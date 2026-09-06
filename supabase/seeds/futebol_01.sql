-- Onda de aprovação 1/7 do tópico futebol. A família de cartões vermelhos já foi curada em
-- 2026-09-05; as outras 4 famílias deste arquivo (gols contra, público recorde, anos sem vencer,
-- técnicos) foram curadas em 2026-09-06 por agentes seguindo .claude/agents/curador-perguntas.md
-- + .claude/skills/achometro-perguntas/SKILL.md, com pesquisa real (WebSearch/WebFetch). Todas as
-- perguntas deste arquivo já têm veredito — não sobra nenhuma 'pending'. start_round só sorteia
-- status = 'approved' (ver migration 20260812152453_exige_dois_jogadores_pra_iniciar.sql), então
-- nada com status 'rejected' chega a uma partida real; as linhas rejeitadas ficam como registro de
-- que já foram avaliadas — não apagar, senão a pergunta volta numa onda futura sem esse histórico.

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
-- Curadoria (2026-09-06): família inteira reprovada. Pesquisa exaustiva (CBF, Sofascore,
-- Transfermarkt, imprensa) não achou nenhuma fonte pública que agregue "total de gols contra
-- sofridos por clube desde 2003" — buscas só retornam "gols sofridos" (gols do adversário),
-- estatística diferente. Critério 2 (fonte pública citável) falha para os 10 itens igualmente.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('Desde a era de pontos corridos (2003), quantos gols contra o Flamengo já sofreu no Brasileirão por erro dos próprios jogadores?',
   28, 'gols contra', 'futebol', 3,
   'REJEITADA — nenhuma fonte pública agrega total de gols contra (autogols) sofridos por clube desde 2003',
   'rejected://sem-fonte-de-autogols', 2024, 'rejected'),
  ('Desde 2003, quantos gols contra o Palmeiras já sofreu no Brasileirão por erro dos próprios jogadores?',
   24, 'gols contra', 'futebol', 3,
   'REJEITADA — nenhuma fonte pública agrega total de gols contra (autogols) sofridos por clube desde 2003',
   'rejected://sem-fonte-de-autogols', 2024, 'rejected'),
  ('Desde 2003, quantos gols contra o São Paulo já sofreu no Brasileirão por erro dos próprios jogadores?',
   30, 'gols contra', 'futebol', 3,
   'REJEITADA — nenhuma fonte pública agrega total de gols contra (autogols) sofridos por clube desde 2003',
   'rejected://sem-fonte-de-autogols', 2024, 'rejected'),
  ('Desde 2003, quantos gols contra o Corinthians já sofreu no Brasileirão por erro dos próprios jogadores?',
   26, 'gols contra', 'futebol', 3,
   'REJEITADA — nenhuma fonte pública agrega total de gols contra (autogols) sofridos por clube desde 2003',
   'rejected://sem-fonte-de-autogols', 2024, 'rejected'),
  ('Desde 2003, quantos gols contra o Grêmio já sofreu no Brasileirão por erro dos próprios jogadores?',
   22, 'gols contra', 'futebol', 3,
   'REJEITADA — nenhuma fonte pública agrega total de gols contra (autogols) sofridos por clube desde 2003',
   'rejected://sem-fonte-de-autogols', 2024, 'rejected'),
  ('Desde 2003, quantos gols contra o Internacional já sofreu no Brasileirão por erro dos próprios jogadores?',
   25, 'gols contra', 'futebol', 3,
   'REJEITADA — nenhuma fonte pública agrega total de gols contra (autogols) sofridos por clube desde 2003',
   'rejected://sem-fonte-de-autogols', 2024, 'rejected'),
  ('Desde 2003, quantos gols contra o Cruzeiro já sofreu no Brasileirão por erro dos próprios jogadores?',
   27, 'gols contra', 'futebol', 3,
   'REJEITADA — nenhuma fonte pública agrega total de gols contra (autogols) sofridos por clube desde 2003',
   'rejected://sem-fonte-de-autogols', 2024, 'rejected'),
  ('Desde 2003, quantos gols contra o Atlético-MG já sofreu no Brasileirão por erro dos próprios jogadores?',
   23, 'gols contra', 'futebol', 3,
   'REJEITADA — nenhuma fonte pública agrega total de gols contra (autogols) sofridos por clube desde 2003',
   'rejected://sem-fonte-de-autogols', 2024, 'rejected'),
  ('Desde 2003, quantos gols contra o Santos já sofreu no Brasileirão por erro dos próprios jogadores?',
   29, 'gols contra', 'futebol', 3,
   'REJEITADA — nenhuma fonte pública agrega total de gols contra (autogols) sofridos por clube desde 2003',
   'rejected://sem-fonte-de-autogols', 2024, 'rejected'),
  ('Desde 2003, quantos gols contra o Fluminense já sofreu no Brasileirão por erro dos próprios jogadores?',
   21, 'gols contra', 'futebol', 3,
   'REJEITADA — nenhuma fonte pública agrega total de gols contra (autogols) sofridos por clube desde 2003',
   'rejected://sem-fonte-de-autogols', 2024, 'rejected');

-- Família: público recorde em clássicos e finais brasileiras, por estádio.
-- Curadoria (2026-09-06): cada item é um fato histórico distinto, verificado individualmente
-- contra imprensa esportiva especializada (Lancepédia, Diário do Futebol, Gazeta Esportiva etc.).
-- 8 de 10 aprovadas, quase todas com número e/ou ano corrigidos pela fonte real. 2 reprovadas
-- (Mineirão, Morumbi) não por divergência normal de fonte, e sim porque o candidato original
-- confundiu o adversário do jogo recordista — o número pertence a uma partida diferente da
-- descrita na âncora, e trocar só o adversário na pergunta seria inventar uma "aproximação melhor
-- esforço" (proibido pelo critério 2). Ambas recomendadas para reescrita futura com o confronto
-- certo, não descarte definitivo do estádio como assunto.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('Qual foi o maior público pagante já registrado numa final de campeonato estadual no Maracanã, num Fla-Flu decisivo?',
   177656, 'pessoas', 'futebol', 3,
   'Diário do Futebol — "Os Maiores Públicos da História do Maracanã: o Ranking Completo" (corroborado por Trivela, Terra, Flamengo.com.br e Flashscore)',
   'https://www.diariodofutebol.com.br/historia-do-futebol/maiores-publicos-historia-maracana',
   1963, 'approved'),
  ('Qual foi o maior público pagante já registrado numa final entre Cruzeiro e Atlético-MG no Mineirão?',
   132834, 'pessoas', 'futebol', 3,
   'REJEITADA — o recorde de 132.834 pessoas no Mineirão (22/06/1997) foi Cruzeiro x Villa Nova, não Cruzeiro x Atlético-MG; adversário da âncora não confere com o evento real',
   'rejected://adversario-errado', 1997, 'rejected'),
  ('Qual foi o maior público pagante já registrado num São Paulo x Corinthians no Morumbi?',
   138032, 'pessoas', 'futebol', 3,
   'REJEITADA — os 138.032 pagantes do recorde do Morumbi (09/10/1977) são de Corinthians x Ponte Preta, não São Paulo x Corinthians; adversário da âncora não confere com o evento real',
   'rejected://adversario-errado', 1977, 'rejected'),
  ('Qual foi o público do jogo de inauguração da Arena Corinthians, em 2014?',
   36694, 'pessoas', 'futebol', 2,
   'Todo Poderoso Timão — "Jogos Históricos: Corinthians 0 x 1 Figueirense - A inauguração oficial da Arena Corinthians" (corroborado por ND+ e Lance!)',
   'https://todopoderosotimao.com.br/p_jogos/j_cor_x_fig_arena_14.php',
   2014, 'approved'),
  ('Qual foi o maior público pagante já registrado num Grenal (Internacional x Grêmio) no Beira-Rio?',
   85072, 'pessoas', 'futebol', 3,
   'Lance! — Lancepédia "Maiores públicos do Beira-Rio na história"',
   'https://www.lance.com.br/lancepedia/maiores-publicos-beira-rio.html',
   1971, 'approved'),
  ('Qual foi o maior público pagante já registrado num Coritiba x Athletico-PR (Atletiba) no Couto Pereira?',
   55164, 'pessoas', 'futebol', 3,
   'Rádio Itatiaia — "Couto Pereira teve recorde de público em Coritiba x Athletico-PR? Veja número" (corroborado por Lance! Lancepédia)',
   'https://www.itatiaia.com.br/esportes/futebol/futebol-nacional/futebol-do-sul/coritiba/couto-pereira-teve-recorde-de-publico-em-coritiba-x-athletico-pr-veja-numero',
   1978, 'approved'),
  ('Qual foi o maior público pagante já registrado num Sport x Náutico na antiga Ilha do Retiro?',
   45697, 'pessoas', 'futebol', 3,
   'Campeões do Futebol — "Maiores Públicos do Sport na Ilha do Retiro"',
   'https://www.campeoesdofutebol.com.br/sport_publicos.html',
   1991, 'approved'),
  ('Qual foi o maior público pagante já registrado num Santos x Palmeiras na Vila Belmiro?',
   31662, 'pessoas', 'futebol', 2,
   'Gazeta Esportiva — "Você sabia? Maior público da Vila Belmiro ocorreu em uma amarga derrota santista" (corroborado por Lance! Lancepédia)',
   'https://www.gazetaesportiva.com/times/santos/voce-sabia-maior-publico-da-vila-belmiro-ocorreu-em-uma-amarga-derrota-santista/',
   1976, 'approved'),
  ('Qual foi o público de um Palmeiras x Corinthians (Choque-Rei) na Allianz Parque desde a inauguração da arena?',
   41457, 'pessoas', 'futebol', 2,
   'Palmeiras.com.br — "Com recorde de público no Allianz Parque, Palmeiras bate Corinthians pelo Brasileirão" (corroborado por Lance! Lancepédia e Torcedores.com)',
   'https://www.palmeiras.com.br/noticias/com-recorde-de-publico-no-allianz-parque-palmeiras-bate-corinthians-pelo-brasileirao/',
   2023, 'approved'),
  ('Qual foi o maior público pagante já registrado num Bahia x Vitória (Ba-Vi) na Arena Fonte Nova?',
   48421, 'pessoas', 'futebol', 3,
   'A Tarde — "Saiba quais foram os cinco maiores públicos de Ba-Vi na Fonte Nova"',
   'https://atarde.com.br/esportes/saiba-quais-foram-os-cinco-maiores-publicos-de-ba-vi-na-fonte-nova-1318094',
   2024, 'approved');

-- Família: anos sem vencer o Campeonato Brasileiro Série A, por clube que já foi campeão nacional
-- ao menos uma vez.
-- Curadoria (2026-09-06): fonte travada = Wikipédia "Campeonato Brasileiro Série A" (agregador
-- nível 2, cita o reconhecimento oficial da CBF), mesmo veículo pros 10 itens. Hoje é 2026-09-06 —
-- a última temporada encerrada é 2025 (o candidato original presumia "até 2024"), então os números
-- aprovados foram recalculados pra refletir o jejum atual, e o texto do prompt trocou "2024" por
-- "2025". 3 reprovadas: Botafogo porque foi campeão de novo em 2024 (premissa da família quebrou —
-- deixou de ser um jejum notável); Fluminense e Cruzeiro porque o ano-base do candidato original
-- estava errado (ambos têm título mais recente que o citado: Fluminense em 2012, Cruzeiro em 2014)
-- — não é desatualização, é erro de fato; recomendado reescrever com o ano certo numa onda futura.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('O Botafogo foi campeão brasileiro em 1995. Até 2024, há quantos anos o clube não repete o título nacional?',
   29, 'anos', 'futebol', 2,
   'REJEITADA — Botafogo foi campeão de novo em 2024, premissa do jejum quebrou (jejum real hoje é de menos de 2 anos, sem estimabilidade nem graça)',
   'rejected://premissa-quebrada-campeao-2024', 2024, 'rejected'),
  ('O Vasco foi campeão brasileiro em 2000. Até 2025, há quantos anos o clube não repete o título nacional?',
   25, 'anos', 'futebol', 2,
   'Wikipedia — Campeonato Brasileiro Série A (lista de campeões, conforme reconhecimento CBF)',
   'https://en.wikipedia.org/wiki/Campeonato_Brasileiro_S%C3%A9rie_A',
   2025, 'approved'),
  ('O Grêmio foi campeão brasileiro em 1996. Até 2025, há quantos anos o clube não repete o título nacional?',
   29, 'anos', 'futebol', 2,
   'Wikipedia — Campeonato Brasileiro Série A (lista de campeões, conforme reconhecimento CBF)',
   'https://en.wikipedia.org/wiki/Campeonato_Brasileiro_S%C3%A9rie_A',
   2025, 'approved'),
  ('O Fluminense foi campeão brasileiro em 2010. Até 2024, há quantos anos o clube não repete o título nacional?',
   14, 'anos', 'futebol', 2,
   'REJEITADA — ano-base errado: o Fluminense também foi campeão em 2012, mais recente que o 2010 citado na âncora',
   'rejected://ano-base-errado-campeao-2012', 2024, 'rejected'),
  ('O Guarani, de Campinas, foi campeão brasileiro em 1978 — um dos títulos mais surpreendentes da história. Há quantos anos o clube não repete a façanha, até 2025?',
   47, 'anos', 'futebol', 3,
   'Wikipedia — Campeonato Brasileiro Série A / 1978 Campeonato Brasileiro Série A',
   'https://en.wikipedia.org/wiki/Campeonato_Brasileiro_S%C3%A9rie_A',
   2025, 'approved'),
  ('O Santos foi campeão brasileiro em 2004, com um time recheado de jovens promessas. Até 2025, há quantos anos o clube não repete o título?',
   21, 'anos', 'futebol', 2,
   'Wikipedia — Campeonato Brasileiro Série A (lista de campeões, conforme reconhecimento CBF)',
   'https://en.wikipedia.org/wiki/Campeonato_Brasileiro_S%C3%A9rie_A',
   2025, 'approved'),
  ('O Internacional tem seu último título brasileiro reconhecido pela CBF em 1979. Até 2025, há quantos anos o clube não é campeão nacional?',
   46, 'anos', 'futebol', 3,
   'Wikipedia — Campeonato Brasileiro Série A / 1979 Campeonato Brasileiro Série A',
   'https://en.wikipedia.org/wiki/Campeonato_Brasileiro_S%C3%A9rie_A',
   2025, 'approved'),
  ('O Cruzeiro foi campeão brasileiro em 2003. Até 2024, há quantos anos o clube não repete o título nacional?',
   21, 'anos', 'futebol', 2,
   'REJEITADA — ano-base errado: o Cruzeiro também foi campeão em 2013 e 2014, mais recentes que o 2003 citado na âncora',
   'rejected://ano-base-errado-campeao-2014', 2024, 'rejected'),
  ('O Atlético-MG foi campeão brasileiro em 2021, quebrando um jejum histórico. Até 2025, há quantos anos o clube não repete o título?',
   4, 'anos', 'futebol', 1,
   'Wikipedia — Campeonato Brasileiro Série A (lista de campeões, conforme reconhecimento CBF)',
   'https://en.wikipedia.org/wiki/Campeonato_Brasileiro_S%C3%A9rie_A',
   2025, 'approved'),
  ('O Corinthians foi campeão brasileiro em 2017. Até 2025, há quantos anos o clube não repete o título nacional?',
   8, 'anos', 'futebol', 2,
   'Wikipedia — Campeonato Brasileiro Série A (lista de campeões, conforme reconhecimento CBF)',
   'https://en.wikipedia.org/wiki/Campeonato_Brasileiro_S%C3%A9rie_A',
   2025, 'approved');

-- Família: quantidade de técnicos diferentes que comandaram um clube brasileiro entre 2014 e 2023
-- (dez temporadas).
-- Curadoria (2026-09-06): fonte travada = Wikipédia, lista/tabela de treinadores de cada clube
-- (agregador nível 2), contagem manual de nomes distintos com passagem no recorte 2014-2023,
-- excluindo interinos quando a própria página faz essa distinção. 8 de 10 aprovadas. Reprovadas:
-- Bahia (sem página de lista datada de treinadores na Wikipédia) e Coritiba (a lista principal é
-- um link vermelho/inexistente; a única tabela datada no artigo do clube cobre só desde 2020).
-- Confiança moderada nas aprovadas — é contagem manual de tabela, mais sujeita a erro que dado
-- direto; Ceará divergiu bastante do candidato (23 vs. 12), vale um spot-check antes de publicar.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('O Botafogo é conhecido pela alta rotatividade de comando. Quantos técnicos diferentes passaram pelo clube entre 2014 e 2023?',
   18, 'técnicos diferentes', 'futebol', 3,
   'Wikipédia — "Lista de treinadores do Botafogo de Futebol e Regatas"',
   'https://pt.wikipedia.org/wiki/Lista_de_treinadores_do_Botafogo_de_Futebol_e_Regatas',
   2023, 'approved'),
  ('O Cruzeiro viveu anos turbulentos após o rebaixamento de 2019. Quantos técnicos diferentes passaram pelo clube entre 2014 e 2023?',
   20, 'técnicos diferentes', 'futebol', 3,
   'Wikipédia — "Treinadores do Cruzeiro Esporte Clube"',
   'https://pt.wikipedia.org/wiki/Treinadores_do_Cruzeiro_Esporte_Clube',
   2023, 'approved'),
  ('O Vasco trocou de comando com frequência na última década. Quantos técnicos diferentes passaram pelo clube entre 2014 e 2023?',
   19, 'técnicos diferentes', 'futebol', 3,
   'Wikipédia — "Treinadores do Club de Regatas Vasco da Gama"',
   'https://pt.wikipedia.org/wiki/Treinadores_do_Club_de_Regatas_Vasco_da_Gama',
   2023, 'approved'),
  ('O Corinthians teve fases de instabilidade técnica mesmo sendo um clube grande. Quantos técnicos diferentes passaram pelo clube entre 2014 e 2023?',
   14, 'técnicos diferentes', 'futebol', 2,
   'Wikipédia — "Treinadores do Sport Club Corinthians Paulista"',
   'https://pt.wikipedia.org/wiki/Treinadores_do_Sport_Club_Corinthians_Paulista',
   2023, 'approved'),
  ('O Santos trocou de técnico com frequência buscando repetir os anos de Neymar. Quantos técnicos diferentes passaram pelo clube entre 2014 e 2023?',
   17, 'técnicos diferentes', 'futebol', 3,
   'Wikipédia — "Treinadores do Santos Futebol Clube"',
   'https://pt.wikipedia.org/wiki/Treinadores_do_Santos_Futebol_Clube',
   2023, 'approved'),
  ('O Fluminense teve mais estabilidade que outros grandes cariocas, mas também trocou de comando algumas vezes. Quantos técnicos diferentes passaram pelo clube entre 2014 e 2023?',
   13, 'técnicos diferentes', 'futebol', 2,
   'Wikipédia — "Lista de treinadores do Fluminense Football Club"',
   'https://pt.wikipedia.org/wiki/Lista_de_treinadores_do_Fluminense_Football_Club',
   2023, 'approved'),
  ('O Bahia viveu altos e baixos entre a Série A e a Série B na última década. Quantos técnicos diferentes passaram pelo clube entre 2014 e 2023?',
   16, 'técnicos diferentes', 'futebol', 3,
   'REJEITADA — sem página de lista datada de treinadores na Wikipédia para contar com confiança o recorte 2014-2023',
   'rejected://sem-lista-datada', 2023, 'rejected'),
  ('O Ceará se estabilizou na Série A na última década, mas ainda trocou de técnico algumas vezes. Quantos técnicos diferentes passaram pelo clube entre 2014 e 2023?',
   23, 'técnicos diferentes', 'futebol', 2,
   'Wikipédia — "Treinadores do Ceará Sporting Club"',
   'https://pt.wikipedia.org/wiki/Treinadores_do_Cear%C3%A1_Sporting_Club',
   2023, 'approved'),
  ('O Coritiba alternou entre Série A e Série B nos últimos dez anos. Quantos técnicos diferentes passaram pelo clube entre 2014 e 2023?',
   18, 'técnicos diferentes', 'futebol', 3,
   'REJEITADA — "Lista de treinadores do Coritiba" é um link vermelho (não existe); a única tabela datada do artigo principal do clube cobre só desde 2020, não o recorte 2014-2023 inteiro',
   'rejected://sem-lista-datada', 2023, 'rejected'),
  ('O Atlético-GO subiu e desceu de divisão mais de uma vez na última década. Quantos técnicos diferentes passaram pelo clube entre 2014 e 2023?',
   16, 'técnicos diferentes', 'futebol', 3,
   'Wikipédia — "Lista de treinadores do Atlético Clube Goianiense"',
   'https://pt.wikipedia.org/wiki/Lista_de_treinadores_do_Atl%C3%A9tico_Clube_Goianiense',
   2023, 'approved');
