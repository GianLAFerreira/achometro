import { useCallback, useState } from 'react'

const STORAGE_KEY = 'achometro:apelido'
// Mesmo limite do `check (char_length(nickname) between 1 and 16)` em
// players — truncar aqui evita que o usuário só descubra o limite quando
// o Postgres devolver um 23514 cru.
const MAX_LENGTH = 16

function readStoredNickname(): string {
  try {
    return window.localStorage.getItem(STORAGE_KEY) ?? ''
  } catch {
    return ''
  }
}

/** Apelido persiste entre salas no mesmo navegador — decisão já tomada no plano. */
export function useNickname() {
  const [nickname, setNicknameState] = useState<string>(readStoredNickname)

  const setNickname = useCallback((value: string) => {
    const trimmed = value.trim().slice(0, MAX_LENGTH)
    setNicknameState(trimmed)
    try {
      window.localStorage.setItem(STORAGE_KEY, trimmed)
    } catch {
      // localStorage pode falhar (modo privado, quota cheia) — o apelido
      // só deixa de persistir entre sessões, o jogo continua funcionando.
    }
  }, [])

  return { nickname, setNickname, maxLength: MAX_LENGTH }
}
