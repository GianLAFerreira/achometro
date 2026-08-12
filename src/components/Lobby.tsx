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
  targetScore: number
  roundsTotal: number
}

export function Lobby({
  code,
  players,
  isHost,
  onStart,
  starting,
  targetScore,
  roundsTotal,
}: LobbyProps) {
  const reduceMotion = useReducedMotion()

  return (
    <section className="flex flex-col gap-6">
      <div>
        <p className="font-body text-sm text-mostrador/60">Código da sala</p>
        <p className="font-num text-3xl text-latao">{code}</p>
      </div>

      {/* Configuração escolhida na Home, invisível depois de criada a
          sala até esta linha — mesma fonte de dados que já chega em
          `room`, sem RPC nova. `/60`, não o `/70` do Note neutro: aqui é
          rótulo de campo (mesmo par de "Código da sala" acima), não
          conteúdo informativo avulso — escolha deliberada, não deriva. */}
      <p className="font-body text-sm text-mostrador/60">
        Primeiro a {targetScore} pontos ou {roundsTotal} rodadas
      </p>

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
