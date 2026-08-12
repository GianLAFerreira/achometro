import { useEffect, useRef, useState } from 'react'
import { serverNow } from './rpc'

// Offset servidor↔cliente medido uma vez por load, ancorado em
// performance.now() — nunca em Date.now() de novo depois, para um ajuste
// de NTP no meio da rodada não fazer o cronômetro saltar.
let anchorPerf = performance.now()
let anchorWallClockMs = Date.now()
let syncPromise: Promise<void> | null = null

async function measureOffset(): Promise<void> {
  const t0 = Date.now()
  const server = await serverNow()
  const t1 = Date.now()
  const roundTripMs = t1 - t0
  const clientMidpointMs = t0 + roundTripMs / 2
  const offsetMs = server.getTime() - clientMidpointMs

  anchorPerf = performance.now()
  anchorWallClockMs = Date.now() + offsetMs
}

export function ensureClockSynced(): Promise<void> {
  if (!syncPromise) {
    syncPromise = measureOffset()
  }
  return syncPromise
}

function serverNowMs(): number {
  return anchorWallClockMs + (performance.now() - anchorPerf)
}

/**
 * Segundos restantes até `endsAtIso`, nunca negativo. Recalcula a partir
 * de `ends_at` a cada tick em vez de decrementar um contador — uma aba em
 * segundo plano estrangula `setInterval`, e decrementar acumularia erro.
 */
export function useCountdown(endsAtIso: string): number {
  const [remainingMs, setRemainingMs] = useState(() => computeRemaining(endsAtIso))

  // `useState` só roda o inicializador no mount. Se `endsAtIso` mudar
  // depois (nova rodada), o valor antigo continuaria valendo até o efeito
  // abaixo rodar — e o efeito só atualiza de forma assíncrona (depois do
  // primeiro tick do setInterval, ou de `ensureClockSynced` resolver).
  // Bug real encontrado no playtest manual: como `useRoundCloser` chama
  // este hook com um `endsAtIso` de fallback no passado enquanto a rodada
  // ainda não carregou, o valor ficava "tempo esgotado" — e continuava
  // esgotado por um render inteiro depois da rodada real chegar, o
  // suficiente para `useRoundCloser` fechar a rodada antes de exibi-la.
  // Ajustar o estado durante a própria renderização (padrão documentado
  // do React para "resetar estado quando uma prop muda") elimina esse
  // intervalo.
  const prevEndsAtRef = useRef(endsAtIso)
  if (prevEndsAtRef.current !== endsAtIso) {
    prevEndsAtRef.current = endsAtIso
    setRemainingMs(computeRemaining(endsAtIso))
  }

  useEffect(() => {
    ensureClockSynced().then(() => setRemainingMs(computeRemaining(endsAtIso)))

    const tick = () => setRemainingMs(computeRemaining(endsAtIso))
    const intervalId = window.setInterval(tick, 250)

    const onVisibility = () => {
      if (document.visibilityState === 'visible') tick()
    }
    document.addEventListener('visibilitychange', onVisibility)

    return () => {
      window.clearInterval(intervalId)
      document.removeEventListener('visibilitychange', onVisibility)
    }
  }, [endsAtIso])

  return Math.max(0, Math.ceil(remainingMs / 1000))
}

function computeRemaining(endsAtIso: string): number {
  return new Date(endsAtIso).getTime() - serverNowMs()
}
