-- Regressão do bug corrigido em 20260908041232_corrige_geracao_de_codigo_de_sala.sql:
-- (random() * length(alfabeto))::int ARREDONDA em vez de truncar, então às vezes vale
-- length(alfabeto) e o índice final fica fora do alfabeto — substr devolve vazio em
-- silêncio, e o código sai com menos de 6 caracteres. Achado testando "jogar de novo"
-- (create_rematch, que reusa este mesmo trecho); reproduzido rodando create_room 500 vezes
-- (37 de 500 saíram curtos antes da correção). Este teste roda 300 vezes de propósito —
-- se o bug voltar, a chance de NENHUMA das 300 sair curta é desprezível.
begin;
select plan(2);

create temporary table _codigo_amostra (code text) on commit drop;

do $$
declare
  i int;
  v_room public.rooms;
begin
  for i in 1..300 loop
    perform set_config(
      'request.jwt.claims',
      json_build_object('sub', gen_random_uuid()::text, 'role', 'authenticated')::text,
      true
    );
    select * into v_room from public.create_room('Tester');
    insert into _codigo_amostra (code) values (v_room.code);
  end loop;
end $$;

select is(
  (select count(*)::int from _codigo_amostra where char_length(code) <> 6),
  0,
  '300 códigos gerados por create_room saem todos com exatamente 6 caracteres'
);

select is(
  (select count(distinct code)::int from _codigo_amostra),
  300,
  'nenhum código repetido nas 300 chamadas (alfabeto de 32^6 possibilidades)'
);

select * from finish();
rollback;
