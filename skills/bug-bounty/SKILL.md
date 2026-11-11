---
name: bug-bounty
description: Caçar vulnerabilidade em programa de bug bounty web com trava de escopo — escopo, recon, teste manual, prova mínima e report. Use ao testar um programa (HackerOne, Bugcrowd, Intigriti, BugHunt), achar falha web (IDOR, XSS, SQLi, SSRF, open redirect, CSRF, falha de lógica), rodar recon (subfinder, httpx, nuclei, ffuf) ou escrever report de vulnerabilidade. Também para treinar no lab OWASP Juice Shop.
---

# bug-bounty

Conduz uma caçada de bug bounty web do escopo ao report. A regra que
manda em tudo: **nenhuma ferramenta toca um alvo que não está no escopo
escrito.** Testar fora do escopo é crime (no Brasil, art. 154-A do Código
Penal), e invalida o programa. O que separa o pesquisador do criminoso é a
autorização — e a autorização é o `escopo.txt`.

Estude a teoria no [guia](../../wiki/guias/guia-bug-bounty.md). Esta skill é
o procedimento de campo.

## Portão de escopo (sempre primeiro)

Antes de qualquer comando contra qualquer host, exista um arquivo
`escopo.txt` no diretório de trabalho. Se não existir, **pare e crie com o
usuário**. Formato:

```
# programa: <nome e URL do programa>
# fonte da política: <URL>  | lida em: <AAAA-MM-DD>
# header de identificação: <ex. X-HackerOne-Research: usuario | ou "nenhum">
# limite de taxa declarado: <ex. 10 req/s | ou "não declarado -> use 5 req/s">
in:  *.exemplo.com
in:  api.exemplo.com
out: blog.exemplo.com
out: tudo que não casa com uma linha "in:"
```

Regras do portão, sem exceção:
1. Todo alvo passa por `python3 referencias/escopo.py escopo.txt <host-ou-url>`
   antes do primeiro comando. Saída `OUT` ou `ERRO` = não rode nada.
2. Um alvo só está dentro se casa uma linha `in:` **e** nenhuma `out:`.
3. Subdomínio achado no recon entra no mesmo teste antes de ser sondado.
4. Lab local (`127.0.0.1`, `localhost`): escopo é a linha `in: 127.0.0.1`.
   O Juice Shop é o único alvo de treino.

## Fases

Siga na ordem. Cada fase tem sua referência; abra a da fase em que está.

1. **Escopo** — ler a política do programa, preencher `escopo.txt`,
   anotar o que é proibido. Referência: [`referencias/escopo-e-regras.md`](referencias/escopo-e-regras.md).
2. **Recon** — mapear a superfície dentro do escopo com subfinder, httpx,
   nuclei, ffuf, sempre com freio de taxa. Referência: [`referencias/recon.md`](referencias/recon.md).
3. **Teste manual** — provar uma classe de falha com o Burp e o navegador,
   usando só contas suas. É onde o valor aparece. Referência: [`referencias/teste-web.md`](referencias/teste-web.md).
4. **Report** — escrever o report que paga: título específico, passos,
   impacto concreto, prova mínima. Referência: [`referencias/report.md`](referencias/report.md).

## Prova mínima (a trava que protege você)

Pare no primeiro sinal de que a falha existe. Uma leitura cruzada, um
`alert(document.domain)`, um redirect para domínio externo — isso prova.
**Não** continue para baixar dados de terceiros, despejar banco, apagar,
pivotar ou escalar. O exploit não é o produto; a prova é. Ir além viola o
código de conduta dos programas e passa a ser dano real.

## Freio de taxa (decorar)

Ferramenta nenhuma vai na velocidade padrão (httpx e nuclei mandam ~150
req/s; ffuf não tem limite). Sempre: `httpx -rl`, `nuclei -rl`, `ffuf -rate`.
Sem limite declarado na política, use 5 req/s. Detalhe e flags perigosas a
evitar: [`referencias/recon.md`](referencias/recon.md).

## Treinar primeiro

Antes de um programa real, rode o fluxo inteiro no lab:
```bash
podman start juice-shop || podman run -d --name juice-shop -p 127.0.0.1:3000:3000 docker.io/bkimminich/juice-shop:latest
```
Caminhada guiada do IDOR da cesta (duas contas, leitura cruzada, report):
[`referencias/lab-juice-shop.md`](referencias/lab-juice-shop.md).
