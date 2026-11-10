---
title: LangChain
tipo: entidade
tags: [framework, agentes, open-source]
fontes: [2026-11-05-post-langchain-langgraph.md]
date: 2026-11-06
---
# LangChain

Biblioteca open source para montar agentes: modelo + ferramentas + instruções, com ciclo pronto (pergunta → ferramenta → execução → resposta) e pontos de controle (aprovação humana, mascaramento de dados pessoais, resumo de histórico).

- Uso: caminho previsível e risco baixo.
- Casos: assistente de RH/compliance, busca de contratos, triagem de chamados.
- Roda sobre o motor do [langgraph](langgraph.md).
- É um construtor de [harness](../conceitos/harness.md).

## v1 (versão 1.4.9, nov/2026)
- `create_agent(model, tools, system_prompt, checkpointer, middleware, response_format)`.
- Middleware: HumanInTheLoop, PII, Summarization, hooks customizados.
- Pilha oficial: LangChain (framework) → [langgraph](langgraph.md) (runtime) → [deep-agents](deep-agents.md) (harness) + [langsmith](langsmith.md) (observabilidade).

Como usar: [guia-langchain](../guias/guia-langchain.md). Decisão: [decidir-langchain-ou-langgraph](../sinteses/decidir-langchain-ou-langgraph.md).
