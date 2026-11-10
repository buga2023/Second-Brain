---
title: Human-in-the-loop (alçada humana)
tipo: conceito
tags: [governanca, aprovacao, alcada]
fontes: [2026-11-05-post-langchain-langgraph.md, 2026-11-05-paper-self-harness-arxiv-2606.09498.md]
date: 2026-11-05
---
# Human-in-the-loop

Pausa do fluxo para uma pessoa decidir. No [langgraph](../entidades/langgraph.md) é a *interrupção*: o fluxo espera horas ou dias com estado salvo.

## Quando é obrigatório
- Ação que **envia, paga ou apaga** ([fonte-post-langchain-langgraph](../fontes/fonte-post-langchain-langgraph.md)).
- Decisão que alguém **assina**.
- Mudança de alto risco no próprio harness — os autores do [self-harness](self-harness.md) admitem que não-regressão não basta.
- Mudança no critério de avaliação (nível L4 em [agentes-auto-evolutivos](agentes-auto-evolutivos.md)).

## Regra
Alçadas definidas **antes** do código: onde o fluxo para e quem aprova.
