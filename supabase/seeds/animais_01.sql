-- Onda de aprovação do tópico animais (lote 1). Curadoria em 2026-09-07 seguindo
-- .claude/agents/curador-perguntas.md + .claude/skills/achometro-perguntas/SKILL.md, com
-- pesquisa real (WebFetch em Wikipédia, PLOS ONE e IUCN Red List — WebSearch indisponível por
-- esgotamento de orçamento da sessão). Já existia 1 pergunta de tema 'animais' no banco (maior
-- cobra já medida, Guinness) — este lote evita repetir tanto o fato-base quanto o molde
-- "recorde do Guinness medido em cm".
--
-- Pool de 7 candidatos pesquisados, 5 aprovados, 2 descartados (não inseridos — motivo aqui):
-- - Onça-pintada, maior peso já registrado (kg): descartada — a Wikipédia cita 158 kg mas as
--   referências [39]/[40] não puderam ser localizadas com autor/publicação/ano verificáveis, e
--   não ficou claro se o valor é de exemplar selvagem ou cativo. Sem fonte rastreável = critério 2.
-- - Falcão-peregrino, velocidade máxima de mergulho (km/h): descartada — o número mais divulgado
--   (389 km/h) vem de um programa de TV da National Geographic (Ken Franklin, 2005), sem
--   revisão científica, e a própria Wikipédia registra que radares nunca confirmaram acima de
--   184 km/h para a espécie. Divergência demais para travar um número confiável (critério 1/2).
--
-- As 5 aprovadas, cada uma com sua própria fonte e tipo de recorde (sem repetir molde entre si):
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  (
    'O peixe-lua (Mola mola) põe mais ovos de uma vez do que qualquer outro vertebrado conhecido. Quantos ovos, aproximadamente, uma fêmea consegue produzir em uma única desova?',
    300000000, 'ovos', 'animais', 3,
    'Wikipédia — "Ocean sunfish", citando Freedman, J. A.; Noakes, D. L. G. (2002), "Why are there no really big bony fishes?", Reviews in Fish Biology and Fisheries',
    'https://en.wikipedia.org/wiki/Ocean_sunfish',
    2002, 'approved'
  ),
  (
    'A andorinha-do-ártico é considerada o animal com a maior migração anual do planeta, voando entre o Ártico e a Antártida todo ano. Qual a maior distância, em quilômetros, já registrada para um indivíduo rastreado em uma única jornada de 10 meses?',
    96000, 'km', 'animais', 2,
    'Wikipédia — "Arctic tern", citando BBC News, "Arctic tern in record-breaking migration from Farne Islands" (7 de junho de 2016)',
    'https://en.wikipedia.org/wiki/Arctic_tern',
    2016, 'approved'
  ),
  (
    'Um estudo publicado na revista Science em 2016 identificou o tubarão-da-Groenlândia como o vertebrado com a maior expectativa de vida já registrada, usando datação por radiocarbono no cristalino dos olhos. Quantos anos os cientistas estimaram para o exemplar mais velho analisado?',
    392, 'anos', 'animais', 3,
    'Wikipédia — "Greenland shark", citando Nielsen, J. et al. (2016), "Eye lens radiocarbon reveals centuries of longevity in the Greenland shark", Science, v. 353',
    'https://en.wikipedia.org/wiki/Greenland_shark',
    2016, 'approved'
  ),
  (
    'O zifio-de-Cuvier é o mamífero com o mergulho mais profundo já monitorado por cientistas, superando em mais de 1.100 metros o recorde anterior da espécie. Qual a profundidade máxima, em metros, registrada nesse estudo de 2014?',
    2992, 'metros', 'animais', 2,
    'Schorr, G. S.; Falcone, E. A.; Moretti, D. J.; Andrews, R. D. (2014), "First Long-Term Behavioral Records from Cuvier''s Beaked Whales (Ziphius cavirostris) Reveal Record-Breaking Dives", PLOS ONE',
    'https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0092633',
    2014, 'approved'
  ),
  (
    'O panda-gigante é um dos maiores símbolos mundiais de espécie ameaçada, com habitat restrito a poucas florestas de bambu na China. Segundo o censo oficial mais recente (concluído em 2014), quantos pandas-gigantes viviam soltos na natureza?',
    1864, 'indivíduos', 'animais', 2,
    'IUCN Red List of Threatened Species — Swaisgood, R.; Wang, D.; Wei, F. (2016), "Ailuropoda melanoleuca"',
    'https://www.iucnredlist.org/species/712/121745669',
    2014, 'approved'
  );
