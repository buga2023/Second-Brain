---
title: MC de Processo — Vasos, Trocadores e PSV
date: 2026-11-24
tags: [projeto, automacao, processo, memoria-de-calculo]
---

# MC de Processo — Vasos, Trocadores e PSV

**O que é:** três automações da GP que geram Memória de Cálculo em Word no modelo do contrato, a partir
de uma planilha de entrada e de uma MC base (a revisão anterior ou a de um equipamento parecido).
v1.0 = padrão do documento: **nada é calculado** (decisão da Manuela; cálculo é a v2.0); metodologia,
equações e contas vêm da MC base. Irmãs da [mc-linhas-processo](mc-linhas-processo.md), que é a base do
motor. No portfólio do NTI: Vasos SOL-050, Trocadores SOL-051, PSV SOL-054.

**Arquitetura:** Vasos é pacote próprio (`mc_vasos`, casamento por TAG de equipamento). Trocadores e PSV
compartilham o mesmo pacote `mc_padrao` (espelhado em dois worktrees; toda mudança vai nos dois). Decisão
do Gustavo: manter Vasos separado por ora, não unificar.

**Pessoas:** coord./especialista Manuela Ferraz (Processo); QA Caio Fernandes; validação de saída com a
Flaviane; esp. de aceite de PSV a definir.

**Onde está:** repo GpDevLab/GPautomacoes, `Projetos/MC de {Vasos,Trocadores,PSV} (Processo)/`. No ar em
teste (fora do portal) nos apps 8952 (Vasos), 8953 (Trocadores), 8954 (PSV) do servidor local
(10.71.0.215, DHCP). MC modelo e MCs emitidas (contrato Petrobras) só na máquina local, nunca na nuvem.

**Como roda:** Python (openpyxl, python-docx), FastAPI. Check = `pytest` na pasta do projeto + geração
ponta a ponta pela LAN com Excel e Word reais.

## Decisões
- 24/11/2026: **acabamento** portado da MC de Linhas para as três (`acabamento.py`): realça pendência
  `XXX` em amarelo, remove imagem órfã e **zera as propriedades do arquivo-modelo**. Isso fechou um
  vazamento real de dado de contrato — o `.docx` saía com autor `ENGENHARIA/IEABAST/EAB` (dono Petrobras
  do modelo) em todo documento.
- 24/11/2026: **painel de cobertura** nas três — `preencher_corpo` devolve uma dataclass `Cobertura`
  (preenchido × base × não recebido + avisos); `gerar_com_cobertura` novo; `gerar` mantém a assinatura
  `(saida, avisos)`. O app expõe `X-MC-Cobertura` e a tela mostra "o que a automação preencheu × o que
  veio da base".
- 24/11/2026: **aviso de formato de tabela** (Trocador/PSV): as tabelas são casadas por ordem; quando a
  legenda da planilha e a da base na mesma posição divergem, avisa em vez de escrever no lugar errado.
  No Vasos **não se aplica** (lá o casamento é por TAG, não por ordem).
- 24/11/2026: a trava anti-corpo-alheio existe no Vasos (TAG forte). No Trocador/PSV **não** foi
  implementada: o TAG é fraco e distinguir projeto de revisão depende de decisão de domínio da Manuela.
  Sinais levantados: o número do documento (contrato+unidade, ex. `9540.05-21236`, estável entre revisões
  e diferente entre contratos) é o discriminador mais forte; a TAG do equipamento no título é fraca.
- Regra de trabalho do Gustavo: escolha de desenvolvimento eu decido; para a Manuela vão só perguntas de
  engenharia (chave de identidade + metodologia-padrão).

## Lições
- Metadado do arquivo-modelo é vazamento de contrato: zerar dono/empresa/template/histórico/customXml
  antes de salvar (o `_propriedades` da Linhas). Medir o autor do `.docx` gerado é o teste que pega.
- Mudança de assinatura rippla: `preencher_corpo`/`gerar` tinham muitos chamadores; manter `gerar`
  `(saida, avisos)` e expor um `gerar_com_cobertura` novo evitou mexer em ~12 testes.
- Ao filtrar algo na extração (título de seção que vazava p/ Documentos), a **escrita** tem de pular o
  mesmo parágrafo, senão o round-trip quebra. Centralizar o critério num helper usado nos dois lados.
- Dois worktrees com o mesmo `mc_padrao` (Trocador/PSV): toda mudança vai e é testada nos dois; conferir
  o diff antes de copiar para garantir que é só a edição pretendida.

## Pendências (dependem da Manuela)
- Chave de identidade da trava anti-corpo-alheio no Trocador/PSV (recomendação: número contrato+unidade).
- Metodologia-padrão / modelo genérico do trocador (hoje o modelo do servidor é uma MC real de projeto).
- v2.0 = cálculo (piloto no separador de Vasos), atrás de portões.

## Estado (24/11/2026)
Code fechado e mergeado no `development` (PRs #115, #101, #104, #116). Apps de teste no ar. Falta o aceite
da Flaviane (saída) e as decisões de domínio da Manuela. GPlan: cards 617/618/619 em Concluído.

Related: [00-Index](../../00-Index.md) · [mc-linhas-processo](mc-linhas-processo.md)
