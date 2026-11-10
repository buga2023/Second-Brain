---
title: "Guia: orquestrar workers no Orca (lições práticas)"
tipo: guia
tags: [guia, orca, orquestracao, workers, claude-code]
fontes: [2026-11-06-sessao-orca-orquestracao.md]
date: 2026-11-06
---
# Guia: orquestrar workers no Orca

Lições de 06/11/2026, quando 3 workers Claude escreveram a documentação da [esteira-nti](../projetos/esteira-nti.md) em paralelo.

## Caminho feliz (o que o Orca espera)
1. Abra o Claude Code **dentro de um terminal do Orca**. Só assim o coordenador tem `ORCA_TERMINAL_HANDLE` e o Orca consegue acordá-lo quando um worker termina.
2. `orca-ide skills get orchestration`: carrega o guia da versão instalada.
3. `orca-ide orchestration worker-start --spec-file spec.md --task-title "..." --worktree current --agent claude`
4. Encerre o turno. O Orca acorda o coordenador com `worker_done` ou com uma pergunta (`ask`).

## Armadilhas que pegamos
| Sintoma | Causa | Correção |
|---|---|---|
| `orca` liga o leitor de tela | no Linux, `orca` é o leitor de tela do GNOME | use `orca-ide` |
| `runtime_unavailable` | o app está fechado | `orca-ide open --json` |
| `no_active_sender_terminal` | o coordenador roda fora de um terminal do Orca | rode o Claude dentro do Orca (**nunca** use o handle de outro painel) |
| o agente sai na hora, em "No, exit" | o Orca lança o Claude em modo Bypass e o aviso nunca foi aceito | **você** decide: aceitar uma vez no Orca, ou mudar o agente padrão para não usar bypass |
| erro de JSON ao ler a resposta | a saída tem vários objetos | ler só o primeiro |

## Plano B que funcionou
```bash
orca-ide repo add --path ~/Projetos/esteira-nti
orca-ide worktree create --name nti-docs-a --repo id:<id> --no-parent      # workspace + branch própria
orca-ide terminal create --worktree path:<wt> --title worker-a --command run-a.sh
# run-a.sh:  claude -p "$(cat prompt-a.md)" --permission-mode acceptEdits \
#              --allowedTools 'Read' 'Write' 'Edit' 'Bash(git add:*)' 'Bash(git commit:*)' ...  > saida-a.log
```
- Os workers ficam **visíveis no Orca** e rodam com **permissões restritas**, sem bypass.
- O coordenador espera pelo log (`WORKER_EXIT=`) e depois faz o merge das branches.

## Como escrever um bom spec de worker
- **Brief compartilhado** no repositório (BRIEF.md): contexto, fontes, regras, divisão de arquivos.
- **Arquivos exclusivos** por worker, para não haver conflito de merge.
- **Evidência de pronto** explícita (rodar o código, validar o YAML, listar os TODOs) num `RELATORIO-x.md`.
- "Não peça confirmação; o que faltar vira TODO."

Relacionados: [guia-ferramentas-claude-code](guia-ferramentas-claude-code.md)
