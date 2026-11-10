---
name: triar-feedback
description: Feedback repassado de terceiros — classifica cada reclamação em versão antiga, entrada fora do previsto, bug, regra nova ou mudança de escopo antes de mexer no código, e redige a resposta para quem reportou. Use quando o usuário colar conversa do Teams ou WhatsApp, mandar print de erro de outra pessoa, ou disser que alguém testou e não funcionou.
---

# Triar feedback

Feedback repassado chega misturado: várias reclamações numa mensagem, sem
dizer qual versão rodou nem com qual arquivo. A **triagem** separa e
classifica antes de qualquer correção.

## 1. Separe os itens

Uma linha por reclamação distinta, com as palavras de quem reportou
entre aspas e a evidência que veio junto (print, nome de arquivo).

Pronto quando: cada frase do feedback está em um item ou marcada como
conversa.

## 2. Classifique, do mais barato ao mais caro

Teste as classes nesta ordem e pare na primeira que a evidência
sustenta:

1. **Versão antiga** — a saída veio de uma versão anterior à correção.
   Confira o identificador de versão na saída, a data do arquivo ou o
   commit em uso. Se o programa não imprime versão, registre isso como
   primeira correção: sem versão na saída, esta dúvida volta em todo
   feedback.
2. **Entrada fora do previsto** — o arquivo real tem um tipo de dado que
   o programa nunca tratou (bloco em vez de texto, MText com código de
   formatação, célula mesclada).
3. **Bug** — caso previsto, resultado errado.
4. **Regra nova** — quem reportou está revelando uma regra da disciplina
   que não estava na especificação.
5. **Mudança de escopo** — a pessoa quer algo diferente do combinado.

Item sem evidência suficiente vira pergunta para quem reportou.

Pronto quando: cada item tem classe e a evidência que a sustenta, ou
uma pergunta redigida.

## 3. Reproduza

Consiga o arquivo real que a pessoa usou e reproduza o problema: a
reprodução é o check **vermelho**. Sem o arquivo, o próximo passo é
pedi-lo — a resposta do passo 6 sai agora, só com esse pedido.

Em CAD, inspecione os tipos de entidade do desenho real antes de mexer
no código.

Pronto quando: cada item de classe 2 ou 3 tem um check que falha pelo
motivo relatado.

## 4. Decida com o usuário

Mostre a tabela (item, classe, evidência, ação recomendada) e peça um
"sim":

| Classe | Ação recomendada |
|---|---|
| Versão antiga | Orientar a recarregar; nenhuma mudança de código |
| Entrada fora do previsto, bug | Corrigir agora |
| Regra nova | Registrar a regra (seção Domínio do `AGENTS.md` ou docs do repo) e então corrigir |
| Mudança de escopo | O usuário decide se entra; nada é implementado antes |

Pronto quando: o usuário respondeu item a item, ou aceitou a tabela.

## 5. Corrija com prova

Faça o check do passo 3 ficar verde e rode de novo todas as amostras
anteriores. Guarde o arquivo de cada caso reportado como amostra
permanente do repositório (dado de cliente ou de contrato fica na pasta
local de amostras, fora do Git).

Pronto quando: o check novo e os antigos passam, com comando e saída na
conversa.

## 6. Redija a resposta

Mensagem pronta para o usuário colar, no tom dele (curta, informal, em
português): qual era a causa, o que mudou, o que a pessoa precisa fazer
(qual versão carregar) e o que mandar se acontecer de novo (o arquivo e
a versão que aparece na saída).

Pronto quando: há uma resposta para cada pessoa que reportou, cobrindo
todos os itens dela.
