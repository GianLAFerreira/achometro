import { useEffect, useRef } from 'react'
import { useCountdown } from '../lib/clock'
import { startRound } from '../lib/rpc'

interface RoundForAdvancer {
  id: string
  status: string
  closed_at: string | null
}

interface UseRoundAdvancerArgs {
  round: RoundForAdvancer | null
  roomId: string
  roomStatus: string
  pauseSeconds: number
  isHost: boolean
  onAdvanced: () => void
}

/**
 * Dispara start_round sozinho depois da pausa de revelação — espelha
 * useRoundCloser de propósito: host dispara direto, qualquer outro membro
 * dispara com atraso aleatório como rede de segurança se o host sumir, e
 * o servidor (não este hook) é quem valida se a pausa já passou
 * (`pause_in_progress` se não). Cliente é gatilho, nunca autoridade —
 * regra 1 do CLAUDE.md.
 *
 * Só atua com a sala já em 'playing' — sair do lobby continua sendo ato
 * deliberado do host, feito por HomeScreen/Lobby, não por aqui.
 */
export function useRoundAdvancer({
  round,
  roomId,
  roomStatus,
  pauseSeconds,
  isHost,
  onAdvanced,
}: UseRoundAdvancerArgs) {
  const pauseEndsAt = round?.closed_at
    ? new Date(new Date(round.closed_at).getTime() + pauseSeconds * 1000).toISOString()
    : FAR_FUTURE_ISO
  const remainingSeconds = useCountdown(pauseEndsAt)
  const firedForRoundId = useRef<string | null>(null)

  const pauseIsOver = remainingSeconds <= 0

  useEffect(() => {
    if (roomStatus !== 'playing') return
    if (!round || round.status !== 'closed') return
    if (!pauseIsOver) return
    if (firedForRoundId.current === round.id) return

    const fire = () => {
      firedForRoundId.current = round.id
      startRound(roomId)
        .then(onAdvanced)
        .catch(() => {
          // deixa tentar de novo no próximo tick em vez de travar pra sempre
          if (firedForRoundId.current === round.id) firedForRoundId.current = null
        })
    }

    if (isHost) {
      fire()
      return
    }

    const jitterMs = 800 + Math.random() * 1500
    const timeoutId = window.setTimeout(fire, jitterMs)
    return () => window.clearTimeout(timeoutId)
  }, [round, roomStatus, pauseIsOver, isHost, roomId, onAdvanced])

  return { remainingSeconds: Math.max(0, remainingSeconds) }
}

const FAR_FUTURE_ISO = new Date(8640000000000000).toISOString()
