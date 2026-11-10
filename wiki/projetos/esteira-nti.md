---
title: Esteira NTI
tipo: projeto
tags: [nti, esteira, projeto-interno, lacuna]
fontes: [2026-11-05-pesquisa-web-esteira-nti.md]
date: 2026-11-06
---
# Esteira NTI

> **Documentada em 06/11/2026.** Definição de trabalho: a esteira de evolução contínua de agentes de IA, orientada a negócio, que junta o [ciclo-de-evolucao-rhawk](../conceitos/ciclo-de-evolucao-rhawk.md), a [avaliacao-atual-vs-candidata](../conceitos/avaliacao-atual-vs-candidata.md), o [self-harness](../conceitos/self-harness.md), o [etl-agentico](../conceitos/etl-agentico.md) e LangChain/LangGraph. NTI é o setor de TI da GP ([glossário](../../memory/glossary.md)).
>
> - **Repositório/skill:** `~/Projetos/esteira-nti` → github.com/buga2023/esteira-nti (privado). Instalada como skill global `esteira-nti` (symlink em `~/.claude/skills/`).
> - **Estrutura:** `SKILL.md` · `references/01–13` (visão, ciclo, avaliação, governança, rollout, métricas, arquitetura, LangGraph, LangChain, LangSmith, runbook, glossário, perguntas abertas) · `templates/` (proposta, checklist do gate, politica.yaml, registro de decisão, RACI) · `scripts/` (ciclo em LangGraph, 9 testes passando).
> - **Como foi feita:** 3 workers Claude em paralelo no Orca ([guia-orca-orquestracao](../guias/guia-orca-orquestracao.md)).

## Hipótese de trabalho (a confirmar)
Uma **esteira** (pipeline) do NTI que leva agentes/dados da exploração até a produção. Se for isso, ela é onde os outros conceitos do vault se encaixam:

| Estágio da esteira | Conceito do vault |
|---|---|
| Ingestão e tratamento de dados | [etl-agentico](../conceitos/etl-agentico.md) |
| Construção do agente | [langchain](../entidades/langchain.md) / [harness](../conceitos/harness.md) |
| Fluxo com regras e alçadas | [langgraph](../entidades/langgraph.md) · [human-in-the-loop](../conceitos/human-in-the-loop.md) |
| Registro de cada passo | [observabilidade-de-traces](../conceitos/observabilidade-de-traces.md) |
| Promoção de versão | [gate-de-regressao](../conceitos/gate-de-regressao.md) |
| Melhoria contínua | [self-harness](../conceitos/self-harness.md) |

Ver [self-harness-como-etl](../sinteses/self-harness-como-etl.md) para a proposta de desenho.

## Candidata a metodologia (06/11/2026)
O [ciclo-de-evolucao-rhawk](../conceitos/ciclo-de-evolucao-rhawk.md) (Operar → Observar → Preparar → Investigar → Propor → Avaliar e decidir) tem a forma exata de uma esteira de evolução. **A confirmar:** ele é a esteira NTI, ou é o processo que roda sobre ela?

## Perguntas abertas
- O que significa NTI aqui (Núcleo de Tecnologia da Informação? outro)?
- A esteira é de **dados**, de **software/CI-CD** ou de **agentes**?
- Quais etapas já existem e quais são aspiração?
- Quem são os aprovadores (alçadas)?
- Existe conjunto de avaliação / teste automatizado hoje?
