---
fonte: Experiência prática nesta sessão (Claude Code + Orca IDE, Fedora 44)
url: n/a
tipo: experiencia
capturado: 2026-11-06
---

Fatos observados ao usar o Orca para orquestrar 3 workers Claude que documentaram a Esteira NTI:

1. No Linux, fora de um terminal do Orca, o binário certo é `orca-ide`. O `orca` sozinho aponta para o leitor de tela do GNOME (/usr/bin/orca).
2. O guia versionado sai de `orca-ide skills get orchestration`.
3. Com o app fechado, todo comando devolve `runtime_unavailable`. `orca-ide open --json` sobe o runtime.
4. `orca-ide orchestration worker-start` falhou com `no_active_sender_terminal`: o coordenador precisa estar DENTRO de um terminal do Orca (ORCA_TERMINAL_HANDLE) ou passar `--from <handle próprio>`. Usar o handle de outro painel é proibido, porque mexe na caixa de mensagens dele.
5. `orca-ide repo add --path <dir>` registra um repositório git; `worktree create --name X --repo id:<id> --no-parent --agent claude --prompt "..."` cria o worktree em ~/orca/workspaces/<repo>/<nome>, numa branch própria.
6. A configuração do Orca lançou o Claude com `--dangerously-skip-permissions`. A tela de aceite do modo Bypass nunca tinha sido confirmada e a opção padrão é "No, exit": o agente saiu sem rodar, e o Orca fechou os terminais pouco depois. O aceite do modo bypass é decisão do usuário e não foi feito pelo coordenador.
7. O que funcionou: `orca-ide terminal create --worktree path:<wt> --title worker-x --command <script>`, em que o script roda `claude -p "$(cat prompt)" --permission-mode acceptEdits --allowedTools <lista restrita>` e grava a saída num log + WORKER_EXIT. O coordenador acompanhou pelos arquivos, sem consultar o correio do Orca.
8. A saída `--json` de alguns comandos traz mais de um objeto JSON (linhas extras): ler só o primeiro objeto.
9. Os workers rodaram em worktrees separados (branches nti-docs-a/b/c) e o coordenador integrou depois com merge.
