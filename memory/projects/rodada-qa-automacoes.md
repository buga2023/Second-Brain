---
title: Rodada de QA das automações (23–25/11/2026)
date: 2026-11-25
tags: [projeto, automacao, qa, processo, eletrica, tubulacao]
---

# Rodada de QA das automações

**O que é:** a correção, em bloco, dos achados que o Caio levantou na QA de 23–24/11/2026 sobre
as automações do repositório `GpDevLab/gpautomacoes`. Não é uma automação: é um modo de
trabalho que se repetiu 22 vezes e que vale guardar, porque o caro não foi corrigir — foi
descobrir **o que de fato estava quebrado** e **onde o código vivo estava**.

**Pessoas:** QA Caio Fernandes (agente `agente-qa`); especialistas por disciplina (Orlando
Moura em Tubulação, Manuela Ferraz em Processo, Flaviane em HAZOP/APR, Simone Moraes em
tratamento térmico); infraestrutura e aprovação com o Wendel.

**Onde está:** [Painel de QA do NTI](painel-qa-nti.md) em `http://10.71.0.100:8960`, que é a
fonte da verdade dos achados. Código em `GpDevLab/gpautomacoes`, branch `development`.

## O que o dia produziu

**180 achados tratados**, 11 PRs mergeados e 10 abertos com CI verde (149 checks, zero falha).
Dos 152 achados do escopo original, **139 fechados** e 13 dependendo de pessoa ou de material;
da segunda leva (106 achados em 10 automações), **41 fechados**.

## As cinco lições que valem mais que as correções

### 1. A `development` nem sempre tem o código que roda

O caso mais caro do dia. A **produção (us02) roda um branch de trabalho**, não a
`development`: 62 commits que ela não tem e 88 que lhe faltam, com 51 de 80 pastas diferentes.
Duas automações estavam assim:

- a LI do E3D ([isometrico-e3d-padrao-emissao](isometrico-e3d-padrao-emissao.md)) tinha 23
  commits só em produção;
- a MC de Bombas **não existia** na `development`, só no branch do PR.

Corrigir na `development` teria sido consertar código que a produção já substituiu. **Antes de
tocar em qualquer automação deste repo:** varrer os branches remotos por commits na pasta
(`git log gp/development..<branch> -- "Projetos/<pasta>"`) e comparar com o que o servidor
roda (`cat /srv/gp/automacoes/current/.commit`).

### 2. O critério de aceite não é o texto do erro

O painel publica, por achado, a coluna **"Resultado esperado (corrigido)"** — é contra ela que
o Caio reteste, não contra a descrição do problema. Eu vinha corrigindo contra a descrição, e
sete correções não teriam passado. Os dois checklists vêm pela API:

```
/checklist-erros/<chave>.xlsx   # coluna C "Como reproduzir", coluna D "Resultado esperado"
/checklist/<chave>.xlsx         # roteiro de teste
```

### 3. Corrigir e mergear não tira o erro da fila

Detalhado em [painel-qa-marcar-resolvido](painel-qa-marcar-resolvido.md). O painel dizia "o dev
marcou como resolvido: 0 automações" com 11 PRs já mergeados. O Caio só é chamado a retestar
quando o dev marca **"✔ Resolvi"**.

### 4. Medir no programa que a pessoa usa

LibreOffice e contagem de páginas em memória enganam. Três achados só apareceram no programa
real, via `win32com`:

- **Excel** (`PageSetup.Pages.Count`): na Lista de Suportes, a revisão nova saía com 3 páginas
  e 4 logos por página em vez de 2 — o molde levava os logos de todas as páginas. Os testes
  não pegavam.
- **Word** (`Repaginate()` antes de `ComputeStatistics`): sem repaginar, a contagem vem errada
  e parece regressão onde não há.

### 5. Família de defeito se repete entre automações

Os mesmos erros aparecem em automação atrás de automação, e vale conferir todos de uma vez:

| Família | Como aparece |
|---|---|
| Número e data do Excel | `2026-11-15 00:00:00` no carimbo; `46.5` com ponto; notação científica |
| Campo apagado | sai vazio sem aviso, ou mantém o valor antigo do modelo |
| Linha errada | apagar uma linha da planilha tira a **última** do Word |
| Erro do usuário vira 500 | arquivo ruim derruba o servidor em vez de 422 |
| Formatação perdida | estilo, hiperlink, campo de legenda, equação, mescla |
| Dado de outro projeto | o modelo do servidor vaza para a MC nova |
| Impressão | a folha não cabe na página |
| Dependência faltando | só aparece no Linux do CI, nunca na máquina de quem desenvolve |
| README × código | a documentação descreve regra que o código não segue |
| Sai calado | nenhum dos anteriores avisa |

## Disciplina de teste que pegou defeito de verdade

- **Injeção obrigatória:** reverter o fonte e conferir que o teste novo **falha**. Pegou vários
  testes meus que estavam vazios.
- **Teste escrito contra o comportamento, não contra a intenção, é armadilha.** Escrevi um
  teste afirmando que um arquivo ruim devia dar 500; o certo era 422, e um PR anterior já
  tinha esse contrato. Fixei o teste no código em vez de no contrato.
- **Reproduzir pelo caminho inteiro.** Num achado, acusei o `zip` do gerador; medindo com 3, 4
  e 5 colunas nada se perdia. A causa era outra, e só apareceu fazendo o caminho real:
  baixar a planilha, acrescentar a coluna, gerar.
- **Esteira de CI é instrumento de medição.** Seis pastas nunca rodavam no CI. Ao entrarem, a
  esteira achou na primeira execução dois defeitos reais de dependência faltando — invisíveis
  em Windows porque a biblioteca vinha de carona do ambiente.

## Pendências

- Aprovar e mergear os 10 PRs abertos; depois o deploy por `REF=development` no kit
  `/srv/gp/kit/22-deploy-automacoes.sh` (tem rollback).
- 61 achados em aberto, em cinco automações (SOL-048, 076, 007, 012, 011).
- Material que falta nesta máquina: os 5 unifilares reais da Lista de Cabos e o formulário do
  resistor de aterramento. Sem eles, alguns achados não têm como ser medidos.
- Decisões de pessoa: Orlando (revisão na capa da LI; MATCODE × SPREF), Simone (revisão em
  documento reprovado), Flaviane (gerência no carimbo do HAZOP), NTI (dois apps para a mesma
  FD de motor).

Related: [painel-qa-nti](painel-qa-nti.md),
[painel-qa-marcar-resolvido](painel-qa-marcar-resolvido.md),
[isometrico-e3d-padrao-emissao](isometrico-e3d-padrao-emissao.md),
[mc-processo-vasos-trocadores-psv](mc-processo-vasos-trocadores-psv.md),
[mc-linhas-processo](mc-linhas-processo.md),
[eletrica-fd-e-rm](eletrica-fd-e-rm.md)
