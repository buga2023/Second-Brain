---
title: Revisão de Fluxograma de Engenharia (pedido #54)
date: 2026-11-13
tags: [projeto, automacao, processo, zwcad]
---

# Revisão de Fluxograma de Engenharia

**O que é:** automação da GP (Processo) que pega um fluxograma de engenharia
existente (DWG) e uma lista de alterações e gera a revisão no padrão GP: folha A1
com carimbo N-381 rev M, alterações em cor 10, notas novas, linha de revisão,
documentos de referência e legenda de cores. Pedido #54 do portal NTI.

**Pessoas:** solicitante Victoria Franco Cruz (Processo); especialista Matheus;
verificação Thiago Magalhães; aprovação Flaviane.

**Onde está:** repo GpDevLab/GPautomacoes, `Projetos/Revisao de Fluxograma de
Engenharia (Processo)/`; pedido em `Vault Automações GP/Pedidos/Processo/Pedido -
Fluxogramas de Engenharia.md`; plano `docs/superpowers/plans/2026-11-13-revisao-fluxograma-engenharia.md`.
Dados reais só na máquina local (`_Dados Reais/Processo/...`).

**Como roda:** Python + ezdxf sobre DXF; ODA File Converter faz DWG↔DXF; ZWCAD 2023
por COM gera o PDF. Check = `conferir.py` saída × gabarito em 5 campos.

## Decisões
- 13/11/2026: escopo v1 = revisão de fluxograma existente; desenho novo, tie-in,
  diâmetro e spec ficam para a fase 2. Confirmado pela solicitante.
- 13/11/2026: o carimbo é o formulário Petrobras N-381 rev M preenchido pela GP
  (emitente GPY). Aprovado pelo Gustavo.
- Campo sem fonte nas entradas (nº do documento, nomes do carimbo) sai como VERIFICAR.

Related: [README](README.md)
