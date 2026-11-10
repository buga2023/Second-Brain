---
title: Skills
date: 2026-11-10
tags: [meta]
---

# Skills

Backup de skills do Claude Code criadas pelo usuário ou pelo Claude, para
sobreviver a containers efêmeros. Cada pasta é uma skill completa
(`SKILL.md` + arquivos de referência); o instalador em
[claude-config](../claude-config/README.md) copia todas para
`~/.claude/skills/`.

- [raio-x](raio-x/SKILL.md): mapa da lógica de uma aplicação, pontos
  frágeis e melhorias priorizadas.
- [triar-feedback](triar-feedback/SKILL.md): classifica feedback
  repassado antes de corrigir e redige a resposta.
- [desenhar-loop](desenhar-loop/SKILL.md): condição de parada, motor,
  teto e portões humanos; referências em
  [MOTORES](desenhar-loop/MOTORES.md) e [ESTADOS](desenhar-loop/ESTADOS.md).
- [graph-engineering](graph-engineering/SKILL.md): grafo de agentes;
  referências em [PADROES](graph-engineering/PADROES.md) e
  [MODELOS](graph-engineering/MODELOS.md).
- [fechar-sessao](fechar-sessao/SKILL.md): roda a entrega do
  repositório, explica e registra neste vault.
- [agents-md](agents-md/SKILL.md): gera `AGENTS.md` lendo o repositório;
  modelo em [MODELO](agents-md/MODELO.md).
- [watch](watch/SKILL.md): assiste vídeo (URL/arquivo local) via
  yt-dlp+ffmpeg ou Gemini — transcript + frames pro agente. De
  `github.com/bradautomates/claude-video`, MIT.

Related: [00-Index](../00-Index.md)
