-- Lote 1 do tema corpo-humano (além da única pergunta já existente em supabase/seed.sql:
-- "Quantas vezes, em média, um adulto respira por dia em repouso?", 22000 respirações/dia).
-- Curadoria seguindo .claude/agents/curador-perguntas.md + .claude/skills/achometro-perguntas/SKILL.md,
-- com pesquisa real (WebSearch/WebFetch). Pool de ~9 candidatos pesquisados, cobrindo as categorias
-- sugeridas (recorde Guinness, comprimento de estrutura, litros de sangue bombeado, velocidade de
-- reflexo, duração de processo biológico) sem repetir o fato-base ou o molde da pergunta existente.
--
-- Descartes (não entram no insert abaixo, ficam só documentados aqui):
-- 1. "Comprimento do intestino delgado" — descartada por critério 3 (estimabilidade): a diferença
--    entre medição em pessoa viva (~3 m) e em cadáver (~6,5 m, sem tônus muscular) é de mais do
--    dobro — não é divergência normal entre fontes, é o próprio método de medição que muda o
--    número, o que vira sorteio entre dois valores cientificamente válidos e incompatíveis.
-- 2. "Comprimento total dos vasos sanguíneos do corpo" — descartada por critério 2 (fonte pública
--    citável): o número popular "100.000 km" é a estimativa antiga de August Krogh (anos 1920) e
--    cobre só capilares, não todos os vasos; a literatura mais recente estima 9.000-19.000 km só
--    de capilares. Não existe fonte que meça o total de artérias+veias+capilares somados — número
--    de internet sem lastro atual.
-- 3. "Velocidade máxima de condução do impulso nervoso (120 m/s)" — descartada por critério 2: a
--    própria Wikipédia marca essa cifra com "[citation needed]"; nenhum textbook ou paper primário
--    foi encontrado sustentando esse valor específico.
-- Nota: "capacidade pulmonar total" (StatPearls/NIH, ~6 litros) e "total de batimentos cardíacos
-- na vida" (~2,8 bilhões, Wikipédia) também passariam nos 4 critérios, mas ficaram de fora deste
-- lote de 5 por variedade (o lote já cobre débito cardíaco e recorde de resistência/anatomia).

insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  (
    'Recordistas de apneia podem respirar oxigênio puro por até 30 minutos antes de prender a respiração, o que estica bastante o fôlego. Quantos segundos dura o recorde mundial (Guinness) de apneia estática com esse preparo?',
    1743, 'segundos', 'corpo-humano', 3,
    'Guinness World Records — "Longest time breath held voluntarily underwater (male)" (Vitomir Maričić, 29min03s)',
    'https://www.guinnessworldrecords.com/world-records/longest-time-breath-held-voluntarily-(male)',
    2025, 'approved'
  ),
  (
    'Uma mulher chinesa começou a deixar o cabelo crescer aos 13 anos e nunca mais cortou. Qual o comprimento do cabelo mais longo já registrado oficialmente pelo Guinness World Records, em milímetros?',
    5627, 'milímetros', 'corpo-humano', 3,
    'Wikipedia, citando o Guinness World Records — "Xie Qiuping" (recorde de cabelo mais longo, categoria feminina, 5,627 m)',
    'https://en.wikipedia.org/wiki/Xie_Qiuping',
    2004, 'approved'
  ),
  (
    'Um coração adulto em repouso bate, em média, cerca de 70 vezes por minuto, empurrando um pouco de sangue a cada batida. Quantos litros de sangue, ao todo, esse coração bombeia em um dia inteiro?',
    7200, 'litros/dia', 'corpo-humano', 2,
    'NIH — StatPearls, "Physiology, Cardiac Output" (débito cardíaco de repouso 5-6 L/min; litros/dia é cálculo derivado a partir de 5 L/min × 1440 min)',
    'https://www.ncbi.nlm.nih.gov/books/NBK470455/',
    2023, 'approved'
  ),
  (
    'Um piscar de olhos dura cerca de 100 a 150 milissegundos. Quantos milissegundos, em média, o cérebro de uma pessoa jovem leva para reagir a um estímulo visual simples, como uma luz acendendo?',
    190, 'milissegundos', 'corpo-humano', 2,
    'Wikipedia — "Reaction time", citando Kosinski, R.J. (2008) "A Literature Review on Reaction Time", Clemson University',
    'https://en.wikipedia.org/wiki/Reaction_time',
    2008, 'approved'
  ),
  (
    'A pele humana está sempre se renovando: novas células nascem na camada mais profunda da epiderme e sobem até descamar na superfície. Quantos dias, em média, leva esse ciclo completo de renovação?',
    48, 'dias', 'corpo-humano', 2,
    'Iizuka, H. (1994), "Epidermal turnover time", Journal of Dermatological Science, 8(3):215-217 (citado por Wikipedia — "Epidermis")',
    'https://en.wikipedia.org/wiki/Epidermis',
    1994, 'approved'
  );
