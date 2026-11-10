---
title: "Guia: como usar LangGraph"
tipo: guia
tags: [guia, langgraph, stategraph, interrupt, checkpointer]
fontes: [2026-11-06-docs-langchain-langgraph-skills.md]
date: 2026-11-06
---
# Guia: LangGraph

> Versão testada: **langgraph 1.2.20**. Exemplo rodável **sem chave de API**: `~/Projetos/estudo-langgraph/ciclo_rhawk.py`. Passo a passo em [tutorial-ciclo-rhawk-langgraph](tutorial-ciclo-rhawk-langgraph.md).

## Ideia em uma frase
O processo vira um **mapa**: etapas (nós) ligadas por caminhos (arestas), com um **estado** compartilhado que é salvo a cada passo.

## Método oficial em 5 passos
1. **Mapear as etapas**, como num fluxograma. Cada etapa vira um nó.
2. **Classificar cada nó:** LLM, dados, ação ou entrada humana. Para cada um, definir retry e resultado esperado.
3. **Desenhar o estado:** guarde dado bruto e formate o prompt dentro do nó.
4. **Escrever os nós:** função que recebe o estado e devolve **só o que mudou**.
5. **Ligar:** arestas, rotas condicionais e `compile(checkpointer=...)`.

## As peças
```python
from typing import Annotated, Literal
import operator
from typing_extensions import TypedDict
from langgraph.graph import StateGraph, START, END
from langgraph.types import Command, interrupt

class Estado(TypedDict, total=False):
    valor: float
    log: Annotated[list[str], operator.add]   # reducer: acumula em vez de sobrescrever

def calcular(estado):                          # nó = função
    return {"valor": 42, "log": ["calculou"]}  # devolve só a mudança

g = StateGraph(Estado)
g.add_node("calcular", calcular)
g.add_edge(START, "calcular")
g.add_edge("calcular", END)
grafo = g.compile()
grafo.invoke({})
```

## Tipos de caminho
| Precisa de | Use |
|---|---|
| sempre ir para o mesmo nó | `add_edge` |
| decidir pela leitura do estado | `add_conditional_edges(nó, função_que_retorna_nome)` |
| atualizar e rotear no mesmo nó | `return Command(update={...}, goto="outro")` com tipo `Command[Literal[...]]` |
| disparar N tarefas em paralelo | `Send("worker", {...})` (exige reducer) |

⚠ **Armadilha:** se o nó retorna `Command(goto=...)` **e** também tem `add_edge` de saída, **os dois caminhos rodam**.

## Estado durável (checkpointer)
| Checkpointer | Uso |
|---|---|
| `InMemorySaver` | teste (perde tudo ao fechar) |
| `SqliteSaver` | local (usado no tutorial) |
| `PostgresSaver` | produção (`.setup()` uma vez no deploy) |

Sempre passe `config = {"configurable": {"thread_id": "..."}}`. **Um thread_id = um processo** (um pedido, um caso, uma melhoria).

Recursos: `grafo.get_state(config)` (onde está) · `get_state_history(config)` (todos os checkpoints, para auditoria e time travel) · `update_state(config, {...})` (corrigir à mão; passa pelos reducers, use `Overwrite` para substituir).

## Pausa para humano (interrupt)
```python
def decidir(estado) -> Command[Literal["adotar", "__end__"]]:
    resposta = interrupt({"pergunta": "Adotar?", "dados": estado["valor"]})  # pausa aqui
    return Command(goto="adotar" if resposta == "sim" else END)

r = grafo.invoke({}, config)            # r["__interrupt__"] traz a pergunta
grafo.invoke(Command(resume="sim"), config)   # horas ou dias depois, até em outro processo
```
**Regras críticas:**
- Ao retomar, **o nó recomeça do início**. Tudo antes do `interrupt()` roda de novo. Efeito colateral (gravar, enviar) vai **depois** do interrupt, ou precisa ser idempotente (upsert).
- Não envolva o `interrupt()` em `try/except` genérico: ele funciona lançando uma exceção.
- O payload precisa ser serializável em JSON.

## Erros: quem conserta?
| Erro | Quem | Como |
|---|---|---|
| transitório (rede, rate limit) | sistema | `add_node(..., retry_policy=RetryPolicy(max_attempts=3))` |
| falha de ferramenta | LLM | `ToolNode(tools, handle_tool_errors=True)` |
| falta informação | humano | `interrupt()` |
| inesperado | dev | deixar estourar |

## Streaming
`grafo.stream(input, config, stream_mode="updates")`: `values` (estado todo) · `updates` (só o que mudou) · `messages` (tokens, para chat) · `custom`.

## Misturando com LangChain
Um agente `create_agent(...)` pode ser **um nó** do grafo, por exemplo o nó "investigar". O grafo garante a ordem e as regras; o agente resolve a etapa que exige julgamento.

Relacionados: [langgraph](../entidades/langgraph.md) · [gate-deterministico](../conceitos/gate-deterministico.md) · [human-in-the-loop](../conceitos/human-in-the-loop.md) · [canary-e-rollback](../conceitos/canary-e-rollback.md)
