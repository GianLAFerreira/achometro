// Todo erro de RPC chega aqui antes de virar texto na tela. Voz do
// aparelho (ver skill achometro-design): claro antes de esperto, sem
// "Ops!", sem pedido de desculpa, sem exclamação de entusiasmo.
//
// As chaves são exatamente as mensagens de `raise exception '...'` das
// funções Postgres (supabase/migrations/*_functions.sql e
// *_realtime_e_integridade_de_rodada.sql) — o Postgres propaga o texto de
// RAISE como `error.message` via PostgREST.
const MESSAGES: Record<string, string> = {
  auth_required: 'Sessão perdida. Recarregue a página.',
  room_not_found: 'Código não confere. Confira as 6 letras.',
  room_finished: 'Essa partida já terminou.',
  could_not_allocate_room_code: 'Não consegui gerar um código de sala. Tenta de novo.',
  not_host: 'Só o anfitrião faz isso.',
  round_already_open: 'Já tem rodada em andamento.',
  no_questions_available: 'Sem pergunta disponível para esta sala.',
  round_not_found: 'Rodada não encontrada.',
  round_closed: 'Rodada já fechada.',
  round_time_over: 'Tempo esgotado.',
  not_in_room: 'Você não está nesta sala.',
  already_answered: 'Palpite já cravado.',
  pause_in_progress: 'Aguarde a pausa entre rodadas terminar.',
  room_closed: 'Essa partida já terminou.',
  not_enough_players: 'Precisa de pelo menos 2 pessoas pra começar.',
  room_not_finished: 'Essa partida ainda não terminou.',
}

const FALLBACK = 'Não deu certo agora. Tenta de novo.'

export function describeError(error: unknown): string {
  const message = extractMessage(error)
  if (message && message in MESSAGES) {
    return MESSAGES[message]
  }
  return FALLBACK
}

function extractMessage(error: unknown): string | null {
  if (error && typeof error === 'object' && 'message' in error) {
    const raw = (error as { message: unknown }).message
    return typeof raw === 'string' ? raw : null
  }
  return null
}
