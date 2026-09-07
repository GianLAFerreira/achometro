-- Onda 9 do tópico futebol — lote enxuto (4 perguntas), mistura Brasil/internacional, formas
-- deliberadamente diferentes entre si: recorde histórico de gols numa única partida de Copa do
-- Mundo (soma dos dois times), recorde individual do Guinness numa única partida internacional,
-- recorde de velocidade (hat-trick mais rápido) e recorde histórico de artilharia de uma
-- competição nacional (Brasileirão) — este último ainda não tinha sido coberto para o Brasileirão
-- especificamente (só havia o equivalente pra Libertadores, no lote 6, com Alberto Spencer).
-- Já nasce 'approved': cada pergunta foi pesquisada e a fonte verificada no momento de ser escrita
-- (mesmo processo do curador-perguntas + skill achometro-perguntas). Sem fonte travada única pro
-- lote — cada assunto buscou sua própria fonte pela hierarquia (oficial > agregador consolidado >
-- imprensa de referência).
--
-- Descartados do pool original de candidatos:
-- - "Cristiano Ronaldo, artilheiro histórico da Champions League" (141 gols, fonte oficial
--   UEFA.com) — já pesquisado e descartado no lote 7 por redundância de forma com a pergunta da
--   Christine Sinclair (recorde de gols de carreira de um jogador num palco de competição); não
--   reaberto aqui pelo mesmo motivo, mesmo achando fonte tier 1 limpa de novo.
-- - "Maior invencibilidade de um clube em liga nacional europeia" (AC Milan, 58 jogos, 1991-1993)
--   — descartado por dois motivos: (1) redundância de forma com "sequência de jogos invictos" já
--   usada para clube do Brasileirão (lote 4) e para a Seleção Brasileira (lote 5); (2) instabilidade
--   de fonte sobre o que de fato é "o recorde" — imprensa diverge entre "recorde europeu" (Milan,
--   58), "recorde do futebol europeu" citando Steaua Bucareste (104) e "recorde mundial" citando
--   Al-Ahly (71), sem uma página oficial que resolva a divergência de escopo (critério 1/2 do
--   curador: dá pra achar o número, mas não uma fonte única que diga com clareza qual é "o"
--   recorde sendo comparado).
-- - "Maior goleada da Seleção Brasileira em jogo oficial" (10 a 1 sobre a Bolívia, 1949) —
--   descartado por redundância de forma com a pergunta de diferença de gols do Brasileirão já
--   usada no lote 4 ("maior diferença de gols numa partida").
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('Em pleno verão europeu de 1954, Áustria e Suíça se enfrentaram nas quartas de final da Copa do Mundo daquele ano, num jogo que ficou conhecido como a "Batalha de Lausana" por causa do calor extremo e da enxurrada de gols dos dois lados — a Suíça chegou a vencer por 3 a 0 e acabou perdendo a partida. Até hoje nenhum jogo de Copa do Mundo teve mais gols. Quantos gols saíram ao todo nessa partida, somando os dois times?',
   12, 'gols', 'futebol', 3,
   'Wikipédia — "Áustria 7–5 Suíça (1954)" (citando o relatório técnico oficial da FIFA)',
   'https://pt.wikipedia.org/wiki/%C3%81ustria_7%E2%80%935_Su%C3%AD%C3%A7a_(1954)',
   1954, 'approved'),
  ('Em 2001, nas eliminatórias da Copa do Mundo de 2002, a Austrália goleou a fraca seleção de Samoa Americana por um placar elástico — uma das maiores goleadas já registradas em jogos internacionais oficiais. Boa parte dos gols saiu do pé de um único jogador, o atacante Archie Thompson, que entrou para o Guinness World Records como o jogador que mais marcou sozinho numa única partida da história do futebol internacional. Quantos gols ele marcou nesse jogo?',
   13, 'gols', 'futebol', 2,
   'Guinness World Records — "Most goals scored in an international (individual)"',
   'https://www.guinnessworldrecords.com/world-records/76815-most-goals-scored-in-an-international-individual',
   2001, 'approved'),
  ('Um hat-trick costuma se espalhar por boa parte de uma partida, com 20, 30 ou mais minutos entre o primeiro e o terceiro gol. Mas o senegalês Sadio Mané, então no Southampton, fez os três gols de um hat-trick contra o Aston Villa tão rápido que entrou para o Guinness World Records como o mais veloz da história da Premier League inglesa. Quantos segundos separaram o primeiro do terceiro gol dele nesse jogo?',
   176, 'segundos', 'futebol', 3,
   'Guinness World Records — "Fastest hat-trick in a football (soccer) English Premier League match"',
   'https://www.guinnessworldrecords.com/world-records/385454-fastest-hat-trick-in-a-football-soccer-english-premier-league-match',
   2015, 'approved'),
  ('Quando o assunto é o maior artilheiro da história do Campeonato Brasileiro, muita gente pensa logo em nomes como Romário, Fred ou algum ídolo mais recente — mas o recorde é de Roberto Dinamite, ídolo do Vasco entre 1971 e 1992, que segue invicto até hoje. Quantos gols ele marcou ao todo no Brasileirão para chegar a esse recorde?',
   190, 'gols', 'futebol', 2,
   'Wikipédia — "Lista de artilheiros do Campeonato Brasileiro de Futebol"',
   'https://pt.wikipedia.org/wiki/Lista_de_artilheiros_do_Campeonato_Brasileiro_de_Futebol',
   2026, 'approved');
