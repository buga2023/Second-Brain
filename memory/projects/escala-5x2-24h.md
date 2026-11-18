---
title: Escala 5x2 24h (consultoria de escala, fábrica têxtil)
date: 2026-11-17
tags: [projeto, consultoria, planilha, escala]
aliases: [escala-5x2, escala 24h, revezamento 5x2]
---

# Escala 5x2 24h

Estudo de mudança de escala de uma fábrica têxtil (cliente externo, via
indicação): sair da 5x1/6x1/6x2 em 3 turnos (A, B, C) para 5x2 **sem parar
a fábrica** (24h, domingo a domingo). Entrega é planilha Excel.

## Onde está e como roda

- Arquivos do cliente ficam só na máquina local (`~/Documents`), nunca no
  vault: base nominal, estudo anterior 2x2, versão 5x2 seg–sex.
- Scripts de geração e check: scratchpad da sessão (openpyxl via
  `uv run --with openpyxl`).

## Histórico

- v1 (antes de 16/11): estudo 2x2 de 12h.
- "Enquadrada Final": 5x2 seg–sex, 2 turnos, folga fixa sáb/dom. Cliente
  recusou: a produção não para.
- 17/11: versão revezamento 24h.

## Decisões (17/11)

- **Fonte única = base nominal** (pessoa por pessoa). A aba detalhada da
  versão anterior não batia com ela (476 × 442 em turno).
- **Turno fixo, folga rotativa**: 7 grupos de folga com 2 dias seguidos,
  girando 1 posição por semana; todo mundo folga domingo ao menos 1 vez em
  7 semanas. Turno que gira vira "ininterrupto de revezamento" (6h sem
  acordo coletivo); validar com jurídico.
- **Dimensionamento**: mesma presença média diária de hoje
  (5x1 = 5/6, 6x1 = 6/7, 6x2 = 6/8) × 7/5, arredondado **por seção e turno**.
  Resumo mostra 3 cenários (setor / seção / função) como faixa.
- Administrativo, Adm/Sáb, aprendiz e estagiário ficam em 5x2 seg–sex.
- Horários dos turnos A/B/C ficam editáveis ("a confirmar").

## Termos

- **Grupo de folga**: turma que começa a semana em dia diferente para cobrir
  o fim de semana.
- **Folguista (AABC)**: cobre folgas girando entre turnos A, A, B, C.

Related: [Projetos](README.md)
