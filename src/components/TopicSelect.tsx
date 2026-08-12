import { motion } from 'motion/react'
import { GENERAL_TOPIC_LABEL, TOPICS } from '../lib/topics'
import { useReducedMotion } from '../lib/motion'
import { BUTTON_BASE, BUTTON_VARIANTS } from './buttonStyles'

interface TopicSelectProps {
  themes: string[]
  onChange: (themes: string[]) => void
  disabled?: boolean
}

// Reaproveita literalmente as strings do Button.tsx (não uma cópia) —
// achado de revisão: uma cópia com padding menor já tinha derrapado do
// piso de toque de 44px sem ninguém decidir isso de propósito.
const SELECTED = BUTTON_VARIANTS.primario
const UNSELECTED = BUTTON_VARIANTS.secundario

// Primeiro controle de múltipla escolha do app — não existia nenhum
// (nem checkbox, nem radio, nem <select>) antes deste componente.
//
// Estado é literalmente `themes: string[]`, o mesmo formato que
// create_room espera — sem flag "isGeneral" separado. "Conhecimentos
// Gerais" fica selecionado quando o array está vazio; marcar um tópico
// específico tira o array do vazio (Geral deixa de aparecer marcado) e
// desmarcar o último tópico específico o esvazia de novo (Geral volta a
// aparecer marcado). É o efeito "exclusivo" pedido, decorrente da própria
// modelagem, sem precisar desabilitar nada explicitamente.
export function TopicSelect({ themes, onChange, disabled }: TopicSelectProps) {
  const reduceMotion = useReducedMotion()
  const isGeneral = themes.length === 0

  const toggleTopic = (value: string) => {
    if (themes.includes(value)) {
      onChange(themes.filter((theme) => theme !== value))
    } else {
      onChange([...themes, value])
    }
  }

  return (
    <div className="flex flex-col gap-2">
      <p className="font-body text-sm text-mostrador/80">Tópicos</p>
      <div className="flex flex-wrap gap-2">
        <motion.button
          type="button"
          aria-pressed={isGeneral}
          disabled={disabled}
          whileTap={reduceMotion ? undefined : { scale: 0.97 }}
          onClick={() => onChange([])}
          className={`${BUTTON_BASE} ${isGeneral ? SELECTED : UNSELECTED}`}
        >
          {GENERAL_TOPIC_LABEL}
        </motion.button>
        {TOPICS.map((topic) => {
          const selected = themes.includes(topic.value)
          return (
            <motion.button
              key={topic.value}
              type="button"
              aria-pressed={selected}
              disabled={disabled}
              whileTap={reduceMotion ? undefined : { scale: 0.97 }}
              onClick={() => toggleTopic(topic.value)}
              className={`${BUTTON_BASE} ${selected ? SELECTED : UNSELECTED}`}
            >
              {topic.label}
            </motion.button>
          )
        })}
      </div>
    </div>
  )
}
