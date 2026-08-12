import { createClient } from '@supabase/supabase-js'
import type { Database } from '../types/database'

const url = import.meta.env.VITE_SUPABASE_URL
const anonKey = import.meta.env.VITE_SUPABASE_ANON_KEY

if (!url || !anonKey) {
  throw new Error(
    'Faltam VITE_SUPABASE_URL / VITE_SUPABASE_ANON_KEY. Copie .env.example para ' +
      '.env.local e preencha com o output de `npm run db:status`.',
  )
}

// Singleton — um cliente só para o app inteiro. `detectSessionInUrl: false`
// porque não usamos OAuth nem magic link: a única identidade é a sessão
// anônima criada por `ensureSession` (ver session.ts).
export const supabase = createClient<Database>(url, anonKey, {
  auth: {
    persistSession: true,
    autoRefreshToken: true,
    detectSessionInUrl: false,
  },
})
