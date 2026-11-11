# Fase 3 — Teste manual (onde o valor aparece)

Provar uma classe de falha com o Burp e o navegador, usando **só contas
suas**. Pare na prova mínima (SKILL.md). Comece por IDOR: é a porta de
entrada mais rendosa para iniciante.

## Burp Suite Community — montar

- Baixe o instalador Linux em portswigger.net/burp/communitydownload e rode.
- Use o **navegador embutido** do Burp (Proxy > Intercept > Open Browser):
  já vem com proxy e certificado, sem configurar nada.
- **Target > Scope**: adicione só os hosts `in:`. Em Proxy > Options ligue
  "Don't send items to Proxy history... if out of scope" para não registrar
  tráfego de host fora do escopo.
- Limitações da Community: não salva projeto; o **Intruder vem lento**
  (throttled) — para fuzz de volume use o ffuf.
  (https://portswigger.net/burp/communitydownload)

### Ferramentas do Burp que você vai usar
- **Proxy**: intercepta e deixa alterar requisição.
- **Repeater**: reenvia uma requisição com alterações. É o cavalo de
  batalha do teste manual.
- **Decoder / Comparer**: decodifica (base64, url) e compara respostas.
- **Autorize** (extensão grátis, roda na Community): reenvia cada requisição
  com uma sessão de baixo privilégio para achar IDOR/falha de autorização em
  massa. Precisa do Jython standalone (Settings > Extensions > Python
  Environment). Ele triplica o tráfego — respeite o limite de taxa.
  (https://github.com/PortSwigger/autorize)

## Classes e o teste mínimo de cada

Referência completa: OWASP WSTG (owasp.org/www-project-web-security-testing-guide).

| Classe | Teste mínimo (com suas contas) | Prova que basta |
|---|---|---|
| **IDOR / BOLA** | Contas A e B. Pegue uma requisição de A com ID (`/api/x/1043`), mande ao Repeater, troque pelo ID de um objeto de B | A lê/altera dado de B |
| **XSS refletido** | Ache um parâmetro refletido na página; injete `"><svg onload=alert(document.domain)>` | O `alert` dispara com o domínio do alvo |
| **XSS armazenado** | Campo salvo (nome, comentário) com o mesmo payload; abra onde ele aparece | Dispara para outra sessão |
| **SQLi** | Num parâmetro, teste `'` e veja erro; depois `' OR '1'='1` em ponto de login/busca | Erro de SQL ou lógica alterada. Pare — não extraia o banco |
| **SSRF** | Parâmetro que busca URL (webhook, importar imagem): aponte para um domínio seu (Collaborator/servidor) | Recebe a conexão vinda do servidor do alvo |
| **Open redirect** | Parâmetro `?url=`/`?next=`: troque por `https://exemplo-seu.com` | Redireciona para o domínio externo |
| **CSRF** | Ação sensível sem token anti-CSRF: monte um form que a dispara | A ação ocorre a partir de outra origem |
| **Lógica de negócio** | Preço negativo, pular etapa de pagamento, cupom repetido, trocar papel | O sistema aceita o estado que não devia |

## IDOR passo a passo (o que você vai fazer mais)

1. Crie duas contas suas, A e B.
2. Logado como A, com o Proxy ligado, navegue e ache requisições com
   identificador (numérico, UUID, e-mail).
3. Mande ao Repeater. Troque o identificador por um objeto de B.
4. Resposta `200` com dado de B = IDOR. **Pare.** Não baixe mais nada.
5. Varredura em massa: Autorize com a sessão de B, respeitando a taxa.

O lab pratica exatamente esse fluxo:
[`lab-juice-shop.md`](lab-juice-shop.md).
