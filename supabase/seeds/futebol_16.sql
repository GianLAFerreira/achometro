-- Onda 16 do tópico futebol — lote enxuto (4 perguntas), moldes inéditos no banco: tempo entre a
-- fundação de um clube e a conquista de seu primeiro título continental (nunca tocado — as ondas
-- anteriores de "clube" tratavam invencibilidade, goleadas ou pontuação de campeão, nunca o hiato
-- desde a fundação), assistências acumuladas por um jogador ao longo de toda a carreira numa única
-- competição específica — a Champions League — como recorde de nacionalidade (distinto de
-- "assistências numa temporada", lote 11, que media um recorte de um único ano), número de clubes
-- diferentes defendidos por um jogador ao longo da carreira (o oposto do molde já usado — jogos
-- por um único clube ao longo de toda a carreira, Maldini, lote 15 — aqui o sujeito é o extremo
-- contrário, o jogador que nunca ficou parado) e total de gols marcados por uma seleção somando
-- todas as partidas de uma única edição da Copa do Mundo (sujeito é o time inteiro numa campanha,
-- distinto de "gols numa edição de Copa" do lote 7, que media o artilheiro individual do torneio,
-- Fontaine).
--
-- Descartados antes de pesquisar a fundo (cruzados contra o rastreamento acumulado):
-- - "Maior invencibilidade de seleção nacional" (qualquer seleção) — o molde de sequência invicta
--   já está saturado tanto para clube (lotes 4-5) quanto para seleção (Argentina, reprovada no
--   lote 7); não retestado sob outro sujeito.
-- - "Gols sofridos na carreira por um goleiro" (total acumulado) — descartado sem pesquisa
--   aprofundada por não haver, tipicamente, uma estatística agregada oficial ou de agregador
--   consolidado para esse número ao longo de toda uma carreira (ao contrário de gols marcados,
--   que os clubes/competições contabilizam).
--
-- Descartados depois de pesquisar:
-- - "Recorde de cartões amarelos na carreira de Sergio Ramos" — a página da Wikipédia usada como
--   fonte só documenta recordes de cartão VERMELHO dele (inclusive o de finais de Champions
--   League), sem nenhum total consolidado de amarelos; descartado por falta de fonte (critério 2)
--   e porque cartão vermelho como gancho já está saturado no banco.
-- - "Recorde de gols marcados por um clube numa única campanha/temporada da Champions League" —
--   pesquisado via Wikipédia (artigo de recordes da competição e artigo da temporada 2019-20), mas
--   o conteúdo acessível não trouxe um número consolidado com o clube recordista citado dentro do
--   tempo de pesquisa; abandonado por limitação de fonte, não por mérito.
--
-- Já nasce 'approved': cada pergunta foi pesquisada e a fonte verificada no momento de ser escrita
-- (mesmo processo do curador-perguntas + skill achometro-perguntas). Sem fonte travada única pro
-- lote — as quatro caíram em Wikipédia como agregador consolidado (nível 2), checado item a item
-- para conferir se o texto de fato sustenta o número, não só citado de memória.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('O Grêmio foi fundado em 1903 e é um dos clubes mais tradicionais do Rio Grande do Sul, mas para conquistar seu primeiro título da Copa Libertadores da América — o torneio mais importante de clubes da América do Sul, batendo o Peñarol na decisão — precisou esperar bem mais do que a maioria dos primeiros campeões do continente. Quantos anos separam a fundação do clube da conquista desse primeiro título?',
   80, 'anos', 'futebol', 2,
   'Wikipédia — "Grêmio Foot-Ball Porto Alegrense"',
   'https://pt.wikipedia.org/wiki/Grêmio_Foot-Ball_Porto_Alegrense',
   1983, 'approved'),
  ('Xavi Hernández jogou praticamente toda a carreira profissional pelo Barcelona, entre 1998 e 2015, sendo mais reconhecido por engatilhar jogadas do que por finalizar. Quantas assistências ele registrou somando todas as suas participações na Champions League ao longo da carreira — o maior número da história da competição entre jogadores espanhóis?',
   30, 'assistências', 'futebol', 2,
   'Wikipédia — "Xavi Hernández"',
   'https://en.wikipedia.org/wiki/Xavi_Hernández',
   2015, 'approved'),
  ('O goleiro inglês John Burridge jogou profissionalmente entre 1969 e 1997 — quase 30 anos —, trocando de time com uma frequência incomum até para os padrões do futebol inglês, sempre atrás de mais uma chance como titular, e chegou a jogar na primeira divisão já com mais de 43 anos. Por quantos clubes diferentes ele passou ao longo de toda a carreira?',
   29, 'clubes', 'futebol', 2,
   'Wikipédia — "John Burridge"',
   'https://en.wikipedia.org/wiki/John_Burridge',
   1997, 'approved'),
  ('A Copa do Mundo de 1950, sediada no Brasil, teve formato diferente do atual — sem final única, o título saiu de um quadrangular decisivo entre os melhores colocados — e a seleção brasileira disputou só 6 partidas em todo o torneio, goleando adversários como a Suécia (7 a 1) e a Espanha (6 a 1) pelo caminho, antes do tropeço final contra o Uruguai. Quantos gols o Brasil marcou ao todo, somando as 6 partidas da campanha?',
   22, 'gols', 'futebol', 2,
   'Wikipédia — "Brazil at the FIFA World Cup"',
   'https://en.wikipedia.org/wiki/Brazil_at_the_FIFA_World_Cup',
   1950, 'approved');
