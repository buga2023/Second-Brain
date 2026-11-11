# Lab — IDOR da cesta no OWASP Juice Shop

Treino do fluxo inteiro num alvo feito para isso. O Juice Shop é
propositalmente vulnerável e roda na sua máquina, então é legal e seguro.
Escopo do lab: `in: 127.0.0.1`.

## Subir

```bash
podman start juice-shop || \
  podman run -d --name juice-shop -p 127.0.0.1:3000:3000 docker.io/bkimminich/juice-shop:latest
# espere o 200:
until curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:3000/ | grep -q 200; do sleep 2; done
```

## O exercício

Cada usuário tem uma cesta com um `BasketId`. O endpoint
`GET /rest/basket/{id}` **não confere** se a cesta é sua — troca o id e lê a
de outro. Clássico IDOR/BOLA.

Rode `referencias/lab-idor.sh` (abaixo) ou faça à mão no Burp:
1. Crie as contas A e B (`POST /api/Users`).
2. Faça login nas duas (`POST /rest/user/login`) e guarde `token` e `bid`.
3. Como A, chame `GET /rest/basket/<bid-de-B>` com o **token de A**.
4. Vem `success` com a cesta de B = IDOR provado. Pare.

## Saída real (rodada em 2026-11-10)

```
alice: bid=6  bob: bid=7
--- alice (token dela) pede a cesta dela:
{"status":"success","bid":6,"itens":[]}
--- alice (token dela) pede a cesta do BOB (7):
{"status":"success","bid":7,"itens":["Apple Juice (1000ml)"]}
```

A alice, com o token dela, leu a cesta 7 (do bob). O servidor devolveu
`success` em vez de `401/403`. Esse é o achado.

## Report de treino

Está em [`assets/report-exemplo-idor-juiceshop.md`](../assets/report-exemplo-idor-juiceshop.md) —
use como molde para o primeiro report real.

## No Burp (versão sem curl)

1. Target > Scope: só `127.0.0.1`.
2. Navegue logado como A pelo navegador do Burp; ache `GET /rest/basket/6`.
3. Repeater: troque `6` por `7`. Send. A resposta traz a cesta de B.
4. Confirme em massa com o Autorize usando a sessão de B.
