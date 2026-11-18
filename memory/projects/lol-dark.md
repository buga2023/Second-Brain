---
title: Projeto lol-dark (canal dark de LoL)
date: 2026-11-17
tags: [projeto, video, automacao, hyperframes]
---

# lol-dark (Wardado Clips)

**O que é.** Canal dark de League of Legends (YouTube, Instagram, TikTok) com
um Short por dia feito por uma esteira automática: coleta notas oficiais da
Riot → roteiro com IA → crítico com nota mínima 80 → narração Kokoro →
render HyperFrames → QA → publicação.

**Como funciona (wiki):** [wardado-clips](../../wiki/projetos/wardado-clips.md).

**Onde está.**
- Código: `~/Projects/lol-dark` (GitHub `buga2023/lol-dark`, público, para ter
  Actions ilimitado).
- Regras: `gemini.md` no repo (a Lei); skills `roteiro-short-lol` e
  `video-short-lol` em `.claude/skills/`.
- Piloto: `~/Videos/lol-dark/piloto-patch-26-23.mp4`.

**Como rodar.** `.venv/bin/python tools/run_pipeline.py --dry-run` (com
`GEMINI_API_KEY`) ou `--roteiro tests/fixtures/roteiro_ok.json --dry-run`.
Na nuvem: workflow `esteira.yml` (09:00 Salvador) e disparo manual.

**Critério de pronto.** `pytest tests/` verde e o MP4 da amostra (patch 26.23)
aprovado no `tools/qa.py`, com comando e saída mostrados.

**Decisões (2026-11-17).**
1. GitHub Actions em repo público, estado em JSONL no branch `state`.
2. Portão de qualidade: roteiro só vira vídeo com nota ≥ 80 do crítico (rubrica
   de 7 critérios) e zero falha determinística (número sem fonte zera).
3. Modo `auto` (pedido do Gustavo): publica sozinho o que passa no crítico e no
   QA. Até a auditoria da API do YouTube o upload sai privado; posta pelo app.
4. Visual próprio, sem cara de template de IA: boletim impresso, League Gothic +
   IBM Plex Mono, número antigo riscado → novo em vermelho, legenda karaokê.
5. Linha editorial: patch, campeão do Mundial, skins, notícias, builds, guias,
   jogadas de pro **reconstruídas** com arte e dados (sem trecho de transmissão:
   risco de claim).
6. Contas (Google/YouTube, TikTok, Instagram, bot do Telegram) criadas pelo
   Gustavo: exigem verificação de identidade dele.

**Decisões (2026-11-18, madrugada).**
7. Marca: **Wardado Clips**, youtube.com/@wardadoclips (nome, @, descrição, foto,
   banner, país, palavras-chave, público e padrões de envio salvos no Studio).
   Paleta azul-marinho #0B3A66 + dourado #D4A84B + creme; olho como selo.
8. Voz: feminina suave. Ordem VoiceMaker (chave pendente) → Gemini TTS (voz Leda,
   instrução de estilo) → Kokoro `pf_dora` só como reserva.
9. Metas de qualidade no loop (`tools/qualidade.py`): roteiro ≥ 80 com critério
   antislop; narração com ritmo médio 2,2–3,3 palavras/s, inteligibilidade
   ≥ 0,85 (whisper) e naturalidade ≥ 8/10 (Gemini ouvindo); vídeo ≥ 80/100
   (Gemini assistindo). Reprovou: refaz a etapa ou não publica.
10. 3 execuções por dia (09h, 13h, 19h Salvador). Fonte sem fim: lore pt_BR do
    Data Dragon (formato voce-sabia); notícias da Riot no formato noticia.
11. Recusado: bot que posta divulgação em Discords e comunidades alheias (spam,
    viola termos do Discord e arrisca o canal). Divulgação feita do jeito
    permitido: servidor próprio com bot de aviso, canais de divulgação de
    servidores que permitem, Reddit dentro das regras de cada sub.
12. TikTok: perfil a configurar no Chrome (a extensão não tinha permissão em
    tiktok.com). Postagem automática exige app aprovado na TikTok.

**Decisões (2026-11-18, cont.).**
13. Texto pelo **Claude** (Claude Code headless `claude -p`, token da assinatura em
    `CLAUDE_CODE_OAUTH_TOKEN`): roteirista, crítico (≥ 80) e juiz de vídeo por
    folha de quadros. Gemini virou reserva. n8n descartado: o cron do Actions já
    dispara nos horários.
14. Spec v2 (doc do Gustavo): `qa.py` dele virou a trava técnica (−14 LUFS,
    movimento a cada 2 s, loop visual/áudio); `masterizar.sh` no fim do render;
    paleta #0B3D6A/#051C33/#D1A147/#EDEAE4, Anton + JetBrains Mono + Archivo,
    ▲ buff ouro / ▼ nerf papel; `lint_editorial.py` (cópia ≥ 8 palavras, gancho
    repetido).
15. 62 pautas perenes (`assets/pautas_evergreen.json`): cada uma é pergunta; o
    Claude pesquisa na web só em domínios oficiais e o código baixa a página e
    confere o trecho citado. Sem fonte conferida: `sem_fonte`.
16. Voz: VoiceStudio (OmniVoice, AGPL, voz por tags) testado no runner; a spec v2
    recomenda voz própria clonada (Chatterbox, MIT) de gravação autorizada por
    escrito. Pendente: de quem é a voz.
17. Decidido (Gustavo, 2026-11-18): 3 vídeos/dia e postagem automática, mesmo com a spec v2 recomendando 4–5/semana e aprovação nos 20
    primeiros. Voz: VoiceStudio (sem voz clonada por ora).

Related: [README](README.md)
