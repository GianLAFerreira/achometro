import { useEffect, useState } from 'react'
import type { FormEvent } from 'react'
import { NumberField } from './NumberField'
import { Button } from './Button'
import { Countdown } from './Countdown'
import { Note } from './Note'
import { formatInteger, parseGuess } from '../lib/format'
import { submitAnswer } from '../lib/rpc'
import { describeError } from '../lib/errors'
import { useCountdown } from '../lib/clock'

interface RoundOpenProps {
  roundId: string
  prompt: string
  unit: string | null
  endsAt: string
  answersCount: number
  playersCount: number
}

export function RoundOpen({
  roundId,
  prompt,
  unit,
  endsAt,
  answersCount,
  playersCount,
}: RoundOpenProps) {
  const remainingSeconds = useCountdown(endsAt)
  const [rawValue, setRawValue] = useState('')
  const [hasAnswered, setHasAnswered] = useState(false)
  const [submitting, setSubmitting] = useState(false)
  const [feedback, setFeedback] = useState<string | null>(null)

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

  return (
    <section className="flex flex-col gap-6">
      <Countdown seconds={remainingSeconds} />
      <p className="font-body text-lg text-mostrador">{prompt}</p>

      {hasAnswered || timeIsUp ? (
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

      {feedback && <Note tone="erro">{feedback}</Note>}

      <p className="font-num text-sm text-mostrador/60">
        {formatInteger(answersCount)} de {formatInteger(playersCount)} cravaram
      </p>
    </section>
  )
}
