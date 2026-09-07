-- Onda 8 do tópico futebol — lote enxuto (4 perguntas), 100% internacional, com forma
-- deliberadamente diferente de tudo já usado: recorde de idade, recorde individual defensivo
-- (minutos sem sofrer gol) e duas curiosidades de regra (uma administrativa de Copa do Mundo,
-- outra fundamental do próprio jogo, IFAB). Nenhuma é "estatística de carreira", "recorde de
-- público", "campeão histórico" ou "transferência recorde" — moldes já bem explorados nas ondas
-- anteriores. Já nasce 'approved': cada pergunta foi pesquisada e a fonte verificada no momento de
-- ser escrita (mesmo processo do curador-perguntas + skill achometro-perguntas). Sem fonte travada
-- única pro lote — cada assunto buscou sua própria fonte pela hierarquia (oficial > agregador
-- consolidado > imprensa de referência).
--
-- Descartados do pool de candidatos:
-- - "Gol mais rápido da história da Copa do Mundo" (Hakan Şükür, 1958... 2002, 11s) — já
--   pesquisado e descartado no lote 6 (redundância de forma com recorde de disputa de pênaltis);
--   confirmado de novo aqui (Guinness, 11s) só para checar, mas mantido fora pelo mesmo motivo.
-- - "Recorde de mais cartões vermelhos numa única partida" (Claypole x Victoriano Arenas, 2011,
--   36 expulsões) — já pesquisado e descartado no lote 7 por instabilidade de fonte (a própria
--   história do recorde tem valores conflitantes ao longo dos anos: 20, 23, 36). Achamos uma
--   página oficial do Guinness com 36, mas não reabrimos a decisão anterior — o fato-base já foi
--   avaliado e reprovado, não é caso de "fonte nova apareceu".
-- - "Maior público pagante da história de uma Copa do Mundo" (Maracanaço, 1950, ~173.850) —
--   mesmo fato-base do Maracanã já coberto por "público recorde em clássicos/finais por estádio"
--   (lote 1) e já descartado por sobreposição no lote 5.
-- - "Marta, maior artilheira da história das Copas do Mundo somando homens e mulheres" (17 gols) —
--   fonte oficial limpa (FIFA), mas descartada por redundância de forma com a pergunta já aprovada
--   da Christine Sinclair (lote 7): as duas seriam "recorde de gols que não é do CR7/Messi, é de
--   uma mulher", mesmo gancho repetido.
-- - "Jogador de futebol profissional mais alto da história" — descartado por falta de fonte única
--   e citável: números conflitantes entre veículos (2,08 m, 2,11 m, 2,26 m) sem página oficial do
--   Guinness que resolva a divergência (critério 1/2 do curador).
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('A maioria dos goleiros de seleção pendura as chuteiras bem antes dos 40 anos. Mas o egípcio Essam El-Hadary ainda fazia sua estreia em Copas do Mundo depois disso — e, contra a Arábia Saudita, na edição de 2018, na Rússia, se tornou o jogador mais velho a entrar em campo na história do torneio. Quantos anos ele tinha?',
   45, 'anos', 'futebol', 2,
   'ABC News (Austrália) — "Essam El Hadary becomes oldest ever player at a World Cup"',
   'https://www.abc.net.au/news/2018-06-26/essam-el-hadary-becomes-oldest-ever-player-at-a-world-cup/9908938',
   2018, 'approved'),
  ('Um goleiro raramente passa mais de duas ou três partidas seguidas sem sofrer gol. Mas o holandês Edwin van der Sar, do Manchester United, bateu o recorde histórico da Premier League ao ficar impossível de vazar por 14 jogos seguidos, entre novembro de 2008 e março de 2009. Quantos minutos ele ficou sem sofrer gol nessa sequência, segundo o Guinness World Records?',
   1311, 'minutos', 'futebol', 3,
   'Guinness World Records — "Longest football (soccer) Premier League clean sheet"',
   'https://www.guinnessworldrecords.com/world-records/81295-longest-football-soccer-premier-league-clean-sheet',
   2009, 'approved'),
  ('Durante décadas, cada seleção só podia levar 23 jogadores para uma Copa do Mundo. Isso mudou na edição de 2022, no Catar, quando a FIFA ampliou o limite por causa do calendário apertado pela pandemia. Quantos jogadores cada seleção passou a poder inscrever a partir daquela edição?',
   26, 'jogadores', 'futebol', 1,
   'Goal.com — "FIFA approves 26-man squads for 2022 World Cup"',
   'https://www.goal.com/en/news/fifa-approves-26-man-squads-for-2022-world-cup/blt11a0dec44b28298d',
   2022, 'approved'),
  ('Uma partida de futebol começa com 11 jogadores em campo de cada lado. Mas as regras do próprio jogo (IFAB) permitem que ela continue mesmo depois de várias expulsões ou lesões, até um limite mínimo por equipe. Qual é esse número mínimo de jogadores por time para uma partida não ser interrompida?',
   7, 'jogadores', 'futebol', 2,
   'IFAB — "Laws of the Game 2025/26, Law 3: The Players"',
   'https://www.theifab.com/laws/latest/the-players/',
   2025, 'approved');
