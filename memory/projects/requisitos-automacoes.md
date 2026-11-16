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

## Kits por pessoa e medição de HH (16/11)
- `kits_v2/`: 31 planilhas (30 pessoas + `NTI - interno.xlsx`), 405 perguntas para
  316 itens em aberto, mais a aba "Dados do pedido" com os campos do formulário
  Pedido de Automação GP v3 (colaboradores, aprovador, centro de custo, vezes em
  30 dias, abrangência, % esperado...), uma linha por automação no kit do solicitante.
  Check: `scripts/verifica_kits.py kits_v2`.
- Decisão (Gustavo): os requisitos seguem os campos do Pedido v3; o PGI-DEV-006 do
  .docx é o mesmo texto da skill.
- `Roteiro_Cronometragem_HH.xlsx`: primeira medição real de HH (manual × com
  automação) em 6 automações, fórmulas testadas no LibreOffice. Envios do Portal
  vêm do access.log do nginx; "1 envio = 1 documento" é premissa, não fato.

## Proposta do Bruno Damasceno para HH de Instrumentação (16/11, aguardando Manuela)
- Troca o % fixo por função por % próprio e justificado por automação: SOL-023 50%/30%,
  SOL-020 60%/20%, SOL-026 60%/30%, Item 15 (RM) 95%/60%; inclui SOL-021 (3,30 HH),
  SOL-025 (3,60) e Item 17 PATEC (5,40). Total 9,9 → 27,5 HH (contas conferidas).
- Pede renomear SOL-020 para "Lista de Instrumentos por fluxograma" e tirar SOL-021 de
  Hold/Canceladas (v25: Implantada).
- Continua **estimativa do especialista**, não medição. SOL-025 e Item 17 são potencial.
- Status: a Manuela ainda vai aceitar ou reprovar. Não aplicar antes disso.

## Achados
- O vault quase não cita o ID SOL: só 12 de 94 IDs aparecem em alguma nota.
- Anexo B: nenhuma automação tem Ficha aprovada nem testes com os Casos A, B e C.
- Conferência manual de 65 requisitos em 5 automações: nenhum inventado; 1 com
  evidência fraca, rebaixado.
- As planilhas Criterios_Economia_HH_* são estimativa (HH de template × % fixo
  por função), não medição. Há 6 IDs trocados em relação ao v25.

Related: [README](README.md) · [eletrica-fd-e-rm](eletrica-fd-e-rm.md) · [triagem-automacao-gp](triagem-automacao-gp.md)
