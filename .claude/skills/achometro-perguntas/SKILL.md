---
name: achometro-perguntas
description: Guia de redação das perguntas do Achômetro — a forma âncora + pergunta, o que conta como "divertida", e as convenções de unit/theme/difficulty. Carregar sempre que perguntas do banco forem escritas, curadas ou revisadas.
---

# Redação das perguntas — Achômetro

Isto rege o texto que vai em `questions.prompt` (e os campos vizinhos `unit`, `theme`,
`difficulty`). **Não é a voz da interface** — ver `achometro-design` para a copy de botões, estados
e mensagens do app (`Cravar palpite`, `Aferindo`, etc.). Ali o aparelho é seco e não se desculpa; a
pergunta pode ter mais cor — é ela que carrega a curiosidade que faz alguém parar pra pensar.

Este guia serve a dois papéis: quem escreve pergunta nova e quem a valida
(`.claude/agents/curador-perguntas.md`, que aplica o critério 4 — "divertida" — usando a régua
daqui).

## A âncora: dois testes, não uma regra absoluta

Âncora é a frase de contexto que abre a pergunta, antes do numeral. Forma, quando ela existe:

```
<contexto curto que dá a escala>. <pergunta numérica direta>?
```

Ela **não é obrigatória em toda pergunta**. Existe pra sustentar o critério 3 do curador
(estimável por raciocínio, não sorte pura) só quando o sujeito sozinho não dá essa base — forçar
âncora onde ela não faz falta piora a pergunta, não melhora.

### Teste 1 — necessidade

*O jogador consegue situar a ordem de grandeza só lendo o sujeito?* Se sim, não force âncora.

- **Dispensa âncora** (sujeito autoexplicativo): "Qual a distância em linha reta entre Macapá (AP)
  e Passo Fundo (RS)?" — as siglas de estado já dizem norte-a-sul do Brasil; não sobra nada de
  útil pra uma frase de contexto acrescentar.
- **Exige âncora** (sujeito obscuro): "O Tocantins é um dos estados mais novos do Brasil (criado
  em 1988) e tem população relativamente pequena. Quantos municípios você acha que ele tem?" —
  sem isso ninguém tem de onde partir.

### Teste 2 — tamanho

Quando a âncora entra, ela é **uma oração curta**, nunca uma frase explicativa.

- **Padrão** (uma oração, informação que ancora e nada mais): "Léo Moura jogou mais de 20 anos
  como lateral, boa parte no Flamengo. Quantos cartões vermelhos ele levou na carreira?"
- **Proibido** (frase explicativa, mais contexto do que o necessário — exemplo real do que já foi
  escrito e teve que ser revertido): "O Brasil é um país continental com malha ferroviária de
  passageiros quase inexistente, o que faz do carro o meio de transporte dominante. Quantos
  veículos — carros, motos, caminhões etc. — formam a frota total do país?"

O que a âncora, quando existe, precisa entregar: uma referência de grandeza que o jogador consiga
usar de fato — tempo de carreira, ano de criação, porte relativo. Não é trivia decorativa, e não
pode entregar a resposta de bandeja.

### Nunca fazer retrofit

Esta regra vale para pergunta **nova**. Não retrofitar âncora em pergunta que já está no banco e
funciona seca — isso já foi tentado no lote 1 (`supabase/seed.sql`) e revertido: a pergunta piora,
não melhora. Pergunta existente só muda se o curador achar um problema real nela (fonte, número,
factualidade da âncora que já tem) — nunca só pra encaixar no padrão.

## O critério "divertida", com régua

É o critério mais subjetivo do curador e o que mais importa pro produto. Uma pergunta pode passar
nos outros três critérios e ainda ser morna — isso reprova.

**Conta como gancho de diversão:**
- Comparação inesperada (duas coisas que ninguém pensaria em colocar lado a lado)
- Número contraintuitivo (a resposta provável surpreende quem acerta o palpite por perto)
- Assunto que puxa debate de mesa — alguém vai discordar do palpite do outro em voz alta

**Conta como morna (mesmo com fonte e número certos):**
- Pergunta correta, bem ancorada, mas cujo resultado não gera reação nenhuma — ninguém questiona,
  ninguém se surpreende, o grupo segue pra próxima rodada em silêncio.

## Convenções de campo

- **`unit`** — string livre no schema, sem constraint. Convenção: plural, minúsculo, sem ponto final
  (`'gols'`, `'cartões vermelhos'`, `'km'`, não `'Gol'`, `'Cartão Vermelho.'`).
- **`theme`** — taxonomia fechada por convenção, **não por CHECK constraint no banco**: fonte única
  em `src/lib/topics.ts` (`futebol`, `geografia`, `historia`, `brasil`, `corpo-humano`, `cultura`,
  `animais`). Um tema inventado aqui não dá erro — só nunca é sorteado, porque `rooms.themes`
  filtra contra essa lista do cliente. Falha silenciosa: conferir contra `topics.ts` antes de
  gravar, não confiar em validação do banco.
- **`difficulty`** — smallint 1–3, **deliberadamente sem definição escrita**. Julgar no feeling.
  Isso é decisão de produto, não lacuna a preencher — não "corrigir" depois achando que foi
  esquecido.

## Fonte da pergunta

A política de qual fonte usar quando os números divergem entre agregadores mora no curador
(`.claude/agents/curador-perguntas.md`), não aqui — este guia é sobre a forma do texto, não sobre
a apuração do número.
