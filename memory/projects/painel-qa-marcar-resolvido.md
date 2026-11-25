---
title: Painel de QA — marcar "Resolvi"
date: 2026-11-25
tags: [projeto, qa, nti, automacao, processo-de-trabalho]
---

# Painel de QA — marcar "Resolvi"

**O que é:** o passo do fluxo de QA que é fácil de pular e que trava tudo quando falta.

**Corrigir e mergear não tira o achado da fila.** O Caio só é chamado a retestar quando o dev
marca **"✔ Resolvi"** no [Painel de QA](painel-qa-nti.md). Sem isso a automação fica para
sempre em "já testada, com erros com os desenvolvedores", mesmo com tudo corrigido e no ar.
Em 25/11/2026 o painel dizia "o dev marcou como resolvido: 0 automações" com 11 PRs mergeados.

## Como marcar

Um POST por achado:

```
POST /api/dev/resolvido        (multipart/form-data)
  chave   = "SOL-083 - MC de SPDA"
  arquivo = "2026-11-24 PR89.json"      (de /api/automacao/<chave> → execucoes[0].arquivo)
  erro    = "E05"                       (sem código: "t:" + os 120 primeiros caracteres do título)
  por     = "Gustavo (via Claude)"
  nota    = "PR #130 mergeado em 25/11; teste de regressão na suíte da pasta"
```

Os achados abertos são `execucoes[0].erros` com `reproduzido != false` e `triagem` fora de
`falso_positivo` e `corrigido`.

## Regras

- Marcar **só** achado cujo PR está **mergeado** e que tem teste. PR aberto, não.
- Pendência que depende de decisão de alguém não se marca: ela não foi corrigida.
- O painel leva cerca de 1,5 s por marcação — 65 passaram de dois minutos. Rodar em segundo
  plano.
- Para desfazer: coluna "Dev" na página da automação.
- A auditoria registra nome, data e nota de cada marcação; conferir lá depois.

Related: [painel-qa-nti](painel-qa-nti.md), [rodada-qa-automacoes](rodada-qa-automacoes.md)
