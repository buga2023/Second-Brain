---
name: fechar-sessao
description: Fecha uma entrega — roda o checklist de entrega do repositório, explica o que foi construído e registra projeto, decisões e termos no Second-Brain. Use quando o usuário disser que terminou, pedir para documentar o que foi feito, ou ao concluir um build relevante.
---

# Fechar sessão

## 1. Levante o que mudou

Junte `git status`, `git diff` e `git log` desde o começo do trabalho com
o que foi decidido na conversa.

Pronto quando: há uma lista de mudanças, cada uma com seus arquivos.

## 2. Rode a entrega do repositório

Siga a seção **Entrega** do `AGENTS.md` do repositório, passo a passo
(testes, commit, push, reinício de serviço, teste na rede interna,
atualização de painéis). Para cada passo:

- Este ambiente alcança: execute e guarde a evidência.
- Compartilha ou não tem volta (push, deploy, reinício de servidor em
  uso): execute se o `AGENTS.md` autoriza; senão, peça um "sim".
- Fora do alcance (rede interna, aplicativo desktop, sistema com login):
  escreva como **próxima ação** do usuário, em até 3 passos, com o
  resultado esperado.

Repositório sem seção Entrega: rode os testes que existirem e ofereça a
skill `agents-md` para criar a seção.

Pronto quando: cada passo está marcado como feito (com evidência),
próxima ação do usuário, ou não se aplica.

## 3. Explique

Em 5 a 8 linhas de linguagem simples: o que foi construído, como
conferir que funciona, o que ficou de fora. Se a lógica da aplicação
mudou de forma que o usuário precisa entender, ofereça a skill `raio-x`.

Pronto quando: a explicação foi entregue na conversa.

## 4. Registre no vault

O caminho do vault está nas instruções globais (Second-Brain). Leia
`00-Index.md` e atualize:

- **Projeto** — `memory/projects/<projeto>.md`: o que é, estado atual,
  como rodar e conferir, pendências, quem está envolvido.
- **Decisão** — `memory/context/<assunto>.md`, com o motivo.
- **Pessoa** nova — `memory/people/`, nome e papel.
- **Termo** novo — `memory/glossary.md`.
- **Log** — uma entrada `## [AAAA-MM-DD] operação | título` em `log.md` (formato no `CLAUDE.md`).

Toda nota nova entra no índice da pasta. No vault entram lógica,
decisões e nomes de sistemas; conteúdo de documento de cliente ou de
contrato fica na máquina local.

Pronto quando: o projeto tem nota atualizada e o `log.md` tem a linha de
hoje.

## 5. Publique o vault

Rode o lint do vault (skill `obsidian-notes`, se instalada), faça commit
e push. Na primeira vez da sessão, confirme o push com o usuário.

Pronto quando: lint sem erros e o hash do commit foi informado.
