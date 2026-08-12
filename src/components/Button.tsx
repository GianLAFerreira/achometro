import { motion } from 'motion/react'
import type { HTMLMotionProps } from 'motion/react'
import { useReducedMotion } from '../lib/motion'

type Variant = 'primario' | 'secundario'

interface ButtonProps extends HTMLMotionProps<'button'> {
  variant?: Variant
}

// Sem border-radius — a lista de proibições do design system marca raio
// uniforme aplicado a tudo como assinatura de "cara de IA"; o resto da
// interface (fora do mostrador) é plano e de canto reto de propósito.
const BASE =
  'inline-flex items-center justify-center px-5 py-3 font-body text-sm font-medium ' +
  'uppercase tracking-wide transition-colors disabled:cursor-not-allowed disabled:opacity-50'

const VARIANTS: Record<Variant, string> = {
  primario: 'bg-latao text-tinta hover:bg-latao/90',
  secundario: 'bg-esmalte-2 text-mostrador hover:bg-esmalte-2/70',
}

// Feedback de toque (whileTap) é o único "movimento" deste componente —
// desativado com prefers-reduced-motion, mesma regra de qualquer outra
// animação do app.
export function Button({ variant = 'primario', className = '', ...rest }: ButtonProps) {
  const reduceMotion = useReducedMotion()
  return (
    <motion.button
      whileTap={reduceMotion ? undefined : { scale: 0.97 }}
      className={`${BASE} ${VARIANTS[variant]} ${className}`}
      {...rest}
    />
  )
}
