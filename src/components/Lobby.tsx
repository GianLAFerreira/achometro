import { Button } from './Button'
import { Note } from './Note'

interface LobbyPlayer {
  id: string
  nickname: string
}

interface LobbyProps {
  code: string
  players: LobbyPlayer[]
  isHost: boolean
  onStart: () => void
  starting: boolean
}

export function Lobby({ code, players, isHost, onStart, starting }: LobbyProps) {
  return (
    <section className="flex flex-col gap-6">
      <div>
        <p className="font-body text-sm text-mostrador/60">Código da sala</p>
        <p className="font-num text-3xl text-latao">{code}</p>
      </div>

      <ul className="flex flex-col gap-1">
        {players.map((player) => (
          <li key={player.id} className="font-body text-sm text-mostrador">
            {player.nickname}
          </li>
        ))}
      </ul>

      {players.length <= 1 && <Note>Ninguém aqui ainda. Passe o código {code}.</Note>}

      {isHost ? (
        <Button onClick={onStart} disabled={starting || players.length === 0}>
          Iniciar rodada
        </Button>
      ) : (
        <Note>Aguardando o anfitrião.</Note>
      )}
    </section>
  )
}
