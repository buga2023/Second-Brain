---
title: Visão geral — agentes que evoluem dentro de esteiras
tipo: sintese
tags: [overview, tese]
fontes: [todas]
date: 2026-11-06
---
# Visão geral

**Tese atual (05/11/2026):** o ganho prático de 2026 em agentes não está em trocar o modelo, e sim no **[harness](conceitos/harness.md)** em volta dele — e esse harness já pode ser melhorado pelo próprio agente ([self-harness](conceitos/self-harness.md), [harnessx](entidades/harnessx.md), [ahe](entidades/ahe.md)), desde que exista uma **esteira com gates** que decida o que entra.

## As quatro peças
1. **Construir** o agente → [langchain](entidades/langchain.md).
2. **Controlar** o processo → [langgraph](entidades/langgraph.md), [gate-deterministico](conceitos/gate-deterministico.md), [human-in-the-loop](conceitos/human-in-the-loop.md).
3. **Alimentar** com dados confiáveis → [etl-agentico](conceitos/etl-agentico.md).
4. **Evoluir** com segurança → [self-harness](conceitos/self-harness.md) + [gate-de-regressao](conceitos/gate-de-regressao.md) + [observabilidade-de-traces](conceitos/observabilidade-de-traces.md).

A ponte entre 3 e 4: [self-harness-como-etl](sinteses/self-harness-como-etl.md).

**Versão empresarial do loop:** [ciclo-de-evolucao-rhawk](conceitos/ciclo-de-evolucao-rhawk.md). Mesma forma do Self-Harness, mas medida pelo negócio, com pessoas investigando e decidindo.

## Evidência mais forte
MiniMax M2.5: 40,5% → 61,9% só mudando o harness ([fonte-paper-self-harness](fontes/fonte-paper-self-harness.md)). AHE superou harness humano (77,0% vs 71,9%).

## Como fazer (06/11/2026)
Guias práticos: [guia-langchain](guias/guia-langchain.md) · [guia-langgraph](guias/guia-langgraph.md) · [tutorial-ciclo-rhawk-langgraph](guias/tutorial-ciclo-rhawk-langgraph.md) (rodando localmente). Avaliação e governança: [respostas-perguntas-abertas](sinteses/respostas-perguntas-abertas.md).

## Maior lacuna
[esteira-nti](projetos/esteira-nti.md) — sem fonte. É a peça que transforma a pesquisa em plano.

## Próximos ingests sugeridos
- Documento interno da esteira NTI.
- Paper completo HarnessX (2606.14249) e AHE (2604.25850).
- [survey-gao-tmlr-2026](entidades/survey-gao-tmlr-2026.md) na íntegra.
