---
title: Métricas de valor (os 4 critérios do RHAWK, medidos)
tipo: conceito
tags: [metricas, kpi, custo, resolucao]
fontes: [2026-11-06-pesquisa-web-avaliacao-governanca.md, 2026-11-06-slide-rhawk-avaliar-mudanca.md]
date: 2026-11-06
---
# Métricas de valor

Como transformar os 4 critérios de [avaliacao-atual-vs-candidata](avaliacao-atual-vs-candidata.md) em número.

| Critério RHAWK | Métrica | Armadilha |
|---|---|---|
| Mais problemas resolvidos | **resolução efetiva** = resolvidos − reabertos | não confundir com deflexão (conta desistência como sucesso) |
| Menos retornos e retrabalho | **reabertura** em 24–48 h pelo mesmo cliente; % de correção humana | resolução alta com reabertura alta = "contenção com roupa melhor" |
| Qualidade preservada | nota de revisão humana amostral; erros graves; recusas indevidas | é guarda: não pode cair |
| Custo aceitável | **custo por resolução efetiva** (tokens + tempo humano) | contar retries e reprocessamento |

## Referências de mercado (fornecedor, **não verificado**)
- Resolução por IA: 65–70% (padrão) · 85%+ (plataforma dedicada) · <50% = chatbot de deflexão.
- Custo por resolução: IA ≈ US$0,60–1,30 × humano US$7–15+.
- Gartner (de segunda mão): GenAI passa de US$3 por resolução até 2030.

## Fórmula de economia
`economia = resolvidos_efetivos_IA × (custo_humano − custo_IA)`

**Use os seus números, não os do mercado.** O baseline é a versão atual (champion).
