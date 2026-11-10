---
name: agents-md
description: AGENTS.md de um repositório — lê o repo, pergunta só o que o código não conta e escreve um AGENTS.md enxuto mais um CLAUDE.md que o importa. Use ao começar a trabalhar num repositório sem AGENTS.md, ou quando o usuário pedir para criar ou revisar o arquivo de instruções do projeto.
---

# AGENTS.md

O `AGENTS.md` guarda o que um agente não descobre lendo o repositório.
Cada linha passa no teste: "o agente erraria sem isto?".

## 1. Leia o repositório

Levante os comandos (instalar, rodar, testar tudo, testar um arquivo,
lint), os pontos de entrada, onde ficam amostras e gabaritos, e os
arquivos de instrução que já existem (`CLAUDE.md`, `AGENTS.md`,
`.cursorrules`, `README`).

Pronto quando: cada comando candidato tem a fonte (`package.json`,
`pyproject.toml`, script, README).

## 2. Rode cada comando

Só entra no arquivo comando que rodou aqui. O que falhou vira candidato
a armadilha, com a mensagem de erro.

Pronto quando: cada comando está marcado "rodou" (com código de saída)
ou "falhou".

## 3. Pergunte o que o código não conta

Uma rodada de `grilling`, com resposta recomendada em cada pergunta:

- Quem confirma que o resultado está certo, e contra qual gabarito?
- Onde está a amostra real de entrada?
- Quais passos fecham uma entrega (reinício, teste na rede interna,
  painéis a atualizar), e quais o agente pode fazer sem perguntar?
- O que o agente não deve tocar (pastas, dados, serviços em uso)?
- Que dado não pode sair da máquina?
- Que erro já custou retrabalho neste projeto?

Pronto quando: cada pergunta tem resposta ou "não se aplica".

## 4. Escreva

Preencha [MODELO.md](MODELO.md). Seções vazias saem do arquivo. Alvo:
até 80 linhas. Regra que vale só para parte do código vai para
`.claude/rules/<tema>.md` com `paths:` no frontmatter.

Havendo um `CLAUDE.md` com conteúdo, mova para o `AGENTS.md` o que passa
no teste e mostre ao usuário o que ficou de fora antes de apagar.

Pronto quando: toda linha do arquivo veio do passo 2 ou do passo 3.

## 5. Ligue ao Claude Code

Deixe na raiz um `CLAUDE.md` cuja única linha é `@AGENTS.md`. Assim o
arquivo carrega em qualquer versão do Claude Code e continua sendo lido
por Codex, Cursor e Copilot.

Pronto quando: `CLAUDE.md` existe e contém o import.

## 6. Prove

Despache um subagente de contexto novo com a tarefa: "usando só o que
este repositório te diz, rode os testes e explique como você provaria
que uma mudança está pronta". Ele precisa conseguir sem perguntar nada.
O que ele errar ou perguntar é linha que falta ou linha confusa.

Pronto quando: o subagente rodou o comando de teste certo e descreveu o
critério de pronto do arquivo.
