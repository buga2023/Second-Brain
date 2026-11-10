---
title: Entrevista antes do grafo
date: 2026-11-10
tags: [decisao, context]
---

# Entrevista antes do grafo

Decisão de planejamento, triangulada por três fontes independentes:

1. **Boas práticas oficiais do Claude Code**
   (code.claude.com/docs/en/best-practices): "Interview me until you
   could write the spec, then write it to SPEC.md" antes de construir.
2. **Mat (ex-Vercel)**, skill "GrillMy": entrevista o usuário antes de
   construir algo significativo, pra não deixar a IA decidir no seu
   lugar.
3. **Maestros da IA**, skill "Diretriz"
   (youtube.com/watch?v=bKI-YvBuu2Y): versão com painel de entrevista
   (sugestão de resposta de um clique, dicionário por voz) em vez de
   terminal. Dado real deles: um MVP (editor de vídeo) ficou pronto em
   ~1h30 e ~100k tokens via entrevista; o mesmo canal diz que via
   Gauntlet Loop/grafo teria sido "mais complexo e com muito mais
   tokens". Escopo mal definido na entrevista ("para o mercado", "todas
   as features do CapCut") é o que mais infla custo.

## Regra adotada

Antes de desenhar um grafo de execução (skill `graph-engineering`) ou
rodar o `gauntlet-loop`, fazer uma entrevista curta de escopo primeiro.
Só escalar pra grafo/loop quando a tarefa genuinamente precisar de
paralelismo, revisão cruzada ou múltiplas disciplinas — não como
primeiro instinto. Regra espelhada em `~/.claude/CLAUDE.md` (seção
Planos).

## Related

- [graph-engineering](../../skills/graph-engineering/SKILL.md)
- [00-Index](../../00-Index.md)
