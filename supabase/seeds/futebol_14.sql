-- Onda 14 do tópico futebol — lote enxuto (3 perguntas), moldes inéditos no banco: gols de falta
-- direta na carreira (nunca tocado — os lotes de "gols na carreira" até aqui sempre foram gols em
-- geral, de atacante ou goleiro), finais de Copa Libertadores disputadas por um clube (distinto de
-- "maior campeão" já usado no lote 6 — aqui a métrica é participação em decisões, vitoriosas ou
-- não) e distância percorrida numa partida de Copa do Mundo (desempenho físico, nunca tocado —
-- todos os recordes físicos até aqui eram sobre gols, cartões ou jogos).
--
-- Removida na revisão da sessão principal: "Alberto Suppici, técnico mais jovem já campeão de Copa
-- do Mundo" (31 anos, Rádio Itatiaia) — mesmo fato-base já pesquisado e reprovado no lote 12 por
-- divergência irreconciliável entre fontes tier 1 (FIFA Museum diz 36 anos; aritmética a partir da
-- data de nascimento de 1898 dá 31 ou 32, dependendo de já ter feito aniversário em julho de 1930).
-- O agente deste lote 14 não conferiu os descartes específicos do lote 12 antes de pesquisar o
-- mesmo candidato de novo — reprovado de novo aqui, mantendo a decisão anterior.
--
-- Candidato descartado antes de pesquisar a fundo: "goleiro com mais pênaltis defendidos na
-- carreira" e "seleção que mais sofreu gols numa única edição de Copa do Mundo" — o lote já tinha
-- perguntas aprovadas com gancho seguro quando o orçamento de busca da sessão se esgotou; ambos
-- ficam como ideia para uma leva futura, não descartados por mérito.
--
-- Já nasce 'approved': cada pergunta foi pesquisada e a fonte verificada no momento de ser escrita
-- (mesmo processo do curador-perguntas + skill achometro-perguntas). Sem fonte travada única pro
-- lote — cada assunto buscou sua própria fonte pela hierarquia (oficial > agregador consolidado >
-- imprensa de referência).
insert into public.questions
  (prompt, answer, unit, theme, difficulty, source_name, source_url, as_of_year, status)
values
  ('Um batedor de falta talentoso marca uma dezena de gols de bola parada ao longo de toda a carreira, quando muito. Mas o brasileiro Juninho Pernambucano, que jogou por Vasco e Olympique Lyonnais, superou até Pelé nesse quesito específico, segundo levantamento do jornal espanhol As. Quantos gols de falta direta ele marcou ao todo na carreira?',
   77, 'gols de falta', 'futebol', 3,
   'ESPN Brasil (citando levantamento do jornal As) — "Juninho crava que bateu mais falta do que Zico e Neymar"',
   'https://www.espn.com.br/futebol/artigo/_/id/14102945/juninho-pernambucano-bateu-mais-falta-que-zico-e-neymar-se-coloca-abaixo-de-tres-veja-quais',
   2019, 'approved'),
  ('Um clube sul-americano tradicional participa de uma final de Libertadores a cada muitas edições, quando participa. Mas o Boca Juniors, da Argentina, é o clube que mais vezes chegou à decisão da competição ao longo da história, à frente até do Peñarol uruguaio. Quantas finais de Libertadores o clube argentino já disputou, contando até a edição de 2025?',
   12, 'finais', 'futebol', 2,
   'Diário do Futebol — "Clubes com mais finais de Libertadores disputadas: o ranking"',
   'https://www.diariodofutebol.com.br/historia-do-futebol/clubes-com-mais-finais-de-libertadores',
   2025, 'approved'),
  ('Num jogo de Copa do Mundo, um meio-campista costuma correr entre 10 e 12 km, mesmo numa partida disputada até o fim. Mas o croata Marcelo Brozovic bateu o próprio recorde histórico do torneio ao correr muito mais que isso numa partida contra o Japão, em 2022, decidida na prorrogação. Quantos quilômetros ele percorreu nesse jogo, arredondando para o quilômetro mais próximo?',
   17, 'km', 'futebol', 3,
   'Goal.com Brasil — "O recorde de Brozovic: jogador da Croácia é o que mais correu em uma partida de Copa do Mundo"',
   'https://www.goal.com/br/not%C3%ADcias/o-recorde-de-brozovic-jogador-da-croacia-e-o-que-mais-correu-em-uma-partida-de-copa-do-mundo/bltf89ac65e1cfe52f2',
   2022, 'approved');
