---
fonte: Pesquisa web — ferramentas e regras de bug bounty (documentação oficial)
url: https://docs.projectdiscovery.io/tools/nuclei/running
tipo: pesquisa-web
capturado: 2026-11-10
---
# Pesquisa web: ferramentas e regras de bug bounty (documentação oficial)

Captura bruta de 2026-11-10, feita por WebSearch/WebFetch. Complementa o
guia `wiki/guias/guia-bug-bounty.md` (não repete a trilha de estudo nem a
estrutura do report). Foco: uso prático, flags conferidas na doc oficial.

Convenções desta nota:
- Cada fato traz a URL de onde veio.
- "(não verificado)" = número ou afirmação sem fonte oficial confirmada.
- Nenhuma ferramenta foi rodada nesta sessão. Os comandos saíram da doc.

---

## 1. Regras de programa

### 1.1 O que costuma ser proibido (HackerOne, Code of Conduct)
Fonte: https://www.hackerone.com/policies/code-of-conduct
- Tráfego excessivo: "Excessive traffic or request generation (e.g., DoS, DDoS)". Teste que afete disponibilidade é proibido.
- Engenharia social: "Social engineering (e.g., phishing, opening support tickets)". Abrir ticket de suporte como vetor também conta.
- Acesso a dados: proibido acessar "excessive amounts of customer internal information, dumping a database".
- Contas: proibido "gaining access to and using accounts or production credentials not approved per the program's policy".
- Automação/IA: hackbots "must not operate in a fully autonomous manner"; precisa de humano no loop. Teste assistido por IA não pode causar "out-of-scope activity, excessive traffic".
- Extorsão: proibido "attempt to obtain bounties, money or services by coercion".
- Divulgação: segue as regras de cada programa; não pode incluir informação confidencial ou pessoal de terceiros (https://hackerone.com/guidelines).

### 1.2 Bugcrowd (Standard Disclosure Terms)
Fonte: https://www.bugcrowd.com/resources/essentials/standard-disclosure-terms/
- "Actions which affect the integrity or availability of program targets are prohibited and strictly enforced."
- "If you notice performance degradation on the target systems, you must immediately suspend all use of automated tools."
- Não qualificam: DoS/DDoS de rede; achados "derived primarily from social engineering (e.g. phishing, vishing)".
- O brief do programa prevalece: "Terms specified in the program brief supersede these terms."
- Violação pode invalidar submissões e cancelar recompensas "for current and future programs".
- Duplicatas, Out of Scope e Not Applicable continuam cobertos pelos termos de sigilo: mesmo rejeitado, não divulgue (https://docs.bugcrowd.com/researchers/reporting-managing-submissions/reporting-a-bug/).
- Submeter contra alvo listado como Out of Scope: "-1 point adjustment"; repetir leva a perda de acesso (mesma URL).

### 1.3 Intigriti (Community Code of Conduct)
Fonte: https://kb.intigriti.com/en/articles/5247238-community-code-of-conduct
- Fora de escopo: "do not knowingly continue testing the out of scope vulnerable asset". Achou sem querer: reporte, sem esperar bounty.
- Domínio que não está na lista "in-scope" é fora de escopo automaticamente (https://kb.intigriti.com/en/articles/5379096-in-scope-or-out-of-scope).
- Software pirata (ex.: Burp Pro crackeado) é violação.
- Dados pessoais: use só contas próprias, não baixe, não altere, não compartilhe.
- "Do not conduct any disproportionate testing that may affect service performance." Comandos invasivos em produção: o mínimo; evite operações de escrita sem permissão.
- Scanner: "Be gentle when conducting automated tests or scanners."
- Divulgação exige aprovação da Intigriti e da empresa, por escrito.
- Prazo esperado de report em alvo vivo: cerca de 48 h após a descoberta.

### 1.4 Exemplo de programa real (GitHub)
Fonte: https://bounty.github.com/rules
- Engenharia social, phishing e ataque físico: proibidos.
- Scanner em larga escala proibido; exemplo dado pelo próprio programa: "sending 65,000 requests in two minutes using Burp Suite Intruder is excessive".
- "Do not intentionally access others' PII." Suspeita de vazamento: limite as consultas aos seus próprios dados.
- Teste de autorização: "you must use accounts you own".
- DoS só é permitido nas condições do programa (e sem limite apenas na sua própria instância do GitHub Enterprise Server).

### 1.5 Limites de taxa típicos
- Não existe padrão de plataforma. Quem define é o brief de cada programa (https://kb.intigriti.com/en/articles/5678905-understanding-rate-limiting).
- Intigriti recomenda ler o brief e cita como exemplo `-rate-limit 1` no Nuclei ou 1000 ms de delay no Intruder (mesma URL). Desrespeitar limite pode dar suspensão e reduz convites para programas privados.
- Exemplo concreto: o programa da própria Intigriti pede "max. 10 requests /sec" para ferramentas automáticas (https://app.intigriti.com/programs/intigriti/intigriti/detail).
- Os padrões das ferramentas são bem mais altos que isso: nuclei e httpx saem com 150 req/s (seção 4). Sempre passe o limite explicitamente.

### 1.6 Header de identificação
- HackerOne: o pesquisador pode mandar `X-HackerOne-Research: <usuario>` para a empresa reconhecer o tráfego (https://docs.hackerone.com/en/articles/8369822-traffic-identification).
- HackerOne também dá um e-mail de encaminhamento `<usuario>@wearehackerone.com` para criar contas de teste; não use em teste não autorizado (https://github.com/Hacker0x01/docs.hackerone.com/blob/master/docs/hackers/hacker-email-alias.md).
- Intigriti: programas pedem `X-Intigriti-Username: <usuario>` (https://app.intigriti.com/programs/intigriti/intigriti/detail).
- O header só declara quem você diz ser; qualquer um pode enviá-lo (SANS ISC, https://isc.sans.edu/diary.html?date=2025-10-30). Não dá imunidade: escopo e taxa continuam valendo.
- Na prática: todas as ferramentas da seção 4 aceitam `-H`, e no Burp dá para injetar o header por regra de match/replace.

### 1.7 Safe harbor
- Safe harbor = cláusula na política que deixa quem age de boa-fé reportar sem medo de processo; existe para conter o "chilling effect" de leis anti-hacking (https://disclose.io/).
- disclose.io classifica: - **Full Safe Harbor**: programa cumpre todos os requisitos do framework (autorização frente a leis anti-hacking como CFAA/CMA; no nível 4, também renúncia sobre DMCA/anti-evasão e exceção nos termos de uso) (https://disclose.io/framework/maturity/level-4/). - **Partial Safe Harbor**: falta algum requisito, mas há compromisso de boa-fé de não processar (https://disclose.io/framework/maturity/level-3/).
- Bugcrowd mostra ícones distintos de full/partial no brief e na página do programa (https://docs.bugcrowd.com/researchers/disclosure/disclose-io-and-safe-harbor/).
- HackerOne Gold Standard Safe Harbor (GSSH): texto padrão lançado em nov/2022; programas que adotam ganham selo e dá para filtrar por ele (https://www.hackerone.com/press-release/hackerone-announces-gold-standard-safe-harbor-improve-protections-good-faith-security). Atualizado em 2026-01-01 e estendido por um "Good Faith AI Research Safe Harbor" em jan/2026 (https://www.hackerone.com/press-release/hackerone-sets-standard-ai-era-testing-good-faith-ai-research-safe-harbor).
- Limite: a HackerOne não autoriza teste em infraestrutura de terceiros, e terceiros não ficam vinculados ao safe harbor (https://docs.hackerone.com/organizations/safe-harbor-faq.html). Ex.: o app do alvo roda num SaaS de terceiro → esse SaaS não está coberto.
- Safe harbor é de lei americana/europeia; não há fonte encontrada sobre efeito no Brasil (art. 154-A do CP continua valendo para fora de escopo).

### 1.8 Severidade
- **Bugcrowd VRT**: taxonomia com prioridade base P1 (Critical) a P5 (Informational) para tipos comuns de falha (https://bugcrowd.com/vulnerability-rating-taxonomy; escala em https://github.com/bugcrowd/vulnerability-rating-taxonomy). O dono do programa pode mudar a prioridade final. P5 vai para "Won't Fix" por padrão, salvo opt-in do programa (https://docs.bugcrowd.com/customers/submission-management/severity-overview). Uso prático: antes de reportar, procure a classe no VRT; se for P5, é provável que não pague.
- **CVSS 3.1**: nota 0–10 a partir de 8 métricas base (AV, AC, PR, UI, S, C, I, A), vetor tipo `CVSS:3.1/AV:N/AC:L/PR:H/UI:N/S:U/C:L/I:L/A:N` (https://www.first.org/cvss/v3.1/specification-document).
- **CVSS 4.0**: mesma escala 0–10 (None 0.0, Low 0.1–3.9, Medium 4.0–6.9, High 7.0–8.9, Critical 9.0–10.0), com grupos Base, Threat, Environmental e Supplemental e rótulos CVSS-B/BT/BE/BTE (https://www.first.org/cvss/v4.0/specification-document).

---

## 2. BugHunt (Brasil)

O site principal (https://www.bughunt.com.br/) não trouxe texto útil na
captura. O que achei em páginas da própria empresa:
- Cadastro gratuito de pesquisador em https://admin.bughunt.com.br/register/hacker (https://blog.bughunt.com.br/como-trabalhar-com-bug-bounty/).
- Recompensa "monetária" conforme o risco do bug para a empresa (mesma URL). O post não diz como o pagamento é feito.
- Segundo resumo de busca de páginas da BugHunt (não abri o texto integral, então trate como **não verificado**): pesquisador assina termo de adesão e política de privacidade; quem atinge certa pontuação pode ser convidado a perfil verificado com checagem de dados pessoais e bancários; valor segue grade predefinida por programa e severidade definida pelo cliente; em duplicata, só o primeiro report válido é pago; há programas públicos e privados (https://blog.bughunt.com.br/, https://bughunt.com.br/en/about.html).
- Empresa: BUG HUNT PLATAFORMA DE RECOMPENSA T I S A, CNPJ
  37.248.277/0001-48, São Paulo/SP (consulta de terceiro: https://monitorcnpj.com.br/cnpj/37248277000148/).

**Não achei**: forma de pagamento (PIX, transferência, nota fiscal),
exigência de CPF/idade mínima, prazo de pagamento, regras de conduta
completas. Conferir nos termos dentro da conta após o cadastro.

---

## 3. Burp Suite Community

### 3.1 O que a Community tem e não tem
Fonte: https://portswigger.net/burp/communitydownload
- Tem: Proxy HTTP(S)/WebSockets com histórico; Repeater, Decoder, Sequencer, Comparer; "Burp Intruder (demo)".
- Só no Pro: Intruder completo, scanner de vulnerabilidade, salvar projeto ("Project files"), busca, Burp Collaborator (OAST), crawl automático, BApps marcadas como exclusivas do Pro.
- Consequência prática: na Community o projeto é temporário. Exporte o que importa (requisições, prints) antes de fechar.

### 3.2 Ferramentas e uso
- **Proxy**: intercepta e registra o tráfego do navegador embutido (https://portswigger.net/burp/documentation/desktop/tools/proxy).
- **Target > Scope**: defina prefixos de URL (sem protocolo = HTTP e HTTPS); "Include subdomains" opcional; prefixo não aceita wildcard; para regras por host/porta/caminho, "Use advanced scope control". Clique direito numa requisição → "Add to scope" (https://portswigger.net/burp/documentation/desktop/tools/target/scope).
- **Isolar o escopo** (evita atacar host não autorizado): Settings > Proxy > Miscellaneous → "Don't send items to Proxy history or live tasks, if out of scope"; em Proxy history logging, "Stop logging out-of-scope items" (vem marcado ao adicionar host ao escopo) (https://portswigger.net/burp/documentation/desktop/tools/proxy/options).
- **Repeater**: reenvia e edita uma requisição à mão; é onde se prova IDOR e lógica de negócio (https://portswigger.net/burp/documentation/desktop/tools/repeater).
- **Intruder**: manda a mesma requisição várias vezes trocando payloads em posições marcadas (https://portswigger.net/burp/documentation/desktop/tools/intruder). Na Community é "time throttled", segundo funcionários da PortSwigger no fórum; a doc oficial não publica o limite (https://forum.portswigger.net/thread/how-throttled-is-intruder-in-the-community-edition-of-burpsuite-1dea4d42). Relato de usuário de 2017: ~1 req/s caindo para 1 a cada 15 s **(não verificado)**. Para fuzz de volume, use ffuf com `-rate`.
- **Decoder**: codifica/decodifica (URL, Base64, HTML, hex) e calcula hash (https://portswigger.net/burp/documentation/desktop/tools/decoder).
- **Comparer**: diff de duas requisições/respostas por palavra ou byte; útil para ver o que muda entre conta A e conta B (https://portswigger.net/burp/documentation/desktop/tools/comparer).

### 3.3 Instalação no Linux
- Doc oficial genérica: baixar o instalador da edição e rodar (https://portswigger.net/burp/documentation/desktop/getting-started/download-and-install). A página não detalha Linux.
- Requisitos: Linux Intel e ARM 64-bit; mínimo 2 núcleos e 4 GB RAM (recomendado 16 GB); 1 GB de disco. Existe opção JAR, mas o navegador embutido não funciona via JAR em ARM64 (https://portswigger.net/burp/documentation/desktop/getting-started/system-requirements).
- Passo comum em guias de terceiros (o instalador é um `.sh` autoextraível, nome com versão, ex. `burpsuite_community_linux_v2023_2_3.sh`):
  ```bash chmod +x burpsuite_community_linux_v*.sh ./burpsuite_community_linux_v*.sh
  ``` (https://www.linuxfordevices.com/?p=8239). Rodar sem sudo instala no home do usuário (não verificado).
- **Modo unattended `-q`**: a doc oficial só documenta `-q -varfile response.varfile` para o Burp Suite DAST/Enterprise (instalador install4j), não para o desktop Community (https://portswigger.net/burp/documentation/dast/user-guide/reference/unattended-installation). Para o Community, **não confirmado**. Forum: retirar `-c` do comando quando o wizard insiste em perguntar (https://forum.portswigger.net/thread/unattended-installation-is-not-unattended-5376ff42).

### 3.4 Extensões gratuitas
- Extensão em Python exige Jython standalone: baixar o JAR em jython.org, depois Settings > Extensions > Python Environment → selecionar o JAR; voltar ao BApp Store e atualizar a lista (https://portswigger.net/burp/documentation/desktop/extend-burp/extensions/troubleshooting).
- **Autorize** (IDOR/controle de acesso): pré-requisito "Burp Suite (Community or Professional)" + Jython (https://github.com/PortSwigger/autorize). Uso:
  1. Aba Autorize > Configuration: cole o cookie ou `Authorization` da conta de **baixo privilégio** (conta B).
  2. Ligue a interceptação ("Intercept is off" → on).
  3. Navegue como a conta de **alto privilégio** (conta A).
  4. Cada requisição é repetida com a sessão B e sem sessão. Status: "Bypassed!", "Enforced!" ou "Is enforced???" (precisa de detector).
  5. Opção "Intercept requests from Repeater" para testar requisições montadas à mão. Página BApp: https://portswigger.net/bappstore/f9bbac8c4acf4aefa4d7dc92a991af2f
- Atenção: Autorize repete **toda** requisição em escopo, duas vezes. Isso multiplica o tráfego por 3. Restrinja os filtros de interceptação ao escopo e evite endpoints que escrevem (POST/DELETE) em produção.
- Outras extensões citadas por terceiros (Logger++, Param Miner, JS Link Finder): não conferi compatibilidade com Community nesta sessão.

---

## 4. subfinder, httpx, nuclei, ffuf

### 4.1 Instalação (doc oficial)
Todas exigem Go recente; binário vai para `$HOME/go/bin` (põe no PATH).
```bash
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
go install github.com/ffuf/ffuf/v2@latest
echo 'export PATH=$PATH:$HOME/go/bin' >> ~/.bashrc
```
Fontes: https://docs.projectdiscovery.io/tools/subfinder/install,
https://docs.projectdiscovery.io/tools/httpx/install,
https://docs.projectdiscovery.io/tools/nuclei/install,
https://github.com/ffuf/ffuf (ffuf: Go ≥ 1.20; o mesmo comando atualiza).

Observação: o caminho do subfinder e do nuclei tem `/v2` e `/v3`; o do
guia (`.../<ferramenta>/cmd/<ferramenta>`) falha para esses dois.
Possível conflito de nome com o `httpx` do Python (pacote pip) se ambos
estiverem no PATH **(não verificado na doc)**: rode `httpx -version` para
conferir qual binário respondeu.

### 4.2 subfinder (passivo: consulta fontes públicas, não o alvo)
Fonte: https://docs.projectdiscovery.io/tools/subfinder/usage

| Flag | O que faz |
|---|---|
| `-d` / `-dL` | domínio / arquivo com domínios |
| `-all` | usa todas as fontes (lento) |
| `-recursive` | só fontes que aceitam subdomínio como entrada |
| `-s` / `-es` | fontes específicas / fontes excluídas (`-ls` lista) |
| `-silent` | só os subdomínios na saída |
| `-o` | arquivo de saída |
| `-oJ` / `-json` | saída JSONL |
| `-rl` | máx. requisições HTTP por segundo (às fontes) |
| `-pc` | config de chaves de API; padrão `$CONFIG/subfinder/provider-config.yaml` |

Exemplo: `subfinder -d alvo.com -all -silent -oJ -o subs.jsonl`

### 4.3 httpx (ativo: toca cada host)
Fonte: https://docs.projectdiscovery.io/tools/httpx/usage

| Flag | O que faz | Padrão |
|---|---|---|
| `-l` | lista de hosts | |
| `-sc` / `-title` / `-td` | status, título, tecnologia (Wappalyzer) | |
| `-fr` | segue redirect | |
| `-mc` / `-fc` | casa / filtra status (`-mc 200,302`) | |
| `-H` | header customizado | |
| `-rl` | máx. req/s | **150** |
| `-t` | threads | **50** |
| `-j` | saída JSONL | |
| `-o` / `-silent` | arquivo / modo silencioso | |
| `-random-agent` | User-Agent aleatório | **ligado** |

Exemplo seguro (taxa baixa + identificação):
```bash
httpx -l subs.txt -sc -title -td -rl 5 -t 5 \
  -H "X-HackerOne-Research: SEU_USUARIO" -j -o vivos.jsonl
```

### 4.4 nuclei (ativo, por templates)
Fonte: https://docs.projectdiscovery.io/tools/nuclei/running

| Flag | O que faz | Padrão |
|---|---|---|
| `-rl` | máx. req/s **global**; prevalece sobre `-c` e `-bs` | **150** |
| `-c` | templates em paralelo | 25 |
| `-bs` | hosts em paralelo por template | 25 |
| `-H` | header/cookie `nome:valor` (cli ou arquivo) | |
| `-s` / `-es` | roda / exclui por severidade (info, low, medium, high, critical, unknown) | |
| `-tags` / `-etags` | roda / exclui por tag | |
| `-itags` | força tag mesmo se excluída por padrão | |
| `-et` | exclui arquivo/pasta de template | |
| `-j` | saída JSONL no stdout | |
| `-je` / `-jle` | exporta para arquivo JSON / JSONL | |
| `-ut` | atualiza nuclei-templates | |
| `-nt` | roda só templates novos do último release | |
| `-duc` | desliga checagem automática de update | |

Templates:
- Ficam no repositório `projectdiscovery/nuclei-templates`, em YAML (https://docs.projectdiscovery.io/templates/introduction).
- Exclusão padrão vem do arquivo `.nuclei-ignore` na raiz dos templates (doc de running). Hoje ele lista as tags `dos`, `local`, `fuzz`, `bruteforce`, `txt-service` e 14 arquivos específicos (https://github.com/projectdiscovery/nuclei-templates/blob/main/.nuclei-ignore).
- **`intrusive` NÃO está no `.nuclei-ignore`**: precisa excluir à mão.
- Templates de fuzzing exigem `-fuzz`/`-dast`; headless exige `-headless` (doc de running). Sem essas flags, não rodam.

Comando conservador para programa de bug bounty:
```bash
nuclei -l vivos.txt -rl 5 -c 5 -bs 5 \
  -etags dos,intrusive,fuzz,bruteforce \
  -es info,unknown \
  -H "X-HackerOne-Research: SEU_USUARIO" \
  -jle achados.jsonl
```
Antes de rodar: confirmar que o programa permite scanner automático.

### 4.5 ffuf (ativo, fuzz)
Fonte: https://github.com/ffuf/ffuf

| Flag | O que faz | Padrão |
|---|---|---|
| `-u` | URL com a palavra `FUZZ` | |
| `-w` | wordlist, opcional `caminho:PALAVRA` | |
| `-H` | header "Nome: Valor" (aceita vários) | |
| `-X` / `-d` | método / corpo POST | |
| `-rate` | req/s | **0 = sem limite** |
| `-t` | threads | **40** |
| `-p` | delay entre requisições (`0.1` ou faixa `0.1-2.0`) | |
| `-mc` | casa status (`all` = tudo) | 200-299,301,302,307,401,403,405,500 |
| `-fc` / `-fs` / `-fw` | filtra status / tamanho / nº de palavras | |
| `-ac` | autocalibra filtros (corta falso positivo) | desligado |
| `-recursion` | recursivo (URL tem de terminar em FUZZ) | desligado |
| `-o` / `-of` | arquivo / formato: json, ejson, html, md, csv, ecsv, all | json |
| `-maxtime` | tempo máximo total em segundos | 0 |

Exemplo:
```bash
ffuf -u https://alvo.com/FUZZ \
  -w SecLists/Discovery/Web-Content/common.txt \
  -rate 10 -t 5 -ac -mc all -fc 404 \
  -H "X-HackerOne-Research: SEU_USUARIO" \
  -o ffuf.json -of json -maxtime 600
```
O padrão sem `-rate` e com 40 threads é o que mais viola limite de
programa. Sempre passe `-rate`.

### 4.6 Wordlists (SecLists)
Fonte: https://github.com/danielmiessler/SecLists
```bash
git clone --depth 1 https://github.com/danielmiessler/SecLists.git
# ou, no Kali: apt -y install seclists
```
Em `Discovery/Web-Content`
(https://github.com/danielmiessler/SecLists/tree/master/Discovery/Web-Content):
- `common.txt`, `quickhits.txt`: começo rápido, poucas requisições.
- `raft-{small,medium,large}-{directories,files,words,extensions}`.
- `DirBuster-2007_directory-list-2.3-{small,medium,big}.txt`: grandes; calcule tempo × `-rate` antes.
- `burp-parameter-names.txt`: nomes de parâmetro escondidos.
- `api/`, `common-api-endpoints-mazen160.txt`, `graphql.txt`: APIs.
- `common_pt-br.txt`: palavras em português (útil para alvo brasileiro).
Conta rápida: lista de 4.700 linhas a 10 req/s ≈ 8 minutos.

---

## 5. Classes de falha para iniciante (teste manual mínimo)

Referência: OWASP WSTG v4.2
(https://wstg.owasp.org/v4.2/4-Web_Application_Security_Testing). Labs:
PortSwigger Web Security Academy (https://portswigger.net/web-security).
Regra comum a todas: prova mínima, só com as suas contas, pare na prova.

### 5.1 IDOR / BOLA (WSTG-ATHZ-04)
https://wstg.owasp.org/v4.2/4-Web_Application_Security_Testing/05-Authorization_Testing/04-Testing_for_Insecure_Direct_Object_References
Lab: https://portswigger.net/web-security/access-control/idor
- Teste mínimo: contas A e B. Capture requisição de A com ID de objeto (path, query, corpo JSON, header). No Repeater, troque pelo ID de um objeto de B. Resposta com dado de B ou ação aplicada em B = falha.
- Teste também o método (GET → PUT/DELETE) e IDs em outros formatos (UUID vazado em outra resposta). Autorize automatiza a troca de sessão.

### 5.2 XSS refletido e armazenado (WSTG-INPV-01 / 02)
https://wstg.owasp.org/v4.2/4-Web_Application_Security_Testing/07-Input_Validation_Testing/01-Testing_for_Reflected_Cross_Site_Scripting
https://wstg.owasp.org/v4.2/4-Web_Application_Security_Testing/07-Input_Validation_Testing/02-Testing_for_Stored_Cross_Site_Scripting
Lab: https://portswigger.net/web-security/cross-site-scripting
- Teste mínimo: mande uma string única (ex. `xyz123"'<>`) em cada entrada; ache onde ela volta na resposta e em que contexto (HTML, atributo, JS). Veja quais caracteres saem sem escape. Só então monte payload para o contexto (ex. `<img src=x onerror=alert(document.domain)>`).
- Armazenado: grave no seu próprio perfil/comentário e veja onde aparece. Não deixe payload visível para outros usuários; apague depois.
- `alert(document.domain)` prova em qual origem o script rodou.

### 5.3 SQL injection básico (WSTG-INPV-05)
https://wstg.owasp.org/v4.2/4-Web_Application_Security_Testing/07-Input_Validation_Testing/05-Testing_for_SQL_Injection
Lab: https://portswigger.net/web-security/sql-injection
- Teste mínimo: `'` e `''` no parâmetro e compare erro/tamanho; depois condição booleana (`' AND '1'='1` vs `' AND '1'='2`) e compare no Comparer. Diferença consistente = indício.
- Pare ao provar (ex. versão do banco). Despejar tabela viola o CoC da HackerOne ("dumping a database", seção 1.1). sqlmap em produção costuma ser proibido ou exige taxa baixa: leia o brief.
- Time-based (`SLEEP`) pesa no servidor; o próprio `.nuclei-ignore` exclui um template time-based de SQLi.

### 5.4 SSRF (WSTG-INPV-19)
https://wstg.owasp.org/v4.2/4-Web_Application_Security_Testing/07-Input_Validation_Testing/19-Testing_for_Server-Side_Request_Forgery
Lab: https://portswigger.net/web-security/ssrf
- Onde: parâmetros que recebem URL (webhook, importar de URL, preview de link, gerar PDF de URL, avatar por URL).
- Teste mínimo: aponte para um servidor seu que registre requisições e veja se o servidor do alvo chama. Sem Collaborator na Community: use um endpoint seu.
- Prova de impacto: só o necessário (ex. acessar `127.0.0.1` ou metadata de nuvem e mostrar que respondeu). Não leia credenciais nem faça scan da rede interna sem o programa permitir.

### 5.5 Open redirect (WSTG-CLNT-04)
https://wstg.owasp.org/v4.2/4-Web_Application_Security_Testing/11-Client-side_Testing/04-Testing_for_Client-side_URL_Redirect
- Teste mínimo: parâmetros `next`, `redirect`, `url`, `returnTo`; troque por `https://exemplo.org` e veja se o navegador sai do domínio.
- Muitos programas só pagam open redirect com impacto encadeado (ex. vazamento de token OAuth). Confira a lista de exclusões do brief.

### 5.6 CSRF (WSTG-SESS-05)
https://wstg.owasp.org/v4.2/4-Web_Application_Security_Testing/06-Session_Management_Testing/05-Testing_for_Cross_Site_Request_Forgery
Lab: https://portswigger.net/web-security/csrf
- Teste mínimo: ação que muda estado (trocar e-mail, senha). Veja se tem token anti-CSRF e se ele é validado (remova, troque pelo de outra sessão, troque POST por GET). Monte HTML de PoC, abra logado com a sua conta B, confirme a mudança.
- Verifique o atributo `SameSite` do cookie: navegadores modernos aplicam `Lax` por padrão, o que bloqueia muito CSRF clássico.
- CSRF de logout e em formulário sem impacto aparecem como exclusão comum.

### 5.7 Lógica de negócio (WSTG-BUSL)
https://wstg.owasp.org/v4.2/4-Web_Application_Security_Testing/10-Business_Logic_Testing/
Lab: https://portswigger.net/web-security/logic-flaws
- Teste mínimo: mapeie o fluxo (carrinho → pagamento → confirmação). No Repeater: quantidade negativa ou fracionária, preço/ID de cupom no corpo, pular etapa (chamar a confirmação direto), reaplicar cupom, trocar ID de plano.
- Não conclua compra real com valor adulterado contra a empresa sem o programa permitir; pare quando o servidor aceitar o valor errado.

---

## 6. Programas para iniciante e status de report

### 6.1 Como achar
- Diretório da HackerOne (https://hackerone.com/directory/programs) com filtros documentados: "Offers bounties", "Managed by HackerOne" (triagem da própria HackerOne, resposta mais rápida), "High response efficiency" (cumpre metas de resposta ≥ 80% das vezes), "Offers retesting", IBB, "Active Program", além de tipo de ativo (https://docs.hackerone.com/hackers/directory.html).
- Filtro por Gold Standard Safe Harbor existe, segundo o anúncio do GSSH (seção 1.7).
- Não achei filtro oficial "beginner friendly" nem "programas novos" na HackerOne. A doc do diretório não o cita.
- VDP (programa de divulgação): o diretório documenta a política de divulgação de cada organização, com ou sem bounty (mesma URL). VDP pode não pagar; relatos em VDP não contam para "milestone points" da HackerOne (https://docs.hackerone.com/en/articles/9145220-reputation-milestone-swag). Valem como treino e reputação. Que reputação de VDP conte igual: não confirmado.
- Intigriti: reputação só sobe; duplicata de submissão válida dá 1/5 dos pontos do original (https://kb.intigriti.com/en/articles/3379630-leaderboard-reputation-and-streak).

### 6.2 Status de report (HackerOne)
Fonte: https://docs.hackerone.com/hackers/report-states.html
- **Duplicate**: "already been reported or is otherwise previously known by the customer team".
- **Informative**: "contains valid information, but ... doesn't require action". Cobre fora de escopo e risco aceito. Não afeta reputação.
- **Not Applicable (N/A)**: "doesn't contain a valid reproducible issue, and the security implications have not been demonstrated". Reduz reputação.
- **Spam**: não descreve falha legítima (ou vende produto). Penalidade maior.
- **Needs More Info**: mais de 30 dias sem resposta → fecha como informative.

Tabela de reputação (https://docs.hackerone.com/hackers/reputation.html;
perfil começa em 100, não fica negativo):

| Estado | Pontos |
|---|---|
| Triaged ou Resolved | +7 (retirado se fechar diferente de Resolved) |
| Duplicata de resolvido, enviada antes de ficar público | +2 |
| Original resolvido antes de a duplicata ser enviada | 0 |
| Informative | 0 |
| N/A fechado por você mesmo | 0 |
| Not Applicable | −5 |
| Duplicata de resolvido enviada depois de ficar público | −5 |
| Duplicata de N/A | −5 |
| Spam | −10 |

Bugcrowd: Out of Scope e Not Reproducible são estados finais inválidos;
Resolved, Unresolved e Won't Fix contam como válidos
(https://docs.bugcrowd.com/researchers/reporting-managing-submissions/understanding-substates/).
Intigriti: duplicate, accepted risk e informative são neutros; out of
scope, spam e not applicable derrubam a taxa de validade
(https://kb.intigriti.com/en/articles/5191201-handling-submissions).

### 6.3 Como evitar cada um
- **Duplicata**: leia reports divulgados do programa (Hacktivity) e o changelog; foque em funcionalidade nova ou pouco visitada; não reporte o que o nuclei acha em 5 minutos (todo mundo roda); nunca reporte falha já pública (−5).
- **Informative**: confira a lista de exclusões do brief e o VRT (P5); sem impacto concreto (header ausente, versão antiga sem exploit, clickjacking em página sem ação) tende a cair aqui.
- **N/A**: reproduza do zero antes de enviar; mostre impacto com requisição e resposta; se não conseguir provar, feche você mesmo (self close N/A = 0 em vez de −5).
- **Fora de escopo**: confira o host contra o brief antes do primeiro pacote; no Burp, escopo + descartar o que está fora (seção 3.2).

---

## 7. Tributação no Brasil (recompensa do exterior, pessoa física)

Fonte oficial encontrada:
- Carnê-leão é "o imposto sobre a renda mensal de pessoa física residente no Brasil recebida de outra pessoa física ou do exterior" (https://www.gov.br/receitafederal/pt-br/assuntos/meu-imposto-de-renda/pagamento/carne-leao).
- Vencimento: "até o último dia útil do mês subsequente ao do recebimento do rendimento" (mesma URL).
- Canal: "Meu Carnê-Leão", no portal da Receita; para rendimento anterior a 2021, programa do respectivo ano (https://www.gov.br/pt-br/servicos/apurar-carne-leao).

Não confirmado em fonte oficial nesta busca:
- Regra de conversão de moeda. Fontes de terceiros citam dólar de compra (PTAX) do último dia útil da primeira quinzena do mês anterior ao recebimento, com base na IN RFB 1.500/2014 (https://netcpa.com.br/colunas/rendimentos-no-exterior-no-irpf-2023-como-funcionam-e-como-declara-los/17890). Há matéria indicando possível mudança para 2026 sem norma publicada (https://investnews.com.br/financas/como-declarar-investimentos-no-exterior/). **Contradição entre fontes**: confirmar com contador.
- Se recompensa de bug bounty é classificada como rendimento de trabalho sem vínculo (tabela progressiva) ou outra natureza, compensação de imposto retido no exterior e código de DARF: não achei fonte da Receita.
- Recebimento via plataforma (PayPal, Payoneer, transferência) e câmbio: não pesquisado.

---

## Perguntas abertas
- Limite exato do Intruder na Community (doc oficial não publica).
- Se o instalador `.sh` do Burp Community aceita `-q` (install4j).
- Termos completos da BugHunt: pagamento, documentos exigidos, conduta.
- Natureza tributária da recompensa de bug bounty e conversão de moeda vigente em 2026.
- Se o `httpx` do ProjectDiscovery conflita com o do Python no Fedora.
