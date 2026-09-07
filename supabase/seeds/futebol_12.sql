-- Onda 12 do tópico futebol — lote enxuto (4 perguntas), moldes inéditos no banco: recorde de
-- jogos apitados por um árbitro ao longo de várias Copas do Mundo (nunca tocado antes — os lotes
-- anteriores cobriram jogadores e técnicos, nunca arbitragem), recorde de jogos consecutivos
-- marcando gol numa temporada de liga (distinto de invencibilidade de equipe e de artilheiro de
-- carreira, já usados), valor de contrato de patrocínio de material esportivo de um jogador
-- (dinheiro fora de campo, nunca usado) e recorde de gols marcados por um único jogador numa
-- partida de Champions League (distinto de hat-trick mais rápido e de gol mais rápido de Copa,
-- já usados). Dois candidatos pesquisados nesta rodada foram descartados antes de entrar aqui:
-- "técnico mais jovem a vencer uma Copa do Mundo" (Alberto Suppici, 1930) reprovado por
-- divergência irreconciliável entre fontes — a própria FIFA Museum (tier 1) diz que ele tinha 36
-- anos, enquanto Wikipedia e outras fontes, batendo com a data de nascimento de 1898, dizem 31;
-- não há como fechar os dois números com aritmética simples, então preferiu-se descartar a
-- pergunta a arriscar um gabarito errado; e "recorde de cartões amarelos numa única partida de
-- Copa do Mundo" reprovado por reusar o mesmo fato-base (Battle of Nuremberg 2006 / Holanda x
-- Argentina 2022) que já sustenta o molde saturado de cartão vermelho recorde numa partida, com o
-- agravante de o próprio Guinness não ter atualizado o registro de 2006 apesar da imprensa
-- reportar quebra do recorde em 2022. Já nasce 'approved': cada pergunta foi pesquisada e a fonte
-- verificada no momento de ser escrita (mesmo processo do curador-perguntas + skill
-- achometro-perguntas). Sem fonte travada única pro lote — cada assunto buscou sua própria fonte
-- pela hierarquia (oficial > agregador consolidado > imprensa de referência).
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('Um árbitro de Copa do Mundo costuma apitar 2 ou 3 jogos por edição, quando muito, e raramente repete presença em mais de um Mundial seguido. Mas o uzbeque Ravshan Irmatov apitou partidas em três Copas seguidas — 2010, 2014 e 2018, incluindo uma semifinal —, um recorde que nenhum árbitro chegou perto de igualar depois. Quantos jogos de Copa do Mundo ele apitou ao todo?',
   11, 'jogos', 'futebol', 2,
   'Guinness World Records — "Most football (soccer) FIFA World Cup matches refereed"',
   'https://www.guinnessworldrecords.com/world-records/90727-most-football-soccer-fifa-world-cup-finals-matches-refereed',
   2018, 'approved'),
  ('Um artilheiro em fase boa costuma balançar as redes em 3 ou 4 jogos seguidos, no máximo. Mas entre novembro de 2012 e maio de 2013, pelo Barcelona, Lionel Messi marcou gol em rodada após rodada de La Liga sem interrupção, um recorde reconhecido pelo Guinness que nem Cristiano Ronaldo chegou perto de igualar depois. Em quantos jogos seguidos ele balançou as redes?',
   21, 'jogos', 'futebol', 2,
   'Guinness World Records — "Most consecutive games scored in La Liga by an individual"',
   'https://www.guinnessworldrecords.com/world-records/725235-most-consecutive-games-scored-in-la-liga-by-an-individual',
   2013, 'approved'),
  ('Contratos de patrocínio de material esportivo de jogadores de futebol costumam girar na casa de poucos milhões de libras por ano, mesmo para os maiores astros. Mas em 2020 Neymar assinou com a Puma o maior contrato individual de patrocínio esportivo já registrado, superando os acordos de Messi (Adidas) e Cristiano Ronaldo (Nike) somados. Quantos milhões de libras esterlinas ele passou a receber por ano?',
   23, 'milhões de libras esterlinas', 'futebol', 2,
   'SoccerBible — "Neymar''s New PUMA Deal Is A Record Breaker"',
   'https://www.soccerbible.com/news/2020/09/neymar-s-new-puma-deal-is-a-record-breaker/',
   2020, 'approved'),
  ('Um atacante em grande fase costuma marcar 2 ou 3 gols numa noite inspirada de Champions League, raramente mais que isso. Mas em 2012, jogando pelo Barcelona contra o Bayer Leverkusen, Lionel Messi bateu um recorde da competição que só foi igualado depois, por Luiz Adriano (2014) e Erling Haaland (2023) — nunca superado. Quantos gols ele marcou naquela partida?',
   5, 'gols', 'futebol', 1,
   'Guinness World Records — "Most goals scored in a UEFA Champions League match"',
   'https://www.guinnessworldrecords.com/world-records/most-goals-scored-in-a-uefa-champions-league-match',
   2012, 'approved');
