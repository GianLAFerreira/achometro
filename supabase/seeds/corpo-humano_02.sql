-- RASCUNHO NÃO VERIFICADO. Todas as ~100 linhas abaixo foram escritas de memória, sem pesquisa
-- (sem WebSearch/WebFetch) — é geração de volume de candidatos, não curadoria. Todo `answer` é
-- estimativa educada; toda `source_name`/`source_url` é placeholder. status = 'pending' em toda
-- linha; start_round só sorteia status = 'approved', então nada aqui entra em partida real antes
-- de uma sessão futura confirmar cada número com fonte real e decidir aprovar/rejeitar (mesmo
-- processo usado em futebol_25.sql e brasil_02.sql).
--
-- Não repete fato-base nem molde já usado em supabase/seed.sql ("quantas vezes um adulto respira
-- por dia") nem em supabase/seeds/corpo-humano_01.sql (recorde de apneia, recorde de cabelo mais
-- longo, débito cardíaco em litros/dia, tempo de reação a estímulo visual, ciclo de renovação da
-- epiderme). Evita deliberadamente perguntas de conhecimento geral (ex.: "quantos ossos tem o
-- corpo humano", "quantos litros de sangue tem o corpo") — o foco é estimativa real, com âncora.
--
-- Famílias incluídas (cada uma cobre 1 métrica, variando o órgão/tecido/substância/característica):
--   1.  Tempo de renovação (vida útil) de diferentes tipos de célula do corpo, em dias
--   2.  Comprimento de estruturas anatômicas específicas, em centímetros
--   3.  Capacidade/volume máximo de órgãos e cavidades, em mililitros
--   4.  Recorde documentado de tempo do corpo humano numa condição extrema, em horas
--   5.  Número de receptores/células sensoriais de cada sentido
--   6.  Semana de gestação em que um marco do desenvolvimento fetal acontece
--   7.  Número de genes/variantes associados a uma característica, segundo estudos GWAS
--   8.  Composição corporal: massa de uma substância/tecido no corpo de um adulto médio (70 kg)
--   9.  Microbioma humano: fatos e contagens
--   10. Meia-vida de substâncias no sangue, em minutos

insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values

-- Família 1: tempo de renovação (vida útil) de diferentes tipos de célula do corpo, em dias
  ('As hemácias circulam pelo corpo carregando oxigênio até serem recicladas pelo baço. Quantos dias, em média, uma hemácia sobrevive antes de ser substituída?',
   120, 'dias', 'corpo-humano', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('As plaquetas são as células responsáveis por estancar sangramentos, formando coágulos. Quantos dias, em média, uma plaqueta sobrevive na corrente sanguínea antes de ser substituída?',
   10, 'dias', 'corpo-humano', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O revestimento interno do intestino delgado é raspado constantemente pela passagem do alimento e precisa se renovar sem parar. Quantos dias leva, em média, para essas células se renovarem por completo?',
   4, 'dias', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O fígado é um dos órgãos com maior capacidade de regeneração do corpo, renovando suas próprias células regularmente. Quantos dias, em média, vive um hepatócito antes de ser substituído?',
   300, 'dias', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('Da célula ainda imatura até o espermatozoide pronto para ser liberado, o corpo masculino passa por um ciclo inteiro de produção. Quantos dias dura esse ciclo completo de espermatogênese?',
   74, 'dias', 'corpo-humano', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('As células que compõem cada papila gustativa da língua morrem e são substituídas com frequência bem maior que a maioria das células do corpo. Quantos dias, em média, vive uma dessas células?',
   10, 'dias', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('A córnea fica exposta direto ao ar e ao atrito das pálpebras a cada piscada, então suas células superficiais se renovam rápido. Quantos dias, em média, leva esse ciclo de renovação?',
   7, 'dias', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O revestimento interno da bexiga fica em contato direto com a urina e também precisa se renovar regularmente. Quantos dias, em média, vive uma célula desse revestimento antes de ser substituída?',
   200, 'dias', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('Os neurônios que detectam cheiros ficam na mucosa do nariz, expostos direto ao ar que respiramos, e são um dos poucos tipos de neurônio que o corpo consegue substituir. Quantos dias, em média, vive um desses neurônios antes de ser trocado por um novo?',
   60, 'dias', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O osso parece uma estrutura fixa, mas é tecido vivo que se desfaz e se reconstrói o tempo todo. Quantos dias leva, em média, para o esqueleto adulto inteiro ser completamente renovado, célula por célula?',
   3650, 'dias', 'corpo-humano', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),

-- Família 2: comprimento de estruturas anatômicas específicas, em centímetros
  ('A traqueia liga a garganta aos pulmões e é reforçada por anéis de cartilagem. Quantos centímetros de comprimento ela tem, em média, num adulto?',
   11, 'centímetros', 'corpo-humano', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O esôfago leva o alimento da garganta até o estômago, atravessando o peito inteiro. Quantos centímetros de comprimento ele tem, em média?',
   25, 'centímetros', 'corpo-humano', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('A aorta é a maior artéria do corpo, saindo do coração e descendo até se ramificar na altura do abdômen. Quantos centímetros de comprimento ela tem, em média, num adulto?',
   40, 'centímetros', 'corpo-humano', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('A medula espinhal desce dentro da coluna vertebral, mas termina bem antes do fim da coluna. Quantos centímetros de comprimento ela tem, em média, num adulto?',
   45, 'centímetros', 'corpo-humano', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O fêmur é o osso mais longo do corpo humano, indo do quadril até o joelho. Quantos centímetros de comprimento ele tem, em média, num adulto?',
   48, 'centímetros', 'corpo-humano', 1, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O nervo ciático é o mais longo e mais grosso do corpo, descendo da base da coluna até o pé. Quantos centímetros de comprimento ele tem, em média, numa pessoa adulta?',
   100, 'centímetros', 'corpo-humano', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('Cada ureter liga um rim à bexiga, descendo por dentro do abdômen. Quantos centímetros de comprimento ele tem, em média?',
   25, 'centímetros', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O cordão umbilical liga o feto à placenta durante toda a gestação. Quantos centímetros de comprimento ele tem, em média, no momento do parto?',
   50, 'centímetros', 'corpo-humano', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O intestino grosso (cólon) recebe o que sobrou da digestão antes de virar fezes. Quantos centímetros de comprimento ele tem, em média, num adulto?',
   150, 'centímetros', 'corpo-humano', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O tendão de Aquiles liga a panturrilha ao calcanhar e é o mais grosso e resistente do corpo. Quantos centímetros de comprimento ele tem, em média?',
   15, 'centímetros', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),

-- Família 3: capacidade/volume máximo de órgãos e cavidades, em mililitros
  ('Vazio, o estômago tem o tamanho de um punho fechado, mas se estica bastante depois de uma refeição grande. Quantos mililitros ele consegue comportar quando totalmente distendido?',
   1500, 'mililitros', 'corpo-humano', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('A vesícula biliar é um órgão pequeno, escondido embaixo do fígado, que guarda bile entre as refeições. Quantos mililitros ela consegue armazenar, no máximo?',
   50, 'mililitros', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('Numa respiração normal em repouso, os pulmões usam só uma fração da capacidade que realmente têm. Quantos mililitros é a capacidade pulmonar total de um adulto, somando tudo?',
   6000, 'mililitros', 'corpo-humano', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('Fora da gravidez, o útero tem o tamanho de uma pera pequena, mas se expande enormemente para acomodar o bebê. Quantos mililitros ele chega a comportar no fim de uma gestação a termo?',
   5000, 'mililitros', 'corpo-humano', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('Esse líquido banha o cérebro e a medula espinhal, amortecendo impactos. Quantos mililitros dele circulam, ao todo, pelo sistema nervoso central de um adulto?',
   150, 'mililitros', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O ventrículo esquerdo é a câmara do coração que bombeia sangue para o corpo inteiro. Quantos mililitros de sangue ele comporta quando está completamente cheio, antes de bater?',
   120, 'mililitros', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O intestino grosso é mais curto que o delgado, mas bem mais largo. Quantos mililitros ele consegue comportar, no máximo?',
   1200, 'mililitros', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('Dentro de cada rim existe uma pequena cavidade onde a urina se acumula antes de descer pelo ureter. Quantos mililitros essa cavidade comporta, no máximo, em condições normais?',
   8, 'mililitros', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('Nem todo o ar que a gente inspira chega às partes do pulmão que trocam gases — parte fica só passando pelas vias aéreas. Quantos mililitros de ar ficam, em média, nesse "espaço morto" a cada respiração?',
   150, 'mililitros', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('A vontade de urinar aparece bem antes da bexiga estar de fato cheia. Quantos mililitros ela consegue comportar, no limite, antes da dor ficar insuportável?',
   800, 'mililitros', 'corpo-humano', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),

-- Família 4: recorde documentado de tempo do corpo humano numa condição extrema, em horas
  ('Em 1964, um estudante americano de 17 anos ficou acordado o máximo de tempo que conseguiu, sob observação de pesquisadores do sono. Quantas horas seguidas ele ficou sem dormir?',
   264, 'horas', 'corpo-humano', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1964, 'pending'),
  ('No fim dos anos 1960, um escocês com obesidade grave passou por um jejum medicamente supervisionado, tomando só água, vitaminas e eletrólitos. Quantas horas seguidas durou esse jejum?',
   9168, 'horas', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1971, 'pending'),
  ('Um fazendeiro americano começou a soluçar em 1922 e não conseguiu parar por décadas, virando um caso médico famoso. Quantas horas seguidas, ao todo, ele passou soluçando até finalmente parar?',
   596000, 'horas', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1990, 'pending'),
  ('Um homem americano ficou anos num estado de consciência mínima após um acidente, antes de surpreender os médicos ao voltar a falar. Quantas horas ele ficou nesse estado antes de se recuperar?',
   166400, 'horas', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2003, 'pending'),
  ('Uma médica norueguesa caiu num rio congelado durante um passeio de esqui e ficou presa sob o gelo até ser resgatada em hipotermia extrema, sem sinais vitais. Quantas horas seu coração ficou parado antes de ela ser reanimada com vida, sem sequelas graves?',
   3, 'horas', 'corpo-humano', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1999, 'pending'),
  ('Existe um caso, ainda hoje contestado por parte da medicina, do que seria a gestação humana documentada mais longa da história. Quantas horas ela teria durado, da concepção ao parto?',
   9000, 'horas', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1945, 'pending'),
  ('Depois de um grande terremoto, equipes de resgate encontram sobreviventes presos sob escombros por tempos impressionantes. Quantas horas uma das pessoas resgatadas com vida ficou presa, num dos casos mais longos já registrados?',
   261, 'horas', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('Um americano contraiu poliomielite ainda criança, nos anos 1950, e passou o resto da vida dependendo de um respirador em formato de cápsula para conseguir respirar. Quantas horas, ao todo, ele viveu dependendo desse aparelho?',
   631000, 'horas', 'corpo-humano', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2024, 'pending'),
  ('Existe um caso documentado de cirurgia para remoção de um tumor gigante que se estendeu por dias seguidos, com a paciente sob anestesia geral o tempo todo. Quantas horas essa cirurgia durou, ao todo?',
   96, 'horas', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 1951, 'pending'),
  ('Existe um caso clínico raro de febre alta que não baixou por dias seguidos, mesmo com tratamento. Quantas horas seguidas essa febre persistiu?',
   240, 'horas', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2015, 'pending'),

-- Família 5: número de receptores/células sensoriais de cada sentido
  ('Os bastonetes são as células da retina responsáveis pela visão em ambientes escuros. Quantos milhões deles existem, em média, em cada olho humano?',
   120, 'milhões de bastonetes', 'corpo-humano', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('Os cones são as células da retina responsáveis por enxergar cores e detalhes finos, em quantidade bem menor que os bastonetes. Quantos milhões deles existem, em média, em cada olho humano?',
   6, 'milhões de cones', 'corpo-humano', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('A cóclea, dentro do ouvido interno, transforma vibração sonora em sinal elétrico usando células revestidas de minúsculos cílios. Quantas dessas células ciliadas existem, ao todo, em cada ouvido?',
   15000, 'células ciliadas', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O nariz humano detecta cheiros através de neurônios especializados na mucosa olfativa, que se renovam com frequência. Quantos milhões desses neurônios existem, ao todo, no nariz?',
   6, 'milhões de neurônios', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('A pele inteira do corpo é coberta por receptores que detectam toque, pressão e vibração. Quantos milhões desses receptores táteis existem, ao todo, espalhados pela pele?',
   4, 'milhões de receptores', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('Cada papila gustativa da língua abriga um grupo de células sensíveis a sabor. Quantas papilas gustativas existem, ao todo, numa língua adulta?',
   10000, 'papilas gustativas', 'corpo-humano', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O olfato humano reconhece uma quantidade enorme de cheiros diferentes usando um número limitado de tipos de receptor, cada um codificado por um gene específico. Quantos tipos diferentes de receptor olfativo o nariz humano tem?',
   400, 'tipos de receptor', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('Espalhados dentro dos músculos do corpo inteiro, existem receptores que avisam o cérebro sobre o quanto cada músculo está esticado. Quantos milhares desses receptores (fusos musculares) existem, ao todo, no corpo?',
   50, 'milhares de fusos musculares', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('A dor na pele é detectada por terminações nervosas especializadas, espalhadas por toda a superfície do corpo. Quantos milhares desses receptores de dor existem só na pele?',
   200, 'milhares de receptores', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('Além de detectar toque e dor, a pele também tem receptores dedicados só a sentir frio e calor. Quantos milhares desses receptores térmicos existem, ao todo, na pele?',
   250, 'milhares de receptores', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),

-- Família 6: semana de gestação em que um marco do desenvolvimento fetal acontece
  ('Bem no início da gravidez, antes mesmo de a maioria das pessoas descobrir que está grávida, o coração do embrião já começa a se formar e bater. Em que semana de gestação isso acontece?',
   6, 'semanas', 'corpo-humano', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('As linhas únicas que formam a impressão digital de cada pessoa aparecem ainda dentro do útero, bem cedo na gravidez. Em que semana de gestação elas já estão totalmente formadas?',
   13, 'semanas', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('Muito antes de nascer, o feto já reage a sons vindos de fora do corpo da mãe. A partir de que semana de gestação essa audição já funciona?',
   18, 'semanas', 'corpo-humano', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('Durante boa parte da gravidez, as pálpebras do feto ficam seladas, protegendo os olhos ainda em formação. Em que semana de gestação elas se abrem pela primeira vez?',
   28, 'semanas', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O paladar do feto começa a se desenvolver bem antes do nascimento, através do líquido amniótico que ele engole. Em que semana de gestação as papilas gustativas já estão funcionando?',
   14, 'semanas', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('No começo da gravidez o feto já se mexe, mas os movimentos são fracos demais pra mãe perceber. Em que semana de gestação, em média, ela começa a sentir os primeiros chutes?',
   18, 'semanas', 'corpo-humano', 1, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('Bebês que nascem cedo demais costumam ter dificuldade para respirar, porque os pulmões ainda não produzem uma substância essencial para eles não colabarem. A partir de que semana de gestação essa produção já é suficiente, mesmo em caso de parto prematuro?',
   34, 'semanas', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('Um dos reflexos que o bebê precisa ter pronto assim que nasce é o de sugar, essencial pra mamar. Em que semana de gestação esse reflexo aparece no feto?',
   32, 'semanas', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('Nas primeiras semanas de gravidez, os órgãos genitais do feto ainda não são diferenciados o suficiente para aparecer num ultrassom comum. A partir de que semana de gestação isso já costuma ser possível?',
   14, 'semanas', 'corpo-humano', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O cérebro do feto começa a mostrar atividade elétrica organizada muito antes do que a maioria imagina. Em que semana de gestação essa atividade já é mensurável?',
   6, 'semanas', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),

-- Família 7: número de genes/variantes associados a uma característica, segundo estudos GWAS
  ('Por muito tempo se ensinou que a cor dos olhos era definida por um único gene, numa herança simples. Estudos genômicos recentes já associaram quantos genes diferentes a essa característica?',
   16, 'genes', 'corpo-humano', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('A altura de uma pessoa não depende de um único gene, mas da soma de efeitos pequenos de muitos genes diferentes. Quantos genes/variantes já foram associados a essa característica, segundo estudos genômicos amplos?',
   700, 'genes', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('A calvície que atinge boa parte dos homens ao longo da vida tem forte componente genético, espalhado por várias regiões do DNA. Quantos genes/variantes já foram associados a essa característica?',
   200, 'genes', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('A enxaqueca crônica tem influência genética significativa, identificada em estudos com milhares de pacientes. Quantos genes/variantes já foram associados a essa condição?',
   40, 'genes', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O peso corporal tem influência genética real, além de hábitos e ambiente, distribuída por muitas regiões do genoma. Quantos genes/variantes já foram associados à obesidade em estudos genômicos amplos?',
   100, 'genes', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O diabetes tipo 2 é uma das condições mais estudadas geneticamente, por afetar tanta gente no mundo. Quantos genes/variantes já foram associados a essa condição?',
   400, 'genes', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('A depressão maior tem componente genético comprovado, embora nenhum gene isolado a explique sozinho. Quantos genes/variantes já foram associados a essa condição em estudos recentes?',
   180, 'genes', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O espectro autista tem uma das arquiteturas genéticas mais complexas já estudadas, envolvendo dezenas de regiões do DNA. Quantos genes/variantes já foram associados a essa condição?',
   100, 'genes', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('A esquizofrenia é uma das condições psiquiátricas com maior número de variantes genéticas já mapeadas. Quantos genes/variantes já foram associados a essa condição?',
   270, 'genes', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('Curiosamente, até o nível de escolaridade que uma pessoa alcança tem um componente genético mensurável, associado a centenas de variantes espalhadas pelo DNA. Quantos genes/variantes já foram associados a essa característica?',
   1000, 'genes', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),

-- Família 8: composição corporal — massa de uma substância/tecido no corpo de um adulto médio (70 kg)
  ('Boa parte do peso de uma pessoa não é músculo nem gordura, é água distribuída por todo o corpo. Quantos quilos de água, em média, tem o corpo de um adulto de 70 kg?',
   42, 'quilogramas', 'corpo-humano', 1, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O esqueleto inteiro pesa bem menos do que a maioria imagina, mesmo sustentando o corpo todo. Quantos quilos, em média, pesa o esqueleto seco de um adulto de 70 kg?',
   9, 'quilogramas', 'corpo-humano', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('Os músculos que a gente controla conscientemente formam a maior fatia de tecido do corpo. Quantos quilos, em média, tem de massa muscular esquelética um adulto de 70 kg?',
   28, 'quilogramas', 'corpo-humano', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('Mesmo numa pessoa com percentual de gordura considerado saudável, uma fatia real do peso corporal ainda é gordura. Quantos quilos de gordura, em média, tem um adulto de 70 kg com percentual de gordura médio?',
   14, 'quilogramas', 'corpo-humano', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('A pele costuma ser chamada de maior órgão do corpo, mas seu peso real surpreende. Quantos quilos, em média, pesa toda a pele de um adulto de 70 kg?',
   4, 'quilogramas', 'corpo-humano', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O colágeno é a proteína mais abundante do corpo humano, presente em pele, tendões, ossos e vasos sanguíneos. Quantos quilos de colágeno, em média, tem o corpo de um adulto de 70 kg?',
   2, 'quilogramas', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('A queratina forma a camada externa da pele, além do cabelo e das unhas inteiros. Quantos quilos de queratina, em média, tem o corpo de um adulto?',
   2, 'quilogramas', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('Quase todo o cálcio do corpo fica guardado dentro dos ossos e dentes. Quantos gramas de cálcio, ao todo, tem o corpo de um adulto de 70 kg?',
   1000, 'gramas', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O ferro do corpo fica majoritariamente dentro da hemoglobina, a proteína que carrega oxigênio no sangue. Quantos gramas de ferro, ao todo, tem o corpo de um adulto?',
   4, 'gramas', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O corpo produz a maior parte do colesterol que usa, sem precisar da alimentação. Quantos gramas de colesterol, ao todo, tem armazenados no corpo um adulto médio?',
   100, 'gramas', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),

-- Família 9: microbioma humano — fatos e contagens
  ('Por décadas se repetiu que o corpo humano tinha dez vezes mais bactérias do que células próprias, mas estudos mais recentes recalcularam essa conta. Quantos trilhões de bactérias, aproximadamente, vivem hoje no corpo de um adulto?',
   38, 'trilhões de bactérias', 'corpo-humano', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O intestino humano abriga uma das comunidades bacterianas mais diversas do corpo. Quantas espécies diferentes de bactéria, aproximadamente, já foram identificadas vivendo aí?',
   1000, 'espécies', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O genoma humano tem uma quantidade limitada de genes, mas as bactérias que vivem dentro do intestino somam muito mais genes do que isso. Quantos milhões de genes, aproximadamente, tem o microbioma intestinal somado?',
   3, 'milhões de genes', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('A boca é um dos ambientes do corpo com maior concentração de bactérias, favorecida pela umidade e temperatura constantes. Quantos bilhões de bactérias, aproximadamente, vivem numa boca humana normal?',
   20, 'bilhões de bactérias', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('Quase todo mundo carrega, sem perceber, minúsculos ácaros microscópicos vivendo dentro dos folículos capilares do rosto. Quantos milhares desses ácaros, em média, vivem no rosto de um adulto?',
   1, 'milhares de ácaros', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('Além de bactérias, a pele também hospeda uma comunidade de fungos microscópicos, chamada de micobioma. Quantas espécies diferentes de fungo, aproximadamente, já foram identificadas na pele humana?',
   80, 'espécies', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('Além das bactérias, o corpo também carrega uma quantidade enorme de vírus, boa parte deles inofensivos e até úteis, incluindo vírus que infectam as próprias bactérias. Quantos trilhões de partículas virais, aproximadamente, existem no corpo humano?',
   380, 'trilhões de vírus', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('Um tratamento forte com antibióticos não mata só a bactéria causadora da infecção, derruba também boa parte da comunidade bacteriana saudável do intestino. Quantos dias, em média, leva para esse microbioma se recompor depois de um tratamento assim?',
   180, 'dias', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('Boa parte do peso das fezes não é resto de comida não digerida, é a própria massa de bactérias, vivas e mortas. Que porcentagem do peso das fezes, aproximadamente, é composta por bactérias?',
   50, '%', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('Um estudo holandês famoso mediu quantas bactérias diferentes duas pessoas trocam ao se beijar. Quantos milhões de bactérias, em média, são transferidas num beijo de 10 segundos?',
   80, 'milhões de bactérias', 'corpo-humano', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),

-- Família 10: meia-vida de substâncias no sangue, em minutos
  ('Depois de uma xícara de café, a cafeína não some do sangue de uma vez, ela vai caindo aos poucos. Quantos minutos leva, em média, para a concentração de cafeína no sangue cair pela metade?',
   300, 'minutos', 'corpo-humano', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O paracetamol é um dos analgésicos mais usados no mundo, e o corpo o elimina do sangue num ritmo relativamente previsível. Quantos minutos leva, em média, para a concentração dele no sangue cair pela metade?',
   120, 'minutos', 'corpo-humano', 2, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('Como é uma vitamina solúvel em água, o corpo não consegue estocar vitamina C por muito tempo, precisando repor via alimentação com frequência. Quantos minutos leva, em média, para a concentração dela no sangue cair pela metade?',
   960, 'minutos', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('O cortisol é o hormônio que o corpo libera em resposta ao estresse, e sua concentração no sangue muda rápido ao longo do dia. Quantos minutos leva, em média, para a concentração dele no sangue cair pela metade?',
   70, 'minutos', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('A adrenalina é liberada em situações de perigo ou emoção intensa, e some da corrente sanguínea quase tão rápido quanto aparece. Quantos minutos leva, em média, para a concentração dela no sangue cair pela metade?',
   2, 'minutos', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('A insulina precisa agir rápido para controlar o açúcar no sangue depois de uma refeição, e por isso também desaparece rápido da circulação. Quantos minutos leva, em média, para a concentração dela no sangue cair pela metade?',
   5, 'minutos', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('A testosterona circula no sangue tanto ligada a proteínas quanto livre, e é a fração livre que desaparece mais rápido. Quantos minutos leva, em média, para a concentração da testosterona livre no sangue cair pela metade?',
   10, 'minutos', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('A melatonina é o hormônio que o corpo libera à noite para induzir o sono, e sua concentração no sangue cai relativamente rápido depois do pico noturno. Quantos minutos leva, em média, para a concentração dela no sangue cair pela metade?',
   45, 'minutos', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('Depois de uma dose de bebida alcoólica, o fígado processa o álcool num ritmo praticamente constante. Quantos minutos leva, em média, para o corpo processar uma dose padrão de álcool?',
   60, 'minutos', 'corpo-humano', 1, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending'),
  ('A penicilina é um dos antibióticos mais antigos e conhecidos do mundo, e também é eliminada do sangue relativamente rápido pelos rins. Quantos minutos leva, em média, para a concentração dela no sangue cair pela metade?',
   60, 'minutos', 'corpo-humano', 3, 'NÃO VERIFICADO — número candidato, pendente de curadoria', 'pending://sem-fonte-verificada', 2023, 'pending');
