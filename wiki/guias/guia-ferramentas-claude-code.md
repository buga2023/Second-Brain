---
title: "Guia: ferramentas LangChain instaladas no Claude Code"
tipo: guia
tags: [guia, claude-code, skills, mcp]
fontes: [2026-11-06-docs-langchain-langgraph-skills.md]
date: 2026-11-06
---
# Ferramentas LangChain instaladas no Claude Code (06/11/2026)

## 1. Skills oficiais (em `~/.claude/skills/`, globais)
Origem: github.com/langchain-ai/langchain-skills (MIT, commit 126c384). **Copiei só as 15 skills que são markdown puro**; o script de instalação não foi executado.

| Peça o quê | Skill que entra |
|---|---|
| "qual camada uso?" | `ecosystem-primer` (sempre a primeira) |
| agente com ferramentas | `langchain-fundamentals`, `langchain-python-quickstart` |
| aprovação, middleware, saída estruturada | `langchain-middleware` |
| RAG, busca em documentos | `langchain-rag` |
| versões e instalação | `langchain-dependencies` |
| grafo, nós, arestas | `langgraph-fundamentals`, `langgraph-python-quickstart` |
| pausa para humano | `langgraph-human-in-the-loop` |
| estado durável, memória | `langgraph-persistence` |
| deploy (`langgraph dev/build/deploy`) | `langgraph-cli` |
| agente com plano, arquivos, subagentes | `deep-agents-core`, `-orchestration`, `-memory`, `deepagents-python-quickstart` |

**Ficaram de fora** (trazem scripts executáveis; instalar só se precisar): `eval-engineering` (avaliação com Harbor/Docker), `swarm`, `managed-deep-agents`, `langgraph-decision-models` e as versões TypeScript.

**Como usar:** é só pedir em português ("monta um grafo LangGraph com aprovação humana"). O Claude Code carrega a skill sozinho. Também dá para invocar pelo nome: `/langgraph-fundamentals`.

## 2. MCP da documentação oficial (escopo de usuário)
- `docs-langchain` → https://docs.langchain.com/mcp (guias, tutoriais, LangSmith)
- `reference-langchain` → https://reference.langchain.com/mcp (referência da API)

Ficam ativos a partir da **próxima sessão** do Claude Code. Conferir com `claude mcp list`. Sem MCP, o índice fica em https://docs.langchain.com/llms.txt.

## 3. Projeto de estudo
`~/Projetos/estudo-langgraph`: venv com langchain 1.4.9, langgraph 1.2.20, langchain-anthropic, checkpoint-sqlite. Ver [tutorial-ciclo-rhawk-langgraph](tutorial-ciclo-rhawk-langgraph.md).

## 4. Falta configurar (é com você)
- `ANTHROPIC_API_KEY`: para o agente LangChain chamar o modelo.
- `LANGSMITH_API_KEY` + `LANGSMITH_TRACING=true` + `LANGSMITH_PROJECT`: para traces e avaliação ([langsmith](../entidades/langsmith.md)). Plano gratuito em smith.langchain.com.

## Atualizar as skills
```bash
cd /tmp && git clone --depth 1 https://github.com/langchain-ai/langchain-skills.git
# revise o diff e copie de config/skills/<nome> para ~/.claude/skills/
```
