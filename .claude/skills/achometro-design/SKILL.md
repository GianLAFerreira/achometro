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

**Domínio da escala é dinâmico, não fixo em 10³–10¹¹** (implementado em `src/components/
Mostrador.tsx`): calculado a partir do gabarito + palpites de cada rodada, arredondado pra década
abaixo/acima, com span mínimo de 2 décadas. O mockup acima é ilustrativo, não um range fixo.

**Empilhamento de rótulo é por colisão real em pixel, não um percentual fixo de distância no eixo
log.** Um limiar em % não escala com o tamanho do nome (até 16 caracteres) — testado ao vivo:
resolvia nomes curtos colidindo e reabria com nomes longos. A implementação mede a largura real do
track via `ResizeObserver` e estima a largura do rótulo por contagem de caractere, empacotando cada
marcador na primeira linha (row) onde ele não sobrepõe o rótulo anterior — mesmo princípio de
empacotamento de intervalo, não um número mágico. Rótulos de nome completos (não só o marcador) só
aparecem em `sm:` e acima — no celular o mostrador mostra só régua + marcadores + gabarito; a lista
detalhada por jogador (que já existia antes do mostrador) continua abaixo dele em qualquer largura,
e é a fonte legível de detalhe.

## Regra de ousadia

O mostrador é a **única** peça com tratamento de instrumento (textura, bisel, brilho). Todo o
resto — botão, campo, lobby, navegação — é plano e disciplinado. Se textura ou bisel aparecer em
dois lugares diferentes da interface, o desenho já saiu do controle: é o caminho direto para
skeumorfismo datado em vez de instrumento elegante. Indicadores funcionais em SVG plano que mudam
por estado (ex.: o anel de progresso do cronômetro) não contam como esse tratamento — não têm
textura, bisel ou brilho, só um traço colorido por token; a proibição é sobre ornamento
skeuomórfico, não sobre qualquer elemento gráfico fora do mostrador.

Estado "selecionado" em qualquer controle novo (ex.: `TopicSelect.tsx`, seletor de tópicos da sala)
reaproveita as mesmas cores das variantes de `Button.tsx` (`bg-latao text-tinta` selecionado,
`bg-esmalte-2 text-mostrador` não-selecionado) em vez de inventar uma terceira paleta de "estado
ativo" — mesmo princípio de fonte única que rege os presets de movimento e os tokens de cor.

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

## Movimento

Fonte única dos presets: `src/lib/motion.ts` (`SPRING_NEEDLE`, `EASE_SETTLE`, `DURATION_FAST`,
`DURATION_BASE`) — mudar ali, não duplicar número de easing/duração num componente. Regra: **animação
só em transição de estado** (troca de tela, chegada de dado via Realtime, toque, contagem
regressiva) — nunca decorativa ou ociosa. Se um elemento "pulsa sozinho" sem gatilho de estado, já
saiu do escopo.

`SPRING_NEEDLE` (overshoot + amortecimento) é usado em exatamente três lugares, e a lista não deve
crescer sem decisão deliberada: o ponteiro do mostrador, a cascata do placar final (fim de partida —
`Scoreboard.tsx`, prop `isFinal`) e a entrada do logo na Home (`HomeScreen.tsx`, primeiro contato
com o app). Ainda só timing/tamanho/escala já-existente — nenhum componente novo ganha textura,
bisel ou brilho por causa disto.

Todo componente animado via `motion/react` checa `useReducedMotion()` (reexportado de
`lib/motion.ts`) antes de aplicar overshoot, stagger ou `whileTap`. `src/index.css` tem uma regra
`@media (prefers-reduced-motion: reduce)` global como defesa em profundidade pras poucas transições
puramente CSS (ex.: `transition-colors` do Button, o pulso de urgência do cronômetro).

Vibração (Web Vibration API, `src/lib/haptics.ts`) em exatamente 2 momentos no mobile: cravar
palpite e abertura da revelação. Sem terceiro, sem prompt de permissão, no-op silencioso em iOS
Safari.

## Mobile e breakpoints

Mobile-first de verdade: a base (sem prefixo) é o telefone; `sm:`/`md:` só *adicionam* — aumentam
escala tipográfica, densidade ou revelam rótulo, nunca mudam a estrutura do layout de telefone. O
mostrador é o exemplo: régua + marcadores no celular, rótulos de nome só a partir de `sm:`.
`index.html` declara `viewport-fit=cover`; o container raiz (`App.tsx`) reserva
`env(safe-area-inset-bottom)` pra não colidir com a barra de gestos do iPhone.

## Piso de qualidade (não negociável)

Responsivo até 360px de largura · foco de teclado visível sobre o esmalte (não só sobre o
mostrador) · contraste AA verificado nos pares `--mostrador`/`--tinta` e `--esmalte`/`--mostrador`
· `prefers-reduced-motion` sempre honrado.
