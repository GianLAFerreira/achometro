import { useEffect, useMemo, useRef, useState } from 'react'
import { motion } from 'motion/react'
import { SPRING_NEEDLE, useReducedMotion } from '../lib/motion'

interface MostradorAnswer {
  playerId: string
  nickname: string
  value: number
}

interface MostradorProps {
  revealedAnswer: number
  answers: MostradorAnswer[]
  highlightPlayerId?: string | null
}

// Elemento-assinatura (skill achometro-design): escala logarítmica, porque
// as perguntas variam de centenas a bilhões e em escala linear tudo se
// amontoa num pixel — a mesma razão pela qual a pontuação usa erro
// relativo, não erro absoluto. É a ÚNICA peça do app com esse tratamento;
// resto da interface fica plano de propósito.
//
// Domínio dinâmico (não fixo em 10³–10¹¹ como o mockup da skill): cada
// pergunta tem sua própria magnitude, então a escala se ajusta ao
// gabarito + palpites desta rodada, com span mínimo de 2 décadas.
const MIN_SPAN_DECADES = 2
const ROW_HEIGHT_PX = 16
// Um percentual fixo de distância não cobre colisão de rótulo — a largura
// do texto varia com o nome (até 16 caracteres). Em vez disso, mede a
// largura real do track (ResizeObserver) e estima a largura do rótulo em
// px por contagem de caractere, pra decidir empilhamento com geometria de
// verdade. Achado de revisão adversarial: um limiar em % (testado a 3% e
// depois 7%) resolvia o caso ao vivo com nomes curtos e reabria a colisão
// com nomes longos — o problema é de largura em px, não de percentual.
const LABEL_CHAR_WIDTH_PX = 6.5 // Instrument Sans, text-xs (~12px) — média por glifo
const LABEL_PADDING_PX = 6
const ROW_GAP_PX = 4
const FALLBACK_TRACK_WIDTH_PX = 360 // antes do primeiro ResizeObserver disparar

function logPosition(value: number): number {
  return Math.log10(Math.max(1, Math.abs(value)))
}

function computeDomain(values: number[]): { minExp: number; maxExp: number } {
  const logs = values.map(logPosition)
  let minExp = Math.floor(Math.min(...logs))
  let maxExp = Math.ceil(Math.max(...logs))
  const span = maxExp - minExp
  if (span < MIN_SPAN_DECADES) {
    const pad = Math.ceil((MIN_SPAN_DECADES - span) / 2)
    minExp -= pad
    maxExp += pad
  }
  return { minExp, maxExp }
}

function estimateLabelHalfWidthPx(nickname: string): number {
  return (nickname.length * LABEL_CHAR_WIDTH_PX + LABEL_PADDING_PX) / 2
}

export function Mostrador({ revealedAnswer, answers, highlightPlayerId }: MostradorProps) {
  const reduceMotion = useReducedMotion()
  const containerRef = useRef<HTMLDivElement>(null)
  const [trackWidth, setTrackWidth] = useState(FALLBACK_TRACK_WIDTH_PX)

  useEffect(() => {
    const el = containerRef.current
    if (!el) return
    const observer = new ResizeObserver((entries) => {
      const width = entries[0]?.contentRect.width
      if (width) setTrackWidth(width)
    })
    observer.observe(el)
    return () => observer.disconnect()
  }, [])

  const { gabaritoPct, decades, markers } = useMemo(() => {
    const domain = computeDomain([revealedAnswer, ...answers.map((a) => a.value)])
    const toPct = (value: number) =>
      Math.min(100, Math.max(0, ((logPosition(value) - domain.minExp) / (domain.maxExp - domain.minExp)) * 100))

    const decadeList = []
    for (let exp = domain.minExp; exp <= domain.maxExp; exp++) {
      decadeList.push({ exp, pct: toPct(10 ** exp) })
    }

    // Empilhamento por colisão real em px: cada marcador entra na primeira
    // linha (row) cujo último rótulo colocado não sobreponha o dele —
    // igual a empacotamento de intervalos, não um limiar percentual fixo.
    const sorted = [...answers].sort((a, b) => toPct(a.value) - toPct(b.value))
    const rowRightEdges: number[] = []
    const withRows = sorted.map((answer) => {
      const pct = toPct(answer.value)
      const centerPx = (pct / 100) * trackWidth
      const halfWidth = estimateLabelHalfWidthPx(answer.nickname)
      const leftEdge = centerPx - halfWidth
      let row = 0
      while (rowRightEdges[row] !== undefined && leftEdge < rowRightEdges[row] + ROW_GAP_PX) {
        row += 1
      }
      rowRightEdges[row] = centerPx + halfWidth
      return { ...answer, pct, row }
    })

    return {
      gabaritoPct: toPct(revealedAnswer),
      decades: decadeList,
      markers: withRows,
    }
  }, [revealedAnswer, answers, trackWidth])

  const maxRow = markers.reduce((max, m) => Math.max(max, m.row), 0)

  return (
    <div ref={containerRef} className="flex flex-col gap-2" aria-hidden="true">
      {/* Marcas de década — só com rótulo em telas sm e acima; no celular a
          régua fica só com as marcas, sem número competindo por espaço. */}
      <div className="relative hidden h-4 sm:block">
        {decades.map(({ exp, pct }) => (
          <span
            key={exp}
            className="absolute -translate-x-1/2 font-num text-xs text-mostrador/40"
            style={{ left: `${pct}%` }}
          >
            10<sup>{exp}</sup>
          </span>
        ))}
      </div>

      {/* Trilho */}
      <div className="relative h-4">
        <div className="absolute inset-x-0 top-1/2 h-px -translate-y-1/2 bg-mostrador/20" />
        {decades.map(({ exp, pct }) => (
          <div
            key={exp}
            className="absolute top-0 h-4 w-px bg-mostrador/20"
            style={{ left: `${pct}%` }}
          />
        ))}

        <motion.div
          className="absolute top-0 h-4 w-0.5 bg-agulha"
          style={{ left: `${gabaritoPct}%` }}
          initial={reduceMotion ? false : { scaleY: 0, opacity: 0 }}
          animate={{ scaleY: 1, opacity: 1 }}
          transition={reduceMotion ? { duration: 0 } : SPRING_NEEDLE}
        />

        {markers.map((marker, index) => {
          const isYou = marker.playerId === highlightPlayerId
          return (
            <motion.div
              key={marker.playerId}
              className={`absolute top-0 h-4 w-1 -translate-x-1/2 ${isYou ? 'bg-latao' : 'bg-latao/60'}`}
              style={{ left: `${marker.pct}%` }}
              initial={reduceMotion ? false : { scaleY: 0, y: -6, opacity: 0 }}
              animate={{ scaleY: 1, y: 0, opacity: 1 }}
              transition={
                reduceMotion ? { duration: 0 } : { ...SPRING_NEEDLE, delay: index * 0.05 }
              }
            />
          )
        })}
      </div>

      {/* Rótulos de nome — só sm e acima, mesma razão das décadas. A lista
          detalhada abaixo do mostrador é a fonte legível em qualquer
          largura; isto é só o flourish visual. */}
      <div className="relative hidden sm:block" style={{ height: (maxRow + 1) * ROW_HEIGHT_PX }}>
        {markers.map((marker) => (
          <span
            key={marker.playerId}
            className={`absolute -translate-x-1/2 whitespace-nowrap font-body text-xs ${
              marker.playerId === highlightPlayerId ? 'text-latao' : 'text-mostrador/60'
            }`}
            style={{ left: `${marker.pct}%`, top: marker.row * ROW_HEIGHT_PX }}
          >
            {marker.nickname}
          </span>
        ))}
      </div>
    </div>
  )
}
