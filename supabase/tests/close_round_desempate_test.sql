-- close_round tem 3 vias de fim de partida (ver docs/banco-de-dados.md); a via de
-- "pontuação-alvo" só dispara com um único líder estrito, de propósito — empate no topo NÃO
-- encerra a partida (regra reforçada pela migration remove_rounds_total.sql: sem rounds_total
-- como rede de segurança, um empate mal resolvido travaria a sala pra sempre). Este teste cobre
-- as duas metades dessa regra: empate não termina, líder único termina.
begin;
select plan(6);

-- ── Cenário 1: empate na pontuação-alvo — NÃO deve terminar a partida ──────────────────────
do $$
declare
  v_room_id uuid := '11111111-1111-1111-1111-111111111111';
  v_host_id uuid := '11111111-1111-1111-1111-111111111112';
  v_guest_id uuid := '11111111-1111-1111-1111-111111111113';
  v_question_id uuid := '11111111-1111-1111-1111-111111111114';
  v_round_id uuid := '11111111-1111-1111-1111-111111111115';
begin
  insert into public.rooms (id, code, host_player_id, themes, answer_seconds, pause_seconds, target_score, status)
    values (v_room_id, 'PGTAP1', v_host_id, '{}', 20, 10, 2, 'playing');
  insert into public.players (id, room_id, nickname, score) values
    (v_host_id, v_room_id, 'Host', 1),
    (v_guest_id, v_room_id, 'Guest', 1);
  insert into public.questions (id, prompt, answer, unit, theme, source_name, source_url, as_of_year, status)
    values (v_question_id, 'pergunta de teste 1', 100, 'unidades', 'futebol', 'teste', 'pending://teste', 2024, 'approved');
  insert into public.rounds (id, room_id, question_id, index, question_prompt, question_unit, question_theme, status, ends_at)
    values (v_round_id, v_room_id, v_question_id, 0, 'pergunta de teste 1', 'unidades', 'futebol', 'open', now() + interval '20 seconds');
  -- os dois cravam o MESMO palpite (nenhum exato) — empatam no menor erro, +1 ponto cada
  insert into public.answers (round_id, player_id, value) values
    (v_round_id, v_host_id, 90),
    (v_round_id, v_guest_id, 90);

  perform set_config('request.jwt.claims', json_build_object('sub', v_host_id, 'role', 'authenticated')::text, true);
  perform public.close_round(v_round_id);
end $$;

select is(
  (select score from public.players where room_id = '11111111-1111-1111-1111-111111111111' and id = '11111111-1111-1111-1111-111111111112'),
  2,
  'empate: host ganha 1 ponto (1 -> 2)'
);
select is(
  (select score from public.players where room_id = '11111111-1111-1111-1111-111111111111' and id = '11111111-1111-1111-1111-111111111113'),
  2,
  'empate: guest ganha 1 ponto (1 -> 2)'
);
select is(
  (select status from public.rooms where id = '11111111-1111-1111-1111-111111111111'),
  'playing',
  'empate no alvo NÃO encerra a partida — segue jogando até desempatar'
);
select is(
  (select winner_player_id from public.rooms where id = '11111111-1111-1111-1111-111111111111'),
  null::uuid,
  'sem vencedor declarado enquanto os líderes estão empatados'
);

-- ── Cenário 2: líder único na pontuação-alvo — DEVE terminar a partida ─────────────────────
do $$
declare
  v_room_id uuid := '22222222-2222-2222-2222-222222222221';
  v_host_id uuid := '22222222-2222-2222-2222-222222222222';
  v_guest_id uuid := '22222222-2222-2222-2222-222222222223';
  v_question_id uuid := '22222222-2222-2222-2222-222222222224';
  v_round_id uuid := '22222222-2222-2222-2222-222222222225';
begin
  insert into public.rooms (id, code, host_player_id, themes, answer_seconds, pause_seconds, target_score, status)
    values (v_room_id, 'PGTAP2', v_host_id, '{}', 20, 10, 2, 'playing');
  insert into public.players (id, room_id, nickname, score) values
    (v_host_id, v_room_id, 'Host', 1),
    (v_guest_id, v_room_id, 'Guest', 1);
  insert into public.questions (id, prompt, answer, unit, theme, source_name, source_url, as_of_year, status)
    values (v_question_id, 'pergunta de teste 2', 100, 'unidades', 'futebol', 'teste', 'pending://teste', 2024, 'approved');
  insert into public.rounds (id, room_id, question_id, index, question_prompt, question_unit, question_theme, status, ends_at)
    values (v_round_id, v_room_id, v_question_id, 0, 'pergunta de teste 2', 'unidades', 'futebol', 'open', now() + interval '20 seconds');
  -- host crava o valor exato (2 pontos: 1 -> 3, sozinho >= target); guest erra longe (0 ponto)
  insert into public.answers (round_id, player_id, value) values
    (v_round_id, v_host_id, 100),
    (v_round_id, v_guest_id, 1);

  perform set_config('request.jwt.claims', json_build_object('sub', v_host_id, 'role', 'authenticated')::text, true);
  perform public.close_round(v_round_id);
end $$;

select is(
  (select status from public.rooms where id = '22222222-2222-2222-2222-222222222221'),
  'finished',
  'líder único na pontuação-alvo encerra a partida'
);
select is(
  (select winner_player_id from public.rooms where id = '22222222-2222-2222-2222-222222222221'),
  '22222222-2222-2222-2222-222222222222'::uuid,
  'vencedor é quem cravou o valor exato e ficou sozinho no topo'
);

select * from finish();
rollback;
