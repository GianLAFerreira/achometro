import { AnimatePresence, motion } from 'motion/react'
import { Button } from './Button'
import { Note } from './Note'
import { DURATION_FAST, useReducedMotion } from '../lib/motion'

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
  const reduceMotion = useReducedMotion()

  return (
    <section className="flex flex-col gap-6">
      <div>
        <p className="font-body text-sm text-mostrador/60">Código da sala</p>
        <p className="font-num text-3xl text-latao">{code}</p>
      </div>

      <ul className="flex flex-col gap-1">
        <AnimatePresence initial={false}>
          {players.map((player) => (
            <motion.li
              key={player.id}
              layout={!reduceMotion}
              initial={reduceMotion ? false : { opacity: 0, x: -8 }}
              animate={{ opacity: 1, x: 0 }}
              exit={reduceMotion ? undefined : { opacity: 0 }}
              transition={{ duration: DURATION_FAST }}
              className="font-body text-sm text-mostrador"
            >
              {player.nickname}
            </motion.li>
          ))}
        </AnimatePresence>
      </ul>

      {players.length <= 1 && <Note>Ninguém aqui ainda. Passe o código {code}.</Note>}

      {isHost ? (
        <Button onClick={onStart} disabled={starting || players.length < 2}>
          Iniciar rodada
        </Button>
      ) : (
        <Note>Aguardando o anfitrião.</Note>
      )}
    </section>
  )
}
