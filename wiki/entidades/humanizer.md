---
title: Humanizer
tipo: entidade
tags: [skill, escrita, ferramenta]
fontes: [2026-11-10-repos-video-ferramentas-agentes.md]
date: 2026-11-10
---
# Humanizer (blader/humanizer)

Skill de agente (MIT) que reescreve texto gerado por IA para soar humano
sem mudar o conteúdo. Base: o guia "Signs of AI writing" da Wikipedia;
checa 26 padrões. Os cinco mais fortes: "não é X, é Y", frase de efeito
no fim, ditado que soa profundo, preâmbulo encenado ("Here's the thing")
e discutir com ninguém ("não estou dizendo que...").

- Edita para leitor humano. **Não** serve para enganar detector de IA, e o
  próprio README diz que os detectores ainda pegam a maior parte.
- Afirmação do README: num teste cego, juízes preferiram a reescrita 16 de
  16 vezes **(não verificado)**.
- Instalação no Claude Code: `/plugin marketplace add blader/humanizer`
  e depois `/plugin install humanizer@humanizer`; uso com `/humanizer`.

## Onde encaixa aqui
Revisão final dos textos das skills de LinkedIn (post-writer,
newsletter-voice) e do doc-drafter. **Status:** não instalada.

Related: [fonte-repos-video-ferramentas-agentes](../fontes/fonte-repos-video-ferramentas-agentes.md)
