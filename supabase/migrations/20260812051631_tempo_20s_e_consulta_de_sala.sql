-- Achômetro — tempo de resposta cai para 20s (era 45s: tempo demais para um
-- palpite que é achismo por definição, não cálculo) e uma forma de checar um
-- código de sala sem já entrar nela.
--
-- Hoje não existe caminho para isso: a policy `rooms_select_member` filtra
-- tudo para quem não é membro, e `join_room` é SECURITY DEFINER — descobrir
-- que a sala existe via join_room já te coloca dentro dela. `HomeScreen`
-- só descobre um código inválido depois que a pessoa digita o apelido na
-- tela da sala e `join_room` estoura `room_not_found`.

alter table public.rooms alter column answer_seconds set default 20;

-- ─────────────────────────────────────────────────────────────────────────
-- create_room — só o default do parâmetro muda (45 → 20). Corpo idêntico
-- ao original em 20260811234827_functions.sql:15-60. Não altera a
-- assinatura (text, text[], smallint, smallint), então os revoke/grant já
-- emitidos para essa assinatura continuam valendo — não precisam ser
-- reemitidos.
-- ─────────────────────────────────────────────────────────────────────────
create or replace function public.create_room(
  p_nickname text,
  p_themes text[] default '{}',
  p_rounds_total smallint default 10,
  p_answer_seconds smallint default 20
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
-- peek_room — só o veredito, nunca dados da sala. Não é SELECT direto
-- (RLS bloquearia mesmo assim, não há policy de leitura pra não-membro) e
-- não é join_room (que já teria o efeito colateral de te colocar dentro).
-- 'empty' cobre sala existente sem nenhum jogador ativo — caso que a
-- migration de inatividade introduz depois desta.
-- ─────────────────────────────────────────────────────────────────────────
create function public.peek_room(p_room_code text) returns text
language plpgsql
security definer
stable
set search_path = public, pg_temp
as $$
declare
  v_room public.rooms;
begin
  select * into v_room from public.rooms where code = upper(p_room_code);

  if v_room.id is null then
    return 'not_found';
  end if;
  if v_room.status = 'finished' then
    return 'finished';
  end if;
  if v_room.status = 'abandoned' then
    return 'abandoned';
  end if;
  if not exists (select 1 from public.players where room_id = v_room.id) then
    return 'empty';
  end if;

  return 'ok';
end;
$$;

revoke execute on function public.peek_room(text) from public;
grant execute on function public.peek_room(text) to authenticated;
