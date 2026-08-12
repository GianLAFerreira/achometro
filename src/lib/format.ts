const numberFormatter = new Intl.NumberFormat('pt-BR')

export function formatInteger(value: number): string {
  return numberFormatter.format(Math.round(value))
}

/**
 * Converte o texto de um <input> num inteiro. Não existe decimal neste
 * jogo (ver constraint questions_answer_integer_check) — ignora tudo que
 * não for dígito ou sinal de negativo, incluindo separador de milhar que
 * o próprio usuário digitar.
 */
export function parseGuess(raw: string): number | null {
  const digitsOnly = raw.replace(/[^\d-]/g, '')
  if (digitsOnly === '' || digitsOnly === '-') return null
  const value = Number.parseInt(digitsOnly, 10)
  return Number.isFinite(value) ? value : null
}
