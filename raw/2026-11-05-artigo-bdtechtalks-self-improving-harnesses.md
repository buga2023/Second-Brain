---
fonte: "How self-improving harnesses are rewriting the agent engineering playbook" — BD TechTalks
url: https://bdtechtalks.com/2026/07/13/ai-agents-self-improving-harness/
tipo: artigo
capturado: 2026-11-05
nota: Extrato via WebFetch. Fonte secundária (jornalística).
---

Harness = lógica de execução, prompts, memória e configuração de ferramentas em volta do modelo.

1) Self-Harness (arXiv 2606.09498): weakness mining → harness proposal → proposal validation (testes de regressão; edição que conserta um caso e quebra outro que passava é rejeitada). MiniMax M2.5 de 40,5% para 61,9% no Terminal-Bench-2.0, sem mexer nos pesos. Regras geradas: disciplina de retry de comandos, recriação forçada de artefatos ausentes, persistência de variáveis de ambiente entre sessões de shell.

2) HarnessX (arXiv 2606.14249, pesquisadores da Xiaomi): harness como software modular; comportamentos são "processors" plugados em hooks de ciclo de vida. Motor AEGIS com 4 agentes: Digester (acha onde falhou nos traces), Planner (estratégia), Evolver (edita código e roda testes isolados), Critic (barra reward hacking e regressões). Evolução só de harness: +14,5% médio em ALFWorld, GAIA e SWE-bench Verified. Co-evolução do modelo via GRPO cross-harness: +4,7% adicional. Modelos menores open-weight (ex.: Qwen 9B) ganham mais. Código aberto no GitHub, configuração YAML, integrações com MemPalace (memória longa) e VERL (treino distribuído).

Lições para empresas:
- Investir em observabilidade: log detalhado de traces é pré-requisito.
- Construir datasets de avaliação e gates de regressão.
- Papel do time muda para "arquitetura de feedback": menos patch manual de prompt, mais pipeline de traces e infraestrutura de avaliação.
- Orçar compute de otimização: o meta-agente costuma ser modelo de fronteira.
- Considerar modelos menores open-weight: scaffolding melhor reduz a distância.
- Avaliar opções open source (HarnessX) respeitando a licença.
