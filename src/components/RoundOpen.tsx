import { useEffect, useRef, useState } from 'react'
import type { FormEvent } from 'react'
import { AnimatePresence, motion } from 'motion/react'
import { NumberField } from './NumberField'
import { Button } from './Button'
import { Countdown } from './Countdown'
import { Note } from './Note'
import { formatInteger, parseGuess } from '../lib/format'
import { submitAnswer } from '../lib/rpc'
import { describeError } from '../lib/errors'
import { useCountdown } from '../lib/clock'
import { tapFeedback } from '../lib/haptics'
import { DURATION_FAST, useReducedMotion } from '../lib/motion'

interface RoundOpenProps {
  roundId: string
  prompt: string
  unit: string | null
  endsAt: string
  answerSeconds: number
  answersCount: number
  // Jogadores ATIVOS (missed_streak < 2), não o total da sala — quem
  // ficou inativo não entra no "N de M cravaram".
  playersCount: number
}

export function RoundOpen({
  roundId,
  prompt,
  unit,
  endsAt,
  answerSeconds,
  answersCount,
  playersCount,
}: RoundOpenProps) {
  const remainingSeconds = useCountdown(endsAt)
  const [rawValue, setRawValue] = useState('')
  const [hasAnswered, setHasAnswered] = useState(false)
  const [submitting, setSubmitting] = useState(false)
  const [feedback, setFeedback] = useState<string | null>(null)
  const reduceMotion = useReducedMotion()
  const prevAnswersCountRef = useRef(answersCount)
  const [countBumped, setCountBumped] = useState(false)

  // Rodada nova (roundId mudou) — reseta o formulário. `answers` não é
  // legível pelo cliente com a rodada aberta (regra 4), então "já
  // respondi" só existe como estado local nesta aba; se a página recarregar
  // no meio da rodada, um segundo envio simplesmente devolve "Palpite já
  // cravado." em vez de duplicar — ver o catch abaixo.
  useEffect(() => {
    setRawValue('')
    setHasAnswered(false)
    setSubmitting(false)
    setFeedback(null)
  }, [roundId])

  // Pulso breve no contador quando ele sobe via Realtime — feedback de
  // "chegou gente respondendo", não é decorativo: só dispara na transição
  // de valor, nunca em loop.
  useEffect(() => {
    if (answersCount > prevAnswersCountRef.current) {
      setCountBumped(true)
      const timeoutId = window.setTimeout(() => setCountBumped(false), DURATION_FAST * 1000 * 2)
      prevAnswersCountRef.current = answersCount
      return () => window.clearTimeout(timeoutId)
    }
    prevAnswersCountRef.current = answersCount
  }, [answersCount])

  const handleSubmit = async (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault()
    const value = parseGuess(rawValue)
    if (value === null) {
      setFeedback('Digite um número.')
      return
    }
    setSubmitting(true)
    setFeedback(null)
    try {
      await submitAnswer(roundId, value)
      tapFeedback()
      setHasAnswered(true)
    } catch (error) {
      const message = describeError(error)
      setFeedback(message)
      if (message === 'Palpite já cravado.') setHasAnswered(true)
    } finally {
      setSubmitting(false)
    }
  }

  const timeIsUp = remainingSeconds <= 0
  const answeredPhase = hasAnswered ? 'answered' : timeIsUp ? 'time-up' : 'form'

  return (
    <section className="flex flex-col gap-6">
      <Countdown seconds={remainingSeconds} totalSeconds={answerSeconds} />
      <p className="font-body text-lg text-mostrador">{prompt}</p>

      <AnimatePresence mode="wait" initial={false}>
        <motion.div
          key={answeredPhase}
          initial={reduceMotion ? false : { opacity: 0 }}
          animate={{ opacity: 1 }}
          exit={reduceMotion ? undefined : { opacity: 0 }}
          transition={{ duration: DURATION_FAST }}
        >
          {answeredPhase !== 'form' ? (
            <Note>{hasAnswered ? 'Palpite cravado. Aguardando os outros.' : 'Tempo esgotado.'}</Note>
          ) : (
            <form className="flex flex-col gap-4" onSubmit={handleSubmit}>
              <NumberField
                id="palpite"
                label={unit ? `Seu palpite (${unit})` : 'Seu palpite'}
                value={rawValue}
                onChange={(event) => setRawValue(event.target.value)}
                disabled={submitting}
                autoFocus
              />
              <Button type="submit" disabled={submitting}>
                Cravar palpite
              </Button>
            </form>
          )}
        </motion.div>
      </AnimatePresence>

      {feedback && <Note tone="erro">{feedback}</Note>}

      <motion.p
        className="font-num text-sm text-mostrador/60"
        animate={countBumped && !reduceMotion ? { scale: [1, 1.15, 1] } : { scale: 1 }}
        transition={{ duration: DURATION_FAST * 2 }}
      >
        {formatInteger(answersCount)} de {formatInteger(playersCount)} cravaram
      </motion.p>
    </section>
  )
}
