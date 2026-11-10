---
title: Skill vuln-triage
date: 2026-11-10
tags: [projeto, skill, seguranca]
---

# vuln-triage

Skill do usuário (`anthropic-skills:vuln-triage`, pacote
`vuln-triage-v1.zip`). Faz a triagem e a correção de vulnerabilidades
apontadas por scanners (Aikido, Snyk, Dependabot, GitHub Security, Trivy,
Grype).

- Princípio central: **o exploit não é o produto**. Ela confirma se o
  código vulnerável é alcançável e corrige, sem escrever exploit.
- Workflow de quatro passos; referências por família de CVE, stack Java,
  outras stacks e verificações de pentest não destrutivas.

## Related

- [memory/projects](README.md)
