---
title: Deep Agents
tipo: entidade
tags: [framework, harness, langchain]
fontes: [2026-11-06-docs-langchain-langgraph-skills.md]
date: 2026-11-06
---
# Deep Agents

A camada de **cima** da pilha LangChain, que a própria documentação chama de *harness*. Vem pronta com planejamento (todo list), arquivos, subagentes, memória e skills. `create_deep_agent(model, tools)`. Versão 0.7.34.

Use quando a tarefa é longa e exige plano. Não use quando precisa de controle fino de cada etapa: aí é [langgraph](langgraph.md).

Conexão: é literalmente o [harness](../conceitos/harness.md) que o [self-harness](../conceitos/self-harness.md) estuda, empacotado como produto.
