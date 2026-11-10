---
title: Governança e alçadas (quem assina)
tipo: conceito
tags: [governanca, raci, eu-ai-act, nist, alcada]
fontes: [2026-11-06-pesquisa-web-avaliacao-governanca.md, 2026-11-05-post-langchain-langgraph.md]
date: 2026-11-06
---
# Governança e alçadas

## RACI por caso de uso
Para cada agente de risco, nomear **um** responsável final (accountable) por:
1. **Aprovação** da mudança (o "adotar" da etapa 06).
2. **Enforcement em runtime** (guardas, limites).
3. **Privacidade**.
4. **Incidente e rollback**: tem plano escrito e decide ship/rollback.

## Escala de alçada (proposta do vault)
| Risco da mudança | Quem decide |
|---|---|
| Baixo (texto de prompt, limite de loop) e gate verde | automático + registro |
| Médio (nova ferramenta de leitura, troca de modelo) | dono do agente |
| Alto (ferramenta que envia, paga ou apaga; critério de avaliação) | dono do agente + negócio/compliance |

## Marcos regulatórios (fontes secundárias)
- **NIST AI RMF:** Govern · Map · Measure · Manage; o risco fica com a liderança executiva.
- **EU AI Act art. 14:** supervisão humana efetiva, proporcional ao risco; tem que dar para **parar** o sistema. Art. 26: o implantador designa supervisores competentes e guarda **logs por ≥6 meses**.
- Datas de vigência **conflitantes** entre as fontes (ago/2026 × dez/2027). Verificar no texto oficial. Para o Brasil, ver também LGPD e o PL de IA (ainda não pesquisado).

## Em código
A alçada vira `interrupt()` no [langgraph](../entidades/langgraph.md) ou `HumanInTheLoopMiddleware` no [langchain](../entidades/langchain.md). Ver [human-in-the-loop](human-in-the-loop.md) e [tutorial-ciclo-rhawk-langgraph](../guias/tutorial-ciclo-rhawk-langgraph.md).
