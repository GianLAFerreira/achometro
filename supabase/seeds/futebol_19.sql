-- Onda 19 do tópico futebol — lote de 4 perguntas, moldes inéditos no banco: artilheiro histórico
-- de uma SELEÇÃO nacional (Ali Daei, gols pelo Irã — nunca tocado; gols carreira já usados eram
-- sempre por clube, nunca pela seleção) e cartão até então de Cristiano Ronaldo/Messi mencionado
-- só como contexto, sem citar quantidade das Bolas de Ouro (veto do usuário respeitado); técnico
-- que dirigiu o maior número de seleções DIFERENTES em Copas do Mundo (Bora Milutinović — eixo
-- distinto do "mandato mais curto técnico" já usado no lote 11, aqui mede diversidade de países,
-- não duração); quantidade de estádios da primeira Copa do Mundo (1930, Uruguai, todos em
-- Montevidéu — nunca tocado o ângulo "infraestrutura de uma edição"); e recorde de gols de pênalti
-- convertidos numa única edição (2018, estreia do VAR — distinto de "disputa de pênaltis" (lote 6,
-- que é sobre shootout) e de "total de cartões numa edição" (lote 15), aqui é sobre pênaltis
-- marcados durante o jogo normal).
--
-- Descartados antes de pesquisar a fundo (cruzados contra o rastreamento acumulado em
-- futebol_ganchos.md):
-- - Qualquer variante de "Bolas de Ouro do Messi" — PROIBIDO POR DECISÃO DO USUÁRIO, nunca reabrir.
-- - "Artilheiro isolado de uma única edição/temporada de torneio" (Champions League, Copa América
--   etc.) — gancho tratado como esgotado (já usado 3x: Fontaine, Platini, Onega).
-- - "Cartão vermelho/amarelo" em qualquer variante — gancho saturado, mencionado explicitamente no
--   rastreamento como esgotado inclusive para Sergio Ramos.
-- - "Sequência invicta/invencibilidade" (clube, seleção ou goleiro) — esgotado, não retestado.
-- - "Maior cláusula de rescisão já registrada" (ex.: Mbappé no PSG) — descartado sem pesquisar a
--   fundo: cláusulas contratuais raramente têm fonte oficial pública, só valores especulados pela
--   imprensa, risco alto de reprovar por critério 2 (fonte).
-- - "Recorde de gols de cabeça na carreira" — descartado sem pesquisar: não costuma existir
--   estatística agregada oficial consolidada para esse recorte ao longo de carreira inteira (mesmo
--   problema já identificado para gols sofridos por goleiro, lote 16).
-- - "Distância total percorrida por um jogador ao longo de uma Copa inteira" (agregado, não uma
--   partida) — descartado sem pesquisar: risco de não haver número consolidado facilmente
--   verificável fora dos relatórios técnicos da FIFA.
--
-- Já nasce 'approved': cada pergunta foi pesquisada e a fonte verificada no momento de ser escrita
-- (mesmo processo do curador-perguntas + skill achometro-perguntas). Fonte travada em Wikipédia
-- como agregador consolidado (nível 2) para as quatro, item a item conferido para garantir que o
-- texto de fato sustenta o número citado, não só citado de memória.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('O atacante iraniano Ali Daei defendeu a seleção do seu país entre 1993 e 2006 e chegou a ser o maior artilheiro internacional da história do futebol masculino — recorde que só foi superado por Cristiano Ronaldo em 2021. Quantos gols Daei marcou pela seleção do Irã ao longo da carreira?',
   108, 'gols', 'futebol', 2,
   'Wikipédia — "Ali Daei"',
   'https://en.wikipedia.org/wiki/Ali_Daei',
   2006, 'approved'),
  ('O técnico sérvio radicado no México Bora Milutinović ficou famoso por levar seleções bem diferentes entre si — como México, Nigéria e Costa Rica — a rodadas eliminatórias de Copas do Mundo consecutivas, sempre trocando de país a cada edição. Quantas seleções nacionais diferentes ele comandou ao todo em Copas do Mundo ao longo da carreira?',
   5, 'seleções', 'futebol', 3,
   'Wikipédia — "Bora Milutinović"',
   'https://en.wikipedia.org/wiki/Bora_Milutinovi%C4%87',
   2002, 'approved'),
  ('A primeira Copa do Mundo da história, disputada no Uruguai em 1930, teve todos os jogos concentrados numa única cidade, Montevidéu, num torneio ainda bem pequeno perto dos padrões atuais. Quantos estádios diferentes foram usados nessa edição?',
   3, 'estádios', 'futebol', 1,
   'Wikipédia — "1930 FIFA World Cup"',
   'https://en.wikipedia.org/wiki/1930_FIFA_World_Cup',
   1930, 'approved'),
  ('A Copa do Mundo de 2018, na Rússia, foi a primeira a usar o árbitro de vídeo (VAR) e viu o número de pênaltis disparar em relação às edições anteriores, batendo o recorde de gols de pênalti que vinha desde 1998. Quantos gols de pênalti foram marcados naquela edição?',
   22, 'gols', 'futebol', 2,
   'Wikipédia — "Video assistant referee"',
   'https://en.wikipedia.org/wiki/Video_assistant_referee',
   2018, 'approved');
