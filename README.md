# Achômetro

> O medidor oficial do seu achismo.

Jogo de palpite numérico multiplayer. Um host cria a sala, cada jogador entra pelo próprio
celular, aparece uma pergunta ("quantos ossos tem o corpo humano?") e quem chega mais perto do
valor real pontua.

**Status: em construção — Fase 0 (scaffold).** Ainda não é jogável.

## Postura de privacidade

Sem cadastro, sem e-mail, sem senha. Cada jogador é um apelido + um código gerado no próprio
navegador — limpar o navegador é virar outra pessoa. Salas e respostas são apagadas depois de
24h. Ver `CLAUDE.md` para as regras completas.

## Stack

Vite + React + TypeScript + Tailwind CSS v4 no cliente · Supabase (Postgres + Realtime + RLS)
como backend, com a lógica de jogo inteira em funções Postgres — nada de regra de pontuação
correndo no navegador. Detalhe e motivação de cada peça em `CLAUDE.md`.

## Rodar localmente

```bash
npm install
npm run dev
```

Requer Node.js 22+. A parte de banco (Supabase local via Docker) entra a partir da Fase 1.

## Licença

MIT.
