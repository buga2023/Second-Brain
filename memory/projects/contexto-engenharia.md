---
title: Harness de contexto de engenharia
date: 2026-11-13
tags: [projeto, automacao, harness, gp]
aliases: [contexto-engenharia, harness de consulta]
---

# Harness de contexto de engenharia

Ferramenta local que recebe o texto de um pedido de automação da GP e devolve
um **dossiê de contexto** antes de alguém construir. Aprovada pelo Gustavo em
13/11/2026, depois de um dia em que boa parte do retrabalho veio de contexto
que existia e não foi consultado.

## Por que existe

Em 13/11 três tropeços tinham a mesma causa:

- uma correção foi feita em dobro, porque a branch de integração já tinha o
  conserto de um colega;
- um pedido recusado no portal já estava construído e no ar;
- uma conversão de unidade só foi descoberta medindo os dados: a pressão do
  simulador é absoluta e a do documento é manométrica.

Nos três casos a informação já estava no repositório, no vault ou nos dados.
Faltava perguntar antes de construir.

## O que o dossiê responde

1. **O que já existe:** automações parecidas e módulos para reaproveitar
   (leitores de folha de dados, preenchedor de Word/Excel, conversão de
   unidades, carimbo, numeração de documento).
2. **Engenharia:** tipo de documento e classe na codificação Petrobras/GP, e as
   normas prováveis. Vem de cartões curtos escritos com fonte.
3. **Dados disponíveis:** se há par entrada → gabarito **do mesmo projeto**.
   Só metadados (nome, tipo, data); o conteúdo de dado de contrato nunca é
   indexado.
4. **Pessoas:** especialista e solicitante da disciplina.
5. **Lições:** bugs recorrentes que se aplicam (ver
   [lições da auditoria](../context/licoes-auditoria-automacoes.md)).
6. **Perguntas** a fazer ao solicitante, a partir das lacunas.

## Desenho

- Python + SQLite FTS5 (BM25), sem nuvem e sem modelo de IA. Roda na máquina
  onde os dados estão.
- Fontes: vault de automações, README/AGENTS/docstrings dos projetos, registro
  do portal, cartões de conhecimento versionados e metadados da pasta de
  dados reais.
- CLI: `indexar` e `consultar "<pedido>" [--disciplina] [--json]`.
- Vira uma skill (`contexto-engenharia`) que as skills de criação de
  automação chamam no primeiro passo
  ([triagem-automacao-gp](triagem-automacao-gp.md) e pedido-automacao).

## Critério de pronto

Consultando com o texto de dois pedidos reais de 13/11, o dossiê tem de trazer:

- **FDs de equipamentos elétricos:** o app de FD de equipamento elétrico e a
  RM de elétrica entre os parecidos, e a norma do formulário.
- **Balanço material a partir do simulador:** a nota do pedido, o cartão de
  pressão absoluta → manométrica, a classe do documento de balanço e os
  arquivos do projeto (só nomes).

## Estado

- 13/11/2026: em construção na branch `feat/contexto-engenharia` do
  repositório de automações (pasta `Projetos/_contexto_engenharia`). PR e
  instalação da skill depois da revisão.

## Perguntas abertas

- Indexar também as transcrições de reunião e as conversas do Teams? Hoje
  ficam fora, por serem conversa e não decisão.
- Atualização do índice: manual (`indexar`) ou a cada commit no repositório?

Related: [Projetos](README.md), [triagem-automacao-gp](triagem-automacao-gp.md),
[lições da auditoria](../context/licoes-auditoria-automacoes.md),
[Esteira NTI](../../wiki/projetos/esteira-nti.md)
