---
title: LangSmith
tipo: entidade
tags: [observabilidade, avaliacao, plataforma]
fontes: [2026-11-06-docs-langchain-langgraph-skills.md, 2026-11-06-pesquisa-web-avaliacao-governanca.md]
date: 2026-11-06
---
# LangSmith

Plataforma da LangChain para **observabilidade e avaliação**. Funciona com qualquer framework. É a peça que faz o "Observar" e o "Avaliar" do [ciclo-de-evolucao-rhawk](../conceitos/ciclo-de-evolucao-rhawk.md) na prática.

- **Tracing:** cada passo do agente fica registrado ([observabilidade-de-traces](../conceitos/observabilidade-de-traces.md)). Ligar com `LANGSMITH_TRACING=true`.
- **Datasets + experimentos:** avaliação offline; comparação com baseline = [gate-de-regressao](../conceitos/gate-de-regressao.md).
- **Pairwise** (`evaluate_comparative`): compara versão atual × candidata = [avaliacao-atual-vs-candidata](../conceitos/avaliacao-atual-vs-candidata.md).
- **Avaliadores online:** pontuam traces de produção.
- **Integração com pytest e Vitest:** gate em CI.
- Falha em produção → vira exemplo no dataset ([avaliacao-offline-e-online](../conceitos/avaliacao-offline-e-online.md)).
