import type { ButtonHTMLAttributes } from 'react'

type Variant = 'primario' | 'secundario'

interface ButtonProps extends ButtonHTMLAttributes<HTMLButtonElement> {
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

export function Button({ variant = 'primario', className = '', ...rest }: ButtonProps) {
  return <button className={`${BASE} ${VARIANTS[variant]} ${className}`} {...rest} />
}
