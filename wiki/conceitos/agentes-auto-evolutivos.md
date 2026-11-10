---
title: Agentes auto-evolutivos
tipo: conceito
tags: [auto-evolucao, surveys, agentes]
fontes: [2026-11-05-pesquisa-web-harness-e-auto-evolucao.md, 2026-11-05-paper-self-harness-arxiv-2606.09498.md]
date: 2026-11-05
---
# Agentes auto-evolutivos

Agentes cuja capacidade **muda e persiste** entre execuções a partir da própria experiência.

## Mapa do campo ([survey-gao-tmlr-2026](../entidades/survey-gao-tmlr-2026.md))
- **O que evoluir:** pesos do modelo · memória · ferramentas · prompts · arquitetura ([harness](harness.md)).
- **Quando:** durante a tarefa ou entre tarefas.
- **Como:** feedback de verificador, reflexão, busca evolutiva, RL.
- **Onde:** código, educação, saúde...

## Níveis (preprint set/2026, sem revisão)
L0 saída → ... → L4 critério (o agente muda o próprio jeito de se avaliar — o mais perigoso).

## Vias (HKUST-GZ)
Consolidativa · Adaptativa por feedback · Expansiva · Reconfigurativa.

## Onde estão os resultados práticos hoje
Evoluir o **harness** (não os pesos): [self-harness](self-harness.md), [harnessx](../entidades/harnessx.md), [ahe](../entidades/ahe.md). Barato, reversível, auditável.

## Próxima fronteira
Evoluir o **mecanismo que evolui** (Hierarchical Self-Improvement, HarnessEvolve, HarnessForge).

## Perguntas abertas
- Como provar que melhorou, e não só decorou o benchmark?
- Quem aprova uma mudança no critério de avaliação (L4)? → [human-in-the-loop](human-in-the-loop.md)
