---
title: Second Brain
date: 2026-11-10
tags: [meta]
---

# Second Brain

Vault pessoal de memória e contexto: decisões, pessoas, projetos e termos
que o Claude Code deve lembrar entre sessões, em vez de redescobrir ou
perguntar de novo a cada conversa.

Entre pelo índice: [00-Index](00-Index.md).

## Estrutura

- [memory/people](memory/people/README.md): quem é quem (nomes, apelidos, papéis).
- [memory/projects](memory/projects/README.md): projetos e codinomes em andamento.
- [memory/context](memory/context/README.md): fatos de contexto geral (empresa, ferramentas, processos).
- [memory/glossary.md](memory/glossary.md): siglas, termos internos e seus significados.

## Convenção de frontmatter

Toda nota começa com:

```yaml
---
title: Nome da nota
date: AAAA-MM-DD      # data de criação ou última revisão relevante
tags: [pessoa]         # ou [projeto], [termo], [decisao], [meta]...
aliases: [Apelido]     # opcional: outros nomes pelos quais a nota é conhecida
---
```

## Convenção de links

- Links relativos em Markdown (`[Nome](caminho/arquivo.md)`), não wikilinks —
  assim o vault renderiza certo no GitHub, no VS Code e no Obsidian.
- Toda nota termina com uma linha `Related:` apontando para notas que ela
  usa, contradiz ou substitui.
- Toda pasta tem um índice (`README.md`) listando o que está dentro.

## Como usar (para o Claude)

1. Antes de começar um trabalho que gere contexto reaproveitável, procure
   aqui primeiro em vez de perguntar de novo.
2. Ao final de um trabalho relevante, registre aqui (pessoa, projeto,
   decisão ou termo novo) — não deixe só na conversa.
3. Quando criar uma nota nova, link ela a partir do índice da pasta.

Related: [00-Index](00-Index.md)
