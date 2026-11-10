---
title: Self-Harness
tipo: conceito
tags: [self-harness, auto-evolucao, harness]
fontes: [2026-11-05-paper-self-harness-arxiv-2606.09498.md, 2026-11-05-artigo-bdtechtalks-self-improving-harnesses.md]
date: 2026-11-05
---
# Self-Harness

Paradigma em que **o próprio agente reescreve seu [harness](harness.md)** a partir das próprias falhas, sem humano e sem modelo mais forte. Proposto por [shanghai-ai-lab](../entidades/shanghai-ai-lab.md) ([fonte-paper-self-harness](../fontes/fonte-paper-self-harness.md)).

## O loop
1. **Garimpo de fraquezas** — roda tarefas, agrupa falhas por *assinatura* (causa no verificador + comportamento + mecanismo). Agrupa padrões, não sintomas.
2. **Proposta** — gera várias edições **mínimas**, cada uma mirando 1 falha em 1 superfície. Proibido reescrever a arquitetura.
3. **Validação** — [gate-de-regressao](gate-de-regressao.md) em dois conjuntos (visto e nunca visto). Entra só se não piorar nenhum e melhorar algum. Tudo registrado.

## Exemplos de regras que o agente criou
- Gerar cedo o arquivo de saída exigido.
- Quebrar loops de exploração e retry.
- Checar dependências antes de começar.
- Manter variáveis de ambiente entre sessões de shell.

→ São **boas práticas de engenharia descobertas automaticamente** — o mesmo tipo de regra que um sênior escreveria num checklist.

## Resultados
Ver tabela em [fonte-paper-self-harness](../fontes/fonte-paper-self-harness.md). Destaque: MiniMax M2.5 40,5% → 61,9% em [terminal-bench](../entidades/terminal-bench.md).

## Limites
- Depende de verificador bom. Sem teste automático confiável, não há loop.
- Regras podem estar ajustadas ao benchmark.
- Os próprios autores: não-regressão não basta para mudança de alto risco → aí entra [human-in-the-loop](human-in-the-loop.md).

## Leitura de negócio
Ver [self-harness-como-etl](../sinteses/self-harness-como-etl.md).
