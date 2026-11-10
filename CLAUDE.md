# Segundo cérebro do Gustavo

Vault Obsidian + repo git no padrão LLM Wiki do Karpathy
(gist `karpathy/442a6bf555914893e9891c11519de94f`). O Gustavo escolhe as
fontes e faz as perguntas. O Claude escreve e mantém o wiki: resume, cruza
referências, arquiva e mantém o registro. Idioma: **português (BR)**, com
termos técnicos consagrados em inglês (harness, trace, ETL).

> **Repo público** (`buga2023/Second-Brain`). Material interno da GP ou de
> projeto privado só entra depois de o Gustavo confirmar.

## Camadas

- `raw/`: fontes **imutáveis**. Nunca editar. Nome `AAAA-MM-DD-slug.md`,
  frontmatter `fonte`, `url`, `tipo`, `capturado`; imagens em `raw/assets/`.
  Toda fonte nova entra na tabela de `raw/README.md`.
- `wiki/`: conhecimento compilado. `index.md` é o catálogo (uma linha por
  página), `overview.md` é a tese atual. Pastas: `fontes/` (resumo de uma
  fonte, prefixo `fonte-`), `conceitos/`, `entidades/`, `projetos/`,
  `guias/` (como fazer, com código testado), `sinteses/` (análises e
  respostas que vale guardar).
- `memory/`: o que lembrar entre sessões. `people/` (uma nota por pessoa),
  `projects/` (projetos e skills próprias), `context/` (decisões e
  convenções), `glossary.md` (siglas e codinomes).
- `skills/`: skills do Claude Code (`claude-config/install.sh` instala, junto
  com as regras pessoais). `tools/`: lint.
- `00-Index.md` é a entrada; `log.md` é o histórico único.

## Convenções

- **Links Markdown relativos** (`[nome](../pasta/arquivo.md)`), nunca
  `[[wikilinks]]`: o repo precisa renderizar no GitHub. Nomes de arquivo
  únicos no vault inteiro.
- Frontmatter: `title`, `date` (AAAA-MM-DD), `tags: [..]`, `aliases`
  opcional. No wiki também: `tipo` (conceito | entidade | fonte | projeto |
  sintese | guia) e `fontes` (lista de arquivos de `raw/`).
- Toda nota termina com `Related:` (ou `## Related`), com links para as
  notas que ela usa, contradiz ou substitui. Toda pasta tem índice.
- Número citado aponta para a página da fonte. Afirmação de fornecedor sem
  fonte verificável: marcar **(não verificado)**.
- Contradição entre fontes: seção `## Contradições`, mantendo os dois
  lados. Lacuna: seção `## Perguntas abertas`.

## Operações

- **Ingest**: fonte em `raw/` → página `wiki/fontes/fonte-*` → atualizar
  conceitos e entidades tocados → `wiki/index.md`, `overview.md` (se a tese
  mudar), `raw/README.md` e uma entrada em `log.md`. Fato sobre pessoa,
  projeto, decisão ou sigla vai para `memory/` em vez de ficar só na
  conversa.
- **Query**: ler `00-Index.md` → `wiki/index.md` → abrir as páginas →
  responder citando. Uma resposta boa vira página em `wiki/sinteses/`.
- **Lint**: `python3 tools/vault_lint.py . --exclude skills tools` (a CI
  roda o mesmo a cada push) e depois a parte que só o modelo faz:
  contradições, afirmações velhas, conceitos citados sem página, lacunas
  que uma busca resolveria. Registrar em `log.md` como `lint`.
- `log.md`: entradas `## [AAAA-MM-DD] operação | título`, só acrescentar.

## Decisões em vigor

- Grilling antes do grafo: antes de desenhar grafo de execução ou loop,
  entrevistar o escopo (`grilling`; `wayfinder` se passar de uma sessão).
  Ver `memory/context/entrevista-antes-do-grafo.md`.
