---
title: ETL agêntico
tipo: conceito
tags: [etl, dados, pipelines, self-healing]
fontes: [2026-11-05-pesquisa-web-etl-agentico.md]
date: 2026-11-05
---
# ETL agêntico

Pipelines de dados (Extract → Transform → Load) em que agentes LLM **constroem, rodam e reparam** o pipeline.

## Arquitetura em 3 camadas
1. **Percepção** — metadados, schemas, [observabilidade-de-traces](observabilidade-de-traces.md).
2. **Raciocínio** — o LLM diagnostica e escolhe a ação.
3. **Ações permitidas** — lista fechada: refazer job, ajustar schema, quarentenar lote.

## Boas práticas
- Determinístico primeiro: SQL filtra, LLM só explica exceções. Nunca LLM por registro.
- Retries **com limite**, só para falhas recuperáveis (rate limit, schema transitório).
- Logar todo prompt e resposta.
- Ação destrutiva (apagar, sobrescrever produção) → [human-in-the-loop](human-in-the-loop.md).

## Onde quebra
Remediação autônoma sem limite. Custo de LLM em retry.

## Cuidado
Números de ganho vêm de fornecedores **(não verificado)**.

## Relacionados
[langgraph](../entidades/langgraph.md) (o grafo é um bom motor para ETL com exceções) · [self-harness-como-etl](../sinteses/self-harness-como-etl.md) · [esteira-nti](../projetos/esteira-nti.md)
