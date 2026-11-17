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

## Conferência das fases anteriores (2026-11-17)

- **Fase 1 (AI 02):** os arquivos entregues são `Fase1_GAP_Salarial_ENTREGA` (tema 01, RAIS/CAGED),
  não feminicídio. Confirmar com o Gustavo se foi o arquivo errado.
- **Fase 3 (AI 04):** o pedido era a "continuação da AI 03": Terraform, segurança de
  credenciais, organização do repositório e README. A entrega foi a análise. O Terraform nunca foi entregue.
- Os slides da professora ("Big Data – tudo o que você precisa saber") ensinam os **3 V's de Laney**
  (Volume, Velocidade, Variedade). A ementa e o guia pedem 5 (+Veracidade e Valor). O README deve
  apresentar os 3 e depois os 2 extras.
- A ementa cita Hadoop/Spark. Justificar o Pandas em chunks pelo volume (~2,6 GB brutos).
- O KDD do deck de Mineração (seleção → pré-processamento → transformação → mineração →
  interpretação) serve para estruturar o pitch e o README.
- Materiais baixados em `~/Downloads/classroom-bigdata/` (local, fora do vault).

## Fase 4 construída (2026-11-17)

- O banco antigo `pg-1fc147bb` tinha sido criado no console durante o trial (plano developer-1, pago).
  Quando o trial acabou, ficou POWEROFF. Não religamos, porque geraria cobrança.
- Terraform (`terraform/`) criou `pg-feminicidio` no plano `free-1-1gb` (do-nyc) e o usuário `painel_leitura`
  (só SELECT). O token do Aiven vale 30 dias e fica só no `.env`; o `scripts/tf.sh` passa ele como TF_VAR.
- Recarga sem baixar as fontes de novo: `python -m scripts.carregar_processados` (cerca de 40 s).
- Entrou a população feminina do IBGE (Projeção 2024, FTP) → tabela `populacao_feminina_uf` + `vw_taxas_uf_ano`.
  Taxa Brasil 3,51 por 100 mil; RR 9,49 e SP 1,59 (SP tem o maior número absoluto e a menor taxa).
- Dashboard Streamlit (`dashboard/app.py`): 4 KPIs, filtros, seletor de métrica, drill-down região→UF→município,
  SQL parametrizado ao vivo. Deploy no Streamlit Cloud ficou pendente do login do Gustavo (authkit bloqueado para a extensão).
- GitHub Actions: `ci.yml` (pytest + terraform validate) e `fontes.yml` (checagem mensal). Em 17/11 a checagem
  achou o SINESP 2025 publicado e revisões do SINESP 2019-2024 e do SIM 2022/2023. O recorte continua 2019-2024.
- O código da Fase 3 entrou no repositório (`analise/`, `saidas/`, `figuras/`, `docs/relatorio_fase3/`) e reproduz o findings.json idêntico.
- Pitch: deck de 12 slides (artifact Slides, privado) + `docs/pitch/roteiro.md` com as perguntas da defesa.
- Pacote de entrega: `~/Downloads/Entrega_Fase4_Gustavo_Santos_Mateus_Bulhoes/`.

## Entrega pronta (2026-11-17)

- Painel público: https://feminicidio-interseccional.streamlit.app (Streamlit Cloud, conta buga2023, Python 3.12;
  Secret = URI do `painel_leitura`). Faz redeploy sozinho a cada push na `main`.
- Slides: artifact Slides privado (BeRfLyGcVTFiRZSFX7izEf). O Gustavo precisa compartilhar com o Mateus.
- Loop de revisão: check de 89 itens (números dos slides/README/roteiro = consulta ao vivo, barema,
  segredos, terraform sem drift) + 2 revisores independentes. O revisor 2 deu 9,5 e "pronto para entregar".
- Antes de apresentar: conferir se o `pg-feminicidio` está Running (o free desliga por inatividade) e abrir o painel
  10 min antes (o Cloud hiberna).
- O token do Aiven expira em cerca de 30 dias (criado em 17/11).

## Como rodar

Ver o README do repositório (`run_pipeline.py`, `dashboard/`).

## Related

- [Projetos](README.md)
