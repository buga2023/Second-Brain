---
title: "Síntese: bug bounty do zero (ferramentas, método e relatório)"
tipo: sintese
tags: [sintese, seguranca, bug-bounty, aprendizado]
fontes: []
date: 2026-11-11
---
# Bug bounty do zero

Pedido de origem: um reel do Instagram (`instagram.com/reel/DfkRRaJSTXS`) sobre
ferramentas de reporte de bug. **O vídeo não foi visto**: o Instagram está fora
da rede da sessão em nuvem. Esta página cobre o kit padrão do mercado; as
ferramentas do reel entram aqui quando o Gustavo passar os nomes.

## O que é

Empresas publicam um **programa** (escopo + regras + tabela de pagamento) numa
plataforma. Você testa só o que está no escopo, acha uma falha, escreve um
relatório reproduzível e recebe se a falha for **válida, nova (não duplicada)
e com impacto**. Testar fora do escopo, ou sistema sem programa, é crime
(Lei 12.737/2012 no Brasil), não importa a intenção.

## Plataformas

| Plataforma | Observação |
|---|---|
| HackerOne | Maior; tem o Hacker101 (curso grátis + CTF que dá convite para programa privado) |
| Bugcrowd | Bugcrowd University para iniciante |
| Intigriti, YesWeHack | Europa, bom volume |
| BugHunt | Brasileira, atendimento em PT-BR; clientes como OLX, Webmotors, Enjoei; recompensas noticiadas até R$ 8–15 mil por bug (números antigos, **não verificado** hoje) |
| Immunefi | Cripto / smart contracts; prêmios altos, exige Solidity |

## Ferramentas, por fase

1. **Proxy (a ferramenta principal):** Burp Suite Community (grátis) ou Caido.
   Intercepta e altera cada requisição do navegador. 80% do trabalho é aqui.
2. **Recon (achar superfície):**
   - Subdomínios: `subfinder -d alvo.com`, `amass enum -passive -d alvo.com`, crt.sh.
   - Quem está vivo: `httpx -l subs.txt -title -status-code`.
   - URLs antigas: Wayback Machine, `gau`, `waybackurls`.
   - Crawler: `katana -u https://alvo.com`.
3. **Fuzzing:** `ffuf -u https://alvo.com/FUZZ -w wordlist.txt` (diretórios e
   parâmetros). Wordlists: SecLists.
4. **Scanner por template:** `nuclei -l vivos.txt`. Acha o óbvio; o óbvio quase
   sempre já foi reportado (duplicado).
5. **Portas:** `nmap`. Menos útil em bounty web.

As ferramentas da ProjectDiscovery (subfinder, httpx, katana, nuclei) são em Go
e se encadeiam por pipe.

## Onde está o dinheiro para iniciante

Falha que scanner não acha, porque depende de entender a regra do negócio:

- **IDOR / controle de acesso quebrado:** trocar `id=123` por `id=124` e ver o
  dado de outro usuário. Teste com duas contas suas (A e B).
- **Lógica de negócio:** cupom aplicado duas vezes, preço negativo, pular etapa
  de pagamento.
- XSS, SSRF, SQLi: estudar no PortSwigger Web Security Academy (grátis, o melhor
  material que existe).

## O relatório (é o que paga)

1. Título: tipo + onde + impacto ("IDOR em /api/pedidos expõe endereço de qualquer cliente").
2. Passo a passo numerado que qualquer um reproduz.
3. Requisição/resposta HTTP e print ou vídeo curto.
4. **Impacto concreto**: o que um atacante faz com isso. Sem impacto, vira "informativo" e não paga.
5. Correção sugerida.

## IA em 2026: cuidado

As plataformas estão afogadas em relatório gerado por IA sem verificação
("AI slop"). O curl encerrou o bounty pago em jan/2026 por isso; a HackerOne
pausou o Internet Bug Bounty em mar/2026; o GitHub estaria limitando novos
pesquisadores (fonte única, **não verificado**). Consequência prática: relatório
de IA sem prova reproduzida queima sua reputação na plataforma. Use IA para
ler código, montar wordlist e revisar texto; prove tudo à mão.

## Trilha de estudo sugerida

1. Semanas 1–4: HTTP, cookies, sessões; PortSwigger Academy (Apprentice).
2. Semanas 5–8: Burp no dia a dia; labs de IDOR, controle de acesso, XSS.
3. Mês 3: Hacker101 CTF; ler relatórios públicos (Hacktivity da HackerOne).
4. Mês 4+: um único programa com escopo amplo, foco em lógica de negócio,
   duas contas, semanas no mesmo alvo. Primeira recompensa costuma levar
   meses (estimativa de guias, não medida).

## Perguntas abertas

- Quais ferramentas aparecem no reel `DfkRRaJSTXS`?

## Fontes consultadas (web, 2026-11-11)

- [Netlas: roadmap 2026](https://netlas.io/blog/bug_bounty_roadmap/)
- [HackerDNA: guia iniciante 2026](https://hackerdna.com/blog/bug-bounty)
- [Computing: plataformas contra AI slop](https://www.computing.co.uk/news/2026/security/bug-bounty-platforms-battle-ai-slop)
- [Dark Reading: HackerOne pausa bounties](https://www.darkreading.com/application-security/ai-led-remediation-crisis-prompts-hackerone-pause-bug-bounties%250A)
- [The New Stack: GitHub e AI slop](https://thenewstack.io/github-bug-bounty-ai-slop/?p=22823557)
- [Olhar Digital: até R$ 8 mil por bug](https://olhardigital.com.br/noticia/programas-cacadores-de-falhas-pagam-ate-r-8-mil-por-bug-no-pais/104938)
- [Baguete: OLX com BugHunt](https://www.baguete.com.br/noticias/olx-procura-falhas-com-bughunt)

Related: [wiki index](../index.md), [decidir-langchain-ou-langgraph](decidir-langchain-ou-langgraph.md)
