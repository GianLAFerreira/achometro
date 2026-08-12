-- Lote 1 — amostra de 10 perguntas para playtest com pessoas reais, antes de completar
-- o banco (~150). Validadas pelo agente curador-perguntas contra os 4 critérios de aceite.

insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year)
values
  (
    'Quantos gols saíram na Copa do Mundo de 2026, contando todas as fases do torneio?',
    308, 'gols', 'esportes', 3,
    'Wikipedia (agregando dados da FIFA) e Yahoo Sports',
    'https://en.wikipedia.org/wiki/2026_FIFA_World_Cup',
    2026
  ),
  (
    'Quantos veículos (carros, motos, caminhões etc.) formam a frota total do Brasil?',
    123974520, 'veículos', 'brasil', 2,
    'Senatran (Secretaria Nacional de Trânsito) — dez/2024',
    'https://www.gov.br/transportes/pt-br/assuntos/transito/conteudo-Senatran/estatisticas-frota-de-veiculos-senatran',
    2024
  ),
  (
    'Qual é a população da cidade de São Paulo hoje?',
    11905000, 'habitantes', 'brasil', 2,
    'IBGE — Estimativas da População 2025',
    'https://cidades.ibge.gov.br/brasil/sp/sao-paulo',
    2025
  ),
  (
    'O Tocantins é um dos estados mais novos do Brasil (criado em 1988) e tem população relativamente pequena. Quantos municípios você acha que ele tem?',
    139, 'municípios', 'brasil', 3,
    'IBGE — Cidades e Estados',
    'https://www.ibge.gov.br/cidades-e-estados/to/',
    2024
  ),
  (
    'Quantos verbetes, locuções e definições tem a 5ª edição do Novo Dicionário Aurélio da Língua Portuguesa (2010)?',
    435000, 'verbetes', 'cultura', 3,
    'Editora Positivo — divulgação oficial da 5ª edição',
    'https://www.positivoemfoco.com.br/2019/08/12/novas-versoes-digitais-do-aurelio/',
    2010
  ),
  (
    'Quantas vezes, em média, um adulto respira por dia em repouso?',
    22000, 'respirações/dia', 'corpo-humano', 2,
    'Harvard Health Publishing — "Take a Breather"',
    'https://www.health.harvard.edu/heart-health/take-a-breather',
    2024
  ),
  (
    'Qual é a profundidade do ponto mais profundo do oceano, o Challenger Deep, na Fossa das Marianas?',
    10935, 'metros', 'geografia', 2,
    'Greenaway et al. (2021), "Revised depth of the Challenger Deep", Deep Sea Research Part I',
    'https://www.sciencedirect.com/science/article/pii/S0967063721001813',
    2021
  ),
  (
    'Qual o comprimento da maior cobra já medida e registrada oficialmente pelo Guinness World Records (em centímetros)?',
    767, 'centímetros', 'animais', 2,
    'Guinness World Records — "Longest snake ever (captivity)"',
    'https://www.guinnessworldrecords.com/world-records/longest-snake-ever-(captivity)',
    2011
  ),
  (
    'Quantas notas de R$100 estão em circulação no Brasil hoje?',
    1800000000, 'cédulas', 'brasil', 3,
    'Banco Central do Brasil — Sismecir (Sistema de Administração do Meio Circulante)',
    'https://dadosabertos.bcb.gov.br/dataset/dinheiro-em-circulao',
    2024
  ),
  (
    'Qual a distância em linha reta entre Macapá (AP) e Passo Fundo (RS)?',
    3148, 'km', 'geografia', 2,
    'Cálculo geodésico (haversine) a partir das coordenadas oficiais das duas cidades — valor derivado, não publicado diretamente',
    'https://geografos.com.br/cidades-amapa/macapa.php',
    2024
  );
