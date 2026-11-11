---
title: Reel nogCYBER — ferramentas de hacking por fase
tipo: fonte
tags: [seguranca, pentest, bug-bounty, video]
fontes: [2026-11-10-reel-nogcyber-ferramentas-hacking.md]
date: 2026-11-10
---
# Reel nogCYBER: ferramentas de hacking por fase

Reel de 1min52 do perfil nogCYBER que apresenta 13 ferramentas na ordem de
um teste de invasão. Fonte bruta:
[raw](../../raw/2026-11-10-reel-nogcyber-ferramentas-hacking.md).

| Fase | Ferramentas citadas | Serve para bug bounty web? |
|---|---|---|
| Reconhecimento (OSINT) | Maltego, theHarvester, Shodan | Sim, com limite: e-mail de funcionário quase sempre fica fora do escopo |
| Varredura | Nmap, Nessus, OpenVAS | Nmap sim; Nessus/OpenVAS achados genéricos de versão costumam ser recusados |
| Web | Burp Suite | **A principal ferramenta do caçador** |
| Exploração | Metasploit | Pouco: programas proíbem exploração além da prova mínima |
| Senhas | Hashcat, John the Ripper | Quase nunca; quebra de senha costuma ser proibida |
| Rede | Wireshark, Aircrack-ng | Não em bug bounty (é pentest interno/físico) |

## Leitura
- O vídeo descreve **pentest** (contrato com uma empresa). Bug bounty é o
  caminho para ganhar por falha achada sem contrato, e usa um subconjunto
  dessas ferramentas mais as de recon web. Ver
  [guia-bug-bounty](../guias/guia-bug-bounty.md).
- Ponto do vídeo que vale guardar: a diferença entre profissional e
  criminoso é a **autorização**.

Related: [guia-bug-bounty](../guias/guia-bug-bounty.md) · [raw](../../raw/README.md)
