---
fonte: Post colado pelo Gustavo (formato LinkedIn)
url: n/a
tipo: post
capturado: 2026-11-05
---

POR QUE LANGCHAIN E LANGGRAPH?

Conexão com os principais modelos, controle do fluxo, memória que sobrevive a falhas e pausa para aprovação humana, prontos. O time para de reconstruir encanamento e investe no que é do negócio.

🧱 O QUE É LANGCHAIN

▪ Biblioteca de código aberto para montar agentes: conecta modelo, ferramentas e instruções

▪ Aceita os principais fornecedores de modelo: troca-se o modelo sem reescrever o sistema

▪ Entrega o ciclo pronto: recebe a pergunta, escolhe a ferramenta, executa e responde

▪ Pontos de controle dentro do ciclo: aprovação humana, mascaramento de dados pessoais, resumo de histórico longo

Boas práticas:
↳ Poucas ferramentas, com descrições claras: o modelo escolhe melhor quando a escolha é simples
↳ Saída estruturada sempre que a resposta alimentar outro sistema
↳ Aprovação humana antes de qualquer ação que envie, pague ou apague

LangChain encurta o caminho até o primeiro agente útil.

🧭 O QUE É LANGGRAPH

▪ Motor de orquestração: o processo vira um mapa de etapas (nós) ligadas por caminhos (arestas)

▪ Caminhos condicionais, repetições e novas tentativas

▪ Estado durável: cada etapa é salva. Se o servidor cair, o processo retoma de onde parou

▪ Interrupção: pausa por horas ou dias à espera de decisão humana

▪ Regra fixa e julgamento do modelo no mesmo fluxo

Boas práticas:

↳ Desenhe o processo antes de programar: cada etapa faz uma coisa só

↳ Chamadas a sistemas externos em etapas próprias, com nova tentativa automática

↳ Alçadas definidas antes do código: onde o fluxo para e quem aprova

↳ Toda pausa e todo erro deixam rastro auditável

LangGraph garante que o processo termine, mesmo quando algo dá errado.

🔗 COMO SE COMPLEMENTAM
▪ O agente do LangChain roda sobre o motor do LangGraph: são camadas da mesma pilha
▪ Um agente LangChain pode ser uma etapa dentro de um fluxo LangGraph
▪ O fluxo define ordem e regras. O agente resolve a etapa que exige julgamento
▪ Comece no LangChain e desça ao LangGraph quando precisar de mais controle

O agente decide dentro do espaço que o fluxo permite.

🏭 CASOS DE USO
LangChain:
▪ Assistente de políticas de RH e compliance
▪ Busca e resumo de contratos
▪ Triagem de chamados

LangGraph:
▪ Cadastro de fornecedor com validação e aprovação
▪ Conciliação financeira com tratamento de exceções
▪ Atendimento com escalonamento para humano: a Klarna cortou 80% do tempo de resolução*

Os dois juntos:
▪ Reembolso: o fluxo garante a checagem da política e da alçada. O agente lê a nota e interpreta exceções

🎯 COMO DECIDIR
▪ Caminho previsível e risco baixo → LangChain
▪ Alçada, prazo, exceção ou registro em sistema → LangGraph
▪ Decisão que alguém assina → LangGraph com interrupção: o agente prepara, a pessoa decide

Se uma etapa não pode ser pulada, ela não pode depender da escolha do modelo.

Qual processo da sua operação já pede as duas camadas?

Vibe para explorar. Verify para escalar.

*Caso publicado pela LangChain.
