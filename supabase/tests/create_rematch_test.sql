-- "Jogar de novo" tinha um bug real: cada clique chamava create_room direto, cada um gerando
-- sua própria sala — jogadores caíam em salas diferentes. create_rematch (migration
-- jogar_de_novo_sala_compartilhada.sql) corrige isso sendo IDEMPOTENTE: o primeiro clique cria
-- a sala nova e grava o código em rooms.rematch_room_code da sala antiga; um segundo clique (de
-- outro jogador) tem que devolver a MESMA sala, nunca criar outra. Este teste cobre a
-- idempotência e as duas guardas (sala não terminada, quem não é da sala).
begin;
select plan(5);

do $$
declare
  v_room_id uuid := '33333333-3333-3333-3333-333333333331';
  v_host_id uuid := '33333333-3333-3333-3333-333333333332';
  v_guest_id uuid := '33333333-3333-3333-3333-333333333333';
  v_not_finished_room_id uuid := '33333333-3333-3333-3333-333333333334';
begin
  insert into public.rooms (id, code, host_player_id, themes, answer_seconds, pause_seconds, target_score, status)
    values (v_room_id, 'PGTAP3', v_host_id, array['futebol'], 25, 12, 3, 'finished');
  insert into public.players (id, room_id, nickname, score) values
    (v_host_id, v_room_id, 'Host', 3),
    (v_guest_id, v_room_id, 'Guest', 1);

  -- sala irmã, ainda não terminada — só pra testar a guarda room_not_finished
  insert into public.rooms (id, code, host_player_id, themes, answer_seconds, pause_seconds, target_score, status)
    values (v_not_finished_room_id, 'PGTAP4', v_host_id, '{}', 20, 10, 5, 'lobby');
  insert into public.players (id, room_id, nickname, score) values
    (v_host_id, v_not_finished_room_id, 'Host', 0);

  -- host clica "jogar de novo" primeiro
  perform set_config('request.jwt.claims', json_build_object('sub', v_host_id, 'role', 'authenticated')::text, true);
  perform public.create_rematch(v_room_id);

  -- guest clica depois — tem que cair na MESMA sala, não criar outra
  perform set_config('request.jwt.claims', json_build_object('sub', v_guest_id, 'role', 'authenticated')::text, true);
  perform public.create_rematch(v_room_id);
end $$;

select isnt(
  (select rematch_room_code from public.rooms where id = '33333333-3333-3333-3333-333333333331'),
  null,
  'primeiro clique grava um código de rematch na sala antiga'
);

select is(
  (
    select count(*)::int from public.rooms
    where host_player_id in ('33333333-3333-3333-3333-333333333332', '33333333-3333-3333-3333-333333333333')
      and id not in ('33333333-3333-3333-3333-333333333331', '33333333-3333-3333-3333-333333333334')
  ),
  1,
  'dois cliques (host + guest) resultam em UMA sala nova só, não duas'
);

select is(
  (
    select r2.themes from public.rooms r1
    join public.rooms r2 on r2.code = r1.rematch_room_code
    where r1.id = '33333333-3333-3333-3333-333333333331'
  ),
  array['futebol'],
  'sala nova herda os mesmos temas da sala antiga'
);

do $$
begin
  -- precisa ser o host da PGTAP4 (membro de verdade) pra bater na guarda
  -- room_not_finished, e não antes na de not_in_room.
  perform set_config(
    'request.jwt.claims',
    json_build_object('sub', '33333333-3333-3333-3333-333333333332', 'role', 'authenticated')::text,
    true
  );
end $$;

select throws_ok(
  $$ select public.create_rematch('33333333-3333-3333-3333-333333333334') $$,
  'P0001',
  'room_not_finished',
  'create_rematch recusa sala que ainda não terminou (host da PGTAP4, ainda em lobby)'
);

do $$
begin
  perform set_config(
    'request.jwt.claims',
    json_build_object('sub', gen_random_uuid()::text, 'role', 'authenticated')::text,
    true
  );
end $$;

select throws_ok(
  $$ select public.create_rematch('33333333-3333-3333-3333-333333333331') $$,
  'P0001',
  'not_in_room',
  'create_rematch recusa quem nunca esteve na sala antiga'
);

select * from finish();
rollback;
