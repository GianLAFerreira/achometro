import { AnimatePresence, motion } from 'motion/react'
import { Button } from './Button'
import { Note } from './Note'
import { useCountdown } from '../lib/clock'
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
  createdAt: string
}

// Espelha o `interval '45 seconds'` do branch 'lobby' de start_round
// (migration lobby_sem_host_apos_desistencia) — só decide QUANDO MOSTRAR
// o botão de fallback; quem autoriza de fato é o servidor.
const HOST_GRACE_SECONDS = 45

export function Lobby({
  code,
  players,
  isHost,
  onStart,
  starting,
  targetScore,
  createdAt,
}: LobbyProps) {
  const reduceMotion = useReducedMotion()
  const graceEndsAt = new Date(
    new Date(createdAt).getTime() + HOST_GRACE_SECONDS * 1000,
  ).toISOString()
  const graceRemaining = useCountdown(graceEndsAt)

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
        Primeiro a {targetScore} pontos
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
      ) : graceRemaining > 0 ? (
        <Note>Aguardando o anfitrião. Você pode assumir em {graceRemaining}s.</Note>
      ) : (
        <Button
          variant="secundario"
          onClick={onStart}
          disabled={starting || players.length < 2}
        >
          Assumir e iniciar
        </Button>
      )}
    </section>
  )
}
