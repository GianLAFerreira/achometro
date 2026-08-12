-- Achômetro — funções de jogo (RPC), todas SECURITY DEFINER.
--
-- Regra do projeto: regra de jogo mora aqui, nunca no cliente. Toda função
-- usa auth.uid() internamente — nunca um player_id vindo como parâmetro —
-- porque um parâmetro pode ser forjado pelo chamador, auth.uid() não pode
-- (vem do JWT verificado da sessão anônima).
--
-- `set search_path = public, pg_temp` em cada função: prática obrigatória
-- para SECURITY DEFINER, senão um search_path malicioso na sessão do
-- chamador poderia redirecionar a função para objetos de outro schema.

-- ─────────────────────────────────────────────────────────────────────────
-- create_room
-- ─────────────────────────────────────────────────────────────────────────
create function public.create_room(
  p_nickname text,
  p_themes text[] default '{}',
  p_rounds_total smallint default 10,
  p_answer_seconds smallint default 45
) returns public.rooms
language plpgsql
security definer
set search_path = public, pg_temp
as $$
declare
  v_room public.rooms;
  v_code text;
  v_alphabet text := 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789'; -- sem O/0, I/1 — evita confusão ao ditar em voz alta
  v_attempt int;
begin
  if auth.uid() is null then
    raise exception 'auth_required';
  end if;

  for v_attempt in 1..20 loop
    v_code := (
      select string_agg(substr(v_alphabet, (random() * length(v_alphabet))::int + 1, 1), '')
      from generate_series(1, 6)
    );
    begin
      insert into public.rooms (code, host_player_id, themes, rounds_total, answer_seconds)
      values (v_code, auth.uid(), coalesce(p_themes, '{}'), p_rounds_total, p_answer_seconds)
      returning * into v_room;
      exit;
    exception when unique_violation then
      -- código colidiu (raríssimo em 33^6 possibilidades) — tenta outro
      continue;
    end;
  end loop;

  if v_room.id is null then
    raise exception 'could_not_allocate_room_code';
  end if;

  insert into public.players (id, room_id, nickname)
  values (auth.uid(), v_room.id, p_nickname);

  return v_room;
end;
$$;

-- ─────────────────────────────────────────────────────────────────────────
-- join_room — idempotente: entrar de novo na mesma sala só atualiza o
-- apelido e o last_seen_at, não duplica a linha.
-- ─────────────────────────────────────────────────────────────────────────
create function public.join_room(
  p_room_code text,
  p_nickname text
) returns public.rooms
language plpgsql
security definer
set search_path = public, pg_temp
as $$
declare
  v_room public.rooms;
begin
  if auth.uid() is null then
    raise exception 'auth_required';
  end if;

  select * into v_room from public.rooms where code = upper(p_room_code);

  if v_room.id is null then
    raise exception 'room_not_found';
  end if;
  if v_room.status = 'finished' then
    raise exception 'room_finished';
  end if;

  insert into public.players (id, room_id, nickname)
  values (auth.uid(), v_room.id, p_nickname)
  on conflict (room_id, id) do update
    set nickname = excluded.nickname, last_seen_at = now();

  return v_room;
end;
$$;

-- ─────────────────────────────────────────────────────────────────────────
-- start_round — só o host. Escolhe a pergunta que ninguém na sala já viu;
-- se o pool esgotou, cai para a pergunta vista por menos gente da sala em
-- vez de travar a partida (degradação obrigatória do plano).
-- ─────────────────────────────────────────────────────────────────────────
create function public.start_round(
  p_room_id uuid
) returns public.rounds
language plpgsql
security definer
set search_path = public, pg_temp
as $$
declare
  v_room public.rooms;
  v_question public.questions;
  v_round public.rounds;
  v_next_index smallint;
begin
  if auth.uid() is null then
    raise exception 'auth_required';
  end if;

  select * into v_room from public.rooms where id = p_room_id for update;
  if v_room.id is null then
    raise exception 'room_not_found';
  end if;
  if v_room.host_player_id <> auth.uid() then
    raise exception 'not_host';
  end if;
  if exists (select 1 from public.rounds where room_id = p_room_id and status = 'open') then
    raise exception 'round_already_open';
  end if;

  select coalesce(max(index), -1) + 1 into v_next_index
  from public.rounds where room_id = p_room_id;

  if v_next_index >= v_room.rounds_total then
    update public.rooms set status = 'finished' where id = p_room_id;
    raise exception 'rounds_complete';
  end if;

  -- caminho principal: pergunta aprovada, do tema da sala, que ninguém
  -- atualmente na sala já viu.
  select q.* into v_question
  from public.questions q
  where q.status = 'approved'
    and (v_room.themes = '{}' or q.theme = any(v_room.themes))
    and not exists (
      select 1 from public.question_seen qs
      join public.players p on p.id = qs.player_id
      where qs.question_id = q.id and p.room_id = p_room_id
    )
  order by random()
  limit 1;

  -- degradação: pool esgotado pra esta sala — pega a pergunta vista por
  -- menos gente da sala, em vez de travar a partida.
  if v_question.id is null then
    select q.* into v_question
    from public.questions q
    where q.status = 'approved'
      and (v_room.themes = '{}' or q.theme = any(v_room.themes))
    order by (
      select count(*) from public.question_seen qs
      join public.players p on p.id = qs.player_id
      where qs.question_id = q.id and p.room_id = p_room_id
    ) asc, random()
    limit 1;
  end if;

  if v_question.id is null then
    raise exception 'no_questions_available';
  end if;

  insert into public.rounds (
    room_id, question_id, index, question_prompt, question_unit, question_theme,
    ends_at
  ) values (
    p_room_id, v_question.id, v_next_index, v_question.prompt, v_question.unit, v_question.theme,
    now() + (v_room.answer_seconds * interval '1 second')
  ) returning * into v_round;

  insert into public.question_seen (player_id, question_id)
  select p.id, v_question.id from public.players p where p.room_id = p_room_id
  on conflict do nothing;

  update public.rooms set status = 'playing' where id = p_room_id and status = 'lobby';

  return v_round;
end;
$$;

-- ─────────────────────────────────────────────────────────────────────────
-- submit_answer — a PK composta (round_id, player_id) de `answers` rejeita
-- naturalmente uma segunda tentativa com unique_violation.
-- ─────────────────────────────────────────────────────────────────────────
create function public.submit_answer(
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

  select * into v_round from public.rounds where id = p_round_id;
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

  insert into public.answers (round_id, player_id, value)
  values (p_round_id, auth.uid(), p_value)
  returning * into v_answer;

  return v_answer;
end;
$$;

-- ─────────────────────────────────────────────────────────────────────────
-- close_round — só o host. Idempotente (fechar de novo retorna a rodada já
-- fechada em vez de pontuar duas vezes). Erro relativo é a mesma matemática
-- da escala logarítmica do mostrador — ver skill achometro-design.
-- ─────────────────────────────────────────────────────────────────────────
create function public.close_round(
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
    raise exception 'not_host';
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
-- Privilégios: ninguém executa por padrão; só quem tem sessão (anônima ou
-- não) via o papel `authenticated`.
-- ─────────────────────────────────────────────────────────────────────────
revoke execute on function public.create_room(text, text[], smallint, smallint) from public;
revoke execute on function public.join_room(text, text) from public;
revoke execute on function public.start_round(uuid) from public;
revoke execute on function public.submit_answer(uuid, numeric) from public;
revoke execute on function public.close_round(uuid) from public;

grant execute on function public.create_room(text, text[], smallint, smallint) to authenticated;
grant execute on function public.join_room(text, text) to authenticated;
grant execute on function public.start_round(uuid) to authenticated;
grant execute on function public.submit_answer(uuid, numeric) to authenticated;
grant execute on function public.close_round(uuid) to authenticated;
