import { useSyncExternalStore } from 'react'

// Roteador escrito à mão — só duas rotas (`/` e `/sala/:code`), não vale
// instalar react-router. History API + um evento sintético, porque
// `pushState` não dispara `popstate` por conta própria.

export type Route = { name: 'home' } | { name: 'room'; code: string }

const NAVIGATE_EVENT = 'achometro:navigate'

function parseRoute(pathname: string): Route {
  const trimmed = pathname.replace(/\/+$/, '') || '/'
  const roomMatch = /^\/sala\/([A-Za-z0-9]{6})$/.exec(trimmed)
  if (roomMatch) {
    return { name: 'room', code: roomMatch[1].toUpperCase() }
  }
  return { name: 'home' }
}

export function roomPath(code: string): string {
  return `/sala/${code.toUpperCase()}`
}

export function navigate(path: string): void {
  if (path !== window.location.pathname) {
    window.history.pushState(null, '', path)
    window.dispatchEvent(new Event(NAVIGATE_EVENT))
  }
}

function subscribe(callback: () => void): () => void {
  window.addEventListener('popstate', callback)
  window.addEventListener(NAVIGATE_EVENT, callback)
  return () => {
    window.removeEventListener('popstate', callback)
    window.removeEventListener(NAVIGATE_EVENT, callback)
  }
}

// useSyncExternalStore compara snapshots por referência — devolver um
// objeto novo a cada chamada, mesmo com o mesmo pathname, arrisca loop de
// re-render. Cacheia pelo pathname bruto.
let cachedPathname: string | null = null
let cachedRoute: Route | null = null

function getSnapshot(): Route {
  const pathname = window.location.pathname
  if (pathname !== cachedPathname || !cachedRoute) {
    cachedPathname = pathname
    cachedRoute = parseRoute(pathname)
  }
  return cachedRoute
}

export function useRoute(): Route {
  return useSyncExternalStore(subscribe, getSnapshot)
}
