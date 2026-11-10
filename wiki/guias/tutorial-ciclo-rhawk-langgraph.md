---
title: "Tutorial: o ciclo RHAWK em LangGraph (rodável)"
tipo: guia
tags: [tutorial, langgraph, rhawk, gate, interrupt]
fontes: [2026-11-06-docs-langchain-langgraph-skills.md, 2026-11-06-slide-rhawk-ciclo-evolucao.md, 2026-11-06-slide-rhawk-avaliar-mudanca.md]
date: 2026-11-06
---
# Tutorial: o ciclo RHAWK em LangGraph

Código: `~/Projetos/estudo-langgraph/ciclo_rhawk.py`. **Roda sem chave de API**: os dados são simulados, mas a mecânica é real. Testado em 06/11/2026.

## O grafo
```
START → observar → preparar → investigar → propor → avaliar → decidir ⏸
                                              ↑                    │
                                              └──── revisar ───────┤
                                                       adotar → FIM │
                                                    descartar → FIM ┘
```

| Nó | Etapa RHAWK | Tipo de nó | Conceito LangGraph |
|---|---|---|---|
| observar | 02 | dados | nó simples |
| preparar | 03 | dados (ETL) | calcula as métricas da versão atual |
| investigar | 04 | (seria LLM + pessoa) | ponto onde entraria o [guia-langchain](guia-langchain.md) |
| propor | 05 | (seria LLM) | conta as tentativas no estado |
| avaliar | 06a | **regra** | [gate-deterministico](../conceitos/gate-deterministico.md) em código |
| decidir | 06b | **humano** | `interrupt()` + `Command(goto)` |
| adotar | — | ação | efeito colateral só depois da aprovação |

## Rodar
```bash
cd ~/Projetos/estudo-langgraph && source .venv/bin/activate
python ciclo_rhawk.py iniciar melhoria-001
python ciclo_rhawk.py decidir melhoria-001 revisar
python ciclo_rhawk.py decidir melhoria-001 adotar
python ciclo_rhawk.py historico melhoria-001
```

## O que aconteceu no teste
1. **Proposta 1:** resolução de 60% → 80%, mas custo de 0,66 → 0,95 por caso. O gate recomendou **REVISAR**: ganho, mas violou a guarda de custo (teto 0,75).
2. O humano escolheu "revisar" **em outro processo**. O estado veio do `ciclo.db`: isso é a execução durável.
3. **Proposta 2:** resolução de 80%, retrabalho de 20% → 10%, custo 0,60. O gate recomendou **ADOTAR**.
4. O humano adotou e o fluxo terminou. O histórico mostra 12 checkpoints e a trilha de auditoria completa.

## Lições que o código deixa visíveis
- **A regra decide, o humano assina.** O gate recomenda, mas o `interrupt` é obrigatório. A aresta `avaliar → decidir` não pode ser pulada.
- **Os limites ficam fora do modelo:** `CUSTO_MAX` é uma constante, ou seja, a alçada é definida antes do código.
- **Log com reducer** (`operator.add`) = trilha auditável de graça.
- **"Revisar" é um laço** no grafo, não uma tarefa manual.

## Exercícios para evoluir
1. Trocar `investigar` por um agente LangChain (copiar de `agente_investigador.py`).
2. Ler `CUSTO_MAX` de um arquivo `politica.yaml`.
3. Adicionar `RetryPolicy` no `observar` (simula uma API instável).
4. Adicionar um nó `canario` depois de `adotar`, com gatilho de rollback ([canary-e-rollback](../conceitos/canary-e-rollback.md)).
5. Trocar `SqliteSaver` por `PostgresSaver`.
