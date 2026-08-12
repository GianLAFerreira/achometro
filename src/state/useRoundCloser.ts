import { useEffect, useRef } from 'react'
import { useCountdown } from '../lib/clock'
import { closeRound } from '../lib/rpc'

interface RoundForCloser {
  id: string
  status: string
  ends_at: string
  answers_count: number
}

interface UseRoundCloserArgs {
  round: RoundForCloser | null
  // Contagem de jogadores ATIVOS (missed_streak < 2), não do total da
  // sala — senão uma rodada nunca fecha cedo enquanto houver gente com a
  // aba fechada, que é o cenário que a inatividade existe para resolver.
  activePlayersCount: number
  isHost: boolean
  onClosed: () => void
}

/**
 * Dispara close_round no momento certo. O host fecha assim que todo
 * mundo ativo respondeu OU quando o tempo acaba; qualquer outro membro só
 * fecha depois do tempo, e com um pequeno atraso aleatório — rede de
 * segurança se o host sumir (aba fechada, sem rede), sem todo mundo na
 * sala chamar close_round no mesmo instante. O servidor é idempotente de
 * qualquer jeito (ver migration), isto só evita chamada desperdiçada.
 */
export function useRoundCloser({ round, activePlayersCount, isHost, onClosed }: UseRoundCloserArgs) {
  // Sentinela no futuro distante, não no passado: enquanto `round` é
  // null, `timeIsUp` deve ser `false` (o guard `!round` abaixo já
  // bloqueia qualquer disparo, mas um fallback "sempre esgotado" é uma
  // armadilha para o próximo bug do mesmo tipo — errar para o lado
  // seguro é não fechar rodada nenhuma, nunca fechar cedo demais).
  const remainingSeconds = useCountdown(round?.ends_at ?? FAR_FUTURE_ISO)
  const firedForRoundId = useRef<string | null>(null)

  const allAnswered =
    round != null && activePlayersCount > 0 && round.answers_count >= activePlayersCount
  const timeIsUp = remainingSeconds <= 0

  useEffect(() => {
    if (!round || round.status !== 'open') return
    if (firedForRoundId.current === round.id) return

    const fire = () => {
      firedForRoundId.current = round.id
      closeRound(round.id)
        .then(onClosed)
        .catch(() => {
          // deixa tentar de novo no próximo tick em vez de travar pra sempre
          if (firedForRoundId.current === round.id) firedForRoundId.current = null
        })
    }

    if (isHost && (allAnswered || timeIsUp)) {
      fire()
      return
    }

    if (!isHost && timeIsUp) {
      const jitterMs = 800 + Math.random() * 1500
      const timeoutId = window.setTimeout(fire, jitterMs)
      return () => window.clearTimeout(timeoutId)
    }
  }, [round, allAnswered, timeIsUp, isHost, onClosed])
}

const FAR_FUTURE_ISO = new Date(8640000000000000).toISOString()
