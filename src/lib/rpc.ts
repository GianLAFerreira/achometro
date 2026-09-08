import { supabase } from './supabase'
import type { Database } from '../types/database'

// Wrappers tipados das 5 RPCs de jogo + server_now. Cada função Postgres já
// valida tudo que importa (regra 1 do CLAUDE.md) — isto é só a borda que
// converte erro do PostgREST em exceção JS, para lib/errors.ts traduzir.

type RoomRow = Database['public']['Tables']['rooms']['Row']
type RoundRow = Database['public']['Tables']['rounds']['Row']
type AnswerRow = Database['public']['Tables']['answers']['Row']

export interface CreateRoomOptions {
  themes?: string[]
  answerSeconds?: number
  pauseSeconds?: number
  targetScore?: number
}

export async function createRoom(
  nickname: string,
  options: CreateRoomOptions = {},
): Promise<RoomRow> {
  const { data, error } = await supabase.rpc('create_room', {
    p_nickname: nickname,
    p_themes: options.themes ?? [],
    p_answer_seconds: options.answerSeconds ?? 20,
    p_pause_seconds: options.pauseSeconds ?? 10,
    p_target_score: options.targetScore ?? 5,
  })
  if (error) throw error
  return data
}

// Nunca recebe nickname do chamador — o servidor reusa o apelido que a
// pessoa já tinha na sala antiga (players.nickname), igual documentado em
// create_rematch. Idempotente: se outro jogador já clicou "jogar de
// novo" primeiro, devolve a MESMA sala nova em vez de criar outra — é
// isso que garante todo mundo cair junto, não uma sala por clique.
export async function createRematch(oldRoomId: string): Promise<RoomRow> {
  const { data, error } = await supabase.rpc('create_rematch', { p_old_room_id: oldRoomId })
  if (error) throw error
  return data
}

export async function joinRoom(roomCode: string, nickname: string): Promise<RoomRow> {
  const { data, error } = await supabase.rpc('join_room', {
    p_room_code: roomCode,
    p_nickname: nickname,
  })
  if (error) throw error
  return data
}

// Veredito sem efeito colateral, pra validar um código de sala antes de
// pedir apelido — diferente de join_room, que já te coloca dentro da sala.
export type RoomPeek = 'ok' | 'not_found' | 'finished' | 'abandoned' | 'empty'

export async function peekRoom(roomCode: string): Promise<RoomPeek> {
  const { data, error } = await supabase.rpc('peek_room', { p_room_code: roomCode })
  if (error) throw error
  return data as RoomPeek
}

export async function startRound(roomId: string): Promise<RoundRow> {
  const { data, error } = await supabase.rpc('start_round', { p_room_id: roomId })
  if (error) throw error
  return data
}

export async function submitAnswer(roundId: string, value: number): Promise<AnswerRow> {
  const { data, error } = await supabase.rpc('submit_answer', {
    p_round_id: roundId,
    p_value: value,
  })
  if (error) throw error
  return data
}

export async function closeRound(roundId: string): Promise<RoundRow> {
  const { data, error } = await supabase.rpc('close_round', { p_round_id: roundId })
  if (error) throw error
  return data
}

export async function serverNow(): Promise<Date> {
  const { data, error } = await supabase.rpc('server_now')
  if (error) throw error
  return new Date(data)
}
