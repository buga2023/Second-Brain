---
title: Ferramentas
date: 2026-11-10
tags: [meta]
---

# Ferramentas

- `vault_lint.py`: cópia do lint da skill `obsidian-notes` (Mark Rogers,
  MIT, v0.2.1; licença em `LICENSE-vault_lint`). Acha links quebrados ou
  ambíguos, órfãs, nomes repetidos, pastas sem índice e frontmatter inválido.
  Roda sem dependências: `python3 tools/vault_lint.py . --exclude skills`.
  A GitHub Action `.github/workflows/lint.yml` roda o mesmo comando a cada push.

Related: [00-Index](../00-Index.md)
