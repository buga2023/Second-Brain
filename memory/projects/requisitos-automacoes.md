---
title: Requisitos e Melhorias das Automações GP
date: 2026-11-16
tags: [projeto, automacao, nti, pgi-dev-006]
---

# Requisitos e Melhorias das Automações GP

**O que é:** planilha com a Ficha (PGI-DEV-006, Etapa 2) e o checklist do Anexo B
de cada uma das 94 automações do portfólio v25, mais os requisitos numerados
(RN/EX/VAR/ENT/SAI/VAL), as pendências por pessoa e as melhorias. Público: NTI
(construir, testar, cobrar especialista).

**Onde está:** `C:\Users\GTI\Documents\automaçoes\Requisitos-Automacoes\`
(fora do git). `PLANO.md`, `BRIEF_EXTRACAO.md`, `scripts/`, `dados/` e a saída
`Requisitos_Automacoes_GP_v1.xlsx`. A pasta `fonte/` é um worktree
somente-leitura do GPautomacoes em `gp/development` dbc04c73.

**Como refazer:** `scripts/inventario.py <portfolio.xlsx>`, `mapa_fontes.py`,
extração por lote (brief), `valida_extr.py dados/extr_*.json`,
`gera_xlsx.py`, `verifica_xlsx.py`.

## Decisões
- 16/11/2026 (Gustavo): a lista é para o NTI, no formato da Ficha do PGI-DEV-006.
- Fonte de código = `gp/development`, porque o checkout local estava 231 commits
  atrás do `gp/main` e o development é a linha mais completa.
- "Atendido" só com arquivo:linha de código. O que só está na nota fica como
  "Declarado, não conferido no código".

## Achados
- O vault quase não cita o ID SOL: só 12 de 94 IDs aparecem em alguma nota.
- Anexo B: nenhuma automação tem Ficha aprovada nem testes com os Casos A, B e C.
- Conferência manual de 65 requisitos em 5 automações: nenhum inventado; 1 com
  evidência fraca, rebaixado.
- As planilhas Criterios_Economia_HH_* são estimativa (HH de template × % fixo
  por função), não medição. Há 6 IDs trocados em relação ao v25.

Related: [README](README.md) · [eletrica-fd-e-rm](eletrica-fd-e-rm.md) · [triagem-automacao-gp](triagem-automacao-gp.md)
