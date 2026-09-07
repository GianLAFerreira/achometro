-- Onda de aprovação 1/N do tópico história — primeiro lote do tema (4 perguntas; nasceu com 5, mas
-- "Grande Muralha da China" foi removida na revisão da sessão principal porque o agente do tema
-- `geografia`, rodando em paralelo sem visibilidade deste arquivo, pesquisou e aprovou o mesmo
-- fato-base de forma independente — mantida só em geografia_01.sql, encaixe mais natural pra uma
-- medição física). Banco começa do zero (sem restrição de duplicata prévia). Curadoria (2026-09-07)
-- por agente seguindo
-- .claude/agents/curador-perguntas.md + .claude/skills/achometro-perguntas/SKILL.md, com pesquisa
-- real (WebSearch/WebFetch), mais verificação independente do coordenador para os itens 2 (Revolta
-- da Vacina), 4 (população de Roma) e 7 (Grande Muralha).
--
-- Pool original tinha 7 candidatos, formas variadas (duração de guerra/império, vítimas de revolta,
-- distância de expedição histórica, população de cidade antiga, extensão de construção). 5 aprovadas,
-- 2 descartadas antes mesmo de virar linha no banco (não geram registro 'rejected' porque a família
-- não tinha um "sujeito trocável" — são descarte de candidato solto, não de item de família):
--   - Bandeira de Fernão Dias (distância em km): sem fonte que estime a distância percorrida —
--     só há duração em anos (~7) documentada, e essa duração sozinha é número pequeno demais pra
--     estimar (viraria "sabe ou não sabe", não palpite). Descartada por falta de fonte (critério 2).
--   - Total de africanos escravizados desembarcados no Brasil no tráfico transatlântico: a fonte de
--     nível 1 óbvia (slavevoyages.org) é uma aplicação em JavaScript que não pôde ser lida via
--     WebFetch nesta sessão; as fontes secundárias abertas divergem sem citar a primária dentro do
--     texto (~5 milhões vs. ~5,5 milhões vs. um range inutilizável de 4,4-13,2 milhões). Descartada
--     por não fechar o critério 1 (fonte única escolhida por hierarquia) com confiança — não é
--     divergência normal de nível 2/3, é impossibilidade de verificar a fonte de nível 1 candidata.
--     Recomendado retomar numa onda futura com acesso de navegador real ao dado do Slave Voyages.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('A Guerra dos Cem Anos, travada entre Inglaterra e França, apesar do nome não durou exatamente 100 anos. Quantos anos ela durou de fato, entre o primeiro e o último ano do conflito?',
   116, 'anos', 'historia', 2,
   'Wikipedia — "Hundred Years'' War" (datas 1337-1453 consolidadas na historiografia, sem divergência relevante entre fontes)',
   'https://en.wikipedia.org/wiki/Hundred_Years%27_War',
   2026, 'approved'),
  ('Em 1904, uma revolta popular contra a vacinação obrigatória tomou as ruas do Rio de Janeiro, então capital do país com quase 800 mil habitantes. Quantas pessoas morreram nos confrontos?',
   30, 'mortos', 'historia', 2,
   'Wikipédia — "Revolta da Vacina" (número consolidado a partir de Carvalho, "Os Bestializados", 2005; Sevcenko, "A Revolta da Vacina", 1999; e Benchimol, 2003 — verificado diretamente via WebFetch)',
   'https://pt.wikipedia.org/wiki/Revolta_da_Vacina',
   2026, 'approved'),
  ('No auge do Império Romano, no século 2 d.C., a cidade de Roma era o maior centro urbano do mundo antigo — nenhuma outra cidade do Ocidente teria população parecida até o século 19. Qual era a população estimada da cidade, em número de habitantes?',
   1000000, 'habitantes', 'historia', 2,
   'Wikipedia — "Demography of the Roman Empire" (estimativa convencional de ~1 milhão para a cidade de Roma nos séculos 1-2 d.C., citando o historiador Ian Morris — verificado diretamente via WebFetch)',
   'https://en.wikipedia.org/wiki/Demography_of_the_Roman_Empire',
   2026, 'approved'),
  ('O Império Bizantino manteve viva a tradição romana no Oriente depois da queda de Roma, em 476, até ser derrubado pelos otomanos, em 1453. Quantos anos ele resistiu nesse intervalo?',
   977, 'anos', 'historia', 2,
   'Wikipedia — "Byzantine Empire" (datas de início e fim consolidadas na historiografia; marco didático 476-1453, não o marco acadêmico alternativo da fundação de Constantinopla em 330)',
   'https://en.wikipedia.org/wiki/Byzantine_Empire',
   2026, 'approved');
