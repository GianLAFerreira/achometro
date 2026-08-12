import { motion } from 'motion/react'
import { useReducedMotion } from '../lib/motion'

interface CountdownProps {
  seconds: number
  totalSeconds: number
}

const URGENT_THRESHOLD = 5
const SIZE = 128
const STROKE = 6
const RADIUS = SIZE / 2 - STROKE / 2
const CIRCUMFERENCE = 2 * Math.PI * RADIUS

// Face herói é Martian Mono — o conteúdo do app é número, o cronômetro é
// o número mais olhado da tela durante uma rodada aberta. O anel de
// progresso reforça isso sem competir: só o TRAÇO muda pra --agulha nos
// últimos segundos, nunca a cor do dígito — --agulha sobre --esmalte não
// passa AA pra texto (mesma regra documentada em Note.tsx), então o
// número fica sempre em --latao. Urgência vira pulso de escala (CSS, ver
// index.css) em vez de cor no texto.
export function Countdown({ seconds, totalSeconds }: CountdownProps) {
  const reduceMotion = useReducedMotion()
  const clamped = Math.max(0, seconds)
  const progress = totalSeconds > 0 ? Math.min(1, clamped / totalSeconds) : 0
  const isUrgent = clamped > 0 && clamped <= URGENT_THRESHOLD

  return (
    <div className="relative inline-flex h-32 w-32 items-center justify-center">
      <svg viewBox={`0 0 ${SIZE} ${SIZE}`} className="absolute inset-0 -rotate-90">
        <circle
          cx={SIZE / 2}
          cy={SIZE / 2}
          r={RADIUS}
          fill="none"
          stroke="currentColor"
          strokeWidth={STROKE}
          className="text-mostrador/15"
        />
        <motion.circle
          cx={SIZE / 2}
          cy={SIZE / 2}
          r={RADIUS}
          fill="none"
          stroke="currentColor"
          strokeWidth={STROKE}
          strokeDasharray={CIRCUMFERENCE}
          className={isUrgent ? 'text-agulha' : 'text-latao'}
          animate={{ strokeDashoffset: CIRCUMFERENCE * (1 - progress) }}
          transition={reduceMotion ? { duration: 0 } : { duration: 0.25, ease: 'linear' }}
        />
      </svg>
      <p
        className={`font-num text-4xl text-latao ${
          isUrgent && !reduceMotion ? 'animate-[pulso-urgente_1s_ease-in-out_infinite]' : ''
        }`}
        role="timer"
        aria-live="polite"
      >
        {clamped}
      </p>
    </div>
  )
}
