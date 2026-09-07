-- Onda 1 do tópico brasil (além das 4 perguntas já existentes em supabase/seed.sql) — lote de 5
-- perguntas, moldes inéditos no banco: extensão da FRONTEIRA TERRESTRE somando os limites com os
-- dez países vizinhos (16.885 km — ângulo de território/fronteira, distinto de "população de
-- cidade" e "município de estado" já usados); recorde de MENOR TEMPERATURA já registrada em solo
-- brasileiro (-14 °C, Caçador/SC, 1952 — recorde natural contraintuitivo por o Brasil ter fama de
-- país tropical); extensão da MALHA RODOVIÁRIA PAVIMENTADA (213.500 km — ângulo de infraestrutura,
-- contraintuitivo porque é uma fração pequena da malha total de um país que depende do caminhão
-- pra escoar quase tudo); EXPECTATIVA DE VIDA ao nascer hoje, ancorada num contraste histórico com
-- os ~51 anos dos anos 1950 (ângulo de demografia); e quantidade de UNIDADES DE CONSERVAÇÃO
-- FEDERAIS administradas pelo ICMBio (335 — ângulo de biodiversidade/natureza, distinto de
-- "frota de veículos" já usado).
--
-- Descartados antes de fechar o lote:
-- - Número de aeroportos com voos regulares no Brasil — sem fonte com contagem oficial única e
--   atual (ANAC bloqueou acesso direto na busca e a Wikipédia não fecha um total certificável).
-- - Produção de café do Brasil na safra mais recente (sacas) — sem fonte atual e citável com o
--   número exato (CONAB bloqueou acesso direto; a Wikipédia só tinha toneladas de 2011,
--   desatualizado demais pra valer como fonte).
--
-- Já nasce 'approved': cada pergunta foi pesquisada e a fonte verificada no momento de ser escrita
-- (mesmo processo do curador-perguntas + skill achometro-perguntas). Sem fonte travada única pro
-- lote — cada item caiu numa fonte diferente pela hierarquia do critério 1: fronteira e clima
-- vieram de Wikipédia citando a origem (CIA World Factbook e EPAGRI, respectivamente — nível 2,
-- agregador consolidado citando origem, usado porque os órgãos brasileiros oficiais bloquearam
-- acesso direto na busca); malha rodoviária também via Wikipédia citando a CNT; expectativa de
-- vida veio direto do World Bank Open Data (nível 2, agregador consolidado com série histórica
-- da ONU); unidades de conservação veio de Wikipédia citando Agência Gov (nível 1/2, comunicação
-- oficial do governo federal sobre o próprio ICMBio). Todas com `answer` inteiro por causa da
-- constraint `questions_answer_integer_check` — inclusive a menor temperatura, que é um inteiro
-- negativo (-14), permitido pela constraint (trunc(-14) = -14) e pela função de pontuação (usa
-- `abs()` na diferença, então não quebra com gabarito negativo).
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('O Brasil faz fronteira terrestre com dez dos doze países da América do Sul — só não encosta em Chile e Equador. Quantos quilômetros tem essa fronteira toda, somando os limites com todos os vizinhos?',
   16885, 'km', 'brasil', 2,
   'Wikipédia — "Fronteiras do Brasil" (citando CIA World Factbook)',
   'https://pt.wikipedia.org/wiki/Fronteiras_do_Brasil',
   2024, 'approved'),
  ('O Brasil tem fama de país tropical, mas o Sul pega geada boa parte do inverno. Qual foi a menor temperatura já registrada oficialmente em solo brasileiro, em graus Celsius (conte o número negativo)?',
   -14, 'graus Celsius', 'brasil', 2,
   'Wikipédia — "Clima do Brasil" (citando EPAGRI)',
   'https://pt.wikipedia.org/wiki/Clima_do_Brasil',
   1952, 'approved'),
  ('O Brasil movimenta a maior parte da sua carga por caminhão, não por trem. Quantos quilômetros da malha rodoviária brasileira estão pavimentados hoje?',
   213500, 'km', 'brasil', 3,
   'Wikipédia — "Roads in Brazil" (citando CNT — Confederação Nacional do Transporte)',
   'https://en.wikipedia.org/wiki/Roads_in_Brazil',
   2023, 'approved'),
  ('Nos anos 1950, um brasileiro recém-nascido tinha expectativa de vida em torno de 51 anos. Quantos anos um brasileiro pode esperar viver hoje, em média?',
   76, 'anos', 'brasil', 2,
   'World Bank Open Data — "Life expectancy at birth, total (Brazil)"',
   'https://data.worldbank.org/indicator/SP.DYN.LE00.IN?locations=BR',
   2024, 'approved'),
  ('O ICMBio é o órgão federal que cuida dos parques e reservas naturais do Brasil. Quantas unidades de conservação federais ele administra hoje pelo país?',
   335, 'unidades de conservação', 'brasil', 3,
   'Wikipédia — "Instituto Chico Mendes de Conservação da Biodiversidade" (citando Agência Gov, 2023)',
   'https://pt.wikipedia.org/wiki/Instituto_Chico_Mendes_de_Conserva%C3%A7%C3%A3o_da_Biodiversidade',
   2023, 'approved');
