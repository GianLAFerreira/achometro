import type { InputHTMLAttributes } from 'react'

interface TextFieldProps extends Omit<InputHTMLAttributes<HTMLInputElement>, 'type'> {
  label: string
  id: string
}

// Mesmo tratamento visual do NumberField, mas sem inputMode numérico —
// usado só para o apelido (texto livre, até 16 caracteres).
//
// Sem `outline-none`: em Tailwind v4 a camada `utilities` vem depois de
// `base` no cascade, então essa utility anularia o `:focus-visible`
// global do index.css independente de especificidade (achado por
// revisão adversarial de UI). O foco de teclado visível é piso de
// qualidade não negociável do design system.
export function TextField({ label, id, className = '', ...rest }: TextFieldProps) {
  return (
    <label className="flex flex-col gap-2 font-body text-sm text-mostrador/80" htmlFor={id}>
      {label}
      <input
        id={id}
        type="text"
        autoComplete="off"
        className={`bg-esmalte-2 px-4 py-3 font-body text-base text-mostrador ${className}`}
        {...rest}
      />
    </label>
  )
}
