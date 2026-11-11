---
title: Projeto bug bounty
date: 2026-11-10
tags: [projeto, skill, seguranca, bug-bounty]
---

# bug-bounty

**O que é.** Aprender bug bounty para gerar renda e ter uma skill do Claude
Code que conduz o trabalho com trava de escopo: escopo → recon → teste
manual → prova mínima → report.

**Onde está.**
- Skill: [skills/bug-bounty](../../skills/bug-bounty/SKILL.md) (instala com
  `bash claude-config/install.sh --skills-only`).
- Estudo: [guia-bug-bounty](../../wiki/guias/guia-bug-bounty.md).
- Lab: OWASP Juice Shop em podman, `127.0.0.1:3000`.

**Como rodar o lab.**
```bash
podman start juice-shop || podman run -d --name juice-shop -p 127.0.0.1:3000:3000 docker.io/bkimminich/juice-shop:latest
```

**Critério de pronto (aprovado 2026-11-10).** Skill instalada, ferramentas
instaladas no Fedora e a skill achando 1 IDOR real no Juice Shop com report
gerado, comando e saída mostrados.

**Decisões (2026-11-10).**
1. Uma skill `bug-bounty` com referências por fase, não três skills.
2. Ferramentas: subfinder, httpx, nuclei, ffuf (binários oficiais em
   `~/.local/bin`), Burp Suite Community, Juice Shop. nmap via
   `sudo dnf install nmap` (o Gustavo roda: sudo pede senha).
3. Trava de escopo obrigatória: nenhum comando contra alvo fora de
   `escopo.txt`.
4. Metasploit, Hashcat, Aircrack-ng e Wireshark ficam fora da skill por
   agora (pouco uso em bug bounty web).

## Related
- [memory/projects](README.md) · [guia-bug-bounty](../../wiki/guias/guia-bug-bounty.md)
