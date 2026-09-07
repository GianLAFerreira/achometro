-- Onda de aprovação 2/N do tópico história (5 perguntas). Curadoria (2026-09-07) seguindo
-- .claude/agents/curador-perguntas.md + .claude/skills/achometro-perguntas/SKILL.md, com pesquisa
-- real via WebFetch direto em Wikipedia (WebSearch chegou ao limite de sessão antes de começar
-- este lote; todas as verificações abaixo foram feitas lendo a página-fonte, não por busca).
--
-- Cuidado explícito com cruzamento de tema: nenhum candidato deste lote é monumento/estrutura
-- física (o Canal do Panamá foi cogitado e descartado por esse motivo mesmo depois de passar nos
-- 4 critérios — ver descartes). Nenhum fato-base repete o que já está em historia_01.sql (duração
-- de guerra/império, mortos de revolta, população de cidade antiga).
--
-- Pool pesquisado (11 candidatos, mais que os ~7 planejados porque vários caíram por fonte
-- contestada ou não específica o suficiente):
--   1. Elefantes de guerra de Aníbal sobreviventes à travessia dos Alpes (218 a.C.) — DESCARTADA:
--      as fontes (Wikipedia "Hannibal's crossing of the Alps") descrevem a dificuldade da travessia
--      mas não dão uma contagem específica de elefantes sobreviventes, só de homens. Falha
--      critério 2 (fonte não cobre o dado exato).
--   2. Extensão da Longa Marcha comunista chinesa (1934-35), em km — DESCARTADA: divergência real
--      entre 6.000 km (pesquisa britânica de 2006), ~9.375 km (mídia chinesa) e 10.000-12.500 km
--      (relatos de época/Mao), com a própria Wikipedia descrevendo "controvérsia" historiográfica
--      desde 2003. Não é variação normal de agregador (critério 1) — é número contestado. Falha
--      critério 1.
--   3. Tamanho da frota de invasão de Guilherme, o Conquistador, em 1066 — DESCARTADA: a própria
--      Wikipedia ("Norman conquest of England") cita 776 navios só de uma fonte de época e avisa
--      que "pode ser um número inflado", com "números exatos desconhecidos". Falha critério 2
--      (fonte não é confiável o suficiente pra fechar um gabarito).
--   4. Mortos romanos na Batalha de Canas (216 a.C.) — DESCARTADA: fontes antigas variam de 45.500
--      a 70.000, e estimativas modernas vão de 10.500 a 48.200 — a própria Wikipedia registra que
--      "estudiosos modernos discordam fortemente das fontes antigas". Número historicamente
--      contestado, não divergência normal de nível 2/3. Falha critério 1.
--   5. Mortos na Grande Fome irlandesa (1845-1852) — APROVADA (ver abaixo).
--   6. Tamanho da Grande Armée de Napoleão na invasão da Rússia (1812) — APROVADA (ver abaixo).
--   7. Execuções no Terror francês (1793-94) — passou nos 4 critérios (16.594 sentenças de morte
--      oficiais em toda a França, por Wikipedia "Reign of Terror"), mas foi trocada por outro
--      candidato pra não deixar o lote concentrado em França/era napoleônica (já há a Grande Armée)
--      — não é reprovação por critério, é ajuste de variedade do lote.
--   8. Mortos na construção do Canal do Panamá (1881-1914) — passou nos 4 critérios (~22.000 na
--      fase francesa + ~5.600 na fase americana, por Wikipedia "Panama Canal"), mas foi trocada
--      por precaução: é uma estrutura física famosa, o mesmo tipo de assunto que já gerou
--      cruzamento com o tema `geografia` no lote anterior (Grande Muralha). Troca preventiva, não
--      reprovação por critério.
--   9. Migrantes atraídos pela Corrida do Ouro da Califórnia (1848-1855) — APROVADA (ver abaixo).
--  10. Soldados evacuados em Dunquerque (1940) — APROVADA (ver abaixo).
--  11. Extensão da Marcha do Sal de Gandhi (1930) — APROVADA (ver abaixo).
--
-- As 5 aprovadas, todas nível 2 da hierarquia (Wikipedia agregando fonte historiográfica
-- consolidada — não há fonte de nível 1 tipo IBGE para fatos históricos deste tipo, mesmo padrão
-- já usado em historia_01.sql):
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('Em 1812, Napoleão invadiu a Rússia à frente da Grande Armée, o maior exército multinacional já reunido na Europa até então. Quantos soldados formavam essa força no início da invasão?',
   685000, 'soldados', 'historia', 2,
   'Wikipedia — "Grande Armée" (685.000 homens reunidos em 24 de junho de 1812, pouco antes da invasão — verificado diretamente via WebFetch)',
   'https://en.wikipedia.org/wiki/Grande_Arm%C3%A9e',
   2026, 'approved'),
  ('A Grande Fome irlandesa, causada pela praga da batata entre 1845 e 1852, atingiu um país que tinha cerca de 8 milhões de habitantes antes da crise. Quantas pessoas morreram de fome e doença nesse período?',
   1000000, 'mortos', 'historia', 2,
   'Wikipedia — "Great Famine (Ireland)" (total de mortes de aproximadamente 1 milhão, conforme infobox e corpo do artigo — verificado diretamente via WebFetch)',
   'https://en.wikipedia.org/wiki/Great_Famine_(Ireland)',
   2026, 'approved'),
  ('A descoberta de ouro na Califórnia em 1848 disparou uma das maiores corridas migratórias da história dos Estados Unidos, atraindo gente do país inteiro e do exterior. Quantas pessoas haviam chegado à região atrás de ouro até 1855?',
   300000, 'pessoas', 'historia', 2,
   'Wikipedia — "California Gold Rush" (estimativa de ao menos 300.000 garimpeiros, comerciantes e imigrantes chegados à Califórnia entre 1848 e 1855 — verificado diretamente via WebFetch)',
   'https://en.wikipedia.org/wiki/California_Gold_Rush',
   2026, 'approved'),
  ('Em maio de 1940, tropas aliadas ficaram cercadas pelos alemães no litoral francês perto de Dunquerque, numa situação que Churchill chamaria de "desastre colossal". Quantos soldados foram retirados dali por mar na evacuação que se seguiu?',
   338226, 'soldados', 'historia', 2,
   'Wikipedia — "Dunkirk evacuation" (338.226 soldados aliados evacuados entre 26 de maio e 4 de junho de 1940 — verificado diretamente via WebFetch)',
   'https://en.wikipedia.org/wiki/Dunkirk_evacuation',
   2026, 'approved'),
  ('Em 1930, Gandhi liderou uma marcha de protesto contra o monopólio britânico do sal, saindo do Ashram de Sabarmati até o litoral de Dandi. Quantos quilômetros teve esse trajeto?',
   387, 'km', 'historia', 1,
   'Wikipedia — "Salt March" (387 km entre Sabarmati e Dandi, sem divergência relevante entre fontes — verificado diretamente via WebFetch)',
   'https://en.wikipedia.org/wiki/Salt_March',
   2026, 'approved');
