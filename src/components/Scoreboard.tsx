import { useEffect, useRef, useState } from 'react'
import { motion } from 'motion/react'
import { formatInteger } from '../lib/format'
import { DURATION_FAST, SPRING_NEEDLE, useReducedMotion } from '../lib/motion'

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
  // Placar da PARTIDA ENCERRADA (última rodada ou sobrevivente único) —
  // único outro momento com tratamento de instrumento além do mostrador:
  // cascata por posição, vencedor com destaque maior. Ainda só
  // timing/tamanho/cor já-existente, nenhuma textura nova.
  isFinal?: boolean
}

// Marca de inatividade e de vencedor sempre em texto, nunca só em cor —
// mesma razão documentada em Note.tsx: cor sozinha (mesmo a dourada de
// --latao) não é canal suficiente pra quem depende de contraste ou não
// souber de antemão qual apelido é o próprio. `layout` no motion.li
// resolve a reordenação (FLIP) quando o score muda o sort, sem precisar
// calcular posição à mão.
export function Scoreboard({ players, highlightPlayerId, winnerPlayerId, isFinal }: ScoreboardProps) {
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
    // key muda quando a partida termina — força remontagem de toda a
    // lista, pra `initial` do motion.li disparar a cascata de verdade
    // (sem isso, os <li> já estariam montados de rodadas anteriores e
    // `initial` nunca "replaya").
    <motion.ol key={isFinal ? 'final' : 'live'} className="flex flex-col gap-2">
      {ranked.map((player, index) => {
        const isYou = player.id === highlightPlayerId
        const isInactive = player.missed_streak >= 2
        const isWinner = player.id === winnerPlayerId
        const justScored = bumped.has(player.id)
        return (
          <motion.li
            key={player.id}
            layout={!reduceMotion}
            initial={
              isFinal && !reduceMotion ? { opacity: 0, y: 10 } : false
            }
            animate={{ opacity: 1, y: 0 }}
            transition={
              isFinal && !reduceMotion
                ? { ...SPRING_NEEDLE, delay: index * 0.08 }
                : { duration: DURATION_FAST }
            }
            className="flex items-center justify-between gap-4 border-b border-mostrador/10 py-2 font-body text-sm"
          >
            <span
              className={`${isYou ? 'text-latao' : 'text-mostrador'} ${
                isFinal && isWinner ? 'font-display text-xl uppercase tracking-tight' : ''
              }`}
            >
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
