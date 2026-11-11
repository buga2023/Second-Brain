---
title: Pesquisa web — ferramentas e regras de bug bounty
tipo: fonte
tags: [seguranca, bug-bounty, recon, ferramentas]
fontes: [2026-11-10-pesquisa-web-bug-bounty-ferramentas.md]
date: 2026-11-10
---
# Pesquisa web: ferramentas e regras de bug bounty

Aprofundamento das fontes oficiais (HackerOne, Bugcrowd, Intigriti,
ProjectDiscovery, PortSwigger) para alimentar a skill
[bug-bounty](../../memory/projects/bug-bounty.md). Fonte bruta e todas as
URLs: [raw](../../raw/2026-11-10-pesquisa-web-bug-bounty-ferramentas.md).

## O que mais muda a prática
- **Velocidade padrão é perigosa**: httpx e nuclei mandam ~150 req/s; ffuf
  não tem limite. Sempre `-rl`/`-rate`. Programas pedem bem menos (o da
  Intigriti fixa 10 req/s). Sem limite declarado, use 5 req/s.
- **nuclei não exclui `intrusive` por padrão** — passe
  `-etags dos,intrusive,fuzz,bruteforce`. E só rode scanner se a política
  permitir.
- **Header de identificação** (HackerOne `X-HackerOne-Research`, Intigriti
  `X-Intigriti-Username`) identifica, não autoriza.
- **Reputação**: N/A −5, Spam −10, duplicata pública −5; Informative 0.
  N/A que você mesmo fecha vale 0 — feche se não der para provar.
- **Dados de terceiros**: parar na prova; "dumping a database" é violação.
  IA autônoma sem humano no loop é vedada (HackerOne).
- **Burp Community**: não salva projeto, Intruder throttled; use ffuf para
  volume. Autorize roda na Community (precisa Jython), bom para IDOR.
- **Safe harbor** não cobre infraestrutura de terceiros; leia a cláusula.

## Perguntas abertas
- Limite exato do Intruder na Community e modo `-q` do instalador desktop:
  a doc oficial não publica.
- BugHunt: forma de pagamento e documentos de cadastro — não encontrado.
- Tributação de recompensa do exterior (carnê-leão): Receita confirma o
  carnê-leão, mas regra de conversão e natureza do rendimento sem fonte
  oficial; fontes de terceiros se contradizem. Confirmar com contador.

Related: [guia-bug-bounty](../guias/guia-bug-bounty.md) · [bug-bounty](../../memory/projects/bug-bounty.md) · [raw](../../raw/README.md)
