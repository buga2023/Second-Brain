---
title: Painel de QA do NTI
date: 2026-11-25
tags: [projeto, qa, nti, automacao]
---

# Painel de QA do NTI

**O que é:** o sistema onde o Caio registra a QA das automações da GP e onde o time acompanha
o estado de cada uma. É a **fonte da verdade** dos achados: o relatório em Markdown e os
checklists em Excel saem dele, não o contrário.

**Onde está:** `http://10.71.0.100:8960`. Tela em `/#/automacoes`, `/#/prs` e `/#/auditoria`.

**Pessoas:** QA Caio Fernandes (agente `agente-qa`); responsável NTI Gustavo.

## API

| Rota | Para quê |
|---|---|
| `/api/resumo` | KPIs, lista de automações e o grupo de cada uma |
| `/api/automacao/<chave>` | execuções de QA, achados, PRs ligados |
| `/api/prs` | PRs vistos no GitHub, já casados com a automação |
| `/api/auditoria` | histórico de tudo que mudou |
| `/checklist-erros/<chave>.xlsx` | um achado por linha, com **"Como reproduzir"** e **"Resultado esperado (corrigido)"** |
| `/checklist/<chave>.xlsx` | roteiro de teste da automação |
| `/planilha-comentada?chave=&arquivo=` | a planilha de entrada que a QA usou, comentada |
| `/api/dev/resolvido` | marcar achado como resolvido — ver [painel-qa-marcar-resolvido](painel-qa-marcar-resolvido.md) |

A chave é o nome inteiro, com o código: `SOL-010 - Lista de Isométricos`.

## O que o painel lê do git

Ele sincroniza os PRs do GitHub por período (campo `prs_sincronizados_em`) e casa cada um com
a automação pela pasta tocada e pelo código `SOL-xxx` citado no título ou no corpo. Do corpo
ele extrai dois campos que aparecem na tela:

- **itens** — a lista **numerada** sob `## O que foi feito`;
- **pendências** — as caixas `- [ ]`.

Corpo de PR em outro formato (tabela, bullets sob outro título) deixa os dois campos vazios, e
o painel não mostra o que já foi feito.

## Grupos

Cada automação cai num grupo, e é por ele que o painel decide de quem é a bola:

- **precisa de reteste** — houve código novo depois da QA;
- **com o desenvolvedor** — o resultado vale para o código atual;
- **apto com ressalvas** — pode usar, o dev conserta o que sobrou;
- **resolvido** — o dev marcou e o Caio ainda não reteste.

Related: [painel-qa-marcar-resolvido](painel-qa-marcar-resolvido.md),
[rodada-qa-automacoes](rodada-qa-automacoes.md)
