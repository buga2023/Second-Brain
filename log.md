---
title: Log
date: 2026-11-10
tags: [meta]
---

# Log

Registro cronológico (append-only) do que entrou ou mudou no vault.
Formato: `## [AAAA-MM-DD] operação | título`, onde operação é
`setup`, `ingest`, `query`, `lint` ou `refactor`. Últimas entradas:
`grep "^## \[" log.md | tail -5`.

## [2026-11-05] setup | Vault local criado (wiki/ + raw/)
Estrutura raw/ + wiki/ + CLAUDE.md (Karpathy LLM Wiki + schema PT-BR), em `~/Desktop/Brain`.

## [2026-11-05] ingest | Post LangChain/LangGraph
## [2026-11-05] ingest | Paper Self-Harness (arXiv 2606.09498)
## [2026-11-05] ingest | BD TechTalks — self-improving harnesses
## [2026-11-05] ingest | Pesquisa web — harness e auto-evolução
## [2026-11-05] ingest | Pesquisa web — ETL agêntico
## [2026-11-05] ingest | Pesquisa web — esteira NTI (sem resultado)
Criadas 8 páginas de conceito, 7 de entidade, 6 de fonte, 1 projeto, 2 sínteses, overview e index.
Lacuna aberta: [esteira-nti](wiki/projetos/esteira-nti.md).

## [2026-11-06] ingest | Slide RHAWK: ciclo de evolução orientado ao negócio
Imagem em raw/assets/. Criadas: fonte-slide-rhawk-ciclo-evolucao, ciclo-de-evolucao-rhawk, rhawk. Atualizadas: esteira-nti, self-harness-como-etl, overview, index.

## [2026-11-06] ingest | Slide RHAWK: como saber se a mudança gerou mais valor
Criadas: fonte-slide-rhawk-avaliar-mudanca, avaliacao-atual-vs-candidata. Atualizadas: ciclo-de-evolucao-rhawk (pergunta da etapa 06 respondida em parte), gate-de-regressao, index.

## [2026-11-06] ingest | Pesquisa web: avaliação, rollout, métricas e governança
## [2026-11-06] ingest | Docs e skills oficiais LangChain/LangGraph
Criadas: 4 conceitos, 2 entidades, 4 guias (nova categoria guias/), 1 síntese de respostas. Projeto rodável em ~/Projetos/estudo-langgraph (testado). 15 skills + 2 MCP instalados.

## [2026-11-06] ingest | Sessão Orca + documentação da Esteira NTI
Esteira NTI documentada por 3 workers Orca e empacotada como skill (github.com/buga2023/esteira-nti, privado). Criado guia-orca-orquestracao. Atualizados esteira-nti e index.

## [2026-11-10] setup | Scaffold do repo Second-Brain (memory/*, índice, glossário)
## [2026-11-10] ingest | Skill `triagem-automacao-gp` registrada em memory/projects
## [2026-11-10] ingest | Skills `graph-engineering` (criada) e `watch` (bradautomates/claude-video), backup em skills/
## [2026-11-10] ingest | Decisão "entrevista antes do grafo" (vídeos Maestros da IA) em memory/context
## [2026-11-10] ingest | Conselhos do Matt Pocock (vídeo + repo mattpocock/skills)
Plugin "Skills For Real Engineers" instalado; grilling/wayfinder/writing-for-agents citados em CLAUDE.md e graph-engineering; nota matt-pocock.md criada.

## [2026-11-10] ingest | Análise do histórico de sessões
Criadas as skills raio-x, triar-feedback, desenhar-loop, fechar-sessao, agents-md e
graph-engineering v2; claude-config com regras e instalador; notas fluxo-diario,
como-trabalho, inventario-skills e boas-praticas-instrucoes.

## [2026-11-10] refactor | Unificação dos dois vaults
`~/Desktop/Brain` (wiki/ + raw/) trazido para este repo. 276 wikilinks convertidos em links
relativos (skill obsidian-notes, `--to-markdown-links`); frontmatter do wiki padronizado
(`titulo`→`title`, `atualizado`→`date`); os dois logs fundidos aqui; CLAUDE.md do vault
criado; lint automático em `tools/` + GitHub Action; matt-pocock movido para people/;
notas das skills vibecode-flow, vuln-triage e prompt-engineering; glossário ampliado;
LICENSE da skill watch incluída. `raw/` copiado byte a byte, sem edição.

## [2026-11-10] ingest | Repositórios do vídeo de Enzo Barbatto (sessão na nuvem)
Humanizer instalado em skills/, Laya registrado como candidato, veredito dos demais em
memory/context/inventario-skills.md.

## [2026-11-10] lint | desenhar-loop revisado após teste com agente de contexto novo
Tipos de loop, ambiente de execução, armadilhas dos motores.

## [2026-11-10] ingest | Repositórios do vídeo: páginas no wiki
Lista colada + metadados do GitHub em raw/. Criadas: fonte-repos-video-ferramentas-agentes
e 5 entidades (humanizer, laya, scroll-craft, voicestudio, rea), com os vereditos do
inventario-skills. Link do ScrollCraft completado (nateherkai/scroll-craft).

## [2026-11-10] lint | raio-x revisado após teste em aplicação real
Teste com agente de contexto novo gerou 422 linhas e misturava achado reproduzido com
achado só lido. A skill agora pede selo (reproduzido / lido / não verificado), resumo no
topo, até 15 regras e um diagrama, e mantém fechados os arquivos de credencial. Cuidados
com a skill watch reproduzidos no teste anotados em memory/context/inventario-skills.md.

## [2026-11-10] setup | Ferramentas do vídeo instaladas e vault como regra global
Máquina Fedora: humanizer e demais skills do vault (install.sh), ScrollCraft (symlink),
Laya (venv), VoiceStudio (AppImage, checksum conferido), REA (MCP + skill, rea-agents 6.8.0).
Regra nova em claude-config/regras.md: todo projeto lê e mantém sua nota no vault.
Vault registrado no Obsidian (Flatpak).

Related: [00-Index](00-Index.md)

## [2026-11-10] ingest | Reel nogCYBER e guia de bug bounty
Reel do Instagram (nogCYBER, 13 ferramentas de pentest por fase) transcrito com a skill watch
(motor local + WhisperX; instalador corrigido para fixar torchvision CPU). Pesquisa web sobre
trilha de bug bounty, plataformas (HackerOne, Bugcrowd, Intigriti, BugHunt), recon e report.
Novo guia wiki/guias/guia-bug-bounty.md; 5 termos no glossário.

## [2026-11-10] ingest+build | Skill bug-bounty criada e testada no lab
Pesquisa aprofundada (subagente) sobre ferramentas e regras de bug bounty -> raw +
wiki/fontes/fonte-pesquisa-bug-bounty-ferramentas.md. Skill skills/bug-bounty criada: SKILL.md
com portao de escopo (escopo.py, testado), 4 referencias de fase + lab Juice Shop. Ferramentas
instaladas (subfinder, httpx, nuclei, ffuf em ~/.local/bin; Juice Shop em podman). IDOR da cesta
provado no lab (alice leu a cesta do bob via GET /rest/basket/7); report de exemplo gravado.
Skill instalada em ~/.claude. Projeto: memory/projects/bug-bounty.md.

## [2026-11-13] memory | Auditoria das automações e harness de contexto de engenharia
Auditoria de todas as automações da GP em produção (4 revisores por disciplina + reprodução
do teste de um especialista; achados graves remedidos). Classes de bug e lições de processo em
memory/context/licoes-auditoria-automacoes.md (detalhe por app fica no vault privado). Projeto
novo memory/projects/contexto-engenharia.md: harness local (SQLite FTS5, sem nuvem) que monta o
dossiê de contexto antes de criar uma automação; skill de triagem ganha passo 0 e checklist.

