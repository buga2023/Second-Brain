---
title: Índice do wiki
date: 2026-11-10
tags: [meta]
---

# Índice do wiki

Ponto de entrada: [overview](overview.md) · Histórico: [log](../log.md) · Fontes brutas: [raw](../raw/README.md)

## Guias (como fazer)
- [guia-orca-orquestracao](guias/guia-orca-orquestracao.md): workers no Orca; armadilhas e o plano B que funcionou.
- [guia-langchain](guias/guia-langchain.md): create_agent, ferramentas, memória, saída estruturada, middleware, HITL.
- [guia-langgraph](guias/guia-langgraph.md): StateGraph, arestas, Command, checkpointer, interrupt, erros.
- [tutorial-ciclo-rhawk-langgraph](guias/tutorial-ciclo-rhawk-langgraph.md): ciclo RHAWK rodando em LangGraph (sem chave de API).
- [guia-ferramentas-claude-code](guias/guia-ferramentas-claude-code.md): skills e MCP instalados, o que falta configurar.

## Sínteses
- [respostas-perguntas-abertas](sinteses/respostas-perguntas-abertas.md): limites, offline×online, quem assina, rollback, frequência.
- [self-harness-como-etl](sinteses/self-harness-como-etl.md) — tese: o loop de Self-Harness é um ETL das falhas do agente; rascunho de esteira.
- [decidir-langchain-ou-langgraph](sinteses/decidir-langchain-ou-langgraph.md) — tabela de decisão de camada.

## Projetos
- [esteira-nti](projetos/esteira-nti.md): documentada; skill + repo no GitHub (buga2023/esteira-nti).

## Conceitos
- [avaliacao-offline-e-online](conceitos/avaliacao-offline-e-online.md): dataset congelado antes, tráfego real depois; champion×challenger.
- [canary-e-rollback](conceitos/canary-e-rollback.md): shadow → canário → 100%; gatilho de rollback escrito antes.
- [metricas-de-valor](conceitos/metricas-de-valor.md): os 4 critérios RHAWK em número; resolução efetiva, reabertura, custo.
- [governanca-e-alcadas](conceitos/governanca-e-alcadas.md): RACI, escala de alçada, NIST, EU AI Act.
- [avaliacao-atual-vs-candidata](conceitos/avaliacao-atual-vs-candidata.md): atual × candidata, 4 critérios de negócio, adotar/revisar/descartar; proposta de regra explícita.
- [ciclo-de-evolucao-rhawk](conceitos/ciclo-de-evolucao-rhawk.md): 6 etapas Operar→Avaliar; a versão empresarial do Self-Harness, medida pelo negócio.
- [harness](conceitos/harness.md) — tudo em volta do modelo: prompt, ferramentas, regras, middleware.
- [self-harness](conceitos/self-harness.md) — agente reescreve o próprio harness: garimpo → proposta → validação.
- [agentes-auto-evolutivos](conceitos/agentes-auto-evolutivos.md) — mapa do campo: o quê, quando, como evoluir; níveis L0–L4.
- [etl-agentico](conceitos/etl-agentico.md) — agentes que constroem e reparam pipelines; determinístico primeiro.
- [gate-de-regressao](conceitos/gate-de-regressao.md) — não piora nada, melhora algo, registra tudo.
- [gate-deterministico](conceitos/gate-deterministico.md) — etapa obrigatória não depende do modelo.
- [human-in-the-loop](conceitos/human-in-the-loop.md) — alçada humana: enviar, pagar, apagar, assinar.
- [observabilidade-de-traces](conceitos/observabilidade-de-traces.md) — trace é matéria-prima da auto-evolução.

## Entidades
- [laya](entidades/laya.md): decisão em uma passada (escolha, nota, sim/não) com abstenção calibrada; candidato a gate/roteador.
- [humanizer](entidades/humanizer.md): skill que tira as marcas de texto escrito por IA.
- [scroll-craft](entidades/scroll-craft.md): skill de sites imersivos guiados por scroll.
- [voicestudio](entidades/voicestudio.md): estúdio de voz local (clonagem, dublagem, transcrição); AGPL.
- [rea](entidades/rea.md): MCP de engenharia reversa (binários, Electron, .NET, web).
- [langsmith](entidades/langsmith.md): tracing, datasets, pairwise, avaliadores online.
- [deep-agents](entidades/deep-agents.md): camada harness da LangChain (plano, arquivos, subagentes).
- [rhawk](entidades/rhawk.md): rhawk.pro, autora do ciclo de evolução (relação a confirmar).
- [langchain](entidades/langchain.md) — biblioteca para montar agentes.
- [langgraph](entidades/langgraph.md) — motor de orquestração com estado durável e interrupção.
- [harnessx](entidades/harnessx.md) — Xiaomi; harness modular + 4 agentes (AEGIS); +14,5%.
- [ahe](entidades/ahe.md) — Agentic Harness Engineering; 77,0% vs 71,9% do Codex-CLI.
- [terminal-bench](entidades/terminal-bench.md) — benchmark de tarefas em terminal.
- [shanghai-ai-lab](entidades/shanghai-ai-lab.md) — autores do Self-Harness.
- [survey-gao-tmlr-2026](entidades/survey-gao-tmlr-2026.md) — survey de referência do campo.

## Fontes
- [fonte-repos-video-ferramentas-agentes](fontes/fonte-repos-video-ferramentas-agentes.md): 6 repos de um vídeo (Humanizer, Grill Me, Laya, ScrollCraft, VoiceStudio, REA).
- [fonte-docs-langchain-langgraph](fontes/fonte-docs-langchain-langgraph.md): skills oficiais e docs, versões atuais.
- [fonte-pesquisa-avaliacao-governanca](fontes/fonte-pesquisa-avaliacao-governanca.md): avaliação, rollout, métricas, governança.
- [fonte-slide-rhawk-avaliar-mudanca](fontes/fonte-slide-rhawk-avaliar-mudanca.md): slide "como saber se a mudança gerou mais valor".
- [fonte-slide-rhawk-ciclo-evolucao](fontes/fonte-slide-rhawk-ciclo-evolucao.md): slide do ciclo de evolução orientado ao negócio.
- [fonte-post-langchain-langgraph](fontes/fonte-post-langchain-langgraph.md) — post colado (referência de formato).
- [fonte-paper-self-harness](fontes/fonte-paper-self-harness.md) — paper primário, arXiv 2606.09498.
- [fonte-bdtechtalks-self-improving-harnesses](fontes/fonte-bdtechtalks-self-improving-harnesses.md) — artigo; lições para empresa.
- [fonte-pesquisa-harness-e-auto-evolucao](fontes/fonte-pesquisa-harness-e-auto-evolucao.md) — varredura: AHE, surveys.
- [fonte-pesquisa-etl-agentico](fontes/fonte-pesquisa-etl-agentico.md) — varredura: fornecedores e boas práticas.
- [fonte-pesquisa-esteira-nti](fontes/fonte-pesquisa-esteira-nti.md) — busca sem resultado.

Related: [00-Index](../00-Index.md) · [overview](overview.md)
