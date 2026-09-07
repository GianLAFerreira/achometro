-- Onda 18 do tópico futebol — lote enxuto (3 perguntas), moldes inéditos no banco: especificação
-- física de um objeto do futebol (peso da taça da Copa do Mundo — nunca tocado; recordes de
-- público já usados eram sobre espectadores, não sobre o troféu), sequência de partidas
-- consecutivas disputadas sem desfalcar o time (Harold Bell — eixo diferente do gancho já saturado
-- de invencibilidade/sequência invicta, que mede resultado; aqui mede presença/seleção, não
-- vitória ou empate) e gols combinados de um trio de ataque numa única temporada (MSN do
-- Barcelona — nunca tocado; todo gancho de "gols numa temporada" já usado media ou um time inteiro
-- ou um jogador isolado, nunca uma dupla/trio específico).
--
-- Removida na revisão da sessão principal: "quantas Bolas de Ouro Messi já venceu" (8, Guinness) —
-- exatamente a mesma pergunta que o usuário já tinha mandado remover do lote 7 (2026-09-06) por
-- ser conhecimento geral demais (quem acompanha futebol já sabe que Messi é disparado o maior
-- vencedor do prêmio). O agente deste lote 18 não tinha essa decisão registrada no rastreamento
-- acumulado (ela não veio de uma reprovação do curador, veio de uma decisão do usuário sobre uma
-- pergunta já aprovada) — reintroduzida por engano, removida de novo aqui.
--
-- Descartados antes de pesquisar a fundo (cruzados contra o rastreamento acumulado):
-- - "Recorde de gols de um jogador numa única edição/temporada da Champions League" (ex.: CR7,
--   17 gols em 2013-14) — mesmo desenho de "artilheiro isolado de uma única edição de torneio" já
--   usado 3 vezes trocando só a competição (Copa do Mundo/Fontaine lote 7, Eurocopa/Platini
--   lote 7, Libertadores/Onega lote 17); gancho tratado como esgotado, não repetir uma 4ª vez.
-- - "Artilheiro isolado de uma edição de Copa América" — mesmo motivo acima.
-- - "Total de cartões amarelos na carreira de um jogador" — cartão é gancho saturado (ver
--   rastreamento: Sergio Ramos já descartado por esse motivo no lote 17).
--
-- Descartados depois de pesquisar:
-- - "Maior estádio de futebol do mundo por capacidade" — a Wikipédia diverge de forma
--   inconciliável: cita o Narendra Modi Stadium (estádio primariamente de críquete, na Índia)
--   como "maior estádio de futebol", o que comprometeria a credibilidade da pergunta na mesa.
--   Sem fonte que resolva essa ambiguidade, descartado.
-- - "Recorde Guinness de mais assistências numa única partida profissional" — página do Guinness
--   World Records retornou 404; sem fonte rastreável, descartado.
--
-- Já nasce 'approved': cada pergunta foi pesquisada e a fonte verificada no momento de ser escrita
-- (mesmo processo do curador-perguntas + skill achometro-perguntas). Sem fonte travada única pro
-- lote — as quatro caíram em Wikipédia como agregador consolidado (nível 2), checado item a item
-- para conferir se o texto de fato sustenta o número, não só citado de memória. O peso da taça
-- (ítem 2) é reportado em gramas, não quilos, por causa da constraint do banco que exige answer
-- inteiro (`questions_answer_integer_check`).
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('A taça atual da Copa do Mundo é maciça por fora mas oca por dentro — feita de ouro 18 quilates com uma base de duas camadas de malaquita, mede 36,8 cm de altura e é erguida por um campeão diferente a cada edição desde 1974. Quantos gramas ela pesa?',
   6175, 'gramas', 'futebol', 2,
   'Wikipédia — "FIFA World Cup Trophy"',
   'https://en.wikipedia.org/wiki/FIFA_World_Cup_Trophy',
   1974, 'approved'),
  ('O zagueiro inglês Harold Bell defendeu o Tranmere Rovers e ficou famoso por nunca ser poupado nem desfalcar o time numa sequência iniciada na temporada 1946-47, que só terminou em agosto de 1955. Quantas partidas consecutivas ele disputou nesse período — um recorde do futebol inglês que resiste até hoje?',
   401, 'partidas', 'futebol', 3,
   'Wikipédia — "Harold Bell (footballer)"',
   'https://en.wikipedia.org/wiki/Harold_Bell_(footballer)',
   1955, 'approved'),
  ('Na temporada 2014-15, o ataque do Barcelona formado por Lionel Messi, Neymar e Luis Suárez — apelidado de MSN — foi tão avassalador que bateu um recorde de gols combinados numa única temporada, somando todas as competições. Quantos gols os três marcaram juntos naquele ano?',
   122, 'gols', 'futebol', 2,
   'Wikipédia — "2014–15 FC Barcelona season"',
   'https://en.wikipedia.org/wiki/2014%E2%80%9315_FC_Barcelona_season',
   2015, 'approved');
