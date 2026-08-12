import { formatInteger } from '../lib/format'

interface ScoreboardPlayer {
  id: string
  nickname: string
  score: number
}

interface ScoreboardProps {
  players: ScoreboardPlayer[]
  highlightPlayerId?: string | null
}

export function Scoreboard({ players, highlightPlayerId }: ScoreboardProps) {
  const ranked = [...players].sort((a, b) => b.score - a.score)
  return (
    <ol className="flex flex-col gap-2">
      {ranked.map((player, index) => (
        <li
          key={player.id}
          className={`flex items-center justify-between gap-4 border-b border-mostrador/10 py-2 font-body text-sm ${
            player.id === highlightPlayerId ? 'text-latao' : 'text-mostrador'
          }`}
        >
          <span>
            {index + 1}. {player.nickname}
          </span>
          <span className="font-num text-base">{formatInteger(player.score)}</span>
        </li>
      ))}
    </ol>
  )
}
