---
title: "Post: Por que LangChain e LangGraph?"
tipo: fonte
tags: [langchain, langgraph, orquestracao, human-in-the-loop, post]
fontes: [2026-11-05-post-langchain-langgraph.md]
date: 2026-11-05
---
# Post: Por que LangChain e LangGraph?

Post em formato LinkedIn trazido pelo Gustavo. Serve como **referência de formato** (🧱 o que é · 🧭 como funciona · ↳ boas práticas · 🏭 casos · 🎯 como decidir) e como **tese sobre camadas**.

## Pontos-chave
- [langchain](../entidades/langchain.md) encurta o caminho até o primeiro agente útil: modelo + ferramentas + instruções, com troca de fornecedor sem reescrita.
- [langgraph](../entidades/langgraph.md) garante que o processo termine: grafo de nós e arestas, estado durável, interrupção para decisão humana.
- São camadas da mesma pilha: o agente decide **dentro do espaço que o fluxo permite**.
- Regra de ouro: *"Se uma etapa não pode ser pulada, ela não pode depender da escolha do modelo."* → ver [gate-deterministico](../conceitos/gate-deterministico.md).
- Assinatura: *"Vibe para explorar. Verify para escalar."*

## Dados citados
- Klarna: −80% no tempo de resolução com atendimento escalonável para humano (caso publicado pela própria LangChain — **(não verificado)** de forma independente).

## Conecta com
[human-in-the-loop](../conceitos/human-in-the-loop.md) · [decidir-langchain-ou-langgraph](../sinteses/decidir-langchain-ou-langgraph.md) · [self-harness-como-etl](../sinteses/self-harness-como-etl.md)
