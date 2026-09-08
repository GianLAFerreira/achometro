# Arquitetura

## Visão geral

```
┌─────────────────────┐        RPC (Postgres functions)       ┌───────────────────────────┐
│  Cliente (React)     │ ─────────────────────────────────────▶ │  Supabase                   │
│  src/                │                                        │  ┌───────────────────────┐  │
│                       │ ◀───────────────────────────────────  │  │ Postgres               │  │
│  useRoom, useRound-   │        Realtime (postgres_changes)     │  │  - questions            │  │
│  Advancer/Closer      │                                        │  │  - rooms/players/rounds │  │
│                       │ ◀───────────────────────────────────  │  │  - answers              │  │
│                       │        SELECT direto (via RLS)         │  │  - question_seen        │  │
└─────────────────────┘                                        │  │ RPCs SECURITY DEFINER  │  │
                                                                  │  │ RLS nega por padrão     │  │
                                                                  │  │ pg_cron (TTL 24h)        │  │
                                                                  │  └───────────────────────┘  │
                                                                  └───────────────────────────┘
```

Não existe servidor de aplicação entre o React e o Supabase — o cliente fala direto com Postgres
via PostgREST (para SELECT, protegido por RLS) e via RPC (para toda escrita, protegida por
`SECURITY DEFINER` + `auth.uid()`). Ver `CLAUDE.md`, regra 1, para o porquê de a lógica de jogo
nunca rodar no cliente: o React é sempre um *gatilho* que pede uma ação, nunca a autoridade que
decide se ela é válida.

## Identidade sem PII

Todo acesso passa por login anônimo do Supabase (`signInAnonymously`, disparado por
`src/lib/session.ts`). Isso dá um `auth.uid()` real e verificável no JWT da sessão, sem exigir
e-mail, senha ou qualquer dado pessoal. `player_id` em todo o schema **é** esse `auth.uid()` — não
um UUID inventado no cliente, que não teria como ser distinguido de uma falsificação pela RLS. Ver
`CLAUDE.md`, regra 2.

## Como o cliente descobre que algo mudou

`useRoom` (`src/state/useRoom.ts`) assina um canal Realtime por sala e trata **todo** evento
(`postgres_changes` em `rooms`, `players`, `rounds`) como invalidação — nunca aplica o payload do
evento direto no estado. Ao receber qualquer evento, refaz um fetch completo da sala. Isso existe
porque o Realtime não faz replay do que perdeu: se o socket cair por alguns segundos, aplicar só
os payloads que chegaram deixaria o estado permanentemente errado sem nenhum sinal de erro. O
resync também dispara em reconexão de canal (`SUBSCRIBED`/`CHANNEL_ERROR`/`TIMED_OUT`), em
`visibilitychange` e em `online` — cobrindo o celular que volta de segundo plano ou de uma queda de
rede.

**Fallback pra polling em pico.** O Realtime do Supabase tem um teto de 200 conexões simultâneas
por projeto no free tier — irrelevante no uso normal (grupos pequenos, horários espalhados), mas
relevante num pico raro (ex.: o app viralizar). Se o canal de UM cliente específico não conseguir
conectar (qualquer status diferente de `SUBSCRIBED`), esse cliente cai sozinho pra refetch
periódico (2s) até a lib de Realtime conseguir reconectar por conta própria — sem coordenação
global entre clientes, sem contador de conexões. Ver `useRoom.ts` (constante `FALLBACK_POLL_MS`).

`answers` fica deliberadamente fora da publicação do Realtime (ver
`20260812012126_realtime_e_integridade_de_rodada.sql`) — mesmo que a avaliação de RLS do Realtime
tivesse alguma falha, o palpite de outro jogador nunca sairia do banco com a rodada aberta.

## Quem decide quando avançar a rodada

Não há servidor rodando um timer. `useRoundCloser` e `useRoundAdvancer` (`src/state/`) fazem o
host chamar `close_round`/`start_round` no momento certo (todo mundo ativo respondeu, ou o tempo
acabou; ou a pausa de revelação terminou). Qualquer outro membro da sala dispara a mesma chamada
com um atraso aleatório (800–2300ms) como rede de segurança caso o host tenha fechado a aba — sem
isso, o host sumir travaria a partida para sempre. As duas funções RPC são idempotentes (fechar ou
avançar de novo é no-op) e o servidor recusa a chamada se o tempo real ainda não tiver passado
(`round_time_over`, `pause_in_progress`) — o cliente só é o gatilho, a validação de tempo é sempre
do lado do banco.

## Relógio do cliente

Um `setInterval` de UI não pode confiar no relógio local puro (deriva, NTP, aba em segundo plano
estrangulando o timer). `src/lib/clock.ts` mede o offset entre o relógio do servidor
(`server_now()`) e `performance.now()` uma vez por load e recalcula o tempo restante a cada tick a
partir de `ends_at`, nunca decrementando um contador — evita acumular erro e evita que a UI mostre
um cronômetro que diverge do que o servidor vai de fato validar.

## Por que não há framework de UI pronto

Ver `CLAUDE.md`, regra 5: nenhum componente de biblioteca pronta (shadcn/ui, MUI, Chakra) entra no
projeto — todo componente em `src/components/` é escrito à mão contra os tokens de
`.claude/skills/achometro-design/`.
