# Banco de dados

Reflete o estado depois de todas as migrations em `supabase/migrations/` (ordem cronológica pelo
nome do arquivo). Nunca editar uma migration já aplicada — corrigir é criar uma nova (`CLAUDE.md`,
regra 9); então este documento também muda por adição, não por reescrita de uma seção antiga.

## Tabelas

### `questions`

Banco curado de perguntas. **Nunca lida diretamente pelo cliente** — sem `GRANT` nenhum, nem RLS
policy, para `anon` ou `authenticated`. Só uma função `SECURITY DEFINER` (`start_round`) consegue
ler o gabarito antes da revelação.

| Coluna | Tipo | Observação |
|---|---|---|
| `id` | uuid | PK |
| `prompt` | text | texto da pergunta (forma definida na skill `achometro-perguntas`) |
| `answer` | numeric | sempre inteiro (`check (answer = trunc(answer))`) |
| `unit` | text | livre, convenção: plural minúsculo sem ponto |
| `theme` | text | taxonomia fechada por convenção, espelhada em `src/lib/topics.ts` — **não há CHECK no banco**, um tema inventado aqui não dá erro, só nunca é sorteado |
| `difficulty` | smallint | 1–3, deliberadamente sem definição escrita |
| `source_name`, `source_url`, `as_of_year` | text, text, smallint | citação da fonte, revelada ao final da rodada |
| `status` | text | `approved` \| `pending` \| `rejected` — só `approved` é sorteável por `start_round` |

Índice `(theme, status)` — é exatamente o par que o `start_round` filtra.

### `rooms`

| Coluna | Tipo | Observação |
|---|---|---|
| `id` | uuid | PK |
| `code` | text | único, 6 caracteres, alfabeto sem `O`/`0`/`I`/`1` (evita confusão ao ditar em voz alta) |
| `host_player_id` | uuid | FK composta para `players (room_id, id)`, deferrable — permite inserir sala e host-jogador na mesma transação |
| `themes` | text[] | `{}` = qualquer tema (todo o pool de `approved`); não é um valor de tema, é ausência de filtro |
| `rounds_total` | smallint | 1–50, default 10 |
| `answer_seconds` | smallint | 5–300, default 20 |
| `pause_seconds` | smallint | 3–60, default 10 — pausa de revelação entre rodadas |
| `target_score` | smallint | 1–100, default 5 — pontuação que encerra a partida antes de `rounds_total`, se atingida antes |
| `status` | text | `lobby` \| `playing` \| `finished` \| `abandoned` |
| `winner_player_id` | uuid | preenchido por `close_round` nas vias de "sobrevivente único" e "pontuação-alvo"; sem FK (só informativo pra UI) |
| `expires_at` | timestamptz | `created_at + 24h`, o que o TTL usa para apagar |

### `players`

PK composta `(room_id, id)` — o mesmo `auth.uid()` pode ter uma linha por sala em que já esteve,
ao longo do tempo. `score` e `missed_streak` (faltas seguidas, incrementada por `close_round` para
quem não respondeu) vivem aqui; "ativo" é `missed_streak < 2`, decidido inteiramente no servidor —
não existe uma segunda coluna de "está ativo" para não arriscar dessincronizar.

### `rounds`

O `prompt`/`unit`/`theme` da pergunta são **copiados** para cá no início da rodada (denormalização
deliberada): a rodada fica imutável mesmo que a pergunta original seja editada depois, e o cliente
nunca precisa ler `questions` diretamente. Os campos `revealed_*` ficam `NULL` enquanto
`status = 'open'` e só são preenchidos por `close_round` — é isso que permite uma única RLS policy
de SELECT sem precisar saber se a rodada está aberta ou fechada (o gabarito simplesmente não está
lá ainda).

### `answers`

PK composta `(round_id, player_id)` — uma segunda tentativa de responder é rejeitada pela própria
constraint (`unique_violation`, mapeado para `already_answered` por `submit_answer`).

### `question_seen`

PK composta `(player_id, question_id)`, **sem FK para `rooms`/`players`/`rounds`** de propósito —
precisa sobreviver à sala para o dedupe de perguntas continuar funcionando depois que ela expirar
e for apagada pelo TTL.

## Funções RPC (`SECURITY DEFINER`)

Todas em `supabase/migrations/*_functions.sql` (com reescritas posteriores em migrations
seguintes — este documento descreve o comportamento **atual**, já com as reescritas aplicadas).
Regra comum a todas: usam `auth.uid()` internamente, nunca um `player_id` vindo como parâmetro (um
parâmetro pode ser forjado pelo chamador, `auth.uid()` não pode — vem do JWT verificado da sessão
anônima), e todas fixam `set search_path = public, pg_temp` (obrigatório para `SECURITY DEFINER`,
senão um `search_path` malicioso na sessão do chamador poderia redirecionar a função para objetos
de outro schema).

| Função | Quem pode chamar | O que faz |
|---|---|---|
| `create_room(nickname, themes, rounds_total, answer_seconds, pause_seconds, target_score)` | qualquer sessão autenticada | Cria a sala com um código de 6 letras único (até 20 tentativas) e insere o próprio chamador como primeiro jogador (host). |
| `join_room(room_code, nickname)` | idem | Idempotente: entrar de novo na mesma sala só atualiza apelido e `last_seen_at`, não duplica a linha (`on conflict do update`). Recusa sala `finished`. |
| `peek_room(room_code)` | idem | Só o veredito (`ok`/`not_found`/`finished`/`abandoned`/`empty`), nunca dados da sala — permite checar um código antes de pedir o apelido, sem o efeito colateral de `join_room` (que já coloca o chamador dentro da sala). |
| `start_round(room_id)` | host, para sair do lobby; qualquer membro, para avançar entre rodadas depois da pausa | Escolhe uma pergunta `approved` do(s) tema(s) da sala que ninguém na sala ainda viu (`question_seen`); se o pool esgotou para esta sala, cai para a pergunta vista por *menos* gente da sala em vez de travar a partida. Recusa sala `finished`/`abandoned`, recusa avançar antes do fim de `pause_seconds`. |
| `submit_answer(round_id, value)` | membro da sala da rodada | Grava o palpite. A PK composta de `answers` rejeita naturalmente uma segunda tentativa. Zera o próprio `missed_streak` do jogador ao responder. |
| `close_round(round_id)` | host, a qualquer momento; qualquer membro, só depois de `ends_at` | Calcula pontos por erro relativo (`\|palpite − gabarito\| / \|gabarito\|`; ver fórmula abaixo), incrementa `missed_streak` de quem não respondeu, revela o gabarito, e decide se a sala termina (quatro vias, ver abaixo). Idempotente: fechar de novo retorna a rodada já fechada em vez de pontuar duas vezes. |
| `server_now()` | idem | Devolve `now()` do servidor — o cliente usa uma vez no boot para medir o offset entre seu relógio e o do servidor (`src/lib/clock.ts`). |
| `is_room_member(room_id)`, `can_read_answer(round_id)` | uso interno das RLS policies | Funções auxiliares `SECURITY DEFINER` que isolam o lookup de pertencimento — necessário para evitar recursão infinita de uma policy que faria `EXISTS` na própria tabela dentro do seu `USING`. |

### Pontuação (dentro de `close_round`)

Por jogador que respondeu, erro relativo = `abs(valor − gabarito) / abs(gabarito)` (ou
`abs(valor)` se o gabarito for `0`). Quem tem o **menor** erro relativo da rodada ganha 1 ponto;
quem cravar o valor exato ganha 2. Empate no menor erro pontua todo mundo empatado — não há
critério de desempate por ordem de chegada. "Cravar" exige valor exato, sem faixa de tolerância —
decisão de produto aceita conscientemente: em gabaritos grandes (frota de veículos, população de
cidade) ninguém crava nunca; o bônus de 2 pontos só é alcançável de fato em perguntas de número
pequeno.

### As quatro vias de fim de partida (`close_round`, em ordem de checagem)

1. **Zero jogadores ativos** (todos com `missed_streak >= 2`) → sala `abandoned`.
2. **Sobrou exatamente 1 jogador ativo**, e a sala tinha mais de 1 → sala `finished`,
   `winner_player_id` = o sobrevivente.
3. **Um único líder estrito atingiu `target_score`** → sala `finished`, `winner_player_id` = o
   líder. Empate no topo *não* dispara esta via de propósito — a partida segue até desempatar.
4. **Última rodada** (`index + 1 >= rounds_total`) → sala `finished`, sem vencedor definido aqui
   (o cliente decide como exibir empate no placar final).

## RLS — nega por padrão, abre só o necessário

Modelo de identidade: todo acesso passa por login anônimo (`authenticated` com `auth.uid()`
verificável). Não existe papel `anon` com privilégio nenhum neste projeto — sem sessão, mesmo
anônima, zero acesso. `GRANT SELECT` é dado a `authenticated` em `rooms`, `players`, `rounds`,
`answers`, `question_seen` (nunca em `questions`); RLS então restringe *o que aquele GRANT já
permitiu* — sem o GRANT, toda leitura falharia com "permission denied" antes mesmo do Postgres
avaliar qualquer policy.

| Tabela | Policy de SELECT | Regra |
|---|---|---|
| `rooms` | `rooms_select_member` | visível só para quem tem uma linha em `players` para essa sala |
| `players` | `players_select_roommates` | vejo todo mundo que está na(s) mesma(s) sala(s) que eu |
| `rounds` | `rounds_select_member` | mesma regra de pertencimento; o gabarito some sozinho porque `revealed_*` é `NULL` até `close_round` |
| `answers` | `answers_select_closed_and_member` | **a política que mais importa do projeto** — só true se a rodada estiver `closed` E eu for membro da sala; faltando qualquer uma das duas, o palpite de outro jogador vazaria antes da hora ou para gente de fora da sala |
| `question_seen` | `question_seen_select_own` | só a própria linha (`player_id = auth.uid()`) |

Nenhuma tabela tem policy de INSERT/UPDATE/DELETE — toda escrita passa pelas funções
`SECURITY DEFINER` acima. `TRUNCATE`/`REFERENCES`/`TRIGGER`/`MAINTAIN`, concedidos por padrão pelo
Supabase a `anon`/`authenticated` em toda tabela nova, são revogados explicitamente (RLS não
filtra `TRUNCATE` — limitação conhecida do Postgres, não bug daqui).

## Limpeza (TTL)

`pg_cron` roda `delete from public.rooms where expires_at < now()` a cada 30 minutos. `players`,
`rounds`, `answers` são apagados junto via `ON DELETE CASCADE`. `question_seen` sobrevive de
propósito (sem FK para `rooms`), para o dedupe de perguntas continuar valendo mesmo depois que a
sala que gerou aquele registro já foi apagada.

## Realtime

Publicação `supabase_realtime` inclui `rooms`, `players`, `rounds`. `answers` fica **fora** de
propósito — defesa em profundidade da regra 4 do `CLAUDE.md`: mesmo que a avaliação de RLS do
Realtime tivesse alguma falha, o palpite de outro jogador nunca sairia do banco com a rodada
aberta.
