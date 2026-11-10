# Motores de loop no Claude Code

Fonte: code.claude.com/docs (páginas `goal`, `scheduled-tasks`,
`hooks-guide`, `headless`, `routines`, `desktop-scheduled-tasks`).
Confira lá se um limite abaixo parecer desatualizado.

## /goal — trabalhar até uma condição

```text
/goal <condição>
```

- Depois de cada turno, um modelo pequeno lê a conversa e decide: ainda
  não, cumprida, ou impossível. Esse avaliador **só enxerga a conversa**:
  não roda comando nem abre arquivo. Escreva a condição como algo que a
  saída do Claude demonstra, e peça a evidência no próprio texto.
- Uma condição que aguenta muitos turnos tem um estado final mensurável,
  o check declarado e as restrições.
- Teto e portões entram na condição como cláusula "ou pare e relate".
  Limite de 4.000 caracteres. Um goal por sessão.
- `/goal` sem argumento mostra o estado; `/goal clear` encerra.
- Sem aprovar cada comando: rode em auto mode, com o terminal aberto.
- Erro de crédito, de autenticação ou de contexto estourado limpa o
  goal; rode `/goal` de novo depois de resolver.
- Sem sessão: `claude -p "/goal <condição>"`. A saída só aparece no fim;
  para acompanhar, `--output-format stream-json --verbose`.

Modelo:

```text
/goal python tools/avaliar.py amostras/ gabarito/ sai 0 com acerto >= 95%
e python -m pytest -q sai 0, saídas coladas no turno. Restrições: git
diff --stat em amostras/, gabarito/ e tools/avaliar.py vazio (mostre);
sem regra por nome de arquivo. Cada turno: ler PROGRESSO.md, uma
mudança, medir, registrar antes e depois. Ou pare e relate: 25 turnos;
2 turnos sem a medida subir; suspeita de erro no gabarito (liste o caso,
não corrija)
```

## /loop — vigiar em intervalo

```text
/loop 5m <prompt>     intervalo fixo (s, m, h, d; mínimo 1 minuto)
/loop <prompt>        o Claude escolhe a espera a cada volta (1 min a 1 h)
/loop                 roda .claude/loop.md, ou o prompt de manutenção embutido
```

- Cada volta é mais um turno na mesma sessão; só dispara com a sessão
  aberta e ociosa. Expira em 7 dias.
- A volta pode atrasar até metade do intervalo (no máximo 30 min); a de
  5 minutos não atrasa.
- Parar: `Esc` no loop de espera variável; no de intervalo fixo, peça
  "cancela o loop de <nome>".
- O loop de espera variável não volta sozinho depois de `--resume`.

Modelo:

```text
/loop 5m Rode <check> e anote hora, resultado e falhas seguidas em
MONITOR.md. Saudável: uma linha. 2 falhas seguidas: escreva "CAIU <hora>
<erro>" e cancele este loop. Não altere nada no serviço. Cancele e
relate após 96 voltas, ou se o check não puder rodar 2 voltas seguidas
```

## Agendador do sistema — comando repetido, sem modelo

Quando a volta é só um comando e uma comparação (um health check), o
Agendador de Tarefas do Windows ou o cron rodam um script que grava o
resultado e avisa. Custa zero tokens e não depende de sessão aberta.

## Tarefa agendada — Claude sem sessão aberta

| | Nuvem (`/schedule`) | Desktop (app do Claude) |
|---|---|---|
| Precisa de | nada ligado | app aberto e computador acordado |
| Arquivos locais / rede interna | não (clone novo do repo) | sim |
| Intervalo mínimo | 1 hora | 1 hora no formulário; 1 minuto pedindo ao Claude |

Nuvem serve para o que vive no GitHub. O que depende do servidor
interno, de unidade de rede ou de dado de contrato roda como tarefa
Desktop na máquina do usuário.

## claude -p em laço — a mesma operação em uma lista

PowerShell:

```powershell
$falhas = 0
foreach ($item in Get-Content itens.txt) {
  $r = claude -p "Aplique <operação> em $item e faça commit. Responda só OK ou FALHA: <motivo>." `
    --allowedTools "Read,Edit,Bash(git add *),Bash(git commit *)" `
    --permission-mode dontAsk --max-turns 20
  "$item`t$r" | Add-Content resultado.tsv
  if ($r -notmatch '^OK') { $falhas++ }
  if ($falhas -ge 3) { Write-Host "3 falhas: parando"; break }
}
```

- `--allowedTools` pré-aprova o necessário; `--permission-mode dontAsk`
  recusa o resto; `--max-turns` é o teto de cada item.
- Rode em 3 itens, leia `resultado.tsv`, ajuste o prompt e só então rode
  a lista toda.
- Quando cada item pede build e conferência independente, o motor é um
  grafo: skill `graph-engineering`, modelo `lote-com-verificacao`.

## Stop hook — regra que vale em toda sessão do repositório

`.claude/settings.json`:

```json
{
  "hooks": {
    "Stop": [
      { "hooks": [ { "type": "command", "command": "python tools/stop_check.py" } ] }
    ]
  }
}
```

`tools/stop_check.py`:

```python
import subprocess, sys

r = subprocess.run([sys.executable, "-m", "pytest", "-q", "-x"],
                   capture_output=True, text=True)
if r.returncode in (0, 5):  # 5: nenhum teste coletado
    sys.exit(0)
sys.stderr.write(r.stdout[-3000:] + r.stderr[-1000:])
sys.exit(2)
```

- Sair com código 2 impede o Claude de encerrar o turno; o que vai para
  stderr volta para ele como motivo. É o harness que executa.
- O limite de 8 bloqueios só conta bloqueios sem chamada de ferramenta
  entre eles: um check que o Claude não consegue fazer passar prende a
  sessão. Use para check rápido que depende só do código (typecheck,
  lint, teste curto).
- Script em Python roda igual no Windows e no Linux; comando com sintaxe
  de shell (`||`, `1>&2`) depende do Git Bash no Windows.
