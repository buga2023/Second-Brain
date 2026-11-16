---
title: Elétrica — FD de Equipamento Elétrico e RM de Elétrica
date: 2026-11-16
tags: [projeto, automacao, eletrica]
---

# Elétrica: FD de Equipamento Elétrico e RM de Elétrica

**O que é:** duas automações da Elétrica, especialista Caio Lima Fernandes.
- **FD de Equipamento Elétrico** (pedido 57): preenche a folha de dados do
  equipamento a partir da norma Petrobras e do critério de projeto. Generaliza a
  "FD de Motor Elétrico BT" (pedido 2). Campo sem fonte sai em amarelo (VERIFICAR).
- **RM de Elétrica** (pedido #7): gera a requisição de material (formulário N-381,
  Excel) a partir das FDs.

**Onde está:** repo GpDevLab/gpautomacoes, `Projetos/FD de Equipamento Elétrico/`,
`Projetos/FD de Motor Eletrico BT/` e `Projetos/Gerar RM de Elétrica/`
(decisões da RM em `docs/decisoes.md`). Dados reais só em `_Dados Reais/`.
FD no portal: `http://10.71.0.32:8080/app/fd-equipamento-eletrico/`.

## Decisões
- 03/11/2026 (Caio): na FD entram só dados da N-2919 e do critério de projeto;
  área classificada e partida são entrada manual.
- 04/11/2026 (Caio): RM continua em Excel, no formulário N-381.
- 09/11/2026 (Caio): N-2760 substitui a N-0332 em todo equipamento, inclusive
  quando a FD cita a N-0332.
- 12/11/2026 (Caio): gabarito = FDs emitidas no e-clic do projeto ASP-072 (PTB16),
  que tem exemplo de todos os tipos; começar por painel e motor.
- 16/11/2026 (Caio):
  - O "não ficou intuitivo" era sobre a FD; ele quer a FD geral, como a que está
    sendo feita agora.
  - RM e FD continuam apps separados: não saem necessariamente no mesmo momento.
  - RM pode aceitar o PDF do diagrama e ler título e revisão do carimbo.
  - Motor BT usa a FD de 5 páginas como gabarito. A N-2919 tem mais duas FDs
    para motores de tensão maior (fase futura).
  - CCM/CDC em .doc: basta salvar na versão atual do Word (.docx) para converter.
  - Não há FD em elaboração no momento.

## Como falar com o Caio
Mandar a FD gerada e perguntas sim/não no vocabulário dele; pedido abstrato
("tabela campo → fonte") ele não entendeu.

Related: [README](README.md)
