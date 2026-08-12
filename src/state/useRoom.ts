import { useCallback, useEffect, useRef, useState } from 'react'
import { supabase } from '../lib/supabase'
import { describeError } from '../lib/errors'
import { joinRoom } from '../lib/rpc'
import type { Database } from '../types/database'

type RoomRow = Database['public']['Tables']['rooms']['Row']
type PlayerRow = Database['public']['Tables']['players']['Row']
type RoundRow = Database['public']['Tables']['rounds']['Row']
type AnswerRow = Database['public']['Tables']['answers']['Row']

export type RoomState =
  | { kind: 'resolving' }
  // Não tem linha em `players` para esta sala ainda — pode ser código
  // errado ou só falta chamar join_room. A ambiguidade se resolve no
  // próprio join_room (ele levanta `room_not_found` se o código for
  // inválido) — não adivinhamos aqui.
  | { kind: 'needs-join' }
  | { kind: 'error'; message: string }
  | {
      kind: 'ready'
      room: RoomRow
      players: PlayerRow[]
      rounds: RoundRow[]
      currentRound: RoundRow | null
      answers: AnswerRow[]
      isHost: boolean
      // Pode ser `null` legitimamente: quem abre um link de sala sem dar
      // join ainda (só quer ver o placar) enxerga a sala sem estar em
      // `players`. É a fonte autoritativa do próprio apelido — nunca
      // useNickname(), que é a preferência do NAVEGADOR, não da sala.
      me: PlayerRow | null
      // Ativo = menos de 2 faltas seguidas (players.missed_streak),
      // decidido no servidor em close_round. Não é coluna separada, pra
      // não ter dois estados podendo dessincronizar.
      activePlayers: PlayerRow[]
    }

const RESYNC_DEBOUNCE_MS = 80

/**
 * Hook mestre de uma sala. Regra de arquitetura: todo evento do Realtime é
 * tratado como INVALIDAÇÃO, nunca como payload aplicado direto no estado.
 * Sem isso, uma queda de socket de alguns segundos deixa o estado
 * permanentemente errado e sem nenhum sinal de erro — Realtime não faz
 * replay do que perdeu.
 */
export function useRoom(roomCode: string, playerId: string | null) {
  const [roomId, setRoomId] = useState<string | null>(null)
  const [state, setState] = useState<RoomState>({ kind: 'resolving' })
  const resyncTimerRef = useRef<number | null>(null)

  const fetchAndSet = useCallback(
    async (id: string) => {
      try {
        const snapshot = await fetchRoomSnapshot(id)
        if (!snapshot) {
          // A própria RLS decidiu que não somos mais membro (saiu, ou a
          // sala nunca existiu com esse id). Volta pro fluxo de entrada.
          setRoomId(null)
          setState({ kind: 'needs-join' })
          return
        }
        setState({
          kind: 'ready',
          room: snapshot.room,
          players: snapshot.players,
          rounds: snapshot.rounds,
          currentRound: snapshot.currentRound,
          answers: snapshot.answers,
          isHost: playerId != null && snapshot.room.host_player_id === playerId,
          me: snapshot.players.find((p) => p.id === playerId) ?? null,
          activePlayers: snapshot.players.filter((p) => p.missed_streak < 2),
        })
      } catch (error) {
        setState({ kind: 'error', message: describeError(error) })
      }
    },
    [playerId],
  )

  // 1) resolve o código da URL para um roomId — sem chamar join_room
  // incondicionalmente: quem já é membro não deve ter o apelido
  // sobrescrito, e quem só quer ver o placar final não deve ser barrado.
  useEffect(() => {
    let cancelled = false
    setState({ kind: 'resolving' })
    setRoomId(null)

    findRoomByCode(roomCode)
      .then((room) => {
        if (cancelled) return
        if (!room) {
          setState({ kind: 'needs-join' })
          return
        }
        setRoomId(room.id)
      })
      .catch((error: unknown) => {
        if (cancelled) return
        setState({ kind: 'error', message: describeError(error) })
      })

    return () => {
      cancelled = true
    }
  }, [roomCode])

  const scheduleResync = useCallback(() => {
    if (!roomId) return
    if (resyncTimerRef.current) window.clearTimeout(resyncTimerRef.current)
    resyncTimerRef.current = window.setTimeout(() => {
      fetchAndSet(roomId)
    }, RESYNC_DEBOUNCE_MS)
  }, [roomId, fetchAndSet])

  // 2) com roomId resolvido: busca inicial + canal Realtime só como sinal
  // de "algo mudou, refaça o fetch". resync também dispara em
  // visibilitychange, 'online' e em toda re-assinatura do canal
  // (SUBSCRIBED cobre a primeira vez E toda reconexão depois de queda).
  useEffect(() => {
    if (!roomId) return

    fetchAndSet(roomId)

    const channel = supabase
      .channel(`room:${roomId}`)
      .on(
        'postgres_changes',
        { event: '*', schema: 'public', table: 'rooms', filter: `id=eq.${roomId}` },
        scheduleResync,
      )
      .on(
        'postgres_changes',
        { event: '*', schema: 'public', table: 'players', filter: `room_id=eq.${roomId}` },
        scheduleResync,
      )
      .on(
        'postgres_changes',
        { event: '*', schema: 'public', table: 'rounds', filter: `room_id=eq.${roomId}` },
        scheduleResync,
      )
      .subscribe((status) => {
        // Resync imediato (sem debounce) em qualquer transição de status:
        // cobre a assinatura inicial, toda reconexão depois de queda de
        // rede, e serve de rede de segurança se o canal cair sem que
        // 'online'/visibilitychange disparem.
        if (status === 'SUBSCRIBED' || status === 'CHANNEL_ERROR' || status === 'TIMED_OUT') {
          fetchAndSet(roomId)
        }
      })

    const onVisible = () => {
      if (document.visibilityState === 'visible') fetchAndSet(roomId)
    }
    const onOnline = () => fetchAndSet(roomId)
    document.addEventListener('visibilitychange', onVisible)
    window.addEventListener('online', onOnline)

    return () => {
      document.removeEventListener('visibilitychange', onVisible)
      window.removeEventListener('online', onOnline)
      supabase.removeChannel(channel)
      if (resyncTimerRef.current) window.clearTimeout(resyncTimerRef.current)
    }
  }, [roomId, fetchAndSet, scheduleResync])

  const resync = useCallback(() => {
    if (roomId) fetchAndSet(roomId)
  }, [roomId, fetchAndSet])

  // create_room fica de fora deste hook de propósito — RPC mutante nunca
  // sai de useEffect (StrictMode chamaria duas vezes e criaria duas
  // salas). join_room é seguro aqui porque é idempotente (on conflict do
  // update) e só é chamado a partir de um handler de submit, nunca de
  // efeito.
  const join = useCallback(
    async (nickname: string) => {
      const room = await joinRoom(roomCode, nickname)
      setRoomId(room.id)
    },
    [roomCode],
  )

  return { state, resync, join }
}

async function findRoomByCode(code: string): Promise<RoomRow | null> {
  const { data, error } = await supabase
    .from('rooms')
    .select('*')
    .eq('code', code.toUpperCase())
    .maybeSingle()
  if (error) throw error
  return data
}

interface RoomSnapshot {
  room: RoomRow
  players: PlayerRow[]
  rounds: RoundRow[]
  currentRound: RoundRow | null
  answers: AnswerRow[]
}

// Três selects paralelos, sem embed do PostgREST: existem DUAS FKs entre
// `rooms` e `players` (players.room_id -> rooms.id, e a FK composta do
// host), e o embed automático fica ambíguo por causa disso.
async function fetchRoomSnapshot(roomId: string): Promise<RoomSnapshot | null> {
  const [roomRes, playersRes, roundsRes] = await Promise.all([
    supabase.from('rooms').select('*').eq('id', roomId).maybeSingle(),
    supabase.from('players').select('*').eq('room_id', roomId).order('joined_at', { ascending: true }),
    supabase.from('rounds').select('*').eq('room_id', roomId).order('index', { ascending: true }),
  ])

  if (roomRes.error) throw roomRes.error
  if (playersRes.error) throw playersRes.error
  if (roundsRes.error) throw roundsRes.error
  if (!roomRes.data) return null

  const rounds = roundsRes.data ?? []
  const currentRound = rounds.length > 0 ? rounds[rounds.length - 1] : null

  // Sempre tenta — a própria RLS devolve vazio (não erro) enquanto a
  // rodada está aberta. Deixar a política decidir em vez de replicar a
  // condição aqui é a mesma defesa em profundidade da regra 4.
  let answers: AnswerRow[] = []
  if (currentRound) {
    const answersRes = await supabase.from('answers').select('*').eq('round_id', currentRound.id)
    if (answersRes.error) throw answersRes.error
    answers = answersRes.data ?? []
  }

  return { room: roomRes.data, players: playersRes.data ?? [], rounds, currentRound, answers }
}
