interface CountdownProps {
  seconds: number
}

// Face herói é Martian Mono — o conteúdo do app é número, o cronômetro é
// o número mais olhado da tela durante uma rodada aberta.
export function Countdown({ seconds }: CountdownProps) {
  return (
    <p className="font-num text-4xl text-latao" role="timer" aria-live="polite">
      {Math.max(0, seconds)}
    </p>
  )
}
