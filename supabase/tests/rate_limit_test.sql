-- create_room/create_rematch e log_client_error não tinham nenhuma trava contra abuso — uma
-- sessão anônima válida podia chamar em loop sem limite (migration
-- 20260908143104_rate_limit_rpcs_de_escrita.sql). Este teste cobre: o limite bate no número
-- certo, create_room e create_rematch compartilham o mesmo orçamento (os dois criam sala com
-- host_player_id = auth.uid()), e log_client_error tem o próprio limite independente.
begin;
select plan(5);

-- ── create_room: 10 passam, o 11º é recusado ──────────────────────────────────────────────
do $$
declare
  v_host_id uuid := '44444444-4444-4444-4444-444444444441';
  i int;
begin
  perform set_config('request.jwt.claims', json_build_object('sub', v_host_id, 'role', 'authenticated')::text, true);
  for i in 1..10 loop
    perform public.create_room('Tester');
  end loop;
end $$;

select is(
  (select count(*)::int from public.rooms where host_player_id = '44444444-4444-4444-4444-444444444441'),
  10,
  'create_room: 10 chamadas no limite criam 10 salas'
);

select throws_ok(
  $$ select public.create_room('Tester') $$,
  'P0001',
  'rate_limited',
  'create_room: a 11ª chamada em 5 minutos é recusada'
);

-- ── create_rematch compartilha o orçamento com create_room ────────────────────────────────
do $$
declare
  v_host_id uuid := '44444444-4444-4444-4444-444444444441'; -- já gastou as 10 vagas acima
  v_old_room_id uuid := '44444444-4444-4444-4444-444444444442';
begin
  insert into public.rooms (id, code, host_player_id, themes, answer_seconds, pause_seconds, target_score, status)
    values (v_old_room_id, 'RLTEST', v_host_id, '{}', 20, 10, 5, 'finished');
  insert into public.players (id, room_id, nickname, score, joined_at, last_seen_at, missed_streak) values
    (v_host_id, v_old_room_id, 'Host', 3, now(), now(), 0);
end $$;

select throws_ok(
  $$ select public.create_rematch('44444444-4444-4444-4444-444444444442') $$,
  'P0001',
  'rate_limited',
  'create_rematch recusa quando o host já esgotou o orçamento de create_room'
);

-- ── log_client_error: 20 passam, o 21º é recusado ─────────────────────────────────────────
do $$
declare
  v_player_id uuid := '44444444-4444-4444-4444-444444444443';
  i int;
begin
  perform set_config('request.jwt.claims', json_build_object('sub', v_player_id, 'role', 'authenticated')::text, true);
  for i in 1..20 loop
    perform public.log_client_error('erro de teste');
  end loop;
end $$;

select is(
  (select count(*)::int from public.client_errors where player_id = '44444444-4444-4444-4444-444444444443'),
  20,
  'log_client_error: 20 chamadas no limite gravam 20 linhas'
);

select throws_ok(
  $$ select public.log_client_error('erro de teste') $$,
  'P0001',
  'rate_limited',
  'log_client_error: a 21ª chamada em 5 minutos é recusada'
);

select * from finish();
rollback;
