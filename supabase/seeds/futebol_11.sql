-- Onda 11 do tópico futebol — lote enxuto (4 perguntas), moldes inéditos no banco: recorde de
-- jogos (caps) por um jogador pela Seleção Brasileira (distinto de gols de carreira, cartões
-- vermelhos e assistências, já usados nos lotes 1-10), recorde de mandato mais curto de um técnico
-- (nunca usado antes — nenhuma pergunta anterior tocou o lado da comissão técnica além de
-- "quantos técnicos passaram pelo clube", lote 1), recorde de assistências numa única temporada da
-- Premier League (estatística de passe, distinta de gols e cartões) e recorde de partidas
-- disputadas na primeira divisão inglesa ao longo de uma carreira (longevidade de carreira, não
-- gols/cartões). Já nasce 'approved': cada pergunta foi pesquisada e a fonte verificada no momento
-- de ser escrita (mesmo processo do curador-perguntas + skill achometro-perguntas). Sem fonte
-- travada única pro lote — cada assunto buscou sua própria fonte pela hierarquia (oficial >
-- agregador consolidado > imprensa de referência).
--
-- Cafu (jogos pela Seleção): CBF e FIFA divergem entre si (150 vs. 142) — ambas fontes oficiais,
-- tier 1 da hierarquia, mas competindo entre si. Resolvido a favor do número de 150, que é o
-- efetivamente celebrado pela imprensa esportiva brasileira em 2026 (contexto da perseguição de
-- Neymar ao recorde), via Lance, imprensa de referência apurando o dado da CBF.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('Cafu foi capitão do Brasil pentacampeão em 2002 e jogou pela Seleção Brasileira por 16 anos, entre 1990 e 2006 — um recorde que resiste até hoje, com Neymar entre os principais perseguidores. Quantos jogos ele disputou pela Seleção?',
   150, 'jogos', 'futebol', 2,
   'Lance — "Jogadores com mais jogos pela Seleção Brasileira"',
   'https://www.lance.com.br/selecao-brasileira/jogadores-com-mais-jogos-selecao-brasileira.html',
   2026, 'approved'),
  ('Um técnico normalmente segue no cargo por meses, mesmo em times que vão mal. Mas o inglês Leroy Rosenior foi anunciado e demitido do Torquay United no mesmo dia, em maio de 2007, quando a diretoria vendeu o clube pouco depois do anúncio — episódio tratado pela imprensa esportiva como o mandato mais curto já registrado no futebol profissional. Quantos minutos ele durou no cargo?',
   10, 'minutos', 'futebol', 2,
   'Wikipedia — "Leroy Rosenior"',
   'https://en.wikipedia.org/wiki/Leroy_Rosenior',
   2007, 'approved'),
  ('Um armador de elite na Premier League costuma fechar a temporada com 12 a 15 assistências. Mas Bruno Fernandes, do Manchester United, superou em 2025/26 uma marca que resistia desde 2003, do francês-inglês Thierry Henry, e que havia sido apenas igualada por Kevin De Bruyne em 2020. Quantas assistências ele deu naquela temporada, estabelecendo o novo recorde?',
   21, 'assistências', 'futebol', 2,
   'Sky Sports — "Bruno Fernandes: Man Utd captain breaks Premier League assists record for a single season"',
   'https://www.skysports.com/football/news/11667/13538833/bruno-fernandes-man-utd-captain-breaks-premier-league-assists-record-for-a-single-season',
   2026, 'approved'),
  ('Peter Shilton foi goleiro profissional por 25 anos, entre 1966 e 1991, passando por Leicester City, Nottingham Forest e outros clubes ingleses. Quantas partidas ele disputou na primeira divisão do futebol inglês ao longo da carreira — um recorde que segue de pé até hoje?',
   848, 'jogos', 'futebol', 2,
   'Guinness World Records — "Most appearances in the English football (soccer) top division"',
   'https://www.guinnessworldrecords.com/world-records/110025-most-appearances-in-the-english-football-soccer-top-division',
   1991, 'approved');
