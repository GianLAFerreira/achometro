import { useCallback, useState } from 'react'
import type { FormEvent } from 'react'
import { motion } from 'motion/react'
import { TextField } from '../components/TextField'
import { Button } from '../components/Button'
import { Note } from '../components/Note'
import { useNickname } from '../state/useNickname'
import { createRoom, peekRoom } from '../lib/rpc'
import { describeError } from '../lib/errors'
import { navigate, roomPath } from '../lib/router'
import { DURATION_BASE, SPRING_NEEDLE, useReducedMotion } from '../lib/motion'

const PEEK_MESSAGES: Record<string, string> = {
  not_found: 'Código não confere. Confira as 6 letras.',
  finished: 'Essa partida já terminou.',
  abandoned: 'Essa sala foi encerrada por inatividade.',
  empty: 'Essa sala está vazia.',
}

export function HomeScreen() {
  const reduceMotion = useReducedMotion()
  const { nickname, setNickname } = useNickname()
  const [roomCode, setRoomCode] = useState('')
  const [creating, setCreating] = useState(false)
  const [checkingCode, setCheckingCode] = useState(false)
  const [feedback, setFeedback] = useState<string | null>(null)

  // create_room é RPC mutante — só a partir de um handler de submit,
  // nunca de useEffect (StrictMode chamaria duas vezes e criaria duas
  // salas; join_room sobrevive porque é idempotente, create_room não).
  const handleCreate = useCallback(
    async (event: FormEvent<HTMLFormElement>) => {
      event.preventDefault()
      if (!nickname) {
        setFeedback('Escolha um apelido.')
        return
      }
      setCreating(true)
      setFeedback(null)
      try {
        const room = await createRoom(nickname)
        navigate(roomPath(room.code))
      } catch (error) {
        setFeedback(describeError(error))
      } finally {
        setCreating(false)
      }
    },
    [nickname],
  )

  // Entrar por código valida com peek_room antes de navegar — sem isso, o
  // código errado só aparecia depois de digitar o apelido na tela da sala
  // (join_room só estoura o erro lá). peek_room não tem efeito colateral;
  // quem de fato entra é join_room, chamado só pela tela da sala, o mesmo
  // caminho de quem abre um link compartilhado.
  const handleJoin = useCallback(
    async (event: FormEvent<HTMLFormElement>) => {
      event.preventDefault()
      const trimmed = roomCode.trim()
      if (trimmed.length !== 6) {
        setFeedback('Código não confere. Confira as 6 letras.')
        return
      }
      setCheckingCode(true)
      setFeedback(null)
      try {
        const verdict = await peekRoom(trimmed)
        if (verdict === 'ok') {
          navigate(roomPath(trimmed))
        } else {
          setFeedback(PEEK_MESSAGES[verdict] ?? 'Código não confere. Confira as 6 letras.')
        }
      } catch (error) {
        setFeedback(describeError(error))
      } finally {
        setCheckingCode(false)
      }
    },
    [roomCode],
  )

  return (
    <div className="flex min-h-screen flex-col items-center justify-center gap-12 px-6 py-16">
      <div className="text-center">
        {/* Entrada do logo: mesmo spring do ponteiro do mostrador e da
            cascata do placar final (SPRING_NEEDLE) — terceiro e último
            momento com esse tratamento, deliberadamente reservado a
            instantes de identidade, nunca espalhado pela interface. */}
        <motion.h1
          className="font-display text-5xl font-extrabold uppercase tracking-tight text-mostrador sm:text-7xl"
          initial={reduceMotion ? false : { opacity: 0, y: 16, scale: 0.92 }}
          animate={{ opacity: 1, y: 0, scale: 1 }}
          transition={reduceMotion ? { duration: 0 } : SPRING_NEEDLE}
        >
          Achômetro
        </motion.h1>
        <motion.p
          className="mt-2 font-body text-base text-mostrador/80"
          initial={reduceMotion ? false : { opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={reduceMotion ? { duration: 0 } : { duration: DURATION_BASE, delay: 0.2 }}
        >
          O medidor oficial do seu achismo.
        </motion.p>
      </div>

      <div className="flex w-full max-w-sm flex-col gap-10">
        <form className="flex flex-col gap-4" onSubmit={handleCreate}>
          <TextField
            id="apelido-criar"
            label="Seu apelido"
            value={nickname}
            onChange={(event) => setNickname(event.target.value)}
            maxLength={16}
            disabled={creating}
          />
          <Button type="submit" disabled={creating}>
            Abrir sala
          </Button>
        </form>

        <form className="flex flex-col gap-4" onSubmit={handleJoin}>
          <TextField
            id="codigo-sala"
            label="Código da sala"
            value={roomCode}
            onChange={(event) => setRoomCode(event.target.value.toUpperCase())}
            maxLength={6}
            disabled={checkingCode}
          />
          <Button type="submit" variant="secundario" disabled={checkingCode}>
            Entrar na sala
          </Button>
        </form>

        {feedback && <Note tone="erro">{feedback}</Note>}
      </div>
    </div>
  )
}
