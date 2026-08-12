-- Achômetro — tela de configuração de sala: pontuação-alvo pra vencer
-- (default 5, personalizável), expõe pause_seconds como parâmetro de
-- create_room (já existia como coluna, nunca tinha sido configurável no
-- cliente), e a 4ª via de fim de partida em close_round.
--
-- Pontuação-alvo e número de rodadas (rounds_total, já existente)
-- convivem — a sala termina no que vier primeiro, decisão do usuário.

alter table public.rooms add column target_score smallint not null default 5
  check (target_score >= 1 and target_score <= 100);

-- ─────────────────────────────────────────────────────────────────────────
-- create_room — muda de assinatura (4 → 6 parâmetros). Em Postgres isso
-- cria um OVERLOAD novo, não substitui o antigo — a assinatura de 4
-- parâmetros continuaria existindo e colidiria com o PostgREST resolvendo
-- por nome (ambiguidade). Precisa dropar a assinatura antiga antes de
-- criar a nova, e reemitir revoke/grant pra assinatura nova (grants são
-- por assinatura, não por nome).
-- ─────────────────────────────────────────────────────────────────────────
drop function public.create_room(text, text[], smallint, smallint);

create function public.create_room(
  p_nickname text,
  p_themes text[] default '{}',
  p_rounds_total smallint default 10,
  p_answer_seconds smallint default 20,
  p_pause_seconds smallint default 10,
  p_target_score smallint default 5
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
      insert into public.rooms (
        code, host_player_id, themes, rounds_total, answer_seconds, pause_seconds, target_score
      )
      values (
        v_code, auth.uid(), coalesce(p_themes, '{}'), p_rounds_total, p_answer_seconds,
        p_pause_seconds, p_target_score
      )
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

revoke execute on function public.create_room(text, text[], smallint, smallint, smallint, smallint) from public;
grant execute on function public.create_room(text, text[], smallint, smallint, smallint, smallint) to authenticated;

-- ─────────────────────────────────────────────────────────────────────────
-- close_round — preserva sem tocar as 3 vias existentes e todo o resto do
-- corpo já auditado (autorização host/prazo, lock, cálculo de pontos por
-- erro relativo, incremento de missed_streak). Acrescenta a 4ª via, entre
-- a do sobrevivente único e a de última rodada: pontuação-alvo atingida
-- por um único líder estrito. Empate no topo não dispara esta via de
-- propósito (v_leaders_count > 1) — a partida segue pra próxima rodada
-- até desempatar, decisão do usuário.
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
  v_total_players int;
  v_active_players int;
  v_sole_survivor uuid;
  v_max_score int;
  v_leaders_count int;
  v_target_winner uuid;
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

  with erros as (
    select
      a.player_id,
      a.value,
      case when v_question.answer = 0 then abs(a.value)
           else abs(a.value - v_question.answer) / abs(v_question.answer)
      end as erro_relativo
    from public.answers a
    where a.round_id = p_round_id
  ),
  melhor as (
    select min(erro_relativo) as erro_minimo from erros
  ),
  scored as (
    select
      e.player_id,
      case when e.value = v_question.answer then 2 else 1 end as points
    from erros e
    join melhor m on e.erro_relativo = m.erro_minimo
  )
  update public.players p
  set score = p.score + s.points
  from scored s
  where p.room_id = v_room.id and p.id = s.player_id;

  update public.players p
  set missed_streak = p.missed_streak + 1
  where p.room_id = v_room.id
    and not exists (
      select 1 from public.answers a
      where a.round_id = p_round_id and a.player_id = p.id
    );

  update public.rounds
  set status = 'closed',
      closed_at = now(),
      revealed_answer = v_question.answer,
      revealed_source_name = v_question.source_name,
      revealed_source_url = v_question.source_url,
      revealed_as_of_year = v_question.as_of_year
  where id = p_round_id
  returning * into v_round;

  select count(*) into v_total_players from public.players where room_id = v_room.id;
  select count(*) into v_active_players
    from public.players where room_id = v_room.id and missed_streak < 2;
  select max(score) into v_max_score from public.players where room_id = v_room.id;
  select count(*) into v_leaders_count
    from public.players where room_id = v_room.id and score = v_max_score;

  if v_active_players = 0 then
    update public.rooms set status = 'abandoned' where id = v_room.id;
  elsif v_active_players = 1 and v_total_players > 1 then
    select id into v_sole_survivor
      from public.players where room_id = v_room.id and missed_streak < 2;
    update public.rooms
      set status = 'finished', winner_player_id = v_sole_survivor
      where id = v_room.id;
  elsif v_leaders_count = 1 and v_max_score >= v_room.target_score then
    select id into v_target_winner
      from public.players where room_id = v_room.id and score = v_max_score;
    update public.rooms
      set status = 'finished', winner_player_id = v_target_winner
      where id = v_room.id;
  elsif v_round.index + 1 >= v_room.rounds_total then
    update public.rooms set status = 'finished' where id = v_room.id;
  end if;

  return v_round;
end;
$$;
