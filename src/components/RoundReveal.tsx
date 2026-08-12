import { formatInteger } from '../lib/format'
import { Note } from './Note'

interface RevealAnswer {
  playerId: string
  nickname: string
  value: number
  submittedAt: string
}

interface RoundRevealProps {
  revealedAnswer: number
  sourceName: string
  sourceUrl: string
  asOfYear: number
  unit: string | null
  answers: RevealAnswer[]
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
  revealedAnswer,
  sourceName,
  sourceUrl,
  asOfYear,
  unit,
  answers,
  pauseSecondsRemaining,
}: RoundRevealProps) {
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

      {ranked.length === 0 ? (
        <Note>Ninguém cravou palpite.</Note>
      ) : (
        <ol className="flex flex-col gap-2">
          {ranked.map((answer) => (
            <li
              key={answer.playerId}
              className="flex items-center justify-between gap-4 font-body text-sm text-mostrador"
            >
              <span>{answer.nickname}</span>
              <span className="font-num">{formatInteger(answer.value)}</span>
              <span className={answer.cravou ? 'text-latao' : 'text-mostrador/60'}>
                {answer.cravou ? 'Cravou' : `erro ${Math.round(answer.erro * 100)}%`}
              </span>
            </li>
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
