-- Achômetro — corrige geração de código de sala: `(random() * length(alfabeto))::int` ARREDONDA
-- (não trunca), então às vezes vale exatamente `length(alfabeto)` (32). Somando 1, o índice vira 33
-- — fora do alfabeto de 32 caracteres — e `substr` com posição além do fim da string devolve texto
-- VAZIO em vez de erro, silenciosamente. O código final então sai com menos de 6 caracteres.
--
-- Achado por acidente: testando o "jogar de novo" (create_rematch, que reusa este mesmo trecho),
-- um código saiu com 5 caracteres em vez de 6. Reproduzido de propósito rodando create_room 500
-- vezes: **37 de 500 (7,4%) saíram curtos** (36 com 5 caracteres, 1 com 4). Bug pré-existente desde
-- a primeira migration (`20260811234827_functions.sql`), sobrevivendo copiado em toda reescrita de
-- create_room desde então (inclusive na versão atual, `20260908023154_remove_rounds_total.sql`) —
-- não é novo, só nunca tinha sido pego. Afeta todo código de sala já gerado até aqui (~7% deles),
-- inclusive em produção; não há como corrigir os já emitidos (não há registro de quais foram
-- curtos), só garantir que os próximos saiam certos.
--
-- Correção: `floor(random() * length(alfabeto))::int + 1` — `floor` trunca ANTES do cast, deixando
-- o resultado sempre em `[0, length-1]`, e o índice final sempre em `[1, length]`. `create_room`
-- (usada também por `create_rematch`, que tem o mesmo trecho) recebe a mesma correção nos dois
-- lugares — mudar só um deixaria o outro com o mesmo bug.
create or replace function public.create_room(
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
      select string_agg(
        substr(v_alphabet, floor(random() * length(v_alphabet))::int + 1, 1), ''
      )
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

create or replace function public.create_rematch(
  p_old_room_id uuid
) returns public.rooms
language plpgsql
security definer
set search_path = public, pg_temp
as $$
declare
  v_old_room public.rooms;
  v_new_room public.rooms;
  v_nickname text;
  v_code text;
  v_alphabet text := 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
  v_attempt int;
begin
  if auth.uid() is null then
    raise exception 'auth_required';
  end if;

  select * into v_old_room from public.rooms where id = p_old_room_id for update;
  if v_old_room.id is null then
    raise exception 'room_not_found';
  end if;

  select nickname into v_nickname
    from public.players where room_id = p_old_room_id and id = auth.uid();
  if v_nickname is null then
    raise exception 'not_in_room';
  end if;

  if v_old_room.status <> 'finished' then
    raise exception 'room_not_finished';
  end if;

  if v_old_room.rematch_room_code is not null then
    select * into v_new_room from public.rooms where code = v_old_room.rematch_room_code;
    if v_new_room.id is not null then
      return v_new_room;
    end if;
  end if;

  for v_attempt in 1..20 loop
    v_code := (
      select string_agg(
        substr(v_alphabet, floor(random() * length(v_alphabet))::int + 1, 1), ''
      )
      from generate_series(1, 6)
    );
    begin
      insert into public.rooms (
        code, host_player_id, themes, answer_seconds, pause_seconds, target_score
      )
      values (
        v_code, auth.uid(), v_old_room.themes, v_old_room.answer_seconds,
        v_old_room.pause_seconds, v_old_room.target_score
      )
      returning * into v_new_room;
      exit;
    exception when unique_violation then
      continue;
    end;
  end loop;

  if v_new_room.id is null then
    raise exception 'could_not_allocate_room_code';
  end if;

  insert into public.players (id, room_id, nickname)
  values (auth.uid(), v_new_room.id, v_nickname);

  update public.rooms set rematch_room_code = v_new_room.code where id = p_old_room_id;

  return v_new_room;
end;
$$;
