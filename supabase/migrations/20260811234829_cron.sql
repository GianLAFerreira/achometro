-- Achômetro — TTL. Salas com mais de 24h (rooms.expires_at) são apagadas;
-- players/rounds/answers vão junto via ON DELETE CASCADE. question_seen
-- não tem FK pra rooms de propósito — precisa sobreviver à sala pra o
-- dedupe de perguntas continuar funcionando depois que ela expirar.

create extension if not exists pg_cron;

select cron.schedule(
  'achometro-room-ttl-cleanup',
  '*/30 * * * *', -- a cada 30 minutos
  $$ delete from public.rooms where expires_at < now(); $$
);
