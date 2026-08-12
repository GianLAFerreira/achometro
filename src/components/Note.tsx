import type { ReactNode } from 'react'

interface NoteProps {
  tone?: 'neutro' | 'erro'
  children: ReactNode
}

// Voz do aparelho: claro antes de esperto. Erro se marca com --agulha (a
// mesma cor do ponteiro/gabarito), mas NÃO como cor do texto: medido,
// --agulha sobre --esmalte dá 2.71:1 de contraste, abaixo até do mínimo
// de texto grande (3:1) — achado por revisão adversarial de UI. O texto
// continua em --mostrador (par já validado contra --esmalte); --agulha
// vira só a marca lateral, redundante com a própria mensagem em
// português, nunca o único jeito de perceber que é erro.
export function Note({ tone = 'neutro', children }: NoteProps) {
  if (tone === 'erro') {
    return (
      <p className="border-l-2 border-agulha bg-agulha/10 py-1 pl-3 font-body text-sm text-mostrador">
        {children}
      </p>
    )
  }
  return <p className="font-body text-sm text-mostrador/70">{children}</p>
}
