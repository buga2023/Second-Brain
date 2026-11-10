---
title: Laya
tipo: entidade
tags: [modelo, decisao, roteamento, ferramenta]
fontes: [2026-11-10-repos-video-ferramentas-agentes.md]
date: 2026-11-10
---
# Laya (NandhaKishorM/laya)

Biblioteca Python (Apache-2.0; `pip install laya`) de **decisão não
autorregressiva** ("System 1"): em vez de gerar texto, devolve escolha
tipada, nota ou sim/não sobre qualquer texto numa única passada, em mais
de 100 idiomas. Um roteador escolhe o checkpoint certo por pedido. Cada
resposta traz probabilidade calibrada, conjunto de predição conformal e
flags de abstenção e de fora da distribuição. Tem extras para LangChain e
LangGraph, servidor HTTP e MCP.

- Latência anunciada de 33 ms por decisão **(não verificado)**.
- Paper: *From Laya to Vega* (Preprints 2026,
  doi 10.20944/preprints202611.0781.v1), ainda sem revisão por pares.

## Onde encaixa aqui
Candidata a nó de roteamento ou de [gate](../conceitos/gate-deterministico.md)
barato num grafo LangGraph: classificar, triar e dizer sim/não sem chamar
um LLM inteiro. A abstenção calibrada combina com o
[human-in-the-loop](../conceitos/human-in-the-loop.md) da
[esteira-nti](../projetos/esteira-nti.md): o que o modelo não sabe vai para
uma pessoa. Precisa de benchmark próprio antes de confiar.

Related: [fonte-repos-video-ferramentas-agentes](../fontes/fonte-repos-video-ferramentas-agentes.md) · [langgraph](langgraph.md)
