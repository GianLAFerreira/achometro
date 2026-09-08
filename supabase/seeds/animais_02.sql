-- Rascunho de candidatos — tema animais (lote 2). Escrito "de memória", SEM pesquisa e SEM
-- verificação de fonte — cada linha existe só para uma sessão futura validar com pesquisa real
-- (mesmo processo já usado em supabase/seeds/futebol_25.sql). Não rodar db:reset/db push com este
-- arquivo antes da curadoria. status = 'pending' em todas as linhas.
--
-- Já existiam 6 perguntas aprovadas de tema 'animais' (supabase/seeds/animais_01.sql): maior
-- cobra medida, ovos do peixe-lua, migração da andorinha-do-ártico, longevidade do
-- tubarão-da-Groenlândia, mergulho do zifio-de-Cuvier, população de pandas-gigantes. Este lote
-- evita repetir esses fatos-base e varia o tipo de métrica em vez de insistir em
-- "recorde único do Guinness/estudo científico" sem mudar o ângulo.
--
-- 10 famílias de ~10 perguntas cada, misturando espécies comuns/raras, brasileiras/exóticas,
-- terrestres/aquáticas/aéreas:
-- A. Velocidade máxima terrestre (km/h)
-- B. Velocidade máxima aquática (km/h)
-- C. Velocidade máxima aérea, voo nivelado (km/h)
-- D. Peso máximo recorde de espécie (kg)
-- E. Tempo de gestação (dias)
-- F. Número de filhotes/ovos por ninhada
-- G. Altura ou distância de salto (m/cm)
-- H. Tamanho de colônia/cardume/bando (indivíduos)
-- I. Força de mordida (kgf)
-- J. Fauna brasileira específica (métricas mistas)

insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values

-- Família A: velocidade máxima terrestre (km/h)
(
  'O guepardo é o animal terrestre mais rápido do planeta em disparadas curtas. Qual a velocidade máxima, em km/h, já registrada para a espécie?',
  120, 'km/h', 'animais', 1,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2012, 'pending'
),
(
  'A avestruz é a maior ave viva, mas não voa — corre. Qual a velocidade máxima, em km/h, já registrada para a espécie?',
  70, 'km/h', 'animais', 1,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O antílope-americano (pronghorn), da América do Norte, é considerado o segundo animal terrestre mais veloz do mundo, atrás só do guepardo. Qual sua velocidade máxima registrada, em km/h?',
  88, 'km/h', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O leão caça em bandos e depende de arrancadas curtas, não de resistência. Qual sua velocidade máxima registrada, em km/h?',
  80, 'km/h', 'animais', 1,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O canguru-vermelho, maior marsupial do mundo, se desloca aos saltos em vez de correr. Qual a velocidade máxima já registrada para a espécie, em km/h?',
  70, 'km/h', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'A zebra convive com predadores como leões nas savanas africanas e depende da velocidade para escapar. Qual sua velocidade máxima registrada, em km/h?',
  65, 'km/h', 'animais', 1,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O gnu migra em manadas de milhões de indivíduos pela savana africana. Qual sua velocidade máxima registrada, em km/h?',
  80, 'km/h', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'A ema é a maior ave do Brasil e, como a avestruz, não voa. Qual a velocidade máxima já registrada para a espécie, em km/h?',
  60, 'km/h', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O veado-campeiro é um cervídeo nativo dos campos abertos do Brasil, hoje ameaçado de extinção. Qual sua velocidade máxima estimada, em km/h?',
  65, 'km/h', 'animais', 3,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'A lebre-europeia escapa de predadores só com velocidade, sem tocas para se esconder. Qual sua velocidade máxima registrada, em km/h?',
  72, 'km/h', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),

-- Família B: velocidade máxima aquática (km/h)
(
  'O peixe-vela é considerado o peixe mais veloz dos oceanos. Qual a velocidade máxima já registrada para a espécie, em km/h?',
  110, 'km/h', 'animais', 1,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O peixe-espada usa seu bico rígido para cortar a água em alta velocidade. Qual sua velocidade máxima registrada, em km/h?',
  97, 'km/h', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O atum-rabilho é um dos peixes mais valiosos do mundo na pesca comercial. Qual sua velocidade máxima registrada, em km/h?',
  70, 'km/h', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O marlim-azul é um dos maiores peixes ósseos e um troféu clássico da pesca esportiva. Qual sua velocidade máxima registrada, em km/h?',
  80, 'km/h', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O tubarão-mako é considerado o tubarão mais veloz dos oceanos. Qual sua velocidade máxima registrada, em km/h?',
  74, 'km/h', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'A orca é o maior golfinho do mundo e caça em grupo. Qual sua velocidade máxima registrada, em km/h?',
  56, 'km/h', 'animais', 1,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O golfinho-comum vive em grupos grandes e é um dos cetáceos mais numerosos do planeta. Qual sua velocidade máxima registrada, em km/h?',
  60, 'km/h', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O pinguim-gentoo é considerado a ave aquática mais veloz nadando embaixo d''água. Qual sua velocidade máxima registrada, em km/h?',
  36, 'km/h', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'A foca-leopardo é uma das principais predadoras da Antártida, caçando até pinguins na água. Qual sua velocidade máxima registrada, em km/h?',
  40, 'km/h', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'A barracuda ataca suas presas em arrancadas curtas e explosivas. Qual sua velocidade máxima registrada, em km/h?',
  43, 'km/h', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),

-- Família C: velocidade máxima aérea, voo nivelado (km/h)
(
  'O andorinhão-de-cauda-espinhosa é considerado o animal mais veloz do mundo em voo nivelado, sem contar mergulhos. Qual sua velocidade máxima registrada, em km/h?',
  170, 'km/h', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O falcão-peregrino é famoso pela velocidade de mergulho, mas também é rápido em voo reto e nivelado. Qual sua velocidade máxima registrada nesse tipo de voo, em km/h?',
  100, 'km/h', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O eider é um pato marinho de regiões árticas que voa em bandos sobre o mar aberto. Qual sua velocidade máxima registrada, em km/h?',
  76, 'km/h', 'animais', 3,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O beija-flor-de-garganta-rubi bate as asas dezenas de vezes por segundo para pairar no ar. Qual sua velocidade máxima registrada em voo, em km/h?',
  60, 'km/h', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O condor-dos-andes é uma das maiores aves voadoras do mundo e plana por horas sem bater as asas. Qual sua velocidade máxima registrada, em km/h?',
  56, 'km/h', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'A fragata é uma ave marinha que passa semanas voando sem pousar na água. Qual sua velocidade máxima registrada, em km/h?',
  95, 'km/h', 'animais', 3,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O papagaio-do-mar tem asas pequenas para o tamanho do corpo e precisa batê-las muito rápido para voar. Qual sua velocidade máxima registrada, em km/h?',
  88, 'km/h', 'animais', 3,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O morcego-de-cauda-livre-brasileiro forma colônias enormes em cavernas do Brasil e é considerado o mamífero mais veloz em voo nivelado. Qual sua velocidade máxima registrada, em km/h?',
  160, 'km/h', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'A abelha-europeia voa carregando néctar e pólen entre a colmeia e as flores. Qual sua velocidade máxima registrada em voo, em km/h?',
  24, 'km/h', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'A libélula-imperador é um dos insetos voadores mais ágeis do mundo. Qual sua velocidade máxima registrada, em km/h?',
  55, 'km/h', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),

-- Família D: peso máximo recorde de espécie (kg)
(
  'A baleia-azul é o maior animal já registrado na história do planeta. Qual o maior peso, em kg, já registrado para a espécie?',
  190000, 'kg', 'animais', 1,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O tubarão-baleia é o maior peixe vivo do mundo, apesar de se alimentar só de plâncton. Qual o maior peso, em kg, já registrado para a espécie?',
  34000, 'kg', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O elefante-africano é o maior animal terrestre vivo. Qual o maior peso, em kg, já registrado para a espécie?',
  10400, 'kg', 'animais', 1,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O rinoceronte-branco é o segundo maior animal terrestre do mundo, atrás só dos elefantes. Qual o maior peso, em kg, já registrado para a espécie?',
  2300, 'kg', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'A girafa é o animal terrestre mais alto do mundo. Qual o maior peso, em kg, já registrado para a espécie?',
  1930, 'kg', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O urso-polar é o maior carnívoro terrestre vivo do planeta. Qual o maior peso, em kg, já registrado para a espécie?',
  1002, 'kg', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O crocodilo-de-água-salgada é o maior réptil vivo do mundo. Qual o maior peso, em kg, já registrado para a espécie?',
  1075, 'kg', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'A anta é o maior mamífero terrestre nativo da América do Sul. Qual o maior peso, em kg, já registrado para a espécie?',
  320, 'kg', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'A avestruz é a maior ave viva do planeta. Qual o maior peso, em kg, já registrado para a espécie?',
  157, 'kg', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'A capivara é o maior roedor vivo do mundo. Qual o maior peso, em kg, já registrado para a espécie?',
  91, 'kg', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),

-- Família E: tempo de gestação (dias)
(
  'O elefante-africano tem a gestação mais longa entre os mamíferos terrestres. Quantos dias, em média, dura essa gestação?',
  660, 'dias', 'animais', 1,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O tubarão-frade é o segundo maior peixe do mundo e é apontado por pesquisadores como o vertebrado com a gestação mais longa já estimada. Quantos dias essa gestação pode durar, segundo essa estimativa?',
  1277, 'dias', 'animais', 3,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'A girafa nasce já caindo de uma altura de quase dois metros. Quantos dias dura, em média, a gestação da espécie?',
  457, 'dias', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O rinoceronte-branco tem uma das gestações mais longas entre os mamíferos terrestres. Quantos dias dura, em média?',
  490, 'dias', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O camelo vive em ambientes desérticos extremos e tem gestação bem mais longa que a de um cavalo. Quantos dias dura, em média?',
  400, 'dias', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O tatu-galinha tem um mecanismo raro de atrasar o início do desenvolvimento do embrião após o acasalamento. Quantos dias dura, em média, sua gestação total?',
  120, 'dias', 'animais', 3,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'A preguiça é conhecida pelo metabolismo extremamente lento, e sua gestação segue o mesmo ritmo. Quantos dias dura, em média?',
  180, 'dias', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'A baleia-jubarte migra milhares de quilômetros entre áreas de alimentação e reprodução. Quantos dias dura, em média, sua gestação?',
  330, 'dias', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O gambá é um marsupial brasileiro e tem uma das gestações mais curtas entre os mamíferos do mundo. Quantos dias dura essa gestação?',
  13, 'dias', 'animais', 3,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O canguru-vermelho é um marsupial e, como o gambá, tem gestação muito curta. Quantos dias dura, em média?',
  33, 'dias', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),

-- Família F: número de filhotes/ovos por ninhada
(
  'O tatu-galinha é um dos poucos mamíferos do mundo que sempre dá à luz irmãos geneticamente idênticos, vindos de um único óvulo fecundado. Quantos filhotes idênticos nascem em cada ninhada?',
  4, 'filhotes', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'A rã-touro é uma espécie invasora no Brasil e uma das rãs mais prolíficas do mundo. Quantos ovos, aproximadamente, uma fêmea consegue pôr em uma única desova?',
  20000, 'ovos', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'A fêmea do polvo-gigante-do-pacífico passa meses sem comer só cuidando dos ovos, e depois morre. Quantos ovos, aproximadamente, ela consegue pôr em uma única ninhada?',
  100000, 'ovos', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'A tartaruga-verde volta à mesma praia onde nasceu para desovar. Quantos ovos, aproximadamente, ela põe em cada ninhada?',
  120, 'ovos', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'A jiboia, diferente da maioria das cobras, não põe ovos — os filhotes nascem vivos. Quantos filhotes, aproximadamente, nascem em uma única ninhada?',
  60, 'filhotes', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O coelho-europeu é conhecido por se reproduzir tão rápido que virou espécie invasora em vários países. Quantos filhotes nascem, em média, em cada ninhada?',
  12, 'filhotes', 'animais', 1,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O cachorro-do-mato é um canídeo silvestre comum em quase todo o território brasileiro. Quantos filhotes nascem, em média, em cada ninhada?',
  5, 'filhotes', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O camundongo se reproduz tão rápido que uma única fêmea pode gerar centenas de descendentes por ano. Quantos filhotes nascem, em média, em cada ninhada?',
  14, 'filhotes', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'A piranha-vermelha é um peixe amazônico famoso pela fama de agressividade. Quantos ovos, aproximadamente, uma fêmea põe em uma única desova?',
  5000, 'ovos', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O gambá carrega os filhotes recém-nascidos numa bolsa (marsúpio), mas o número de tetas limita quantos sobrevivem. Quantos filhotes, em média, nascem vivos em uma ninhada?',
  13, 'filhotes', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),

-- Família G: altura ou distância de salto (m/cm)
(
  'A pulga é famosa por conseguir saltar dezenas de vezes a altura do próprio corpo. Qual a altura máxima, em cm, já registrada para esse salto?',
  20, 'cm', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O gafanhoto usa as patas traseiras como molas para escapar de predadores. Qual a distância máxima, em cm, já registrada para esse salto?',
  100, 'cm', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O canguru-vermelho se desloca só aos saltos. Qual a altura máxima, em metros, já registrada para um salto vertical da espécie?',
  3, 'metros', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O puma é um dos felinos com os saltos mais longos do mundo, usado tanto para caçar quanto para escapar de predadores maiores. Qual a distância máxima, em metros, já registrada para um único salto?',
  6, 'metros', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O impala é uma das presas mais comuns dos grandes predadores africanos e escapa deles aos saltos. Qual a altura máxima, em metros, já registrada para um salto vertical?',
  3, 'metros', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O recorde mundial de salto em altura com cavalo em concurso hípico é considerado imbatível há décadas. Qual a altura, em cm, desse recorde?',
  247, 'cm', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1949, 'pending'
),
(
  'Concursos de salto de rã são uma tradição popular nos Estados Unidos, e o recorde mundial é validado até hoje. Qual a distância, em cm, desse recorde?',
  655, 'cm', 'animais', 3,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1986, 'pending'
),
(
  'O golfinho-nariz-de-garrafa consegue saltar completamente para fora da água. Qual a altura máxima, em metros, já registrada para esse salto?',
  6, 'metros', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'A orca é o maior golfinho do mundo e também consegue saltar para fora da água. Qual a altura máxima, em metros, já registrada para esse salto?',
  5, 'metros', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'A baleia-jubarte, apesar do tamanho gigantesco, consegue erguer boa parte do corpo para fora da água num salto (breaching). Qual a altura máxima, em metros, já registrada para esse salto?',
  4, 'metros', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),

-- Família H: tamanho de colônia/cardume/bando (indivíduos)
(
  'A formiga-de-fogo é uma espécie invasora que forma colônias enormes e agressivas. Quantos indivíduos, aproximadamente, uma colônia grande dessa espécie pode reunir?',
  500000, 'indivíduos', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'Uma colmeia de abelhas funciona como um único organismo, com milhares de operárias trabalhando juntas. Quantos indivíduos, em média, vivem numa colmeia grande?',
  60000, 'indivíduos', 'animais', 1,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'Cavernas do Brasil abrigam algumas das maiores colônias de morcegos do mundo. Quantos indivíduos, aproximadamente, uma dessas colônias pode reunir?',
  200000, 'indivíduos', 'animais', 3,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O pinguim-imperador se reproduz em colônias enormes sobre o gelo da Antártida para se proteger do frio extremo. Quantos indivíduos, aproximadamente, uma colônia grande pode reunir?',
  200000, 'indivíduos', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'Enxames de gafanhoto-do-deserto já causaram crises alimentares na África por devorarem plantações inteiras. Quantos indivíduos, aproximadamente, um enxame denso pode reunir por km²?',
  80000000, 'indivíduos por km²', 'animais', 3,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'Todo ano, na costa da África do Sul, acontece um fenômeno conhecido como "corrida da sardinha", com um cardume tão grande que é visto do espaço. Quantos indivíduos, aproximadamente, esse cardume pode reunir?',
  15000000, 'indivíduos', 'animais', 3,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O Lago Natron, na África, é um dos poucos lugares do mundo onde o flamingo-rosa se reproduz em massa. Quantos indivíduos, aproximadamente, esse bando reprodutivo pode reunir?',
  1500000, 'indivíduos', 'animais', 3,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'A morsa se reúne em grandes colônias sobre o gelo ou praias do Ártico para descansar e se reproduzir. Quantos indivíduos, aproximadamente, uma colônia grande pode reunir?',
  3000, 'indivíduos', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O pinguim-de-magalhães se reproduz na Patagônia e passa o inverno nadando até o litoral do Brasil. Quantos indivíduos, aproximadamente, sua maior colônia reprodutiva reúne?',
  1000000, 'indivíduos', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'A capivara é o roedor mais social do Brasil, vivendo sempre em grupo. Quantos indivíduos, aproximadamente, o maior grupo já registrado reunia?',
  100, 'indivíduos', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),

-- Família I: força de mordida (kgf)
(
  'O jacaré-do-pantanal é o réptil mais comum dos rios e lagoas do Pantanal brasileiro. Qual a força máxima de mordida, em kgf, já registrada para a espécie?',
  300, 'kgf', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'A onça-pintada é considerada o felino com a mordida proporcionalmente mais forte do mundo, capaz de perfurar o casco de jacarés. Qual a força máxima de mordida, em kgf, já registrada para a espécie?',
  500, 'kgf', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O hipopótamo é considerado um dos mamíferos mais perigosos da África, apesar de ser herbívoro. Qual a força máxima de mordida, em kgf, já registrada para a espécie?',
  800, 'kgf', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O tubarão-touro é uma das poucas espécies de tubarão que consegue viver em água doce. Qual a força máxima de mordida, em kgf, já registrada para a espécie?',
  600, 'kgf', 'animais', 3,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O urso-pardo consegue quebrar ossos grossos com a mordida. Qual a força máxima de mordida, em kgf, já registrada para a espécie?',
  500, 'kgf', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'A hiena-malhada consegue triturar ossos inteiros com a mordida, algo raro entre carnívoros. Qual a força máxima de mordida, em kgf, já registrada para a espécie?',
  400, 'kgf', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O gorila-das-terras-baixas é o maior primata vivo do mundo. Qual a força máxima de mordida, em kgf, já registrada para a espécie?',
  590, 'kgf', 'animais', 3,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O crocodilo-de-água-salgada tem a mordida mais forte já medida entre todos os animais vivos. Qual a força máxima de mordida, em kgf, já registrada para a espécie?',
  1700, 'kgf', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'Um estudo comparou a força da mordida de vários animais em relação ao tamanho do corpo, e a piranha-preta liderou o ranking apesar do tamanho pequeno. Qual a força máxima de mordida, em kgf, já registrada para a espécie nesse estudo?',
  30, 'kgf', 'animais', 3,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O leão precisa derrubar presas muito maiores que ele com a força da mordida. Qual a força máxima de mordida, em kgf, já registrada para a espécie?',
  400, 'kgf', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),

-- Família J: fauna brasileira específica (métricas mistas)
(
  'Um estudo identificou uma área do semiárido brasileiro coberta por milhões de cupinzeiros de uma só espécie, um dos maiores conjuntos de construções de um único animal no mundo. Quantos cupinzeiros, aproximadamente, esse estudo estimou nessa área?',
  200000000, 'cupinzeiros', 'animais', 3,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2018, 'pending'
),
(
  'O mico-leão-dourado é um primata símbolo da Mata Atlântica que já esteve à beira da extinção. Quantos indivíduos, aproximadamente, vivem soltos na natureza hoje?',
  4800, 'indivíduos', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O peixe-boi-da-amazônia é o maior mamífero de água doce do mundo. Quantos indivíduos, aproximadamente, restam na natureza?',
  10000, 'indivíduos', 'animais', 3,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'A arara-azul-de-lear só existe na natureza numa pequena região do interior da Bahia. Quantos indivíduos, aproximadamente, restam na natureza hoje?',
  1700, 'indivíduos', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O mutum-do-nordeste é uma ave brasileira considerada extinta na natureza, sobrevivendo hoje só em cativeiro. Quantos indivíduos, aproximadamente, existem em cativeiro hoje?',
  150, 'indivíduos', 'animais', 3,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O Pantanal abriga uma das maiores populações de onça-pintada do mundo, atraindo turistas de vários países. Quantos indivíduos, aproximadamente, vivem soltos nessa região?',
  4000, 'indivíduos', 'animais', 3,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O boto-cor-de-rosa é o maior golfinho de água doce do mundo e vive nos rios da Amazônia. Qual o maior peso, em kg, já registrado para a espécie?',
  185, 'kg', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'A tartaruga-da-amazônia é a maior tartaruga de água doce da América do Sul e desova em praias de rio. Quantos ovos, aproximadamente, ela põe em cada ninhada?',
  120, 'ovos', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'O tamanduá-bandeira não tem dentes e depende só da língua para comer formigas e cupins. Qual o comprimento máximo, em cm, já registrado para essa língua?',
  45, 'cm', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
),
(
  'A ariranha é a maior espécie de lontra do mundo e vive em rios da Amazônia e do Pantanal. Qual o maior comprimento total, em cm, já registrado para a espécie?',
  180, 'cm', 'animais', 2,
  'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2020, 'pending'
);
