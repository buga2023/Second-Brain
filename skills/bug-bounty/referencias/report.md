# Fase 4 — Report (o que paga)

O report é o produto. Triador que não reproduz, não paga. Estrutura cobrada
pela HackerOne (docs.hackerone.com/hackers/quality-reports.html) e pela
Intigriti (intigriti.com/hackademy/how-to-write-a-good-report).

## Modelo

```markdown
# Título
<classe> em <endpoint> permite <quem> <fazer o quê>
Ex.: IDOR em GET /rest/basket/{id} permite a qualquer usuário ler a cesta de outro

## Resumo
Duas frases: o quê e onde.

## Passos para reproduzir
1. Numerados, caminho mais curto, só com contas minhas (A e B).
2. Inclua a requisição HTTP crua (método, URL, headers, corpo).
3. ...

## Impacto
O que um atacante faz de fato: dado de quem, quantos registros, qual ação.
É a seção que decide o valor. Sem "isso é perigoso" — diga o efeito concreto.

## Evidência
Print ou vídeo curto, só com minhas contas. A requisição e a resposta.

## Correção sugerida (opcional)
Ex.: validar no servidor que o objeto pertence ao usuário da sessão.
```

## Regras do report

- **Título específico**: "IDOR em /rest/basket/{id}...", nunca "IDOR no site".
- **Impacto é a seção mais importante** — o que dá para fazer, não o rótulo.
  (https://www.floqast.com/engineering-blog/how-i-learned-to-write-better-bug-bounty-reports)
- **Passos reproduzíveis sozinhos**: antes de enviar, refaça só lendo o
  report. Se você não reproduz, o triador também não.
- **Uma falha por report.** Não junte achados.
- **Evidência só com suas contas.** Nada de dado real de terceiro.

## Checklist antes de enviar

- [ ] O alvo estava `in:` no escopo (confirme no `escopo.py`).
- [ ] Título diz classe + endpoint + impacto.
- [ ] Passos numerados reproduzem do zero.
- [ ] Impacto é concreto (quem, quanto, qual ação).
- [ ] Evidência anexada, só com suas contas.
- [ ] Não é duplicata óbvia (busquei no Hacktivity/changelog).
- [ ] Parei na prova mínima; não extraí dado de terceiro.
