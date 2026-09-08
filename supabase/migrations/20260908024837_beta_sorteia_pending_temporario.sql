-- Achômetro — AJUSTE TEMPORÁRIO DE BETA, PREVISTO PRA SER DESFEITO.
--
-- Contexto: o banco tem ~700+ perguntas 'pending' (candidatas escritas de memória, aguardando
-- curadoria real com pesquisa de fonte) e só ~236 'approved'. Curar tudo vai levar tempo; o
-- usuário decidiu, conscientemente, abrir mão de "só pergunta verificada" por enquanto pra dar
-- volume de conteúdo pros jogadores do beta usarem — decisão de produto, não erro.
--
-- Mudança: start_round passa a sortear `status in ('approved', 'pending')`, não só 'approved'.
-- `rejected` continua sempre fora (essas já foram avaliadas e reprovadas — nunca entram).
--
-- Efeito colateral colateral aceito conscientemente: perguntas 'pending' têm
-- `source_name`/`source_url` como placeholder ("NÃO VERIFICADO — número candidato, pendente de
-- curadoria" / "pending://sem-fonte-verificada") — RoundReveal.tsx renderiza isso como se fosse a
-- fonte real, com link quebrado (`pending://` não é um protocolo navegável). Não escondido nem
-- mascarado no cliente — fica visível de propósito, avisado ao usuário antes desta migration.
--
-- COMO REVERTER (quando a curadoria avançar o suficiente): criar uma migration nova que reaplique
-- start_round com `where q.status = 'approved'` nos dois selects abaixo (main + fallback) — nunca
-- editar esta migration depois de aplicada (regra 9 do CLAUDE.md).
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

  -- caminho principal: pergunta 'approved' OU 'pending' (ajuste temporário de beta — ver
  -- cabeçalho desta migration), do tema da sala, que ninguém atualmente na sala já viu.
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
