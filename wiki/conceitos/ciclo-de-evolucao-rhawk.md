---
title: Ciclo de evolução orientado ao negócio (RHAWK)
tipo: conceito
tags: [rhawk, ciclo, auto-evolucao, governanca, esteira]
fontes: [2026-11-06-slide-rhawk-ciclo-evolucao.md, 2026-11-05-paper-self-harness-arxiv-2606.09498.md, 2026-11-05-pesquisa-web-etl-agentico.md]
date: 2026-11-06
---
# Ciclo de evolução orientado ao negócio

Modelo de 6 etapas da RHAWK ([fonte-slide-rhawk-ciclo-evolucao](../fontes/fonte-slide-rhawk-ciclo-evolucao.md)). Princípio: **melhorar com evidências**. Escolher o que melhorar, testar a mudança e acompanhar o resultado.

## Mapeamento etapa por etapa

| # | RHAWK | Equivalente no vault | ETL | Quem age |
|---|---|---|---|---|
| 01 | **Operar** — IA em uso | agente em produção ([langchain](../entidades/langchain.md) / [langgraph](../entidades/langgraph.md)) | — | agente |
| 02 | **Observar** — agente + negócio | [observabilidade-de-traces](observabilidade-de-traces.md) + KPIs do negócio | **Extract** | sistema |
| 03 | **Preparar** — evidências conectadas | cruzar trace com resultado de negócio ([etl-agentico](etl-agentico.md)) | **Transform** | sistema |
| 04 | **Investigar** — pessoas + agente | garimpo de fraquezas do [self-harness](self-harness.md) | — | **pessoa + agente** |
| 05 | **Propor** — hipótese + mudança | proposta mínima de edição no [harness](harness.md) | — | agente (e pessoa) |
| 06 | **Avaliar e decidir** — antes de adotar | [avaliacao-atual-vs-candidata](avaliacao-atual-vs-candidata.md) · [gate-de-regressao](gate-de-regressao.md) + [human-in-the-loop](human-in-the-loop.md) | **Load** | **regra + pessoa** |

## Self-Harness × ciclo RHAWK

| | Self-Harness (paper) | Ciclo RHAWK |
|---|---|---|
| Métrica | pass-rate em benchmark | **resultado do negócio** |
| Diagnóstico | só o agente | **pessoas + agente** |
| Mudança | edição mínima no harness | hipótese + mudança (pode ir além do harness) |
| Decisão | regra automática de não-regressão | avaliar **e decidir**: tem dono |
| Força | escala, roda sozinho | aderência ao negócio, auditável por gente |
| Risco | otimizar o benchmark | ciclo lento se a investigação depender só de gente |

**Leitura:** o ciclo RHAWK é a **versão empresarial** do Self-Harness. Ele troca o verificador técnico por evidência de negócio e põe gente nos dois pontos em que os autores do paper admitem que a automação não basta: o diagnóstico e as mudanças de alto risco.

## Onde automatizar e onde não
- **Dá para automatizar quase tudo:** 02 e 03 (é ETL), e a primeira passada do 04 (agrupar falhas por assinatura).
- **Deve ter gente:** fechar o 04 (o que importa para o negócio) e decidir no 06.
- **Princípio:** [gate-deterministico](gate-deterministico.md). A etapa 06 não pode ser pulada, então não pode depender da escolha do modelo.

## Implementação
Rodando em LangGraph: [tutorial-ciclo-rhawk-langgraph](../guias/tutorial-ciclo-rhawk-langgraph.md). Respostas da pesquisa: [respostas-perguntas-abertas](../sinteses/respostas-perguntas-abertas.md).

## Perguntas abertas
- Este ciclo **é** a [esteira-nti](../projetos/esteira-nti.md), ou é a metodologia que roda sobre ela?
- Quais KPIs de negócio entram no "Observar"?
- ~~Qual é o critério de "adotar" na etapa 06?~~ Respondido em parte por [fonte-slide-rhawk-avaliar-mudanca](../fontes/fonte-slide-rhawk-avaliar-mudanca.md): atual × candidata, 4 critérios, adotar/revisar/descartar. Faltam os limites numéricos. Ver [avaliacao-atual-vs-candidata](avaliacao-atual-vs-candidata.md).
- Com que frequência o ciclo roda (por incidente, semanal, por release)?
