---
fonte: Resultados de busca web (Claude Code, 2026-11-06)
url: várias (abaixo)
tipo: pesquisa-web
capturado: 2026-11-06
nota: Resumos de resultados de busca. Maioria é blog de fornecedor; tratar números como direcionais.
---

## Offline × online / champion-challenger
- Offline = gate antes do deploy: candidata roda contra dataset congelado; regressão bloqueada antes de ir ao ar. Exemplo citado: fidelidade caiu de 0,91 para 0,74 numa suíte de 47 casos e foi barrada antes do merge (techsy.io, versões FR/VI/CS).
- Online = tráfego real: pontuação amostral, A/B e monitores de guarda, coisas que um dataset fixo não reproduz.
- Champion/challenger: dividir o tráfego e medir resultado de negócio, não score substituto (Lyzr). — https://lyzr.ai/blog/online-vs-offline-ai-evaluation/
- Fluxo (CallSphere): regressão offline → canário → queda de métrica dispara rollback → traces de falha voltam para o dataset offline. — https://callsphere.ai/blog/online-vs-offline-agent-evaluation-pre-deploy-post-deploy
- Outras: https://alpeshnakrani.com/blog/offline-vs-online-evaluation/ , https://techsy.io/fr/blog/evaluation-llm-en-ligne-vs-hors-ligne

## LangSmith (docs oficiais)
- Avaliação offline em datasets curados × online em traces de produção (sem resposta de referência; monitora tendências e acha casos para o offline).
- Pairwise: `evaluate_comparative` compara dois experimentos; aba "Pairwise Experiments". Feedback com prefixo `pairwise_`/`ranked_`.
- Regressão: comparar experimentos contra um baseline ("Compare").
- Avaliadores de código para checagens tipo teste unitário; integrações com pytest e Vitest/Jest.
- Runs de produção que falharam viram exemplos do dataset.
— https://docs.langchain.com/langsmith/evaluation-types , https://docs.smith.langchain.com/how_to_guides/evaluation/evaluate_pairwise , https://docs.smith.langchain.com/how_to_guides/evaluation/compare_experiment_results , https://www.langchain.com/blog/pairwise-evaluations-with-langsmith

## Shadow, canário e rollback
- Shadow espelha o tráfego sem efeito para o usuário; canário serve tráfego real com roteamento percentual pronto para rollback. Sequência: shadow → espelho → canário → 100%.
- Shadow para mudanças grandes (troca de modelo, schema de ferramenta); dobra o custo de inferência; inútil sem camada de avaliação.
- "Canário sem critério de rollback escrito é um incidente lento." Exemplo: taxa de disparo de guarda numa janela de 15 min > 1,5× o baseline → rollback imediato. Outros gatilhos: queda de nota de rubrica, latência p99, erros só na candidata.
- Sinais: latência, custo por requisição, taxa de erro/recusa, tamanho de saída, feedback. Combinar KPI de negócio (atrasado) com indicadores adiantados (erros, falha de ferramenta, pico de tokens).
- Não-determinismo do LLM (até 15%) → gates com faixa de tolerância.
- Rampas: 1→5→20→50→100% ou 1→10→25→50→75→100%.
— https://tianpan.co/blog/2026-04-09-llm-gradual-rollout-shadow-canary-ab-testing , https://futureagi.com/blog/llm-eval-shadow-traffic-canary-2026/ , https://learn.traeai.com/t/ai-engineering/phases/17-infrastructure-and-production/20-shadow-canary-progressive

## Métricas de valor (suporte)
- Reabertura: medir à parte e descontar da resolução (8% reabertos → resolução efetiva = 92% do painel). Janela típica: reaberto pelo mesmo cliente em 24 a 48 h.
- Deflexão ≠ resolução: deflexão conta desistência como sucesso. Resolução alta + reabertura alta = "contenção com roupa melhor".
- Referências de fornecedor: resolução de IA boa em 2026 = 65–70% (padrão), 85%+ (plataformas dedicadas); chatbots de deflexão travam abaixo de 50%.
- Custo por resolução: IA US$0,62 × humano US$7,40 (um fornecedor); preços de US$0,60–1,27 (Gorgias) e US$0,99 (Fin); humano >US$15 na América do Norte; Gartner (citado de segunda mão): GenAI passa de US$3 por resolução até 2030.
- Fórmula: economia = resolvidos pela IA × (custo humano − custo IA), com os resolvidos já descontados das reaberturas.
— https://fin.ai/learn/resolution-rate-vs-deflection-rate , https://www.eesel.ai/en/blog/deflection-rate-what-is-it-and-how-to-improve-it , https://helpscout.com/blog/ai-support-metrics , https://www.lorikeetcx.ai/articles/ai-support-cost-per-resolution-compared-2026 , https://kdschemin.substack.com/p/your-ai-support-agent-closed-the

## Governança / alçada
- RACI por caso de uso de alto risco: um responsável (accountable) para aprovação, um para enforcement em runtime, um para privacidade, um para incidente. O dono do modelo decide ship/rollback, com plano de rollback documentado. — https://nhimg.org/articles/ai-governance-roles-and-decision-rights-need-clearer-raci-models/
- NIST AI RMF: Govern, Map, Measure, Manage; a responsabilidade pelo risco fica com a liderança executiva.
- EU AI Act art. 14: supervisão humana efetiva, proporcional ao risco e à autonomia; capacidade de parar o sistema; deveres para fornecedor e implantador. Art. 26: o implantador designa supervisores competentes e guarda logs por ≥6 meses. As datas de vigência são conflitantes entre as fontes (02/08/2026 × 02/12/2027) — verificar no Jornal Oficial.
- Crosswalk acadêmico RACI/gates ↔ NIST/AI Act/ISO 42001: AAGATE — https://arxiv.org/pdf/2510.25863
— https://www.metacto.com/blogs/human-oversight-of-ai-agents-production , https://www.airia.com/blog/human-oversight-for-ai-agents-what-it-means-and-how-to-implement-it-in-the-enterprise/

## RHAWK
- Busca por "rhawk.pro" sem nenhum resultado do domínio. Continua sem fonte pública.
