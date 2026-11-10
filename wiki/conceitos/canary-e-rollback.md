---
title: Shadow, canário e rollback
tipo: conceito
tags: [rollout, canary, rollback, producao]
fontes: [2026-11-06-pesquisa-web-avaliacao-governanca.md]
date: 2026-11-06
---
# Shadow, canário e rollback

Como uma candidata aprovada no offline entra em produção sem susto.

1. **Shadow:** recebe uma cópia do tráfego, responde, mas ninguém vê. Só vale com avaliação automática das respostas. Dobra o custo, então use só em mudança grande (troca de modelo, nova ferramenta).
2. **Canário:** atende de verdade uma fração pequena. Rampa típica de 1 → 5 → 20 → 50 → 100%.
3. **Rollback:** volta automático para a atual quando um gatilho dispara.

## Regra de ouro
> "Canário sem critério de rollback escrito é um incidente lento."

O gatilho é escrito **antes** de começar. Exemplo da fonte: taxa de disparo de guarda numa janela de 15 min passa de 1,5× o baseline → rollback imediato.

## O que monitorar
- **Adiantados (minutos):** erro, falha de ferramenta, recusa, pico de tokens, latência p99, custo por requisição.
- **Atrasados (dias):** resolução, reabertura, satisfação. Ver [metricas-de-valor](metricas-de-valor.md).
- LLM não é determinístico (até 15% de variação) → use **faixa de tolerância**, não um limite seco.

## Em LangGraph
O estado durável permite pausar, voltar ao checkpoint anterior e reprocessar ("time travel"). Ver [guia-langgraph](../guias/guia-langgraph.md).
