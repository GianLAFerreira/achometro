-- Onda 21 do tópico futebol — lote de 4 perguntas, moldes inéditos no banco: total de gols contra
-- somados numa ÚNICA EDIÇÃO de Copa do Mundo (2026, 14 — fato-base já verificado no lote 20 via
-- Wikipédia "List of FIFA World Cup own goals", guardado ali como pronto pra um lote futuro
-- isolado porque no lote 20 o tema "gol contra" já estava coberto pelo recorde de carreira do
-- Richard Dunne; agora, isolado, entra sem redundância); maior VIRADA DE PLACAR numa decisão
-- europeia (o "Milagre de Istambul" — Milan 3x0 Liverpool no intervalo da final da Champions
-- League de 2005, Liverpool empata em 3x3 e vence nos pênaltis — ângulo de virada/remontada nunca
-- tocado no banco, distinto de goleada ou invencibilidade); recorde do ARREMESSO LATERAL mais
-- longo já registrado no futebol (Michael Lewis, Guinness World Records, 59,817 m — recorde físico
-- de uma técnica específica, distinto da distância percorrida numa partida já usada com Brozovic
-- no lote 14); e quantidade de TÉCNICOS DIFERENTES que já comandaram a Seleção Brasileira desde a
-- estreia oficial em 1914 (85, incluindo Ancelotti) — ângulo de rotatividade institucional de uma
-- seleção inteira ao longo da história, distinto de "mandato mais curto" (lote 11) e "técnico que
-- dirigiu mais seleções diferentes" (lote 19), que são sobre recordes de um único treinador.
--
-- Descartados antes de pesquisar (cruzados contra o rastreamento acumulado em
-- futebol_ganchos.md, sem gastar busca):
-- - Qualquer variante de cartão vermelho/amarelo, sequência invicta/invencibilidade, artilheiro
--   isolado de uma edição/temporada de torneio, e "Bolas de Ouro do Messi" — todos ganchos
--   esgotados ou vetados, listados no rastreamento.
-- - Terceira pergunta de transferência recorde (variação por idade/posição) — já usado 2x
--   (Neymar-PSG geral, Gvardiol por posição); mais uma pesava o lote pro mesmo tema.
-- - Premiação em dinheiro da Copa do Mundo feminina — mesmo molde de "premiação trocando
--   competição" já reprovado no lote 20 para a versão masculina.
-- - Menor público pago já registrado numa partida profissional — descartado sem aprofundar: risco
--   real de a maioria dos recordes "baixos" catalogados serem por punição disciplinar (portões
--   fechados) e não comparáveis entre si por fonte única.
--
-- Já nasce 'approved': cada pergunta foi pesquisada e a fonte verificada no momento de ser escrita
-- (mesmo processo do curador-perguntas + skill achometro-perguntas), item a item conferido para
-- garantir que o texto de fato sustenta o número citado, não só citado de memória. Sem fonte
-- travada única pro lote — as quatro caíram em Wikipédia como agregador consolidado (nível 2); a
-- do arremesso lateral cita a Guinness World Records (nível 1) como origem, mas a página oficial
-- do Guinness não estava mais acessível diretamente (link fora do ar), então o texto que sustenta
-- o número aqui é o da Wikipédia que cita aquela origem — exatamente o caso previsto no critério 1
-- do curador para "agregador quando cita a origem". Todas com `answer` inteiro por causa da
-- constraint `questions_answer_integer_check` — o arremesso lateral (59,817 m) foi arredondado
-- para o metro mais próximo (60), como já feito antes com a distância do Brozovic (lote 14).
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('A Copa do Mundo de 2018 já tinha dobrado o recorde de gols contra somados numa única edição, chegando a 12. Quantos gols contra saíram ao todo na Copa mais recente, a de 2026, que bateu essa marca de novo?',
   14, 'gols contra', 'futebol', 2,
   'Wikipédia — "List of FIFA World Cup own goals"',
   'https://en.wikipedia.org/wiki/List_of_FIFA_World_Cup_own_goals',
   2026, 'approved'),
  ('A final da Champions League de 2005, entre Milan e Liverpool, ficou conhecida como o "Milagre de Istambul" por causa de uma virada histórica no placar. Quantos gols de desvantagem o Liverpool superou naquela decisão, até empatar em 3 a 3 e vencer nos pênaltis?',
   3, 'gols', 'futebol', 2,
   'Wikipédia — "2005 UEFA Champions League final"',
   'https://en.wikipedia.org/wiki/2005_UEFA_Champions_League_final',
   2005, 'approved'),
  ('Um arremesso lateral bem cobrado por um jogador profissional costuma passar dos 25 metros, raramente muito além disso. Qual a distância, em metros, do arremesso lateral mais longo já registrado no futebol, com recorde reconhecido pela Guinness World Records, arredondando para o metro mais próximo?',
   60, 'metros', 'futebol', 2,
   'Wikipédia — "Throw-in" (citando Guinness World Records)',
   'https://en.wikipedia.org/wiki/Throw-in',
   2019, 'approved'),
  ('A Seleção Brasileira de futebol estreou oficialmente em 1914 e desde então já venceu cinco Copas do Mundo. Quantos técnicos diferentes já comandaram a equipe ao longo de toda essa história, contando até o mais recente?',
   85, 'técnicos', 'futebol', 3,
   'Wikipédia — "List of Brazil national football team managers"',
   'https://en.wikipedia.org/wiki/List_of_Brazil_national_football_team_managers',
   2025, 'approved');
