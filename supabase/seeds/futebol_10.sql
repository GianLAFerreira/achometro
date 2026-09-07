-- Onda 10 do tópico futebol — lote enxuto (4 perguntas), mistura Brasil/internacional, formas
-- deliberadamente diferentes entre si e diferentes das já usadas nos lotes 1-9: recorde de gols de
-- um jogador numa única edição do Brasileirão (distinto do recorde de gols de time numa edição, já
-- usado no lote 4, e do recorde de carreira inteira, já usado nos lotes 3 e 9), contagem de um
-- grupo seleto de jogadores (jamais usado antes — nem carreira, nem recorde numérico de uma
-- partida), recorde de distância (mold inédito no banco) e recorde de transferência específico de
-- goleiro (distinto do recorde mundial de transferência geral, já usado no lote 7 com Neymar, e do
-- recorde do futebol brasileiro, já usado no lote 4). Já nasce 'approved': cada pergunta foi
-- pesquisada e a fonte verificada no momento de ser escrita (mesmo processo do curador-perguntas +
-- skill achometro-perguntas). Sem fonte travada única pro lote — cada assunto buscou sua própria
-- fonte pela hierarquia (oficial > agregador consolidado > imprensa de referência).
--
-- Descartados do pool original de candidatos:
-- - "Hat-trick mais rápido da história da Copa do Mundo" (László Kiss, 1982, 7 minutos, fonte
--   oficial Guinness World Records) — teria fonte limpa e o número bate, mas descartado por
--   redundância de forma com "hat-trick mais rápido da Premier League" (Sadio Mané), já usada no
--   lote 9: o mesmo tipo de recorde (velocidade de hat-trick), só trocando a competição.
-- - "Maior invencibilidade da seleção argentina antes da final da Copa América de 2024" — descartado
--   por redundância de forma com a invencibilidade da Seleção Brasileira (lote 5) e com sequências
--   de jogos invictos de clube (lotes 4 e 9, este último já rejeitando o caso do AC Milan pelo mesmo
--   motivo).
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('Numa temporada comum do Brasileirão, o artilheiro do campeonato costuma fechar o ano com algo entre 15 e 20 gols. Mas em 2004 o atacante Washington, do Atlético Paranaense, disparou tanto que estabeleceu o recorde de gols numa única edição da competição — uma marca que nenhum artilheiro chegou perto de igualar desde então. Quantos gols ele marcou naquele Brasileirão?',
   34, 'gols', 'futebol', 2,
   'Wikipédia — "Campeonato Brasileiro de Futebol de 2004" (seção de artilheiros)',
   'https://pt.wikipedia.org/wiki/Campeonato_Brasileiro_de_2004',
   2004, 'approved'),
  ('Hoje, assim que um jogador estreia oficialmente pela seleção principal do seu país, ele fica travado a ela para sempre — trocar de seleção depois é praticamente impossível pelas regras da FIFA. Mas nas primeiras décadas de Copa do Mundo, quando essa trava não existia, um punhado de jogadores conseguiu disputar Mundiais por duas seleções diferentes, como o argentino Luis Monti, campeão em 1930, e vice-campeão pela Itália em 1934. Quantos jogadores, ao todo, já entraram para esse grupo seleto na história da competição?',
   6, 'jogadores', 'futebol', 3,
   'Wikipédia — "Lista de futebolistas que disputaram a Copa do Mundo FIFA por dois países"',
   'https://pt.wikipedia.org/wiki/Lista_de_futebolistas_que_disputaram_a_Copa_do_Mundo_FIFA_por_dois_pa%C3%ADses',
   2026, 'approved'),
  ('A maioria dos gols de fora da área não passa dos 30 ou 35 metros. Mas em 2021 o goleiro galês Tom King, do Newport County, bateu um tiro de meta que voou por cima do goleiro adversário e entrou para o Guinness World Records como o gol mais longe já registrado numa partida oficial de futebol. De quantos metros, arredondando para o metro mais próximo, foi esse gol recorde?',
   96, 'metros', 'futebol', 2,
   'Guinness World Records — "Longest goal scored in a competitive football (soccer) match"',
   'https://www.guinnessworldrecords.com/world-records/111981-longest-goal-scored-in-a-competitive-football-soccer-match',
   2021, 'approved'),
  ('Goleiro raramente é a posição mais cara de um elenco — atacantes e meias costumam concentrar as transferências milionárias do futebol europeu. Mas em 2018 o Chelsea pagou a cláusula de rescisão do espanhol Kepa Arrizabalaga, então no Athletic Bilbao, e bateu o recorde mundial de transferência para um goleiro, marca que segue de pé até hoje. Quantos euros o Chelsea pagou nessa cláusula?',
   80000000, 'euros', 'futebol', 2,
   'ESPN — "Kepa Arrizabalaga pays €80m release clause ahead of Chelsea move"',
   'https://www.espn.com/soccer/story/_/id/37559625/kepa-arrizabalaga-pays-80m-release-clause-ahead-of-chelsea-move',
   2018, 'approved');
