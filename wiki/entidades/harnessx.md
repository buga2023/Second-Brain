---
title: HarnessX (Xiaomi)
tipo: entidade
tags: [framework, harness, open-source, auto-evolucao]
fontes: [2026-11-05-artigo-bdtechtalks-self-improving-harnesses.md]
date: 2026-11-05
---
# HarnessX

arXiv 2606.14249, pesquisadores da Xiaomi. Open source (YAML; integra MemPalace e VERL).

- [harness](../conceitos/harness.md) como software modular: "processors" plugados em hooks de ciclo de vida.
- Motor **AEGIS** com 4 agentes: Digester → Planner → Evolver → **Critic** (barra reward hacking e regressão).
- +14,5% médio (ALFWorld, GAIA, SWE-bench Verified) só com harness; +4,7% co-evoluindo o modelo.
- Modelos pequenos ganham mais.

Comparar com [self-harness](../conceitos/self-harness.md): mesmo loop, mas com papéis separados em agentes distintos.
