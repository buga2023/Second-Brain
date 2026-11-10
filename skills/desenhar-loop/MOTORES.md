# Motores de loop no Claude Code

Fonte: code.claude.com/docs (páginas `goal`, `scheduled-tasks`,
`hooks-guide`, `headless`, `routines`). Confira lá se um limite abaixo
parecer desatualizado.

## /goal — trabalhar até uma condição

```text
/goal <condição>
```

- Depois de cada turno, um modelo pequeno lê a conversa e decide: ainda
  não, cumprida, ou impossível. Esse avaliador **só enxerga a conversa**:
  ele não roda comando nem abre arquivo. Escreva a condição como algo
  que a saída do Claude demonstra, e peça a evidência no próprio texto.
- Uma condição que aguenta muitos turnos tem: um estado final
  mensurável, o check declarado (`pytest tests/fd sai 0`) e as
  restrições (`nenhum outro teste alterado`).
- Teto: inclua na condição (`ou pare após 20 turnos`). Limite de 4.000
  caracteres. Um goal por sessão.
- `/goal` sem argumento mostra o estado; `/goal clear` encerra.
- Para rodar sem aprovar cada comando, use em auto mode. Sem sessão
  aberta: `claude -p "/goal <condição>"`.

Modelo de condição:

```text
/goal todos os 32 tipos de FD em amostras/ geram .docx idêntico ao
gabarito em gabarito/ (python tools/comparar.py sai 0 e imprime 32/32);
nenhum arquivo em gabarito/ é alterado; registre cada tentativa em
PROGRESSO.md; ou pare após 25 turnos e relate o que falta
```

## /loop — repetir em intervalo

```text
/loop 5m <prompt>     intervalo fixo (s, m, h, d; mínimo 1 minuto)
/loop <prompt>        o Claude escolhe a espera a cada volta (1 min a 1 h)
/loop                 roda .claude/loop.md, ou o prompt de manutenção embutido
```

- Cada volta é mais um turno na mesma sessão; só dispara com a sessão
  aberta e ociosa. Expira em 7 dias.
- Parar: `Esc` no loop de espera variável; no de intervalo fixo, peça
  "cancela o loop de <nome>".
- Serve para acompanhar algo que muda sozinho (deploy, CI, fila). Para
  trabalhar até terminar, o motor é `/goal`.
- Prompt padrão do projeto: `.claude/loop.md` (texto livre, até 25 KB).

## Stop hook — regra que vale em toda sessão do repositório

`.claude/settings.json`:

```json
{
  "hooks": {
    "Stop": [
      { "hooks": [ { "type": "command", "command": "python -m pytest -q 1>&2 || exit 2" } ] }
    ]
  }
}
```

- Sair com código 2 impede o Claude de encerrar o turno; o que o comando
  escreve em stderr volta para ele como motivo.
- É o harness que executa, então vale mesmo quando o modelo "esquece".
  Depois de 8 bloqueios seguidos sem chamada de ferramenta, o Claude
  Code libera o encerramento.
- Reserve para check rápido e sem exceção (typecheck, lint, teste
  curto). Check lento em Stop hook trava toda sessão.

## Rotina agendada — roda sem sessão aberta

| | Nuvem (`/schedule`) | Desktop |
|---|---|---|
| Máquina ligada | não precisa | precisa |
| Arquivos locais / LAN | não (clone novo do repo) | sim |
| Intervalo mínimo | 1 hora | 1 minuto |

Rotina em nuvem serve para o que vive no GitHub. O que depende do
servidor interno, de unidade de rede ou de dado de contrato roda como tarefa
Desktop na máquina do usuário.

## claude -p em laço — a mesma tarefa em uma lista

PowerShell:

```powershell
Get-Content itens.txt | ForEach-Object {
  claude -p "Aplique <operação> em $_ e faça commit. Responda OK ou FALHA." `
    --allowedTools "Read,Edit,Bash(git add *),Bash(git commit *)" `
    --permission-mode dontAsk `
    --max-turns 20
}
```

- `--allowedTools` pré-aprova o necessário; `--permission-mode dontAsk`
  recusa o resto; `--max-turns` é o teto.
- Rode em 3 itens, leia o que saiu errado, ajuste o prompt e só então
  rode a lista toda.
- Quando cada item precisa de build e de conferência independente, o
  motor é um grafo: skill `graph-engineering`, modelo
  `lote-com-verificacao`.
