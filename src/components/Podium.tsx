import { motion } from 'motion/react'
import { formatInteger } from '../lib/format'
import { SPRING_NEEDLE, useReducedMotion } from '../lib/motion'

interface PodiumPlayer {
  id: string
  nickname: string
  score: number
}

interface PodiumProps {
  players: PodiumPlayer[]
  highlightPlayerId?: string | null
}

// Momento de fim de partida — substitui a cascata que Scoreboard.tsx
// fazia antes (ver isFinal removido de lá): um só lugar celebra, não
// dois. Continua dentro dos três usos deliberados de SPRING_NEEDLE (ver
// lib/motion.ts) — é troca, não crescimento.
//
// Calculado por PONTUAÇÃO, não por `winner_player_id`: esse campo só é
// setado pelo servidor em 2 das 3 vias de fim de jogo (sobrevivente
// único, pontuação-alvo) — quando a partida termina por esgotar as
// rodadas, ninguém é "vencedor" oficial, mas o 1º lugar por pontuação já
// é bem definido de qualquer forma. `<Note>` de "Vencedor: X" (RoomScreen)
// continua só aparecendo quando o servidor de fato declarou — o pódio é
// um elemento visual adicional, não uma reinterpretação daquele texto.
const PLATFORM_HEIGHT: Record<number, string> = {
  1: 'h-32',
  2: 'h-24',
  3: 'h-16',
}

// Ordem de revelação é a suspense de premiação: 3º sobe primeiro, 1º por
// último, com a maior pausa — não uma fórmula linear por índice.
const REVEAL_DELAY: Record<number, number> = {
  3: 0,
  2: 0.2,
  1: 0.4,
}

// Ordem visual: com 3 no pódio, o clássico 2º-1º-3º (1º ao centro). Com
// 2, só 1º-2º lado a lado — sem vaga vazia pro 3º que não existe.
function visualOrder(count: number): number[] {
  return count >= 3 ? [2, 1, 3] : [1, 2]
}

export function Podium({ players, highlightPlayerId }: PodiumProps) {
  const reduceMotion = useReducedMotion()
  const ranked = [...players].sort((a, b) => b.score - a.score)
  const top = ranked.slice(0, Math.min(3, ranked.length))

  if (top.length < 2) return null

  const order = visualOrder(top.length)

  return (
    <div className="flex items-end justify-center gap-4" aria-hidden="true">
      {order.map((rank) => {
        const player = top[rank - 1]
        if (!player) return null
        const isYou = player.id === highlightPlayerId
        return (
          <div key={player.id} className="flex w-20 flex-col items-center gap-2">
            {/* w-full truncate: apelido vai até 16 caracteres (teto real
                do banco) e pode ser uma palavra só, sem ponto de quebra —
                sem largura casada com a plataforma (w-20 no pai), um nome
                longo estoura a linha a 360px. Achado de revisão. */}
            <p
              className={`w-full truncate text-center font-body text-sm ${
                isYou ? 'text-latao' : 'text-mostrador'
              }`}
            >
              {player.nickname}
              {isYou ? ' (você)' : ''}
            </p>
            <motion.div
              className={`flex w-20 items-start justify-center pt-2 origin-bottom ${PLATFORM_HEIGHT[rank]} ${
                rank === 1 ? 'bg-latao text-tinta' : 'bg-esmalte-2 text-mostrador'
              }`}
              initial={reduceMotion ? false : { scaleY: 0 }}
              animate={{ scaleY: 1 }}
              transition={reduceMotion ? { duration: 0 } : { ...SPRING_NEEDLE, delay: REVEAL_DELAY[rank] }}
            >
              <span className="font-num text-3xl">{rank}</span>
            </motion.div>
            <p className="font-num text-sm text-mostrador/60">{formatInteger(player.score)}</p>
          </div>
        )
      })}
    </div>
  )
}
