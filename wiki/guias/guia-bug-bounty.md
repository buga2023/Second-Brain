---
title: Guia de bug bounty — do zero ao primeiro report pago
tipo: guia
tags: [seguranca, bug-bounty, pentest, aprendizado]
fontes: [2026-11-10-reel-nogcyber-ferramentas-hacking.md]
date: 2026-11-10
---
# Guia de bug bounty: do zero ao primeiro report pago

Bug bounty: empresas publicam um **programa** dizendo o que pode ser
testado (escopo) e quanto pagam por falha. Você acha a falha, escreve um
**report**, a plataforma faz a triagem e a empresa paga. Sem contrato e sem
salário: só ganha quem acha falha válida, que ninguém reportou antes.

> Os comandos abaixo vêm da documentação e de guias; **não foram rodados
> nesta sessão**. Teste primeiro em lab (Juice Shop local).

> **Regra de ouro.** Só teste o que está no escopo de um programa em que
> você está inscrito. Fora disso é crime no Brasil (art. 154-A do Código
> Penal, Lei 12.737/2012), mesmo que a intenção seja boa. Leia a política
> inteira do programa antes do primeiro pacote.

## 1. Expectativa realista
- Ficou mais difícil que em 2018–2020, mas não acabou ([Netlas](https://netlas.io/blog/bug_bounty_roadmap/)).
- Primeiro pagamento costuma ficar entre US$ 100 e 500 ([Netlas](https://netlas.io/blog/bug_bounty_roadmap/)). Leva meses, não semanas.
- No Brasil a BugHunt cita até R$ 8 mil por bug e até R$ 120 mil/ano para os melhores **(não verificado, número da própria empresa)** ([Olhar Digital](https://olhardigital.com.br/noticia/programas-cacadores-de-falhas-pagam-ate-r-8-mil-por-bug-no-pais/104938), [Canaltech](https://canaltech.com.br/seguranca/participantes-de-bug-bounty-podem-faturar-ate-r-120-mil-em-menos-de-um-ano-215003/)).
- Maior risco do iniciante: **duplicata** (alguém reportou antes) e **N/A** (não é falha que o programa aceita).

## 2. Trilha de estudo (ordem)

| Etapa | O que estudar | Onde (grátis) |
|---|---|---|
| 1. Base | HTTP (métodos, headers, cookies, status), HTML/JS, como login e sessão funcionam, DNS | MDN Web Docs; DevTools do navegador |
| 2. Classes de falha | OWASP Top 10: controle de acesso quebrado (IDOR), XSS, SQLi, SSRF, CSRF, falhas de autenticação | [PortSwigger Web Security Academy](https://portswigger.net/web-security) |
| 3. Ferramenta central | Burp Suite Community: Proxy, Repeater, Intruder, Decoder | Labs da própria Academy (a maioria roda no Community) ([HackerDNA PT](https://hackerdna.com/pt-br/blog/portswigger-web-security-academy)) |
| 4. Prática guiada | Máquinas e salas de web | TryHackMe, Hack The Box, OWASP Juice Shop (local) |
| 5. Uma classe só | Escolha **IDOR** e fique nela até achar uma: é a porta de entrada mais citada ([Netlas](https://netlas.io/blog/bug_bounty_roadmap/)) | Labs de "Access control" da Academy |
| 6. Programa real | Programa com rótulo "beginner friendly" ou VDP, escopo largo | HackerOne, Bugcrowd (Bugcrowd University), Intigriti, BugHunt (BR) |

## 3. As ferramentas, por fase

### Ambiente
- **Kali Linux** (citado no vídeo): distro com tudo pronto. No seu Fedora dá
  para rodar como VM, ou instalar só as ferramentas (Go + pacotes) sem Kali.
- **Burp Suite Community**: baixar em portswigger.net, configurar o
  navegador embutido do Burp (já vem com proxy e certificado).

### Reconhecimento: descobrir a superfície
| Ferramenta | Faz | Exemplo |
|---|---|---|
| subfinder | Lista subdomínios por fontes passivas | `subfinder -d alvo.com -silent > subs.txt` |
| httpx | Diz quais subdomínios respondem e o que rodam | `httpx -l subs.txt -title -tech-detect -status-code` |
| Shodan | Buscador de aparelhos e serviços expostos | `ssl.cert.subject.cn:"alvo.com"` no site |
| theHarvester | E-mails, hosts e nomes públicos | `theHarvester -d alvo.com -b crtsh` |
| Maltego | Grafo visual de OSINT (pessoas, domínios) | mais usado em investigação; em bug bounty, raro |
| crt.sh | Certificados emitidos → subdomínios | `https://crt.sh/?q=%25.alvo.com` |

Cadeia típica: `subfinder → httpx → nuclei` ([ProjectDiscovery](https://projectdiscovery.io/blog/building-one-shot-recon)). Instalação: `go install -v github.com/projectdiscovery/<ferramenta>/cmd/<ferramenta>@latest` (confira o caminho na doc oficial).

### Varredura
| Ferramenta | Faz | Exemplo |
|---|---|---|
| Nmap | Portas abertas e serviço/versão | `nmap -sV -T3 host-do-escopo` |
| ffuf | Fuzz de diretórios, arquivos e parâmetros escondidos | `ffuf -u https://alvo.com/FUZZ -w wordlist.txt -rate 10` |
| nuclei | Scanner por templates (CVEs, misconfig) | `nuclei -l vivos.txt -severity medium,high` |
| Nessus / OpenVAS | Scanner de vulnerabilidade de infraestrutura | Usado em pentest; em bug bounty gera barulho e "versão antiga" sem prova é recusado |

Respeite o limite de requisições do programa (`-rate`, `-T3`). Muitos
proíbem scanner automático pesado. Mais ferramenta não é mais resultado:
trabalho manual focado em poucos alvos costuma render mais ([Fun of Cybersecurity](https://funofcybersecurity.blogspot.com/2026/02/the-recon-mistake-90-of-hackers-make.html)).

### Teste manual (onde o dinheiro está)
**Burp Suite** fica entre navegador e servidor e deixa ver e alterar cada
requisição. Fluxo básico para IDOR:
1. Crie **duas contas** suas (A e B).
2. Navegue logado como A com o Proxy ligado; ache uma requisição com ID
   (`GET /api/pedidos/1043`).
3. Mande para o **Repeater**, troque o ID por um objeto da conta B.
4. Se A vê ou altera dado de B, achou. Pare aí: não baixe dados de terceiros.

### Exploração, senhas e rede (do vídeo, pouco uso em bug bounty)
- **Metasploit**: biblioteca de exploits. Programas costumam proibir ir além
  da prova mínima; útil para estudar em lab (Metasploitable, HTB).
- **Hashcat / John the Ripper**: testam combinações contra um hash.
  Estudo e pentest com autorização; quase nunca em programa público.
- **Wireshark**: lê o tráfego da rede. Ótimo para **entender** protocolos.
- **Aircrack-ng**: Wi-Fi. Só na sua própria rede.

## 4. Como escrever o report
O report é o que paga. Estrutura cobrada pela HackerOne ([Quality Reports](https://docs.hackerone.com/hackers/quality-reports.html)) e pela Intigriti ([guia](https://www.intigriti.com/hackademy/how-to-write-a-good-report)):

1. **Título específico**: "IDOR em /api/pedidos/{id} permite a qualquer
   usuário ler pedidos de outros clientes", não "IDOR no site".
2. **Resumo**: duas frases, o quê e onde.
3. **Passos para reproduzir**: numerados, o caminho mais curto, com a
   requisição HTTP crua.
4. **Impacto**: o que um atacante faz de fato (dados de quem, quantos,
   qual ação). É a seção que decide o valor ([FloQast](https://www.floqast.com/engineering-blog/how-i-learned-to-write-better-bug-bounty-reports)).
5. **Evidência**: print ou vídeo curto, usando só as suas contas.
6. **Correção sugerida** (opcional).

Antes de enviar: refaça os passos do zero só lendo o report.

## 5. Onde aprender mais
- **Labs**: [PortSwigger Academy](https://portswigger.net/web-security) (o principal), TryHackMe, Hack The Box, Juice Shop.
- **YouTube**: NahamSec (recon e lives), InsiderPhD (iniciante), STÖK (metodologia) ([Intigriti top 20](https://www.intigriti.com/blog/news/top-20-bug-bounty-youtube-channels-of-2022)).
- **Podcast**: Critical Thinking – Bug Bounty Podcast (Justin Gardner e Joel Margolis).
- **Livro**: *Real-World Bug Hunting*, Peter Yaworski (casos reais por classe).
- **Leitura de reports**: Hacktivity da HackerOne (reports públicos já pagos).
- **Bugcrowd University** e o guia de Burp da Bugcrowd ([blog](https://www.bugcrowd.com/blog/the-ultimate-beginners-guide-to-burp-suite/)).

## 6. Plano de 8 semanas (sugestão)
| Semana | Meta | Pronto quando |
|---|---|---|
| 1 | HTTP + DevTools + Burp instalado | Interceptar e alterar uma requisição sua |
| 2–3 | Academy: Access control + Authentication | 15 labs resolvidos |
| 4 | Academy: XSS + SQLi (apprentice) | 15 labs resolvidos |
| 5 | Recon: subfinder, httpx, ffuf contra Juice Shop/lab | Lista de endpoints de um lab |
| 6 | Ler 30 reports pagos de IDOR no Hacktivity | Anotar padrão de cada um |
| 7–8 | Um programa VDP/beginner, só IDOR, duas contas | Primeiro report enviado |

## Perguntas abertas
- Regras atuais de cadastro e taxa da BugHunt para pesquisadores (busca não trouxe).
- Tributação de recompensa recebida do exterior (carnê-leão): confirmar com contador.

Related: [fonte-reel-nogcyber-ferramentas-hacking](../fontes/fonte-reel-nogcyber-ferramentas-hacking.md) · [vuln-triage](../../memory/projects/vuln-triage.md) · [índice](../index.md)
