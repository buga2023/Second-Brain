---
title: Feminicídio Interseccional (trabalho Fases 1-4)
date: 2026-11-17
tags: [projeto, faculdade]
---

# Feminicídio Interseccional

Trabalho de faculdade em dupla (Gustavo Santos e Mateus Bulhões): monitoramento
de segurança pública e feminicídio com recorte de gênero, raça e idade
(ODS 5 e ODS 18).

- **Repositório:** `buga2023/fase2-etl-violencia-genero` (público), clone local em
  `~/Projetos/fase2-etl-violencia-genero`. Branch de trabalho `entrega-fase4`.
- **Fontes:** SINESP-VDE, SIM/DataSUS (CID X85-Y09, sexo feminino), IBGE. Recorte 2019-2024.
- **Banco:** PostgreSQL no Aiven (free tier), schema `vde`, modelo estrela.
  URI em `.env` (`DATABASE_URL`), fora do git.
- **Fase 2:** ETL + carga + painel HTML estático (no repo).
- **Fase 3:** análise (perguntas.py, figuras, relatório PDF, painel estático). Entregue
  por zip em 2026-10-20; código ainda NÃO está no repo.
- **Fase 4 (2026-11):** dashboard ao vivo no Aiven, Terraform, README final, pitch 10 min.

## Decisões (2026-11-17)

- Dashboard em **Streamlit**, publicado no Streamlit Community Cloud, com o
  `DATABASE_URL` guardado como secret.
- Terraform criado do zero com o provider Aiven: `infra/terraform`.
- Escopo da sessão: entregáveis 1 a 4, incluindo o pitch.
- Antes de construir: conferir o Classroom (enunciado, slides, feedbacks) via Claude in Chrome.

## Barema e exigências (lido no Classroom em 2026-11-17)

Disciplina Big Data e Analytics 2026/2. O projeto vale 6 pontos da 2ª unidade
(prova vale 4) e a apresentação é obrigatória. A Fase 4 (AI 06) vale 100 pontos e
vence em **2026-11-22**. As Fases 2 e 3 foram entregues e ainda estão sem nota.
A AI 05 (Introdução a Big Data) ficou sem entrega e o prazo já fechou.

O Guia de Orientação (Docs anexo em "Orientações do projeto") pede:
- Repositório com `/etl`, `/terraform` (main.tf, variables.tf, outputs.tf, provider Aiven) e `/dashboard` (Streamlit).
- README com diagrama, 5 V's, tipos de dados, dicionário de dados e regras de negócio,
  justificativa relacional × não relacional e guia de deploy. A Fase 4 soma link, print,
  os 4 KPIs e a análise ODS 5/18.
- Dashboard online: ≥4 KPIs, filtros cruzados (Ano, UF/Região, Sexo, Raça/Cor, Faixa
  Etária), seletor de métrica e drill-down.
- Segredos fora do repositório (`.env` e Secrets); LGPD; GitHub Actions citado para Velocidade.
- Pitch de 10 min com demonstração do Terraform.
- Barema (10): Aiven+IaC 2,5 | ETL+modelagem 2,5 | regras, 5V, LGPD 1,5 | ODS 1,5 | dashboard 1,0 | README e pitch 1,0.

## Como rodar

Ver o README do repositório (`run_pipeline.py`, `dashboard/`).

## Related

- [Projetos](README.md)
