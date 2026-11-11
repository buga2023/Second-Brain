# IDOR em GET /rest/basket/{id} permite ler a cesta de outro usuário

> Report de treino, escrito contra o OWASP Juice Shop (lab local). Serve de
> molde para o primeiro report real. Não enviar a lugar nenhum: é lab.

## Resumo
O endpoint `GET /rest/basket/{id}` não verifica se a cesta pertence ao
usuário autenticado. Trocando o `{id}`, um usuário logado lê a cesta de
qualquer outro.

## Passos para reproduzir
1. Criei duas contas minhas: A (`alice.lab@bb.local`) e B
   (`bob.lab@bb.local`).
2. Fiz login nas duas. A recebeu `bid=6`; B recebeu `bid=7`. B tinha um
   item na cesta (Apple Juice 1000ml).
3. Autenticado como A, com o **token de A**, chamei a cesta de B:
   ```http
   GET /rest/basket/7 HTTP/1.1
   Host: 127.0.0.1:3000
   Authorization: Bearer <token-de-A>
   ```
4. Resposta `200`:
   ```json
   {"status":"success","data":{"id":7,"Products":[{"name":"Apple Juice (1000ml)"}]}}
   ```
   A leu a cesta de B. Esperado seria `401`/`403`.

## Impacto
Qualquer usuário autenticado lê a cesta de qualquer outro iterando o `id`
(1, 2, 3, ...), expondo o que outros clientes pretendem comprar. Em loja
real, vazamento de dado de compra de toda a base.

## Evidência
Saída das duas chamadas (cesta própria vazia, cesta alheia com item), feita
só com minhas duas contas. Nenhum dado de terceiro foi acessado.

## Correção sugerida
No servidor, validar que `basket.UserId == session.userId` antes de
devolver a cesta; negar com `403` caso contrário.
