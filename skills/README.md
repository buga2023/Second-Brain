---
title: Skills
date: 2026-11-10
tags: [meta]
---

# Skills

Backup de skills do Claude Code criadas pelo usuário ou pelo Claude, para
sobreviver a containers efêmeros. Cada pasta é uma skill completa
(`SKILL.md` + assets). Para instalar numa máquina nova, rode
`skills/install.sh`: ele cria symlinks em `~/.claude/skills/`, e um
`git pull` no vault já atualiza a skill.

As skills que vivem no claude.ai (`anthropic-skills:*`) não ficam aqui;
cada uma tem uma nota em [memory/projects](../memory/projects/README.md).

- [graph-engineering](graph-engineering/SKILL.md): desenha grafos de
  execução de agentes (nós/arestas) e traduz para o Workflow tool.
  **Não verificada**: montada a partir do título do vídeo.
- [watch](watch/SKILL.md): assiste vídeo (URL/arquivo local) via
  yt-dlp+ffmpeg ou Gemini — transcript + frames pro agente. De
  `github.com/bradautomates/claude-video`, MIT (ver `watch/LICENSE`).

Related: [00-Index](../00-Index.md)
