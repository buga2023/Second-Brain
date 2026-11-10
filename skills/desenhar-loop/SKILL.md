---
name: desenhar-loop
description: Loop de agente — escolhe o motor (/goal, /loop, Stop hook, rotina agendada, claude -p, máquina de estados) e escreve a condição de parada com check, teto e portões humanos. Use quando o usuário quiser que o Claude trabalhe sozinho até terminar, vigie algo em intervalo, ou disser "loop". Vários agentes diferentes cooperando é a skill graph-engineering.
---

# Desenhar loop

Um **loop** é um agente repetindo observar → agir → conferir até uma
**condição de parada**. O desenho está em três peças: o **check** que
decide cada volta, o **motor** que dispara a próxima e o **teto** que
desliga o loop se ele não converge.

## 1. Nomeie o fim e o check

Identifique qual dos três tipos de loop é este; o check muda em cada um:

| Tipo | O check | Estado agora |
|---|---|---|
| **Trabalho** até ficar pronto | Comando que prova o estado final | **Vermelho**: falha antes do trabalho |
| **Vigia** de algo que muda sozinho | Comando que diz se está saudável, mais a definição de "caiu" (quantas falhas seguidas) | Verde; o loop reage ao vermelho |
| **Conferência humana** | O que a pessoa devolve (tabela, print, "aprovado") | Sem comando: cada conferência é um portão |

Medida indefinida ("95% de quê?", "ficar bom" segundo quem?) é decisão
do usuário: pergunte, com uma resposta recomendada.

O check precisa exercitar o caso real: a amostra que a pessoa usa (o
desenho, a planilha, o template baixado), comparada com o gabarito. Se
esse check ainda não existe, ele é o primeiro item da entrega — construa
agora se o usuário pediu execução; senão, liste como pré-requisito no
topo do bloco.

Pronto quando: o tipo está nomeado e o check foi rodado com a saída na
conversa — ou, sem acesso para rodar, o comando exato e a suposição
estão escritos.

## 2. Confira o ambiente onde o loop vai rodar

Vale o ambiente de execução, que pode ser outro que este. Confirme cada
dependência:

- Alcance: arquivos locais, rede interna, navegador, aplicativo desktop
  (CAD), credenciais. Sessão em nuvem não vê a máquina nem a rede
  interna do usuário.
- Fôlego: sessão aberta, máquina acordada, permissões (auto mode ou
  ferramentas pré-aprovadas) — é o que sustenta o "volto depois".
- Aviso: por onde o usuário fica sabendo do resultado.

Cada coisa que só uma pessoa faz (testar no CAD, aprovar um texto, logar
num portal) é um **portão humano**.

Pronto quando: cada dependência está marcada alcançável, portão humano
ou bloqueio, e os bloqueios foram ditos ao usuário.

## 3. Escolha o motor

Responda em ordem e pare no primeiro sim:

1. Quem confere é uma pessoa, e a resposta leva horas ou dias?
   → **Máquina de estados** ([ESTADOS.md](ESTADOS.md)).
2. É só um comando repetido, sem decisão no meio (um health check)?
   → **Agendador do sistema**, sem Claude; o loop não precisa de modelo.
3. Precisa rodar sem sessão aberta? → **Tarefa agendada**: Desktop se
   depende de arquivo local ou rede interna, nuvem se vive no GitHub.
4. É a mesma operação em uma lista de itens? → **`claude -p` em laço**.
5. É trabalho até uma condição? → **`/goal`**.
6. É vigia em intervalo, por até 7 dias? → **`/loop`**.
7. É regra que vale em toda sessão do repositório? → **Stop hook**.

Motores se compõem: um estado da máquina pode ser um `/goal`. Sintaxe,
limites e armadilhas de cada um: [MOTORES.md](MOTORES.md).

## 4. Escreva o loop

- **Condição de parada** e **restrições** (o que não pode mudar no
  caminho), com o check do passo 1.
- **Estado em arquivo** — um `PROGRESSO.md` lido no começo e atualizado
  no fim de cada volta: feito, tentado sem sucesso, medida atual,
  próximo passo.
- **Teto** — o dobro das voltas que você estima; sem estimativa, 20.
- **Saída de emergência** — em loop de trabalho, duas voltas sem a
  medida melhorar; em vigia, o check deixar de rodar. Parar e relatar.
- **Portões humanos como cláusula de parada** — em `/goal` e `/loop` o
  avaliador dispara outra volta se a condição não vale; escreva "ou pare
  e relate quando precisar de <pessoa>: <o que ela devolve>".

Pronto quando: as cinco peças estão no texto do loop.

## 5. Entregue

1. **Falta preencher** — no topo, cada dado que só o usuário tem (URL,
   lista de arquivos, nome de quem testa, definição da medida).
2. O bloco para colar: comando, arquivo de hook ou plano de estados.
3. Como parar, e como reconhecer que travou.
4. Onde o resultado aparece e quem aprova o que não tem volta (merge,
   deploy, envio).

Pronto quando: o bloco não tem lacuna fora da lista "Falta preencher".
