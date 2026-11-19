---
title: MC de Linhas (Processo) — padrão do documento
date: 2026-11-19
tags: [projeto, automacao, processo, memoria-de-calculo]
---

# MC de Linhas (Processo)

**O que é:** automação da GP que gera a Memória de Cálculo de linhas (perda de carga) em Word, no modelo GP, a
partir de uma planilha de entrada. v1.x = padrão do documento (nada é calculado); v2.0 = cálculo. É a base do
motor único de MC para todas as disciplinas (motor + pacote por tipo; segundo tipo previsto: MC de Bomba).
No portfólio do NTI é a SOL-036.

**Pessoas:** solicitante e especialista Manuela Ferraz (Processo). A lista dos métodos mais usuais ela vai
fechar com a Flaviane.

**Onde está:** repo GpDevLab/GPautomacoes, `Projetos/MC de Linhas (Processo)/`. Branch local
`feature/mc-linhas-v1` (worktree `C:/tmp/wt-mc-linhas`), sem push e sem PR até 19/11/2026. No ar no servidor
us02 em `/app/mc-linhas/` (pm2 `gp-mc-linhas`, porta 8950). MC modelo e MCs emitidas só na máquina local.

**Como roda:** Python (openpyxl, python-docx), FastAPI. Check = `pytest` na pasta do projeto, mais o teste de
ponta a ponta pela LAN no Edge com Excel e Word reais.

## Decisões
- 18/11/2026: a planilha é a MC em forma de tabela. Traz tudo o que pode entrar e o engenheiro decide.
- 18/11/2026: aba Linhas em matriz, uma coluna por linha de tubulação (pedido da Manuela).
- 18/11/2026: toda planilha de versão anterior continua aceita. Quebrar o formato fez a Manuela perder um teste
  em 17/11.
- 19/11/2026 (v1.3): a Manuela achou a planilha confusa e o app recusou o arquivo dela. Causa no log: ela criou
  um tipo de item que não existia, para o total de um conjunto de linhas. Saída:
  - tipo "Resultado do conjunto" (aceita "Resultado consolidado"), que vira a tabela "Resultados consolidados";
  - coluna só com a identificação da linha entra nos textos e fica sem tabela, com aviso na tela;
  - aba Linhas sem a coluna "Usar?": o que tem valor entra, o que está em branco não entra;
  - Capa, Linhas e Textos bastam para gerar; abas opcionais em cinza;
  - densidade, viscosidade e rugosidade dos textos vêm da aba Linhas quando o valor é um só. A velocidade não,
    porque a da tabela é a calculada e a da premissa é a adotada.
- Regra de trabalho do Gustavo: escolha de desenvolvimento eu decido; para a Manuela vão só perguntas de
  engenharia.

## Lições
- Ler o log do app antes de supor o erro: ele guarda arquivo, abas e motivo de cada recusa.
- Guardar como fixture a planilha no formato exato que a pessoa enviou, com dados fictícios, gravada com o
  código da versão que estava no ar.
- Injeção sempre em cópia do projeto.

## Em aberto
- Com a Manuela: quais premissas valem por padrão; o que ela quis dizer com "Referência" ao lado da velocidade;
  métodos mais usuais (com a Flaviane); uma MC de Bomba emitida em Word.
- Revisão independente da v1.2 e da v1.3, push e PR.
- Formato de saída de outros contratos pede um modelo Word por contrato.
