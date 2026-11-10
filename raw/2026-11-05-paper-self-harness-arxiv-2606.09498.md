---
fonte: "Self-Harness: Harnesses That Improve Themselves" (arXiv 2606.09498v1)
url: https://arxiv.org/html/2606.09498v1
tipo: paper
capturado: 2026-11-05
nota: Extrato estruturado do paper, obtido via WebFetch. Não é o texto integral.
---

Autores: Hangfan Zhang, Shao Zhang, Kangcong Li, Chen Zhang, Yang Chen, Yiqun Zhang, Lei Bai, Shuyue Hu (Shanghai Artificial Intelligence Laboratory). Autores correspondentes: Shuyue Hu e Lei Bai.

Ideia central: um agente LLM melhora o próprio harness (prompts, ferramentas, regras de runtime) sem engenheiros humanos nem agente externo mais forte. Pesos do modelo e avaliador ficam fixos.

Loop:
1. Weakness Mining — roda no split held-in; traces de falha agrupados por assinatura determinística (causa no verificador, comportamento do agente, mecanismo).
2. Harness Proposal — o mesmo modelo propõe várias edições mínimas e diversas; cada uma mira um mecanismo de falha e uma superfície editável; proibido reescrever a arquitetura de controle.
3. Proposal Validation — cada candidata é avaliada em held-in e held-out; aceitas são mescladas na próxima versão; rejeitadas são registradas sem mudar o harness ativo.

Harness inicial mínimo: prompt de sistema curto, ferramentas padrão de arquivo e shell, sem subagentes, skills ou middleware. Edições em pontos de configuração declarados: instruções, políticas de controle de runtime, ferramentas/middleware.

Mudanças observadas:
- MiniMax M2.5: criar cedo o artefato de saída exigido; tratar conteúdo estruturado de ferramenta com cuidado; redirecionar após loops longos de ferramenta (cap de mensagens de ferramenta ativado).
- Qwen3.5-35B-A3B: checar dependências antes; quebrar loops de exploração/retry; recuperar artefatos após erro de ferramenta via middleware. Ramos com subagentes e skills foram explorados e descartados por não trazerem ganho.
- GLM-5: manter mudanças de ambiente persistentes entre sessões de shell; passar mais cedo da exploração para implementação e teste.

Resultados (Terminal-Bench-2.0, subconjunto de 64 tarefas), pass %:
| Modelo | Held-in | Held-out |
| MiniMax M2.5 | 43,0 → 50,0 | 40,5 → 61,9 |
| Qwen3.5-35B-A3B | 15,1 → 36,0 | 23,8 → 38,1 |
| GLM-5 | 47,7 → 57,0 | 42,9 → 57,1 |
Ganho relativo de até 138% (Qwen held-in). A seção 4.3 cita números diferentes para as mesmas execuções (ex.: MiniMax 42,2% → 53,9%), sem reconciliação.

Regras de aceitação:
- Promove só se não reduzir acertos em nenhum split e melhorar ao menos um. Trade-offs rejeitados mesmo se o total subir.
- Execuções repetidas agregadas antes da regra (evita sorte).
- Edições que não mudam nenhuma superfície ou falham antes de produzir resultado são rejeitadas.
- Toda candidata registrada: superfícies alteradas, resultados por split, repetições, decisão.
- Held-out nunca é mostrado ao propositor, mas é usado como gate.

Limitações: um benchmark, 64 tarefas fixas, três modelos; tarefas multimodais e dependentes de web excluídas. Edições podem refletir padrões específicos do benchmark. Depende da qualidade do verificador e dos traces. Não-regressão de pass-rate é insuficiente para mudanças de alto risco. Held-out usado para gate e para reporte (não totalmente independente).
