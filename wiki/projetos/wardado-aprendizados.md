---
title: Wardado Clips — o que aprendemos
tipo: projeto
tags: [projeto, wardado, aprendizados, video, tts, youtube]
date: 2026-11-18
fontes: []
---
# Wardado Clips — o que aprendemos

Base de conhecimento do canal: o que funcionou, o que quebrou e por quê, de 17 a 18/11/2026. Arquitetura em
[wardado-clips](wardado-clips.md); voltas e pontos de ajuste em [wardado-melhorias](wardado-melhorias.md).
Números de mercado vêm de guias de terceiros, **(não verificado)** quando não há fonte oficial.

## Roteiro

- Um Short defende **uma ideia**. Quatro campeões em 39 s viram lista e a nota cai; um campeão com a consequência
  prática de cada número foi o primeiro roteiro a passar (Azir, 84/100).
- Cada número precisa do "e daí?": o que muda na partida de quem assiste.
- Opinião marcada como opinião ("pra mim") é desejada; opinião vendida como fato é reprovada pelo crítico.
- O crítico precisa receber a **própria crítica anterior**; sem isso muda de direção a cada rodada e o roteiro nunca converge.
- O roteirista escreve melhor quando vê a **rubrica do editor** e **um exemplo aprovado** no prompt.
- Três rascunhos em paralelo por rodada, com pré-checagem sem modelo (palavras, frases, números), economizam rodadas.
- Um modelo gera (Gemini via `agy`), outro fiscaliza (Claude). Depois de 2 rodadas reprovadas, o Claude reescreve a
  partir das críticas.
- Limites que mais reprovam: 60–110 palavras, frase até 14 palavras, texto de tela até 22 caracteres em cena de número.
- A nota editorial (1–5 em gancho, ângulo, clareza, fecho) barra mais que o crítico: gancho 3/5 é o motivo mais comum.

## Fontes e fatos

- Pauta perene é **pergunta**; só vira vídeo com trecho literal conferido na página oficial. Trecho inventado e site
  fora da lista são barrados por teste.
- A wiki oficial (`wiki.leagueoflegends.com`) devolve 403 ao cliente Python `requests` e 200 ao `curl`: 18 pautas
  foram marcadas "sem fonte" por engano até a conferência passar a usar `curl`.
- Nota de patch antiga não é notícia: o curador só usa o patch mais recente.
- Clipes oficiais de habilidade: `lol.dyn.riotcdn.net/x/videos/champion-abilities/<chave 4 dígitos>/ability_<chave>_<Q|W|E|R|P>1.mp4`.
- Splash: Data Dragon `cdn/img/champion/splash/<Chave>_0.jpg` (K'Sante = `KSante`, Bardo = `Bard`).

## Edição

- Arte parada foi o maior defeito do piloto (14 de 19 janelas de 2 s sem movimento). O que resolveu: gameplay
  oficial alternando com detalhe da splash a cada ~1,8 s, mais arte em tela cheia ao fundo. Resultado: 0 de 17.
- Loop: o fecho termina com o mesmo clipe do gancho, cortado para o último quadro cair onde o primeiro começa
  (semelhança 0,69 → 0,835).
- Legenda: palavra ainda não dita em cinza fica ilegível. Regra: caixa azul-noite, palavra falada em ouro, resto em papel.
- Selo de habilidade (Q/W/E/R) só quando a cena cita a habilidade; a conjunção "E" no começo da frase enganava o detector.
- Vídeo dentro de elemento temporizado quebra o render do HyperFrames: o `<video>` vai na camada raiz.
- Movimento seco (cortes, `power3.out`), faixa dourada só na troca de bloco; nada quica.
- Título: no máximo 2 linhas, sem palavra sozinha; em cena de número, uma linha só.

## Som e voz

- Piloto saiu a −19,7 LUFS e com fade no fim. `masterizar.sh` leva a −14 LUFS e −1,5 dBTP, com trilha baixando sob a voz.
- Sem respiro depois da última palavra, ou o loop de áudio reprova (queda de 8,6 dB → 3,6 dB).
- Kokoro (`pf_dora`) soa robótica: só rascunho. O dono escolheu a voz **VoiceStudio/OmniVoice, "female, young adult,
  moderate pitch"** em 18/11 e quer seguir melhorando.
- Voz desenhada por descrição não é clone; clonar pessoa real só com autorização por escrito.
- Gemini 3.8 Flash TTS (`gemini-3.8-flash-tts`, Interactions API, WAV 24 kHz) está implementado pela documentação, mas
  **não testado**: a chave do dono devolve 403.
- Efeitos: biblioteca fixa de 5 sons (Pixabay, uso comercial livre), pico 1 quadro depois da imagem.
- Pronúncia: dicionário em `assets/voz/pronuncia.json` (a voz nova disse "Azeir").

## Infraestrutura

- GitHub Actions em repo público roda a esteira de graça; VoiceStudio sobe no runner em ~5 min, narração de 6 cenas em CPU leva ~10 min.
- `agy -p` e `claude -p` abrem processos filhos: o timeout comum mata só o pai e o Python fica preso no pipe (uma
  chamada ficou 30 min parada). Solução: matar o grupo de processos.
- `gemini-4-carbon-high` passou de 9 min num roteiro; `gemini-3.8-flash-high` responde em segundos.
- `pkill -f padrão` dentro de um comando que contém o padrão mata o próprio comando.
- Escrita concorrente no branch `state`: `concurrency: state` e push com rebase.

## Plataformas e crescimento (pesquisa de 17/11, guias de mercado)

- YouTube: "conteúdo inautêntico" desde 15/07/2025; template repetido e leitura de material alheio não monetizam.
  Exige análise própria em cada vídeo.
- Programa de Parcerias: 1.000 inscritos + 10 mi de views de Shorts em 90 dias; para canais novos a partir de
  01/02/2027, 20 mi **(não verificado: fonte única)**.
- Riot: anúncio no vídeo pode; membros pagos e Patreon não; sem logo da Riot; aviso obrigatório na descrição.
- Upload por API não auditada fica privado; TikTok e Instagram exigem app aprovado para postar por API.
- 3 a 5 hashtags; título com campeão ou patch; arquivo sem marca d'água de outro app ao republicar.
- Divulgação por bot em comunidades alheias foi recusada: é spam e arrisca o canal.

## Canais de referência (metadados públicos do YouTube lidos em 18/11/2026)

Referência de **formato**, não de conteúdo. Ninguém assistiu aos vídeos: gancho e tom vêm de legendas automáticas de 5 vídeos.

| Canal | Inscritos | O que mais rende | Padrão |
| --- | --- | --- | --- |
| Renecrodilo | 255 mil | Compilados diários de clipes (32–72 mil views); Shorts narrados de fato único fizeram 125–771 mil, mas o canal parou em 04/2024 | Título em caixa alta com dois assuntos; abre direto no clipe |
| Rato Imoral | 187 mil | Série "Jogadas Imorais" (até 905 mil) rende muito mais que o compilado diário (3–35 mil) | "História com começo, meio e fim" |
| Bronziocre | 1,11 mi | Série "Como os ___ realmente jogam" (3,1 a 5,6 mi) | Vocabulário próprio (Bronzétes, CBLOW), abre no pico do caos |

Padrões a adaptar (inferência): série nomeada e numerada rende mais que vídeo avulso; número concreto no título;
primeira frase já é o fato; vocabulário próprio do canal; Short narrado de fato único é o formato mais próximo do
Wardado e está sem dono entre esses canais.

**Cortes de streamers.** Não achamos política pública de Ilha das Lendas, Kami, Jukes, Kennzy ou Smurf do Muca
permitindo cortes de terceiros; vários têm canal de cortes próprio. O Renecrodilo pede na descrição "não dê strike".
Decisão: o Wardado não reposta clipe de streamer sem autorização; fala da jogada com narração e arte oficiais.

## Dados gratuitos do competitivo

API Cargo da Leaguepedia, sem chave (`tools/esports.py`): agenda, resultados e estatísticas de todas as ligas, com
crédito CC BY-SA 3.0 na descrição. Primeiro dado lido: final do Mundial 2026, Bilibili Gaming 3 a 1 Gen.G (14/11).

## Formato-assinatura proposto: O Ward Viu

Todo vídeo é o que um ward revelou: abre na névoa de guerra, a sentinela cai e a névoa abre sobre o fato; fecha com
um selo fixo (`WARDADO` confirmado, `SEM VISÃO` hipótese, `VARRIDO` removido ou revertido) e a pergunta "Você tinha
visão disso?". Série recorrente "A Riot voltou atrás?": a cada patch, reabre uma mudança antiga e confere na nota
nova. Manual completo: `docs/PLAYBOOK.md` no repositório. **A validar com o dono.**

## Decisões do dono que contrariam a recomendação

- 3 vídeos por dia e postagem automática (as skills recomendam 4–5 por semana e aprovação nos 20 primeiros).
- Canal completo: patch, builds, lore, agenda e estatísticas do competitivo, jogadas de profissionais.

## Perguntas abertas

- Jogadas de pro: sem trecho de transmissão (direito autoral e regra das skills), como mostrar a jogada? Hoje:
  reconstrução com dados e clipe oficial da habilidade.
- Agenda e estatísticas: de onde tirar dados com permissão? A API do site lolesports usa uma chave que não é do
  canal; Riot API exige cadastro de produto. Hoje: página pública + Leaguepedia, com trecho conferido.
- Qual voz bate a atual? Testar Gemini 3.8 quando houver chave.

## Related

- [wardado-clips](wardado-clips.md)
- [wardado-melhorias](wardado-melhorias.md)
- [lol-dark (memória)](../../memory/projects/lol-dark.md)
