# Documentação do Achômetro

Esta pasta documenta a **estrutura** do projeto — pastas, arquivos, schema do banco, fluxo de
jogo. Para as regras que não se quebram, o stack e o porquê de cada escolha, ver `CLAUDE.md` na
raiz do repo — ele é a fonte de verdade para *decisão de produto e arquitetura*; aqui é a
referência de *onde as coisas estão e como se encaixam*.

- [`estrutura-de-pastas.md`](./estrutura-de-pastas.md) — mapa de pastas e arquivos, cliente e
  banco.
- [`arquitetura.md`](./arquitetura.md) — como cliente, banco e Realtime se falam, e por que o
  cliente nunca é autoridade.
- [`banco-de-dados.md`](./banco-de-dados.md) — tabelas, funções RPC, RLS e a limpeza por TTL,
  refletindo o estado atual das migrations.
- [`fluxo-de-jogo.md`](./fluxo-de-jogo.md) — o ciclo de vida de uma sala e de uma rodada, tela por
  tela.

Estes documentos descrevem o estado do código nas migrations e arquivos existentes no momento em
que foram escritos (2026-09-06). Quando uma migration nova mudar uma tabela, função ou regra
citada aqui, atualizar o trecho correspondente — não é um documento "escreva uma vez e esqueça".
