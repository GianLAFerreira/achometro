-- Achômetro — corrige "Jogar de novo": clicar tinha que levar TODO MUNDO pra mesma sala nova, e
-- levava cada um pra uma sala diferente (cada cliente chamava create_room por conta própria, cada
-- chamada gera um código novo). Achado em playtest depois do commit anterior (dfae75d).
--
-- Solução: uma função nova, create_rematch(old_room_id), em vez de reusar create_room direto do
-- cliente. Quem clica primeiro cria a sala nova E grava o código dela em
-- rooms.rematch_room_code da sala ANTIGA (já finalizada); quem clicar depois (ou nem clicar)
-- só precisa ler esse campo via o canal Realtime que RoomScreen já assina em `rooms` — o
-- efeito no cliente (`useEffect` em RoomScreen.tsx) navega todo mundo assim que o campo aparece,
-- sem precisar de um segundo clique de cada jogador.
--
-- Idempotência contra corrida: create_rematch faz `select ... for update` na sala antiga antes de
-- checar `rematch_room_code`. Duas chamadas concorrentes serializam nesse lock — a segunda, ao
-- destravar, já enxerga o `rematch_room_code` que a primeira gravou (Postgres reavalia a linha
-- mais recente depois de um SELECT FOR UPDATE bloqueado) e devolve a MESMA sala em vez de criar
-- outra.
alter table public.rooms add column rematch_room_code text;

create function public.create_rematch(
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

  -- já existe rematch (outro jogador clicou primeiro) — devolve a mesma sala, não cria outra.
  if v_old_room.rematch_room_code is not null then
    select * into v_new_room from public.rooms where code = v_old_room.rematch_room_code;
    if v_new_room.id is not null then
      return v_new_room;
    end if;
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

revoke execute on function public.create_rematch(uuid) from public;
grant execute on function public.create_rematch(uuid) to authenticated;
