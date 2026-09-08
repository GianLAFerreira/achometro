-- Achômetro — observabilidade: registro de erro do cliente pra consulta manual, não analytics.
--
-- Contexto: erros do jogo em si (raise exception das funções RPC, RLS negando algo, erro de
-- query) já ficam visíveis no painel do Supabase (Logs → Postgres/API), sem precisar de nada
-- daqui — essa parte já existia. O que faltava é o erro que só acontece no NAVEGADOR do jogador
-- (React quebrando, promise sem .catch) — hoje ele só aparece pro jogador (ErrorBoundary) e
-- some, sem ninguém saber que aconteceu.
--
-- Isto NÃO é analytics de terceiro (regra 8 do CLAUDE.md continua valendo: nenhum SDK externo,
-- nenhum pixel, nenhuma chamada saindo do domínio do próprio projeto) — é só uma tabela no MESMO
-- projeto Supabase que o resto do jogo já usa, gravada por uma função SECURITY DEFINER, sem
-- policy de leitura nenhuma pra `authenticated` (mesmo padrão de `questions`): só quem tem a
-- service_role key (o painel do Supabase) consegue ler.
--
-- Zero PII de propósito (regra 2): grava só `player_id` (o mesmo auth.uid() anônimo já usado em
-- toda tabela do jogo, não um dado novo), mensagem, stack, rota e user-agent — nada de nome real,
-- e-mail ou qualquer coisa que identifique a pessoa por trás da sessão anônima.
create table public.client_errors (
  id          uuid primary key default gen_random_uuid(),
  player_id   uuid,
  message     text not null,
  stack       text,
  path        text,
  user_agent  text,
  created_at  timestamptz not null default now()
);

create index client_errors_created_at_idx on public.client_errors (created_at desc);

alter table public.client_errors enable row level security;
-- Sem GRANT nenhum pra `authenticated`/`anon` e sem policy — igual `questions`. Só a função
-- abaixo (dona da tabela, SECURITY DEFINER) escreve; leitura é só via service_role (painel).

create function public.log_client_error(
  p_message text,
  p_stack text default null,
  p_path text default null,
  p_user_agent text default null
) returns void
language plpgsql
security definer
set search_path = public, pg_temp
as $$
begin
  insert into public.client_errors (player_id, message, stack, path, user_agent)
  values (
    auth.uid(),
    left(p_message, 2000),
    left(p_stack, 4000),
    left(p_path, 200),
    left(p_user_agent, 300)
  );
end;
$$;

revoke execute on function public.log_client_error(text, text, text, text) from public;
grant execute on function public.log_client_error(text, text, text, text) to authenticated;

-- Retenção de 30 dias — mesmo espírito do TTL de sala (24h), só que mais longo porque log serve
-- pra investigar depois, não pra expirar sessão de jogo.
select cron.schedule(
  'achometro-client-errors-ttl-cleanup',
  '0 3 * * *', -- uma vez por dia, 03h
  $$ delete from public.client_errors where created_at < now() - interval '30 days'; $$
);
