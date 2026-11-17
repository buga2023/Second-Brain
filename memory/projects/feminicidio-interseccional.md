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

## Como rodar

Ver o README do repositório (`run_pipeline.py`, `dashboard/`).

## Related

- [Projetos](README.md)
