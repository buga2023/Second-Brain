---
title: Inventário de skills
date: 2026-11-10
tags: [skills, context]
---

# Inventário de skills

Levantamento de 2026-11-10: o que existe, onde se sobrepõe e o que
faltava.

## Minhas skills (conta claude.ai)

| Grupo | Skills |
|---|---|
| GP | `triagem-automacao-gp`, `apresentacao-gp`, `gerador-documentos-gp` |
| Noxis | `proposta-noxis`, `proposta-social-trafego`, `noxis-carousel`, `area-membros-flix`, `identidade-visual` |
| Método | `vlaeg-framework`, `vibecode-flow`, `business-modeling-framework`, `prompt-engineering` |
| Utilitárias | `transcricao-reuniao`, `editorial-pdf`, `vuln-triage`, `cj-custo-europa` |

## Skills deste vault (instaladas por `claude-config`)

| Skill | Lacuna que fecha |
|---|---|
| [raio-x](../../skills/raio-x/SKILL.md) | Ver a lógica do que construí e onde melhorar |
| [triar-feedback](../../skills/triar-feedback/SKILL.md) | Meu pedido mais frequente: feedback repassado |
| [desenhar-loop](../../skills/desenhar-loop/SKILL.md) | Escrever loops com condição de parada |
| [graph-engineering](../../skills/graph-engineering/SKILL.md) | Escrever grafos de agentes |
| [fechar-sessao](../../skills/fechar-sessao/SKILL.md) | Fechar entrega e alimentar o vault |
| [agents-md](../../skills/agents-md/SKILL.md) | Instruções por repositório |
| [watch](../../skills/watch/SKILL.md) | Ler vídeo (de terceiro, MIT) |

## Plugins

- **Skills For Real Engineers** (Matt Pocock): `grilling`, `tdd`,
  `code-review`, `diagnosing-bugs`, `research`, `prototype`,
  `domain-modeling`, `codebase-design`, `wizard`, `writing-for-agents`,
  `resolving-merge-conflicts`.
- **Obsidian Notes**: lint e índices deste vault.
- Pacotes da Anthropic: `engineering:*`, `productivity:*`, `data:*`,
  `design:*`.
- Na máquina de trabalho existem skills locais de projeto (deploy, CAD,
  revisão de documentos) que uma sessão em nuvem não enxerga.

## Sobreposições e como desempatar

| Assunto | Opções | Use |
|---|---|---|
| Planejar | `triagem-automacao-gp`, `vlaeg-framework`, `vibecode-flow`, `grilling` | Pedido de automação: triagem. Sistema para durar: VLAEG. Protótipo: V.I.B.E. Decisão em aberto dentro de qualquer um: grilling. |
| Revisar código | `/code-review`, `mattpocock-skills:code-review`, `engineering:code-review` | Bug no diff: `/code-review`. Fidelidade ao spec e padrões do repo: Matt Pocock. Segurança e desempenho: engineering. |
| Depurar | `diagnosing-bugs`, `engineering:debug` | Bug difícil com regressão: `diagnosing-bugs`. |
| Diagrama | `raio-x` (Mermaid), `editorial-pdf` (BPMN) | Lógica de código: raio-x. Processo de negócio para apresentar: editorial-pdf. |

## Achados

- **Descrições longas custam em toda sessão.** Várias das minhas skills
  têm descrição com mais de 800 caracteres e listas de sinônimos
  ("SEMPRE use quando... 'x', 'y', 'z'"). A descrição fica carregada em
  todo turno; a regra do `writing-for-agents` é um gatilho por ramo,
  com a palavra-chave na frente. Enxugar é a melhoria mais barata.
- **Três métodos de planejamento** sem regra de escolha entre eles; a
  tabela acima passa a ser a regra.
- **Nenhuma skill media contra gabarito real.** Hoje isso está dentro
  de `raio-x` (melhorias com medição) e `desenhar-loop` (check vermelho
  na amostra real). Se o padrão "subir a taxa de acerto" continuar
  aparecendo, vira skill própria.

## Pesquisados e não instalados

| Item | Avaliação |
|---|---|
| mermaidiff (plugin da comunidade) | Diagrama de sequência só do que mudou num commit ou PR. Complementa o raio-x; instalar se a revisão de PR virar rotina. |
| Diagrams (Kroki) | Renderiza em serviço externo: não usar com conteúdo interno. Mermaid no próprio Markdown resolve. |
| claude-md-management (Anthropic) | Audita `CLAUDE.md`; `/doctor prompt-audit` já cobre. |
| SuperMatt | Variação das skills do Matt Pocock; redundante com o plugin oficial. |

Related: [fluxo-diario](fluxo-diario.md) · [skills](../../skills/README.md) ·
[matt-pocock](../people/matt-pocock.md) · [00-Index](../../00-Index.md)
