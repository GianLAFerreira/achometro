-- Onda 22 do tópico futebol — lote de 4 perguntas, instrução explícita do usuário: nada de Copa do
-- Mundo/Champions/Brasileirão/Premier League/seleções grandes desta vez — só ligas e competições
-- obscuras de fora do circuito mainstream, pra surpreender até quem acompanha futebol de perto.
--
-- "A Outra Final" (Butão 4x0 Montserrat, Thimphu, 30/06/2002) — no mesmo dia da final da Copa do
-- Mundo daquele ano, as duas seleções então pior rankeadas pela FIFA se enfrentaram num jogo
-- amistoso que virou lenda (e depois documentário) por ser a "final de verdade" de quem estava no
-- fundo do ranking. Ângulo inédito no banco: futebol entre as seleções menos relevantes do mundo,
-- não as maiores.
--
-- Auckland City FC (Nova Zelândia, confederação da Oceania) — clube inteiramente AMADOR que
-- dominou a Liga dos Campeões da Oceania (OFC Champions League) com uma sequência de títulos
-- seguidos na década de 2010, confirmada pela própria tabela de campeões da competição na
-- Wikipédia. Distinto de qualquer sequência já usada no banco: não é invencibilidade de clube
-- grande nem sequência de títulos de liga doméstica (isso já foi feito com o Bundesliga no lote 7)
-- — aqui é sequência de títulos CONTINENTAIS por um clube amador.
--
-- KÍ Klaksvík (Ilhas Feroé) — clube mais vitorioso da liga de um arquipélago de pouco mais de 50 mil
-- habitantes no meio do Atlântico Norte, contando o total de títulos domésticos até o mais recente
-- (2025). Ângulo de "clube dominante numa liga minúscula", nunca tocado no banco.
--
-- Durand Cup (Índia) — competição de futebol mais antiga da Ásia e a 5ª mais antiga do mundo entre
-- as que seguem ativas até hoje, fundada ainda no século 19 (praticamente contemporânea da FA Cup
-- inglesa). Pergunta pede a idade do torneio contada até 2026, não o ano bruto de fundação, pra
-- manter a forma de "estimar por raciocínio" (âncora dá o século, não o ano exato).
--
-- Descartados depois de pesquisar (nenhum entrou no lote):
-- - Davide Gualtieri (San Marino), gol mais rápido contra a Inglaterra em 1993 (8,3s) — a Wikipédia
--   deixa claro que esse foi o gol mais rápido da história de eliminatórias/fase final de Copa do
--   Mundo *até* ser superado pelo gol de 8,1s do Christian Benteke em 2016; não é mais recorde
--   vigente. Usar como "recorde" seria impreciso, e reformular pra "recorde histórico entre 1993 e
--   2016" perdia a graça do gancho. Descartado por risco de fato impreciso.
-- - San Marino, maior sequência sem marcar gol (1.852 minutos, 20 jogos, 2008–2012) — a citação da
--   Wikipédia pra esse "recorde mundial" é vaga (referência genérica "World Record Breakers", sem
--   nome de veículo claro) e a página correspondente no site oficial do Guinness World Records
--   retornou 404. Sem fonte de nível 1 ou 2 confiável, reprovado pelo critério 2 (mesmo padrão do
--   caso "recorde de assistências, página 404" já registrado no rastreamento).
-- - SP Tre Fiori (San Marino), clube mais titulado do campeonato sammarinese (9 títulos) — fonte
--   boa (Wikipédia, tabela de campeões), mas descartado por ser o gancho mais morno do pool: "9
--   títulos" sem mais contexto não gera tanta reação quanto os quatro escolhidos.
--
-- Já nasce 'approved': cada pergunta foi pesquisada e a fonte verificada no momento de ser escrita
-- (mesmo processo do curador-perguntas + skill achometro-perguntas), conferindo se o texto da fonte
-- de fato sustenta o número citado. Todas as quatro caíram em Wikipédia como agregador consolidado
-- (nível 2) — não havia fonte oficial de nível 1 (federação/confederação) cobrindo esses recortes
-- específicos de forma mais direta que a própria tabela de campeões/resultados da Wikipédia.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('Em 2002, no mesmo dia da final da Copa do Mundo, Butão e Montserrat — as duas seleções então pior rankeadas pela FIFA — se enfrentaram em Thimphu numa partida amistosa apelidada de "A Outra Final". Quantos gols o Butão fez para vencer aquele jogo?',
   4, 'gols', 'futebol', 2,
   'Wikipédia — "The Other Final"',
   'https://en.wikipedia.org/wiki/The_Other_Final',
   2002, 'approved'),
  ('O Auckland City é um clube totalmente AMADOR da Nova Zelândia, mas ainda assim dominou o futebol de clubes da Oceania com uma sequência ininterrupta de títulos continentais ao longo da década de 2010. Quantos títulos seguidos da Liga dos Campeões da Oceania (OFC Champions League) ele conquistou nessa sequência?',
   7, 'títulos', 'futebol', 2,
   'Wikipédia — "OFC Champions League"',
   'https://en.wikipedia.org/wiki/OFC_Champions_League',
   2017, 'approved'),
  ('O KÍ Klaksvík joga na liga das Ilhas Feroé, um arquipélago de pouco mais de 50 mil habitantes no meio do Atlântico Norte, e é o clube mais vitorioso do país. Quantos títulos do campeonato feroês ele já conquistou ao todo, contando até o mais recente em 2025?',
   22, 'títulos', 'futebol', 2,
   'Wikipédia — "KÍ Klaksvík"',
   'https://en.wikipedia.org/wiki/K%C3%8D_Klaksv%C3%ADk',
   2025, 'approved'),
  ('A Durand Cup, disputada até hoje na Índia, é considerada a competição de futebol mais antiga de toda a Ásia — e ainda uma das mais antigas do mundo entre as que seguem ativas, fundada lá pelo século 19. Quantos anos ela tem, contados até 2026?',
   138, 'anos', 'futebol', 2,
   'Wikipédia — "Durand Cup"',
   'https://en.wikipedia.org/wiki/Durand_Cup',
   2026, 'approved');
