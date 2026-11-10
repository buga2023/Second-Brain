---
title: Second Brain
date: 2026-11-10
tags: [meta]
---

# Second Brain

Segundo cérebro do Gustavo: um wiki mantido pelo Claude (padrão LLM Wiki do
Karpathy) mais a memória de pessoas, projetos e decisões, para que nada
precise ser redescoberto a cada conversa. Abre como vault no Obsidian e
renderiza no GitHub e no VS Code.

Entre pelo índice: [00-Index](00-Index.md). O esquema e as regras de
operação (ingest, query, lint) estão no [CLAUDE.md](CLAUDE.md).

## Estrutura

- [raw](raw/README.md): fontes brutas, imutáveis.
- [wiki](wiki/index.md): conhecimento compilado (fontes, conceitos,
  entidades, projetos, guias, sínteses) e a [tese atual](wiki/overview.md).
- [memory/people](memory/people/README.md), [memory/projects](memory/projects/README.md),
  [memory/context](memory/context/README.md), [glossário](memory/glossary.md).
- [skills](skills/README.md): backup de skills locais e `install.sh`.
- [tools](tools/README.md): lint do vault (também roda na CI).
- [log](log.md): histórico de tudo que entrou ou mudou.

## Uso rápido

```
python3 tools/vault_lint.py . --exclude skills tools   # saúde do vault
skills/install.sh                                      # instala as skills do backup
grep "^## \[" log.md | tail -5                          # últimas mudanças
```

Related: [00-Index](00-Index.md) · [CLAUDE.md](CLAUDE.md)
