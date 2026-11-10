---
title: "Paper: Self-Harness (arXiv 2606.09498)"
tipo: fonte
tags: [self-harness, paper, terminal-bench, auto-evolucao]
fontes: [2026-11-05-paper-self-harness-arxiv-2606.09498.md]
date: 2026-11-05
---
# Paper: Self-Harness — Harnesses That Improve Themselves

[shanghai-ai-lab](../entidades/shanghai-ai-lab.md), jun/2026. Fonte primária do conceito [self-harness](../conceitos/self-harness.md).

## Pontos-chave
- O agente melhora o próprio [harness](../conceitos/harness.md) — prompts, ferramentas, regras de runtime — **sem humano e sem modelo mais forte**. Pesos e avaliador fixos.
- Loop de 3 etapas: garimpo de fraquezas → proposta mínima → validação com [gate-de-regressao](../conceitos/gate-de-regressao.md).
- Harness inicial é mínimo de propósito (prompt curto, shell, arquivos).
- As regras geradas são diferentes por modelo: cada modelo tem "manias" próprias.

## Números ([terminal-bench](../entidades/terminal-bench.md) 2.0, 64 tarefas, held-out)
| Modelo | Antes | Depois |
|---|---|---|
| MiniMax M2.5 | 40,5% | 61,9% |
| Qwen3.5-35B-A3B | 23,8% | 38,1% |
| GLM-5 | 42,9% | 57,1% |

## Contradições
- A seção 4.3 do paper cita outros números para as mesmas execuções (MiniMax 42,2% → 53,9%), sem reconciliação.

## Limitações declaradas
Um benchmark, 64 tarefas, 3 modelos; depende de verificador e traces de qualidade; held-out também é usado como gate; não-regressão não basta para mudanças de alto risco.
