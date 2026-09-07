-- Onda 13 do tópico futebol — lote enxuto (3 perguntas), moldes inéditos no banco e sujeitos fora
-- de Messi/Cristiano Ronaldo/Neymar (o lote 12 usou Messi em 2 das 4): recorde de gols marcados
-- por um goleiro na carreira (nunca tocado — os lotes anteriores de "gols na carreira" sempre
-- foram sobre atacantes), recorde de gols numa única edição da Eurocopa (nunca tocado — só Copa do
-- Mundo e Brasileirão haviam sido usados como "gols numa edição") e recorde de participações em
-- Copas do Mundo Femininas ao longo da carreira (distinto de caps pela seleção, já saturado — aqui
-- a métrica é número de edições disputadas, não jogos).
--
-- Removida na revisão da sessão principal: "Marta, recorde de gols em Copas do Mundo somando
-- homens e mulheres" (17 gols, Guinness) — o agente que gerou este lote argumentou que era
-- "distinto" do recorde de Christine Sinclair (todos os jogos internacionais, lote 7), mas o
-- gancho de diversão é idêntico ("recorde que não é de CR7/Messi, é de uma mulher") e o fato-base
-- (artilheira de Copas do Mundo) já havia sido pesquisado e descartado por esse motivo exato no
-- lote 8. Mantido fora para não reabrir uma decisão já tomada.
--
-- Divergência de fonte tratada: Rogério Ceni tem duas contagens tier 1 conflitantes — a contagem
-- oficial do São Paulo (131 gols, inclui amistosos) e o levantamento da FIFA/IFFHS (129, só
-- competições oficiais). Como a pergunta trata especificamente do recorde mundial de goleiro
-- artilheiro — uma alegação sobre competições oficiais —, prevaleceu o número da FIFA/IFFHS (129),
-- não o da contagem interna do clube.
--
-- Já nasce 'approved': cada pergunta foi pesquisada e a fonte verificada no momento de ser escrita
-- (mesmo processo do curador-perguntas + skill achometro-perguntas). Sem fonte travada única pro
-- lote — cada assunto buscou sua própria fonte pela hierarquia (oficial > agregador consolidado >
-- imprensa de referência).
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('Um goleiro raramente participa da parte ofensiva do jogo, muito menos bate faltas e pênaltis como um artilheiro. Mas o brasileiro Rogério Ceni, que defendeu o gol do São Paulo por 25 anos, tornou isso rotina e se consagrou o goleiro que mais balançou as redes na história do futebol. Quantos gols ele marcou ao todo na carreira, segundo o levantamento da FIFA/IFFHS para competições oficiais?',
   129, 'gols', 'futebol', 3,
   'FIFA/IFFHS (via Wikipédia — "Lista de gols de Rogério Ceni")',
   'https://pt.wikipedia.org/wiki/Lista_de_gols_de_Rog%C3%A9rio_Ceni',
   2015, 'approved'),
  ('Um artilheiro de Eurocopa costuma fechar o torneio com 4 ou 5 gols, quando muito. Mas o francês Michel Platini, na edição de 1984 disputada em casa, marcou em quase todas as partidas e segue até hoje como o maior artilheiro de uma única edição do torneio. Quantos gols ele marcou ao todo naqueles cinco jogos?',
   9, 'gols', 'futebol', 2,
   'UEFA — "Euro history makers: 1984, Michel Platini"',
   'https://www.uefa.com/uefaeuro/history/news/0253-0d811e08aca4-9adde9d7b0f6-1000--euro-history-makers-1984-michel-platini',
   1984, 'approved'),
  ('Um jogador de destaque costuma disputar 2 ou 3 Copas do Mundo ao longo da carreira, raramente mais que isso. Mas a brasileira Formiga esticou a carreira na seleção por 24 anos e chegou a um número de edições do Mundial que nenhum outro jogador, homem ou mulher, chegou perto de igualar. Quantas Copas do Mundo Femininas diferentes ela disputou, entre 1995 e 2019?',
   7, 'copas do mundo', 'futebol', 3,
   'The Analyst (Opta) — "Most Appearances at the Women''s World Cup"',
   'https://theanalyst.com/articles/most-appearances-at-the-womens-world-cup',
   2019, 'approved');
