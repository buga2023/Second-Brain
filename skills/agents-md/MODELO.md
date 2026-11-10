# Modelo de AGENTS.md

Copie o bloco abaixo, preencha e apague as seções que ficarem vazias.

```markdown
# <nome do projeto>

<Uma frase: o que faz e para quem.>

## Comandos
- Instalar: `<comando>`
- Rodar: `<comando>`
- Testar tudo: `<comando>`
- Testar um arquivo: `<comando> <caminho>`
- Lint: `<comando>`

## Pronto significa
- `<check>` passa usando a amostra real em `<caminho>`, comparada com o
  gabarito em `<caminho>`.
- Quem confirma o resultado: <pessoa ou papel>.

## Domínio
- <Regra da disciplina que o código não deixa óbvia, com a fonte: norma,
  pessoa, documento.>
- Termos: ver `<glossário>`.

## Armadilhas
- <Padrão antigo que aparece no código e não deve ser copiado.>
- <Tipo de entrada real que já quebrou o programa.>
- <Pré-requisito de ambiente: variável, serviço, unidade de rede.>

## Entrega
1. `<testes>`
2. Commit e push em `<branch>` (<autorizado sem perguntar | pedir "sim">)
3. <Reiniciar serviço: comando, e quem avisar>
4. <Testar em <endereço da rede interna>>
5. <Atualizar: painel, kanban, nota do projeto>

## Limites
- Não alterar: `<pastas ou arquivos>`.
- Dado que fica na máquina local: <qual>.
```

## E o `CLAUDE.md` do repositório

Uma linha:

```markdown
@AGENTS.md
```

## Linhas que quase sempre valem em automação de CAD (ZWCAD, AutoLISP)

- Todo comando imprime nome e versão ao rodar (`MEUCOMANDO v5`), para saber
  qual versão produziu um resultado relatado.
- Antes de alterar uma rotina, inspecione os tipos de entidade do
  desenho real (texto, MText, bloco, cota) em que ela vai rodar.
- O agente não testa dentro do CAD: cada mudança termina com a próxima
  ação de quem testa (carregar o arquivo, rodar o comando, o que
  observar).
