-- Onda 4 do tópico futebol — lote pequeno e VARIADO, ao contrário das ondas anteriores, que eram
-- famílias homogêneas ("quantos X o jogador Y fez na carreira" repetido com sujeitos diferentes).
-- Feedback do usuário: diversificar a FORMA da pergunta, não só o sujeito — cada uma destas é um
-- assunto de recorde/história de clube ou competição, não estatística individual de carreira.
-- Já nasce 'approved': cada pergunta foi pesquisada e a fonte verificada no momento de ser
-- escrita (mesmo processo do curador-perguntas + skill achometro-perguntas). Sem fonte travada
-- única pro lote — cada pergunta é uma métrica diferente, então cada uma buscou sua própria fonte
-- pela hierarquia (oficial > agregador consolidado > imprensa), não faz sentido travar veículo
-- entre assuntos não relacionados.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('Qual foi a maior diferença de gols já registrada em uma partida do Campeonato Brasileiro Série A?',
   9, 'gols de diferença', 'futebol', 2,
   'Wikipédia — "Lista das maiores goleadas do Campeonato Brasileiro de Futebol - Série A"',
   'https://pt.wikipedia.org/wiki/Lista_das_maiores_goleadas_do_Campeonato_Brasileiro_de_Futebol_-_S%C3%A9rie_A',
   1983, 'approved'),
  ('Desde que o Brasileirão passou a ser disputado em pontos corridos, em 2003, quantos clubes diferentes já foram campeões?',
   9, 'clubes', 'futebol', 2,
   'Wikipedia (inglês) — "Campeonato Brasileiro Série A"',
   'https://en.wikipedia.org/wiki/Campeonato_Brasileiro_S%C3%A9rie_A',
   2025, 'approved'),
  ('Qual é o recorde de jogos seguidos sem perder de um único clube na história do Campeonato Brasileiro Série A?',
   42, 'jogos', 'futebol', 2,
   'Revista Placar — "Quais são as maiores invencibilidades na história do Brasileirão"',
   'https://placar.com.br/brasileirao/quais-sao-as-maiores-invencibilidades-na-historia-do-brasileirao/',
   1978, 'approved'),
  ('Qual foi o maior número de gols marcados por um único time em uma edição do Brasileirão, na era de pontos corridos?',
   103, 'gols', 'futebol', 2,
   'Revista Placar — "Qual time marcou mais gol em uma única edição do Brasileirão?"',
   'https://placar.com.br/brasileirao/qual-times-marcou-mais-gol-em-uma-unica-edicao-do-brasileirao/',
   2004, 'approved'),
  ('Clubes brasileiros raramente pagam dezenas de milhões de euros por um jogador. Qual foi, em reais, o valor da contratação mais cara da história do futebol brasileiro?',
   260000000, 'reais', 'futebol', 3,
   'Lance! — "Paquetá se torna a contratação mais cara da história do futebol brasileiro; veja ranking"',
   'https://www.lance.com.br/lance-negocios/paqueta-se-torna-a-contratacao-mais-cara-da-historia-do-futebol-brasileiro-veja-ranking.html',
   2026, 'approved');
