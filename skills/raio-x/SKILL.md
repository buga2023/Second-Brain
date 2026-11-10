---
name: raio-x
description: Raio-x de uma aplicação — traça um caso real da entrada à saída e entrega o mapa da lógica (entradas, regras, estado, saídas, diagrama), os pontos frágeis e as melhorias priorizadas. Use quando o usuário quiser entender como um projeto funciona, pedir para ver a lógica do que construiu, ou perguntar como melhorar uma aplicação.
---

# Raio-x

O **raio-x** mostra a lógica de uma aplicação como ela é no código hoje,
com evidência em cada afirmação (`arquivo:linha`, ou comando e saída). O
que não foi lido nem rodado aparece escrito como "não verificado".

## 1. Delimite

Encontre os **pontos de entrada** (comando de terminal, rota HTTP, botão,
comando do CAD, tarefa agendada) e escolha o **caso principal**: uma
amostra real de entrada que a pessoa usa de verdade (o DWG, a planilha, o
PDF). Procure a amostra no repositório (`amostras/`, `tests/`, `demo/`);
se não houver, peça uma ao usuário.

Pronto quando: o ponto de entrada tem `arquivo:linha` e a amostra tem
caminho.

## 2. Trace o caso principal

Siga a amostra salto a salto, da entrada até a saída. Em cada salto
anote: onde está, o que recebe, o que decide, o que entrega ao próximo.
Se a aplicação roda neste ambiente, rode-a com a amostra e guarde a
saída; senão, trace pela leitura. Em repositório grande, despache um
subagente por subsistema e junte os trechos.

Pronto quando: o caminho é contínuo da entrada à saída, e cada lacuna
está marcada "não verificado".

## 3. Monte o raio-x

Escreva `docs/RAIO-X.md` (ou a pasta de docs que o repositório já usa)
com estas seções, nesta ordem:

1. **Para que serve** — uma frase, e quem usa o resultado.
2. **Entradas** — o quê, formato, de onde vem.
3. **Regras** — uma linha por decisão que o código toma:

   | Regra | Onde | Quem decide | Se falhar |
   |---|---|---|---|
   | | `arquivo:linha` | código fixo, IA, ou pessoa | erro visível, silêncio, ou resultado errado |

4. **Estado** — onde cada dado fica guardado (arquivo, banco, planilha,
   memória) e quem mais lê ou escreve ali.
5. **Saídas** — o quê, formato, para onde vai.
6. **Dependências** — serviços, modelos, rede, aplicativos, máquinas.
7. **Fluxo** — diagrama Mermaid `flowchart TD`, rótulos em linguagem
   simples, losango para cada regra, até uns 20 nós (maior que isso: um
   diagrama geral e um por subsistema). Marque os passos de IA e os
   passos manuais com estilo próprio.
8. **Pontos frágeis** — passo 4.
9. **Melhorias** — passo 5.

Pronto quando: toda linha da tabela de regras tem `arquivo:linha` e o
diagrama mostra os mesmos saltos do passo 2.

## 4. Cace os pontos frágeis

Procure cada um destes, com evidência:

- **Regra sem prova real** — decisão sem teste que use a amostra real
  ou o gabarito.
- **Falha silenciosa** — erro engolido, valor padrão que mascara
  ausência, saída vazia tratada como sucesso.
- **Valor preso no código** — regex, caminho, porta, nome de projeto ou
  de cliente que muda de um uso para outro.
- **Passo manual escondido** — algo que só funciona porque alguém faz
  uma coisa fora do sistema.
- **Versão sem nome** — não dá para saber qual versão produziu uma
  saída (o programa não imprime versão nem data).
- **Ponto único** — uma máquina, um arquivo ou uma pessoa sem substituto.
- **Dado em dois lugares** — a mesma informação mantida em duas fontes.
- **Entrada fora do previsto** — tipo de entrada que existe no mundo
  real e o código não trata (bloco em vez de texto, célula mesclada,
  campo vazio).

Pronto quando: cada item da lista foi procurado e está como "encontrado
em `arquivo:linha`" ou "não encontrado".

## 5. Proponha melhorias

Uma linha por melhoria: o que muda, qual ponto frágil resolve, esforço
(P, M ou G) e **como medir** — o check ou a taxa antes e depois contra o
gabarito real. Ordene por ganho dividido por esforço e destaque as três
primeiras. Quando ainda não há medição, a primeira melhoria é criar a
linha de base.

Pronto quando: toda melhoria aponta um ponto frágil e tem como medir.

## 6. Confira com o usuário

Entregue em linguagem simples, em 5 a 8 linhas, o que a aplicação faz, e
as três coisas mais surpreendentes que o código faz, cada uma como
pergunta: "o código faz X; era isso que você esperava?". Corrija o
`RAIO-X.md` com as respostas.

Pronto quando: o usuário confirmou ou corrigiu as três, e as correções
estão no arquivo.
