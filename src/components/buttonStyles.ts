// Fonte única do visual "botão plano" — extraído de Button.tsx pra um
// arquivo sem componente, porque exportar constante de um arquivo de
// componente quebra o Fast Refresh (oxlint react(only-export-components)).
// Reaproveitado por Button.tsx e por qualquer controle novo que precise
// da mesma estética (ex.: TopicSelect.tsx) sem duplicar a string e
// arriscar divergir dela.
type Variant = 'primario' | 'secundario'

// Sem border-radius — a lista de proibições do design system marca raio
// uniforme aplicado a tudo como assinatura de "cara de IA"; o resto da
// interface (fora do mostrador) é plano e de canto reto de propósito.
export const BUTTON_BASE =
  'inline-flex items-center justify-center px-5 py-3 font-body text-sm font-medium ' +
  'uppercase tracking-wide transition-colors disabled:cursor-not-allowed disabled:opacity-50'

export const BUTTON_VARIANTS: Record<Variant, string> = {
  primario: 'bg-latao text-tinta hover:bg-latao/90',
  secundario: 'bg-esmalte-2 text-mostrador hover:bg-esmalte-2/70',
}
