---
title: "Síntese: respostas às perguntas abertas do ciclo RHAWK"
tipo: sintese
tags: [sintese, avaliacao, governanca, rollout]
fontes: [2026-11-06-pesquisa-web-avaliacao-governanca.md, 2026-11-06-slide-rhawk-avaliar-mudanca.md]
date: 2026-11-06
---
# Respostas às perguntas abertas

Perguntas de [avaliacao-atual-vs-candidata](../conceitos/avaliacao-atual-vs-candidata.md) e [ciclo-de-evolucao-rhawk](../conceitos/ciclo-de-evolucao-rhawk.md), respondidas com o que existe publicado.

### 1. Quais os limites numéricos ("custo aceitável")?
**Não existe padrão de mercado.** O consenso é:
- O limite é **relativo à versão atual** (baseline), não absoluto.
- Ganho: tem que **superar a variação natural** do LLM (até ~15%). Repita as execuções e exija uma diferença acima do ruído.
- Guarda de custo: teto definido pelo negócio, ex.: custo por resolução efetiva ≤ X% do custo humano.
- Referências de mercado em [metricas-de-valor](../conceitos/metricas-de-valor.md) (não verificadas).

### 2. Comparar offline, A/B ou os dois?
**Os dois, em sequência:** offline (barra regressão) → shadow, se a mudança for grande → canário → 100%. Ver [avaliacao-offline-e-online](../conceitos/avaliacao-offline-e-online.md) e [canary-e-rollback](../conceitos/canary-e-rollback.md).

### 3. Quem assina o "adotar"?
**Uma pessoa nomeada por caso de uso (RACI)**, com alçada proporcional ao risco. Mudança que envia, paga ou apaga nunca é automática. Ver [governanca-e-alcadas](../conceitos/governanca-e-alcadas.md).

### 4. Quanto tempo acompanhar depois e o que dispara rollback?
- **Gatilho escrito antes**, com indicadores adiantados (erro, falha de ferramenta, custo, latência) em janelas curtas (ex.: 15 min, >1,5× o baseline).
- **Acompanhamento** pelos indicadores atrasados (reabertura em 24–48 h, resolução) até completar ao menos **um ciclo de negócio** (ex.: uma semana com todos os dias úteis). Isso é inferência do vault, não fonte.

### 5. Com que frequência o ciclo roda?
Sem fonte específica. Prática comum: **por incidente** (gatilho) + **revisão periódica** (semanal ou quinzenal) dos traces agregados. O Self-Harness roda em lote sobre um conjunto de tarefas.

### Continuam abertas
- O que é a [esteira-nti](../projetos/esteira-nti.md) e qual a relação com a [rhawk](../entidades/rhawk.md).
- Os números reais da operação (baseline).
