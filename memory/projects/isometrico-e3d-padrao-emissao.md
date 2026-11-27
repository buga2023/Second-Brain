---
title: Isométrico do E3D no padrão de emissão
date: 2026-11-23
tags: [projeto, automacao, tubulacao, e3d, dxf]
aliases: [inserir padrão no autocad, isometrico padrao emissao]
---

# Isométrico do E3D no padrão de emissão

**O que é:** automação da GP (Tubulação) que pega o isométrico extraído do AVEVA
E3D em DXF e devolve o DWG no padrão de emissão: moldura fechada, acentos
corrigidos e campos de projeto do carimbo preenchidos. Pedido "Inserir padrão no
AutoCAD", Portal NTI, 23/11/2026. Prazo pedido: 25/11/2026.

**Pessoas:** solicitante e especialista Fábio Cruz dos Santos; testes Fábio e
Pedro Illo; aprovador da disciplina Pedro Illo.

**Onde está:** repo GpDevLab/GPautomacoes, `Projetos/Isométrico E3D no Padrão de
Emissão (Tubulação)/`, branch `feature/isometrico-e3d-padrao-emissao`, worktree
`automaçoes/wt-isometrico-padrao`. Par real e configuração real do contrato só
na máquina, em `_Dados Reais/Tubulação/Isométrico E3D no Padrão de Emissão`.

**Como roda:** Python + ezdxf sobre o DXF; ODA File Converter gera o DWG.
`python -m padrao_isometrico ENTRADA.dxf --config <contrato>.json --saida PASTA`.
Check = `conferir.py` saída × gabarito, item a item, e `pytest`.

## Decisões e achados

- 23/11/2026: o par anexado ao pedido não é antes/depois do padrão. O DWG é a
  revisão 01 de outra extração do modelo (lista de material, peso e traçado
  diferentes). Serve de gabarito só para moldura, acentos e carimbo.
- 23/11/2026: o DXF do E3D vem todo num layer, sem blocos, e escreve acento como
  `\U+00C3`. Grava a extensão da folha com 2 coordenadas, o que quebrou o
  primeiro teste com arquivo real.
- 23/11/2026: valores do carimbo ficam em configuração por contrato, por posição
  na folha. Campo que muda por folha e não está no DXF (documentos de referência,
  número do SGM) fica como veio e sai sinalizado.
- 23/11/2026: regra da data com 4 dígitos fica desligada. No gabarito duas datas
  têm 4 dígitos e uma tem 2; falta o Fábio dizer qual é a regra.
- 23/11/2026 (Gustavo): seguir construindo e tirar a dúvida da origem dos valores
  do carimbo no final.

- 25/11/2026: o Fábio respondeu "pra mim tá ok" no Teams sobre o resultado do
  teste. O Pedro Illo tentou usar e não conseguiu: só existia a linha de comando,
  e foi dito a ele que era um plugin de ZWCAD. Não é e nunca foi.
- 25/11/2026 (Gustavo): fazer a tela no Portal e deixar pronto para o Pedro usar.
  Tela = app web no molde das outras (FastAPI, porta 8959, slug
  `isometrico-padrao-emissao`, BETA). Várias folhas por envio, saída em .zip.
  Contrato escolhido numa lista lida de pasta fora do git (`ISO_CONTRATOS`).
  Resultado por folha: OK, Conferir (EX-01/EX-02) ou Erro; EX-03 vira "Preencher
  à mão".
- 25/11/2026: prova no Caso A pela tela, via endereço da LAN: DWG baixado e DWG do
  comando têm as mesmas 4.336 entidades, 0 diferentes; 11 de 11 itens do padrão
  iguais ao gabarito.

- 26/11/2026 (Gustavo): tudo que rodava só na máquina dele vai para o servidor Linux,
  para não cair quando o PC desliga. Eram cinco apps: APR, HAZOP, FD de Mecânica,
  Emissor de FD e este. Emissor de FD, APR e HAZOP já tinham subido em 24/11 e saíram do ar em
  25/11, quando um deploy da LI partiu de outra linha. Deploy novo parte sempre
  do commit que está no ar.
- 26/11/2026: conversão para DWG medida no Linux pela primeira vez. Caso A pelo
  endereço oficial: 4.336 entidades, 0 diferentes do DWG gerado no Windows; 11 de 11
  itens do padrão iguais ao gabarito.

- 26/11/2026 (Fábio, com o Gustavo): o SGM tem de sair no carimbo. Entrou na configuração
  do contrato; Caso A passou de 11 para 13 itens iguais ao emitido. Falta o Fábio dizer se
  o número vale para todas as folhas do contrato.
- 26/11/2026 (Gustavo): a própria pessoa cadastra o contrato na tela e digita o que vai em
  cada campo do carimbo. Feito na v0.2.0: sete campos (unidade, programa, área, duas linhas
  de título, SGM, órgão gestor); posições do carimbo em `config/carimbo_e3d.json`, medidas
  em uma folha; programa, área e título saem centralizados. Sem login e sem exclusão pela
  tela. O contrato RPBC configurado pelo NTI não é editável pela tela.

- 27/11/2026: a fonte do carimbo (`O8116901.shx`, estilo HTX1) **não existe em nenhuma máquina
  da GP**. Quem gera o PDF usa a de substituição, mais larga, e o texto passa da borda da célula.
  O DWG emitido à mão pela engenharia tem o mesmo defeito, então não vem da automação. Decisão do
  Gustavo: como ninguém tem a fonte, a automação mede a célula no desenho e estreita o que ela
  escreve até caber (RN-06; EX-04 quando nem no mínimo cabe).

- 27/11/2026: nas extrações novas do E3D o carimbo **já vem preenchido** (título, programa, área,
  cliente). A automação não reescreve campo que já está na posição, então o texto largo era do
  próprio desenho. A RN-06 passou a medir todo texto dentro do carimbo, não só o que ela escreve.

## Onde roda

Servidor Linux do portal desde 26/11/2026: `http://10.71.0.32:8080/app/isometrico-padrao-emissao/`
(PM2, branch `deploy/apps-locais-26-11`). A configuração do contrato fica no servidor,
fora do git, e chega ao app pela variável `ISO_CONTRATOS`. A máquina do Gustavo não
serve mais essa tela. PR #144 ainda sem revisão humana. Card GPlan 655.

## Próximo passo

Aceite do Fábio no Portal; abrir no CAD um DWG de contrato criado pela tela; par da mesma
extração em revisão 0; Casos B e C;
origem dos documentos de referência e do SGM; regra da data e sufixo de revisão.

Related: [README](README.md) · [sgm](sgm.md) · [revisao-fluxograma-engenharia](revisao-fluxograma-engenharia.md)
