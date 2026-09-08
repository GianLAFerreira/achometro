# Observabilidade

Onde olhar quando precisar investigar algo — três canais, cada um cobrindo uma camada diferente
do app. Nenhum é analytics de terceiro (`CLAUDE.md`, regra 8): os três são recursos do próprio
Supabase/Cloudflare que o projeto já usa, não um SDK novo rodando no navegador do jogador.

## 1. Erro de jogo (Postgres/API) — painel do Supabase

Toda regra de jogo mora em função Postgres (`CLAUDE.md`, regra 1) — então todo erro de jogo
(`raise exception` de `start_round`/`close_round`/etc., RLS negando uma leitura, erro de query)
já fica registrado sozinho, sem nenhum código deste projeto:

- Painel do Supabase → **Logs** → **Postgres Logs** (exceptions, erro de função) ou **API Logs**
  (toda chamada PostgREST/RPC, com status HTTP).
- Filtro útil: buscar pelo texto exato do `raise exception` (ex. `not_host`, `round_time_over`) —
  são as mesmas chaves traduzidas em `src/lib/errors.ts`.
- Retenção segue o plano do projeto (free tier: alguns dias) — não é pra investigação histórica
  longa, é pra "aconteceu algo estranho agora há pouco, o que foi?".

## 2. Erro do navegador do jogador — tabela `client_errors`

O que o painel acima **não** cobre: um erro que só acontece no cliente (React quebrando,
`Promise` rejeitada sem `.catch`) nunca chega a fazer uma chamada de rede que falhe — hoje ele só
aparece pro jogador (`ErrorBoundary`, tela "Algo quebrou") e não deixa rastro nenhum.

- `src/lib/clientErrorLog.ts` — `logClientError()` chama a RPC `log_client_error`;
  `installGlobalErrorLogging()` (chamada uma vez em `main.tsx`) escuta `window.onerror` e
  `unhandledrejection`. `ErrorBoundary.tsx` também chama `logClientError` direto no
  `componentDidCatch` (cobre erro de render, que os listeners globais não pegam).
- Nunca lança um erro novo se o próprio log falhar (ex. sessão anônima ainda não resolveu) —
  perder um log é aceitável, piorar a tela por causa dele não é.
- **Como consultar**: tabela `public.client_errors` só é legível com a `service_role key` — via
  Table Editor do painel do Supabase, ou SQL Editor (`select * from client_errors order by
  created_at desc`). RLS está ligado e **sem nenhuma policy** (mesmo padrão de `questions`) — o
  próprio cliente do jogo nunca consegue ler essa tabela, só escrever através da função.
- Sem PII de propósito (regra 2): guarda `player_id` (o mesmo `auth.uid()` anônimo de sempre,
  não um dado novo), mensagem, stack, rota (`path`) e user-agent — nada que identifique a pessoa
  por trás da sessão.
- TTL de 30 dias via `pg_cron` (`achometro-client-errors-ttl-cleanup`).

## 3. Tráfego e erro do site estático — Cloudflare Workers Logs

O deploy é um Worker servindo assets estáticos (ver `CLAUDE.md`, linha do Stack) — não roda
lógica de jogo nenhuma, mas ainda vale saber se uma rota está devolvendo 4xx/5xx ou se o build
publicado está sendo servido.

- Painel da Cloudflare → Workers & Pages → `achometro` → aba **Logs** (tempo real) — precisa estar
  **habilitado** (Settings do Worker → Observability → Logs), não vem ligado por padrão.
- Alternativa via terminal: `npx wrangler tail` (streaming ao vivo; não precisa de código novo).
- Cobre só a camada de entrega de arquivo estático — erro de jogo (canal 1) e erro de cliente
  (canal 2) não aparecem aqui.
