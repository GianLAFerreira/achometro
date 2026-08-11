/**
 * Placeholder de scaffold (Fase 0) — só para verificar que o pipeline inteiro
 * funciona: Vite + Tailwind v4 + os tokens do design system + as 3 fontes.
 * A interface real (sala, rodada, mostrador) entra nas Fases 3 e 4.
 */
function App() {
  return (
    <main className="flex min-h-screen flex-col items-center justify-center gap-4 px-6 text-center">
      <h1 className="font-display text-5xl font-extrabold uppercase tracking-tight text-mostrador sm:text-7xl">
        Achômetro
      </h1>
      <p className="max-w-md font-body text-base text-mostrador/80">
        O medidor oficial do seu achismo.
      </p>
      <p className="font-num text-sm text-latao">scaffold ok — fase 0</p>
    </main>
  )
}

export default App
