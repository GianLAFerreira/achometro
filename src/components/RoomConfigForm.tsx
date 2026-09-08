import { useState } from 'react'
import type { FormEvent } from 'react'
import { NumberField } from './NumberField'
import { Button } from './Button'
import { Note } from './Note'
import { TopicSelect } from './TopicSelect'
import { createRoom } from '../lib/rpc'
import { parseGuess } from '../lib/format'
import { describeError } from '../lib/errors'
import type { Database } from '../types/database'

type RoomRow = Database['public']['Tables']['rooms']['Row']

interface RoomConfigFormProps {
  nickname: string
  onCreated: (room: RoomRow) => void
  onBack: () => void
}

// Espelha os CHECKs de supabase/migrations/*_configuracao_de_sala.sql e
// *_tempo_20s_e_consulta_de_sala.sql — como os campos são <input
// type="text"> (NumberField deliberadamente não usa type="number", ver
// seu próprio comentário), min/max de HTML não têm efeito nenhum aqui;
// a validação de verdade é em handleSubmit, mesmo padrão de
// RoundOpen.tsx (parseGuess + feedback, não validação nativa).
const TARGET_SCORE_RANGE = { min: 1, max: 100 }
const ANSWER_SECONDS_RANGE = { min: 5, max: 300 }
const PAUSE_SECONDS_RANGE = { min: 3, max: 60 }

function inRange(value: number | null, range: { min: number; max: number }): value is number {
  return value !== null && value >= range.min && value <= range.max
}

// create_room já aceita answer_seconds desde a Fase 1 e ganhou
// pause_seconds/target_score nesta mudança — esta tela é só a primeira vez
// que o cliente de fato os expõe. Sem controle de "número de rodadas": a
// partida agora só termina pela pontuação-alvo (ou inatividade), não por
// contagem de rodadas.
export function RoomConfigForm({ nickname, onCreated, onBack }: RoomConfigFormProps) {
  const [themes, setThemes] = useState<string[]>([])
  const [targetScoreRaw, setTargetScoreRaw] = useState('5')
  const [answerSecondsRaw, setAnswerSecondsRaw] = useState('20')
  const [pauseSecondsRaw, setPauseSecondsRaw] = useState('10')
  const [creating, setCreating] = useState(false)
  const [feedback, setFeedback] = useState<string | null>(null)

  const handleSubmit = async (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault()

    const targetScore = parseGuess(targetScoreRaw)
    const answerSeconds = parseGuess(answerSecondsRaw)
    const pauseSeconds = parseGuess(pauseSecondsRaw)

    if (
      !inRange(targetScore, TARGET_SCORE_RANGE) ||
      !inRange(answerSeconds, ANSWER_SECONDS_RANGE) ||
      !inRange(pauseSeconds, PAUSE_SECONDS_RANGE)
    ) {
      setFeedback('Confira os números da configuração.')
      return
    }

    setCreating(true)
    setFeedback(null)
    try {
      const room = await createRoom(nickname.trim(), {
        themes,
        targetScore,
        answerSeconds,
        pauseSeconds,
      })
      onCreated(room)
    } catch (error) {
      setFeedback(describeError(error))
    } finally {
      setCreating(false)
    }
  }

  return (
    <form className="flex flex-col gap-6" onSubmit={handleSubmit}>
      <TopicSelect themes={themes} onChange={setThemes} disabled={creating} />

      <div className="flex flex-col gap-4">
        <NumberField
          id="pontuacao-alvo"
          label="Pontuação pra vencer"
          value={targetScoreRaw}
          onChange={(event) => setTargetScoreRaw(event.target.value)}
          disabled={creating}
        />
        <NumberField
          id="tempo-resposta"
          label="Tempo de resposta (segundos)"
          value={answerSecondsRaw}
          onChange={(event) => setAnswerSecondsRaw(event.target.value)}
          disabled={creating}
        />
        <NumberField
          id="tempo-pausa"
          label="Tempo de pausa entre rodadas (segundos)"
          value={pauseSecondsRaw}
          onChange={(event) => setPauseSecondsRaw(event.target.value)}
          disabled={creating}
        />
      </div>

      {feedback && <Note tone="erro">{feedback}</Note>}

      <div className="flex flex-col gap-2">
        <Button type="submit" disabled={creating}>
          Criar sala
        </Button>
        <Button type="button" variant="secundario" onClick={onBack} disabled={creating}>
          Voltar
        </Button>
      </div>
    </form>
  )
}
