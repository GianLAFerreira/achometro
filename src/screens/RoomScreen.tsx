import { useCallback, useMemo, useState } from 'react'
import type { FormEvent } from 'react'
import { useRoom } from '../state/useRoom'
import { useNickname } from '../state/useNickname'
import { useRoundCloser } from '../state/useRoundCloser'
import { Lobby } from '../components/Lobby'
import { RoundOpen } from '../components/RoundOpen'
import { RoundReveal } from '../components/RoundReveal'
import { Scoreboard } from '../components/Scoreboard'
import { Button } from '../components/Button'
import { TextField } from '../components/TextField'
import { Note } from '../components/Note'
import { startRound } from '../lib/rpc'
import { describeError } from '../lib/errors'

interface RoomScreenProps {
  code: string
  playerId: string
}

// Deriva a fase inteiramente do estado do servidor (room.status +
// currentRound.status) — nada de useState('lobby'|'playing'|'reveal').
// Uma máquina de estados local é a forma mais confiável de dessincronizar
// dois clientes que estão vendo a mesma sala.
export function RoomScreen({ code, playerId }: RoomScreenProps) {
  const { state, resync, join } = useRoom(code, playerId)
  const { nickname, setNickname } = useNickname()
  const [joining, setJoining] = useState(false)
  const [starting, setStarting] = useState(false)
  const [feedback, setFeedback] = useState<string | null>(null)

  const currentRound = state.kind === 'ready' ? state.currentRound : null
  useRoundCloser({
    round: currentRound,
    playersCount: state.kind === 'ready' ? state.players.length : 0,
    isHost: state.kind === 'ready' && state.isHost,
    onClosed: resync,
  })

  const nicknameById = useMemo(() => {
    const map = new Map<string, string>()
    if (state.kind === 'ready') {
      for (const player of state.players) map.set(player.id, player.nickname)
    }
    return map
  }, [state])

  const handleJoin = useCallback(
    async (event: FormEvent<HTMLFormElement>) => {
      event.preventDefault()
      if (!nickname) {
        setFeedback('Escolha um apelido.')
        return
      }
      setJoining(true)
      setFeedback(null)
      try {
        await join(nickname)
      } catch (error) {
        setFeedback(describeError(error))
      } finally {
        setJoining(false)
      }
    },
    [nickname, join],
  )

  const handleStart = useCallback(async () => {
    if (state.kind !== 'ready') return
    setStarting(true)
    setFeedback(null)
    try {
      await startRound(state.room.id)
      resync()
    } catch (error) {
      setFeedback(describeError(error))
    } finally {
      setStarting(false)
    }
  }, [state, resync])

  if (state.kind === 'resolving') {
    return <Note>Aferindo.</Note>
  }

  if (state.kind === 'error') {
    return <Note tone="erro">{state.message}</Note>
  }

  if (state.kind === 'needs-join') {
    return (
      <form className="flex flex-col gap-4" onSubmit={handleJoin}>
        <TextField
          id="apelido"
          label="Seu apelido"
          value={nickname}
          onChange={(event) => setNickname(event.target.value)}
          maxLength={16}
          disabled={joining}
          autoFocus
        />
        <Button type="submit" disabled={joining}>
          Entrar na sala
        </Button>
        {feedback && <Note tone="erro">{feedback}</Note>}
      </form>
    )
  }

  const { room, players } = state

  return (
    <div className="flex flex-col gap-10">
      {room.status === 'lobby' && (
        <Lobby
          code={room.code}
          players={players}
          isHost={state.isHost}
          onStart={handleStart}
          starting={starting}
        />
      )}

      {room.status !== 'lobby' && currentRound && currentRound.status === 'open' && (
        <RoundOpen
          roundId={currentRound.id}
          prompt={currentRound.question_prompt}
          unit={currentRound.question_unit}
          endsAt={currentRound.ends_at}
          answersCount={currentRound.answers_count}
          playersCount={players.length}
        />
      )}

      {room.status !== 'lobby' && currentRound && currentRound.status === 'closed' && (
        <>
          <RoundReveal
            revealedAnswer={currentRound.revealed_answer ?? 0}
            sourceName={currentRound.revealed_source_name ?? ''}
            sourceUrl={currentRound.revealed_source_url ?? ''}
            asOfYear={currentRound.revealed_as_of_year ?? 0}
            unit={currentRound.question_unit}
            answers={state.answers.map((answer) => ({
              playerId: answer.player_id,
              nickname: nicknameById.get(answer.player_id) ?? '???',
              value: answer.value,
              submittedAt: answer.submitted_at,
            }))}
          />
          {state.isHost && room.status !== 'finished' && (
            <Button onClick={handleStart} disabled={starting}>
              Próxima rodada
            </Button>
          )}
          {room.status === 'finished' && <Note>Partida encerrada.</Note>}
        </>
      )}

      {feedback && <Note tone="erro">{feedback}</Note>}

      <Scoreboard players={players} highlightPlayerId={playerId} />
    </div>
  )
}
