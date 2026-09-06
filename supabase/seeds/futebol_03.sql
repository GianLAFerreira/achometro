-- Onda 3 do tópico futebol — diferente das ondas 1 e 2 (que nasceram 'pending', candidatas de
-- memória à espera do agente curador-perguntas), esta onda já nasce 'approved': cada pergunta foi
-- pesquisada e a fonte verificada no momento de ser escrita, seguindo o mesmo processo do
-- curador-perguntas (.claude/agents/curador-perguntas.md) e a skill achometro-perguntas
-- (.claude/skills/achometro-perguntas/SKILL.md).

-- Família: gols marcados na carreira por atacantes/meias brasileiros conhecidos, mas cujo total
-- exato de carreira não é do domínio público óbvio (evita nomes como Pelé/Romário/Ronaldo, cujo
-- número já é conhecimento geral). Fonte travada da família (nível 2 da hierarquia — agregador
-- consolidado): ogol.com.br, lendo o total de carreira do cabeçalho do perfil de cada jogador
-- (soma todos os clubes e competições). Mesmo veículo pra todos; cada jogador com sua própria URL
-- de perfil, o que é esperado neste nível (ver critério 1 do curador-perguntas.md).
-- Descartados do pool original de 14 por falta de total agregado nesse veículo: Vágner Love
-- (só temporada a temporada), Hulk e Dudu (perfil carrega só a última temporada por ainda terem
-- vínculo de clube ativo no sistema do ogol), Diego Souza (não descartado por falta de fonte —
-- ficou de fora só porque os outros 10 já fechavam a cota).
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('Fred foi centroavante de Cruzeiro, Fluminense e da Seleção por quase 20 anos. Quantos gols ele marcou ao todo na carreira?',
   413, 'gols', 'futebol', 2,
   'ogol.com.br', 'https://www.ogol.com.br/jogador/fred/9839', 2026, 'approved'),
  ('Diego Tardelli foi atacante por quase 20 anos, com mais de uma passagem pelo Atlético-MG. Quantos gols ele marcou ao todo na carreira?',
   233, 'gols', 'futebol', 2,
   'ogol.com.br', 'https://www.ogol.com.br/jogador/diego-tardelli/5683', 2026, 'approved'),
  ('Jô jogou como atacante por quase 20 anos, passando por Corinthians, CSKA Moscou e Manchester City. Quantos gols ele marcou ao todo na carreira?',
   245, 'gols', 'futebol', 2,
   'ogol.com.br', 'https://www.ogol.com.br/jogador/jo/5171', 2026, 'approved'),
  ('Rafael Sóbis foi atacante por quase 20 anos e ganhou duas Libertadores em times diferentes. Quantos gols ele marcou ao todo na carreira?',
   175, 'gols', 'futebol', 3,
   'ogol.com.br', 'https://www.ogol.com.br/jogador/rafael-sobis/5473', 2026, 'approved'),
  ('Wellington Paulista foi atacante por mais de 20 anos, passando por times como Cruzeiro, Botafogo e Palmeiras. Quantos gols ele marcou ao todo na carreira?',
   256, 'gols', 'futebol', 3,
   'ogol.com.br', 'https://www.ogol.com.br/jogador/wellington-paulista/6041', 2026, 'approved'),
  ('Marcelinho Carioca foi ídolo do Corinthians por sua batida de falta, numa carreira de quase 20 anos. Quantos gols ele marcou ao todo na carreira?',
   307, 'gols', 'futebol', 2,
   'ogol.com.br', 'https://www.ogol.com.br/jogador/marcelinho-carioca/5653', 2026, 'approved'),
  ('Robinho jogou por Santos, Real Madrid, Milan e Manchester City ao longo de quase 20 anos. Quantos gols ele marcou ao todo na carreira?',
   278, 'gols', 'futebol', 1,
   'ogol.com.br', 'https://www.ogol.com.br/jogador/robinho/4692', 2026, 'approved'),
  ('Luís Fabiano foi centroavante do Sevilla e da Seleção por quase 20 anos. Quantos gols ele marcou ao todo na carreira?',
   403, 'gols', 'futebol', 2,
   'ogol.com.br', 'https://www.ogol.com.br/jogador/luis-fabiano/5685', 2026, 'approved'),
  ('Deivid foi atacante por quase 20 anos, com passagens por Corinthians, Cruzeiro e Santos. Quantos gols ele marcou ao todo na carreira?',
   228, 'gols', 'futebol', 3,
   'ogol.com.br', 'https://www.ogol.com.br/player.php?id=3473', 2026, 'approved'),
  ('Washington foi artilheiro do Brasileirão duas vezes (2004 e 2008), a maior parte pelo Athletico Paranaense. Quantos gols ele marcou ao todo na carreira?',
   381, 'gols', 'futebol', 2,
   'ogol.com.br', 'https://www.ogol.com.br/jogador/washington/5108', 2026, 'approved');
