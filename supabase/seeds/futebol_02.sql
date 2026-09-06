-- Onda de aprovação 2/7 do tópico futebol. As 5 famílias deste arquivo foram curadas em
-- 2026-09-06 por agentes seguindo .claude/agents/curador-perguntas.md +
-- .claude/skills/achometro-perguntas/SKILL.md, com pesquisa real (WebSearch/WebFetch). Todas as
-- perguntas deste arquivo já têm veredito — não sobra nenhuma 'pending'. start_round só sorteia
-- status = 'approved' (ver migration 20260812152453_exige_dois_jogadores_pra_iniciar.sql), então
-- nada com status 'rejected' chega a uma partida real; as linhas rejeitadas ficam como registro de
-- que já foram avaliadas — não apagar, senão a pergunta volta numa onda futura sem esse histórico.

-- Família: rebaixamentos para a Série B na história de clubes brasileiros tradicionais.
-- Curadoria (2026-09-06): 10 de 10 aprovadas. Fonte travada por gênero (imprensa esportiva
-- dedicada a apurar e somar o histórico de quedas de cada clube — Lance!, Placar, Goal.com,
-- FogãoNET, Um Dois Esportes, Torcedores.com), cada item sua própria matéria. Vários números do
-- candidato original estavam errados, não só desatualizados: Fluminense e Cruzeiro caíram de fato
-- só 1 vez cada (não 3 e 2), e Sport/Coritiba já somam 7 quedas cada (não 5 e 6) — Sport incluindo
-- a queda de 2025.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('O Botafogo, campeão brasileiro em 1995, já foi rebaixado para a Série B quantas vezes na história?',
   3, 'rebaixamentos', 'futebol', 2,
   'FogãoNET — "Botafogo: terceiro rebaixamento; relembre outras quedas"',
   'https://www.fogaonet.com/noticia/botafogo-terceiro-rebaixamento-relembre-outras-quedas/',
   2021, 'approved'),
  ('O Vasco, um dos clubes mais tradicionais do Rio, já foi rebaixado para a Série B quantas vezes na história?',
   4, 'rebaixamentos', 'futebol', 2,
   'Lance! — "Quantas vezes o Vasco foi rebaixado na história"',
   'https://www.lance.com.br/brasileirao/quantas-vezes-o-vasco-foi-rebaixado-na-historia.html',
   2020, 'approved'),
  ('O Fluminense, tricampeão carioca recente, já foi rebaixado para a Série B quantas vezes na história?',
   1, 'rebaixamentos', 'futebol', 2,
   'Placar — "Quantas vezes o Fluminense já foi rebaixado?"',
   'https://placar.com.br/brasileirao/quantas-vezes-o-fluminense-ja-foi-rebaixado/',
   1997, 'approved'),
  ('O Cruzeiro, apesar de duas décadas vitoriosas, já foi rebaixado para a Série B quantas vezes na história?',
   1, 'rebaixamentos', 'futebol', 2,
   'Placar — "Cruzeiro é rebaixado à Série B do Brasileiro pela primeira vez na história"',
   'https://placar.com.br/placar/cruzeiro-e-rebaixado-a-serie-b-do-brasileiro-pela-primeira-vez-na-historia/',
   2019, 'approved'),
  ('O Grêmio, tricampeão da Libertadores, já foi rebaixado para a Série B quantas vezes na história?',
   2, 'rebaixamentos', 'futebol', 2,
   'Goal.com Brasil — "Quantas vezes o Grêmio foi rebaixado para a Série B do Brasileirão?"',
   'https://www.goal.com/br/noticias/quantas-vezes-o-gremio-foi-rebaixado-para-a-serie-b-do-brasileirao/blt47091a79bb495ae2',
   2004, 'approved'),
  ('O Internacional, um dos clubes mais estáveis do Sul, já foi rebaixado para a Série B quantas vezes na história?',
   1, 'rebaixamentos', 'futebol', 2,
   'Goal.com Brasil — "Internacional é rebaixado pela primeira vez em sua história"',
   'https://www.goal.com/br/noticias/internacional-e-rebaixado-pela-primeira-vez-em-sua-historia/blt87d9ba9c535f7d58',
   2016, 'approved'),
  ('O Atlético-MG, campeão da Libertadores em 2013, já foi rebaixado para a Série B quantas vezes na história?',
   1, 'rebaixamentos', 'futebol', 2,
   'Placar — "Em 2005, Atlético-MG montou time ''galático'' mas acabou rebaixado"',
   'https://placar.com.br/coluna/tbt-placar/em-2005-atletico-mg-montou-time-galotico-mas-acabou-rebaixado/',
   2005, 'approved'),
  ('O Bahia, tricampeão brasileiro nas décadas de 1950 e 1980, já foi rebaixado para a Série B quantas vezes na história?',
   4, 'rebaixamentos', 'futebol', 3,
   'Lance! — "Quantas vezes o Bahia foi rebaixado na história"',
   'https://www.lance.com.br/brasileirao/quantas-vezes-o-bahia-foi-rebaixado-na-historia.html',
   2021, 'approved'),
  ('O Sport, campeão da Copa do Brasil em 2008, já foi rebaixado para a Série B quantas vezes na história?',
   7, 'rebaixamentos', 'futebol', 3,
   'Torcedores.com — "Sport bate recorde de rebaixamento; lista com mais quedas também inclui gigante"',
   'https://www.torcedores.com/noticias/2025/11/sport-bate-recorde-de-rebaixamento-lista-com-mais-quedas-tambem-inclui-gigante',
   2025, 'approved'),
  ('O Coritiba, um dos clubes mais antigos do Brasil, já foi rebaixado para a Série B quantas vezes na história?',
   7, 'rebaixamentos', 'futebol', 3,
   'Um Dois Esportes — "Coritiba heptarrebaixado: relembre as quedas do clube de 1989 a 2023"',
   'https://www.umdoisesportes.com.br/futebol/coritiba-heptarebaixado-relembre-as-quedas-do-clube-de-1989-a-2023/',
   2023, 'approved');

-- Família: pênaltis perdidos na carreira profissional (todas as competições), por jogador.
-- Curadoria (2026-09-06): 2 de 10 aprovadas. Como já era esperado (mesmo padrão da família irmã de
-- cartões vermelhos), "total de pênaltis perdidos na carreira inteira" raramente tem fonte
-- agregada — a maioria dos jogadores só tem recorte por clube/temporada/competição específica, não
-- soma de carreira. Só Neymar e Gabigol têm matéria dedicada de imprensa somando a carreira toda
-- (trava de família nível 3); os outros 8 foram reprovados por falta desse tipo de fonte.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('Neymar é um dos principais cobradores de pênalti do futebol brasileiro. Quantos pênaltis ele já perdeu na carreira profissional?',
   19, 'pênaltis perdidos', 'futebol', 3,
   'Metropoles — "Vídeo: Neymar chega a 19 pênaltis perdidos na carreira"',
   'https://www.metropoles.com/esportes/video-neymar-chega-a-19-penaltis-perdidos-na-carreira',
   2023, 'approved'),
  ('Hulk é conhecido pela cobrança forte de pênaltis. Quantos ele já perdeu na carreira profissional?',
   9, 'pênaltis perdidos', 'futebol', 3,
   'REJEITADA — só há recortes por clube/período (11 pelo Atlético-MG, 13 fora do Brasil), sem matéria dedicada somando a carreira inteira',
   'rejected://sem-fonte-de-carreira', 2024, 'rejected'),
  ('Gabigol é um dos artilheiros do futebol brasileiro recente. Quantos pênaltis ele já perdeu na carreira profissional?',
   9, 'pênaltis perdidos', 'futebol', 3,
   'Lance! — "Pênalti perdido fecha temporada decepcionante de Gabigol pelo Cruzeiro"',
   'https://www.lance.com.br/cruzeiro/penalti-perdido-fecha-temporada-decepcionante-de-gabigol-pelo-cruzeiro.html',
   2025, 'approved'),
  ('Deyverson, atacante conhecido pelas comemorações, quantos pênaltis já perdeu na carreira profissional?',
   6, 'pênaltis perdidos', 'futebol', 3,
   'REJEITADA — só há registro de lances pontuais (Atlético-MG 2024, Cuiabá 2023), nenhuma matéria soma o total de carreira',
   'rejected://sem-fonte-de-carreira', 2024, 'rejected'),
  ('Jô, artilheiro que rodou por Corinthians e outros clubes, quantos pênaltis já perdeu na carreira profissional?',
   7, 'pênaltis perdidos', 'futebol', 3,
   'REJEITADA — única estatística agregada encontrada é recorde de pênaltis perdidos na Arena Corinthians (4), não carreira inteira',
   'rejected://sem-fonte-de-carreira', 2024, 'rejected'),
  ('Diego Costa, atacante que defendeu Brasil e Espanha, quantos pênaltis já perdeu na carreira profissional?',
   5, 'pênaltis perdidos', 'futebol', 3,
   'REJEITADA — único dado numérico encontrado é filtrado só para a Champions League, não carreira inteira',
   'rejected://sem-fonte-de-carreira', 2024, 'rejected'),
  ('Fred, artilheiro histórico do Fluminense, quantos pênaltis já perdeu na carreira profissional?',
   10, 'pênaltis perdidos', 'futebol', 3,
   'REJEITADA — matérias mencionam pênaltis perdidos em jogos específicos, sem soma de carreira',
   'rejected://sem-fonte-de-carreira', 2024, 'rejected'),
  ('Diego Tardelli, atacante que rodou por vários clubes grandes, quantos pênaltis já perdeu na carreira profissional?',
   6, 'pênaltis perdidos', 'futebol', 3,
   'REJEITADA — só há menção a um pênalti perdido específico (contra o Corinthians), sem total de carreira',
   'rejected://sem-fonte-de-carreira', 2024, 'rejected'),
  ('Robinho, um dos maiores talentos do futebol brasileiro dos anos 2000, quantos pênaltis já perdeu na carreira profissional?',
   4, 'pênaltis perdidos', 'futebol', 3,
   'REJEITADA — nenhuma fonte, dedicada ou agregadora, com total de pênaltis perdidos na carreira',
   'rejected://sem-fonte-de-carreira', 2024, 'rejected'),
  ('Ricardo Oliveira, artilheiro que marcou por vários clubes na Série A, quantos pênaltis já perdeu na carreira profissional?',
   5, 'pênaltis perdidos', 'futebol', 3,
   'REJEITADA — nenhuma fonte com estatística de pênaltis perdidos, muito menos total de carreira',
   'rejected://sem-fonte-de-carreira', 2024, 'rejected');

-- Família: número de sócios-torcedores de clubes brasileiros.
-- Curadoria (2026-09-06): 9 de 10 aprovadas. Fonte travada única pra família inteira: Rádio
-- Itatiaia, "Palmeiras é o clube com mais sócios-torcedores no Brasil; veja ranking nacional"
-- (30/08/2023) — levantamento exclusivo cobrindo os 10 clubes na mesma matéria/data, satisfaz o
-- critério 1 com folga. Quase todos os números foram corrigidos (o candidato original chutou
-- valores redondos demais — múltiplos de 10 mil). Só o Flamengo caiu: a âncora original afirmava
-- que o clube "tem o maior programa de sócio-torcedor do Brasil", mas na fonte real ele é o 5º
-- colocado (103.000) — o Palmeiras lidera (185.338) — a alegação é factualmente falsa e checável,
-- do tipo que gera contestação imediata na mesa. Recomendado reescrever a âncora numa onda futura.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('O Flamengo tem o maior programa de sócio-torcedor do Brasil. Quantos sócios o clube tinha em 2023?',
   190000, 'sócios-torcedores', 'futebol', 2,
   'REJEITADA — âncora factualmente errada: pela fonte travada da família (Rádio Itatiaia, 30/08/2023), o Flamengo é o 5º colocado (103.000), não o líder — o Palmeiras lidera com 185.338',
   'rejected://ancora-factualmente-errada', 2023, 'rejected'),
  ('O Corinthians tem uma das maiores torcidas organizadas do país. Quantos sócios-torcedores o clube tinha em 2023?',
   116000, 'sócios-torcedores', 'futebol', 2,
   'Rádio Itatiaia — "Palmeiras é o clube com mais sócios-torcedores no Brasil; veja ranking nacional"',
   'https://www.itatiaia.com.br/esportes/futebol-nacional/2023/08/31/palmeiras-e-o-clube-com-mais-socios-torcedores-no-brasil-veja-ranking-nacional',
   2023, 'approved'),
  ('O Internacional tem tradição em programas de sócio-torcedor no Sul do país. Quantos sócios o clube tinha em 2023?',
   120842, 'sócios-torcedores', 'futebol', 2,
   'Rádio Itatiaia — "Palmeiras é o clube com mais sócios-torcedores no Brasil; veja ranking nacional"',
   'https://www.itatiaia.com.br/esportes/futebol-nacional/2023/08/31/palmeiras-e-o-clube-com-mais-socios-torcedores-no-brasil-veja-ranking-nacional',
   2023, 'approved'),
  ('O Grêmio disputa com o rival gaúcho o maior número de sócios do Sul. Quantos sócios-torcedores o clube tinha em 2023?',
   113938, 'sócios-torcedores', 'futebol', 2,
   'Rádio Itatiaia — "Palmeiras é o clube com mais sócios-torcedores no Brasil; veja ranking nacional"',
   'https://www.itatiaia.com.br/esportes/futebol-nacional/2023/08/31/palmeiras-e-o-clube-com-mais-socios-torcedores-no-brasil-veja-ranking-nacional',
   2023, 'approved'),
  ('O São Paulo tem um dos programas de sócio-torcedor mais antigos do país. Quantos sócios o clube tinha em 2023?',
   60377, 'sócios-torcedores', 'futebol', 2,
   'Rádio Itatiaia — "Palmeiras é o clube com mais sócios-torcedores no Brasil; veja ranking nacional"',
   'https://www.itatiaia.com.br/esportes/futebol-nacional/2023/08/31/palmeiras-e-o-clube-com-mais-socios-torcedores-no-brasil-veja-ranking-nacional',
   2023, 'approved'),
  ('O Palmeiras vive fase vitoriosa e viu o programa de sócios crescer. Quantos sócios-torcedores o clube tinha em 2023?',
   185338, 'sócios-torcedores', 'futebol', 2,
   'Rádio Itatiaia — "Palmeiras é o clube com mais sócios-torcedores no Brasil; veja ranking nacional"',
   'https://www.itatiaia.com.br/esportes/futebol-nacional/2023/08/31/palmeiras-e-o-clube-com-mais-socios-torcedores-no-brasil-veja-ranking-nacional',
   2023, 'approved'),
  ('O Atlético-MG lançou a Arena MRV apoiado em receita de sócios. Quantos sócios-torcedores o clube tinha em 2023?',
   85481, 'sócios-torcedores', 'futebol', 2,
   'Rádio Itatiaia — "Palmeiras é o clube com mais sócios-torcedores no Brasil; veja ranking nacional"',
   'https://www.itatiaia.com.br/esportes/futebol-nacional/2023/08/31/palmeiras-e-o-clube-com-mais-socios-torcedores-no-brasil-veja-ranking-nacional',
   2023, 'approved'),
  ('O Cruzeiro reconstruiu sua base de sócios após a crise financeira do final da década de 2010. Quantos sócios o clube tinha em 2023?',
   50766, 'sócios-torcedores', 'futebol', 2,
   'Rádio Itatiaia — "Palmeiras é o clube com mais sócios-torcedores no Brasil; veja ranking nacional"',
   'https://www.itatiaia.com.br/esportes/futebol-nacional/2023/08/31/palmeiras-e-o-clube-com-mais-socios-torcedores-no-brasil-veja-ranking-nacional',
   2023, 'approved'),
  ('O Vasco renovou sua base de sócios-torcedores nos últimos anos. Quantos sócios o clube tinha em 2023?',
   56000, 'sócios-torcedores', 'futebol', 2,
   'Rádio Itatiaia — "Palmeiras é o clube com mais sócios-torcedores no Brasil; veja ranking nacional"',
   'https://www.itatiaia.com.br/esportes/futebol-nacional/2023/08/31/palmeiras-e-o-clube-com-mais-socios-torcedores-no-brasil-veja-ranking-nacional',
   2023, 'approved'),
  ('O Botafogo viu sua base de sócios crescer com a chegada de John Textor. Quantos sócios-torcedores o clube tinha em 2023?',
   61555, 'sócios-torcedores', 'futebol', 2,
   'Rádio Itatiaia — "Palmeiras é o clube com mais sócios-torcedores no Brasil; veja ranking nacional"',
   'https://www.itatiaia.com.br/esportes/futebol-nacional/2023/08/31/palmeiras-e-o-clube-com-mais-socios-torcedores-no-brasil-veja-ranking-nacional',
   2023, 'approved');

-- Família: capacidade oficial de estádios brasileiros.
-- Curadoria (2026-09-06): 10 de 10 aprovadas. Fonte travada: Wikipédia (agregador nível 2, citando
-- CBF/Sisbrace, laudo técnico ou site oficial do estádio/clube), mesmo veículo pros 10 itens.
-- Vários números levemente corrigidos por reforma/atualização de laudo recente — destaque pro
-- Mangueirão, que saltou de 45.845 pra 53.645 depois da reabertura do "Novo Mangueirão" em 2023.
-- Nota: a Allianz Parque foi renomeada "Nubank Parque" recentemente — o nome no prompt pode
-- precisar de atualização numa passada futura, fora do escopo desta curadoria (só o número mudou
-- aqui). O item do Maracanã tem risco leve de "morna" por ser dado muito conhecido — mantido
-- aprovado pelo ângulo de contraste com a lotação histórica de ~200 mil em 1950.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('Qual é a capacidade oficial do Maracanã, no Rio de Janeiro, após as reformas para a Copa de 2014?',
   78838, 'lugares', 'futebol', 2,
   'Wikipédia — Estádio Jornalista Mário Filho',
   'https://pt.wikipedia.org/wiki/Est%C3%A1dio_Jornalista_M%C3%A1rio_Filho',
   2013, 'approved'),
  ('Qual é a capacidade oficial do Mineirão, em Belo Horizonte?',
   61927, 'lugares', 'futebol', 2,
   'Wikipédia (Sisbrace/CBF) — Estádio Governador Magalhães Pinto',
   'https://pt.wikipedia.org/wiki/Est%C3%A1dio_Governador_Magalh%C3%A3es_Pinto',
   2023, 'approved'),
  ('Qual é a capacidade oficial do Beira-Rio, estádio do Internacional em Porto Alegre?',
   50842, 'lugares', 'futebol', 2,
   'Wikipédia — Estádio Beira-Rio (dados pós-reforma Copa de 2014)',
   'https://pt.wikipedia.org/wiki/Est%C3%A1dio_Beira-Rio',
   2014, 'approved'),
  ('Qual é a capacidade oficial da Neo Química Arena, do Corinthians, em São Paulo?',
   48905, 'lugares', 'futebol', 2,
   'Wikipédia — Neo Química Arena',
   'https://pt.wikipedia.org/wiki/Neo_Qu%C3%ADmica_Arena',
   2025, 'approved'),
  ('Qual é a capacidade oficial do Allianz Parque, estádio do Palmeiras em São Paulo?',
   43723, 'lugares', 'futebol', 2,
   'Wikipédia (dado WTorre) — Allianz Parque',
   'https://pt.wikipedia.org/wiki/Allianz_Parque',
   2024, 'approved'),
  ('Qual é a capacidade oficial da Arena Fonte Nova, em Salvador, casa do Bahia?',
   47902, 'lugares', 'futebol', 2,
   'Wikipédia / CBF — Cadastro Nacional de Estádios (Arena Fonte Nova)',
   'https://en.wikipedia.org/wiki/Arena_Fonte_Nova',
   2023, 'approved'),
  ('Qual é a capacidade oficial da Ligga Arena (antiga Arena da Baixada), do Athletico-PR, em Curitiba?',
   42372, 'lugares', 'futebol', 2,
   'Wikipédia — Arena da Baixada',
   'https://en.wikipedia.org/wiki/Arena_da_Baixada',
   2014, 'approved'),
  ('Qual é a capacidade oficial do estádio Mangueirão, em Belém, usado por Paysandu e Remo?',
   53645, 'lugares', 'futebol', 2,
   'Wikipédia / CBF — Estádio Mangueirão',
   'https://pt.wikipedia.org/wiki/Mangueir%C3%A3o',
   2023, 'approved'),
  ('Qual é a capacidade oficial da Vila Belmiro, estádio histórico do Santos?',
   17923, 'lugares', 'futebol', 2,
   'Wikipédia (Laudo de Engenharia da FPF) — Estádio Urbano Caldeira',
   'https://pt.wikipedia.org/wiki/Est%C3%A1dio_Urbano_Caldeira',
   2018, 'approved'),
  ('Qual é a capacidade oficial do Couto Pereira, estádio do Coritiba?',
   40502, 'lugares', 'futebol', 2,
   'Wikipédia (site oficial do Coritiba)',
   'https://pt.wikipedia.org/wiki/Est%C3%A1dio_Major_Ant%C3%B4nio_Couto_Pereira',
   2017, 'approved');

-- Família: tempo médio de bola rolando (minutos efetivos) por partida no Brasileirão, por ano.
-- Curadoria (2026-09-06): só 3 de 10 aprovadas. A única fonte homogênea encontrada com a mesma
-- metodologia (CBF, medindo as primeiras 10 rodadas de cada temporada, noticiado por ISTOÉ) cobre
-- apenas 2014-2016 — 2016 teve o número bem corrigido (57, não 51). Para 2017-2023 só existem
-- números fragmentados: metodologias diferentes (amostra parcial vs. temporada completa),
-- atribuição de fonte primária não verificável, ou nenhum dado encontrado (2020-2022) — reprovados
-- por critério 2 (fonte pública citável), não por divergência de número.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('Segundo levantamentos de tempo de bola em jogo, quantos minutos, em média, a bola ficou rolando por partida no Brasileirão de 2014?',
   52, 'minutos', 'futebol', 3,
   'CBF — estudo de arbitragem sobre bola rolando (primeiras 10 rodadas/100 jogos de cada temporada), via ISTOÉ',
   'https://istoe.com.br/tempo-de-bola-rolando-cresce-em-partidas-do-campeonato-brasileiro-desde-2014/',
   2016, 'approved'),
  ('Segundo levantamentos de tempo de bola em jogo, quantos minutos, em média, a bola ficou rolando por partida no Brasileirão de 2015?',
   54, 'minutos', 'futebol', 3,
   'CBF — mesmo estudo de bola rolando, via ISTOÉ',
   'https://istoe.com.br/tempo-de-bola-rolando-cresce-em-partidas-do-campeonato-brasileiro-desde-2014/',
   2016, 'approved'),
  ('Segundo levantamentos de tempo de bola em jogo, quantos minutos, em média, a bola ficou rolando por partida no Brasileirão de 2016?',
   57, 'minutos', 'futebol', 3,
   'CBF — mesmo estudo de bola rolando, via ISTOÉ',
   'https://istoe.com.br/tempo-de-bola-rolando-cresce-em-partidas-do-campeonato-brasileiro-desde-2014/',
   2016, 'approved'),
  ('Segundo levantamentos de tempo de bola em jogo, quantos minutos, em média, a bola ficou rolando por partida no Brasileirão de 2017?',
   54, 'minutos', 'futebol', 3,
   'REJEITADA — só há número secundário sem citação primária verificável, fora da metodologia (primeiras 10 rodadas) da fonte travada da família',
   'rejected://sem-fonte-primaria', 2017, 'rejected'),
  ('Segundo levantamentos de tempo de bola em jogo, quantos minutos, em média, a bola ficou rolando por partida no Brasileirão de 2018?',
   55, 'minutos', 'futebol', 3,
   'REJEITADA — único dado achado é parcial (só as 4 primeiras rodadas de 39 jogos), não representa a metodologia da família nem a temporada completa',
   'rejected://metodologia-diferente-parcial', 2018, 'rejected'),
  ('Segundo levantamentos de tempo de bola em jogo, quantos minutos, em média, a bola ficou rolando por partida no Brasileirão de 2019?',
   53, 'minutos', 'futebol', 3,
   'REJEITADA — número de temporada completa atribuído a CBF Academy/Opta usa metodologia diferente da fonte travada, e a atribuição primária não foi verificável',
   'rejected://metodologia-diferente', 2019, 'rejected'),
  ('Segundo levantamentos de tempo de bola em jogo, quantos minutos, em média, a bola ficou rolando por partida no Brasileirão de 2020?',
   56, 'minutos', 'futebol', 3,
   'REJEITADA — nenhuma fonte, número ou estudo encontrado para este ano apesar de busca extensiva',
   'rejected://sem-fonte', 2020, 'rejected'),
  ('Segundo levantamentos de tempo de bola em jogo, quantos minutos, em média, a bola ficou rolando por partida no Brasileirão de 2021?',
   54, 'minutos', 'futebol', 3,
   'REJEITADA — nenhuma fonte, número ou estudo encontrado para este ano apesar de busca extensiva',
   'rejected://sem-fonte', 2021, 'rejected'),
  ('Segundo levantamentos de tempo de bola em jogo, quantos minutos, em média, a bola ficou rolando por partida no Brasileirão de 2022?',
   55, 'minutos', 'futebol', 3,
   'REJEITADA — nenhuma fonte, número ou estudo encontrado para este ano apesar de busca extensiva',
   'rejected://sem-fonte', 2022, 'rejected'),
  ('Segundo levantamentos de tempo de bola em jogo, quantos minutos, em média, a bola ficou rolando por partida no Brasileirão de 2023?',
   53, 'minutos', 'futebol', 3,
   'REJEITADA — número de temporada completa (Placar) não nomeia o provedor original do dado, sem fonte primária citável verificada',
   'rejected://sem-fonte-primaria', 2023, 'rejected');
