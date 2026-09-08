-- Achômetro — sala não fica mais travada pra sempre se o host sumir no lobby.
--
-- Achado por revisão analítica do fluxo de jogo: `start_round`, no branch `lobby`, só aceitava
-- `host_player_id = auth.uid()`. Sem host-transfer nem timeout, se quem criou a sala fechasse a
-- aba antes de clicar "iniciar rodada", os outros jogadores ficavam presos — só o TTL de 24h
-- (pg_cron) resolvia. Diferente do resto do jogo: entre rodadas, "qualquer membro" já serve de
-- rede de segurança pra `start_round`/`close_round` (ver migration pontuacao_inatividade_e_pausa)
-- — só a saída do lobby não tinha essa proteção.
--
-- Mudança: qualquer membro da sala pode chamar `start_round` a partir do lobby, não só o host, DESDE
-- QUE a sala já exista há pelo menos `LOBBY_GRACE_SECONDS` (45s) — dá tempo do host de verdade agir
-- primeiro, sem abrir uma corrida imediata como a de start/close entre rodadas (lá o risco de
-- "host só está lendo a tela" não existe, porque a decisão de sair do lobby já é deliberada por
-- natureza). Cliente decide quando MOSTRAR o botão de fallback (`Lobby.tsx`); o servidor, aqui,
-- é quem de fato autoriza — cliente nunca é autoridade (regra 1 do CLAUDE.md).
--
-- Preserva sem alteração o resto do corpo (seleção de pergunta incluindo o ajuste temporário de
-- beta de `20260908024837_beta_sorteia_pending_temporario.sql`, contagem mínima de 2 jogadores,
-- pausa entre rodadas).
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
      if not exists (
        select 1 from public.players where room_id = p_room_id and id = auth.uid()
      ) then
        raise exception 'not_in_room';
      end if;
      if now() < v_room.created_at + interval '45 seconds' then
        raise exception 'not_host';
      end if;
    end if;
    if (select count(*) from public.players where room_id = p_room_id) < 2 then
      raise exception 'not_enough_players';
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

  -- caminho principal: pergunta 'approved' OU 'pending' (ajuste temporário de beta — ver
  -- 20260908024837_beta_sorteia_pending_temporario.sql), do tema da sala, que ninguém atualmente
  -- na sala já viu.
  select q.* into v_question
  from public.questions q
  where q.status in ('approved', 'pending')
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
    where q.status in ('approved', 'pending')
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
