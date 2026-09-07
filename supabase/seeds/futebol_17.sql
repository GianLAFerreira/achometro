-- Onda 17 do tópico futebol — lote enxuto (4 perguntas), moldes inéditos no banco: total de gols
-- marcados por um TIME (não um jogador) somando toda uma temporada de liga nacional (distinto do
-- molde já usado de "gols numa edição de Copa/Eurocopa", que sempre mediu o artilheiro individual
-- de um torneio internacional — aqui o sujeito é o clube inteiro numa liga doméstica), recorde de
-- público num jogo de futebol feminino de clubes (gancho nunca tocado — os recordes de público já
-- usados eram sobre capacidade de estádio em jogo masculino), recorde de transferência mais cara
-- da história para a posição de zagueiro (terceira variação de "transferência recorde" no banco,
-- seguindo o precedente já aberto pelas ondas 7 e 10 de tratar recorde por posição como sujeito
-- distinto) e artilheiro isolado de uma única edição da Copa Libertadores (mesmo desenho já usado
-- para Copa do Mundo/Fontaine e Eurocopa/Platini — trocando a competição, seguindo o mesmo
-- precedente de que variar o torneio conta como sujeito distinto, não repetição de gancho).
--
-- Descartados antes de pesquisar a fundo (cruzados contra o rastreamento acumulado):
-- - "Premiação em dinheiro do campeão da Copa do Mundo" — mesmo gancho de "premiação" já usado na
--   onda 6 (Libertadores); trocar só a competição repetiria a forma, não abriria sujeito novo.
-- - "Total de gols de uma seleção somando toda uma campanha de Copa do Mundo" (ex.: Brasil 2002,
--   só 4 gols sofridos) — gancho quase idêntico ao já usado na onda 16 (Brasil 1950, 22 gols
--   marcados na campanha), só invertendo marcados↔sofridos; descartado por redundância de forma.
-- - "Maior sequência de jogos invicto de goleiro/seleção" — molde saturado (ondas 4, 5, 7, 16).
--
-- Descartados depois de pesquisar:
-- - "Gols marcados por Messi contra um único clube adversário ao longo da carreira" — nenhuma
--   fonte (Wikipédia em inglês) consolida esse recorte específico; sem número citável.
-- - "Recorde de gols de um jogador em uma única partida da Copa Libertadores" — a seção de
--   "Player records" do artigo da Copa Libertadores na Wikipédia não trouxe esse dado dentro do
--   tempo de pesquisa; abandonado por limitação de fonte, não por mérito.
--
-- Já nasce 'approved': cada pergunta foi pesquisada e a fonte verificada no momento de ser escrita
-- (mesmo processo do curador-perguntas + skill achometro-perguntas). Sem fonte travada única pro
-- lote — as quatro caíram em Wikipédia como agregador consolidado (nível 2), checado item a item
-- para conferir se o texto de fato sustenta o número, não só citado de memória.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('Na temporada 2017-18 da Premier League, o Manchester City de Pep Guardiola dominou o campeonato inglês com uma folga histórica sobre os rivais, terminando com 100 pontos em 38 jogos. Quantos gols o time marcou ao todo naquela temporada — um recorde da competição que resiste até hoje?',
   106, 'gols', 'futebol', 2,
   'Wikipédia — "2017–18 Manchester City F.C. season"',
   'https://en.wikipedia.org/wiki/2017%E2%80%9318_Manchester_City_F.C._season',
   2018, 'approved'),
  ('Em abril de 2022, o Barcelona recebeu o Wolfsburg pela Champions League Feminina no Camp Nou, estádio com capacidade para quase 100 mil pessoas. Quantos espectadores compareceram a essa partida — recorde mundial de público para um jogo de futebol feminino de clubes?',
   91648, 'espectadores', 'futebol', 2,
   'Wikipédia — "FC Barcelona Femení"',
   'https://en.wikipedia.org/wiki/FC_Barcelona_Femen%C3%AD',
   2022, 'approved'),
  ('Zagueiros raramente entram no radar das transferências mais caras do futebol, historicamente dominado por atacantes e meias. Mesmo assim, em 2023 o croata Joško Gvardiol saiu do RB Leipzig rumo ao Manchester City por um valor recorde para um jogador da posição. Quantos milhões de euros o City pagou nessa transferência?',
   90, 'milhões de euros', 'futebol', 2,
   'Wikipédia — "List of most expensive association football transfers"',
   'https://en.wikipedia.org/wiki/List_of_most_expensive_association_football_transfers',
   2023, 'approved'),
  ('Em 1966, o argentino Daniel Onega defendia o River Plate e viveu uma das campanhas mais goleadoras já vistas na Copa Libertadores da América. Quantos gols ele marcou naquela única edição do torneio — um recorde individual que resiste até hoje?',
   17, 'gols', 'futebol', 2,
   'Wikipédia — "List of Copa Libertadores top scorers"',
   'https://en.wikipedia.org/wiki/List_of_Copa_Libertadores_top_scorers',
   1966, 'approved');
