---
name: achometro-design
description: Design system do Achômetro — tokens, tipografia, o mostrador logarítmico e a lista de proibições. Carregar sempre que UI, CSS ou copy do app forem tocados.
---

# Design system — Achômetro

`-ômetro` significa instrumento de medição. A referência não é "app de quiz" — é **painel de
aparelho analógico brasileiro**: esmalte vitrificado, mostrador com escala gravada, ponteiro,
bezel de latão. Balança de feira, manômetro de posto, relógio de luz, velocímetro de Fusca.

## Proibido, sem exceção

Isto é a defesa contra "cara de IA". Nenhum destes entra, mesmo que pareça o caminho mais rápido:

- Gradiente roxo→azul, ou qualquer gradiente como fundo de seção.
- Fonte Inter, Space Grotesk, ou a stack padrão do Tailwind.
- Card branco centralizado com sombra difusa sobre fundo claro.
- `border-radius` uniforme aplicado a tudo.
- Emoji no lugar de ícone.
- Glassmorphism, `backdrop-blur` decorativo.
- As três paletas-padrão de IA: creme+serifa+terracota · preto+verde-limão · jornal de régua fina.
- Componente de UI pronto (shadcn/ui, MUI, Chakra, DaisyUI). Traz o default embutido.
- Cor fora dos tokens abaixo. Sem "só esse caso".

## Tokens de cor

```css
--esmalte:   #0F3B3A   /* verde-petróleo do corpo do aparelho — fundo dominante */
--esmalte-2: #092A29   /* sombra interna, sulcos, profundidade */
--mostrador: #E8DCC0   /* face do mostrador, amarelada de idade */
--latao:     #C9A227   /* bezel, marcas de calibração, vencedor */
--agulha:    #D6402A   /* ponteiro e marca do gabarito */
--tinta:     #14201F   /* texto sobre o mostrador */
```

A página é **escura e esmaltada**; o mostrador é a peça clara. Isso inverte de saída o "fundo
claro com card centralizado" que é a assinatura visual de interface gerada por IA. Não inventar
tom intermediário sem antes checar contraste AA contra `--tinta` ou `--mostrador`.

## Tipografia — três papéis, três faces

| Papel | Face | Uso |
|---|---|---|
| Display | Bricolage Grotesque | Logo e títulos. Caixa alta, tracking apertado. |
| **Números** | Martian Mono | Palpites, gabarito, placar, cronômetro. Face herói — o conteúdo do app *é* número. |
| Corpo | Instrument Sans | Perguntas, rótulos, instruções. Discreto de propósito. |

Self-hosted via `@fontsource`, nunca por `<link>` a Google Fonts CDN — coerente com a postura de
privacidade do projeto (zero requisição a terceiro).

## O elemento-assinatura: o mostrador

Na revelação, o placar não é uma lista — é um mostrador de **escala logarítmica**. Perguntas vão
de 206 (ossos do corpo) a 1,7 bilhão (árvores no Brasil); em escala linear todo mundo se amontoa
num pixel. A escala log é a mesma matemática do erro relativo que já é a regra de pontuação — a
decisão visual e a decisão de jogo são a mesma decisão, não duas.

```
 10³      10⁵      10⁷      10⁹       10¹¹
 ├────┬────┼────┬────┼────┬────┼────┬────┤
      ▲         ▲              ▲│  ▲
    Pedro     Marina        Gian│  Ana
                                 ╹ gabarito
```

Ponteiros entram com física de instrumento: ultrapassam o alvo e assentam com amortecimento. Um
único momento orquestrado por rodada — nada de animação espalhada pela interface.
`prefers-reduced-motion`: ponteiros aparecem já assentados, sem overshoot.

## Regra de ousadia

O mostrador é a **única** peça com tratamento de instrumento (textura, bisel, brilho). Todo o
resto — botão, campo, lobby, navegação — é plano e disciplinado. Se textura ou bisel aparecer em
dois lugares diferentes da interface, o desenho já saiu do controle: é o caminho direto para
skeumorfismo datado em vez de instrumento elegante.

## Voz da interface

Vocabulário de instrumento, claro antes de esperto. Sem "Ops!", sem pedido de desculpa, sem
exclamação de entusiasmo — o aparelho não se desculpa.

| Situação | Texto |
|---|---|
| Botão de enviar | `Cravar palpite` |
| Carregando rodada | `Aferindo` |
| Sala vazia | `Ninguém aqui ainda. Passe o código 7K2M9P.` |
| Erro de sala | `Código não confere. Confira as 6 letras.` |
| Valor exato do gabarito | `Cravou` |
| Fim de rodada | `Resposta: 1,7 bilhão` + fonte clicável |

## Piso de qualidade (não negociável)

Responsivo até 360px de largura · foco de teclado visível sobre o esmalte (não só sobre o
mostrador) · contraste AA verificado nos pares `--mostrador`/`--tinta` e `--esmalte`/`--mostrador`
· `prefers-reduced-motion` sempre honrado.
