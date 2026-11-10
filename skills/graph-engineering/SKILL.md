---
name: graph-engineering
description: Grafo de execução de agentes — escolhe o padrão (encadeamento, roteamento, paralelo, orquestrador, avaliador-otimizador), desenha nós e arestas e entrega o script do Workflow tool. Use quando o usuário pedir vários agentes trabalhando juntos, revisão cruzada entre agentes, ou disser "grafo". Um agente só repetindo até uma condição é a skill desenhar-loop.
---

# Graph engineering

Um **grafo de execução** distribui um trabalho já decidido entre agentes:
**nós** fazem, **arestas** dizem para onde o resultado vai. Decisão ainda
aberta pertence ao grilling (ou `wayfinder`, se não cabe numa sessão) —
feche-a antes do passo 1.

## 1. Prove que precisa de grafo

Um grafo se paga quando ao menos uma destas é verdade:

- **Paralelismo real** — partes independentes, nenhuma espera a outra.
- **Olhar independente** — o resultado pede um crítico que não viu como
  foi feito.
- **Disciplinas distintas** — cada parte exige regra ou contexto que as
  outras não têm.
- **Escala** — a mesma operação em N itens que não cabem num contexto.

Nenhuma delas: recomende um build único com check (ou `desenhar-loop`) e
diga por quê. Cada nó custa tokens e é mais um ponto de falha.

Pronto quando: existe a frase "grafo porque <motivo da lista>", ou a
recomendação de não usar foi entregue ao usuário.

## 2. Defina a barra

A **barra** é a referência concreta contra a qual um crítico dá veredito
binário: um gabarito, um comando que sai 0, um documento-modelo, uma
tela de referência.

Pronto quando: a barra tem nome e o crítico consegue abri-la ou rodá-la
sozinho.

## 3. Escolha o padrão

| O trabalho é... | Padrão |
|---|---|
| Etapas fixas, cada uma usa a saída da anterior | Encadeamento |
| Entradas de tipos diferentes, cada tipo com tratamento próprio | Roteamento |
| Partes independentes, ou a mesma operação em N itens | Paralelo |
| Subtarefas que só dá para conhecer depois de olhar o problema | Orquestrador |
| Dá para criticar contra a barra e a crítica melhora o resultado | Avaliador-otimizador |

Definição, quando evitar e como combinar: [PADROES.md](PADROES.md).

Pronto quando: um padrão (ou combinação) está escolhido e o motivo cabe
em uma linha.

## 4. Desenhe nós e arestas

Uma linha por nó, antes de qualquer código:

| Nó | Papel | Recebe | Devolve | Vai para |
|---|---|---|---|---|

Papéis:

- **Builder** — produz o artefato.
- **Crítico** — contexto novo, nunca viu o raciocínio do builder; devolve
  veredito binário contra a barra, com evidência.
- **Portão** — checagem determinística de pré-requisito; bloqueia se
  faltar (modelo: G1–G5 da `triagem-automacao-gp`).
- **Especialista** — carrega a regra de domínio que o builder não tem.
- **Humano** — aprova o que não se automatiza sem risco.

Cada nó tem uma responsabilidade. Todo ciclo (builder ↔ crítico) tem
condição de saída e um **teto** de rodadas; o teto é disjuntor — bater
nele é falha a relatar.

Pronto quando: todo nó tem as cinco colunas preenchidas, todo ciclo tem
saída e teto, e a tabela cabe em meia página (maior que isso: são dois
grafos).

## 5. Traduza para execução

Adapte um modelo de [MODELOS.md](MODELOS.md) e carregue a skill
`workflow-authoring` para a API. O Workflow tool roda com opt-in do
usuário (pedido explícito de workflow ou orquestração multiagente); sem
opt-in, entregue desenho e script como texto e pergunte se roda. Para um
grafo de 2 ou 3 nós, a mesma topologia roda com subagentes (`Agent`),
sem script.

Pronto quando: cada nó da tabela aparece no script como uma chamada
`agent()`, cada aresta como `pipeline`, `parallel`, condicional ou laço.

## 6. Entregue

A frase do passo 1, a barra, a tabela de nós e arestas e o script. O
desenho vai sempre junto: é ele que o usuário revisa e corrige.
