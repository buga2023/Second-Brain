# Fase 1 — Escopo e regras

Objetivo: sair daqui com `escopo.txt` preenchido e a lista do que é
proibido. Nada de ferramenta nesta fase.

## Passos

1. Abra a política do programa e leia inteira. Anote a URL e a data.
2. Liste os alvos em `in:` e `out:` no `escopo.txt` (formato na SKILL.md).
   Um domínio nu (`exemplo.com`) não entra por `*.exemplo.com` — liste os
   dois se ambos valem.
3. Copie para o cabeçalho: header de identificação exigido e limite de taxa.
4. Anote o que é proibido (seção abaixo) onde você for ver antes de testar.

## Quase sempre proibido (confirme na política)

- **DoS / teste de carga**, e qualquer automação de volume alto.
- **Engenharia social** e phishing contra funcionários ou usuários.
- **Acesso a dados de terceiros**: parar na prova; não baixar, não despejar
  banco. O código de conduta da HackerOne lista "dumping a database" como
  violação. (https://www.hackerone.com/policies/code-of-conduct)
- **Scanner automático pesado** sem permissão (muitos proíbem nuclei/scan
  de volume). O GitHub dá "65,000 requests in two minutes" como exemplo de
  excesso. (https://bounty.github.com/rules)
- **Testar só com suas contas.** Nunca contas de terceiros.
- **IA autônoma sem humano no loop** é vedada pelo código de conduta da
  HackerOne.

## Header de identificação

Alguns programas pedem um header em todo o tráfego para reconhecer você:
- HackerOne: `X-HackerOne-Research: <seu-usuario>`
- Intigriti: `X-Intigriti-Username: <seu-usuario>`

Ele identifica, não autoriza: qualquer um pode enviá-lo, então não dá
imunidade. Passe nas ferramentas com `-H`. (https://docs.hackerone.com/en/articles/8369822-traffic-identification)

## Reputação (HackerOne) — por que importa já

Report ruim custa pontos: **N/A −5**, **Spam −10**, duplicata de falha já
pública **−5**; Informative não tira. Um N/A que você mesmo fecha vale 0 —
se não dá para provar o impacto, feche antes de virar N/A.
(https://docs.hackerone.com/hackers/reputation.html)

## Safe harbor

Proteção legal existe mas tem limite: o Gold Standard Safe Harbor não cobre
infraestrutura de terceiros; "partial" na disclose.io vale menos que "full".
Leia a cláusula do programa antes de confiar nela.
(https://docs.hackerone.com/organizations/safe-harbor-faq.html)

## CVSS em uma frase

Nota de severidade de 0 a 10 (v3.1/v4.0). O programa costuma ter a própria
taxonomia — na Bugcrowd é a VRT, e um P5 vai para "Won't Fix" por padrão.
Mais detalhes só quando for pontuar um achado real.
