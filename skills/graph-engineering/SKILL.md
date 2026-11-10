---
name: graph-engineering
description: Desenha grafos de execução de agentes de IA especializados (nós = agentes/ferramentas/avaliadores/gates humanos, arestas = fluxo sequencial, paralelo ou condicional) e os traduz num script do Workflow tool. Use quando o usuário falar em "grafo de agentes", "graph engineering", "topologia de agentes", "orquestrar vários agentes", "quero agentes rodando em paralelo e se revisando", "desenha isso como um grafo" ou pedir pra tornar um agente/pipeline "100x melhor" distribuindo o trabalho. NÃO use para uma tarefa de um agente só, nem para memória/conhecimento persistente (isso é a skill do segundo cérebro) — "graph engineering" é termo recente (2026) e ambíguo; a primeira coisa a fazer é desambiguar qual dos três sentidos o usuário quer.
---

# Graph Engineering (grafos de execução de agentes)

Origem: vídeo "Torne seus Agentes 100x Melhores com Graph Engineering"
(canal Maestros da IA, youtube.com/@maestrosdaia). O termo não tem
transcrição confirmada nesta skill — ela foi montada a partir do título,
do canal e de pesquisa cruzada sobre o estado atual do termo. Se o vídeo
disser algo diferente do que está aqui, corrija este arquivo.

## Passo 0 — desambiguar

"Graph engineering" para agentes de IA não tem um sentido único em 2026.
Pergunte ou infira qual destes o usuário quer, porque o desenho é diferente:

| Sentido | O que é | Quando é isso |
|---|---|---|
| **Grafo de execução/orquestração** (o mais comum e o que esta skill cobre) | Nós = agentes, ferramentas, avaliadores, decisões humanas; arestas = fluxo | "quero vários agentes especializados", "etapas em paralelo", "revisão cruzada" |
| **Grafo de loops** | Vários loops de agente interagindo entre si | "um agente aciona outro loop que aciona outro" |
| **Grafo de conhecimento/memória** | Relações explícitas e consultáveis entre fatos | Isso é memória persistente → use a skill do segundo cérebro (Obsidian), não esta |

O resto deste arquivo cobre o grafo de execução/orquestração.

## Passo 1 — a barra antes da topologia

Antes de desenhar nó nenhum, defina o que "melhor" quer dizer aqui: uma
barra de qualidade concreta e comparável (técnica do gauntlet-loop,
github.com/robonuggets/gauntlet-loop). Grafo sem barra é só mais
paralelismo gastando mais tokens sem critério de vitória.

## Passo 2 — os nós (quem faz o quê)

Quebre a tarefa em papéis distintos, não em pedaços arbitrários. Tipos de
nó recorrentes:

- **Builder** — produz o artefato (código, texto, plano).
- **Critic/evaluator** — contexto novo, nunca viu como o builder decidiu,
  veredito binário contra a barra (não nota — nota vicia para cima com o
  tempo).
- **Gate/portão** — checagem determinística de pré-requisito antes de
  deixar passar (o padrão G1–G5 da skill `triagem-automacao-gp` é um bom
  modelo: nomeie o critério, torne-o verificável, BLOQUEADO se faltar).
- **Especialista de domínio** — sabe a regra que o builder não sabe
  (ex.: a regra da disciplina de engenharia).
- **Humano** — aprova o que não pode ser automatizado sem risco.

Cada nó deve ter uma única responsabilidade. Nó que builda e critica a
própria coisa não é um nó, é um self-review disfarçado de grafo.

## Passo 3 — as arestas (como o trabalho flui)

- **Sequencial (pipeline)** — saída de um nó é entrada do próximo.
- **Paralelo** — nós independentes, mesma entrada ou entradas disjuntas,
  sem motivo para esperar um pelo outro.
- **Condicional/roteamento** — a saída de um nó decide qual nó roda a
  seguir (ex.: veredito BLOQUEADO → vai para nó de perguntas; APTO → vai
  para nó de plano).
- **Loop com saída** — builder ↔ critic repete até o critic aprovar ou
  até um limite; nunca número fixo de rounds, sempre condição de saída.

Desenhe o grafo em uma tabela ou lista antes de qualquer código: nó,
papel, entrada, saída, para onde vai depois. Se não cabe em meia página,
o grafo provavelmente está fazendo duas coisas e devia ser dois grafos.

## Passo 4 — traduzir para execução

Em Claude Code, o motor de grafo de execução é o **Workflow tool**
(`agent()`, `parallel()`, `pipeline()`, `phase()`) — carregue a skill
`workflow-authoring` antes de escrever o script. Mapeamento direto:

- nó sequencial → `agent()` dentro de um `pipeline()`
- nós paralelos → `parallel([...])`
- critic/evaluator → `agent()` com prompt de veredito binário, schema
  tipado, sem ver o contexto do builder
- gate → checagem antes do próximo `agent()`/`pipeline()`, ou um
  `agent()` dedicado que só retorna aprovado/bloqueado

O Workflow tool só roda com opt-in explícito do usuário (`ultracode` ou
pedido direto por "workflow"/orquestração multiagente) — nunca acione
sozinho por achar que o grafo "ficaria melhor assim". Para uma tarefa
menor, a mesma topologia funciona só com `Agent` (subagentes) descrita em
texto, sem precisar do Workflow tool.

## Passo 5 — custo e quando NÃO usar

Grafo de execução é a camada mais avançada e a menos madura do
ferramental de agentes — cada nó extra é mais tokens e mais uma chance de
falhar, não necessariamente um resultado melhor. Use quando a tarefa
genuinamente se beneficia de perspectivas/paralelismo independentes
(builder+critic, pesquisa+validação, múltiplas disciplinas). Para uma
tarefa que um agente só resolve bem, um grafo só adiciona latência e
custo — diga isso ao usuário em vez de desenhar um grafo por desenhar.

## Saída

Ao aplicar esta skill, entregue: a tabela de nós/arestas (Passo 3), a
barra de qualidade (Passo 1), e — só se houver opt-in para Workflow —
o script. Nunca entregue só o script sem o desenho, porque o desenho é o
que o usuário revisa e corrige.

## Referências

- Vídeo de origem: youtube.com/watch?v=r8JueeaKJ9w (Maestros da IA)
- Técnica de validação: github.com/robonuggets/gauntlet-loop
- Padrão de portões: skill `triagem-automacao-gp` (G1–G5)
- Execução real: skill `workflow-authoring`
