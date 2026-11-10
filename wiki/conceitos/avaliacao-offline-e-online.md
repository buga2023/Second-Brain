---
title: Avaliação offline e online
tipo: conceito
tags: [avaliacao, langsmith, ab-test]
fontes: [2026-11-06-pesquisa-web-avaliacao-governanca.md]
date: 2026-11-06
---
# Avaliação offline e online

**Não é "um ou outro". Os dois juntos formam o ciclo.**

| | Offline (antes de adotar) | Online (depois de adotar) |
|---|---|---|
| Dados | dataset congelado (casos reais passados) | tráfego real |
| Pergunta | a candidata é melhor que a atual nos mesmos casos? | continua melhor no mundo real? |
| Força | reprodutível, barato, barra regressão antes do usuário ver | pega o que o dataset não tem |
| Ferramenta | experimentos + pairwise no [langsmith](../entidades/langsmith.md), pytest/CI | avaliadores online, A/B, [canary-e-rollback](canary-e-rollback.md) |
| No ciclo RHAWK | 06 Avaliar | "acompanhar a operação novamente" → 01/02 |

## O laço que fecha
Falha em produção → vira caso no dataset offline → a próxima candidata precisa passar nele. É o "Observar → Preparar" do [ciclo-de-evolucao-rhawk](ciclo-de-evolucao-rhawk.md), e o garimpo do [self-harness](self-harness.md).

## Champion × challenger
Dividir o tráfego entre a atual (champion) e a candidata (challenger) e medir o **resultado de negócio**. É a evidência mais forte, e também a mais cara e lenta.
