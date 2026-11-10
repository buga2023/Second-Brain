---
title: Gate determinístico
tipo: conceito
tags: [governanca, principio, orquestracao]
fontes: [2026-11-05-post-langchain-langgraph.md, 2026-11-05-paper-self-harness-arxiv-2606.09498.md]
date: 2026-11-05
---
# Gate determinístico

Princípio que atravessa todo o vault:

> "Se uma etapa não pode ser pulada, ela não pode depender da escolha do modelo." — [fonte-post-langchain-langgraph](../fontes/fonte-post-langchain-langgraph.md)

O modelo trabalha **dentro** de um espaço; as bordas do espaço são código, regra ou pessoa.

## Aparece como
- Aresta obrigatória num grafo [langgraph](../entidades/langgraph.md).
- [gate-de-regressao](gate-de-regressao.md) no [self-harness](self-harness.md).
- Lista fechada de ações no [etl-agentico](etl-agentico.md).
- Interrupção para aprovação: [human-in-the-loop](human-in-the-loop.md).
