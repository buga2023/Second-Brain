---
fonte: Docs oficiais LangChain + repositório langchain-ai/langchain-skills + PyPI
url: https://docs.langchain.com , https://github.com/langchain-ai/langchain-skills , https://pypi.org
tipo: documentacao
capturado: 2026-11-06
nota: Skills lidas na íntegra (commit 126c384, 2026-10-26). Exemplos testados localmente em ~/Projetos/estudo-langgraph.
---

## Versões (PyPI, 06/11/2026)
langchain 1.4.9 (04/11) · langgraph 1.2.20 (05/11) · langchain-anthropic 1.7.10 · langsmith 0.14.17 · deepagents 0.7.34 · langgraph-checkpoint-sqlite 3.1.3

## Pilha oficial (skill ecosystem-primer)
- Deep Agents (topo, "harness"): planejamento, arquivos, subagentes, memória, skills. `create_deep_agent`.
- LangGraph (meio, "runtime"): execução durável, fluxo customizado, estado. `StateGraph`.
- LangChain (base, "framework"): modelos, ferramentas, loop do agente. `create_agent`.
- LangSmith (transversal): observabilidade e avaliação.
Regra de escolha (na ordem, para no primeiro que bater): planejamento/arquivos/memória/subagentes → Deep Agents; fluxo customizado (laços, ramificações) → LangGraph; agente de propósito único → LangChain create_agent; chamada simples/RAG → LangChain direto.
Env do LangSmith: LANGSMITH_API_KEY, LANGSMITH_TRACING=true, LANGSMITH_PROJECT (os nomes antigos não funcionam mais).

## LangChain v1
- `create_agent(model="anthropic:...", tools=[...], system_prompt=..., checkpointer=..., middleware=[...], response_format=Pydantic)`; substitui `create_react_agent`; `prompt` virou `system_prompt`; a API legada foi para `langchain-classic`.
- Resultado: `result["messages"][-1].content`; saída estruturada em `result["structured_response"]`.
- Memória: checkpointer + `{"configurable": {"thread_id": ...}}`.
- `recursion_limit` no config contra loop infinito.
- Middleware pronto: HumanInTheLoopMiddleware, PIIMiddleware, SummarizationMiddleware.
- HITL: `interrupt_on={"ferramenta": {"allowed_decisions": ["approve","edit","reject"]}}`; retomar com `Command(resume={"decisions":[{"type":"approve"}]})`; exige checkpointer + thread_id; só interrompe ANTES de a ferramenta executar.
- Hooks customizados: `@before_model`, `@after_model`, `@before_agent`, `@after_agent` (state, runtime); `@wrap_tool_call`, `@wrap_model_call` (request, handler) — não usar yield.

## LangGraph
- Projeto em 5 passos: mapear etapas → classificar cada nó (LLM, dados, ação, entrada humana) → desenhar o estado → construir os nós → ligar as arestas.
- Arestas: `add_edge` (fixa), `add_conditional_edges` (rota por estado), `Command(update, goto)` (atualiza e roteia), `Send` (fan-out paralelo; exige reducer).
- AVISO: Command só ADICIONA rota dinâmica; se existir add_edge saindo do mesmo nó, os dois caminhos rodam.
- Reducers: sem reducer, a última escrita vence; `Annotated[list, operator.add]` acumula.
- Erros: transitório → `RetryPolicy(max_attempts=3)`; recuperável pelo LLM → `ToolNode(handle_tool_errors=True)`; corrigível por pessoa → `interrupt`; inesperado → deixar subir.
- Stream modes: values, updates, messages, custom.
- interrupt: exige checkpointer + thread_id + payload JSON-serializável; o NÓ REINICIA DO COMEÇO ao retomar → efeitos colaterais antes do interrupt precisam ser idempotentes (upsert) ou ficar depois dele. Não envolver em try/except genérico. Múltiplos interrupts paralelos: resume com o mapa {id: valor}.
- Persistência: InMemorySaver (dev), SqliteSaver (local), PostgresSaver (produção; `.setup()` uma vez). `get_state_history` (time travel), `update_state` (passa por reducers; usar `Overwrite` para substituir). Store para memória entre threads (`runtime.store`).
- Subgrafo: checkpointer=False / None (padrão, permite interrupt) / True (memória multi-turno).

## Ferramentas para Claude Code
- MCP: `claude mcp add --transport http docs-langchain --scope user https://docs.langchain.com/mcp` e `reference-langchain` → https://reference.langchain.com/mcp. Índice: https://docs.langchain.com/llms.txt
- Skills (MIT, 22 no total): plugin `/plugin marketplace add langchain-ai/langchain-skills` + `/plugin install langchain-skills@langchain-skills`; ou `npx skills add langchain-ai/langchain-skills ...`; ou install.sh. O projeto se declara em desenvolvimento inicial.
