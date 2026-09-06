# Fluxo de jogo

Ciclo de vida de uma sala, tela por tela, com a função RPC que dispara cada transição. Ver
[`banco-de-dados.md`](./banco-de-dados.md) para o contrato de cada função.

## 1. Boot da página

Antes de qualquer UI, `main.tsx` espera `ensureSession()` (`src/lib/session.ts`) resolver — login
anônimo do Supabase, memoizado por load de página. Só depois disso o `App` é renderizado: assinar
um canal Realtime antes de ter sessão faria o Supabase avaliar RLS como `anon` (sem grant nenhum
aqui) e o cliente receberia zero eventos, sem erro nenhum.

## 2. `HomeScreen` — criar ou entrar

- **Criar sala**: `RoomConfigForm` (temas via `TopicSelect`, número de rodadas, tempo de resposta,
  pausa entre rodadas, pontuação-alvo) → `createRoom()` → navega para `/sala/<código>` como host.
- **Entrar com código**: o campo aceita o código; a validação de "esse código existe?" acontece ao
  digitar o apelido na tela da sala, não aqui (`peek_room` existe para checar sem efeito colateral,
  mas o caminho de entrada de fato passa por `join_room`, que já é o efeito colateral).

## 3. `RoomScreen` — dentro da sala

`useRoom(roomCode, playerId)` resolve o código para um `roomId`, busca o snapshot da sala
(`rooms` + `players` + `rounds` + `answers` da rodada atual) e mantém tudo sincronizado via
Realtime. `RoomScreen` decide qual componente mostrar a partir de `room.status` e do estado da
rodada atual:

```
room.status = 'lobby'                          → Lobby
room.status = 'playing', rodada atual 'open'    → RoundOpen
room.status = 'playing', rodada atual 'closed'  → RoundReveal (+ Scoreboard)
room.status = 'finished'                        → Podium
room.status = 'abandoned'                       → Note de encerramento
```

### Lobby

Lista de jogadores entrando em tempo real (via Realtime em `players`). Só o host vê o botão de
iniciar — `CLAUDE.md` exige pelo menos 2 jogadores para sair do lobby, checagem feita dentro de
`start_round` (não confiar em contagem do lado do cliente). Clicar chama `startRound(roomId)`.

### RoundOpen

Mostra `question_prompt`/`question_unit` da rodada (copiados para `rounds` no início, não lidos de
`questions` de novo), um `NumberField` para o palpite e o `Countdown` contando os `answer_seconds`
da sala. Enviar chama `submitAnswer(roundId, value)`. Fechamento é automático via
`useRoundCloser`: o host fecha assim que todo jogador **ativo** respondeu ou quando o tempo acaba;
qualquer outro membro fecha só depois do tempo, com um pequeno atraso aleatório como rede de
segurança se o host tiver sumido.

### RoundReveal

Aparece quando `close_round` preenche `revealed_*` na rodada. `Mostrador` é a peça central — a
agulha logarítmica que compara cada palpite ao gabarito revelado (ver skill `achometro-design`
para a matemática da escala). `Scoreboard` mostra o placar acumulado ao lado. Depois de
`pause_seconds`, `useRoundAdvancer` chama `start_round` de novo sozinho (mesmo padrão host-primeiro
+ rede de segurança do fechamento) — o jogador não precisa clicar em nada para a próxima rodada
começar.

### Podium

Fim de partida, via uma das quatro condições de `close_round` (ver
[`banco-de-dados.md`](./banco-de-dados.md#as-quatro-vias-de-fim-de-partida-close_round-em-ordem-de-checagem)).
Pódio animado com o placar final.

## Sincronização de tempo

Nenhuma tela confia em `Date.now()` do navegador puro para decidir "o tempo acabou" na tela — isso
é só para a barra visual (`Countdown`). A decisão que de fato conta (se `close_round`/`start_round`
são aceitos) é sempre validada pelo servidor contra `ends_at`/`closed_at + pause_seconds`; o
cliente que tentar agir cedo demais recebe `round_time_over` ou `pause_in_progress` e simplesmente
não altera nada.
