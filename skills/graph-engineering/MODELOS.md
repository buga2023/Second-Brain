# Modelos de script (Workflow tool)

Quatro grafos prontos para adaptar. São JavaScript puro; `args` chega do
campo `args` da chamada do Workflow. A API completa está na skill
`workflow-authoring`.

## builder-critico (avaliador-otimizador)

`args`: `{ tarefa, barra, teto }`

```js
export const meta = {
  name: 'builder-critico',
  description: 'Constrói, critica com contexto novo e repete até passar na barra',
  phases: [{ title: 'Build' }, { title: 'Critica' }],
}
const { tarefa, barra } = args
const teto = args.teto || 4
const VEREDITO = {
  type: 'object',
  properties: {
    passa: { type: 'boolean' },
    falhas: { type: 'array', items: { type: 'string' } },
  },
  required: ['passa', 'falhas'],
}
let falhas = []
for (let rodada = 1; rodada <= teto; rodada++) {
  const correcao = falhas.length
    ? '\nCorrija estas falhas apontadas pela crítica:\n- ' + falhas.join('\n- ')
    : ''
  await agent(tarefa + correcao, { phase: 'Build', label: 'build ' + rodada })
  const v = await agent(
    'Você não viu como isto foi construído. Compare o resultado no ' +
      'repositório contra a barra: ' + barra + '. Rode os checks você ' +
      'mesmo. passa=true só se tudo da barra se sustenta; liste cada ' +
      'falha com a evidência (comando e saída, ou arquivo:linha).',
    { phase: 'Critica', label: 'crítica ' + rodada, schema: VEREDITO },
  )
  if (!v) { log('crítica ' + rodada + ' não retornou'); continue }
  if (v.passa) return { passou: true, rodadas: rodada }
  falhas = v.falhas
  log('rodada ' + rodada + ': ' + falhas.length + ' falha(s)')
}
return { passou: false, rodadas: teto, falhas }
```

## lote-com-verificacao (paralelo + olhar independente)

`args`: `{ itens, operacao, check }`

```js
export const meta = {
  name: 'lote-com-verificacao',
  description: 'Aplica a mesma operação em cada item e confere cada resultado de forma independente',
  phases: [{ title: 'Executa' }, { title: 'Confere' }],
}
const { itens, operacao, check } = args
const RESULTADO = {
  type: 'object',
  properties: { ok: { type: 'boolean' }, evidencia: { type: 'string' } },
  required: ['ok', 'evidencia'],
}
const bruto = await pipeline(
  itens,
  item => agent(operacao + '\nItem: ' + item, { phase: 'Executa', label: 'faz ' + item }),
  (relato, item) => agent(
    'Confira de forma independente o item ' + item + '. Check: ' + check +
      '. Relato de quem fez (confira, não confie): ' + relato,
    { phase: 'Confere', label: 'confere ' + item, schema: RESULTADO },
  ),
)
const resultados = bruto.map((r, i) => ({
  item: itens[i],
  ok: Boolean(r && r.ok),
  evidencia: r ? r.evidencia : 'agente não retornou',
}))
const falhou = resultados.filter(r => !r.ok)
log((resultados.length - falhou.length) + '/' + itens.length + ' passaram')
return { resultados, falhou }
```

## roteador (roteamento)

`args`: `{ entrada, rotas }` — `rotas` é `{ nomeDaRota: 'instrução do especialista' }`

```js
export const meta = {
  name: 'roteador',
  description: 'Classifica a entrada e entrega ao especialista da rota',
  phases: [{ title: 'Classifica' }, { title: 'Trata' }],
}
const { entrada, rotas } = args
const nomes = Object.keys(rotas)
const ROTA = {
  type: 'object',
  properties: {
    rota: { type: 'string', enum: nomes.concat(['nenhuma']) },
    motivo: { type: 'string' },
  },
  required: ['rota', 'motivo'],
}
phase('Classifica')
const c = await agent(
  'Classifique a entrada em uma das rotas: ' + nomes.join(', ') +
    '. Use "nenhuma" se não couber em rota alguma.\nEntrada: ' + entrada,
  { schema: ROTA },
)
if (!c || c.rota === 'nenhuma') {
  return { rota: 'nenhuma', motivo: c ? c.motivo : 'classificador não retornou' }
}
phase('Trata')
const saida = await agent(rotas[c.rota] + '\nEntrada: ' + entrada, { label: c.rota })
return { rota: c.rota, motivo: c.motivo, saida }
```

## orquestrador (orquestrador-trabalhadores)

`args`: `{ objetivo, tetoSubtarefas }`

```js
export const meta = {
  name: 'orquestrador',
  description: 'Planeja subtarefas olhando o problema, delega em paralelo e sintetiza',
  phases: [{ title: 'Planeja' }, { title: 'Executa' }, { title: 'Sintetiza' }],
}
const { objetivo } = args
const teto = args.tetoSubtarefas || 8
const PLANO = {
  type: 'object',
  properties: {
    subtarefas: {
      type: 'array',
      items: {
        type: 'object',
        properties: { titulo: { type: 'string' }, instrucao: { type: 'string' } },
        required: ['titulo', 'instrucao'],
      },
    },
  },
  required: ['subtarefas'],
}
phase('Planeja')
const plano = await agent(
  'Investigue o repositório e quebre o objetivo em subtarefas ' +
    'independentes (nenhuma depende do resultado de outra), no máximo ' +
    teto + '. Objetivo: ' + objetivo,
  { schema: PLANO },
)
if (!plano || !plano.subtarefas.length) return { erro: 'planejador não devolveu subtarefas' }
const subtarefas = plano.subtarefas.slice(0, teto)
if (plano.subtarefas.length > teto) {
  log('plano tinha ' + plano.subtarefas.length + ' subtarefas; rodando as ' + teto + ' primeiras')
}
const partes = await parallel(subtarefas.map(s => () =>
  agent(s.instrucao, { phase: 'Executa', label: s.titulo })))
phase('Sintetiza')
const relatorio = subtarefas
  .map((s, i) => '## ' + s.titulo + '\n' + (partes[i] || 'SEM RETORNO'))
  .join('\n\n')
return agent(
  'Sintetize os resultados em uma resposta única para o objetivo: ' +
    objetivo + '. Aponte o que ficou sem retorno ou inconsistente entre ' +
    'as partes.\n\n' + relatorio,
)
```
