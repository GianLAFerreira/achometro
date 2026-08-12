-- Achômetro — pontuação simplificada (1 mais perto / 2 cravou, com empate
-- pontuando todo mundo), inatividade (2 faltas seguidas) e avanço
-- automático de rodada após uma pausa mostrando o ranking.
--
-- Decisão de produto aceita conscientemente: "cravar" exige valor EXATO,
-- não faixa de tolerância. Em gabaritos grandes (frota de veículos,
-- população de cidade) ninguém crava nunca — o bônus só existe de fato em
-- perguntas de número pequeno. Consequência para a Fase 2 (fora deste
-- commit): as perguntas restantes precisam ser curadas com isso em mente.

-- ─────────────────────────────────────────────────────────────────────────
-- Schema
-- ─────────────────────────────────────────────────────────────────────────
alter table public.players add column missed_streak smallint not null default 0;

alter table public.rooms add column pause_seconds smallint not null default 10
  check (pause_seconds >= 3 and pause_seconds <= 60);
alter table public.rooms add column winner_player_id uuid;

alter table public.rooms drop constraint rooms_status_check;
alter table public.rooms add constraint rooms_status_check
  check (status in ('lobby', 'playing', 'finished', 'abandoned'));

-- `winner_player_id` fica sem FK para `players` de propósito: a FK
-- existente `rooms_host_player_fk` já é deferrable e sem cascade; somar
-- outra FK composta pra mesma tabela complica ordem de delete sem ganho —
-- o dado é só informativo para a UI.

-- ─────────────────────────────────────────────────────────────────────────
-- submit_answer — mesmo corpo de 20260812012126 (preserva o lock `for
-- update` e o mapeamento de duplicata para erro nomeado, que corrigem uma
-- corrida real já auditada). Acrescenta: responder zera a própria falta —
-- volta a "ativo" na hora, e last_seen_at deixa de ser coluna morta.
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

  update public.players
  set missed_streak = 0, last_seen_at = now()
  where room_id = v_round.room_id and id = auth.uid();

  return v_answer;
end;
$$;

-- ─────────────────────────────────────────────────────────────────────────
-- close_round — preserva sem tocar o auth_required, o `for update`, o
-- bloco de autorização host/ends_at e o retorno idempotente (tudo isso já
-- foi auditado em 20260812012126). Muda:
--   1. Pontuação: 1 ponto pra quem tem o menor erro relativo, 2 pra quem
--      crava (valor exato), empate pontua todo mundo — `join melhor` no
--      lugar de `row_number() = 1` é o que garante isso.
--   2. Falta: incrementa missed_streak de quem não respondeu a rodada.
--   3. Fim de partida em três vias: zero jogadores ativos → sala
--      abandonada; sobrou 1 ativo com mais de 1 jogador na sala →
--      finalizada com vencedor; última rodada → finalizada como hoje.
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

  if v_active_players = 0 then
    update public.rooms set status = 'abandoned' where id = v_room.id;
  elsif v_active_players = 1 and v_total_players > 1 then
    select id into v_sole_survivor
      from public.players where room_id = v_room.id and missed_streak < 2;
    update public.rooms
      set status = 'finished', winner_player_id = v_sole_survivor
      where id = v_room.id;
  elsif v_round.index + 1 >= v_room.rounds_total then
    update public.rooms set status = 'finished' where id = v_room.id;
  end if;

  return v_round;
end;
$$;

-- ─────────────────────────────────────────────────────────────────────────
-- start_round — preserva sem alteração a seleção de pergunta (caminho
-- principal + o fallback de dedupe, que impede a partida de travar quando
-- o pool esgota), o insert em question_seen e o `for update` na sala.
-- Muda:
--   1. Autorização por fase: sair do lobby continua exclusivo do host
--      (ato deliberado de "todo mundo chegou"); avançar entre rodadas
--      (status = 'playing') abre pra qualquer membro, mas só depois da
--      pausa — o servidor valida o tempo, o cliente é só gatilho.
--   2. Recusa explícita de sala finished/abandoned.
--   3. Remove o `update ... set status = 'finished'` da linha seguinte ao
--      `raise exception 'rounds_complete'`: a exceção aborta a transação
--      e reverte esse update, é código morto desde sempre. Quem finaliza
--      a sala de fato é close_round.
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

  if v_next_index >= v_room.rounds_total then
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
