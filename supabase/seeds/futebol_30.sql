-- Onda de RASCUNHO (não curada) do tópico futebol — lote final (6/6) de uma sequência dedicada a
-- ampliar a cobertura geográfica/temática do banco. Os lotes anteriores cobriram Europa, América
-- do Sul fora do Brasil, África/Ásia/CONCACAF, clubes brasileiros menores + futebol feminino, e
-- competições internacionais/história/regras (ver futebol_25 a futebol_29). Este lote preenche
-- lacunas remanescentes: Oceania além de Nova Zelândia/Austrália, seleções e clubes menos comuns
-- de outros continentes, futebol de base (Sub-20/Sub-17), Jogos Olímpicos (masculino e feminino),
-- futebol paralímpico/amputado, futsal, tecnologia no futebol e números agregados de mercado
-- (transferências e patrocínio). Todas as perguntas nascem com status='pending' e fonte
-- placeholder ('NÃO VERIFICADO...' / 'pending://sem-fonte-verificada') — escritas de memória, sem
-- pesquisa, seguindo o mesmo processo já usado no início do banco (ver cabeçalho de
-- supabase/seed.sql). Uma sessão futura de curadoria (agente curador-perguntas, com
-- WebSearch/WebFetch real) precisa validar cada número antes de qualquer uma virar 'approved'.
-- Não rodar contra produção sem isso.
--
-- Famílias incluídas (11, ~10 perguntas cada, ~110 total):
--   A. Oceania além de Nova Zelândia e Austrália: seleções e clubes da OFC
--   B. Copa do Mundo Sub-20 da FIFA: títulos, edições e marcos
--   C. Copa do Mundo Sub-17 da FIFA: títulos, edições e marcos
--   D. Jogos Olímpicos, futebol masculino: títulos e marcos históricos
--   E. Jogos Olímpicos, futebol feminino: títulos e marcos históricos
--   F. Futebol paralímpico e futebol amputado: modalidades, títulos e regras
--   G. Futsal: Copa do Mundo da FIFA, craques e regras
--   H. Tecnologia no futebol: goal-line, VAR, chip na bola, impedimento semiautomático
--   I. Transferências agregadas por temporada/janela: recordes de mercado
--   J. Patrocínio e marketing: contratos e valores de marca
--   K. Seleções e clubes menos comuns de outros continentes (Ásia/Sul da Ásia/Oriente Médio)

-- Família A: Oceania além de Nova Zelândia e Austrália — seleções e clubes da OFC.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('O Taiti, minúsculo território francês no Pacífico, chocou o mundo do futebol ao vencer a Copa das Nações da OFC pela primeira e única vez na história. Em que ano foi essa conquista?',
   2012, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2012, 'pending'),
  ('A Nova Caledônia venceu sua única Copa das Nações da OFC da história, um dos maiores feitos do futebol do território. Em que ano foi essa conquista?',
   2008, 'ano', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2008, 'pending'),
  ('Vanuatu, arquipélago de pouco mais de 300 mil habitantes, já teve sua melhor posição histórica no ranking da FIFA. Qual foi essa melhor posição (quanto menor o número, melhor)?',
   130, 'posição', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2019, 'pending'),
  ('Papua-Nova Guiné sediou a Copa das Nações da OFC em casa, buscando seu melhor resultado histórico no torneio. Em que ano foi essa edição sediada pelo país?',
   2016, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2016, 'pending'),
  ('As Ilhas Salomão foram uma das seleções mais fortes do Pacífico nos anos 1990, antes da ascensão de Nova Zelândia e Taiti. Quantas vezes a seleção venceu a Copa das Nações da OFC?',
   2, 'títulos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1998, 'pending'),
  ('A seleção de Samoa Americana ficou marcada por uma goleada histórica sofrida em 2001, mas anos depois conquistou sua primeira vitória internacional da história. Em que ano foi essa primeira vitória?',
   2011, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2011, 'pending'),
  ('As Ilhas Cook, arquipélago com menos de 20 mil habitantes, disputam competições da OFC há décadas. Qual foi a melhor posição que a seleção já alcançou no ranking da FIFA?',
   170, 'posição', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'),
  ('Tonga é uma das seleções fundadoras da confederação oceânica de futebol. Quantas vezes a seleção já disputou a fase final da Copa das Nações da OFC?',
   8, 'edições', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2016, 'pending'),
  ('Fiji surpreendeu o Pacífico ao vencer a Copa das Nações da OFC, um resultado histórico para o futebol do país. Em que ano foi essa conquista?',
   2016, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2016, 'pending'),
  ('O AS Magenta, clube da Nova Caledônia, é um dos mais tradicionais do futebol oceânico, fundado ainda no início do século XX. Quantos títulos nacionais o clube já venceu ao todo?',
   15, 'títulos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending');

-- Família B: Copa do Mundo Sub-20 da FIFA — títulos, edições e marcos.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('A primeira Copa do Mundo Sub-20 da FIFA foi disputada na Tunísia, reunindo seleções jovens de todo o mundo pela primeira vez. Em que ano foi essa edição inaugural?',
   1977, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1977, 'pending'),
  ('A Argentina é a seleção mais vitoriosa da história da Copa do Mundo Sub-20, com craques como Messi e Agüero revelados no torneio. Quantos títulos a seleção argentina já venceu ao todo?',
   6, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2007, 'pending'),
  ('O Brasil também acumula uma bela coleção de títulos na Copa do Mundo Sub-20 ao longo das décadas. Quantos títulos a seleção brasileira já venceu ao todo?',
   5, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2011, 'pending'),
  ('Portugal viveu seu auge no futebol de base ao vencer a Copa do Mundo Sub-20 pela primeira vez, com uma geração que formaria a base da seleção principal anos depois. Em que ano foi essa primeira conquista?',
   1989, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1989, 'pending'),
  ('Gana se tornou a primeira seleção africana a vencer a Copa do Mundo Sub-20 da FIFA. Em que ano foi essa conquista histórica?',
   2009, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2009, 'pending'),
  ('A Sérvia surpreendeu o mundo do futebol ao vencer a Copa do Mundo Sub-20 disputada na Nova Zelândia. Em que ano foi essa conquista?',
   2015, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2015, 'pending'),
  ('A Ucrânia venceu sua única Copa do Mundo Sub-20 da história numa edição disputada na Polônia. Em que ano foi essa conquista?',
   2019, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2019, 'pending'),
  ('O Uruguai ergueu a taça da Copa do Mundo Sub-20 numa edição disputada na Turquia. Em que ano foi essa conquista?',
   2013, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2013, 'pending'),
  ('A Copa do Mundo Sub-20 cresceu de tamanho ao longo das décadas desde sua criação em 1977. Quantas seleções disputam a fase final da competição atualmente?',
   24, 'seleções', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('A Copa do Mundo Sub-20 da FIFA segue um calendário regular desde sua criação em 1977. De quantos em quantos anos o torneio costuma ser disputado?',
   2, 'anos', 'futebol', 1, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending');

-- Família C: Copa do Mundo Sub-17 da FIFA — títulos, edições e marcos.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('A primeira Copa do Mundo Sub-17 da FIFA foi disputada na China, reunindo as principais seleções de base do mundo. Em que ano foi essa edição inaugural?',
   1985, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1985, 'pending'),
  ('A Nigéria é a seleção mais vitoriosa da história da Copa do Mundo Sub-17, com uma geração de base historicamente forte. Quantos títulos a seleção nigeriana já venceu ao todo?',
   5, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2015, 'pending'),
  ('O Brasil também tem uma boa tradição na Copa do Mundo Sub-17, revelando futuros ídolos da seleção principal. Quantos títulos a seleção brasileira já venceu ao todo?',
   4, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2019, 'pending'),
  ('O México venceu a Copa do Mundo Sub-17 em duas ocasiões diferentes, ambas já no século XXI. Quantos títulos a seleção mexicana já venceu ao todo?',
   2, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2011, 'pending'),
  ('A Suíça surpreendeu o mundo ao vencer a Copa do Mundo Sub-17 disputada na Nigéria. Em que ano foi essa conquista inesperada?',
   2009, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2009, 'pending'),
  ('A Copa do Mundo Sub-17 também cresceu de tamanho ao longo das décadas. Quantas seleções disputam a fase final da competição atualmente?',
   24, 'seleções', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('Gana chegou à final da Copa do Mundo Sub-17 mais de uma vez, mas nunca conseguiu erguer o troféu. Quantas vezes a seleção ganense foi vice-campeã do torneio?',
   2, 'vices', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1995, 'pending'),
  ('Assim como a versão Sub-20, a Copa do Mundo Sub-17 segue um calendário regular desde sua criação. De quantos em quantos anos o torneio costuma ser disputado?',
   2, 'anos', 'futebol', 1, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('A França venceu a Copa do Mundo Sub-17 numa edição disputada em Trinidad e Tobago. Em que ano foi essa conquista?',
   2001, 'ano', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2001, 'pending'),
  ('A Inglaterra venceu a Copa do Mundo Sub-17 numa edição disputada na Índia. Em que ano foi essa conquista?',
   2017, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2017, 'pending');

-- Família D: Jogos Olímpicos, futebol masculino — títulos e marcos históricos.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('A Hungria é a seleção mais vitoriosa da história do futebol masculino olímpico, dominando o torneio em plena Guerra Fria. Quantos ouros olímpicos a seleção húngara já venceu ao todo?',
   3, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1968, 'pending'),
  ('O Reino Unido venceu o torneio olímpico de futebol masculino logo nas primeiras edições dos Jogos, no início do século XX. Quantos ouros olímpicos a seleção britânica já venceu ao todo?',
   3, 'títulos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1912, 'pending'),
  ('A Argentina venceu o ouro olímpico de futebol masculino duas vezes na década de 2000, com uma geração recheada de futuros craques. Quantos ouros olímpicos a seleção argentina já venceu ao todo?',
   2, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2008, 'pending'),
  ('O Brasil só conquistou seu primeiro ouro olímpico de futebol masculino jogando em casa, depois de várias medalhas de prata na história. Em que ano foi essa conquista inédita?',
   2016, 'ano', 'futebol', 1, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2016, 'pending'),
  ('A Nigéria se tornou a primeira seleção africana a vencer o ouro olímpico de futebol masculino, batendo a Argentina na final. Em que ano foi essa conquista?',
   1996, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1996, 'pending'),
  ('Camarões venceu o ouro olímpico de futebol masculino numa edição disputada na Austrália. Em que ano foi essa conquista?',
   2000, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2000, 'pending'),
  ('O México surpreendeu o mundo ao vencer o ouro olímpico de futebol masculino em Londres, batendo o Brasil na final. Em que ano foi essa conquista?',
   2012, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2012, 'pending'),
  ('Desde 1992, o torneio olímpico de futebol masculino passou a ser disputado por seleções sub-23, com um número limitado de jogadores mais velhos permitidos em cada elenco. Quantos jogadores acima da idade limite cada seleção pode inscrever?',
   3, 'jogadores', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2021, 'pending'),
  ('A Espanha venceu seu único ouro olímpico de futebol masculino jogando em casa, em Barcelona. Em que ano foi essa conquista?',
   1992, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1992, 'pending'),
  ('O Uruguai foi campeão olímpico de futebol masculino duas vezes na década de 1920, antes mesmo de existir a Copa do Mundo. Quantos ouros olímpicos a seleção uruguaia venceu ao todo nesse período?',
   2, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1928, 'pending');

-- Família E: Jogos Olímpicos, futebol feminino — títulos e marcos históricos.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('Os Estados Unidos dominam o futebol feminino olímpico desde a criação da modalidade nos Jogos. Quantos ouros olímpicos a seleção norte-americana já venceu ao todo?',
   4, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2012, 'pending'),
  ('O futebol feminino estreou nos Jogos Olímpicos décadas depois da versão masculina. Em que ano foi essa primeira edição olímpica da modalidade?',
   1996, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1996, 'pending'),
  ('A Alemanha venceu o ouro olímpico de futebol feminino numa edição disputada no Brasil. Em que ano foi essa conquista?',
   2016, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2016, 'pending'),
  ('A Noruega venceu seu único ouro olímpico de futebol feminino numa edição disputada na Austrália. Em que ano foi essa conquista?',
   2000, 'ano', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2000, 'pending'),
  ('O Canadá quebrou a hegemonia de Estados Unidos e Alemanha ao vencer o ouro olímpico de futebol feminino em Tóquio. Em que edição (identificada pelo ano originalmente programado) foi essa conquista?',
   2020, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2021, 'pending'),
  ('O Brasil já chegou duas vezes à final do futebol feminino olímpico, mas nunca venceu o ouro, ficando com a prata em ambas. Quantas medalhas de prata a seleção brasileira feminina já venceu no torneio olímpico?',
   2, 'medalhas', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2008, 'pending'),
  ('O futebol feminino olímpico teve o número de seleções participantes igualado ao masculino em Paris 2024. Quantas seleções disputaram o torneio feminino naquela edição?',
   12, 'seleções', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2024, 'pending'),
  ('A Suécia é uma das seleções mais "pratas" do futebol feminino olímpico, chegando à final várias vezes sem nunca vencer o ouro. Quantas medalhas de prata a seleção sueca já venceu no torneio?',
   3, 'medalhas', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2021, 'pending'),
  ('A China sediou e chegou à final do primeiro torneio olímpico de futebol feminino da história, mas acabou como vice. Em que ano foi essa primeira edição?',
   1996, 'ano', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1996, 'pending'),
  ('O Japão chegou à final do futebol feminino olímpico em Londres, ficando com a medalha de prata. Em que ano foi essa campanha?',
   2012, 'ano', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2012, 'pending');

-- Família F: futebol paralímpico e futebol amputado — modalidades, títulos e regras.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('O futebol de 5, modalidade paralímpica para atletas com deficiência visual, estreou nos Jogos Paralímpicos ainda no início dos anos 2000. Em que ano foi essa estreia?',
   2004, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2004, 'pending'),
  ('O Brasil é a seleção mais vitoriosa da história do futebol de 5 nos Jogos Paralímpicos. Quantos ouros paralímpicos a seleção brasileira já venceu nessa modalidade?',
   4, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2016, 'pending'),
  ('O futebol de 7, disputado por atletas com paralisia cerebral, fez parte do programa paralímpico por décadas antes de ser removido. Em que ano essa modalidade foi disputada pela última vez nos Jogos Paralímpicos?',
   2016, 'ano', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2016, 'pending'),
  ('Angola é uma das seleções mais tradicionais do futebol amputado, disputado por atletas amputados de membros inferiores. Quantos títulos da Copa do Mundo de futebol amputado a seleção angolana já venceu?',
   3, 'títulos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2022, 'pending'),
  ('A Copa do Mundo de futebol amputado reconhecida pela federação internacional da modalidade existe há décadas. Em que ano foi disputada sua primeira edição oficial?',
   1998, 'ano', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1998, 'pending'),
  ('No futebol de 5 paralímpico, o goleiro enxerga normalmente, mas os demais jogadores de linha são todos cegos ou têm visão bastante reduzida. Quantos jogadores cada time coloca em quadra ao todo, incluindo o goleiro?',
   5, 'jogadores', 'futebol', 1, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'),
  ('Uma partida de futebol de 5 nos Jogos Paralímpicos é mais curta do que uma partida de futebol convencional. Somando os dois tempos, quantos minutos dura o tempo normal de uma partida?',
   50, 'minutos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'),
  ('A federação internacional que organiza o futebol amputado no mundo foi criada para dar uma estrutura permanente à modalidade. Em que ano essa federação foi fundada?',
   2005, 'ano', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2005, 'pending'),
  ('A Rússia é uma das seleções mais tradicionais do futebol de 7 (paralisia cerebral), disputado até 2016 nos Jogos Paralímpicos. Quantos ouros paralímpicos a seleção russa já venceu nessa modalidade?',
   3, 'títulos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2012, 'pending'),
  ('Além do ouro paralímpico, o Brasil também é a seleção mais vitoriosa da Copa do Mundo IBSA de futebol de 5. Quantos títulos mundiais da modalidade a seleção brasileira já venceu ao todo?',
   6, 'títulos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2018, 'pending');

-- Família G: futsal — Copa do Mundo da FIFA, craques e regras.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('A primeira Copa do Mundo de Futsal da FIFA foi disputada nos Países Baixos, ainda no fim dos anos 1980. Em que ano foi essa edição inaugural?',
   1989, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1989, 'pending'),
  ('O Brasil é a seleção mais vitoriosa da história da Copa do Mundo de Futsal da FIFA. Quantos títulos mundiais a seleção brasileira já venceu ao todo?',
   5, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2012, 'pending'),
  ('A Espanha é a segunda seleção mais vitoriosa da história da Copa do Mundo de Futsal da FIFA. Quantos títulos mundiais a seleção espanhola já venceu ao todo?',
   2, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2004, 'pending'),
  ('A Argentina venceu sua única Copa do Mundo de Futsal da FIFA jogando em casa, um marco para o futsal do país. Em que ano foi essa conquista?',
   2016, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2016, 'pending'),
  ('Falcão é considerado por muitos o maior jogador da história do futsal, com uma carreira cheia de premiações individuais. Quantas vezes ele já foi eleito o melhor jogador de futsal do mundo pela FIFA?',
   7, 'prêmios', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2015, 'pending'),
  ('Uma partida de futsal tem dois tempos mais curtos do que uma partida de futebol de campo. Somando os dois tempos, quantos minutos dura o tempo normal de uma partida de futsal?',
   40, 'minutos', 'futebol', 1, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'),
  ('O futsal é disputado em quadra, com um número de jogadores por time bem menor do que o futebol de campo. Quantos jogadores cada time coloca em quadra ao todo, incluindo o goleiro?',
   5, 'jogadores', 'futebol', 1, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'),
  ('A FIFA passou a organizar oficialmente a Copa do Mundo de Futsal a partir do fim dos anos 1980. Em que ano essa Copa do Mundo de Futsal foi assumida pela primeira vez pela FIFA?',
   1989, 'ano', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1989, 'pending'),
  ('Portugal, com o ala Ricardinho na equipe, venceu sua única Copa do Mundo de Futsal da FIFA depois de perder duas finais anteriores. Em que ano foi essa conquista?',
   2021, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2021, 'pending'),
  ('No futsal, as faltas acumuladas por um time em cada período mudam a forma como a falta seguinte é cobrada. A partir de qual falta acumulada num mesmo período o time passa a sofrer tiro livre direto sem barreira?',
   6, 'faltas', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending');

-- Família H: tecnologia no futebol — goal-line, VAR, chip na bola, impedimento semiautomático.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('A tecnologia da linha do gol (goal-line technology) chegou às Copas do Mundo depois de anos de resistência da FIFA a qualquer tipo de auxílio eletrônico. Em que ano ela estreou oficialmente numa Copa do Mundo?',
   2014, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2014, 'pending'),
  ('A Premier League inglesa foi uma das primeiras grandes ligas do mundo a adotar a tecnologia da linha do gol. Em que ano ela passou a valer oficialmente na competição?',
   2013, 'ano', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2013, 'pending'),
  ('O sistema Hawk-Eye, usado para a tecnologia da linha do gol, funciona com múltiplas câmeras apontadas para cada uma das balizas. Quantas câmeras o sistema usa para cobrir um único gol?',
   7, 'câmeras', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2014, 'pending'),
  ('A Copa do Mundo de 2022, no Catar, usou uma bola oficial equipada com um sensor eletrônico dentro dela. Em que ano essa bola com chip conectado estreou numa Copa do Mundo?',
   2022, 'ano', 'futebol', 1, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2022, 'pending'),
  ('A tecnologia de impedimento semiautomático foi apresentada como uma forma de acelerar as decisões do VAR em lances de impedimento. Em que ano ela estreou oficialmente numa Copa do Mundo?',
   2022, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2022, 'pending'),
  ('O VAR foi usado pela primeira vez numa competição oficial da FIFA no Mundial de Clubes, antes de estrear em ligas nacionais. Em que ano foi esse primeiro uso oficial?',
   2016, 'ano', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2016, 'pending'),
  ('A Alemanha foi uma das primeiras ligas do mundo a adotar o VAR de forma permanente na temporada regular. Em que ano a Bundesliga passou a usar o sistema?',
   2017, 'ano', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2017, 'pending'),
  ('O IFAB, órgão que define as regras do futebol, precisou aprovar formalmente o uso do VAR como ferramenta oficial de arbitragem. Em que ano essa aprovação aconteceu?',
   2018, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2018, 'pending'),
  ('A tecnologia da linha do gol precisa ser extremamente rápida para validar ou anular um gol em tempo real. Em quantos segundos, no máximo, o sistema deve enviar a confirmação para o relógio do árbitro?',
   1, 'segundos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2014, 'pending'),
  ('Antes da bola com chip, a FIFA já testava sensores de rastreamento de bola em Copas do Mundo anteriores para fins estatísticos. Em que ano esse tipo de sensor foi usado pela primeira vez oficialmente numa Copa do Mundo?',
   2014, 'ano', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2014, 'pending');

-- Família I: transferências agregadas por temporada/janela — recordes de mercado.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('O mercado de transferências europeu bateu recorde histórico na janela de verão de 2023, somando os gastos de todos os clubes da Premier League. Quantos milhões de libras os clubes ingleses gastaram naquela janela?',
   2360, 'milhões de libras', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O Chelsea foi o clube que mais gastou numa única janela de transferências na história do futebol europeu, no verão de 2023. Quantos milhões de libras o clube gastou naquela janela?',
   450, 'milhões de libras', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('A FIFA publica todo ano um relatório global sobre o mercado de transferências internacionais de jogadores profissionais. Quantos bilhões de dólares os clubes do mundo todo gastaram somados numa temporada recente?',
   8, 'bilhões de dólares', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O relatório anual da FIFA sobre transferências internacionais contabiliza uma quantidade enorme de negociações ao redor do mundo. Quantas transferências internacionais de jogadores foram registradas pela FIFA numa temporada recente?',
   22000, 'transferências', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O Chelsea também bateu recorde de gasto líquido (descontando vendas) numa única temporada, no ciclo de reformulação do elenco pós-2022. Quantos milhões de euros o clube gastou de forma líquida naquela temporada?',
   500, 'milhões de euros', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('A janela de transferências de inverno (janeiro) bateu recorde de gastos entre os clubes ingleses em 2023. Quantos milhões de libras os clubes da Premier League gastaram somados naquele mês?',
   815, 'milhões de libras', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('A Premier League é disparada a liga que mais gasta em transferências no mundo todo, somando as janelas de verão e inverno de uma temporada completa. Quantos bilhões de libras os clubes da liga já gastaram numa única temporada recorde?',
   3, 'bilhões de libras', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('Empréstimos de jogadores são uma parte importante do mercado de transferências internacional. Quantos empréstimos de jogadores foram registrados pela FIFA ao redor do mundo numa temporada recente?',
   9000, 'empréstimos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O Benfica é conhecido no futebol europeu por revelar e vender jogadores por valores altos. Quantos milhões de euros o clube português arrecadou com vendas de jogadores numa única temporada recorde?',
   120, 'milhões de euros', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2022, 'pending'),
  ('Os agentes de jogadores recebem comissões cada vez maiores dos clubes a cada temporada, segundo relatórios da FIFA. Quantos milhões de dólares os clubes do mundo todo pagaram de comissão a agentes numa temporada recente?',
   700, 'milhões de dólares', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending');

-- Família J: patrocínio e marketing — contratos e valores de marca.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('O contrato entre Nike e Barcelona é um dos mais valiosos do futebol mundial na fabricação de material esportivo. Quantos milhões de euros por ano o clube catalão recebe desse contrato?',
   150, 'milhões de euros', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2022, 'pending'),
  ('O Manchester United tem um dos contratos de patrocínio de camisa mais valiosos do futebol inglês. Quantos milhões de libras por ano o clube recebe desse patrocinador estampado no peito da camisa?',
   47, 'milhões de libras', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2022, 'pending'),
  ('Cristiano Ronaldo assinou um contrato vitalício com a Nike considerado um dos mais valiosos já dados a um atleta. Quantos milhões de dólares esse contrato vitalício vale, segundo estimativas divulgadas na imprensa?',
   1000, 'milhões de dólares', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2016, 'pending'),
  ('Kylian Mbappé também tem um contrato de patrocínio pessoal robusto com a Nike, renovado ao longo da carreira. Quantos milhões de euros por ano esse contrato vale, segundo estimativas da imprensa?',
   20, 'milhões de euros', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2022, 'pending'),
  ('O Real Madrid costuma aparecer no topo dos rankings de valor de marca no futebol mundial. Quantos milhões de dólares vale a marca do clube, segundo estimativa de uma consultoria financeira?',
   1700, 'milhões de dólares', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('A FIFA divide seus parceiros comerciais de Copa do Mundo em diferentes categorias de patrocínio. Quantos patrocinadores oficiais, somando todas as categorias, apoiaram uma edição recente do torneio?',
   20, 'patrocinadores', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2022, 'pending'),
  ('As emissoras de televisão pagam somas altíssimas pelos direitos de transmissão de uma Copa do Mundo nos Estados Unidos. Quantos milhões de dólares a Fox pagou pelos direitos de uma edição recente do torneio?',
   425, 'milhões de dólares', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2018, 'pending'),
  ('Contratos de naming rights de estádios de futebol podem valer centenas de milhões ao longo de décadas. Quantos milhões de libras o contrato de naming rights do estádio do Manchester City soma ao todo?',
   400, 'milhões de libras', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2015, 'pending'),
  ('A Premier League vende os direitos de transmissão da liga para emissoras de TV por valores bilionários a cada ciclo de contrato. Quantos milhões de libras por temporada a liga já recebeu num contrato doméstico recente?',
   1600, 'milhões de libras', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2022, 'pending'),
  ('O Real Madrid também está entre os clubes que mais faturam com a venda de camisas e produtos de merchandising no mundo. Quantos milhões de euros por ano o clube fatura com merchandising, segundo estimativas?',
   180, 'milhões de euros', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2022, 'pending');

-- Família K: seleções e clubes menos comuns de outros continentes (Ásia/Sul da Ásia/Oriente
-- Médio) — ângulos ainda não cobertos pelos lotes anteriores de África/Ásia/CONCACAF.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('O Butão, um dos países menos populosos da Ásia, teve uma trajetória de resultados difíceis nas eliminatórias da Copa do Mundo por décadas. Em que ano a seleção butanesa venceu sua primeira partida fora de casa em eliminatórias oficiais?',
   2015, 'ano', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2015, 'pending'),
  ('A Copa Nehru é um dos torneios internacionais mais antigos disputados na Índia, existindo há décadas. Quantas edições da competição já foram disputadas ao todo?',
   12, 'edições', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2012, 'pending'),
  ('O Vietnã é uma das seleções em ascensão do Sudeste Asiático nos últimos anos. Quantos títulos da Copa do Sudeste Asiático (AFF Cup) a seleção vietnamita já venceu ao todo?',
   2, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2018, 'pending'),
  ('A Tailândia é a seleção mais vitoriosa da história da Copa do Sudeste Asiático (AFF Cup). Quantos títulos da competição a seleção tailandesa já venceu ao todo?',
   7, 'títulos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2022, 'pending'),
  ('O Uzbequistão chegou à final da Copa da Ásia pela primeira vez na história numa edição disputada no Catar. Em que ano foi essa campanha?',
   2011, 'ano', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2011, 'pending'),
  ('O Catar surpreendeu o continente ao vencer sua própria Copa da Ásia jogando em casa. Em que ano foi essa conquista?',
   2019, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2019, 'pending'),
  ('A Arábia Saudita é uma das seleções mais tradicionais da Copa da Ásia, com títulos conquistados em diferentes décadas. Quantos títulos da competição a seleção saudita já venceu ao todo?',
   3, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1996, 'pending'),
  ('A Coreia do Norte protagonizou uma das maiores zebras da história da Copa do Mundo de 1966, avançando de fase à frente da Itália. Quantas partidas a seleção norte-coreana venceu naquela fase de grupos?',
   1, 'vitórias', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1966, 'pending'),
  ('O Iraque venceu sua única Copa da Ásia da história numa edição disputada na Indonésia, em meio a um cenário de guerra no próprio país. Em que ano foi essa conquista?',
   2007, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2007, 'pending'),
  ('A Jordânia chegou à sua primeira final de Copa da Ásia da história numa edição recente disputada no Catar. Em que ano foi essa campanha?',
   2023, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2024, 'pending');
