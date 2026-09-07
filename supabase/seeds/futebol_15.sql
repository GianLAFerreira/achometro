-- Onda 15 do tópico futebol — lote enxuto (4 perguntas), moldes inéditos no banco: gols marcados
-- por um lateral (defensor) ao longo da carreira de clubes (as ondas anteriores de "gols na
-- carreira" só haviam tocado atacante/meia — lote 3 — e goleiro — lote 13; defensor nunca foi
-- usado), total de cartões vermelhos mostrados ao longo de uma única edição inteira de Copa do
-- Mundo (distinto de "cartões vermelhos na carreira de um jogador", lote 1 — aqui o sujeito é o
-- torneio, não uma pessoa, e a métrica nunca fora usada), total de partidas disputadas por um
-- jogador vestindo a camisa de um único clube ao longo de toda a carreira (distinto de caps pela
-- seleção — Cafu, lote 11 — e de jogos numa divisão específica — Shilton, lote 11: aqui a métrica
-- é lealdade a um clube só, em todas as competições) e número de vezes que um jogador foi vítima
-- de falta ao longo de uma única edição de Copa do Mundo (nunca tocado — os recordes físicos e de
-- sofrimento até aqui eram sobre distância percorrida, lote 14, nunca sobre faltas sofridas).
--
-- Descartados antes de pesquisar a fundo (cruzados contra o rastreamento acumulado):
-- - "Austrália 31 x 0 Samoa Americana (2001), maior goleada internacional" — descartado assim que
--   a checagem contra o próprio lote 9 revelou que é o MESMO jogo já usado lá (Archie Thompson, 13
--   gols na partida); só o número extraído seria diferente (placar vs. gols de um jogador), não o
--   gancho.
-- - "Técnico mais jovem já campeão de Copa do Mundo" (Suppici) — já reprovado 2x (lotes 12, 13)
--   por divergência irreconciliável de fonte. Não tentado uma terceira vez, como já instruído.
-- - "Jogador de futebol mais alto da história" — já reprovado por falta de fonte única. Não
--   retestado.
--
-- Descartados depois de pesquisar:
-- - "Maior contratação já paga por um clube brasileiro" — Transfermarkt bloqueou o acesso via
--   WebFetch e não foi encontrada outra fonte única e citável a tempo; abandonado por limitação de
--   ferramenta, não por mérito. Fica como ideia para uma leva futura.
-- - "El Salvador 1 x 10 Hungria (Copa de 1982), mais gols sofridos numa única partida de Copa" —
--   descartado ao perceber que é o mesmo gancho de "gols numa única partida de Copa do Mundo" já
--   usado no lote 9 (Áustria 7 x 5 Suíça, 1954), só invertendo a perspectiva (quem sofreu, em vez
--   de quem fez).
-- - "Recorde de assistências de Maradona na Copa de 1986" — pesquisado (Wikipédia, artigo do
--   jogador), mas o texto só confirma 5 assistências na campanha, sem tratá-las como recorde
--   explícito do torneio; descartado por falta de fonte que sustente "recorde". A mesma pesquisa
--   revelou outro dado do mesmo jogo, esse sim citado como recorde (53 faltas sofridas no
--   torneio) — aproveitado como a 4ª pergunta do lote no lugar.
-- - "Total de cartões numa única final de Copa do Mundo" (Espanha x Holanda, 2010, 14 cartões,
--   recorde de finais) — confirmado e bom candidato, mas descartado por redundância dentro do
--   próprio lote com a pergunta de cartões vermelhos da Copa de 2006 (ambas seriam "recorde de
--   cartões numa Copa do Mundo"); mantido fora para variar mais o lote, não por falha de fonte.
--
-- Já nasce 'approved': cada pergunta foi pesquisada e a fonte verificada no momento de ser escrita
-- (mesmo processo do curador-perguntas + skill achometro-perguntas). Sem fonte travada única pro
-- lote — cada assunto buscou sua própria fonte pela hierarquia (oficial > agregador consolidado >
-- imprensa de referência); as quatro caíram em Wikipédia como agregador consolidado (nível 2),
-- checado item a item para conferir se o texto de fato sustenta o número, não só citado de
-- memória.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('Um lateral-esquerdo costuma fechar a carreira inteira com menos de duas dezenas de gols — não é função dele balançar a rede. Mas o brasileiro Roberto Carlos, boa parte da carreira no Real Madrid, ficou famoso justamente pelos chutes de longe e cobranças de falta impossíveis para um goleiro. Quantos gols ele marcou ao todo na carreira de clubes?',
   71, 'gols', 'futebol', 2,
   'Wikipédia — "Roberto Carlos (footballer, born 1973)" (tabela de estatísticas de carreira)',
   'https://en.wikipedia.org/wiki/Roberto_Carlos_(footballer,_born_1973)',
   2015, 'approved'),
  ('Uma Copa do Mundo costuma reunir uma dúzia de expulsões ao longo de um mês inteiro de jogos. Mas a edição de 2006, na Alemanha, ficou marcada pelo rigor extremo da arbitragem — o auge foi a partida entre Portugal e Holanda nas oitavas de final, apelidada de "Batalha de Nuremberg", em que o árbitro russo Valentin Ivanov sozinho mostrou 20 cartões. Quantos cartões vermelhos foram mostrados ao todo durante todo o torneio de 2006, o maior número já registrado numa única edição da Copa?',
   28, 'cartões vermelhos', 'futebol', 2,
   'Wikipédia — "2006 FIFA World Cup" (seção "Unprecedented number of cards")',
   'https://en.wikipedia.org/wiki/2006_FIFA_World_Cup',
   2006, 'approved'),
  ('Um jogador de elite que passa a carreira inteira num único clube costuma somar 400, 500 partidas, quando muito. Mas o zagueiro italiano Paolo Maldini vestiu a camisa do AC Milan por 25 temporadas seguidas, entre 1984 e 2009, sem nunca defender outro clube profissional. Quantas partidas ele disputou ao todo pelo Milan, somando todas as competições — recorde do clube que segue de pé?',
   902, 'jogos', 'futebol', 2,
   'Wikipédia — "Paolo Maldini"',
   'https://en.wikipedia.org/wiki/Paolo_Maldini',
   2009, 'approved'),
  ('Num jogo de Copa do Mundo, um armador habilidoso leva falta várias vezes por partida, mas isso raramente vira um recorde à parte. Na edição de 1986, no México, o argentino Diego Maradona foi tão perseguido pelos adversários — que não sabiam como pará-lo de outro jeito — que se tornou o jogador mais faltado da história de uma única edição do torneio, disputando todos os 7 jogos da campanha do título argentino. Quantas vezes ele foi vítima de falta ao longo daquela Copa?',
   53, 'faltas sofridas', 'futebol', 3,
   'Wikipédia — "Diego Maradona"',
   'https://en.wikipedia.org/wiki/Diego_Maradona',
   1986, 'approved');
