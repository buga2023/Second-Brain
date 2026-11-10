---
title: "Guia: como usar LangChain (v1)"
tipo: guia
tags: [guia, langchain, create_agent, middleware]
fontes: [2026-11-06-docs-langchain-langgraph-skills.md]
date: 2026-11-06
---
# Guia: LangChain v1

> Versão testada: **langchain 1.4.9**. Exemplo rodável: `~/Projetos/estudo-langgraph/agente_investigador.py`.

## Ideia em uma frase
Você dá ao agente **um modelo, ferramentas e instruções**, e o LangChain roda o ciclo: pergunta → escolhe a ferramenta → executa → responde.

## Instalar
```bash
python3 -m venv .venv && source .venv/bin/activate
pip install langchain langchain-anthropic
export ANTHROPIC_API_KEY=...
```

## 1. Agente mínimo
```python
from langchain.agents import create_agent
from langchain.tools import tool

@tool
def buscar_pedido(id: str) -> str:
    """Busca o status de um pedido pelo número.

    Args:
        id: número do pedido, ex.: 'A123'
    """
    return "A123: em trânsito"

agente = create_agent(
    model="anthropic:claude-sonnet-4-5",   # troca de fornecedor = troca da string
    tools=[buscar_pedido],
    system_prompt="Você é o atendimento da loja.",
)
r = agente.invoke({"messages": [{"role": "user", "content": "Cadê o pedido A123?"}]})
print(r["messages"][-1].content)          # ⚠ não use r.content
```
**A docstring da ferramenta é o manual do modelo.** Descrição vaga = escolha errada.

## 2. Memória da conversa
```python
from langgraph.checkpoint.memory import InMemorySaver
agente = create_agent(..., checkpointer=InMemorySaver())
config = {"configurable": {"thread_id": "cliente-42"}}   # cada conversa = um thread_id
agente.invoke({...}, config)
```

## 3. Saída estruturada (quando a resposta alimenta outro sistema)
```python
from pydantic import BaseModel
class Triagem(BaseModel):
    categoria: str
    urgente: bool
agente = create_agent(..., response_format=Triagem)
r["structured_response"]   # Triagem(categoria='entrega', urgente=False)
```

## 4. Middleware = pontos de controle dentro do ciclo
| Middleware | Para quê |
|---|---|
| `HumanInTheLoopMiddleware` | pausa antes de ferramenta que envia, paga ou apaga |
| `PIIMiddleware` | mascara dados pessoais |
| `SummarizationMiddleware` | resume histórico longo |
| `@wrap_tool_call` | retry, bloqueio, log por ferramenta |
| `@before_model` / `@after_model` | inspecionar ou ajustar antes e depois do modelo |

### Aprovação humana
```python
from langchain.agents.middleware import HumanInTheLoopMiddleware
from langgraph.types import Command

agente = create_agent(
    ..., checkpointer=InMemorySaver(),               # obrigatório
    middleware=[HumanInTheLoopMiddleware(interrupt_on={
        "enviar_email": {"allowed_decisions": ["approve", "edit", "reject"]},
        "ler_email": False,
    })],
)
r = agente.invoke({...}, config)
if "__interrupt__" in r:                             # pausou
    r = agente.invoke(Command(resume={"decisions": [{"type": "approve"}]}), config)
```

### Retry e bloqueio
```python
from langchain.agents.middleware import wrap_tool_call
@wrap_tool_call
def bloqueia_perigosa(request, handler):
    if request.tool_call["name"] == "apagar_cliente":
        return "Ferramenta desativada"
    return handler(request)                          # ⚠ nunca use yield aqui
```

## 5. Trava contra loop
`agente.invoke(..., config={"recursion_limit": 10})`

## Erros comuns (das skills oficiais)
- Usar `create_react_agent` ou o parâmetro `prompt=`: isso é API antiga. Use `create_agent` e `system_prompt`.
- Usar HITL sem checkpointer ou sem thread_id.
- Retomar com dict: tem que ser `Command(resume=...)`.

## Quando subir para LangGraph
Se precisar de etapas obrigatórias, laços, alçadas ou estado que sobrevive a falhas → [guia-langgraph](guia-langgraph.md). Detalhe: o agente LangChain **já é um grafo LangGraph** por baixo (nós `model` → `tools` → middleware). Confirmado no teste local.

Relacionados: [langchain](../entidades/langchain.md) · [decidir-langchain-ou-langgraph](../sinteses/decidir-langchain-ou-langgraph.md) · [guia-ferramentas-claude-code](guia-ferramentas-claude-code.md)
