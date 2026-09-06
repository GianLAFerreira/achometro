-- Onda 5 do tópico futebol — lote variado (mesmo espírito da onda 4): recordes de clube,
-- competição e seleção, nunca estatística individual de carreira de jogador. Já nasce 'approved':
-- cada pergunta foi pesquisada e a fonte verificada no momento de ser escrita. Sem fonte travada
-- única pro lote — cada uma buscou sua própria fonte pela hierarquia (oficial > agregador
-- consolidado > imprensa).
--
-- Descartados do pool original de 8 candidatos, por sobreposição com temas já cobertos ou falta
-- de fonte consolidada: "recorde de público em partida no Brasil" (mesmo fato-base do Maracanã já
-- coberto por "público recorde em clássicos/finais por estádio"); "maior sequência sem sofrer gols
-- no Brasileirão" (sem fonte que consolide isso como recorde geral da competição); "técnicos
-- diferentes da seleção desde 2002" (mesma forma de "técnicos diferentes por clube 2014-2023", só
-- trocando clube por seleção).
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('Na era dos pontos corridos do Brasileirão (desde 2003), qual o recorde de vitórias seguidas por um clube dentro de uma mesma edição do campeonato?',
   9, 'vitórias', 'futebol', 2,
   'Lance! — "Corinthians pode igualar recorde da era dos pontos corridos"',
   'https://www.lance.com.br/corinthians/corinthians-pode-igualar-maior-sequencia-de-vitorias-na-era-dos-pontos-corridos.html',
   2024, 'approved'),
  ('A primeira edição do Brasileirão em pontos corridos, em 2003, teve 24 clubes e 46 rodadas — mais que as 38 de hoje. Quantos pontos o Cruzeiro somou como campeão isolado daquela edição?',
   100, 'pontos', 'futebol', 2,
   'Goal.com Brasil — "Cruzeiro campeão de 2003: recordes, elenco e tudo sobre o título do Brasileirão"',
   'https://www.goal.com/br/not%C3%ADcias/cruzeiro-campeao-de-2003-recordes-elenco-e-tudo-sobre-o-titulo-do-brasileirao/9y5hnl3cujr615x1xu31afbqm',
   2003, 'approved'),
  ('Em 2009, o Flamengo só assumiu a ponta do Brasileirão na 37ª de 38 rodadas e fechou campeão com a menor pontuação de um título na era dos pontos corridos. Quantos pontos ele somou?',
   67, 'pontos', 'futebol', 2,
   'Lance! — "Qual foi o campeão brasileiro com menos pontos?"',
   'https://www.lance.com.br/futebol-nacional/qual-foi-o-campeao-brasileiro-com-menos-pontos.html',
   2009, 'approved'),
  ('Entre dezembro de 1993 e janeiro de 1996 — passando pelo tetra de 94 —, a seleção brasileira principal emendou a maior invencibilidade da sua história, encerrada numa derrota para o México na final da Copa Ouro. Quantos jogos seguidos sem perder foram esses?',
   36, 'jogos', 'futebol', 2,
   'ESPN — "Sem perder há 1.020 dias, Itália se candidata a recorde de invencibilidade entre seleções..."',
   'https://www.espn.com.br/futebol/artigo/_/id/8829729/eurocopa-italia-defende-serie-invicta-de-1020-dias-e-ameaca-recorde-historico-do-brasil-veja-quanto-falta',
   1996, 'approved'),
  ('O Brasil é disparado o maior exportador de jogadores de futebol do mundo, à frente de França e Argentina, segundo o CIES Football Observatory. Quantos brasileiros o levantamento mais recente (2026) contou atuando profissionalmente em mais de 135 ligas fora do país?',
   1455, 'jogadores', 'futebol', 3,
   'CIES Football Observatory — Weekly Post nº 546, maio de 2026',
   'https://football-observatory.com/-Posts-',
   2026, 'approved');
