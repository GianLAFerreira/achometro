import { useEffect } from 'react'
import { motion } from 'motion/react'
import { formatInteger } from '../lib/format'
import { Note } from './Note'
import { Mostrador } from './Mostrador'
import { tapFeedback } from '../lib/haptics'
import { DURATION_FAST, useReducedMotion } from '../lib/motion'

interface RevealAnswer {
  playerId: string
  nickname: string
  value: number
  submittedAt: string
}

interface RoundRevealProps {
  roundId: string
  revealedAnswer: number
  sourceName: string
  sourceUrl: string
  asOfYear: number
  unit: string | null
  answers: RevealAnswer[]
  highlightPlayerId?: string | null
  // null = pausa não se aplica (partida encerrada/abandonada); do
  // contrário, segundos até o avanço automático da próxima rodada.
  pauseSecondsRemaining: number | null
}

// Container fino de propósito — o mostrador logarítmico da Fase 4 (skill
// achometro-design) entra aqui sem reescrever o resto da tela. Erro
// relativo é recalculado aqui só para EXIBIÇÃO (a pontuação real já foi
// decidida e aplicada pelo Postgres em close_round); não é a mesma coisa
// que a regra de jogo morar no cliente. "Cravou" exige valor EXATO — igual
// à regra de pontuação (1 mais perto / 2 cravou), não mais o limiar de 5%.
export function RoundReveal({
  roundId,
  revealedAnswer,
  sourceName,
  sourceUrl,
  asOfYear,
  unit,
  answers,
  highlightPlayerId,
  pauseSecondsRemaining,
}: RoundRevealProps) {
  const reduceMotion = useReducedMotion()
  const ranked = [...answers]
    .map((answer) => ({
      ...answer,
      cravou: answer.value === revealedAnswer,
      erro:
        revealedAnswer === 0
          ? Math.abs(answer.value)
          : Math.abs(answer.value - revealedAnswer) / Math.abs(revealedAnswer),
    }))
    .sort((a, b) => a.erro - b.erro || new Date(a.submittedAt).getTime() - new Date(b.submittedAt).getTime())

  // A revelação abrir é um dos 2 momentos com vibração no mobile — o
  // outro é cravar palpite (RoundOpen.tsx). Dispara uma vez por rodada.
  useEffect(() => {
    tapFeedback()
  }, [roundId])

  return (
    <section className="flex flex-col gap-6">
      <div className="flex flex-col gap-1">
        <p className="font-body text-sm text-mostrador/60">Resposta</p>
        <p className="font-num text-4xl text-latao">
          {formatInteger(revealedAnswer)}
          {unit ? ` ${unit}` : ''}
        </p>
        <a
          className="font-body text-xs text-mostrador/60 underline"
          href={sourceUrl}
          target="_blank"
          rel="noreferrer"
        >
          {sourceName}, {asOfYear}
        </a>
      </div>

      {ranked.length > 0 && (
        <Mostrador
          revealedAnswer={revealedAnswer}
          answers={ranked}
          highlightPlayerId={highlightPlayerId}
        />
      )}

      {ranked.length === 0 ? (
        <Note>Ninguém cravou palpite.</Note>
      ) : (
        <ol className="flex flex-col gap-2">
          {ranked.map((answer, index) => (
            <motion.li
              key={answer.playerId}
              initial={reduceMotion ? false : { opacity: 0, y: 6 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: DURATION_FAST, delay: reduceMotion ? 0 : index * 0.04 }}
              className="flex items-center justify-between gap-4 font-body text-sm text-mostrador"
            >
              <span>{answer.nickname}</span>
              <span className="font-num">{formatInteger(answer.value)}</span>
              <span className={answer.cravou ? 'text-latao' : 'text-mostrador/60'}>
                {answer.cravou ? 'Cravou' : `erro ${Math.round(answer.erro * 100)}%`}
              </span>
            </motion.li>
          ))}
        </ol>
      )}

      {pauseSecondsRemaining !== null && (
        <p className="font-num text-sm text-mostrador/60">
          Próxima rodada em {formatInteger(pauseSecondsRemaining)}
        </p>
      )}
    </section>
  )
}
