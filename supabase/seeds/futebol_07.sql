-- Onda 7 do tópico futebol — lote com prioridade explícita para futebol internacional, já que o
-- banco (87 perguntas aprovadas até aqui) está fortemente concentrado em futebol brasileiro. Todas
-- as 7 perguntas deste lote são internacionais: Bola de Ouro, liga nacional estrangeira
-- (Bundesliga), Copa do Mundo fora do enfoque Brasil, futebol feminino, transferência mundial,
-- curiosidade/regra internacional e Copa América. Formas deliberadamente diferentes entre si e dos
-- lotes anteriores (que já usaram bastante "estatística de carreira de jogador brasileiro",
-- "recorde de campeão do Brasileirão" e "artilheiro histórico de competição continental" via
-- Alberto Spencer na Libertadores, lote 6).
-- Já nasce 'approved': cada pergunta foi pesquisada e a fonte verificada no momento de ser escrita
-- (mesmo processo do curador-perguntas + skill achometro-perguntas). Sem fonte travada única pro
-- lote — cada assunto buscou sua própria fonte pela hierarquia (oficial > agregador consolidado >
-- imprensa de referência).
--
-- Descartados do pool original de candidatos:
-- - "Cristiano Ronaldo, artilheiro histórico da Champions League" (140 gols, fonte UEFA.com) —
--   pesquisado e confirmado, mas descartado por redundância de forma dentro do próprio lote com a
--   pergunta da Christine Sinclair: as duas seriam "recorde de gols de carreira de um jogador num
--   palco de competição", forma repetida. Ficou a de Sinclair por gerar um gancho de diversão mais
--   forte (mulher com mais gols que Ronaldo e Messi juntos de recorde) e por cobrir a categoria de
--   futebol feminino pedida explicitamente.
-- - "Juventus, campeã da Serie A por 9 temporadas seguidas (2011-2020)" — pesquisado e confirmado,
--   mas descartado por redundância de forma com a pergunta do Bayern de Munique na Bundesliga:
--   ambas seriam "sequência de títulos consecutivos de um clube em liga nacional estrangeira".
-- - "Bayer Leverkusen invicto na Bundesliga inteira em 2023/24" (51 jogos sem perder, recorde
--   europeu) — cogitado como substituto mais chamativo para a pergunta do Bayern, mas descartado
--   por sobreposição de molde com o recorde de invencibilidade do Botafogo já usado em lote
--   anterior ("sequência de jogos invictos de um clube"), ainda que em liga diferente.
-- - "Recorde de mais cartões vermelhos numa única partida" — pesquisado, mas a própria história do
--   recorde é uma bagunça de fontes conflitantes ao longo dos anos (20 em Sportivo Ameliano x
--   General Caballero, Paraguai 1993; depois 36 em Atlético Claypole x Victoriano Arenas,
--   Argentina 2011; e ainda um caso brasileiro de 23 usado por alguns veículos como comparação) sem
--   uma página oficial do Guinness clara sobre qual valor está vigente hoje — reprovado pelo
--   critério 1/2 (fonte única e citável). Substituído pela expulsão mais rápida de uma Copa do
--   Mundo (José Batista, 1986), que tem fonte oficial limpa.
--
-- Nota de divergência de fonte (critério 1 do curador): a expulsão de José Batista na Copa de 1986
-- é creditada com 52 segundos pela reportagem oficial da FIFA (inside.fifa.com) e com 56 segundos
-- pelo Guinness World Records e por boa parte da imprensa. Por hierarquia, venceu a fonte oficial
-- do dado (FIFA) sobre o agregador/imprensa — o número usado é 52.
--
-- Removida por decisão do usuário (2026-09-06), depois de já aprovada pelo curador: "quantas Bolas
-- de Ouro Messi já venceu" (8). Não é falha de fonte/critério — é conhecimento geral demais para o
-- público do jogo, mesmo o número exato não sendo óbvio de cor: quem acompanha futebol já sabe que
-- Messi é disparado o maior vencedor do prêmio, então a pergunta não gera debate de mesa igual às
-- outras. Não substituída por outra pergunta de Bola de Ouro no mesmo lote.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('O Bayern de Munique foi campeão da Bundesliga ano após ano, sem interrupção, até ser surpreendido pelo Bayer Leverkusen na temporada 2023/24. Por quantos anos seguidos o Bayern não perdia o título alemão?',
   11, 'títulos seguidos', 'futebol', 2,
   'Guinness World Records — "Most consecutive Bundesliga title wins by a football club"',
   'https://www.guinnessworldrecords.com/world-records/470481-most-consecutive-bundesliga-title-wins-by-a-football-soccer-club',
   2023, 'approved'),
  ('Um artilheiro de Copa do Mundo hoje costuma marcar de 6 a 8 gols numa edição inteira. O francês Just Fontaine, que disputou um único Mundial na carreira, o de 1958, superou muito essa marca — um recorde que nem Pelé, Ronaldo Fenômeno ou Mbappé chegaram perto de igualar depois. Quantos gols ele marcou naquela Copa?',
   13, 'gols', 'futebol', 3,
   'FIFA.com — "Just Fontaine, France: goals in one edition record, 1958"',
   'https://www.fifa.com/en/tournaments/mens/worldcup/articles/just-fontaine-france-goals-one-edition-record-1958',
   1958, 'approved'),
  ('O recorde de mais gols em jogos internacionais não é de Cristiano Ronaldo nem de Messi: é da canadense Christine Sinclair, que jogou pela seleção do seu país por mais de duas décadas. Quantos gols ela marcou pelo Canadá — a maior marca entre homens e mulheres na história do futebol?',
   190, 'gols', 'futebol', 2,
   'Guinness World Records — "Most goals scored in international football matches by an individual (female)"',
   'https://www.guinnessworldrecords.com/world-records/77949-most-goals-scored-in-international-football-matches-by-an-individual-female',
   2023, 'approved'),
  ('Em 2017, o Paris Saint-Germain pagou a multa rescisória de Neymar ao Barcelona para tirá-lo da Espanha — um valor que dobrou o recorde mundial de transferências da época e segue invicto quase uma década depois. Quantos euros o PSG pagou?',
   222000000, 'euros', 'futebol', 1,
   'Al Jazeera — "Neymar signs PSG deal to complete world record transfer"',
   'https://www.aljazeera.com/sports/2017/8/3/neymar-signs-psg-deal-to-complete-world-record-transfer',
   2017, 'approved'),
  ('É raro ver alguém expulso nos primeiros segundos de uma Copa do Mundo. Mas na estreia do Uruguai contra a Escócia, em 1986, o zagueiro José Batista foi expulso quase junto com o apito inicial — a expulsão mais rápida da história dos Mundiais até hoje. Quantos segundos de jogo haviam se passado?',
   52, 'segundos', 'futebol', 3,
   'FIFA — "52 days to go: Batista''s red mist"',
   'https://inside.fifa.com/news/52-days-to-go-batistas-red-mist-2940553',
   1986, 'approved'),
  ('Por muito tempo o Uruguai foi o maior campeão da Copa América, com 15 títulos. Mas a Argentina ultrapassou essa marca ao vencer a edição de 2024. Com quantos títulos a Argentina se tornou a maior campeã da história do torneio?',
   16, 'títulos', 'futebol', 2,
   'Copa América (CONMEBOL) — "Every CONMEBOL Copa América Champion in History"',
   'https://copaamerica.com/en/news/all-of-the-conmebol-copa-america-champions',
   2024, 'approved');
