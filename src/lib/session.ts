import { supabase } from './supabase'

let sessionPromise: Promise<string> | null = null

/**
 * Garante uma sessão anônima e devolve o player_id (= auth.uid()).
 *
 * Promise memoizada de módulo, não estado de componente: chamada de
 * qualquer lugar, resolvida uma única vez por load da página.
 * `signInAnonymously` cria um usuário NOVO a cada chamada — sem essa
 * memoização, o StrictMode do React 19 (que monta efeitos duas vezes em
 * dev) criaria dois usuários por load, e o segundo apagaria a sessão do
 * primeiro.
 *
 * Ordem importa: isto precisa resolver ANTES de assinar qualquer canal
 * Realtime. Sem sessão, o Realtime avalia RLS como `anon` — que não tem
 * grant nenhum neste projeto — e o cliente recebe zero eventos, sem erro
 * nenhum. Ver main.tsx, que só renderiza depois desta promise resolver.
 */
export function ensureSession(): Promise<string> {
  if (!sessionPromise) {
    sessionPromise = resolveSession()
  }
  return sessionPromise
}

async function resolveSession(): Promise<string> {
  const { data: existing } = await supabase.auth.getSession()
  if (existing.session) {
    return existing.session.user.id
  }

  const { data, error } = await supabase.auth.signInAnonymously()
  if (error || !data.session) {
    throw new Error(
      `Não foi possível iniciar a sessão anônima: ${error?.message ?? 'sem sessão retornada'}`,
    )
  }
  return data.session.user.id
}
