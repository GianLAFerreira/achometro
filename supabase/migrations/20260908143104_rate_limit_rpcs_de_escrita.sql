-- Achômetro — rate limit nas RPCs de escrita mais "baratas de abusar" (criar sala e logar erro de
-- cliente). O resto do jogo já se autolimita pelo próprio estado (submit_answer tem PK composta
-- que rejeita segunda tentativa; start_round/close_round recusam com round_already_open/
-- pause_in_progress) — criar sala e logar erro não têm nenhuma trava hoje: uma sessão anônima
-- válida pode chamar create_room ou log_client_error em loop, sem limite.
--
-- Limite: por auth.uid(), não por IP (não temos acesso a IP dentro de uma função Postgres sem
-- reader adicional, e auth.uid() já é a identidade verificada que RLS usa em todo o resto do
-- schema — consistente com o resto do projeto). Threshold generoso o bastante pra não incomodar
-- uso real (várias tentativas seguidas, "jogar de novo" repetido) e recusar só um loop de abuso.
--
-- create_room e create_rematch compartilham o MESMO orçamento: os dois criam sala com
-- host_player_id = auth.uid(), então checar `rooms` cobre os dois sem duplicar lógica.
create index if not exists rooms_host_player_created_idx
  on public.rooms (host_player_id, created_at);

create index if not exists client_errors_player_created_idx
  on public.client_errors (player_id, created_at);

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

  if (
    select count(*) from public.rooms
    where host_player_id = auth.uid() and created_at > now() - interval '5 minutes'
  ) >= 10 then
    raise exception 'rate_limited';
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

  -- já existe rematch (outro jogador clicou primeiro) — devolve a mesma sala, sem checar rate
  -- limit: isso não cria nada novo, é só uma leitura.
  if v_old_room.rematch_room_code is not null then
    select * into v_new_room from public.rooms where code = v_old_room.rematch_room_code;
    if v_new_room.id is not null then
      return v_new_room;
    end if;
  end if;

  if (
    select count(*) from public.rooms
    where host_player_id = auth.uid() and created_at > now() - interval '5 minutes'
  ) >= 10 then
    raise exception 'rate_limited';
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

create or replace function public.log_client_error(
  p_message text,
  p_stack text default null,
  p_path text default null,
  p_user_agent text default null
) returns void
language plpgsql
security definer
set search_path = public, pg_temp
as $$
begin
  if auth.uid() is null then
    raise exception 'auth_required';
  end if;

  if (
    select count(*) from public.client_errors
    where player_id = auth.uid() and created_at > now() - interval '5 minutes'
  ) >= 20 then
    raise exception 'rate_limited';
  end if;

  insert into public.client_errors (player_id, message, stack, path, user_agent)
  values (
    auth.uid(),
    left(p_message, 2000),
    left(p_stack, 4000),
    left(p_path, 200),
    left(p_user_agent, 300)
  );
end;
$$;
