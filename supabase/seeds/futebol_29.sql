-- Onda de RASCUNHO (não curada) do tópico futebol — competições internacionais de clubes e
-- seleções, história do futebol e regras/curiosidades técnicas (não mais ligas domésticas
-- específicas de país, já bem cobertas em lotes anteriores). Todas as perguntas nascem com
-- status='pending' e fonte placeholder ('NÃO VERIFICADO...' / 'pending://sem-fonte-verificada') —
-- escritas de memória, sem pesquisa, seguindo o mesmo processo já usado no início do banco (ver
-- cabeçalho de supabase/seed.sql). Uma sessão futura de curadoria (agente curador-perguntas, com
-- WebSearch/WebFetch real) precisa validar cada número antes de qualquer uma virar 'approved'.
-- Não rodar contra produção sem isso.
--
-- Famílias incluídas (14, ~10 perguntas cada, ~140 total):
--   A. Público total (comparecimento agregado) de cada edição de Copa do Mundo
--   B. Total de gols marcados no torneio inteiro, por edição de Copa do Mundo
--   C. Idade do técnico campeão, por edição de Copa do Mundo
--   D. Número de seleções participantes, por edição de Copa do Mundo
--   E. Total de gols marcados no torneio inteiro, por edição de Eurocopa
--   F. Clube campeão europeu (Copa dos Campeões/Champions League): títulos já acumulados até
--      aquela conquista, por década
--   G. Bola de Ouro histórico: ano de conquista (jogadores anteriores a Messi/CR7)
--   H. Técnicos campeões de múltiplas competições internacionais/continentais
--   I. Árbitros históricos: recordes e números de carreira
--   J. Mudanças de regra do futebol ao longo da história: ano de introdução
--   K. Recordes de idade em competições internacionais (fora do já coberto em Copa do Mundo)
--   L. Copa Libertadores: primeiro título por país e contagem de títulos por clube
--   M. Copa América: número de títulos por seleção
--   N. Recordes e marcos do Mundial de Clubes da FIFA

-- Família A: público total (comparecimento agregado de todos os jogos), por edição de Copa do
-- Mundo.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('A Copa do Mundo de 1930, no Uruguai, teve só 13 seleções e estádios pequenos para os padrões de hoje. Somando o público de todos os jogos, quantas pessoas compareceram ao torneio inteiro?',
   590000, 'pessoas', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1930, 'pending'),
  ('A Copa do Mundo de 1950, no Brasil, teve o Maracanã lotado em vários jogos, inclusive na decisão. Somando o público de todos os jogos do torneio, quantas pessoas compareceram ao todo?',
   1045000, 'pessoas', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1950, 'pending'),
  ('A Copa do Mundo de 1966, na Inglaterra, foi a primeira transmitida com grande alcance pela televisão. Somando o público de todos os jogos, quantas pessoas compareceram ao torneio inteiro?',
   1563000, 'pessoas', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1966, 'pending'),
  ('A Copa do Mundo de 1974, na Alemanha Ocidental, coroou o anfitrião como campeão. Somando o público de todos os jogos, quantas pessoas compareceram ao torneio inteiro?',
   1865000, 'pessoas', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1974, 'pending'),
  ('A Copa do Mundo de 1982, na Espanha, foi a primeira disputada com 24 seleções. Somando o público de todos os jogos, quantas pessoas compareceram ao torneio inteiro?',
   2109000, 'pessoas', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1982, 'pending'),
  ('A Copa do Mundo de 1990, na Itália, teve estádios grandes e um público total recorde até então. Somando o público de todos os jogos, quantas pessoas compareceram ao torneio inteiro?',
   2516000, 'pessoas', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1990, 'pending'),
  ('A Copa do Mundo de 1998, na França, foi a primeira disputada com 32 seleções. Somando o público de todos os jogos, quantas pessoas compareceram ao torneio inteiro?',
   2785000, 'pessoas', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1998, 'pending'),
  ('A Copa do Mundo de 2006, na Alemanha, teve estádios modernos lotados em quase todos os jogos. Somando o público de todos os jogos, quantas pessoas compareceram ao torneio inteiro?',
   3359000, 'pessoas', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2006, 'pending'),
  ('A Copa do Mundo de 2014, no Brasil, teve estádios recém-construídos ou reformados para o torneio. Somando o público de todos os jogos, quantas pessoas compareceram ao torneio inteiro?',
   3429000, 'pessoas', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2014, 'pending'),
  ('A Copa do Mundo de 2018, na Rússia, foi disputada em 11 cidades do país. Somando o público de todos os jogos, quantas pessoas compareceram ao torneio inteiro?',
   3031000, 'pessoas', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2018, 'pending');

-- Família B: total de gols marcados no torneio inteiro (todas as partidas somadas), por edição de
-- Copa do Mundo.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('A Copa do Mundo de 1934, na Itália, teve só 17 jogos no formato eliminatório direto. Somando todos os gols de todas as partidas, quantos gols saíram no torneio inteiro?',
   70, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1934, 'pending'),
  ('A Copa do Mundo de 1938, na França, teve 18 jogos ao todo. Somando todos os gols de todas as partidas, quantos gols saíram no torneio inteiro?',
   84, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1938, 'pending'),
  ('A Copa do Mundo de 1954, na Suíça, teve a maior média de gols por jogo da história do torneio. Somando todos os gols de todas as 26 partidas, quantos gols saíram no torneio inteiro?',
   140, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1954, 'pending'),
  ('A Copa do Mundo de 1958, na Suécia, marcou a estreia de Pelé, com 35 jogos disputados. Somando todos os gols de todas as partidas, quantos gols saíram no torneio inteiro?',
   126, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1958, 'pending'),
  ('A Copa do Mundo de 1962, no Chile, teve 32 jogos disputados. Somando todos os gols de todas as partidas, quantos gols saíram no torneio inteiro?',
   89, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1962, 'pending'),
  ('A Copa do Mundo de 1970, no México, teve 32 jogos e ficou marcada pelo tricampeonato do Brasil. Somando todos os gols de todas as partidas, quantos gols saíram no torneio inteiro?',
   95, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1970, 'pending'),
  ('A Copa do Mundo de 1978, na Argentina, teve 38 jogos disputados. Somando todos os gols de todas as partidas, quantos gols saíram no torneio inteiro?',
   102, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1978, 'pending'),
  ('A Copa do Mundo de 1986, no México, teve 52 jogos com 24 seleções em disputa. Somando todos os gols de todas as partidas, quantos gols saíram no torneio inteiro?',
   132, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1986, 'pending'),
  ('A Copa do Mundo de 1994, nos Estados Unidos, teve 52 jogos disputados. Somando todos os gols de todas as partidas, quantos gols saíram no torneio inteiro?',
   141, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1994, 'pending'),
  ('A Copa do Mundo de 2002, na Coreia do Sul e no Japão, foi a primeira disputada com 32 seleções, em 64 jogos. Somando todos os gols de todas as partidas, quantos gols saíram no torneio inteiro?',
   161, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2002, 'pending');

-- Família C: idade do técnico campeão no momento da conquista, por edição de Copa do Mundo.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('Vittorio Pozzo comandou a Itália ao título da Copa do Mundo de 1934, em casa. Com quantos anos ele venceu aquela edição?',
   47, 'anos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1934, 'pending'),
  ('Vittorio Pozzo é o único técnico a vencer duas Copas do Mundo seguidas, repetindo o título com a Itália em 1938. Com quantos anos ele venceu aquela segunda edição?',
   51, 'anos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1938, 'pending'),
  ('Vicente Feola comandou o Brasil ao primeiro título mundial da história, em 1958, na Suécia. Com quantos anos ele venceu aquela Copa?',
   48, 'anos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1958, 'pending'),
  ('Alf Ramsey comandou a Inglaterra ao único título mundial da seleção, em 1966, jogando em casa. Com quantos anos ele venceu aquela Copa?',
   46, 'anos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1966, 'pending'),
  ('Mário Zagallo é lembrado como o técnico mais jovem a vencer uma Copa do Mundo, em 1970, no México. Com quantos anos ele venceu aquela edição?',
   38, 'anos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1970, 'pending'),
  ('Helmut Schön comandou a Alemanha Ocidental ao título de 1974, jogando em casa. Com quantos anos ele venceu aquela Copa?',
   58, 'anos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1974, 'pending'),
  ('Enzo Bearzot comandou a Itália ao tricampeonato mundial em 1982, na Espanha. Com quantos anos ele venceu aquela Copa?',
   55, 'anos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1982, 'pending'),
  ('Carlos Alberto Parreira comandou o Brasil ao tetracampeonato mundial em 1994, nos Estados Unidos. Com quantos anos ele venceu aquela Copa?',
   51, 'anos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1994, 'pending'),
  ('Luiz Felipe Scolari comandou o Brasil ao pentacampeonato mundial em 2002. Com quantos anos ele venceu aquela Copa?',
   53, 'anos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2002, 'pending'),
  ('Joachim Löw comandou a Alemanha ao título mundial de 2014, no Brasil. Com quantos anos ele venceu aquela Copa?',
   54, 'anos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2014, 'pending');

-- Família D: número de seleções participantes, por edição de Copa do Mundo (crescimento do
-- formato ao longo da história).
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('A primeira Copa do Mundo, em 1930 no Uruguai, teve um número de seleções bem menor do que hoje. Quantas seleções disputaram aquela edição?',
   13, 'seleções', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1930, 'pending'),
  ('A Copa do Mundo de 1934, na Itália, já teve uma fase classificatória com muitos países disputando vaga. Quantas seleções disputaram a fase final daquela edição?',
   16, 'seleções', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1934, 'pending'),
  ('A Copa do Mundo de 1938, na França, teve a saída da Áustria da lista de participantes por causa da anexação nazista pouco antes do torneio. Quantas seleções, no fim, disputaram aquela edição?',
   15, 'seleções', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1938, 'pending'),
  ('A Copa do Mundo de 1950, no Brasil, teve várias seleções convidadas que acabaram desistindo antes do início. Quantas seleções, no fim, disputaram aquela edição?',
   13, 'seleções', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1950, 'pending'),
  ('A Copa do Mundo de 1954, na Suíça, manteve o mesmo formato de participantes das edições anteriores do pós-guerra. Quantas seleções disputaram aquela edição?',
   16, 'seleções', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1954, 'pending'),
  ('A Copa do Mundo de 1970, no México, ainda seguia o formato de participantes usado desde os anos 1950. Quantas seleções disputaram aquela edição?',
   16, 'seleções', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1970, 'pending'),
  ('A Copa do Mundo de 1982, na Espanha, ampliou pela primeira vez o número de seleções na fase final. Quantas seleções disputaram aquela edição?',
   24, 'seleções', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1982, 'pending'),
  ('A Copa do Mundo de 1994, nos Estados Unidos, ainda usava o formato de 24 seleções adotado em 1982. Quantas seleções disputaram aquela edição?',
   24, 'seleções', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1994, 'pending'),
  ('A Copa do Mundo de 1998, na França, ampliou de novo o número de seleções na fase final. Quantas seleções disputaram aquela edição?',
   32, 'seleções', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1998, 'pending'),
  ('A Copa do Mundo de 2026, sediada por México, Estados Unidos e Canadá, estreou o maior formato da história do torneio. Quantas seleções disputaram aquela edição?',
   48, 'seleções', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2026, 'pending');

-- Família E: total de gols marcados no torneio inteiro (todas as partidas somadas), por edição de
-- Eurocopa.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('A primeira Eurocopa, em 1960, teve só 4 seleções na fase final. Somando todos os gols de todas as partidas, quantos gols saíram no torneio inteiro?',
   17, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1960, 'pending'),
  ('A Eurocopa de 1968, também com só 4 seleções, é lembrada como uma das edições mais defensivas da história. Somando todos os gols de todas as partidas, quantos gols saíram no torneio inteiro?',
   7, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1968, 'pending'),
  ('A Eurocopa de 1976, na Iugoslávia, ficou marcada pela pintura de Panenka na decisão por pênaltis. Somando todos os gols de todas as partidas, quantos gols saíram no torneio inteiro?',
   19, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1976, 'pending'),
  ('A Eurocopa de 1980, na Itália, foi a primeira disputada com 8 seleções na fase final. Somando todos os gols de todas as partidas, quantos gols saíram no torneio inteiro?',
   27, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1980, 'pending'),
  ('A Eurocopa de 1984, na França, teve Michel Platini como artilheiro isolado do torneio. Somando todos os gols de todas as partidas, quantos gols saíram no torneio inteiro?',
   41, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1984, 'pending'),
  ('A Eurocopa de 1988, na Alemanha Ocidental, foi vencida pela Holanda de Van Basten. Somando todos os gols de todas as partidas, quantos gols saíram no torneio inteiro?',
   34, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1988, 'pending'),
  ('A Eurocopa de 1996, na Inglaterra, foi a primeira disputada com 16 seleções na fase final. Somando todos os gols de todas as partidas, quantos gols saíram no torneio inteiro?',
   64, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1996, 'pending'),
  ('A Eurocopa de 2004, em Portugal, terminou com o título surpreendente da Grécia. Somando todos os gols de todas as partidas, quantos gols saíram no torneio inteiro?',
   77, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2004, 'pending'),
  ('A Eurocopa de 2016, na França, foi a primeira disputada com 24 seleções na fase final. Somando todos os gols de todas as partidas, quantos gols saíram no torneio inteiro?',
   108, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2016, 'pending'),
  ('A Eurocopa de 2020, disputada em 2021 por causa da pandemia, teve jogos espalhados por vários países da Europa. Somando todos os gols de todas as partidas, quantos gols saíram no torneio inteiro?',
   142, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2021, 'pending');

-- Família F: clube campeão da Copa dos Campeões Europeus / Champions League — quantos títulos
-- europeus o clube já tinha acumulado até aquela conquista (contando-a), por década.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('O Real Madrid venceu as cinco primeiras edições da Copa dos Campeões Europeus, de 1956 a 1960. Ao vencer a edição de 1960, com quantos títulos europeus o clube já contava?',
   5, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1960, 'pending'),
  ('O Benfica, de Eusébio, quebrou a hegemonia do Real Madrid ao vencer a Copa dos Campeões Europeus de 1962. Com quantos títulos europeus o clube português já contava depois dessa conquista?',
   2, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1962, 'pending'),
  ('O Milan venceu a Copa dos Campeões Europeus de 1969 com um time recheado de estrelas. Com quantos títulos europeus o clube italiano já contava depois dessa conquista?',
   2, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1969, 'pending'),
  ('O Ajax, do "futebol total" de Johan Cruyff, venceu sua terceira Copa dos Campeões Europeus seguida em 1973. Com quantos títulos europeus o clube holandês já contava depois dessa conquista?',
   3, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1973, 'pending'),
  ('O Liverpool, sob o comando de Bob Paisley, venceu a Copa dos Campeões Europeus de 1981. Com quantos títulos europeus o clube inglês já contava depois dessa conquista?',
   3, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1981, 'pending'),
  ('O Milan de Arrigo Sacchi venceu a Copa dos Campeões Europeus de 1990, sua segunda seguida. Com quantos títulos europeus o clube italiano já contava depois dessa conquista?',
   5, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1990, 'pending'),
  ('O Real Madrid venceu a Champions League de 1998, apelidada de "La Séptima" pela torcida do clube. Com quantos títulos europeus o clube espanhol já contava depois dessa conquista?',
   7, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1998, 'pending'),
  ('O Milan venceu a Champions League de 2007, batendo o Liverpool numa revanche da final de 2005. Com quantos títulos europeus o clube italiano já contava depois dessa conquista?',
   7, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2007, 'pending'),
  ('O Barcelona de Pep Guardiola venceu a Champions League de 2011 com atuações lembradas até hoje. Com quantos títulos europeus o clube catalão já contava depois dessa conquista?',
   3, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2011, 'pending'),
  ('O Real Madrid venceu a Champions League de 2018, sua terceira seguida sob Zinedine Zidane. Com quantos títulos europeus o clube espanhol já contava depois dessa conquista?',
   13, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2018, 'pending');

-- Família G: Bola de Ouro histórico — ano de conquista de jogadores anteriores a Messi e
-- Cristiano Ronaldo (o prêmio nasceu em 1956).
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('Stanley Matthews, o "mágico das pernas finas" do futebol inglês, foi o primeiro jogador da história a receber o prêmio. Em que ano ele venceu a primeira Bola de Ouro?',
   1956, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1956, 'pending'),
  ('Alfredo Di Stéfano dominou o Real Madrid nos primeiros anos da Copa dos Campeões Europeus. Em que ano ele venceu sua primeira Bola de Ouro?',
   1957, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1957, 'pending'),
  ('Eusébio, o "Pantera Negra", foi o grande nome do Benfica nas décadas de 1960 e 1970. Em que ano ele venceu sua única Bola de Ouro?',
   1965, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1965, 'pending'),
  ('Bobby Charlton foi peça-chave do título mundial da Inglaterra em 1966. Em que ano ele venceu sua única Bola de Ouro?',
   1966, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1966, 'pending'),
  ('Johan Cruyff, símbolo do "futebol total" holandês, venceria o prêmio três vezes ao longo da carreira. Em que ano ele venceu a primeira delas?',
   1971, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1971, 'pending'),
  ('Franz Beckenbauer, o "Kaiser" do futebol alemão, também venceria o prêmio duas vezes na carreira. Em que ano ele venceu a primeira delas?',
   1972, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1972, 'pending'),
  ('Michel Platini venceu o prêmio três vezes seguidas na década de 1980. Em que ano ele venceu a primeira delas?',
   1983, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1983, 'pending'),
  ('Marco van Basten também venceria o prêmio três vezes, começando ainda como jogador do Milan. Em que ano ele venceu a primeira delas?',
   1988, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1988, 'pending'),
  ('George Weah foi o primeiro jogador africano da história a vencer o prêmio. Em que ano ele conquistou essa Bola de Ouro?',
   1995, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1995, 'pending'),
  ('Zinedine Zidane venceu o prêmio no mesmo ano em que foi eleito melhor jogador da Copa do Mundo de 1998. Em que ano ele conquistou essa Bola de Ouro?',
   1998, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1998, 'pending');

-- Família H: técnicos campeões de múltiplas competições internacionais/continentais.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('Mário Zagallo é uma figura única na história da Copa do Mundo: venceu o torneio como jogador, como técnico e como membro de comissão técnica. Somando todas essas conquistas, quantas Copas do Mundo diferentes ele venceu ao todo?',
   4, 'títulos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1994, 'pending'),
  ('Carlo Ancelotti é o técnico mais vitorioso da história da Champions League. Quantos títulos da competição ele já venceu como treinador?',
   5, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2024, 'pending'),
  ('Zinedine Zidane venceu a Champions League três vezes seguidas como técnico do Real Madrid, entre 2016 e 2018. Quantos títulos da competição ele venceu ao todo como treinador?',
   3, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2018, 'pending'),
  ('Pep Guardiola venceu a Champions League com dois clubes diferentes na carreira de técnico. Quantos títulos da competição ele já venceu ao todo como treinador?',
   3, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('Bob Paisley comandou o Liverpool em sua época mais vitoriosa na Europa, nas décadas de 1970 e 1980. Quantas Copas dos Campeões Europeus ele venceu como técnico do clube?',
   3, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1983, 'pending'),
  ('José Mourinho é um dos poucos técnicos a vencer a Champions League com dois clubes diferentes, Porto e Inter de Milão. Quantos títulos da competição ele já venceu ao todo?',
   2, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2010, 'pending'),
  ('Ernst Happel venceu a Copa dos Campeões Europeus com dois clubes diferentes, Feyenoord e Hamburgo, em décadas distintas. Quantos títulos da competição ele venceu ao todo?',
   2, 'títulos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1983, 'pending'),
  ('Ottmar Hitzfeld também venceu a Champions League com dois clubes diferentes, Borussia Dortmund e Bayern de Munique. Quantos títulos da competição ele venceu ao todo?',
   2, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2001, 'pending'),
  ('Carlos Bianchi é o técnico mais vitorioso da história da Copa Libertadores, dirigindo Vélez Sarsfield e Boca Juniors. Quantos títulos da competição ele venceu ao todo como treinador?',
   3, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2001, 'pending'),
  ('Luiz Felipe Scolari venceu a Copa Libertadores com dois clubes brasileiros diferentes, Grêmio e Palmeiras, na década de 1990. Quantos títulos da competição ele venceu ao todo como treinador?',
   2, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1999, 'pending');

-- Família I: árbitros históricos — recordes e números de carreira em competições internacionais.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('Pierluigi Collina, um dos árbitros mais reconhecidos da história, apitou a final da Copa do Mundo de 2002. Quantas partidas ao todo ele apitou naquela edição, incluindo a final?',
   4, 'jogos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2002, 'pending'),
  ('Howard Webb foi o árbitro escolhido para apitar a final da Copa do Mundo de 2010, entre Espanha e Holanda. Com quantos anos ele apitou aquela final?',
   38, 'anos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2010, 'pending'),
  ('Néstor Pitana foi o árbitro argentino escolhido para apitar a final da Copa do Mundo de 2018, entre França e Croácia. Com quantos anos ele apitou aquela final?',
   43, 'anos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2018, 'pending'),
  ('Ravshan Irmatov, árbitro uzbeque, apitou a partida de abertura de duas Copas do Mundo seguidas. Em quantas edições seguidas ele apitou a abertura do torneio?',
   2, 'copas', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2014, 'pending'),
  ('Marco Rodríguez, o "Chiquimarco" mexicano, teve uma carreira longa apitando Copas do Mundo. Em quantas edições diferentes do torneio ele apitou partidas?',
   4, 'copas', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2018, 'pending'),
  ('Björn Kuipers, árbitro holandês, apitou grandes decisões continentais ao longo da carreira. Quantas finais de Eurocopa e Champions League somadas ele apitou na carreira?',
   3, 'finais', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'),
  ('Sándor Puhl, árbitro húngaro, apitou a final da Copa do Mundo de 1994, entre Brasil e Itália. Com quantos anos ele apitou aquela final?',
   51, 'anos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1994, 'pending'),
  ('Horacio Elizondo, árbitro argentino, apitou a final da Copa do Mundo de 2006, marcada pela expulsão de Zidane. Quantas partidas ao todo ele apitou naquela edição, incluindo a final?',
   5, 'jogos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2006, 'pending'),
  ('Stéphanie Frappart entrou para a história ao apitar Alemanha e Costa Rica pela Copa do Mundo. Em que ano ela se tornou a primeira árbitra mulher a apitar uma partida de Copa do Mundo masculina?',
   2022, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2022, 'pending'),
  ('Wilton Pereira Sampaio, árbitro brasileiro, se tornou uma referência da CONMEBOL na Copa Libertadores. Quantas finais da competição ele já havia apitado na carreira até 2024?',
   2, 'finais', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2024, 'pending');

-- Família J: mudanças de regra do futebol ao longo da história — ano de introdução.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('Antes de existirem cartões, o árbitro só avisava verbalmente um jogador antes de expulsá-lo, o que gerava confusão em jogos internacionais. Em que ano os cartões amarelo e vermelho estrearam numa Copa do Mundo?',
   1970, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1970, 'pending'),
  ('A regra do "gol de ouro" encerrava a prorrogação assim que um time marcasse, sem esperar o tempo todo. Em que ano essa regra estreou numa Copa do Mundo?',
   1998, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1998, 'pending'),
  ('Depois de gerar críticas por incentivar um futebol mais cauteloso na prorrogação, a regra do gol de ouro acabou sendo abandonada pela IFAB. Em que ano ela foi oficialmente extinta?',
   2004, 'ano', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2004, 'pending'),
  ('O árbitro de vídeo mudou a forma de revisar lances polêmicos no futebol de alto nível. Em que ano o VAR estreou oficialmente numa Copa do Mundo?',
   2018, 'ano', 'futebol', 1, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2018, 'pending'),
  ('Até o início dos anos 1990, o goleiro podia pegar com as mãos qualquer passe que um companheiro lhe desse de trás. Em que ano a regra que proíbe isso passou a valer oficialmente?',
   1992, 'ano', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1992, 'pending'),
  ('Antes da mudança, uma vitória valia apenas um ponto a mais que um empate em muitos torneios oficiais. Em que ano o sistema de três pontos por vitória foi usado pela primeira vez numa Copa do Mundo?',
   1994, 'ano', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1994, 'pending'),
  ('Nas primeiras Copas do Mundo, um jogador que se contundia simplesmente jogava o resto da partida machucado, sem poder ser substituído. Em que ano as substituições foram permitidas pela primeira vez numa Copa do Mundo?',
   1970, 'ano', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1970, 'pending'),
  ('Antes da introdução dessa regra, partidas empatadas em mata-mata de Copa do Mundo eram decididas por sorteio ou repetidas em um novo jogo. Em que ano a disputa de pênaltis foi usada pela primeira vez para decidir uma partida de Copa do Mundo?',
   1982, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1982, 'pending'),
  ('Durante muito tempo, cada equipe podia fazer apenas três substituições por partida em competições oficiais da FIFA. Em que ano o limite passou a ser cinco substituições de forma permanente?',
   2022, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2022, 'pending'),
  ('A regra do impedimento já teve versões bem diferentes da atual, exigindo mais jogadores adversários entre o atacante e a linha de fundo. Em que ano a regra foi alterada para o formato moderno, com apenas dois jogadores necessários?',
   1925, 'ano', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1925, 'pending');

-- Família K: recordes de idade em competições internacionais (fora do já coberto para Copa do
-- Mundo em lotes anteriores).
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('Lamine Yamal se tornou o jogador mais jovem da história a disputar uma partida de Eurocopa, em 2024. Com quantos anos ele fez essa estreia?',
   16, 'anos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2024, 'pending'),
  ('Johan Vonlanthen, da Suíça, se tornou o jogador mais jovem a marcar um gol numa Eurocopa, em 2004. Com quantos anos ele marcou aquele gol?',
   18, 'anos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2004, 'pending'),
  ('Pepe, zagueiro português, se tornou um dos jogadores mais velhos a disputar uma partida de Eurocopa, em 2021. Com quantos anos ele jogou aquela edição?',
   41, 'anos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2021, 'pending'),
  ('Kazuyoshi Miura, atacante japonês, é reconhecido pelo Guinness como o jogador de futebol profissional mais velho ainda em atividade no mundo. Com quantos anos ele seguia jogando profissionalmente em 2024?',
   57, 'anos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2024, 'pending'),
  ('Ronaldo Fenômeno já era um fenômeno mundial aos 21 anos, quando venceu sua primeira Bola de Ouro, em 1997. Com quantos anos ele conquistou esse prêmio?',
   21, 'anos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1997, 'pending'),
  ('Pelé se tornou o jogador mais jovem da história a disputar (e vencer) uma final de Copa do Mundo, em 1958. Com quantos anos ele disputou aquela final?',
   17, 'anos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1958, 'pending'),
  ('Dino Zoff se tornou o goleiro mais velho a ser campeão do mundo, em 1982, comandando a Itália. Com quantos anos ele conquistou aquele título?',
   40, 'anos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1982, 'pending'),
  ('Ivica Vastić, austríaco naturalizado, se tornou o jogador mais velho a marcar um gol numa Eurocopa, em 2008, jogando em casa. Com quantos anos ele marcou aquele gol?',
   38, 'anos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2008, 'pending'),
  ('Kylian Mbappé se tornou o segundo jogador mais jovem da história, depois de Pelé, a marcar um gol numa final de Copa do Mundo, em 2018. Com quantos anos ele marcou aquele gol?',
   19, 'anos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2018, 'pending'),
  ('Michael Owen estreou pela seleção principal da Inglaterra ainda muito jovem, antes de se tornar artilheiro da Copa do Mundo de 1998. Com quantos anos ele fez sua estreia pela seleção?',
   18, 'anos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1998, 'pending');

-- Família L: Copa Libertadores — ano do primeiro título por país e contagem de títulos por
-- clube ao longo da história.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('O Uruguai foi o primeiro país a ter um clube campeão da Copa Libertadores, com o Peñarol vencendo a edição inaugural do torneio. Em que ano foi essa primeira conquista?',
   1960, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1960, 'pending'),
  ('O Brasil teve o Santos, de Pelé, como seu primeiro clube campeão da Copa Libertadores. Em que ano foi essa primeira conquista brasileira?',
   1962, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1962, 'pending'),
  ('A Argentina teve o Independiente como seu primeiro clube campeão da Copa Libertadores. Em que ano foi essa primeira conquista argentina?',
   1964, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1964, 'pending'),
  ('O Paraguai teve o Olimpia como seu primeiro clube campeão da Copa Libertadores, quebrando a hegemonia dos grandes países do continente. Em que ano foi essa primeira conquista paraguaia?',
   1979, 'ano', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1979, 'pending'),
  ('A Colômbia teve o Atlético Nacional como seu primeiro clube campeão da Copa Libertadores. Em que ano foi essa primeira conquista colombiana?',
   1989, 'ano', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1989, 'pending'),
  ('O Chile teve o Colo-Colo como seu primeiro e único clube campeão da Copa Libertadores até hoje. Em que ano foi essa conquista chilena?',
   1991, 'ano', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1991, 'pending'),
  ('O Equador teve a LDU de Quito como seu primeiro e único clube campeão da Copa Libertadores até hoje. Em que ano foi essa conquista equatoriana?',
   2008, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2008, 'pending'),
  ('O Boca Juniors é um dos clubes mais vitoriosos da história da Copa Libertadores. Quantos títulos da competição o clube argentino já venceu ao todo?',
   6, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2007, 'pending'),
  ('O River Plate também acumula uma boa coleção de títulos continentais na história da Copa Libertadores. Quantos títulos da competição o clube argentino já venceu ao todo?',
   4, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2018, 'pending'),
  ('O Peñarol, campeão da primeira edição da Copa Libertadores, segue entre os clubes mais vitoriosos da história do torneio. Quantos títulos da competição o clube uruguaio já venceu ao todo?',
   5, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1987, 'pending');

-- Família M: Copa América — número de títulos vencidos por seleção ao longo da história.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('A Argentina se tornou a seleção mais vitoriosa da história da Copa América depois do título de 2024. Quantos títulos do torneio a seleção argentina já venceu ao todo?',
   16, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2024, 'pending'),
  ('O Uruguai foi, por décadas, a seleção mais vitoriosa da história da Copa América. Quantos títulos do torneio a seleção uruguaia já venceu ao todo?',
   15, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2011, 'pending'),
  ('O Brasil é a terceira seleção mais vitoriosa da história da Copa América. Quantos títulos do torneio a seleção brasileira já venceu ao todo?',
   9, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2019, 'pending'),
  ('O Paraguai já surpreendeu o continente ao vencer a Copa América mais de uma vez na história. Quantos títulos do torneio a seleção paraguaia já venceu ao todo?',
   2, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1979, 'pending'),
  ('O Peru também já ergueu a taça da Copa América mais de uma vez ao longo da história. Quantos títulos do torneio a seleção peruana já venceu ao todo?',
   2, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1975, 'pending'),
  ('O Chile viveu seu auge com dois títulos seguidos de Copa América na década de 2010. Quantos títulos do torneio a seleção chilena já venceu ao todo?',
   2, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2016, 'pending'),
  ('A Bolívia venceu sua única Copa América jogando em casa, em pleno altiplano de La Paz. Quantos títulos do torneio a seleção boliviana já venceu ao todo?',
   1, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1963, 'pending'),
  ('A Colômbia venceu sua única Copa América jogando em casa, no início dos anos 2000. Quantos títulos do torneio a seleção colombiana já venceu ao todo?',
   1, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2001, 'pending'),
  ('O Equador nunca conseguiu erguer a taça da Copa América, apesar de décadas de participação. Quantos títulos do torneio a seleção equatoriana já venceu ao todo?',
   0, 'títulos', 'futebol', 1, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2024, 'pending'),
  ('A Venezuela é uma das poucas seleções sul-americanas tradicionais que nunca venceu a Copa América. Quantos títulos do torneio a seleção venezuelana já venceu ao todo?',
   0, 'títulos', 'futebol', 1, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2024, 'pending');

-- Família N: recordes e marcos do Mundial de Clubes da FIFA (e de sua antecessora, a Copa
-- Intercontinental).
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('O formato antigo, pequeno, do Mundial de Clubes da FIFA reuniu campeões continentais numa única edição por ano até 2023. Em que ano foi disputada a primeira edição desse formato?',
   2000, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2000, 'pending'),
  ('O Real Madrid é o clube mais vitorioso da história do Mundial de Clubes da FIFA no formato pequeno. Quantos títulos da competição o clube espanhol já venceu ao todo?',
   5, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2022, 'pending'),
  ('O Real Madrid aplicou uma das maiores goleadas já registradas na história do Mundial de Clubes da FIFA, contra o Al Jazira, dos Emirados Árabes, em 2018. Qual foi a diferença de gols nessa goleada?',
   8, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2018, 'pending'),
  ('O Corinthians é o clube brasileiro com mais títulos do Mundial de Clubes da FIFA no formato pequeno, vencendo em duas ocasiões diferentes. Quantos títulos da competição o clube já venceu ao todo?',
   2, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2012, 'pending'),
  ('Antes do Mundial de Clubes da FIFA, existia a Copa Intercontinental, disputada entre os campeões da Europa e da América do Sul. Em que ano foi disputada a primeira edição dessa competição?',
   1960, 'ano', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1960, 'pending'),
  ('O Milan é um dos clubes mais vitoriosos da história da Copa Intercontinental, antecessora do Mundial de Clubes da FIFA. Quantos títulos dessa competição o clube italiano já venceu ao todo?',
   3, 'títulos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2007, 'pending'),
  ('A partir de 2025, o Mundial de Clubes da FIFA passou a ter um formato bem maior do que o torneio pequeno disputado desde 2000. Em que ano estreou esse novo formato, com 32 clubes?',
   2025, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2025, 'pending'),
  ('No formato pequeno do Mundial de Clubes da FIFA (2000 a 2023), só clubes de duas confederações conseguiram vencer o título: Europa e América do Sul. Quantas confederações diferentes venceram o torneio nesse período?',
   2, 'confederações', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O TP Mazembe, da República Democrática do Congo, surpreendeu o mundo ao chegar à final do Mundial de Clubes da FIFA. Em que ano um clube africano ou asiático chegou pela primeira vez a essa final?',
   2010, 'ano', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2010, 'pending'),
  ('O Barcelona goleou o Santos, de Neymar, na final do Mundial de Clubes da FIFA de 2011, um dos jogos mais lembrados da competição. Qual foi o placar final dessa decisão?',
   3, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2011, 'pending');
