---
title: Avaliação versão atual × versão candidata
tipo: conceito
tags: [avaliacao, gate, governanca, rhawk, self-harness]
fontes: [2026-11-06-slide-rhawk-avaliar-mudanca.md, 2026-11-05-paper-self-harness-arxiv-2606.09498.md]
date: 2026-11-06
---
# Avaliação versão atual × versão candidata

Como decidir se uma mudança no agente entra. É a etapa 06 do [ciclo-de-evolucao-rhawk](ciclo-de-evolucao-rhawk.md) e a versão de negócio do [gate-de-regressao](gate-de-regressao.md).

## O método (RHAWK)
1. Rodar a **atual** e a **candidata** sob os **mesmos critérios**.
2. Perguntar:

| Critério | Tipo | Exemplo de métrica |
|---|---|---|
| Mais problemas resolvidos? | **ganho** | taxa de resolução sem humano |
| Menos retornos e retrabalho? | **ganho** | % de casos reabertos ou corrigidos |
| Qualidade preservada? | **guarda** (não pode piorar) | nota de revisão, erros graves |
| Custo aceitável? | **guarda** (teto) | custo por caso resolvido (tokens, tempo humano) |

3. Decidir: **adotar · revisar · descartar**.
4. Se adotar, voltar a observar em produção.

## Comparação com o gate do [self-harness](self-harness.md)

| | Self-Harness | RHAWK |
|---|---|---|
| Base de comparação | harness atual × candidato | versão atual × candidata ✅ igual |
| Critérios | pass-rate em 2 conjuntos de teste | 4 critérios de negócio |
| Regra | não piora nenhum e melhora algum | **não explícita no slide** |
| Saídas | aceitar / rejeitar | adotar / **revisar** / descartar |
| Depois de adotar | nada (benchmark fixo) | **acompanhar a operação** ✅ |

O que o RHAWK acrescenta:
- **"Revisar"**: a hipótese é boa, mas a mudança precisa de ajuste. Ela volta para 05 Propor em vez de ser jogada fora.
- **Acompanhar depois de adotar**: protege contra a mudança que passa no teste e falha na vida real, que é a principal limitação do paper.

## Proposta de regra explícita (sugestão do vault)
Junta os dois mundos:
- **Adotar** se: melhora pelo menos 1 critério de ganho **e** não piora nenhum critério de guarda **e** não piora o outro critério de ganho. Isso vale em execuções repetidas, como faz o Self-Harness para evitar sorte.
- **Revisar** se: melhora ganho, mas viola uma guarda (por exemplo, resolve mais, porém custa demais).
- **Descartar** se: não melhora nenhum ganho, ou piora a qualidade.
- **Mudança que envia, paga ou apaga:** mesmo com tudo verde, a decisão final é humana ([human-in-the-loop](human-in-the-loop.md)).

## Respostas (06/11/2026)
Ver [respostas-perguntas-abertas](../sinteses/respostas-perguntas-abertas.md). Implementado como código em [tutorial-ciclo-rhawk-langgraph](../guias/tutorial-ciclo-rhawk-langgraph.md).

## Perguntas abertas (originais)
- Quais são os **limites numéricos** (quanto é "custo aceitável")?
- Com quais casos se compara: reprocessamento de casos passados (offline), teste A/B em produção, ou os dois?
- Quem assina o "adotar"?
- Por quanto tempo se acompanha depois de adotar, e o que dispara o rollback?
