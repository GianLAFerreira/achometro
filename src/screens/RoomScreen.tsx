import { useCallback, useMemo, useState } from 'react'
import type { FormEvent } from 'react'
import { AnimatePresence, motion } from 'motion/react'
import { useRoom } from '../state/useRoom'
import { useNickname } from '../state/useNickname'
import { useRoundCloser } from '../state/useRoundCloser'
import { useRoundAdvancer } from '../state/useRoundAdvancer'
import { Lobby } from '../components/Lobby'
import { RoundOpen } from '../components/RoundOpen'
import { RoundReveal } from '../components/RoundReveal'
import { Scoreboard } from '../components/Scoreboard'
import { Podium } from '../components/Podium'
import { Button } from '../components/Button'
import { TextField } from '../components/TextField'
import { Note } from '../components/Note'
import { startRound } from '../lib/rpc'
import { describeError } from '../lib/errors'
import { navigate } from '../lib/router'
import { FADE_TRANSITION, useReducedMotion } from '../lib/motion'

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
  const reduceMotion = useReducedMotion()

  const currentRound = state.kind === 'ready' ? state.currentRound : null
  const activePlayersCount = state.kind === 'ready' ? state.activePlayers.length : 0

  useRoundCloser({
    round: currentRound,
    activePlayersCount,
    isHost: state.kind === 'ready' && state.isHost,
    onClosed: resync,
  })

  // Avanço automático entre rodadas — depois da pausa de revelação,
  // qualquer membro dispara start_round sozinho (o servidor valida que a
  // pausa passou; ver migration pontuacao_inatividade_e_pausa). Só atua
  // com a sala em 'playing': sair do lobby continua exclusivo do host,
  // via handleStart abaixo.
  const advancer = useRoundAdvancer({
    round: currentRound,
    roomId: state.kind === 'ready' ? state.room.id : '',
    roomStatus: state.kind === 'ready' ? state.room.status : 'lobby',
    pauseSeconds: state.kind === 'ready' ? state.room.pause_seconds : 10,
    isHost: state.kind === 'ready' && state.isHost,
    onAdvanced: resync,
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

  // Só dispara a primeira rodada (saída do lobby) — o avanço entre
  // rodadas é automático, via useRoundAdvancer acima.
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

  const { room, players, me } = state

  // Chave de fase: muda exatamente quando a tela deveria trocar (lobby →
  // rodada aberta → revelação). Deriva só do estado do servidor, mesmo
  // princípio de RoomScreen inteiro — nunca um useState de fase local.
  const phaseKey =
    room.status === 'lobby' ? 'lobby' : currentRound ? `round-${currentRound.status}` : 'empty'

  return (
    <div className="flex flex-col gap-10">
      {/* Identidade do jogador, sempre visível — fonte é `me.nickname`
          (servidor), nunca useNickname() (preferência do navegador, pode
          divergir do apelido desta sala). `me` é null pra quem só está
          vendo a sala sem ter dado join. */}
      <div className="flex items-baseline justify-between gap-4 font-body text-sm text-mostrador/60">
        <p className="min-w-0 truncate">{me ? `Você é ${me.nickname}` : 'Assistindo'}</p>
        <p className="shrink-0">
          sala <span className="font-num text-latao">{room.code}</span>
        </p>
      </div>

      <AnimatePresence mode="wait">
        <motion.div
          key={phaseKey}
          initial={reduceMotion ? false : { opacity: 0, y: 8 }}
          animate={{ opacity: 1, y: 0 }}
          exit={reduceMotion ? undefined : { opacity: 0, y: -8 }}
          transition={FADE_TRANSITION}
          className="flex flex-col gap-10"
        >
          {room.status === 'lobby' && (
            <Lobby
              code={room.code}
              players={players}
              isHost={state.isHost}
              onStart={handleStart}
              starting={starting}
              targetScore={room.target_score}
            />
          )}

          {room.status !== 'lobby' && currentRound && currentRound.status === 'open' && (
            <RoundOpen
              roundId={currentRound.id}
              prompt={currentRound.question_prompt}
              unit={currentRound.question_unit}
              endsAt={currentRound.ends_at}
              answerSeconds={room.answer_seconds}
              answersCount={currentRound.answers_count}
              playersCount={activePlayersCount}
            />
          )}

          {room.status !== 'lobby' && currentRound && currentRound.status === 'closed' && (
            <>
              <RoundReveal
                roundId={currentRound.id}
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
                highlightPlayerId={playerId}
                pauseSecondsRemaining={room.status === 'playing' ? advancer.remainingSeconds : null}
              />
              {room.status === 'abandoned' && (
                <Note tone="erro">Sala encerrada por inatividade.</Note>
              )}
              {room.status === 'finished' && (
                <Note>
                  Partida encerrada.
                  {room.winner_player_id
                    ? ` Vencedor: ${nicknameById.get(room.winner_player_id) ?? '???'}`
                    : ''}
                </Note>
              )}
            </>
          )}
        </motion.div>
      </AnimatePresence>

      {feedback && <Note tone="erro">{feedback}</Note>}

      {room.status === 'finished' && (
        <>
          <Podium players={players} highlightPlayerId={playerId} />
          <Button variant="secundario" onClick={() => navigate('/')}>
            Voltar ao início
          </Button>
        </>
      )}

      <Scoreboard
        players={players}
        highlightPlayerId={playerId}
        winnerPlayerId={room.winner_player_id}
      />
    </div>
  )
}
