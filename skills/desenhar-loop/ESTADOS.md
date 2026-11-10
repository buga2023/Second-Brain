# Máquina de estados

Para trabalho que atravessa dias ou semanas e depende do mundo fora do
Claude (alguém testar, um cliente responder, uma métrica bater). O loop
vive num arquivo de plano no repositório; cada sessão lê o plano,
descobre em que estado está, faz o que cabe e para no próximo portão.

## O ciclo de cada sessão

1. Ler o plano e o `PROGRESSO.md`.
2. Detectar o estado atual pelas evidências (arquivos, resultados), não
   pela memória da conversa.
3. Fazer o que o estado manda.
4. Registrar no `PROGRESSO.md` o que foi feito e a evidência.
5. Conferir o portão: passou, avança um estado; não passou, entrega a
   **próxima ação** — até 3 passos, com o dado que espera de volta.
6. Parar. Um estado por sessão, salvo quando o portão passa na hora.

## Modelo de plano

```markdown
# LOOP_PLAN — <objetivo final mensurável>

Teto: <prazo ou número de sessões>. Saída de emergência: dois ciclos
sem evidência nova no mesmo estado → parar e replanejar com o usuário.

| Estado | Entra quando | Fazer | Portão (evidência que libera o próximo) | Quem confere |
|---|---|---|---|---|
| S0 | plano criado | <ação> | <arquivo, número ou resultado observável> | agente |
| S1 | portão de S0 passou | <ação> | <...> | humano: <quem> |
| S2 | ... | ... | ... | ... |
```

## Regras de um bom estado

- **Portão observável** — um arquivo que existe, um comando que sai 0,
  um número num relatório, uma resposta colada na conversa. "Está bom"
  não libera estado.
- **Quem confere** está escrito. Portão humano nomeia a pessoa e o que
  ela precisa devolver.
- **Uma responsabilidade** por estado. Estado que faz duas coisas tem
  dois portões escondidos.
- **Volta declarada** — se o portão reprovar, para qual estado o
  trabalho retorna.

Um agente por estado (em `.claude/agents/`) vale a pena quando os
estados pedem ferramentas ou contexto diferentes; com as mesmas
ferramentas, um agente só lendo o plano basta.
