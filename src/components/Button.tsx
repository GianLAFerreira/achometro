import { motion } from 'motion/react'
import type { HTMLMotionProps } from 'motion/react'
import { useReducedMotion } from '../lib/motion'
import { BUTTON_BASE, BUTTON_VARIANTS } from './buttonStyles'

type Variant = 'primario' | 'secundario'

interface ButtonProps extends HTMLMotionProps<'button'> {
  variant?: Variant
}

// Feedback de toque (whileTap) é o único "movimento" deste componente —
// desativado com prefers-reduced-motion, mesma regra de qualquer outra
// animação do app.
export function Button({ variant = 'primario', className = '', ...rest }: ButtonProps) {
  const reduceMotion = useReducedMotion()
  return (
    <motion.button
      whileTap={reduceMotion ? undefined : { scale: 0.97 }}
      className={`${BUTTON_BASE} ${BUTTON_VARIANTS[variant]} ${className}`}
      {...rest}
    />
  )
}
