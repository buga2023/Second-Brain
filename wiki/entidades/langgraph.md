---
title: LangGraph
tipo: entidade
tags: [framework, orquestracao, estado-duravel]
fontes: [2026-11-05-post-langchain-langgraph.md]
date: 2026-11-06
---
# LangGraph

Motor de orquestração: processo como grafo (nós = etapas, arestas = caminhos). Condicionais, repetições, retries, **estado durável** (retoma após queda) e **interrupção** ([human-in-the-loop](../conceitos/human-in-the-loop.md)).

- Uso: alçada, prazo, exceção, registro em sistema.
- Casos: cadastro de fornecedor, conciliação financeira, atendimento com escalonamento (Klarna −80%, **(não verificado)**).
- Bom motor para [etl-agentico](../conceitos/etl-agentico.md) com tratamento de exceções.
- Implementa [gate-deterministico](../conceitos/gate-deterministico.md) como aresta obrigatória.

## Versão 1.2.20 (nov/2026)
`StateGraph` · `Command` · `Send` · `interrupt` · checkpointers InMemory/Sqlite/Postgres · Store.

Como usar: [guia-langgraph](../guias/guia-langgraph.md). Tutorial rodável: [tutorial-ciclo-rhawk-langgraph](../guias/tutorial-ciclo-rhawk-langgraph.md). Decisão: [decidir-langchain-ou-langgraph](../sinteses/decidir-langchain-ou-langgraph.md).
