# Achômetro

Jogo de palpite numérico multiplayer, web, anônimo. Sala com código, host configura tema e
rodadas, cada jogador palpita um número, quem chega mais perto pontua.

Plano completo: `C:\Users\gianf\.claude\plans\queriar-um-aplicativo-iremos-nifty-aho.md`

## Stack e por quê (não sugerir trocar sem reler isto)

| Peça | Escolha | Motivo |
|---|---|---|
| UI | Vite + React + TypeScript | SPA estática, build rápido, deploy grátis. |
| Estilo | Tailwind CSS v4 | Velocidade sem CSS solto. |
| Animação | Motion (`motion/react`) | O mostrador e as transições de rodada. |
| Estado local | Zustand | Leve; o estado que importa é o do servidor. |
| Banco + Realtime | Supabase (Postgres + Realtime + RLS) | Free tier cobre a escala alvo (~50 pessoas). |
| Lógica de jogo | Funções Postgres (RPC, `SECURITY DEFINER`) | Estado autoritativo sem manter servidor ligado. |
| Limpeza | pg_cron | TTL de salas/respostas (24h). |
| Deploy | Cloudflare Pages | Estático, grátis, sem cold start. |

## Regras que não se quebram

1. **Regra de jogo mora em função Postgres, nunca no cliente.** Se der vontade de calcular
   pontuação ou validar tempo no React, a resposta é não.
2. **Zero PII.** Nada de e-mail, senha, telefone, OAuth, nome real. `player_id` é o `auth.uid()`
   de uma sessão de **login anônimo do Supabase** (`signInAnonymously`) — não um UUID inventado no
   cliente. Correção feita durante a Fase 1: sem alguma forma de identidade verificável, o RLS não
   tem como distinguir "sua sala" de "sala de outra pessoa" em nenhuma leitura, só nas escritas via
   RPC. Login anônimo dá um `auth.uid()` real e verificável sem exigir e-mail, senha ou qualquer
   dado pessoal — a sessão persiste via token que o próprio SDK guarda no `localStorage`, mesma
   propriedade prática do plano original (limpar o navegador = virar outra pessoa).
3. **RLS nega por padrão.** Toda tabela nova nasce fechada; abrir só o necessário.
4. **`answers` de uma rodada aberta é ilegível por qualquer cliente.** Isso é privacidade e
   anti-trapaça na mesma regra. Testar sempre que essa política for tocada.
5. **Tokens de design são lei.** Ver skill `achometro-design` — cor, fonte e raio fora dos tokens
   não entram. Nenhum componente de UI pronto: nada de shadcn/ui, MUI, Chakra ou similar — kit
   pronto traz o default de "cara de IA" embutido.
6. **Sem LLM em runtime.** As perguntas vêm do banco curado (`supabase/seed.sql`), não de chamada
   de API durante o jogo.
7. **Redação de pergunta segue a skill `achometro-perguntas`.** Forma (âncora + pergunta), o
   critério de "divertida" e as convenções de `unit`/`theme`/`difficulty` moram lá, não na
   memória de quem escreve. Curadoria de fonte (qual usar quando agregadores divergem) mora no
   agent `curador-perguntas`, não na skill.
8. **Sem analytics de terceiro, sem font CDN, sem pixel de rastreio.** Fontes self-hosted via
   `@fontsource`.
9. **Nunca editar uma migration já aplicada.** Corrigir é criar uma migration nova — é como o
   Supabase rastreia estado.

## Comandos

Supabase CLI é devDependency do projeto (não global) — caminho recomendado pelo próprio Supabase
para Node. Sempre via `npm run`, nunca instalar `supabase` global no sistema.

```
npm run dev              # servidor de desenvolvimento Vite
npm run build             # build de produção
npm run db:start           # sobe Postgres + Realtime local no Docker (exige Docker Desktop ligado)
npm run db:stop            # derruba os containers locais
npm run db:reset           # reaplica migrations + seed do zero
npm run db:status          # mostra URLs/chaves do ambiente local
npm run test:e2e           # Playwright, multiplayer com contextos paralelos (a partir da Fase 3)
```

## Mapa de pastas

- `supabase/migrations/` — schema e RPCs, uma migration por mudança, nunca editadas depois de
  aplicadas.
- `supabase/seed.sql` — banco de perguntas curadas (prompt, gabarito, fonte, ano).
- `src/` — cliente React. Estado de servidor via Supabase Realtime + RPC; Zustand só para estado
  de UI local (não duplicar estado do servidor).

## Segredos

O único segredo real é a `service_role key` do Supabase — **nunca entra neste repositório**, vive
só no painel do Supabase. A `anon key` é pública por design; quem protege o banco é a RLS, não a
chave. Ver `.gitignore` e `.claudeignore`.
