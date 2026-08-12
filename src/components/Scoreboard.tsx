import { useEffect, useRef, useState } from 'react'
import { motion } from 'motion/react'
import { formatInteger } from '../lib/format'
import { DURATION_FAST, useReducedMotion } from '../lib/motion'

interface ScoreboardPlayer {
  id: string
  nickname: string
  score: number
  missed_streak: number
}

interface ScoreboardProps {
  players: ScoreboardPlayer[]
  highlightPlayerId?: string | null
  winnerPlayerId?: string | null
}

// Marca de inatividade e de vencedor sempre em texto, nunca só em cor —
// mesma razão documentada em Note.tsx: cor sozinha (mesmo a dourada de
// --latao) não é canal suficiente pra quem depende de contraste ou não
// souber de antemão qual apelido é o próprio. `layout` no motion.li
// resolve a reordenação (FLIP) quando o score muda o sort, sem precisar
// calcular posição à mão.
//
// Lista plana sempre — o momento de celebração do fim de partida é o
// Podium.tsx (top 3, cima da tela), não este componente. Este continua
// sendo a fonte de detalhe completa: todo mundo, 4º lugar em diante,
// inativos.
export function Scoreboard({ players, highlightPlayerId, winnerPlayerId }: ScoreboardProps) {
  const reduceMotion = useReducedMotion()
  const ranked = [...players].sort((a, b) => b.score - a.score)

  const prevScoresRef = useRef<Map<string, number>>(new Map())
  const [bumped, setBumped] = useState<Set<string>>(new Set())

  useEffect(() => {
    const prev = prevScoresRef.current
    const risen = new Set<string>()
    for (const player of players) {
      const before = prev.get(player.id)
      if (before !== undefined && player.score > before) risen.add(player.id)
    }
    if (risen.size > 0) {
      setBumped(risen)
      const timeoutId = window.setTimeout(() => setBumped(new Set()), DURATION_FAST * 1000 * 3)
      prevScoresRef.current = new Map(players.map((p) => [p.id, p.score]))
      return () => window.clearTimeout(timeoutId)
    }
    prevScoresRef.current = new Map(players.map((p) => [p.id, p.score]))
  }, [players])

  return (
    <motion.ol className="flex flex-col gap-2">
      {ranked.map((player, index) => {
        const isYou = player.id === highlightPlayerId
        const isInactive = player.missed_streak >= 2
        const isWinner = player.id === winnerPlayerId
        const justScored = bumped.has(player.id)
        return (
          <motion.li
            key={player.id}
            layout={!reduceMotion}
            initial={false}
            transition={{ duration: DURATION_FAST }}
            className="flex items-center justify-between gap-4 border-b border-mostrador/10 py-2 font-body text-sm"
          >
            <span className={isYou ? 'text-latao' : 'text-mostrador'}>
              {index + 1}. {player.nickname}
              <span className="text-mostrador/60">
                {isYou ? ' (você)' : ''}
                {isInactive ? ' · inativo' : ''}
              </span>
              {isWinner ? <span className="text-latao"> · vencedor</span> : null}
            </span>
            <motion.span
              className="font-num text-base"
              animate={justScored && !reduceMotion ? { scale: [1, 1.25, 1] } : { scale: 1 }}
              transition={{ duration: DURATION_FAST * 2 }}
            >
              {formatInteger(player.score)}
            </motion.span>
          </motion.li>
        )
      })}
    </motion.ol>
  )
}
