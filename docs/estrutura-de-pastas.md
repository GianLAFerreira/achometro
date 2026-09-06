# Estrutura de pastas

```
achometro/
├── src/                  cliente React
│   ├── components/       peças de UI sem estado de servidor
│   ├── screens/          as duas telas da rota (Home, Sala)
│   ├── state/            hooks que ligam Supabase (Realtime + RPC) ao React
│   ├── lib/               utilitários sem JSX: sessão, RPC, roteador, relógio, formatação...
│   └── types/            tipos gerados (database.ts) + vite-env.d.ts
├── supabase/
│   ├── migrations/        schema e RPCs, uma migration por mudança, nunca editada depois de aplicada
│   ├── seed.sql            lote inicial de perguntas (misto de temas, usado no primeiro playtest)
│   ├── seeds/               famílias/lotes de perguntas por tema, carregadas via glob por seed.sql
│   └── config.toml         config do projeto Supabase local (Docker)
├── .claude/
│   ├── agents/             agentes especializados (curador-perguntas, rls-auditor, achometro-ui)
│   └── skills/              skills carregadas sob demanda (achometro-design, achometro-perguntas)
├── docs/                   esta pasta
├── public/                  estáticos servidos direto (favicon etc.)
├── CLAUDE.md                regras do projeto, stack e porquês — autoridade de produto
└── README.md                 apresentação curta do projeto
```

## `src/components/`

Peças de UI reutilizáveis, sem acesso direto a Supabase — recebem dados prontos via props. Nomes
já dizem o papel de cada uma:

| Componente | Papel |
|---|---|
| `Button.tsx` / `buttonStyles.ts` | Botão e as variantes de estilo compartilhadas por ele e por `TopicSelect`. |
| `TextField.tsx` / `NumberField.tsx` | Campos de formulário (apelido, código de sala, palpite). |
| `TopicSelect.tsx` | Seletor de múltipla escolha de temas na configuração de sala. |
| `RoomConfigForm.tsx` | Formulário do host: temas, rodadas, tempo de resposta, pausa, pontuação-alvo → chama `createRoom`. |
| `Lobby.tsx` | Tela de espera antes da 1ª rodada — lista de jogadores, botão de início (host). |
| `RoundOpen.tsx` | Rodada aberta: pergunta, campo de palpite, cronômetro. |
| `Countdown.tsx` | Anel de cronômetro usado dentro de `RoundOpen`. |
| `RoundReveal.tsx` | Revelação do gabarito e pontuação da rodada. |
| `Mostrador.tsx` | O mostrador logarítmico (agulha) que compara palpites ao gabarito na revelação. |
| `Scoreboard.tsx` | Placar ao vivo entre rodadas. |
| `Podium.tsx` | Pódio animado de fim de partida. |
| `Note.tsx` | Texto de aviso/erro com a voz do aparelho (ver skill `achometro-design`). |
| `ErrorBoundary.tsx` | Boundary de erro do React, topo da árvore em `App.tsx`. |

## `src/screens/`

- `HomeScreen.tsx` — landing: criar sala (`RoomConfigForm`) ou entrar com código.
- `RoomScreen.tsx` — orquestra qual componente mostrar dentro de uma sala (`Lobby` / `RoundOpen` /
  `RoundReveal` / `Podium` / `Scoreboard`) a partir do `RoomState` de `useRoom`.

## `src/state/`

Hooks que conectam o React ao estado do servidor. Zustand entra só para estado de UI local — não
duplicar aqui o que o servidor já é dono (regra do `CLAUDE.md`).

- `useRoom.ts` — hook mestre de uma sala: resolve o código da URL, assina o canal Realtime da sala
  e trata todo evento como invalidação (refaz o fetch), nunca como payload aplicado direto.
- `useRoundAdvancer.ts` — dispara `start_round` sozinho depois da pausa de revelação.
- `useRoundCloser.ts` — dispara `close_round` quando todo mundo ativo respondeu ou o tempo acaba.
- `useNickname.ts` — apelido preferido, persistido no navegador (não é a fonte de verdade do
  apelido *da sala* — essa é `players.nickname`, lido via `useRoom`).

Em ambos os hooks de avanço/fechamento automático: o host dispara direto, qualquer outro membro
dispara com um atraso aleatório como rede de segurança se o host sumir — e o servidor, não o
cliente, é quem decide se a ação é válida (idempotência e checagem de tempo moram na função RPC).

## `src/lib/`

- `supabase.ts` — cliente Supabase (URL + anon key das env vars).
- `session.ts` — `ensureSession()`: garante login anônimo, memoizado por load de página.
- `rpc.ts` — wrappers tipados das funções RPC (`create_room`, `join_room`, `peek_room`,
  `start_round`, `submit_answer`, `close_round`, `server_now`).
- `router.ts` — roteador escrito à mão (duas rotas: `/` e `/sala/:code`) via History API.
- `clock.ts` — sincronização de relógio servidor↔cliente e `useCountdown`.
- `errors.ts` — traduz o texto de `raise exception` do Postgres para a mensagem que aparece na UI.
- `format.ts` — formatação/parsing de número inteiro para o palpite e o gabarito.
- `motion.ts` — presets de animação (Motion) compartilhados pelos componentes.
- `haptics.ts` — feedback tátil (vibração) em mobile.
- `topics.ts` — taxonomia fixa de `theme`, fonte única do lado do cliente (espelha o comentário no
  topo de `supabase/seed.sql`).

## `supabase/`

- `migrations/` — cada arquivo é uma mudança de schema ou de função RPC, nomeado
  `<timestamp>_<descrição>.sql`. Ver [`banco-de-dados.md`](./banco-de-dados.md) para o que cada uma
  contém hoje.
- `seed.sql` — carrega o lote inicial de perguntas e, via glob, todo arquivo em `seeds/`.
- `seeds/futebol_0N.sql` — famílias/lotes de perguntas do tema `futebol`, cada uma com header
  comentado explicando fonte e descartes. Ver a skill `achometro-perguntas` e o agente
  `curador-perguntas` para o processo de escrever uma nova.

## `.claude/`

- `agents/curador-perguntas.md` — valida pergunta candidata contra os 4 critérios de aceite antes
  de entrar no seed.
- `agents/rls-auditor.md` — auditoria adversarial de RLS/RPC antes de deploy público.
- `agents/achometro-ui.md` — revisão de UI/CSS/copy contra os tokens do design system.
- `skills/achometro-design/` — tokens de design, tipografia, o mostrador logarítmico, proibições.
- `skills/achometro-perguntas/` — forma da pergunta (âncora), régua de "divertida", convenções de
  `unit`/`theme`/`difficulty`.
