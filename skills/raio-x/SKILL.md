---
name: raio-x
description: Raio-x de uma aplicação — traça um caso real da entrada à saída e entrega o mapa da lógica (regras, estado, diagrama), os pontos frágeis e as melhorias priorizadas. Use quando o usuário quiser entender como um projeto funciona, pedir para ver a lógica do que construiu, ou perguntar como melhorar uma aplicação.
---

# Raio-x

O **raio-x** mostra a lógica de uma aplicação como ela é no código hoje.
Cada afirmação carrega um de três selos:

- **reproduzido** — rodei, com comando e saída;
- **lido** — está em `arquivo:linha`, não rodei;
- **não verificado** — não li nem rodei.

Arquivo de credencial (`.env`, chave, token): registre que existe e onde
é lido; o conteúdo fica fechado.

## 1. Delimite

Liste os **pontos de entrada** (comando, rota HTTP, botão, comando do
CAD, tarefa agendada) e escolha o **caso principal**: o uso mais
frequente na vida real, segundo o README, os testes ou o usuário. Se
esse caso não roda neste ambiente (precisa de rede, de aplicativo
desktop), trace-o pela leitura e rode a variante mais próxima que rodar,
dizendo qual é.

A amostra de entrada é um arquivo que a pessoa usa de verdade. Sem
amostra no repositório e sem usuário para fornecer, crie uma sintética e
marque todo achado que dependa dela como "amostra sintética".

Pronto quando: o caso principal tem ponto de entrada com `arquivo:linha`
e uma amostra com caminho e origem (real ou sintética).

## 2. Trace

Siga a amostra salto a salto, da entrada à saída: onde está, o que
recebe, o que decide, o que entrega. Rode a aplicação quando der e
guarde comando e saída. Depois do caminho principal, percorra cada
desvio que muda o resultado (erro, entrada vazia, opção alternativa).
Em repositório grande, um subagente por subsistema.

Pronto quando: o caminho principal é contínuo e cada desvio tem um selo.

## 3. Escreva o raio-x

Um arquivo `RAIO-X.md` na pasta de documentação do repositório, com
alvo de 150 linhas, nesta ordem:

1. **Resumo** — o que a aplicação faz, em 5 a 8 linhas de linguagem
   simples, e as três melhorias de maior retorno.
2. **Entradas e saídas** — o quê, formato, de onde vem, para onde vai.
3. **Fluxo** — um diagrama Mermaid `flowchart TD` com até 20 nós,
   rótulos em linguagem simples, losango só onde o caminho bifurca.
   Estilo próprio para passo de IA e para passo manual.
4. **Regras que decidem o resultado** — até 15: as que mudam a saída ou
   falham em silêncio. As demais ficam no código.

   | Regra | Onde | Quem decide | Se falhar | Tem teste? |
   |---|---|---|---|---|
   | | `arquivo:linha` | código, IA, pessoa, ou combinação | erro visível, silêncio, resultado errado | sim (qual) ou não |

5. **Estado e dependências** — onde cada dado fica guardado, e de que
   serviço, modelo, rede ou máquina a aplicação depende.
6. **Pontos frágeis** — passo 4.
7. **Melhorias** — passo 5.
8. **Não verificado** — tudo que ficou sem ler ou sem rodar, e por quê.

Pronto quando: as oito seções existem e toda linha da tabela de regras
tem `arquivo:linha`.

## 4. Cace os pontos frágeis

Procure cada tipo abaixo e registre com selo: **reproduzido**, **lido**,
ou "não encontrado — procurei em <onde>".

- **Regra sem prova real** — decisão sem teste que use a amostra real ou
  o gabarito.
- **Falha silenciosa** — erro engolido, valor padrão que mascara
  ausência, saída vazia tratada como sucesso, opção ignorada sem aviso.
- **Valor preso no código** — regex, caminho, porta, nome de projeto ou
  de cliente que muda de um uso para outro.
- **Configuração que vaza** — arquivo de ambiente ou variável de outro
  projeto que muda o comportamento sem ninguém pedir.
- **Passo manual escondido** — só funciona porque alguém faz algo fora
  do sistema.
- **Versão sem nome** — não dá para saber qual versão produziu uma saída.
- **Ponto único** — máquina, arquivo ou pessoa sem substituto.
- **Dado em dois lugares** — a mesma informação em duas fontes.
- **Entrada fora do previsto** — tipo de entrada que existe no mundo
  real e o código não trata.

Pronto quando: cada tipo tem um registro com selo.

## 5. Proponha melhorias

Uma linha por melhoria: o que muda, qual ponto frágil resolve, esforço
(P, M ou G) e **como medir** — um comando que roda ou um número que dá
para contar antes e depois. Ordem: primeiro o que hoje produz resultado
errado sem avisar; dentro de cada grupo, o menor esforço na frente. Sem
medição existente, a primeira melhoria é criar a linha de base contra o
gabarito.

Pronto quando: toda melhoria aponta um ponto frágil e tem medida
executável.

## 6. Confira com o usuário

Apague os arquivos que as execuções criaram. Entregue o Resumo e as três
coisas mais surpreendentes que o código faz, cada uma como pergunta: "o
código faz X; era isso que você esperava?". Corrija o `RAIO-X.md` com as
respostas.

Pronto quando: o usuário confirmou ou corrigiu as três, e as correções
estão no arquivo.
