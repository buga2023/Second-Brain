---
title: "Síntese: como decidir entre LangChain, LangGraph e Self-Harness"
tipo: sintese
tags: [sintese, decisao, arquitetura]
fontes: [2026-11-05-post-langchain-langgraph.md, 2026-11-05-paper-self-harness-arxiv-2606.09498.md]
date: 2026-11-06
---
# Como decidir a camada

| Situação | Camada |
|---|---|
| Caminho previsível, risco baixo | [langchain](../entidades/langchain.md) |
| Alçada, prazo, exceção, registro em sistema | [langgraph](../entidades/langgraph.md) |
| Decisão que alguém assina | [langgraph](../entidades/langgraph.md) + [human-in-the-loop](../conceitos/human-in-the-loop.md) |
| Agente em produção com volume e teste automático | + [self-harness](../conceitos/self-harness.md) por cima |
| Pipeline de dados com falhas recorrentes | [etl-agentico](../conceitos/etl-agentico.md) sobre [langgraph](../entidades/langgraph.md) |

| Tarefa longa com plano, arquivos e subagentes | [deep-agents](../entidades/deep-agents.md) |

Regra oficial (ecosystem-primer), avaliada na ordem: plano/arquivos/memória → Deep Agents; fluxo customizado → LangGraph; agente único → LangChain.

**Pré-requisito do Self-Harness:** existir verificador confiável. Sem teste automático, não ligue auto-evolução.
