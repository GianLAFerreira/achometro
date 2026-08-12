// Vibração curta em 2 momentos do jogo (cravar palpite, abertura da
// revelação) — Web Vibration API, sem terceiro, sem prompt de permissão
// no Android. `navigator.vibrate` não existe em iOS Safari: o `?.` faz
// isso ser um no-op silencioso ali, nunca um erro.
export function tapFeedback(): void {
  navigator.vibrate?.(20)
}
