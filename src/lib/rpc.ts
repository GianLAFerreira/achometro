import { supabase } from './supabase'
import type { Database } from '../types/database'

// Wrappers tipados das 5 RPCs de jogo + server_now. Cada função Postgres já
// valida tudo que importa (regra 1 do CLAUDE.md) — isto é só a borda que
// converte erro do PostgREST em exceção JS, para lib/errors.ts traduzir.

type RoomRow = Database['public']['Tables']['rooms']['Row']
type RoundRow = Database['public']['Tables']['rounds']['Row']
type AnswerRow = Database['public']['Tables']['answers']['Row']

export async function createRoom(
  nickname: string,
  roundsTotal = 10,
  answerSeconds = 20,
): Promise<RoomRow> {
  const { data, error } = await supabase.rpc('create_room', {
    p_nickname: nickname,
    p_themes: [],
    p_rounds_total: roundsTotal,
    p_answer_seconds: answerSeconds,
  })
  if (error) throw error
  return data
}

export async function joinRoom(roomCode: string, nickname: string): Promise<RoomRow> {
  const { data, error } = await supabase.rpc('join_room', {
    p_room_code: roomCode,
    p_nickname: nickname,
  })
  if (error) throw error
  return data
}

// Veredito sem efeito colateral, pra validar um código de sala antes de
// pedir apelido — diferente de join_room, que já te coloca dentro da sala.
export type RoomPeek = 'ok' | 'not_found' | 'finished' | 'abandoned' | 'empty'

export async function peekRoom(roomCode: string): Promise<RoomPeek> {
  const { data, error } = await supabase.rpc('peek_room', { p_room_code: roomCode })
  if (error) throw error
  return data as RoomPeek
}

export async function startRound(roomId: string): Promise<RoundRow> {
  const { data, error } = await supabase.rpc('start_round', { p_room_id: roomId })
  if (error) throw error
  return data
}

export async function submitAnswer(roundId: string, value: number): Promise<AnswerRow> {
  const { data, error } = await supabase.rpc('submit_answer', {
    p_round_id: roundId,
    p_value: value,
  })
  if (error) throw error
  return data
}

export async function closeRound(roundId: string): Promise<RoundRow> {
  const { data, error } = await supabase.rpc('close_round', { p_round_id: roundId })
  if (error) throw error
  return data
}

export async function serverNow(): Promise<Date> {
  const { data, error } = await supabase.rpc('server_now')
  if (error) throw error
  return new Date(data)
}
