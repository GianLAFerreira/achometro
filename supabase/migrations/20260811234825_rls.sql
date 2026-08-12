-- Achômetro — RLS. Nega por padrão; abre só o necessário.
--
-- Modelo de identidade: todo acesso passa por login anônimo do Supabase
-- (signInAnonymously), que dá papel `authenticated` com `auth.uid()`
-- verificável e `is_anonymous = true`. Não existe papel `anon` com
-- privilégio nenhum aqui — sem sessão (mesmo anônima), zero acesso.
--
-- Regra crítica do projeto: respostas de uma rodada aberta são ilegíveis
-- por qualquer cliente. É privacidade e anti-trapaça na mesma política.
--
-- IMPORTANTE — por que os checks de pertencimento são funções e não um
-- EXISTS inline: uma policy em `players` que faz `EXISTS (select ... from
-- players ...)` dentro do próprio `USING` entra em recursão infinita — o
-- Postgres reaplica a mesma policy à subquery, que reaplica de novo, sem
-- fim, até abortar com "infinite recursion detected" (42P17). Achado por
-- auditoria adversarial nesta mesma fase. A correção documentada pelo
-- próprio Supabase é isolar o lookup numa função SECURITY DEFINER: como
-- ela roda com o privilégio do dono da tabela (que não tem RLS forçado
-- sobre si mesmo), a consulta interna não reentra na policy.

alter table public.rooms enable row level security;
alter table public.players enable row level security;
alter table public.rounds enable row level security;
alter table public.answers enable row level security;
alter table public.question_seen enable row level security;
alter table public.questions enable row level security;
-- `questions` fica sem NENHUMA política e sem GRANT nenhum: acesso zero
-- para todo mundo, inclusive authenticated. Só funções SECURITY DEFINER
-- (que rodam como o dono da tabela) conseguem ler o gabarito.

-- RLS restringe o que um GRANT já permitiu — não substitui o GRANT. Sem
-- isto, toda leitura falha com "permission denied" antes de o Postgres
-- avaliar qualquer policy (achado por auditoria adversarial nesta fase).
-- Só SELECT: toda escrita nestas 5 tabelas passa pelas funções abaixo.
grant select on
  public.rooms, public.players, public.rounds, public.answers, public.question_seen
to authenticated;

-- ─────────────────────────────────────────────────────────────────────────
-- Funções auxiliares de autorização — únicas com permissão de olhar
-- `players`/`rounds` sem passar pela RLS de novo.
-- ─────────────────────────────────────────────────────────────────────────
create function public.is_room_member(p_room_id uuid) returns boolean
language sql
security definer
stable
set search_path = public, pg_temp
as $$
  select exists (
    select 1 from public.players p
    where p.room_id = p_room_id and p.id = auth.uid()
  );
$$;

create function public.can_read_answer(p_round_id uuid) returns boolean
language sql
security definer
stable
set search_path = public, pg_temp
as $$
  select exists (
    select 1 from public.rounds r
    join public.players p on p.room_id = r.room_id
    where r.id = p_round_id
      and r.status = 'closed'
      and p.id = auth.uid()
  );
$$;

revoke execute on function public.is_room_member(uuid) from public;
revoke execute on function public.can_read_answer(uuid) from public;
grant execute on function public.is_room_member(uuid) to authenticated;
grant execute on function public.can_read_answer(uuid) to authenticated;

-- ─────────────────────────────────────────────────────────────────────────
-- rooms — visível só para quem tem uma linha em players para essa sala.
-- ─────────────────────────────────────────────────────────────────────────
create policy rooms_select_member
  on public.rooms for select
  to authenticated
  using (public.is_room_member(id));

-- Sem policy de insert/update/delete: toda escrita em `rooms` passa pelas
-- funções SECURITY DEFINER (create_room, start_round, close_round, etc.).

-- ─────────────────────────────────────────────────────────────────────────
-- players — vejo todo mundo que está na(s) mesma(s) sala(s) que eu.
-- ─────────────────────────────────────────────────────────────────────────
create policy players_select_roommates
  on public.players for select
  to authenticated
  using (public.is_room_member(room_id));

-- ─────────────────────────────────────────────────────────────────────────
-- rounds — mesma regra de "sou membro da sala". O gabarito (revealed_*)
-- fica NULL até `close_round` preencher, então esta única policy nunca
-- precisa saber se a rodada está aberta ou fechada.
-- ─────────────────────────────────────────────────────────────────────────
create policy rounds_select_member
  on public.rounds for select
  to authenticated
  using (public.is_room_member(room_id));

-- ─────────────────────────────────────────────────────────────────────────
-- answers — a política que mais importa do projeto. Duas condições, as
-- duas obrigatórias: rodada FECHADA, e eu sou membro da sala da rodada.
-- Faltando qualquer uma, a resposta de outro jogador vaza antes da hora
-- ou pra gente de fora da sala.
-- ─────────────────────────────────────────────────────────────────────────
create policy answers_select_closed_and_member
  on public.answers for select
  to authenticated
  using (public.can_read_answer(round_id));

-- ─────────────────────────────────────────────────────────────────────────
-- question_seen — não sensível (só marca "eu já vi essa pergunta"), mas
-- ainda escopado à própria pessoa. Coluna direta, sem self-join — não
-- sofre do mesmo problema de recursão das policies acima.
-- ─────────────────────────────────────────────────────────────────────────
create policy question_seen_select_own
  on public.question_seen for select
  to authenticated
  using (player_id = (select auth.uid()));
