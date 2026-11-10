---
title: Skill triagem-automacao-gp
date: 2026-11-10
tags: [projeto, skill]
aliases: [Pedido de Automação GP]
---

# triagem-automacao-gp

Skill criada pelo usuário para triar e desenhar automações das disciplinas
de engenharia da GP Consultoria e Engenharia. Já ativa no catálogo de
skills (`anthropic-skills:triagem-automacao-gp`).

## O que faz

Responde, nesta ordem fixa: automatizar muda o resultado? → dá para
começar? → como fazer funcionar? → como o Claude Code constrói isso?

1. **Triagem determinística** (`scripts/triagem.py`): lê o
   `Pedido de Automação — GP.xlsx`, aplica 5 portões (G1–G5: especialista
   nomeado, entrada real, gabarito, regras passo a passo, verdade de
   referência) e extrai os campos.
2. **Mapeamento de processo** (`scripts/mapa_processo.py`): mede prazo,
   esforço, espera e o teto de ganho do pedido; redesenha
   eliminar → simplificar → padronizar antes de automatizar.
3. **Julgamento de mérito**: aplica a rubrica (teste do estagiário, do
   determinismo, do gabarito) sobre as regras do especialista.
4. **Vereditos de processo e prontidão**, plano (`PLANO-<nome>.md`) e
   perguntas fechadas sobre o caso concreto.
5. **Pacote para o Claude Code** (`scripts/gerar_plano_cc.py`): gera pasta
   de projeto com `CLAUDE.md` (constituição), `task_plan.md` (fases com
   portão), stubs `NotImplementedError` e `tests/validar.py`.

## Princípios

- O processo vem antes do pedido — tecnologia só depois de
  eliminar/simplificar/padronizar.
- A parte difícil não é programar, é a regra da disciplina — por isso as
  regras entram verbatim no pacote, nunca resumidas.
- Segue o framework **V.L.A.E.G.** (`vlaeg-framework`) por construção;
  aciona o V.L.A.E.G. direto quando o projeto passa de uma automação de
  disciplina.

## Related

- [memory/projects](README.md)
- [memory/glossary](../glossary.md)
