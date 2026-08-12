-- Achômetro — Fase 3: liga o Realtime (não emitia nada até agora — nenhuma
-- migration anterior tinha `alter publication`) e corrige duas falhas de
-- integridade encontradas na revisão adversarial do desenho do cliente.

-- ─────────────────────────────────────────────────────────────────────────
-- Publicação supabase_realtime — idempotente, para `db reset` local e
-- `db push` no cloud se comportarem igual (`alter publication ... add
-- table` dá erro se a tabela já estiver na publicação).
--
-- `answers` fica deliberadamente FORA. Defesa em profundidade da regra 4
-- do CLAUDE.md: mesmo que a avaliação de RLS do Realtime tivesse alguma
-- falha, o valor do palpite de outro jogador nunca sairia do banco com a
-- rodada aberta. Incluir a tabela também não traria funcionalidade nenhuma
-- — a policy `can_read_answer` nega com a rodada aberta e o evento seria
-- suprimido do mesmo jeito. Quem quiser ler `answers`, lê por SELECT
-- normal depois que a rodada fecha.
-- ─────────────────────────────────────────────────────────────────────────
do $$
begin
  if not exists (
    select 1 from pg_publication_tables
    where pubname = 'supabase_realtime' and schemaname = 'public' and tablename = 'rooms'
  ) then
    alter publication supabase_realtime add table public.rooms;
  end if;

  if not exists (
    select 1 from pg_publication_tables
    where pubname = 'supabase_realtime' and schemaname = 'public' and tablename = 'players'
  ) then
    alter publication supabase_realtime add table public.players;
  end if;

  if not exists (
    select 1 from pg_publication_tables
    where pubname = 'supabase_realtime' and schemaname = 'public' and tablename = 'rounds'
  ) then
    alter publication supabase_realtime add table public.rounds;
  end if;
end;
$$;

-- Sem `replica identity full` em nenhuma tabela — deliberado, não
-- esquecido. Verificado no banco local (`realtime.build_prepared_statement_sql`):
-- o Realtime avalia RLS reconsultando a linha viva por PRIMARY KEY, não a
-- partir das colunas do WAL. `full` só populariza a tupla *antiga* de um
-- UPDATE, que este projeto não usa em nenhuma policy, e amplia o predicado
-- de checagem para todas as colunas — mais WAL, mais lento, sem ganho
-- nenhum aqui. Se um dia uma policy passar a depender de valor antigo,
-- essa é a linha para revisar antes de mudar o padrão.

-- ─────────────────────────────────────────────────────────────────────────
-- answers_count — contador em `rounds`, mantido por trigger (nunca pelo
-- corpo de `submit_answer`) para que não exista caminho de escrita que o
-- deixe divergir da contagem real. É o que permite a UI mostrar "3 de 6
-- cravaram" sem `answers` estar na publicação Realtime: vaza quantidade,
-- nunca valor.
-- ─────────────────────────────────────────────────────────────────────────
alter table public.rounds add column answers_count integer not null default 0;

create function public.increment_round_answers_count() returns trigger
language plpgsql
security definer
set search_path = public, pg_temp
as $$
begin
  update public.rounds set answers_count = answers_count + 1 where id = new.round_id;
  return new;
end;
$$;

create trigger answers_count_increment
  after insert on public.answers
  for each row execute function public.increment_round_answers_count();

-- ─────────────────────────────────────────────────────────────────────────
-- submit_answer — corrige corrida real: a versão original lia `rounds`
-- sem lock, enquanto `close_round` lê com `for update`. Um submit podia
-- passar a validação (`open`, dentro do prazo) e só inserir depois que
-- `close_round` já tinha pontuado e fechado a rodada sem ver esse insert —
-- o palpite entrava no banco e nunca recebia pontos. A janela é o último
-- segundo, exatamente quando todo mundo responde. `for update` (não `for
-- share`, que causaria deadlock no upgrade de lock entre dois submits
-- concorrentes) faz o segundo transactor bloquear e, ao herdar o lock,
-- reavaliar a linha (EvalPlanQual) e ver `status = 'closed'` de verdade.
--
-- Também mapeia palpite duplicado para um erro nomeado em vez de deixar
-- vazar o `23505` cru do Postgres.
-- ─────────────────────────────────────────────────────────────────────────
create or replace function public.submit_answer(
  p_round_id uuid,
  p_value numeric
) returns public.answers
language plpgsql
security definer
set search_path = public, pg_temp
as $$
declare
  v_round public.rounds;
  v_answer public.answers;
begin
  if auth.uid() is null then
    raise exception 'auth_required';
  end if;

  select * into v_round from public.rounds where id = p_round_id for update;
  if v_round.id is null then
    raise exception 'round_not_found';
  end if;
  if v_round.status <> 'open' then
    raise exception 'round_closed';
  end if;
  if now() >= v_round.ends_at then
    raise exception 'round_time_over';
  end if;
  if not exists (
    select 1 from public.players where room_id = v_round.room_id and id = auth.uid()
  ) then
    raise exception 'not_in_room';
  end if;

  begin
    insert into public.answers (round_id, player_id, value)
    values (p_round_id, auth.uid(), p_value)
    returning * into v_answer;
  exception when unique_violation then
    raise exception 'already_answered';
  end;

  return v_answer;
end;
$$;

-- ─────────────────────────────────────────────────────────────────────────
-- close_round — corrige o segundo furo: antes só o host fechava e a
-- função não validava `ends_at`, então o cliente do host era a única
-- autoridade sobre "já pode fechar?" (tangenciava a regra 1 do CLAUDE.md
-- — regra de jogo mora em função Postgres, nunca no cliente). Se o host
-- perdesse conexão ou fechasse a aba, a partida morria sem jeito de
-- continuar.
--
-- Agora: o host fecha a qualquer momento (para permitir "revelar agora"
-- antes do tempo esgotar); qualquer outro membro da sala só consegue
-- fechar depois de `ends_at`. Isso não enfraquece a regra, reforça —
-- o servidor passa a validar tempo no fechamento; o cliente vira gatilho,
-- nunca autoridade. Resto do corpo é idêntico ao original (idempotente,
-- pontuação por erro relativo).
-- ─────────────────────────────────────────────────────────────────────────
create or replace function public.close_round(
  p_round_id uuid
) returns public.rounds
language plpgsql
security definer
set search_path = public, pg_temp
as $$
declare
  v_round public.rounds;
  v_room public.rooms;
  v_question public.questions;
begin
  if auth.uid() is null then
    raise exception 'auth_required';
  end if;

  select * into v_round from public.rounds where id = p_round_id for update;
  if v_round.id is null then
    raise exception 'round_not_found';
  end if;

  select * into v_room from public.rooms where id = v_round.room_id;

  if v_room.host_player_id <> auth.uid() then
    if now() < v_round.ends_at then
      raise exception 'not_host';
    end if;
    if not exists (
      select 1 from public.players where room_id = v_room.id and id = auth.uid()
    ) then
      raise exception 'not_in_room';
    end if;
  end if;

  if v_round.status = 'closed' then
    return v_round; -- idempotente
  end if;

  select * into v_question from public.questions where id = v_round.question_id;

  with ranked as (
    select
      a.player_id,
      case when v_question.answer = 0 then abs(a.value)
           else abs(a.value - v_question.answer) / abs(v_question.answer)
      end as erro_relativo,
      row_number() over (
        order by
          case when v_question.answer = 0 then abs(a.value)
               else abs(a.value - v_question.answer) / abs(v_question.answer)
          end asc,
          a.submitted_at asc
      ) as posicao
    from public.answers a
    where a.round_id = p_round_id
  ),
  scored as (
    select
      player_id,
      (case posicao
         when 1 then 100 when 2 then 70 when 3 then 50
         when 4 then 30 when 5 then 20 when 6 then 10
         else 0
       end
       + case when erro_relativo < 0.05 then 50 else 0 end
      ) as points
    from ranked
  )
  update public.players p
  set score = p.score + s.points
  from scored s
  where p.room_id = v_room.id and p.id = s.player_id;

  update public.rounds
  set status = 'closed',
      closed_at = now(),
      revealed_answer = v_question.answer,
      revealed_source_name = v_question.source_name,
      revealed_source_url = v_question.source_url,
      revealed_as_of_year = v_question.as_of_year
  where id = p_round_id
  returning * into v_round;

  if v_round.index + 1 >= v_room.rounds_total then
    update public.rooms set status = 'finished' where id = v_room.id;
  end if;

  return v_round;
end;
$$;

-- ─────────────────────────────────────────────────────────────────────────
-- server_now — o cliente usa isto uma vez no boot pra medir o offset entre
-- o relógio dele e o do servidor (âncora em `performance.now()`, nunca
-- confia no relógio de parede local pro cronômetro da rodada). Não expõe
-- nada sensível; existe só para não deixar `anon` chamar (que aqui não tem
-- privilégio nenhum de qualquer forma).
-- ─────────────────────────────────────────────────────────────────────────
create function public.server_now() returns timestamptz
language sql
stable
as $$
  select now();
$$;

revoke execute on function public.server_now() from public;
grant execute on function public.server_now() to authenticated;
