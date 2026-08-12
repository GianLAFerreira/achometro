-- Achômetro — hardening encontrado pelo rls-auditor na revisão da Fase 3.
--
-- O Supabase concede TRUNCATE, REFERENCES, TRIGGER e MAINTAIN a `anon` e
-- `authenticated` por padrão em toda tabela (`ALTER DEFAULT PRIVILEGES`
-- da própria plataforma) — não é nada que este projeto tenha pedido.
-- Nenhum desses privilégios é usado pelo app (escrita passa só pelas
-- funções SECURITY DEFINER; leitura é SELECT), e RLS NÃO filtra TRUNCATE
-- — é uma limitação conhecida do Postgres, não um bug daqui. Confirmado
-- na auditoria: `truncate public.answers` funciona hoje para qualquer
-- `authenticated` sem vínculo nenhum com nenhuma sala.
--
-- Não achamos caminho de exploração pela superfície real do app — o
-- PostgREST só traduz REST em SELECT/INSERT/UPDATE/DELETE, não existe
-- verbo que gere TRUNCATE. Ainda assim, "RLS nega por padrão, abre só o
-- necessário" (regra 3 do CLAUDE.md) vale para GRANT também: revoga
-- agora, antes que algum caminho futuro (SQL dinâmico, função nova) torne
-- isso explorável.

revoke truncate, references, trigger, maintain on
  public.rooms, public.players, public.rounds, public.answers,
  public.question_seen, public.questions
from anon, authenticated;

-- Mesma revogação como padrão para qualquer tabela nova criada por
-- `postgres` neste schema — sem isso, a próxima `create table` reabre o
-- mesmo buraco silenciosamente.
alter default privileges for role postgres in schema public
  revoke truncate, references, trigger, maintain on tables from anon, authenticated;
