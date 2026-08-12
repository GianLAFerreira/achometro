-- Decisão de produto: gabaritos são sempre número inteiro (facilita palpite e leitura no
-- mostrador). Reforça isso no banco, não só na curadoria manual do seed.
alter table public.questions
  add constraint questions_answer_integer_check check (answer = trunc(answer));
