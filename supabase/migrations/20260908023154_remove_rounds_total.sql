-- Achômetro — remove o limite de rodadas (rounds_total). Decisão de produto: a partida não
-- termina mais por "acabaram as rodadas" — só por atingir a pontuação-alvo da sala (ou pelas
-- vias de inatividade já existentes: sobrevivente único, sala abandonada). rounds_total nunca
-- foi exposto na tela de configuração de sala (RoomConfigForm só expõe pontuação-alvo, tempo de
-- resposta e pausa) — sempre valia o default de 10 rodadas escondido, o que já criava a situação
-- estranha de uma sala nunca terminar por pontuação se os jogadores estivessem "perto" aos 10
-- rounds. Removendo a coluna e o parâmetro de vez, não só desativando a checagem, pra não deixar
-- configuração morta no schema.

-- ─────────────────────────────────────────────────────────────────────────
-- rounds.index continua existindo (ordem da rodada dentro da sala, usada pelo `unique (room_id,
-- index)` e pelo cliente pra achar a rodada mais recente) — só a comparação contra rounds_total é
-- removida, não o contador em si.
-- ─────────────────────────────────────────────────────────────────────────

-- ─────────────────────────────────────────────────────────────────────────
-- create_room — muda de assinatura (6 → 5 parâmetros, remove p_rounds_total). Overload novo em
-- Postgres, não substituição — precisa dropar a assinatura antiga e reemitir revoke/grant pra
-- assinatura nova (grants são por assinatura, não por nome), mesmo padrão já usado em
-- 20260812155549_configuracao_de_sala.sql.
-- ─────────────────────────────────────────────────────────────────────────
drop function public.create_room(text, text[], smallint, smallint, smallint, smallint);

create function public.create_room(
  p_nickname text,
  p_themes text[] default '{}',
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
        code, host_player_id, themes, answer_seconds, pause_seconds, target_score
      )
      values (
        v_code, auth.uid(), coalesce(p_themes, '{}'), p_answer_seconds,
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

revoke execute on function public.create_room(text, text[], smallint, smallint, smallint) from public;
grant execute on function public.create_room(text, text[], smallint, smallint, smallint) to authenticated;

-- ─────────────────────────────────────────────────────────────────────────
-- start_round — preserva tudo (seleção de pergunta, dedupe, autorização por fase, pausa). Só
-- remove a checagem `v_next_index >= v_room.rounds_total` — a partida nunca mais recusa uma
-- rodada nova por "acabaram as rodadas"; só close_round decide o fim, e só por pontuação-alvo ou
-- inatividade.
-- ─────────────────────────────────────────────────────────────────────────
create or replace function public.start_round(
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
  v_last_closed_at timestamptz;
begin
  if auth.uid() is null then
    raise exception 'auth_required';
  end if;

  select * into v_room from public.rooms where id = p_room_id for update;
  if v_room.id is null then
    raise exception 'room_not_found';
  end if;
  if v_room.status in ('finished', 'abandoned') then
    raise exception 'room_closed';
  end if;

  if v_room.status = 'lobby' then
    if v_room.host_player_id <> auth.uid() then
      raise exception 'not_host';
    end if;
  else
    if not exists (
      select 1 from public.players where room_id = p_room_id and id = auth.uid()
    ) then
      raise exception 'not_in_room';
    end if;

    select closed_at into v_last_closed_at
      from public.rounds where room_id = p_room_id and status = 'closed'
      order by index desc limit 1;

    if v_last_closed_at is not null
       and now() < v_last_closed_at + (v_room.pause_seconds * interval '1 second') then
      raise exception 'pause_in_progress';
    end if;
  end if;

  if exists (select 1 from public.rounds where room_id = p_room_id and status = 'open') then
    raise exception 'round_already_open';
  end if;

  select coalesce(max(index), -1) + 1 into v_next_index
  from public.rounds where room_id = p_room_id;

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
-- close_round — preserva as 3 vias restantes (sala abandonada, sobrevivente único, pontuação-alvo
-- atingida) e todo o resto do corpo já auditado (autorização host/prazo, lock, cálculo de pontos,
-- incremento de missed_streak). Remove só a 4ª via ("última rodada, index+1 >= rounds_total") —
-- sem limite de rodadas, essa via não existe mais. Se nenhuma das 3 vias restantes disparar, a
-- sala simplesmente segue em 'playing' pra próxima rodada, como já acontecia entre rodadas
-- intermediárias.
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
  end if;

  return v_round;
end;
$$;

-- ─────────────────────────────────────────────────────────────────────────
-- rooms.rounds_total — dropa a coluna (e o CHECK inline junto). Nada mais lê nem escreve nela
-- depois desta migration.
-- ─────────────────────────────────────────────────────────────────────────
alter table public.rooms drop column rounds_total;
