import { supabase } from './supabase'

// Nunca deixa uma falha de log virar um erro novo — perder um log é
// aceitável, quebrar a tela por causa do próprio log não é. Sem
// sessão resolvida ainda (ex.: erro durante o boot, antes de
// ensureSession terminar) a chamada falha silenciosamente — não tem
// como logar sem uma sessão autenticada, e não vale a pena resolver
// isso.
export async function logClientError(message: string, stack?: string): Promise<void> {
  try {
    await supabase.rpc('log_client_error', {
      p_message: message,
      p_stack: stack,
      p_path: window.location.pathname,
      p_user_agent: navigator.userAgent,
    })
  } catch {
    // deixa pra lá — ver comentário acima
  }
}

// Cobre o que ErrorBoundary.tsx não pega sozinho (só erro de render):
// erro solto num event handler, e promise rejeitada sem .catch.
// Instalado uma vez, no boot (main.tsx).
export function installGlobalErrorLogging(): void {
  window.addEventListener('error', (event) => {
    void logClientError(event.message, event.error?.stack)
  })
  window.addEventListener('unhandledrejection', (event) => {
    const reason: unknown = event.reason
    const message = reason instanceof Error ? reason.message : String(reason)
    const stack = reason instanceof Error ? reason.stack : undefined
    void logClientError(message, stack)
  })
}
