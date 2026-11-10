---
title: "Síntese: Self-Harness como ETL do comportamento"
tipo: sintese
tags: [sintese, self-harness, etl, esteira, tese]
fontes: [2026-11-05-paper-self-harness-arxiv-2606.09498.md, 2026-11-05-pesquisa-web-etl-agentico.md, 2026-11-05-post-langchain-langgraph.md]
date: 2026-11-06
---
# Self-Harness como ETL do comportamento do agente

**Tese:** o loop do [self-harness](../conceitos/self-harness.md) tem a mesma forma de um pipeline [etl-agentico](../conceitos/etl-agentico.md). A diferença é o que passa pelo cano: em vez de dados de negócio, passam **as falhas do próprio agente**.

| ETL | Self-Harness | Quem decide |
|---|---|---|
| **Extract** | Coletar traces de execução ([observabilidade-de-traces](../conceitos/observabilidade-de-traces.md)) | código |
| **Transform** | Agrupar falhas por assinatura → propor edição mínima | **modelo** |
| **Load** | Promover a edição ao harness ativo, se passar no [gate-de-regressao](../conceitos/gate-de-regressao.md) | **regra** (+ pessoa se alto risco) |

## Por que a analogia ajuda
- Times de dados já sabem operar ETL: agendamento, qualidade, quarentena, rollback. Dá pra **reusar a disciplina** para a evolução de agentes.
- Deixa explícito onde o modelo tem liberdade (Transform) e onde não tem (Load) → [gate-deterministico](../conceitos/gate-deterministico.md).
- As mesmas armadilhas: retry sem limite, custo de LLM, "consertos" que quebram outra coisa.

## Desenho proposto para uma esteira (rascunho para [esteira-nti](../projetos/esteira-nti.md))
1. **Fluxo em [langgraph](../entidades/langgraph.md)** com etapas fixas; agente [langchain](../entidades/langchain.md) só nas etapas de julgamento.
2. **Todo passo vira trace** desde o dia 1.
3. **Conjunto de avaliação** curado com casos reais (visto + reservado).
4. **Loop noturno de Self-Harness**: lê traces da semana → propõe edições → roda o gate.
5. **Promoção**: automática se baixo risco e gate verde; com [human-in-the-loop](../conceitos/human-in-the-loop.md) se mexer em ação que envia, paga ou apaga.
6. **Registro auditável** de toda proposta, aceita ou rejeitada.

## Reforço (06/11/2026)
O [ciclo-de-evolucao-rhawk](../conceitos/ciclo-de-evolucao-rhawk.md) chega à mesma estrutura por outro caminho. A etapa "Preparar: evidências conectadas" é o Transform, e "Avaliar e decidir antes de adotar" é o Load com gate. A diferença é que a métrica é o resultado do negócio, e pessoas entram na investigação.

## Frase-síntese
> O modelo propõe a própria melhoria. A esteira decide se ela entra.

Conecta com o fecho do post: *"Vibe para explorar. Verify para escalar."* — Self-Harness é o **Verify automatizado**.
