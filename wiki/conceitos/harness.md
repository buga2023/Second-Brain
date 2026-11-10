---
title: Harness (arnês do agente)
tipo: conceito
tags: [harness, agentes, fundamento]
fontes: [2026-11-05-paper-self-harness-arxiv-2606.09498.md, 2026-11-05-artigo-bdtechtalks-self-improving-harnesses.md]
date: 2026-11-05
---
# Harness

Tudo o que fica **em volta do modelo** e determina como ele age: prompt de sistema, ferramentas, regras de runtime (limites, retries), middleware, memória, subagentes e skills.

Analogia: o modelo é o motor; o harness é o chassi, o câmbio e o freio.

## Por que importa
- O mesmo modelo muda muito de desempenho só trocando o harness: +21 pontos no MiniMax M2.5 ([fonte-paper-self-harness](../fontes/fonte-paper-self-harness.md)).
- É a camada **mais barata, auditável e reversível** de mexer — não exige treino.
- [langchain](../entidades/langchain.md) e [langgraph](../entidades/langgraph.md) são, na prática, kits para construir harness.

## Superfícies editáveis
Instruções · políticas de runtime · ferramentas · middleware · (opcional) subagentes e skills.

## Relacionados
[self-harness](self-harness.md) · [harnessx](../entidades/harnessx.md) · [ahe](../entidades/ahe.md) · [agentes-auto-evolutivos](agentes-auto-evolutivos.md)
