-- Onda 6 do tópico futebol — lote variado (mesmo espírito das ondas 4 e 5), mas com uma exigência
-- extra: diversificar não só o sujeito, e sim a FORMA da pergunta em relação aos lotes anteriores,
-- que já usaram bastante "estatística de carreira de jogador" e "recorde de pontos de campeão do
-- Brasileirão". Este lote cobre: recorde de competição continental (Libertadores), curiosidade de
-- regra/arbitragem, recorde físico de uma única partida, história de torneio nacional (Copa do
-- Brasil) e recorde financeiro que não é "transferência mais cara" (já usado no lote 4).
-- Já nasce 'approved': cada pergunta foi pesquisada e a fonte verificada no momento de ser escrita
-- (mesmo processo do curador-perguntas + skill achometro-perguntas). Sem fonte travada única pro
-- lote — cada assunto buscou sua própria fonte pela hierarquia (oficial > agregador consolidado >
-- imprensa de referência).
--
-- Descartados do pool original de 8 candidatos:
-- - "Flamengo, clube brasileiro com mais títulos da Copa Libertadores" (4 títulos) — descartado por
--   redundância de forma dentro do próprio lote com a pergunta do artilheiro histórico da
--   Libertadores (Alberto Spencer): as duas seriam "quantos X na Libertadores", forma repetida.
-- - "Gol mais rápido da história da Copa do Mundo" (Hakan Şükür, 11 segundos, 2002) — descartado
--   por redundância de forma com a pergunta da disputa de pênaltis recorde (ambas são "recorde
--   extremo de uma única partida"); ficou a dos pênaltis por ter fonte oficial (Guinness) verificada
--   de primeira mão — a tentativa de checar a página oficial da FIFA para o gol do Şükür falhou ao
--   ser buscada, então não valeu o critério 2 (fonte pública e citável) com a mesma confiança.
-- - "Primeira edição da Copa do Brasil (1989), 32 clubes participantes" — descartado por
--   sobreposição de assunto com a pergunta do Cruzeiro/Copa do Brasil e por ser morna: quantos times
--   entraram numa primeira edição não gera debate de mesa (critério 4).
-- - "Recorde de 56 cobranças numa disputa de pênaltis" (Dimona 23x22 Shimshon Tel Aviv, Israel,
--   maio de 2024), amplamente noticiado pela imprensa como "novo recorde mundial" — descartado por
--   conflito de fonte no critério 1: a própria página oficial do Guinness World Records
--   (guinnessworldrecords.com/world-records/longest-penalty-shootout) ainda reconhece 48 cobranças
--   (final da Copa da Namíbia, 2005) como o recorde vigente; a imprensa deu o jogo de 2024 como
--   recorde mundial, mas isso não está certificado na fonte de nível 1 da hierarquia. Optamos pelo
--   número oficial do Guinness (48), não pelo valor de 56 repetido pela imprensa.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('O equatoriano Alberto Spencer defendeu Peñarol e Barcelona-EQU nas décadas de 1960, e seu recorde nunca foi superado, nem pelos artilheiros modernos da competição. Quantos gols ele marcou na história da Copa Libertadores?',
   54, 'gols', 'futebol', 3,
   'CONMEBOL — "Alberto Spencer, eterno artilheiro da América"',
   'https://www.conmebol.com/pt-br/noticias-pt-br/alberto-spencer-eterno-artilheiro-da-america/',
   1969, 'approved'),
  ('Um tempo de jogo raramente passa de 5 ou 6 minutos de acréscimo. Mas a estreia da Inglaterra contra o Irã na Copa de 2022 quebrou o recorde histórico dos Mundiais nesse quesito, por causa de uma lesão grave no goleiro iraniano e muitas substituições. Somando os dois tempos, quantos minutos de acréscimo o árbitro brasileiro Raphael Claus deu?',
   27, 'minutos', 'futebol', 2,
   'A Gazeta — "Raphael Claus faz história com inéditos 27 minutos de acréscimo em Copas"',
   'https://www.agazeta.com.br/futebol/raphael-claus-faz-historia-com-ineditos-27-minutos-de-acrescimo-em-copas-1122',
   2022, 'approved'),
  ('Uma disputa de pênaltis costuma ter cinco cobranças por time. Mas a final da Copa da Namíbia de 2005 só terminou depois de uma sequência recorde de cobranças alternadas, reconhecida pelo Guinness World Records. Quantas cobranças, somando as dos dois times, foram batidas ao todo nessa disputa?',
   48, 'cobranças', 'futebol', 3,
   'Guinness World Records — "Longest penalty shootout"',
   'https://www.guinnessworldrecords.com/world-records/longest-penalty-shootout',
   2005, 'approved'),
  ('Quando o assunto é Copa do Brasil, Flamengo e Corinthians costumam vir à cabeça primeiro, mas nenhum dos dois é o maior campeão da competição — o título vai para o Cruzeiro. Quantas vezes o clube mineiro já levantou a taça?',
   6, 'títulos', 'futebol', 2,
   'Wikipédia — "Títulos do Cruzeiro Esporte Clube"',
   'https://pt.wikipedia.org/wiki/T%C3%ADtulos_do_Cruzeiro_Esporte_Clube',
   2018, 'approved'),
  ('O futebol sul-americano movimenta muito menos dinheiro que o europeu, mas a Libertadores bateu recorde de premiação em 2024. Quantos dólares o Botafogo, campeão daquele ano, recebeu da CONMEBOL só por vencer a decisão?',
   23000000, 'dólares', 'futebol', 2,
   'CONMEBOL — "Campeão 2024 da CONMEBOL Libertadores será o melhor premiado do planeta"',
   'https://www.conmebol.com/pt-br/noticias-pt-br/campeao-2024-da-conmebol-libertadores-sera-o-melhor-premiado-do-planeta/',
   2024, 'approved');
