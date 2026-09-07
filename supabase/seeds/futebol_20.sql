-- Onda 20 do tópico futebol — lote de 4 perguntas, moldes inéditos no banco: gols somados numa
-- ÚNICA FINAL de Copa do Mundo (1958, Brasil 5x2 Suécia — recorde de gols numa decisão, distinto
-- de "gols numa única partida Copa" já usado no lote 9, que era sobre jogo de fase de
-- grupos/mata-mata, não final); quantidade agregada de HAT-TRICKS em toda a história da Copa do
-- Mundo somando as 23 edições (distinto de "hat-trick mais rápido" já usado no lote 9, que media
-- velocidade de um hat-trick específico, aqui é contagem agregada de todos); recorde de GOLS CONTRA
-- na carreira de um jogador (Richard Dunne, Premier League — ângulo nunca tocado no banco); e
-- quantidade de seleções que já disputaram uma final de Copa do Mundo sem nunca vencer o título
-- (ângulo de "quase-campeão" nunca tocado, distinto de tudo que já existe sobre campeões/goleadas).
--
-- Descartados antes de pesquisar a fundo (cruzados contra o rastreamento acumulado em
-- futebol_ganchos.md):
-- - Qualquer variante de cartão vermelho/amarelo — gancho saturado.
-- - "Artilheiro isolado de uma única edição/temporada de torneio" — esgotado (usado 3x: Fontaine,
--   Platini, Onega; Copa América já testada e descartada).
-- - "Sequência invicta/invencibilidade" — esgotado.
-- - "Bolas de Ouro do Messi" — PROIBIDO POR DECISÃO DO USUÁRIO, nunca reabrir.
-- - Recorde de gols contra numa ÚNICA EDIÇÃO de Copa do Mundo (2018 teve 12; 2026 bateu o recorde
--   com 14, ambos verificados via Wikipédia "List of FIFA World Cup own goals") — pesquisado e
--   confirmado, mas descartado do lote por redundância temática: o lote já tem o ângulo "gols
--   contra" coberto pelo recorde de carreira do Richard Dunne, e usar dois ganchos de gol contra no
--   mesmo lote de 4 pesava demais num único tema. Fica registrado aqui como fato-base já verificado
--   e disponível pra um lote futuro isolado, sem repetir a pesquisa.
-- - Assistências de Michael Olise (2026, liderança da edição) e Brasil ter disputado as 23 edições
--   da Copa — cogitados a partir de "FIFA World Cup records", mas descartados sem aprofundar: o
--   primeiro é ambíguo se é recorde histórico ou só destaque da edição atual; o segundo é
--   conhecimento geral demais entre torcedores brasileiros (risco de morno, critério 4).
--
-- Já nasce 'approved': cada pergunta foi pesquisada e a fonte verificada no momento de ser escrita
-- (mesmo processo do curador-perguntas + skill achometro-perguntas). Fonte travada em Wikipédia
-- como agregador consolidado (nível 2) para as quatro, item a item conferido para garantir que o
-- texto de fato sustenta o número citado, não só citado de memória.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('A final da Copa do Mundo de 1958, entre Brasil e Suécia, é até hoje lembrada como a decisão com mais gols da história do torneio. Quantos gols saíram ao todo naquela partida, somando os dois times?',
   7, 'gols', 'futebol', 2,
   'Wikipédia — "1958 FIFA World Cup final"',
   'https://en.wikipedia.org/wiki/1958_FIFA_World_Cup_final',
   1958, 'approved'),
  ('A Copa do Mundo já soma mais de 1.000 jogos disputados ao longo de 23 edições, mas um hat-trick — três gols ou mais marcados pelo mesmo jogador na mesma partida — segue sendo façanha rara. Quantos hat-tricks já foram registrados juntando toda a história da competição, de 1930 até hoje?',
   58, 'hat-tricks', 'futebol', 3,
   'Wikipédia — "List of FIFA World Cup hat-tricks"',
   'https://en.wikipedia.org/wiki/List_of_FIFA_World_Cup_hat-tricks',
   2026, 'approved'),
  ('O zagueiro irlandês Richard Dunne teve carreira longa por clubes ingleses como Everton, Manchester City e Aston Villa, mas ficou marcado também por um recorde nada glorioso do campeonato. Quantos gols contra ele marcou ao longo da carreira na Premier League — o maior número já registrado por um único jogador na história do torneio inglês?',
   10, 'gols contra', 'futebol', 2,
   'Wikipédia — "Richard Dunne"',
   'https://en.wikipedia.org/wiki/Richard_Dunne',
   2014, 'approved'),
  ('A Copa do Mundo já teve 23 edições, e cada uma delas colocou duas seleções na final — mas nem todo finalista chega a erguer a taça. Quantas seleções diferentes disputaram ao menos uma final da Copa do Mundo na história sem nunca vencer o título?',
   5, 'seleções', 'futebol', 2,
   'Wikipédia — "FIFA World Cup records"',
   'https://en.wikipedia.org/wiki/FIFA_World_Cup_records',
   2026, 'approved');
