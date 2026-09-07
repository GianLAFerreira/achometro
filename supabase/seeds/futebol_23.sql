-- Onda 23 do tópico futebol — lote de 4 perguntas, seguindo a mesma instrução explícita do usuário
-- do lote 22: nada de Copa do Mundo/Champions/Brasileirão/Premier League/seleções grandes — só
-- ligas, seleções menores e curiosidades de futebol fora do circuito mainstream. Não repete nenhum
-- clube/competição já usado no lote 22 (Butão x Montserrat, Auckland City, KÍ Klaksvík, Durand Cup).
--
-- San Marino (seleção nacional) — apontada pela própria Wikipédia como a pior seleção filiada à
-- FIFA do mundo. O fato-base é o total de vitórias oficiais em TODA a sua história desde a fundação
-- em 1990 (amistosos + competitivas somados): só 3, e as três contra o MESMO adversário
-- (Liechtenstein). Ângulo inédito no banco: total de vitórias de carreira de uma seleção inteira
-- (nunca "sequência invicta", que é gancho saturado — aqui é o oposto, a escassez de vitórias).
--
-- Estádio Hernando Siles (La Paz, Bolívia) — virou símbolo da disputa entre a Bolívia e a FIFA
-- depois que a entidade baniu, em 2007, jogos oficiais de qualificatórias em estádios acima de
-- 2.500m de altitude (decisão revertida meses depois após protesto de Evel Morales e outros).
-- Ângulo inédito: altitude de um estádio em metros — nenhuma pergunta do banco tinha usado esse
-- tipo de medida até agora (as anteriores eram gols, títulos, distância percorrida em campo, etc.).
--
-- Ilhas Feroé (seleção nacional) — arquipélago de pouco mais de 50 mil habitantes, a menor
-- população entre as seleções filiadas à UEFA. Fato-base: a melhor posição que já alcançou no
-- ranking da FIFA (74º lugar, atingida em julho de 2015 e repetida em outubro de 2016), segundo o
-- próprio infobox da Wikipédia. Ângulo inédito: posição de ranking em vez de contagem de algo.
--
-- Victoria Stadium (Gibraltar) — quando Gibraltar entrou para a UEFA em 2013, seu único estádio
-- nacional foi vetado por não atender aos padrões da entidade, obrigando a seleção a mandar seus
-- jogos "em casa" de qualificatórias em Portugal (Estádio Algarve) por anos. Fato-base: a
-- capacidade de público do próprio estádio, tão pequena que motivou o veto.
--
-- Descartados depois de pesquisar (nenhum entrou no lote):
-- - Guam, salto no ranking da FIFA em 2014-2015 (chegou ao 146º lugar, seu melhor histórico, após
--   vitórias sobre Turcomenistão e Índia) — a Wikipédia não dá um número de partida (ranking
--   "antes" da subida) que permita calcular quantas posições o time de fato subiu; sem essa
--   baseline, o fato vira aproximação, não número verificável. Critério 2.
-- - Gibraltar, quantas partidas oficiais disputou até sua primeira vitória competitiva (1x0 sobre a
--   Armênia, 2018) — a tabela de resultados da Wikipédia mistura amistosos e jogos competitivos na
--   contagem de "33 partidas" sem permitir isolar com segurança só as competitivas. Critério 2.
-- - CONIFA World Football Cup, total de seleções diferentes que já disputaram as 3 edições (2014,
--   2016, 2018) — a Wikipédia cita "27 times no total", mas a frase não tem nenhuma referência/nota
--   de rodapé, e os números por edição (12+12+16=40) não batem sozinhos com o total sem uma checagem
--   independente de sobreposição — risco de ser síntese do próprio editor da Wikipédia, não fato
--   citável de fonte primária. Critério 2.
-- - Isles of Scilly Football League ("menor liga de futebol do mundo", só 2 times) — a Wikipédia dá
--   uma faixa ("entre quatorze e vinte vezes" que os dois times se enfrentam por temporada), não um
--   número único verificável. Critério 2/3.
-- - Greenlandic Football Championship, número de times na fase final (8, "as of 2022") — frase sem
--   nenhuma citação/nota de rodapé na Wikipédia, ao contrário de outras frases do mesmo artigo que
--   têm referência explícita logo ao lado. Critério 2.
-- - Sikkim Gold Cup (Índia), ano de fundação — a própria Wikipédia se contradiz: o texto do artigo
--   diz 1979, mas as categorias do artigo dizem 1986. Divergência dentro da MESMA fonte, sem como
--   escolher um número. Critério 1/2.
--
-- Já nasce 'approved': cada pergunta foi pesquisada e a fonte verificada no momento de ser escrita
-- (mesmo processo do curador-perguntas + skill achometro-perguntas), conferindo se o texto da fonte
-- de fato sustenta o número citado. Todas as quatro caíram em Wikipédia como agregador consolidado
-- (nível 2) — não havia fonte oficial de nível 1 (federação/confederação) cobrindo esses recortes
-- específicos de forma mais direta que os próprios infoboxes/artigos da Wikipédia.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('San Marino, fundada em 1990, é apontada como a pior seleção nacional de futebol do mundo — e todas as vitórias que ela já teve na história foram contra o mesmo adversário, Liechtenstein. Quantas vitórias oficiais são essas, somando amistosos e jogos competitivos?',
   3, 'vitórias', 'futebol', 2,
   'Wikipédia — "San Marino national football team"',
   'https://en.wikipedia.org/wiki/San_Marino_national_football_team',
   2024, 'approved'),
  ('O Estádio Hernando Siles, em La Paz, fica tão alto que em 2007 a FIFA chegou a proibir jogos oficiais de qualificatórias por lá, achando que dava vantagem desleal à Bolívia — decisão revertida meses depois após protestos. A quantos metros de altitude ele fica?',
   3582, 'metros', 'futebol', 2,
   'Wikipédia — "Estadio Hernando Siles"',
   'https://en.wikipedia.org/wiki/Estadio_Hernando_Siles',
   2007, 'approved'),
  ('As Ilhas Feroé têm pouco mais de 50 mil habitantes, a menor população entre as seleções filiadas à UEFA, mas já chegaram mais perto do topo do futebol mundial do que se imagina. Qual foi a melhor posição que a seleção feroesa já alcançou no ranking da FIFA, atingida em 2015 e repetida em 2016?',
   74, 'posição', 'futebol', 2,
   'Wikipédia — "Faroe Islands national football team"',
   'https://en.wikipedia.org/wiki/Faroe_Islands_national_football_team',
   2016, 'approved'),
  ('Quando Gibraltar entrou para a UEFA em 2013, seu único estádio nacional foi vetado pela entidade por não atender aos padrões mínimos, obrigando a seleção a mandar seus jogos "em casa" de qualificatórias em Portugal por anos. Qual é a capacidade de público do Victoria Stadium, o estádio nacional de Gibraltar?',
   2300, 'lugares', 'futebol', 2,
   'Wikipédia — "Victoria Stadium (Gibraltar)"',
   'https://en.wikipedia.org/wiki/Victoria_Stadium_(Gibraltar)',
   2013, 'approved');
