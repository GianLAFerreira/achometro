// Presets de movimento — fonte única, mesmo princípio dos tokens de cor em
// index.css: mudar aqui, não duplicar número mágico de easing/duração em
// cada componente. Regra da skill achometro-design: animação só em
// transição de estado (troca de tela, chegada de dado, toque), nunca
// decorativa/ociosa — se um componente novo "pulsa sozinho" sem gatilho,
// já saiu do escopo deste arquivo.
import type { Transition } from 'motion/react'

// Ponteiro do mostrador, a cascata do placar final e a entrada do logo
// na Home: ultrapassam o alvo e assentam com amortecimento, como
// instrumento físico de verdade — reservado a esses três momentos
// deliberados, nunca espalhado pela interface (skill: "física de
// instrumento... um único momento orquestrado").
export const SPRING_NEEDLE: Transition = {
  type: 'spring',
  stiffness: 220,
  damping: 18,
  mass: 0.6,
}

// Crossfades entre telas/fases — sem overshoot, é troca de contexto, não
// o momento emocional da revelação.
export const EASE_SETTLE = [0.16, 1, 0.3, 1] as const

export const DURATION_FAST = 0.15
export const DURATION_BASE = 0.25

export const FADE_TRANSITION: Transition = {
  duration: DURATION_BASE,
  ease: EASE_SETTLE,
}

// Reexportado daqui pra todo componente importar de um lugar só — não é
// detecção própria, é a própria lib. Ver useReducedMotion() em cada
// componente animado antes de aplicar overshoot/stagger/whileTap.
export { useReducedMotion } from 'motion/react'
