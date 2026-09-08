import { useEffect, useState } from 'react'
import { AnimatePresence, motion } from 'motion/react'
import { Button } from './Button'
import { Note } from './Note'
import { useCountdown } from '../lib/clock'
import { DURATION_FAST, useReducedMotion } from '../lib/motion'
import { GENERAL_TOPIC_LABEL, TOPICS } from '../lib/topics'
import { roomPath } from '../lib/router'

interface LobbyPlayer {
  id: string
  nickname: string
}

interface LobbyProps {
  code: string
  players: LobbyPlayer[]
  isHost: boolean
  onStart: () => void
  starting: boolean
  targetScore: number
  createdAt: string
  themes: string[]
}

// `themes = []` é "qualquer tema" (ver lib/topics.ts) — mesmo valor que o
// servidor usa direto em start_round, não um tema de verdade pra rotular.
function themeLabels(themes: string[]): string {
  if (themes.length === 0) return GENERAL_TOPIC_LABEL
  return themes
    .map((value) => TOPICS.find((topic) => topic.value === value)?.label ?? value)
    .join(', ')
}

// Espelha o `interval '45 seconds'` do branch 'lobby' de start_round
// (migration lobby_sem_host_apos_desistencia) — só decide QUANDO MOSTRAR
// o botão de fallback; quem autoriza de fato é o servidor.
const HOST_GRACE_SECONDS = 45

// Tempo de leitura do "Link copiado" antes de sumir sozinho — não é
// estado de sistema, é recibo de uma ação que a pessoa acabou de fazer.
const FEEDBACK_MS = 3000

export function Lobby({
  code,
  players,
  isHost,
  onStart,
  starting,
  targetScore,
  createdAt,
  themes,
}: LobbyProps) {
  const reduceMotion = useReducedMotion()
  const graceEndsAt = new Date(
    new Date(createdAt).getTime() + HOST_GRACE_SECONDS * 1000,
  ).toISOString()
  const graceRemaining = useCountdown(graceEndsAt)

  const [inviteFeedback, setInviteFeedback] = useState<string | null>(null)

  useEffect(() => {
    if (!inviteFeedback) return
    const timeoutId = window.setTimeout(() => setInviteFeedback(null), FEEDBACK_MS)
    return () => window.clearTimeout(timeoutId)
  }, [inviteFeedback])

  // Convite: share sheet nativo quando existir — o SO já lista WhatsApp,
  // Telegram, SMS, então não integramos com nenhum deles em particular.
  // `share` e `clipboard` só existem em contexto seguro: em http:// por
  // IP na rede local (celular testando o app do dono da sala) nenhuma
  // das duas aparece, daí a terceira saída ser só avisar pra passar o
  // código, que já está na tela logo acima.
  async function handleInvite() {
    const url = `${window.location.origin}${roomPath(code)}`
    try {
      if (navigator.share) {
        await navigator.share({ title: 'Achômetro', text: `Entra na sala ${code}.`, url })
        return
      }
    } catch (error) {
      // Cancelar o share sheet rejeita com AbortError — é escolha da
      // pessoa, não falha. Qualquer outra rejeição cai pro clipboard.
      if (error instanceof DOMException && error.name === 'AbortError') return
    }
    try {
      await navigator.clipboard.writeText(url)
      setInviteFeedback('Link copiado.')
    } catch {
      setInviteFeedback(`Não deu pra copiar. Passe o código ${code}.`)
    }
  }

  return (
    <section className="flex flex-col gap-6">
      <div className="flex items-end justify-between gap-4">
        <div>
          <p className="font-body text-sm text-mostrador/60">Código da sala</p>
          <p className="font-num text-3xl text-latao">{code}</p>
        </div>
        <Button variant="secundario" onClick={handleInvite}>
          Convidar
        </Button>
      </div>

      {/* Região viva fixa no DOM: um aria-live que só aparece junto com a
          mensagem não é anunciado de forma confiável. min-h reserva a
          altura de uma linha pra não saltar a lista de jogadores quando
          o recibo entra e sai. */}
      <div aria-live="polite" className="min-h-5">
        {inviteFeedback && <Note>{inviteFeedback}</Note>}
      </div>

      {/* Configuração escolhida na Home, invisível depois de criada a
          sala até esta linha — mesma fonte de dados que já chega em
          `room`, sem RPC nova. `/60`, não o `/70` do Note neutro: aqui é
          rótulo de campo (mesmo par de "Código da sala" acima), não
          conteúdo informativo avulso — escolha deliberada, não deriva. */}
      <p className="font-body text-sm text-mostrador/60">Tema: {themeLabels(themes)}</p>
      <p className="font-body text-sm text-mostrador/60">
        Primeiro a {targetScore} pontos
      </p>

      <ul className="flex flex-col gap-1">
        <AnimatePresence initial={false}>
          {players.map((player) => (
            <motion.li
              key={player.id}
              layout={!reduceMotion}
              initial={reduceMotion ? false : { opacity: 0, x: -8 }}
              animate={{ opacity: 1, x: 0 }}
              exit={reduceMotion ? undefined : { opacity: 0 }}
              transition={{ duration: DURATION_FAST }}
              className="font-body text-sm text-mostrador"
            >
              {player.nickname}
            </motion.li>
          ))}
        </AnimatePresence>
      </ul>

      {players.length <= 1 && <Note>Ninguém aqui ainda. Passe o código {code}.</Note>}

      {isHost ? (
        <Button onClick={onStart} disabled={starting || players.length < 2}>
          Iniciar rodada
        </Button>
      ) : graceRemaining > 0 ? (
        <Note>Aguardando o anfitrião. Você pode assumir em {graceRemaining}s.</Note>
      ) : (
        <Button
          variant="secundario"
          onClick={onStart}
          disabled={starting || players.length < 2}
        >
          Assumir e iniciar
        </Button>
      )}
    </section>
  )
}
