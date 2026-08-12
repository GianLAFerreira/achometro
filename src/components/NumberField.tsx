import type { InputHTMLAttributes } from 'react'

interface NumberFieldProps extends Omit<InputHTMLAttributes<HTMLInputElement>, 'type' | 'inputMode'> {
  label: string
  id: string
}

// inputMode="numeric" chama o teclado numérico no celular sem forçar
// type="number" — que esconde o separador de milhar e some com o "-" em
// alguns navegadores. O parse fica em lib/format.ts (parseGuess).
//
// Sem `outline-none`: em Tailwind v4 a camada `utilities` vem depois de
// `base` no cascade, então essa utility anularia o `:focus-visible`
// global do index.css independente de especificidade (achado por
// revisão adversarial de UI). O foco de teclado visível é piso de
// qualidade não negociável do design system.
export function NumberField({ label, id, className = '', ...rest }: NumberFieldProps) {
  return (
    <label className="flex flex-col gap-2 font-body text-sm text-mostrador/80" htmlFor={id}>
      {label}
      <input
        id={id}
        type="text"
        inputMode="numeric"
        autoComplete="off"
        className={`bg-esmalte-2 px-4 py-3 font-num text-2xl text-mostrador ${className}`}
        {...rest}
      />
    </label>
  )
}
