-- Onda de aprovação 1/7 do tópico futebol — status 'pending': start_round só sorteia
-- status = 'approved' (ver migration 20260812152453_exige_dois_jogadores_pra_iniciar.sql),
-- então nada aqui chega a uma partida real até ser promovido pelo agente curador-perguntas
-- (.claude/agents/curador-perguntas.md). source_name/source_url são marcadores explícitos de
-- "ainda não verificado" — nunca URL inventada. answer é candidato de memória, ponto de partida
-- pra curadoria confirmar, corrigir ou reprovar.

-- Família: cartões vermelhos na carreira de jogadores brasileiros.
-- Curadoria (2026-09-05): fonte travada da família = matéria de imprensa esportiva brasileira
-- dedicada a somar o total de cartões vermelhos/expulsões de carreira de um jogador (tier 3 da
-- hierarquia — tiers 1 e 2 não cobrem este dado: não há total oficial agregado, e nem
-- Transfermarkt/FBref nem Flashscore/Sofascore têm uma soma confiável de carreira inteira).
-- Só 4 dos 10 candidatos originais tinham esse tipo de matéria; os outros 6 foram reprovados
-- (não têm fonte, não trocar por "melhor esforço") e ficam como registro de que já foram
-- avaliados — não apagar a linha, senão a pergunta volta numa onda futura. Substitutos precisam
-- ser testados antes contra a existência desse gênero de matéria, não escritos de memória.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('Quantos cartões vermelhos Felipe Melo recebeu na carreira profissional, somando todos os clubes e a seleção?',
   34, 'cartões vermelhos', 'futebol', 3,
   'Flashscore.com.br — "Quantas expulsões tem Felipe Melo na carreira? Veja lista de cartões" (dados de Transfermarkt e Globo Esporte)',
   'https://www.flashscore.com.br/noticias/futebol-copa-do-brasil-quantas-expulsoes-tem-felipe-melo-na-carreira-veja-lista-de-cartoes/UmeAL8km/',
   2023, 'approved'),
  ('Léo Moura jogou mais de 20 anos como lateral, boa parte no Flamengo. Quantos cartões vermelhos ele levou na carreira?',
   14, 'cartões vermelhos', 'futebol', 3,
   'REJEITADA — sem fonte pública que some cartões vermelhos de carreira inteira (Flashscore cobre só 256 dos 932 jogos reais)',
   'rejected://sem-fonte-de-carreira', 2024, 'rejected'),
  ('Réver foi capitão do Atlético-MG campeão da Libertadores e depois do Flamengo. Quantos cartões vermelhos levou na carreira?',
   11, 'cartões vermelhos', 'futebol', 3,
   'REJEITADA — sem fonte pública que some cartões vermelhos de carreira inteira (Flashscore cobre só 300+ dos 722 jogos reais)',
   'rejected://sem-fonte-de-carreira', 2024, 'rejected'),
  ('O zagueiro Gum rodou por Corinthians e outros grandes clubes brasileiros. Quantos cartões vermelhos recebeu na carreira?',
   13, 'cartões vermelhos', 'futebol', 3,
   'REJEITADA — âncora incorreta (Gum nunca jogou no Corinthians; é ídolo do Fluminense, 2009-2018) e sem fonte de total de carreira',
   'rejected://sem-fonte-de-carreira', 2024, 'rejected'),
  ('Edu Dracena foi zagueiro símbolo do Palmeiras nos anos 2010. Quantos cartões vermelhos ele levou na carreira?',
   9, 'cartões vermelhos', 'futebol', 3,
   'REJEITADA — sem fonte pública que some cartões vermelhos de carreira inteira (Transfermarkt bloqueado, ogol.com.br e FootballCritic sem essa coluna)',
   'rejected://sem-fonte-de-carreira', 2024, 'rejected'),
  ('O zagueiro Wallace virou ídolo do Grêmio na década de 2010. Quantos cartões vermelhos recebeu na carreira profissional?',
   12, 'cartões vermelhos', 'futebol', 3,
   'REJEITADA — sujeito não confere: não há zagueiro "Wallace" ídolo do Grêmio na década de 2010 com carreira longa no clube (o ídolo real da posição no período é Pedro Geromel)',
   'rejected://sujeito-nao-confere', 2024, 'rejected'),
  ('David Braz passou por Grêmio, Santos e outros clubes como zagueiro. Quantos cartões vermelhos levou na carreira?',
   10, 'cartões vermelhos', 'futebol', 3,
   'REJEITADA — sem fonte citável de total de carreira (um valor de 7 apareceu em busca, mas sem URL rastreável por trás)',
   'rejected://sem-fonte-de-carreira', 2024, 'rejected'),
  ('Fágner defendeu o Corinthians como lateral por mais de uma década. Quantos cartões vermelhos recebeu na carreira?',
   8, 'cartões vermelhos', 'futebol', 3,
   'Goal.com Brasil — "Quantas vezes Fagner recebeu cartão vermelho em sua carreira"',
   'https://www.goal.com/br/notícias/quantas-vezes-fagner-recebeu-cartao-vermelho-em-sua-carreira/iphnw9fwp8vz15irybusmfpn3',
   2024, 'approved'),
  ('Bruno Henrique, atacante do Flamengo, levou quantos cartões vermelhos na carreira profissional até hoje?',
   7, 'cartões vermelhos', 'futebol', 3,
   'Gávea News — "Bruno Henrique, Carlinhos, Pablo, Gerson... os jogadores do Flamengo com mais cartões vermelhos na carreira"',
   'https://www.gaveanews.com/index.php/2025/02/15/bruno-henrique-carlinhos-pablo-gerson-carlos-alcaraz-ayrton-lucas-alex-sandro-erick-pulgar-allan-e-de-la-cruz-os-jogadores-do-flamengo-com-mais-cartoes-vermelhos-na-carreira/',
   2025, 'approved'),
  ('Everton Ribeiro, ex-Flamengo e hoje no Bahia, também defendeu a seleção brasileira. Quantos cartões vermelhos recebeu na carreira?',
   6, 'cartões vermelhos', 'futebol', 3,
   'O Tempo — "Everton Ribeiro, do Bahia, lamenta expulsão contra o Corinthians: ''Prejudiquei o time''"',
   'https://www.otempo.com.br/sports/futebol-nacional/bahia/2025/3/31/everton-ribeiro-do-bahia-lamenta-expulsao-contra-o-corinthians-prejudiquei-o-time',
   2025, 'approved');

-- Família: gols contra sofridos por clubes na história do Brasileirão (era de pontos corridos,
-- desde 2003) — gols marcados contra o próprio time por jogadores do clube.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('Desde a era de pontos corridos (2003), quantos gols contra o Flamengo já sofreu no Brasileirão por erro dos próprios jogadores?',
   28, 'gols contra', 'futebol', 3,
   'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2024, 'pending'),
  ('Desde 2003, quantos gols contra o Palmeiras já sofreu no Brasileirão por erro dos próprios jogadores?',
   24, 'gols contra', 'futebol', 3,
   'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2024, 'pending'),
  ('Desde 2003, quantos gols contra o São Paulo já sofreu no Brasileirão por erro dos próprios jogadores?',
   30, 'gols contra', 'futebol', 3,
   'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2024, 'pending'),
  ('Desde 2003, quantos gols contra o Corinthians já sofreu no Brasileirão por erro dos próprios jogadores?',
   26, 'gols contra', 'futebol', 3,
   'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2024, 'pending'),
  ('Desde 2003, quantos gols contra o Grêmio já sofreu no Brasileirão por erro dos próprios jogadores?',
   22, 'gols contra', 'futebol', 3,
   'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2024, 'pending'),
  ('Desde 2003, quantos gols contra o Internacional já sofreu no Brasileirão por erro dos próprios jogadores?',
   25, 'gols contra', 'futebol', 3,
   'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2024, 'pending'),
  ('Desde 2003, quantos gols contra o Cruzeiro já sofreu no Brasileirão por erro dos próprios jogadores?',
   27, 'gols contra', 'futebol', 3,
   'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2024, 'pending'),
  ('Desde 2003, quantos gols contra o Atlético-MG já sofreu no Brasileirão por erro dos próprios jogadores?',
   23, 'gols contra', 'futebol', 3,
   'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2024, 'pending'),
  ('Desde 2003, quantos gols contra o Santos já sofreu no Brasileirão por erro dos próprios jogadores?',
   29, 'gols contra', 'futebol', 3,
   'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2024, 'pending'),
  ('Desde 2003, quantos gols contra o Fluminense já sofreu no Brasileirão por erro dos próprios jogadores?',
   21, 'gols contra', 'futebol', 3,
   'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2024, 'pending');

-- Família: público recorde em clássicos e finais brasileiras, por estádio.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('Qual foi o maior público pagante já registrado numa final de campeonato estadual no Maracanã, num Fla-Flu decisivo?',
   177656, 'pessoas', 'futebol', 3,
   'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1963, 'pending'),
  ('Qual foi o maior público pagante já registrado numa final entre Cruzeiro e Atlético-MG no Mineirão?',
   132834, 'pessoas', 'futebol', 3,
   'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1997, 'pending'),
  ('Qual foi o maior público pagante já registrado num São Paulo x Corinthians no Morumbi?',
   138032, 'pessoas', 'futebol', 3,
   'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1977, 'pending'),
  ('Qual foi o público do jogo de inauguração da Arena Corinthians, em 2014?',
   47605, 'pessoas', 'futebol', 2,
   'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2014, 'pending'),
  ('Qual foi o maior público pagante já registrado num Grenal (Internacional x Grêmio) no Beira-Rio?',
   108000, 'pessoas', 'futebol', 3,
   'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1990, 'pending'),
  ('Qual foi o maior público pagante já registrado num Coritiba x Athletico-PR (Atletiba) no Couto Pereira?',
   42000, 'pessoas', 'futebol', 3,
   'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1990, 'pending'),
  ('Qual foi o maior público pagante já registrado num Sport x Náutico na antiga Ilha do Retiro?',
   60000, 'pessoas', 'futebol', 3,
   'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1988, 'pending'),
  ('Qual foi o maior público pagante já registrado num Santos x Palmeiras na Vila Belmiro?',
   32000, 'pessoas', 'futebol', 2,
   'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1985, 'pending'),
  ('Qual foi o público de um Palmeiras x Corinthians (Choque-Rei) na Allianz Parque desde a inauguração da arena?',
   43713, 'pessoas', 'futebol', 2,
   'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2018, 'pending'),
  ('Qual foi o maior público pagante já registrado num Bahia x Vitória (Ba-Vi) na Arena Fonte Nova?',
   56500, 'pessoas', 'futebol', 3,
   'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2015, 'pending');

-- Família: anos sem vencer o Campeonato Brasileiro Série A, por clube que já foi campeão nacional
-- ao menos uma vez (jejum contado até 2024).
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('O Botafogo foi campeão brasileiro em 1995. Até 2024, há quantos anos o clube não repete o título nacional?',
   29, 'anos', 'futebol', 2,
   'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2024, 'pending'),
  ('O Vasco foi campeão brasileiro em 2000. Até 2024, há quantos anos o clube não repete o título nacional?',
   24, 'anos', 'futebol', 2,
   'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2024, 'pending'),
  ('O Grêmio foi campeão brasileiro em 1996. Até 2024, há quantos anos o clube não repete o título nacional?',
   28, 'anos', 'futebol', 2,
   'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2024, 'pending'),
  ('O Fluminense foi campeão brasileiro em 2010. Até 2024, há quantos anos o clube não repete o título nacional?',
   14, 'anos', 'futebol', 2,
   'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2024, 'pending'),
  ('O Guarani, de Campinas, foi campeão brasileiro em 1978 — um dos títulos mais surpreendentes da história. Há quantos anos o clube não repete a façanha, até 2024?',
   46, 'anos', 'futebol', 3,
   'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2024, 'pending'),
  ('O Santos foi campeão brasileiro em 2004, com um time recheado de jovens promessas. Até 2024, há quantos anos o clube não repete o título?',
   20, 'anos', 'futebol', 2,
   'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2024, 'pending'),
  ('O Internacional tem seu último título brasileiro reconhecido pela CBF em 1979. Até 2024, há quantos anos o clube não é campeão nacional?',
   45, 'anos', 'futebol', 3,
   'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2024, 'pending'),
  ('O Cruzeiro foi campeão brasileiro em 2003. Até 2024, há quantos anos o clube não repete o título nacional?',
   21, 'anos', 'futebol', 2,
   'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2024, 'pending'),
  ('O Atlético-MG foi campeão brasileiro em 2021, quebrando um jejum histórico. Até 2024, há quantos anos o clube não repete o título?',
   3, 'anos', 'futebol', 1,
   'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2024, 'pending'),
  ('O Corinthians foi campeão brasileiro em 2017. Até 2024, há quantos anos o clube não repete o título nacional?',
   7, 'anos', 'futebol', 2,
   'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2024, 'pending');

-- Família: quantidade de técnicos diferentes que comandaram um clube brasileiro entre 2014 e 2023
-- (dez temporadas).
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('O Botafogo é conhecido pela alta rotatividade de comando. Quantos técnicos diferentes passaram pelo clube entre 2014 e 2023?',
   22, 'técnicos diferentes', 'futebol', 3,
   'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O Cruzeiro viveu anos turbulentos após o rebaixamento de 2019. Quantos técnicos diferentes passaram pelo clube entre 2014 e 2023?',
   20, 'técnicos diferentes', 'futebol', 3,
   'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O Vasco trocou de comando com frequência na última década. Quantos técnicos diferentes passaram pelo clube entre 2014 e 2023?',
   19, 'técnicos diferentes', 'futebol', 3,
   'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O Corinthians teve fases de instabilidade técnica mesmo sendo um clube grande. Quantos técnicos diferentes passaram pelo clube entre 2014 e 2023?',
   14, 'técnicos diferentes', 'futebol', 2,
   'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O Santos trocou de técnico com frequência buscando repetir os anos de Neymar. Quantos técnicos diferentes passaram pelo clube entre 2014 e 2023?',
   17, 'técnicos diferentes', 'futebol', 3,
   'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O Fluminense teve mais estabilidade que outros grandes cariocas, mas também trocou de comando algumas vezes. Quantos técnicos diferentes passaram pelo clube entre 2014 e 2023?',
   13, 'técnicos diferentes', 'futebol', 2,
   'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O Bahia viveu altos e baixos entre a Série A e a Série B na última década. Quantos técnicos diferentes passaram pelo clube entre 2014 e 2023?',
   16, 'técnicos diferentes', 'futebol', 3,
   'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O Ceará se estabilizou na Série A na última década, mas ainda trocou de técnico algumas vezes. Quantos técnicos diferentes passaram pelo clube entre 2014 e 2023?',
   12, 'técnicos diferentes', 'futebol', 2,
   'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O Coritiba alternou entre Série A e Série B nos últimos dez anos. Quantos técnicos diferentes passaram pelo clube entre 2014 e 2023?',
   18, 'técnicos diferentes', 'futebol', 3,
   'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O Atlético-GO subiu e desceu de divisão mais de uma vez na última década. Quantos técnicos diferentes passaram pelo clube entre 2014 e 2023?',
   15, 'técnicos diferentes', 'futebol', 3,
   'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending');
