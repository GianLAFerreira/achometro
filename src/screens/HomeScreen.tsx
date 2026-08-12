import { useCallback, useState } from 'react'
import type { FormEvent } from 'react'
import { TextField } from '../components/TextField'
import { Button } from '../components/Button'
import { Note } from '../components/Note'
import { useNickname } from '../state/useNickname'
import { createRoom } from '../lib/rpc'
import { describeError } from '../lib/errors'
import { navigate, roomPath } from '../lib/router'

export function HomeScreen() {
  const { nickname, setNickname } = useNickname()
  const [roomCode, setRoomCode] = useState('')
  const [creating, setCreating] = useState(false)
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

  // Entrar por código não chama join_room aqui — só navega para
  // /sala/CODE. A tela da sala pede o apelido e chama join_room, o mesmo
  // caminho de quem abre um link compartilhado.
  const handleJoin = useCallback(
    (event: FormEvent<HTMLFormElement>) => {
      event.preventDefault()
      const trimmed = roomCode.trim()
      if (trimmed.length !== 6) {
        setFeedback('Código não confere. Confira as 6 letras.')
        return
      }
      navigate(roomPath(trimmed))
    },
    [roomCode],
  )

  return (
    <div className="flex min-h-screen flex-col items-center justify-center gap-12 px-6 py-16">
      <div className="text-center">
        <h1 className="font-display text-5xl font-extrabold uppercase tracking-tight text-mostrador sm:text-7xl">
          Achômetro
        </h1>
        <p className="mt-2 font-body text-base text-mostrador/80">
          O medidor oficial do seu achismo.
        </p>
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
          />
          <Button type="submit" variant="secundario">
            Entrar na sala
          </Button>
        </form>

        {feedback && <Note tone="erro">{feedback}</Note>}
      </div>
    </div>
  )
}
