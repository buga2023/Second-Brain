---
title: SGM (Sistema de Gestão de Materiais)
date: 2026-11-16
tags: [projeto, sistema, gp, tubulacao, mecanica]
aliases: [sgm, gm web, gm_web_api, sgm-api]
---

# SGM (Sistema de Gestão de Materiais)

Sistema da GP que gera as listas de materiais de um projeto de tubulação:
Lista de Suportes, Lista de Material de Suporte e Lista de Material de
Tubulação, no formulário GP. Usado por Tubulação e Mecânica.

## Onde está e como roda

- Web: `sgm.gpce.com.br` (front `gm_web_front`, outro repositório).
- API: repositório `GpDevLab/sgm-api` (Node/TypeScript, Express, Prisma,
  PostgreSQL). O Python (pandas, xlwings) só lê as planilhas de entrada e
  preenche os modelos de saída, e por isso a máquina precisa de Excel.
  O DWG passa pelo ODA File Converter.
- Produção: Windows com PM2 (`sgm-api`), deploy pelo `deploy.ps1` a cada push
  na `main`. **O deploy não roda migration**: mudança de schema precisa do SQL
  rodado à mão antes.
- Testes: `npm test` (desde o PR #22; antes não havia nenhum).
- Mapa completo do código: `docs/RAIO-X.md` no repositório.

## Como o cálculo funciona

- Dados por cliente → contrato → projeto → área.
- Material de suporte = quantidade do suporte no export do E3D × valor da
  Matriz N-1758. O casamento é pelo tipo do suporte + diâmetro, em texto exato.
- Material de tubulação vem pronto do export do E3D, ou é lido dos textos de um
  DWG e completado pela tabela `Nm_Sap`.
- Cada upload abre uma revisão de dados; cada download grava um documento com
  revisão.

## Decisões e achados

- **13/11/2026, diagnóstico de UX (Gustavo):** a queixa de "complexo" das
  disciplinas é a interface, não o cálculo. Começar pelos quick wins (rótulos,
  modal, tirar o `id`) e depois a emissão guiada.
- **16/11/2026, raio-x:** defeitos que dão resultado errado sem avisar. Entre
  eles: campo `bandeirola` fora do schema desde 12/01, documento com erro
  marcado CONCLUIDO, NM repetido que some da lista de tubulação a partir da
  Rev A, matriz lida pela letra da coluna e elevação que perde o sinal.
- **16/11/2026, PR #22 (para `development`):** volta o `bandeirola` (SQL
  idempotente em `scripts/sql/`), corrige o status ERRO das 3 listas e tira o
  hash da senha da rota `/api/auth/:token`. Decisão do Gustavo: devolver o
  campo ao schema com migration segura, em vez de parar de enviá-lo.

- **17/11/2026, reaproveitamento (Gustavo, caminho A):** o portal já tem em Python, com
  testes, a Lista de Suportes (8680), a LM por Isométricos (8670), a leitura de DWG e de E3D
  e o carimbo/revisão — duplicam o SGM. Só o SGM tem a `Nm_Sap`, o material de suporte pela
  Matriz N-1758 e o banco com histórico. Decisão: levar essas duas peças para o módulo comum
  `Projetos/_materiais_petrobras` do GPautomacoes (branch `feat/materiais-petrobras-modulo`,
  worktree `automaçoes/wt-materiais-petrobras`); o SGM fica como está. Qual versão das
  listas duplicadas fica é pergunta para a Manuela.
- **17/11/2026, portão do diâmetro:** o TXT do portal não traz `P1BORE`; o app tira o
  diâmetro do nome da linha (`dimensoes.py`). Em redução/derivação pode diferir do ponto do
  suporte — confirmar com 1 área real antes do material de suporte no portal.

## Próximo passo

Revisão do PR #22, rodar o SQL no banco e pegar 1 área real (matriz + export
do E3D + lista emitida à mão) como gabarito para a emissão guiada. Card no
GPlan: 552.
