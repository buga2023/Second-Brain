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

Segue o padrão de "LLM wiki" do Karpathy (gist
`karpathy/442a6bf555914893e9891c11519de94f`): três camadas — fontes brutas
(imutáveis, nunca editadas), este wiki (que eu mantenho) e o esquema
(este README + o CLAUDE.md global). Três operações:

1. **Ingest** — ao chegar informação nova (pessoa, projeto, decisão,
   termo), não deixe só na conversa: atualize a(s) nota(s) relevante(s),
   linke do índice da pasta, e acrescente uma linha em [log.md](log.md).
2. **Query** — antes de perguntar de novo, leia [00-Index.md](00-Index.md)
   primeiro; ele aponta para a nota certa sem precisar vasculhar tudo.
3. **Lint** — de tempos em tempos, rode o lint do vault (contradições,
   notas órfãs, links quebrados) em vez de deixar degradar.

Related: [00-Index](00-Index.md)
