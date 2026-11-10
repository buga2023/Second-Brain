---
title: Boas práticas de CLAUDE.md e AGENTS.md
date: 2026-11-10
tags: [config, context]
---

# Boas práticas de CLAUDE.md e AGENTS.md

Pesquisa de 2026-11-10. Fonte primária: documentação do Claude Code
(code.claude.com/docs, páginas `memory` e `best-practices`) e a skill
`writing-for-agents` (Matt Pocock). O site agents.md não estava
acessível desta sessão; o que vem de blogs está marcado.

## Onde cada arquivo mora

| Arquivo | Vale para | Observação |
|---|---|---|
| `~/.claude/CLAUDE.md` | Eu, todos os projetos | Preferências pessoais |
| `~/.claude/rules/*.md` | Eu, todos os projetos | Carrega junto; é onde o instalador põe as regras |
| `./AGENTS.md` | O repositório, qualquer agente | Fonte única por projeto |
| `./CLAUDE.md` | O repositório, Claude Code | Aqui: uma linha, `@AGENTS.md` |
| `./CLAUDE.local.md` | Eu, um projeto | Fora do Git |
| `.claude/rules/*.md` com `paths:` | Parte do código | Só carrega ao mexer nos arquivos que casam |

Os arquivos se concatenam da raiz até a pasta de trabalho; o mais
próximo é lido por último.

## Como o Claude Code trata o AGENTS.md

- Lê `AGENTS.md` sozinho só quando não há `CLAUDE.md` nem
  `CLAUDE.local.md` na pasta de trabalho ou acima dela (v2.1.277+).
- Um `CLAUDE.md` com `@AGENTS.md` funciona em qualquer versão e nunca
  carrega o arquivo duas vezes. Por isso o padrão adotado é
  `AGENTS.md` + `CLAUDE.md` de uma linha.
- Criar um `CLAUDE.local.md` num repositório que depende só do
  `AGENTS.md` faz o Claude parar de lê-lo — mais um motivo para manter
  o import.
- Dizer em texto "leia o AGENTS.md" não garante leitura; o import
  garante.

## O que escrever

- Só o que o agente não descobre lendo o repositório: comandos de
  verificação, armadilhas, decisões tomadas fora do código, o que já
  precisou ser corrigido duas vezes.
- Até 200 linhas por arquivo; import organiza mas não reduz custo.
- Regra sem exceção (nunca ler `.env`, sempre rodar o formatador) vai
  para hook ou regra de permissão: instrução em texto é seguida quase
  sempre, não sempre.
- Ênfase em maiúsculas não resolve linha ignorada: ou o arquivo está
  longo demais, ou a linha é regra de hook.
- Dar ao agente um check que roda e devolve passou ou falhou, e pedir a
  evidência (comando e saída).

## Como escrever (writing-for-agents)

- **Ponteiro de contexto**: a descrição de uma skill e uma linha do
  `AGENTS.md` são ponteiros; o texto do ponteiro decide quando o
  material é alcançado. Palavra-chave na frente, um gatilho por ramo.
- **Duas cargas**: tudo que fica sempre carregado custa contexto em
  todo turno; tudo que depende de eu lembrar custa atenção minha.
- **Hierarquia**: passo no arquivo, referência no arquivo, referência
  em arquivo irmão alcançada por ponteiro.
- **Critério de conclusão** em cada passo, verificável e exigente.
- **Palavra-guia**: um termo que o modelo já conhece, repetido como
  token (vermelho, fronteira, teto), no lugar de um parágrafo.
- **Positivo em vez de proibição**: dizer o comportamento alvo.
- **Poda**: uma fonte por significado; não repetir o que o ambiente já
  diz; apagar frase que não muda o comportamento padrão.

## Prática da comunidade para AGENTS.md (fontes secundárias)

- O arquivo mais próximo na árvore prevalece; em monorepo, raiz mínima
  que aponta para arquivos por pacote.
- Curto e específico: comandos, verificação e armadilhas não óbvias.
- Limites de tamanho variam por ferramenta (na casa de dezenas de KB).

## Conferir

`/context all` mostra o que carregou; `/doctor prompt-audit` aponta
instrução velha ou contraditória; `/init` gera um ponto de partida.

Related: [claude-config](../../claude-config/README.md) ·
[matt-pocock](matt-pocock.md) · [00-Index](../../00-Index.md)
