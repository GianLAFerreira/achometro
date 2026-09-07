-- Onda de RASCUNHO (não curada) do tópico futebol — clubes brasileiros de menor visibilidade
-- nacional e futebol feminino. Todas as perguntas nascem com status='pending' e fonte placeholder
-- ('NÃO VERIFICADO...' / 'pending://sem-fonte-verificada') — escritas de memória, sem pesquisa,
-- seguindo o mesmo processo já usado no início do banco (ver cabeçalho de supabase/seed.sql).
-- Uma sessão futura de curadoria (agente curador-perguntas, com WebSearch/WebFetch real) precisa
-- validar cada número antes de qualquer uma virar 'approved'. Não rodar contra produção sem isso.
--
-- Famílias incluídas (14, ~10 perguntas cada, ~140 total):
--   A. Artilheiro histórico do clube (clubes brasileiros de menor visibilidade nacional)
--   B. Ano de fundação do clube
--   C. Capacidade oficial do estádio
--   D. Maior público já registrado no estádio do clube
--   E. Número de acessos à Série A na história do clube
--   F. Clássico estadual mais antigo (ano da 1ª edição)
--   G. Maior artilheira histórica do futebol feminino brasileiro (por clube ou seleção)
--   H. Títulos do Brasileirão feminino por clube
--   I. Jogadoras com mais jogos (caps) pela seleção brasileira feminina
--   J. Gols da seleção brasileira feminina em Copas do Mundo, por edição
--   K. Anos sem título estadual (jejum), clubes de menor visibilidade
--   L. Total de títulos estaduais na história do clube
--   M. Recorde de gols de uma artilheira numa edição/torneio específico
--   N. Títulos da UEFA Women's Champions League por clube

-- Família A: artilheiro histórico do clube (gols marcados pelo clube em toda a carreira),
-- clubes brasileiros tradicionais de menor visibilidade nacional.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('Neco é lembrado como o maior artilheiro da história do Ceará, ídolo das décadas de 1950 e 1960. Quantos gols ele marcou pelo clube em toda a carreira?',
   190, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1962, 'pending'),
  ('Wellington Paulista foi um dos artilheiros mais lembrados do Fortaleza na retomada do clube à elite nacional. Quantos gols ele marcou pelo Tricolor do Pici?',
   95, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2022, 'pending'),
  ('Bobô é um dos maiores ídolos recentes do Vitória, artilheiro nos anos de reconstrução do clube na década de 2010. Quantos gols ele marcou pelo Leão da Barra?',
   133, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2019, 'pending'),
  ('O Sport Recife tem mais de um século de história e uma galeria de artilheiros. Quantos gols marcou o maior artilheiro histórico do clube?',
   178, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1990, 'pending'),
  ('Souza é apontado como um dos maiores artilheiros da história do Náutico, clube centenário do Recife. Quantos gols ele marcou pelo Timbu?',
   165, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1985, 'pending'),
  ('A Santa Cruz, torcida numerosa do Recife, tem um artilheiro histórico celebrado pela torcida coral. Quantos gols ele marcou pelo clube?',
   140, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1980, 'pending'),
  ('Rodrigo Pimpão marcou época como artilheiro do Goiás na última década. Quantos gols ele marcou pelo clube esmeraldino?',
   90, 'gols', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'),
  ('Iarley é o maior ídolo e artilheiro histórico do Paysandu, clube mais popular do Pará. Quantos gols ele marcou pelo Papão?',
   172, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2010, 'pending'),
  ('O Remo, rival histórico do Paysandu em Belém, também tem seu artilheiro máximo. Quantos gols ele marcou pelo Leão Azul?',
   110, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2000, 'pending'),
  ('O Bahia, tricampeão brasileiro nas décadas de 1950 e 1980, tem um artilheiro histórico à frente de todos os outros. Quantos gols ele marcou pelo Esquadrão de Aço?',
   200, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1970, 'pending');

-- Família B: ano de fundação de clubes brasileiros tradicionais de menor visibilidade nacional.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('O Vila Nova é um dos dois grandes clubes de Goiânia, rival histórico do Goiás. Em que ano o clube foi fundado?',
   1943, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1943, 'pending'),
  ('O Atlético Clube Goianiense já disputou várias edições da Série A. Em que ano o clube foi fundado?',
   1937, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1937, 'pending'),
  ('O ABC é considerado o clube mais tradicional do Rio Grande do Norte. Em que ano foi fundado?',
   1915, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1915, 'pending'),
  ('O América Futebol Clube, do Rio Grande do Norte, disputa com o ABC o clássico mais tradicional do estado. Em que ano foi fundado?',
   1913, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1913, 'pending'),
  ('O CSA é um dos clubes mais tradicionais de Alagoas. Em que ano o Centro Sportivo Alagoano foi fundado?',
   1913, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1913, 'pending'),
  ('O Guarani, de Campinas, tem um dos poucos títulos brasileiros "de zebra" da história, em 1978. Em que ano o clube foi fundado?',
   1911, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1911, 'pending'),
  ('A Ponte Preta é um dos clubes mais antigos de Campinas, rival histórico do Guarani. Em que ano foi fundada?',
   1900, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1900, 'pending'),
  ('A Portuguesa, tradicional clube da colônia lusa em São Paulo, já disputou muitas edições da Série A. Em que ano foi fundada?',
   1920, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1920, 'pending'),
  ('O Juventude, de Caxias do Sul, é o principal representante do interior gaúcho no futebol nacional. Em que ano foi fundado?',
   1913, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1913, 'pending'),
  ('O Brusque é um clube catarinense relativamente novo que subiu à Série B e à Série A do futebol brasileiro. Em que ano foi fundado?',
   1987, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1987, 'pending');

-- Família C: capacidade oficial de estádios de clubes brasileiros de menor visibilidade nacional
-- (estádios ainda não cobertos nos lotes 01-02 do banco).
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('Qual é a capacidade oficial do Barradão, estádio do Vitória em Salvador?',
   30240, 'lugares', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('Qual é a capacidade oficial da Arena Castelão, em Fortaleza, usada por Ceará e Fortaleza?',
   63903, 'lugares', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2014, 'pending'),
  ('Qual é a capacidade oficial do Estádio Hailé Pinheiro, a Serrinha, casa do Goiás em Goiânia?',
   12500, 'lugares', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'),
  ('Qual é a capacidade oficial do OBA, estádio do Vila Nova em Goiânia?',
   12700, 'lugares', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'),
  ('Qual é a capacidade oficial do Estádio Rei Pelé, em Maceió, casa do CSA?',
   17314, 'lugares', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2018, 'pending'),
  ('Qual é a capacidade oficial do Frasqueirão, estádio do ABC em Natal?',
   18000, 'lugares', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2018, 'pending'),
  ('Qual é a capacidade oficial do Estádio Heriberto Hülse, em Criciúma?',
   19000, 'lugares', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2021, 'pending'),
  ('Qual é a capacidade oficial da Ressacada, estádio do Avaí em Florianópolis?',
   17800, 'lugares', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2021, 'pending'),
  ('Qual é a capacidade oficial do Orlando Scarpelli, estádio do Figueirense em Florianópolis?',
   19300, 'lugares', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2019, 'pending'),
  ('Qual é a capacidade oficial do Alfredo Jaconi, estádio do Juventude em Caxias do Sul?',
   19000, 'lugares', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2021, 'pending');

-- Família D: maior público já registrado no estádio do próprio clube (recorde histórico,
-- estádios ainda não cobertos nos lotes 01-02).
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('Qual foi o maior público pagante já registrado no Estádio dos Aflitos, casa histórica do Náutico no Recife?',
   42000, 'pessoas', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1980, 'pending'),
  ('Qual foi o maior público pagante já registrado no Estádio do Arruda, casa histórica da Santa Cruz no Recife?',
   61000, 'pessoas', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1975, 'pending'),
  ('Qual foi o maior público pagante já registrado no antigo Estádio Presidente Vargas, casa histórica do Ceará em Fortaleza?',
   60000, 'pessoas', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1970, 'pending'),
  ('Qual foi o maior público pagante já registrado no Brinco de Ouro da Princesa, estádio do Guarani em Campinas?',
   30000, 'pessoas', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1978, 'pending'),
  ('Qual foi o maior público pagante já registrado no Moisés Lucarelli, estádio da Ponte Preta em Campinas?',
   30000, 'pessoas', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1977, 'pending'),
  ('Qual foi o maior público pagante já registrado no Canindé, estádio histórico da Portuguesa em São Paulo?',
   35000, 'pessoas', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1973, 'pending'),
  ('Qual foi o maior público pagante já registrado no Barradão, estádio do Vitória em Salvador?',
   30000, 'pessoas', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2000, 'pending'),
  ('O Goiás mandou seus jogos por décadas no gigante Estádio Serra Dourada, com capacidade para mais de 60 mil pessoas. Qual foi o maior público pagante já registrado lá?',
   57000, 'pessoas', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1985, 'pending'),
  ('Qual foi o maior público pagante já registrado na Ressacada, estádio do Avaí em Florianópolis?',
   17000, 'pessoas', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2010, 'pending'),
  ('Qual foi o maior público pagante já registrado no Orlando Scarpelli, estádio do Figueirense em Florianópolis?',
   19000, 'pessoas', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2008, 'pending');

-- Família E: número de acessos à Série A na história do clube (temporadas em que o clube subiu
-- da Série B para a Série A do Brasileirão), clubes de menor visibilidade nacional.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('O Bahia alterna passagens entre a Série A e a Série B ao longo da história. Quantas vezes o clube já subiu para a elite do futebol brasileiro?',
   5, 'acessos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2025, 'pending'),
  ('O Sport Recife é conhecido pelo vaivém entre divisões. Quantas vezes o clube já subiu à Série A do Brasileirão?',
   9, 'acessos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2025, 'pending'),
  ('O Vitória é um dos clubes com mais idas e vindas entre a Série A e a Série B. Quantas vezes o clube já subiu à elite nacional?',
   10, 'acessos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2024, 'pending'),
  ('O Náutico, clube centenário do Recife, também tem histórico de acessos e quedas de divisão. Quantas vezes já subiu à Série A?',
   6, 'acessos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2011, 'pending'),
  ('A Santa Cruz já foi um dos maiores clubes do Nordeste, mas vive décadas de instabilidade de divisão. Quantas vezes já subiu à Série A?',
   4, 'acessos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2010, 'pending'),
  ('O Ceará se consolidou na Série A na última década, mas já teve muitas passagens pela segunda divisão. Quantas vezes já subiu à elite nacional?',
   7, 'acessos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2018, 'pending'),
  ('O Fortaleza teve ascensão meteórica no futebol brasileiro na última década. Quantas vezes o clube já subiu à Série A?',
   3, 'acessos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2019, 'pending'),
  ('O Goiás alterna divisões há décadas, apesar de já ter sido vice-campeão brasileiro. Quantas vezes o clube já subiu à Série A?',
   8, 'acessos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2024, 'pending'),
  ('O Atlético-GO subiu e desceu de divisão mais de uma vez na última década. Quantas vezes o clube já subiu à Série A na história?',
   5, 'acessos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O CSA teve uma passagem breve pela Série A em 2019, mas viveu outros acessos ao longo da história. Quantas vezes o clube já subiu à elite nacional?',
   4, 'acessos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2019, 'pending');

-- Família F: clássico estadual mais antigo — ano da 1ª edição do confronto, clubes de menor
-- visibilidade nacional.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('O Ba-Vi, clássico entre Bahia e Vitória, é um dos mais antigos do futebol brasileiro. Em que ano foi disputada a primeira edição?',
   1904, 'ano', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1904, 'pending'),
  ('O clássico entre Sport e Santa Cruz, conhecido como Clássico das Multidões, mobiliza o Recife inteiro. Em que ano foi disputada a primeira edição?',
   1915, 'ano', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1915, 'pending'),
  ('O clássico entre Sport e Náutico é um dos mais tradicionais de Pernambuco. Em que ano foi disputada a primeira edição?',
   1915, 'ano', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1915, 'pending'),
  ('O Clássico-Rei, entre Ceará e Fortaleza, é a maior rivalidade do futebol cearense. Em que ano foi disputada a primeira edição?',
   1918, 'ano', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1918, 'pending'),
  ('O clássico entre Goiás e Vila Nova é a maior rivalidade do futebol de Goiânia. Em que ano foi disputada a primeira edição?',
   1943, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1943, 'pending'),
  ('O Re-Pa, clássico entre Paysandu e Remo, é considerado um dos mais apaixonados do Brasil. Em que ano foi disputada a primeira edição?',
   1914, 'ano', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1914, 'pending'),
  ('O clássico entre ABC e América é a maior rivalidade do futebol potiguar. Em que ano foi disputada a primeira edição?',
   1917, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1917, 'pending'),
  ('O clássico entre Guarani e Ponte Preta divide a cidade de Campinas há mais de um século. Em que ano foi disputada a primeira edição?',
   1911, 'ano', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1911, 'pending'),
  ('O clássico entre Avaí e Figueirense divide a Ilha de Santa Catarina há décadas. Em que ano foi disputada a primeira edição?',
   1916, 'ano', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1916, 'pending'),
  ('O clássico entre CSA e ASA, também chamado Clássico das Multidões, é a maior rivalidade do futebol alagoano. Em que ano foi disputada a primeira edição?',
   1924, 'ano', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1924, 'pending');

-- Família G: maior artilheira histórica do futebol feminino brasileiro, por clube ou seleção.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('Marta é considerada a maior jogadora da história do futebol feminino mundial. Quantos gols ela marcou pela seleção brasileira em toda a carreira?',
   115, 'gols', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2024, 'pending'),
  ('Gabi Zanotti é uma das principais artilheiras do Corinthians no futebol feminino recente. Quantos gols ela marcou pelo clube?',
   65, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('Marta defendeu o Santos no início da carreira, antes de se transferir para a Europa e os Estados Unidos. Quantos gols ela marcou pelo clube?',
   70, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2011, 'pending'),
  ('Cristiane é uma das artilheiras históricas do futebol feminino do Flamengo. Quantos gols ela marcou pelo clube?',
   85, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2022, 'pending'),
  ('Kerolin se destacou pelo São Paulo antes de se transferir para o futebol americano. Quantos gols ela marcou pelo clube?',
   45, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2022, 'pending'),
  ('Adriana foi uma das principais artilheiras do Palmeiras no futebol feminino. Quantos gols ela marcou pelo clube?',
   55, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2021, 'pending'),
  ('Darlene marcou época como artilheira da Ferroviária, uma das potências do futebol feminino brasileiro. Quantos gols ela marcou pelo clube?',
   60, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'),
  ('Cristiane também construiu parte da carreira no Kindermann, um dos berços do futebol feminino brasileiro. Quantos gols ela marcou pelo clube?',
   90, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2010, 'pending'),
  ('Thaisinha é uma das artilheiras mais lembradas do Grêmio no futebol feminino. Quantos gols ela marcou pelo clube?',
   40, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2021, 'pending'),
  ('Duda Sampaio se firmou como uma das artilheiras do Internacional no futebol feminino recente. Quantos gols ela marcou pelo clube?',
   35, 'gols', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending');

-- Família H: títulos do Campeonato Brasileiro feminino (Brasileirão feminino) por clube.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('O Corinthians é o clube mais vitorioso do futebol feminino brasileiro na última década. Quantos títulos do Brasileirão feminino o clube já venceu?',
   6, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2024, 'pending'),
  ('A Ferroviária, de Araraquara, é uma das forças tradicionais do futebol feminino brasileiro. Quantos títulos do Brasileirão feminino o clube já venceu?',
   2, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O São José Esporte Clube, de São José dos Campos, foi um dos primeiros grandes campeões do futebol feminino nacional. Quantos títulos do Brasileirão feminino o clube já venceu?',
   2, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2015, 'pending'),
  ('O Santos, que revelou Marta no futebol feminino, também já foi campeão nacional. Quantos títulos do Brasileirão feminino o clube já venceu?',
   1, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2010, 'pending'),
  ('O Centro Olímpico, de São Paulo, foi campeão nas primeiras edições do Brasileirão feminino organizado pela CBF. Quantos títulos o clube já venceu?',
   1, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2013, 'pending'),
  ('O Rio Preto Esporte Clube teve uma passagem vitoriosa pelo futebol feminino nacional. Quantos títulos do Brasileirão feminino o clube já venceu?',
   1, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2014, 'pending'),
  ('O Palmeiras investiu pesado no futebol feminino na última década. Quantos títulos do Brasileirão feminino o clube já venceu?',
   1, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2022, 'pending'),
  ('O Cruzeiro reforçou seu time feminino nos últimos anos, disputando o topo do Brasileirão. Quantos títulos do Brasileirão feminino o clube já venceu?',
   1, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2024, 'pending'),
  ('O Kindermann, de Caçador (SC), foi um dos berços do futebol feminino brasileiro antes da profissionalização recente. Quantos títulos do Brasileirão feminino o clube já venceu?',
   3, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2000, 'pending'),
  ('O Saad foi uma potência paulista do futebol feminino nos anos 1990, período anterior à criação do Brasileirão feminino oficial da CBF. Quantos títulos nacionais o clube já venceu?',
   4, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1995, 'pending');

-- Família I: jogadoras com mais jogos (caps) pela seleção brasileira feminina.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('Formiga disputou sete Copas do Mundo pela seleção brasileira, recorde mundial de longevidade. Quantos jogos ela disputou pela seleção feminina?',
   233, 'jogos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('Marta é a maior artilheira da seleção brasileira feminina. Quantos jogos ela disputou pela seleção ao longo da carreira?',
   190, 'jogos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2024, 'pending'),
  ('Rosana foi uma das principais atacantes da seleção brasileira feminina nos anos 2000 e 2010. Quantos jogos ela disputou pela seleção?',
   150, 'jogos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2016, 'pending'),
  ('Cristiane defendeu a seleção brasileira feminina em quatro Copas do Mundo. Quantos jogos ela disputou pela seleção?',
   155, 'jogos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2019, 'pending'),
  ('Tamires é uma das laterais mais experientes da seleção brasileira feminina recente. Quantos jogos ela disputou pela seleção?',
   120, 'jogos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('Andressa Alves rodou por clubes europeus e defendeu a seleção brasileira feminina por anos. Quantos jogos ela disputou pela seleção?',
   90, 'jogos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2022, 'pending'),
  ('Debinha é uma das principais atacantes da seleção brasileira feminina na última década. Quantos jogos ela disputou pela seleção?',
   130, 'jogos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('Erika foi lateral e volante titular da seleção brasileira feminina em três Copas do Mundo. Quantos jogos ela disputou pela seleção?',
   110, 'jogos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2019, 'pending'),
  ('Fabiana foi lateral e zagueira histórica da seleção brasileira feminina. Quantos jogos ela disputou pela seleção?',
   100, 'jogos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2019, 'pending'),
  ('Aline foi goleira titular da seleção brasileira feminina por mais de uma década. Quantos jogos ela disputou pela seleção?',
   95, 'jogos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2019, 'pending');

-- Família J: gols marcados pela seleção brasileira feminina em Copas do Mundo, por edição
-- (e o total histórico somando todas as edições).
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('A seleção brasileira feminina estreou em Copas do Mundo em 1991, na China. Quantos gols o Brasil marcou naquela edição?',
   2, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1991, 'pending'),
  ('Na Copa do Mundo feminina de 1995, na Suécia, quantos gols a seleção brasileira marcou no total?',
   5, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1995, 'pending'),
  ('Na Copa do Mundo feminina de 1999, nos Estados Unidos, o Brasil chegou às quartas de final. Quantos gols a seleção marcou no total?',
   11, 'gols', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1999, 'pending'),
  ('Na Copa do Mundo feminina de 2003, nos Estados Unidos, quantos gols a seleção brasileira marcou no total?',
   12, 'gols', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2003, 'pending'),
  ('Na Copa do Mundo feminina de 2007, na China, o Brasil chegou à final com Marta artilheira do torneio. Quantos gols a seleção marcou no total?',
   20, 'gols', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2007, 'pending'),
  ('Na Copa do Mundo feminina de 2011, na Alemanha, quantos gols a seleção brasileira marcou no total?',
   9, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2011, 'pending'),
  ('Na Copa do Mundo feminina de 2015, no Canadá, a seleção brasileira teve uma campanha discreta. Quantos gols o Brasil marcou no total?',
   3, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2015, 'pending'),
  ('Na Copa do Mundo feminina de 2019, na França, quantos gols a seleção brasileira marcou no total?',
   7, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2019, 'pending'),
  ('Na Copa do Mundo feminina de 2023, na Austrália e Nova Zelândia, o Brasil foi eliminado ainda na fase de grupos. Quantos gols a seleção marcou no total?',
   2, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('A seleção brasileira feminina já disputou nove edições da Copa do Mundo, de 1991 a 2023. Somando todas as edições, quantos gols o Brasil já marcou em Copas do Mundo femininas?',
   71, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending');

-- Família K: anos sem título estadual (jejum), clubes brasileiros de menor visibilidade nacional.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('A Santa Cruz já foi a maior torcida de Pernambuco, mas vive um jejum de títulos estaduais. Até 2025, há quantos anos o clube não vence o Campeonato Pernambucano?',
   13, 'anos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2025, 'pending'),
  ('O Náutico, clube centenário do Recife, também enfrenta um jejum estadual notável. Até 2025, há quantos anos o clube não vence o Campeonato Pernambucano?',
   8, 'anos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2025, 'pending'),
  ('O Guarani já foi campeão brasileiro em 1978, mas vive um longo jejum no Campeonato Paulista. Até 2025, há quantos anos o clube não vence o estadual?',
   37, 'anos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2025, 'pending'),
  ('A Ponte Preta é um dos clubes mais antigos de Campinas, mas tem um dos jejuns estaduais mais longos do futebol paulista. Até 2025, há quantos anos o clube não vence o Paulistão?',
   90, 'anos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2025, 'pending'),
  ('A Portuguesa já foi um clube grande do futebol paulista, mas vive décadas sem título estadual. Até 2025, há quantos anos o clube não vence o Campeonato Paulista?',
   29, 'anos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2025, 'pending'),
  ('O Paysandu é o clube mais popular do Pará, mas enfrenta um jejum recente no estadual. Até 2025, há quantos anos o clube não vence o Campeonato Paraense?',
   8, 'anos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2025, 'pending'),
  ('O CSA, um dos clubes mais tradicionais de Alagoas, também vive um jejum estadual. Até 2025, há quantos anos o clube não vence o Campeonato Alagoano?',
   5, 'anos', 'futebol', 1, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2025, 'pending'),
  ('O Vila Nova disputa com o Goiás e o Atlético-GO o domínio do futebol goiano, mas vive um jejum recente. Até 2025, há quantos anos o clube não vence o Campeonato Goiano?',
   5, 'anos', 'futebol', 1, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2025, 'pending'),
  ('O América-RN divide o futebol potiguar com o ABC, mas vive um jejum estadual recente. Até 2025, há quantos anos o clube não vence o Campeonato Potiguar?',
   6, 'anos', 'futebol', 1, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2025, 'pending'),
  ('O Figueirense já disputou a Série A do Brasileirão, mas vive um jejum no Campeonato Catarinense. Até 2025, há quantos anos o clube não vence o estadual?',
   11, 'anos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2025, 'pending');

-- Família L: total de títulos estaduais na história do clube, clubes brasileiros de menor
-- visibilidade nacional.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('O Sport Recife é um dos clubes mais vitoriosos do futebol nordestino em nível estadual. Quantos Campeonatos Pernambucanos o clube já venceu na história?',
   43, 'títulos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2025, 'pending'),
  ('O Náutico também acumula um bom número de títulos do Campeonato Pernambucano. Quantos o clube já venceu na história?',
   24, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2025, 'pending'),
  ('A Santa Cruz, apesar do jejum recente, tem uma coleção histórica de títulos pernambucanos. Quantos o clube já venceu?',
   22, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2025, 'pending'),
  ('O Vitória disputa com o Bahia a hegemonia do futebol baiano há mais de um século. Quantos Campeonatos Baianos o clube já venceu?',
   30, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2025, 'pending'),
  ('O Ceará é um dos clubes mais vitoriosos do Nordeste em nível estadual. Quantos Campeonatos Cearenses o clube já venceu na história?',
   47, 'títulos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2025, 'pending'),
  ('O Fortaleza também acumula um grande número de títulos do Campeonato Cearense. Quantos o clube já venceu na história?',
   44, 'títulos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2025, 'pending'),
  ('O Goiás é o clube mais tradicional do futebol goiano em nível estadual. Quantos Campeonatos Goianos o clube já venceu na história?',
   24, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2025, 'pending'),
  ('O Vila Nova disputa a hegemonia do futebol goiano com o Goiás e o Atlético-GO. Quantos Campeonatos Goianos o clube já venceu?',
   18, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2025, 'pending'),
  ('O Guarani já foi campeão brasileiro em 1978, mas tem um histórico modesto de títulos estaduais. Quantos Campeonatos Paulistas o clube já venceu?',
   10, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2025, 'pending'),
  ('A Ponte Preta, um dos clubes mais antigos de Campinas, tem poucos títulos estaduais na história. Quantos Campeonatos Paulistas o clube já venceu?',
   6, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2025, 'pending');

-- Família M: recorde de gols de uma artilheira numa edição ou torneio específico (futebol
-- feminino brasileiro e internacional).
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('Ary Borges marcou um hat-trick pela seleção brasileira na estreia da Copa do Mundo feminina de 2023, contra o Panamá. Quantos gols ela marcou naquela única partida?',
   3, 'gols', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('Marta é a maior artilheira histórica de Copas do Mundo, somando as edições masculina e feminina. Quantos gols ela marcou em Copas do Mundo ao longo da carreira?',
   17, 'gols', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('Cristiane é a maior artilheira histórica dos Jogos Olímpicos no futebol feminino, somando todas as seleções. Quantos gols ela marcou em Olimpíadas?',
   15, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2016, 'pending'),
  ('Debinha foi artilheira de uma das edições do Brasileirão feminino antes de se transferir para os Estados Unidos. Quantos gols ela marcou naquela única temporada?',
   18, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2019, 'pending'),
  ('Gabi Portilho foi artilheira de uma edição do Brasileirão feminino pelo Corinthians. Quantos gols ela marcou naquela única temporada?',
   20, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2021, 'pending'),
  ('Kerolin foi artilheira de uma temporada da NWSL, liga norte-americana, jogando pelo North Carolina Courage. Quantos gols ela marcou naquela temporada?',
   12, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2022, 'pending'),
  ('Adriana foi artilheira do Brasileirão feminino de 2019 pelo Corinthians. Quantos gols ela marcou naquela edição?',
   22, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2019, 'pending'),
  ('Byanca Brasil foi artilheira de uma edição da Copa do Brasil feminino pelo Corinthians. Quantos gols ela marcou naquela edição?',
   10, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2022, 'pending'),
  ('Marta foi artilheira isolada da Copa do Mundo feminina de 2007, na China, com uma atuação histórica. Quantos gols ela marcou naquela única edição?',
   7, 'gols', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2007, 'pending'),
  ('Cristiane foi artilheira de uma edição dos Jogos Pan-Americanos pela seleção brasileira feminina. Quantos gols ela marcou naquela única edição?',
   8, 'gols', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2007, 'pending');

-- Família N: títulos da UEFA Women's Champions League (Liga dos Campeões feminina) por clube.
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('O Olympique Lyonnais é o clube mais vitorioso da história da Liga dos Campeões feminina. Quantos títulos o clube francês já venceu?',
   8, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2024, 'pending'),
  ('O 1. FFC Frankfurt dominou o futebol feminino europeu antes da ascensão do Lyon. Quantos títulos da Liga dos Campeões o clube alemão já venceu?',
   4, 'títulos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2015, 'pending'),
  ('O Barcelona construiu um dos times femininos mais dominantes da Europa na última década. Quantos títulos da Liga dos Campeões feminina o clube já venceu?',
   3, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O Wolfsburg é uma das forças tradicionais do futebol feminino alemão. Quantos títulos da Liga dos Campeões feminina o clube já venceu?',
   2, 'títulos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2014, 'pending'),
  ('O Turbine Potsdam foi um dos primeiros grandes campeões europeus do futebol feminino alemão. Quantos títulos da Liga dos Campeões feminina o clube já venceu?',
   2, 'títulos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2010, 'pending'),
  ('O Arsenal foi um dos primeiros clubes ingleses a vencer a competição, ainda como Arsenal Ladies. Quantos títulos da Liga dos Campeões feminina o clube já venceu?',
   1, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2007, 'pending'),
  ('O Umeå IK, da Suécia, foi campeão nas primeiras edições da competição europeia. Quantos títulos da Liga dos Campeões feminina o clube já venceu?',
   1, 'títulos', 'futebol', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2004, 'pending'),
  ('O Chelsea investiu pesado no futebol feminino na última década, mas nunca venceu a Liga dos Campeões. Quantos títulos da competição o clube já venceu?',
   0, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2024, 'pending'),
  ('O Paris Saint-Germain também investiu pesado no futebol feminino, sem nunca vencer a Liga dos Campeões. Quantos títulos da competição o clube já venceu?',
   0, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2024, 'pending'),
  ('O Bayern de Munique tem um time feminino forte na Alemanha, mas ainda não venceu a Liga dos Campeões. Quantos títulos da competição o clube já venceu?',
   0, 'títulos', 'futebol', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2024, 'pending');
