---
title: REA
tipo: entidade
tags: [mcp, engenharia-reversa, seguranca, ferramenta]
fontes: [2026-11-10-repos-video-ferramentas-agentes.md]
date: 2026-11-10
---
# REA: Reverse Engineer Anything (morluto/rea)

Servidor MCP (MIT; `npx rea-agents setup`) que dá ao agente ferramentas de
engenharia reversa: binários nativos, apps JavaScript/Electron, assemblies
.NET e sites. Explica como uma funcionalidade de um app funciona sem o
código-fonte e mostra a evidência. A análise roda local e pode usar
Hopper, Ghidra ou IDA já instalados.

- No Linux, Ghidra, JADX e a análise de Electron exigem um `ps` compatível
  com procps no `PATH`.
- O README avisa que existem cópias falsas: instalar só de `morluto/rea`,
  rea.tools ou do pacote npm `rea-agents`.
- Ferramenta de uso duplo: só em software próprio ou com autorização.

## Onde encaixa aqui
Par natural da [vuln-triage](../../memory/projects/vuln-triage.md):
confirmar se uma vulnerabilidade é alcançável num binário de terceiros.
**Status:** não instalado.

Related: [fonte-repos-video-ferramentas-agentes](../fontes/fonte-repos-video-ferramentas-agentes.md)
