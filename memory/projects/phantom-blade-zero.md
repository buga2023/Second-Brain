---
title: Phantom Blade Zero no Fedora (desempenho)
date: 2026-11-24
tags: [projeto, jogo, linux, desempenho]
---

# Phantom Blade Zero no Fedora

**O que é.** Fazer o Phantom Blade Zero (Steam flatpak, app 4115450, Proton)
rodar liso no PC: Ryzen 7 5700X, RTX 3060 12 GB, 16 GB de RAM.

**Onde está.**
- `~/.local/bin/pbz`: abre o jogo com monitor em 60 Hz, fecha Discord/ZapZap,
  põe a CPU em `throughput-performance` (tuned) e grava RAM/GPU em
  `~/.local/share/pbz-test/sessao-*.log`. Ao fechar, volta a 100 Hz e `balanced`.
- `~/.local/bin/pbz-medir`: resume a última gravação do MangoHud
  (fps médio, 1% low, swap) em blocos de 2 min.
- MangoHud: `~/.config/MangoHud/MangoHud.conf`, logs em
  `~/.var/app/com.valvesoftware.Steam/mangologs`.

**Diagnóstico (24/11).** O limite é RAM, não GPU. Sessão de 40 min com
texturas e malhas em Alto: o fps cai de 46 para 33, a GPU fica em 62% e usa
5 de 12 GB de VRAM, e o swap chega a 8,7 GB (estoura o zram de 8 GB e cai no
swapfile em disco). Com texturas e malhas em Médio e o Discord fechado, o
começo da sessão fica perto de 60.

**Decisões.**
- O jogo regrava o `GameUserSettings.ini`: gráficos só pelo menu do jogo.
- Perfil de CPU em desempenho só durante o jogo (no `pbz`).
- Solução definitiva: 32 GB de RAM.

Related: [README](README.md)
