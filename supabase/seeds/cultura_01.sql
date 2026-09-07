-- Onda de aprovação 1/N do tópico cultura. Banco tinha só 1 pergunta do tema até aqui (verbetes do
-- Aurélio, em supabase/seed.sql) — este lote não repete o fato-base nem o molde ("quantidade de
-- verbetes de dicionário"): mistura bilheteria de cinema, certificação de vendas de música, valor
-- de leilão de arte, apresentações de um musical na Broadway e cópias vendidas de videogame.
-- Curadoria (2026-09-07), pesquisa real (WebFetch) direto nas fontes, seguindo
-- .claude/agents/curador-perguntas.md + .claude/skills/achometro-perguntas/SKILL.md.
--
-- Pool original tinha 7 candidatos; 5 aprovados, 2 descartados antes de virar linha no banco (sem
-- "sujeito trocável" de família aqui — são candidatos soltos, não itens de uma família):
--   - Recorde Guinness de "romance mais longo" (Em Busca do Tempo Perdido, de Proust): o número
--     (9.609.000 caracteres) está confirmado na própria página oficial do Guinness, mas a página
--     não informa nenhum ano de registro/verificação do recorde — só as datas de publicação
--     original da obra (1912/1913), que não são "o ano do dado". Descartada por critério 2 (fonte
--     citável, mas sem ano rastreável para o próprio recorde).
--   - Total de cópias de Minecraft vendidas: a Wikipédia cita "mais de 400 milhões" mas o trecho
--     acessível via WebFetch não expôs a referência (autor/veículo/data) por trás do número — sem
--     conseguir isolar uma fonte datada e citável, ficou por baixo do critério 2. Recomendado
--     retomar numa onda futura com acesso direto ao press release da Microsoft/Xbox.
--
-- Nota de fonte (critério 1): bilheteria de filme usa Box Office Mojo (nível 2 da hierarquia,
-- agregador consolidado, citado explicitamente como referência aceita); certificação de álbum usa
-- a base oficial da RIAA (nível 1); valor de leilão de obra de arte usa Wikipédia (nível 2,
-- cobertura consolidada do leilão da Christie's — tentativa de acessar christies.com diretamente
-- falhou por bloqueio técnico do fetch); apresentações de musical na Broadway usa Wikípedia citando
-- Broadway League/Playbill (nível 2); cópias de jogo vendidas usa Wikipédia citando a própria The
-- Tetris Company (nível 1 repassado por agregador, data explícita no texto).
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('Avatar (2009), de James Cameron, está entre os filmes de maior bilheteria da história mundial do cinema, somando a estreia original e várias reestreias ao longo dos anos. Quantos dólares ele arrecadou ao todo nas bilheterias do mundo inteiro?',
   2923710708, 'dólares', 'cultura', 2,
   'Box Office Mojo — "Avatar (2009) — Worldwide Lifetime Grosses"',
   'https://www.boxofficemojo.com/title/tt0499549/',
   2025, 'approved'),

  ('Thriller, de Michael Jackson (1982), é o álbum mais premiado pela RIAA na história dos Estados Unidos. Quantas cópias certificadas a RIAA reconhece para ele até hoje?',
   34000000, 'cópias certificadas', 'cultura', 2,
   'RIAA — Gold & Platinum Database, "Thriller" (Michael Jackson), certificação de 20/08/2021',
   'https://www.riaa.com/gold-platinum/?tab_active=default-award&ar=Michael+Jackson&ti=Thriller',
   2021, 'approved'),

  ('O quadro Salvator Mundi, atribuído a Leonardo da Vinci, foi arrematado num leilão da Christie''s em Nova York em 2017 e se tornou a obra de arte mais cara já vendida publicamente. Por quantos dólares, somando a taxa da casa de leilões, ele foi vendido?',
   450312500, 'dólares', 'cultura', 2,
   'Wikipédia, "Salvator Mundi (Leonardo)" — leilão Christie''s de 15 de novembro de 2017',
   'https://en.wikipedia.org/wiki/Salvator_Mundi_(Leonardo)',
   2017, 'approved'),

  ('O musical "O Fantasma da Ópera" fechou as portas na Broadway em 2023 depois de décadas ininterruptas em cartaz, o maior recorde de longevidade daquele circuito teatral. Quantas apresentações ele somou ao todo?',
   13981, 'apresentações', 'cultura', 3,
   'Wikipédia (citando Broadway League/Playbill), "The Phantom of the Opera (1986 musical)"',
   'https://en.wikipedia.org/wiki/The_Phantom_of_the_Opera_(1986_musical)',
   2023, 'approved'),

  ('Tetris, lançado em 1984, é um dos jogos mais simples já criados — só blocos caindo e se encaixando — mas também um dos mais vendidos de todos os tempos, com versões em praticamente toda plataforma já lançada. Quantas cópias a The Tetris Company contabiliza vendidas no mundo todo?',
   520000000, 'cópias', 'cultura', 2,
   'The Tetris Company, via Wikipédia "Tetris" (dado de dezembro de 2024)',
   'https://en.wikipedia.org/wiki/Tetris',
   2024, 'approved');
