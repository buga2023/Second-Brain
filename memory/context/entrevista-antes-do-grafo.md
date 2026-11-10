---
title: Grilling antes do grafo
date: 2026-11-10
tags: [decisao, context]
aliases: [Entrevista antes do grafo]
---

# Grilling antes do grafo

Decisão de planejamento, triangulada por três fontes independentes:

1. **Boas práticas oficiais do Claude Code**
   (code.claude.com/docs/en/best-practices): "Interview me until you
   could write the spec, then write it to SPEC.md" antes de construir.
2. **Matt Pocock** (ex-Vercel, newsletter AI Hero), repo
   `github.com/mattpocock/skills` ("Skills For Real Engineers", plugin
   já instalado): skill `grilling`/`grill-me` — interroga o usuário em
   rounds sobre a frontier da design tree, cada pergunta numerada com
   resposta recomendada ("sim" aceita); fatos o agente busca sozinho via
   subagente, só decisões vão pro usuário. Para trabalho maior que uma
   sessão, `wayfinder`: mapa de tickets de decisão com frontier e fog of
   war. `writing-for-agents`: guia de como escrever skill/CLAUDE.md
   (leading words, pruning, context load vs cognitive load) — usado para
   revisar esta própria nota e a skill `graph-engineering`.
3. **Maestros da IA**, skill "Diretriz"
   (youtube.com/watch?v=bKI-YvBuu2Y): versão com painel de grilling
   (sugestão de resposta de um clique, dicionário por voz) em vez de
   terminal. Dado real deles: um MVP (editor de vídeo) ficou pronto em
   ~1h30 e ~100k tokens via grilling; o mesmo canal diz que via Gauntlet
   Loop/grafo teria sido "mais complexo e com muito mais tokens". Escopo
   mal definido na entrevista ("para o mercado", "todas as features do
   CapCut") é o que mais infla custo.

## Regra adotada

Antes de desenhar um grafo de execução (skill `graph-engineering`) ou
rodar o `gauntlet-loop`, grilling de escopo primeiro (`wayfinder` se
maior que uma sessão). Só escalar pra grafo/loop quando a frontier
resolvida ainda pedir paralelismo, revisão cruzada ou várias disciplinas
— não como primeiro instinto. Regra também no [CLAUDE.md](../../CLAUDE.md) do vault (a cópia em
`~/.claude/CLAUDE.md` citada antes não existe na máquina local).

## Related

- [matt-pocock](../people/matt-pocock.md)
- [graph-engineering](../../skills/graph-engineering/SKILL.md)
- [00-Index](../../00-Index.md)
