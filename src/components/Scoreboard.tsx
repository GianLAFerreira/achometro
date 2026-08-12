import { formatInteger } from '../lib/format'

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
// souber de antemão qual apelido é o próprio.
export function Scoreboard({ players, highlightPlayerId, winnerPlayerId }: ScoreboardProps) {
  const ranked = [...players].sort((a, b) => b.score - a.score)
  return (
    <ol className="flex flex-col gap-2">
      {ranked.map((player, index) => {
        const isYou = player.id === highlightPlayerId
        const isInactive = player.missed_streak >= 2
        const isWinner = player.id === winnerPlayerId
        return (
          <li
            key={player.id}
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
            <span className="font-num text-base">{formatInteger(player.score)}</span>
          </li>
        )
      })}
    </ol>
  )
}
