---
title: Como trabalho (padrões do histórico)
date: 2026-11-10
tags: [processo, context]
---

# Como trabalho (padrões do histórico)

Leitura de 15 sessões de trabalho de engenharia (cerca de 128 mensagens
minhas), feita em 2026-11-10 para decidir quais skills criar. São
contagens aproximadas de uma amostra, não uma medição completa.

## O que eu peço

| Tipo de pedido | Aprox. | Skill que cobre agora |
|---|---|---|
| Repassar feedback de outra pessoa para corrigir (conversa colada, print) | 25 | `triar-feedback` |
| Operar e entregar (commit, push, deploy, reinício, teste na rede interna) | 15 | `fechar-sessao` + seção Entrega do `AGENTS.md` |
| Documentar e atualizar status (vault, kanban, painéis, roadmap) | 14 | `fechar-sessao` |
| Implementar ou ajustar | 12 | build com check |
| Continuação ("pode seguir", "sim") | 8 | — |
| Texto para terceiros (mensagem, apresentação) | 8 | `triar-feedback` (resposta), `apresentacao-gp` |
| Auditar ou melhorar | 6 | `raio-x` |
| Loop, agentes, plano | 6 | `desenhar-loop`, `graph-engineering` |
| Criar skill | 4 | `writing-for-agents`, `skill-creator` |

## Como eu escrevo

Curto e informal: metade das mensagens tem até 60 caracteres. Quase
nunca dou critério de pronto; dou a entrada real por referência (número
do print, nome de arquivo). Consequência registrada nas regras: o agente
propõe o critério em uma linha e eu só digo sim.

## Onde o trabalho travou

- **Correção às cegas** — rotinas de CAD refeitas da v1 à v5 porque a
  causa real só aparecia no retorno de quem testava: era bloco e não
  texto, MText com código de formatação, cota com marcador embutido.
  Três vezes o problema era só versão antiga carregada.
- **Verificação que não pega o caso real** — "todos os tipos passam" e,
  em seguida, o arquivo baixado veio errado.
- **Melhoria sem linha de base** — taxa de acerto que cai pouco porque a
  regra era específica de um projeto.
- **Ambiente** — pedido de ação no navegador ou na rede interna feito a
  uma sessão em nuvem, que não alcança nenhum dos dois; ferramenta
  ausente na máquina; unidade de rede inacessível.
- **Duas frentes no mesmo arquivo** — sessões paralelas e duas máquinas
  editando a mesma coisa.
- **Escopo corrigido depois** — "só precisa me mandar o texto".

## O que mudou por causa disso

1. Amostra real e critério de pronto antes de escrever código.
2. Todo feedback repassado passa por triagem antes de virar correção;
   a primeira pergunta é qual versão rodou.
3. Pronto é o check passando na amostra real, com a saída mostrada.
4. Antes de prometer, conferir o que o ambiente alcança.
5. Cada repositório ganha uma seção Entrega no `AGENTS.md`, para o
   fechamento deixar de ser redigido a cada sessão.

Loops e grafos apareciam só em projetos pessoais; no trabalho de
engenharia vinham das skills e do agente, nunca de um pedido meu. É a
lacuna que `desenhar-loop` e `graph-engineering` atacam.

Related: [fluxo-diario](fluxo-diario.md) ·
[inventario-skills](inventario-skills.md) · [00-Index](../../00-Index.md)
