# Padrões de grafo

Os cinco padrões de "Building effective agents" (Anthropic,
anthropic.com/engineering/building-effective-agents), com o mapeamento
para o Workflow tool. A regra da fonte vale para todos: comece pela
solução mais simples e acrescente complexidade só quando ela melhora o
resultado de forma demonstrável.

## Encadeamento (prompt chaining)

Cada etapa processa a saída da anterior; entre etapas cabe um portão
programático.

- **Use quando** a tarefa se divide limpo em etapas fixas e vale trocar
  latência por acerto.
- **Evite quando** as etapas não são conhecidas de antemão (vira
  orquestrador).
- **Workflow:** `pipeline([entrada], etapa1, etapa2, ...)`, ou chamadas
  `agent()` em sequência com `if` entre elas fazendo o portão.

## Roteamento

Um nó classifica a entrada e manda para o tratamento especializado.

- **Use quando** há categorias distintas, tratadas melhor em separado, e
  a classificação é confiável.
- **Evite quando** as categorias se misturam ou o classificador erra
  muito: o erro de rota contamina tudo depois.
- **Workflow:** um `agent()` com `schema` de enum, depois um
  `switch`/mapa escolhendo o próximo `agent()`. Modelo: `roteador`.

## Paralelo

Duas formas:

- **Seccionamento** — subtarefas independentes ao mesmo tempo. Use
  quando dá para dividir, por velocidade ou porque cada aspecto merece
  atenção exclusiva. Evite quando uma parte depende da outra.
- **Votação** — a mesma tarefa várias vezes para ganhar confiança. Use
  em verificação e julgamento (N céticos tentando refutar um achado).
  Evite quando uma tentativa basta.
- **Workflow:** `pipeline(itens, faz, confere)` por padrão; `parallel()`
  só quando a etapa seguinte precisa de todos os resultados juntos
  (deduplicar, comparar). Modelo: `lote-com-verificacao`.

## Orquestrador-trabalhadores

Um nó central decompõe a tarefa na hora, delega e sintetiza.

- **Use quando** as subtarefas só aparecem depois de olhar o problema
  (mudança que toca um número imprevisível de arquivos).
- **Evite quando** as subtarefas são previsíveis: um encadeamento ou
  paralelo fixo é mais barato e mais fácil de depurar.
- **Workflow:** `agent()` planejador com `schema` devolvendo a lista,
  `parallel()` sobre a lista, `agent()` sintetizador. Modelo:
  `orquestrador`.

## Avaliador-otimizador

Um nó gera, outro avalia contra a barra e devolve a crítica, em laço.

- **Use quando** o critério é claro e a crítica melhora o resultado de
  forma mensurável (é o gauntlet-loop: crítico de contexto novo,
  veredito binário, sem nota).
- **Evite quando** não há barra: sem critério, o laço só gasta tokens.
- **Workflow:** laço `for` com teto; `agent()` builder, `agent()`
  crítico com `schema` `{passa, falhas}`. Modelo: `builder-critico`.

## Combinar

Os padrões compõem. Combinações que se repetem:

- Paralelo + avaliador: cada item do lote passa por build e crítica
  (`pipeline(itens, build, critica)`).
- Roteamento + encadeamento: a rota escolhe qual cadeia roda.
- Orquestrador + votação: os achados dos trabalhadores passam por
  céticos antes da síntese.

Agente autônomo (o modelo decide os passos em laço, com ferramentas) é
a escolha quando nem o número de passos dá para prever — é o que o
Claude Code já faz dentro de cada nó.
