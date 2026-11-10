---
title: Configuração do Claude
date: 2026-11-10
tags: [meta, config]
---

# Configuração do Claude

Fonte única das instruções e skills pessoais. O instalador copia daqui
para a pasta `.claude` da máquina; para atualizar, `git pull` e rode de
novo.

## Instalar no Windows

Uma vez, clone o vault:

```powershell
git clone https://github.com/buga2023/Second-Brain "$env:USERPROFILE\Second-Brain"
```

Depois, sempre que quiser instalar ou atualizar:

```powershell
cd "$env:USERPROFILE\Second-Brain"; git pull; powershell -ExecutionPolicy Bypass -File .\claude-config\install.ps1
```

O plugin com as skills do Matt Pocock (`grilling`, `wayfinder`,
`writing-for-agents`, `tdd`) é instalado à parte, uma vez:

```powershell
claude plugin install mattpocock-skills@claude-plugins-official
```

## Instalar em Linux, macOS, WSL ou sessão em nuvem

```bash
bash claude-config/install.sh
```

## O que o instalador faz

| De | Para | Efeito |
|---|---|---|
| `skills/<nome>/` | `~/.claude/skills/<nome>/` | Skill disponível em todo projeto |
| [regras.md](regras.md) | `~/.claude/rules/fluxo-gustavo.md` | Regras pessoais carregadas em toda sessão |

- O `CLAUDE.md` global que já existe na máquina fica como está: as
  regras entram como arquivo separado em `rules/`.
- Skill de mesmo nome já instalada é movida para
  `~/.claude/skills-backup/<data>/` antes da cópia.
- `-SkillsOnly` (PowerShell) ou `--skills-only` (bash) instala só as
  skills.
- O caminho do vault é gravado nas regras no momento da instalação.

## Por repositório

Cada repositório de trabalho ganha um `AGENTS.md` (fonte única) e um
`CLAUDE.md` de uma linha que o importa. A skill `agents-md` gera os dois
lendo o repositório; o modelo está em
[skills/agents-md/MODELO.md](../skills/agents-md/MODELO.md).

## Conferir

Numa sessão nova do Claude Code, `/context all` mostra o arquivo de
regras carregado, e `/doctor prompt-audit` aponta instrução duplicada ou
contraditória entre as regras, o `CLAUDE.md` global e as skills.

Related: [00-Index](../00-Index.md) · [skills](../skills/README.md) ·
[boas práticas](../memory/context/boas-praticas-instrucoes.md)
