---
name: desenhar-loop
description: Loop de agente — escolhe o motor (/goal, /loop, Stop hook, rotina agendada, claude -p, máquina de estados) e escreve a condição de parada com check, teto e portões humanos. Use quando o usuário quiser que o Claude trabalhe sozinho até terminar, repita algo em intervalo, ou disser "loop". Vários agentes diferentes cooperando é a skill graph-engineering.
---

# Desenhar loop

Um **loop** é um agente repetindo observar → agir → conferir até uma
**condição de parada**. O desenho inteiro está em três peças: o **check**
que prova o fim, o **motor** que dispara a próxima volta e o **teto** que
desliga o loop se ele não converge.

## 1. Nomeie o fim e o check

Escreva o estado final como uma coisa mensurável e o comando que a
prova. O check tem que estar **vermelho** agora (falha antes do trabalho)
e ficar verde só quando o trabalho de verdade estiver feito.

Confira o check contra o caso real, não só contra a suíte: "testes
passam" vale quando os testes exercitam a amostra real do usuário (o
DWG, a planilha, o template baixado). Se ainda não existe check que
pegue o caso real, construí-lo é a primeira tarefa — fora do loop.

Pronto quando: você rodou o check, ele falhou pelo motivo certo, e a
saída está na conversa.

## 2. Confira o ambiente

Liste o que cada volta precisa tocar e confirme que este ambiente
alcança: arquivos locais, rede interna (LAN, servidor da GP), navegador
ou extensão, aplicativo desktop (ZWCAD, Plant3D), credenciais. Sessão
em nuvem não vê a máquina nem a LAN do usuário; loop que depende disso
roda no Claude Code local.

Cada coisa que só uma pessoa pode fazer (testar no ZWCAD, aprovar um
texto, logar num portal) vira um **portão humano**: o loop para ali e
entrega a próxima ação em até 3 passos, com o dado que espera de volta.

Pronto quando: cada dependência está marcada como alcançável, portão
humano, ou bloqueio — e os bloqueios foram ditos ao usuário.

## 3. Escolha o motor

| O que dispara a próxima volta | Motor |
|---|---|
| A volta anterior terminou e a condição ainda não vale | `/goal` |
| Passou um intervalo (acompanhar deploy, PR, fila) | `/loop` |
| Toda sessão deste repositório, sempre | Stop hook |
| Um horário, com a máquina desligada | Rotina agendada |
| O próximo item de uma lista, em script | `claude -p` em laço |
| Uma etapa do negócio foi concluída (dias ou semanas) | Máquina de estados |

Sintaxe, limites e exemplo de cada um: [MOTORES.md](MOTORES.md).
Máquina de estados: [ESTADOS.md](ESTADOS.md).

Pronto quando: um motor está escolhido e o motivo é a linha da tabela.

## 4. Escreva o loop

Todo loop, em qualquer motor, carrega:

- **Condição de parada** — o estado final e o check do passo 1.
- **Restrições** — o que não pode mudar no caminho (arquivos, testes
  existentes, dados de produção).
- **Estado em arquivo** — um `PROGRESSO.md` (ou equivalente) lido no
  começo e atualizado no fim de cada volta: feito, tentado sem sucesso,
  próximo passo. Cada volta parte dos fatos do arquivo.
- **Teto** — limite de voltas, tempo ou custo. Bater no teto é falha a
  relatar.
- **Saída de emergência** — duas voltas seguidas sem avanço no check:
  parar e relatar o que foi tentado.
- **Portões humanos** do passo 2.

Pronto quando: as seis peças estão escritas no texto do loop.

## 5. Entregue

O bloco pronto para colar (comando, arquivo de hook ou plano de
estados), como parar o loop, e como reconhecer que ele travou. Para loop
que roda sem ninguém olhando, acrescente onde o resultado aparece e quem
aprova o que não tem volta (merge, deploy, envio).
