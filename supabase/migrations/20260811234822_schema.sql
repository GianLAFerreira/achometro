-- Achômetro — schema base.
-- Identidade: player_id = auth.uid() de uma sessão de login anônimo do Supabase
-- (signInAnonymously). Ver CLAUDE.md, regra 2, para o porquê.

create extension if not exists pgcrypto;

-- ─────────────────────────────────────────────────────────────────────────
-- questions: banco curado de perguntas. Nunca lido diretamente pelo cliente
-- (sem grant de SELECT para anon/authenticated) — só via função SECURITY
-- DEFINER, para o gabarito nunca escapar antes da revelação.
-- ─────────────────────────────────────────────────────────────────────────
create table public.questions (
  id            uuid primary key default gen_random_uuid(),
  prompt        text not null,
  answer        numeric not null,
  unit          text,
  theme         text not null,
  difficulty    smallint not null default 2 check (difficulty between 1 and 3),
  source_name   text not null,
  source_url    text not null,
  as_of_year    smallint not null,
  status        text not null default 'approved'
                  check (status in ('approved', 'pending', 'rejected')),
  created_at    timestamptz not null default now()
);

create index questions_theme_status_idx on public.questions (theme, status);

-- ─────────────────────────────────────────────────────────────────────────
-- rooms
-- ─────────────────────────────────────────────────────────────────────────
create table public.rooms (
  id              uuid primary key default gen_random_uuid(),
  code            text not null unique,
  host_player_id  uuid not null,
  themes          text[] not null default '{}',
  rounds_total    smallint not null default 10
                    check (rounds_total > 0 and rounds_total <= 50),
  answer_seconds  smallint not null default 45
                    check (answer_seconds >= 5 and answer_seconds <= 300),
  status          text not null default 'lobby'
                    check (status in ('lobby', 'playing', 'finished')),
  created_at      timestamptz not null default now(),
  expires_at      timestamptz not null default (now() + interval '24 hours')
);

create index rooms_expires_at_idx on public.rooms (expires_at);

-- ─────────────────────────────────────────────────────────────────────────
-- players — uma linha por (sala, pessoa). O mesmo auth.uid() pode ter uma
-- linha em várias salas ao longo do tempo, por isso a PK é composta.
-- ─────────────────────────────────────────────────────────────────────────
create table public.players (
  id            uuid not null,
  room_id       uuid not null references public.rooms (id) on delete cascade,
  nickname      text not null check (char_length(nickname) between 1 and 16),
  score         integer not null default 0,
  joined_at     timestamptz not null default now(),
  last_seen_at  timestamptz not null default now(),
  primary key (room_id, id)
);

create index players_id_idx on public.players (id);

alter table public.rooms
  add constraint rooms_host_player_fk
  foreign key (id, host_player_id) references public.players (room_id, id)
  deferrable initially deferred;
-- ordem das colunas tem que casar com a PK composta de players (room_id, id):
-- rooms.id -> players.room_id, rooms.host_player_id -> players.id.
-- deferrable: create_room insere a sala e o jogador-host na mesma transação;
-- a FK só é checada no commit, então a ordem de inserção não importa.

-- ─────────────────────────────────────────────────────────────────────────
-- rounds — o prompt/unidade/tema da pergunta são copiados aqui no início da
-- rodada (denormalização deliberada): a rodada fica imutável mesmo que a
-- pergunta original seja editada depois, e o cliente nunca precisa ler
-- `questions` diretamente. Os campos `revealed_*` ficam NULL enquanto a
-- rodada está aberta e só são preenchidos por `close_round` — é isso que
-- permite uma única política de SELECT em `rounds` sem vazar o gabarito.
-- ─────────────────────────────────────────────────────────────────────────
create table public.rounds (
  id                    uuid primary key default gen_random_uuid(),
  room_id               uuid not null references public.rooms (id) on delete cascade,
  question_id           uuid not null references public.questions (id),
  index                 smallint not null,
  question_prompt       text not null,
  question_unit         text,
  question_theme        text not null,
  status                text not null default 'open'
                          check (status in ('open', 'closed')),
  started_at            timestamptz not null default now(),
  ends_at               timestamptz not null,
  closed_at             timestamptz,
  revealed_answer       numeric,
  revealed_source_name  text,
  revealed_source_url   text,
  revealed_as_of_year   smallint,
  unique (room_id, index)
);

create index rounds_room_id_idx on public.rounds (room_id);

-- ─────────────────────────────────────────────────────────────────────────
-- answers
-- ─────────────────────────────────────────────────────────────────────────
create table public.answers (
  round_id      uuid not null references public.rounds (id) on delete cascade,
  player_id     uuid not null,
  value         numeric not null,
  submitted_at  timestamptz not null default now(),
  primary key (round_id, player_id)
);

-- ─────────────────────────────────────────────────────────────────────────
-- question_seen — sobrevive à sala (sem FK para rooms/players/rounds).
-- É o que impede a mesma pergunta de reaparecer para quem já a viu, mesmo
-- depois que a sala expirar e for apagada pelo TTL.
-- ─────────────────────────────────────────────────────────────────────────
create table public.question_seen (
  player_id    uuid not null,
  question_id  uuid not null references public.questions (id) on delete cascade,
  seen_at      timestamptz not null default now(),
  primary key (player_id, question_id)
);

create index question_seen_player_id_idx on public.question_seen (player_id);
