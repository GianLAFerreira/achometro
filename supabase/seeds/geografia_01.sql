-- Lote 1 do tópico geografia — 5 perguntas, moldes inéditos no banco (só havia 2 perguntas de
-- geografia antes: profundidade do Challenger Deep e distância em linha reta Macapá–Passo Fundo,
-- nenhuma repetida aqui em fato-base ou molde): extensão total da GRANDE MURALHA DA CHINA somando
-- todos os trechos e fortificações de todas as dinastias, contra o trecho Ming mais conhecido
-- (molde: comprimento de estrutura, China); área do maior DESERTO do mundo pelo critério técnico
-- de precipitação — o Deserto Antártico, não o Saara (molde: área, comparação/definição
-- contraintuitiva); quantos dos 26 ESTADOS BRASILEIROS não têm acesso ao mar, apesar do litoral
-- brasileiro estar entre os mais extensos do mundo (molde: contagem, Brasil); quantos PAÍSES fazem
-- fronteira terrestre com a Rússia, apesar de seu território ser quase o dobro do segundo maior do
-- mundo (molde: contagem de fronteiras, comparação de escala); e a altitude de LA PAZ, capital mais
-- alta do mundo (molde: altitude de cidade, distinto da profundidade oceânica já usada no banco).
--
-- Descartados após pesquisa (motivo em uma frase cada):
-- - Extensão da fronteira Brasil–Bolívia (maior fronteira terrestre do Brasil, ~3.423 km) —
--   molde repetido: é outra "distância em km envolvendo o Brasil", parecido demais com a
--   pergunta já existente de Macapá–Passo Fundo (3.148 km), mesma ordem de grandeza e mesmo tipo
--   de resposta.
-- - Quantidade de fusos horários oficiais da Rússia (11, reforma de 2014) — reprovado pelo
--   critério 4 (divertida): a intuição de "país gigantesco = muitos fusos" já bate com o número
--   real, sem gerar surpresa nem debate de mesa.
--
-- Já nasce 'approved': cada pergunta foi pesquisada e a fonte verificada no momento de ser
-- escrita (mesmo processo do curador-perguntas + skill achometro-perguntas), item a item
-- conferido para garantir que o texto de fato sustenta o número citado. Fontes: a Grande Muralha
-- usa a Wikipédia como agregador (nível 2) citando a origem oficial (levantamento de 2012 da
-- State Administration of Cultural Heritage da China) — mesmo caso previsto no critério 1 do
-- curador para "agregador quando cita a origem"; o deserto Antártico, o litoral do Brasil, as
-- fronteiras da Rússia e a altitude de La Paz usam Wikipédia como agregador consolidado (nível 2)
-- diretamente, sem divergência relevante entre fontes checadas. Todas com `answer` inteiro por
-- causa da constraint `questions_answer_integer_check` — a extensão da Grande Muralha (21.196,18
-- km) foi arredondada para o km mais próximo (21196).
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('O trecho mais conhecido da Grande Muralha da China, perto de Pequim, tem cerca de 8.850 km. Somando todos os trechos, trincheiras e fortificações de todas as dinastias, qual é a extensão total da muralha, em km, segundo o levantamento oficial do governo chinês de 2012 (arredondando para o inteiro mais próximo)?',
   21196, 'km', 'geografia', 3,
   'Wikipédia — "Great Wall of China" (citando levantamento de 2012 da State Administration of Cultural Heritage da China)',
   'https://en.wikipedia.org/wiki/Great_Wall_of_China',
   2012, 'approved'),
  ('Deserto, por definição, é qualquer região de pouquíssima precipitação — não precisa ter areia nem calor. Pelo critério oficial, o maior deserto do mundo não é o Saara, e sim o Deserto Antártico, coberto de gelo. Qual é a área dele, em km²?',
   14200000, 'km²', 'geografia', 3,
   'Wikipédia — "Desert" (tabela dos dez maiores desertos do mundo)',
   'https://en.wikipedia.org/wiki/Desert',
   2024, 'approved'),
  ('O Brasil tem quase 11 mil km de litoral, um dos mais extensos do mundo. Mesmo assim, quantos dos seus 26 estados não têm nenhum acesso ao mar?',
   9, 'estados', 'geografia', 2,
   'Wikipédia — "Litoral do Brasil" (citando dados do IBGE)',
   'https://pt.wikipedia.org/wiki/Litoral_do_Brasil',
   2024, 'approved'),
  ('A Rússia é o maior país do mundo em área — quase o dobro do Canadá, o segundo colocado. Quantos países fazem fronteira terrestre com ela?',
   14, 'países', 'geografia', 2,
   'Wikipédia — "Borders of Russia"',
   'https://en.wikipedia.org/wiki/Borders_of_Russia',
   2024, 'approved'),
  ('La Paz, sede do governo da Bolívia, é considerada a capital mais alta do mundo, erguida em pleno planalto andino. A que altitude, em metros, ela fica?',
   3640, 'metros', 'geografia', 2,
   'Wikipédia — "List of national capitals by elevation"',
   'https://en.wikipedia.org/wiki/List_of_national_capitals_by_elevation',
   2024, 'approved');
