---
title: Gate de regressão
tipo: conceito
tags: [avaliacao, governanca, testes]
fontes: [2026-11-05-paper-self-harness-arxiv-2606.09498.md, 2026-11-05-artigo-bdtechtalks-self-improving-harnesses.md]
date: 2026-11-06
---
# Gate de regressão

A porta que decide se uma mudança proposta (por humano ou por agente) **entra**. Critério do [self-harness](self-harness.md):

- Não pode piorar **nenhum** conjunto de teste.
- Precisa melhorar **pelo menos um**.
- Trade-off é rejeitado, mesmo que o total suba.
- Repetir execuções antes de decidir (evita sorte).
- Registrar tudo: o que mudou, resultado, decisão.

É um caso de [gate-deterministico](gate-deterministico.md): **o agente propõe, a regra decide.**

Versão com critérios de negócio e a saída extra "revisar": [avaliacao-atual-vs-candidata](avaliacao-atual-vs-candidata.md).

Sem um conjunto de avaliação curado, não há gate — e sem gate, auto-evolução é só deriva.
