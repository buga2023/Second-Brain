# Fase 2 — Recon (com freio)

Mapear a superfície dentro do escopo. Cada host novo passa pelo portão
(`escopo.py`) antes de ser sondado. Binários em `~/.local/bin`.

## Freio de taxa — a regra que não se quebra

Velocidade padrão é perigosa: **httpx e nuclei mandam ~150 req/s; ffuf não
tem limite** (40 threads sem rate). Sempre passe o freio. Sem limite na
política, use 5 req/s.

| Ferramenta | Freio | Headers |
|---|---|---|
| httpx | `-rl N` (req/s) | `-H "X-HackerOne-Research: usuario"` |
| nuclei | `-rl N` (vence `-c` e `-bs`) | `-H "..."` |
| ffuf | `-rate N` | `-H "..."` |

## Cadeia básica

```bash
# 1. subdominios (passivo, sem tocar o alvo)
subfinder -d exemplo.com -silent > subs.txt

# 2. PORTAO: filtre subs.txt, mantendo so o que da IN
while read h; do python3 referencias/escopo.py escopo.txt "$h" >/dev/null && echo "$h"; done < subs.txt > subs-in.txt

# 3. quais respondem, com titulo e tech
httpx -l subs-in.txt -rl 5 -title -tech-detect -status-code -o vivos.txt

# 4. conteudo escondido num host (ligue -ac para calibrar)
ffuf -u https://api.exemplo.com/FUZZ -w ~/.local/share/wordlists/common.txt -rate 5 -ac

# 5. scan por template — SO se a politica permitir scanner
nuclei -l vivos.txt -rl 5 -etags dos,intrusive,fuzz,bruteforce -exclude-type headless -severity low,medium,high,critical
```

## nuclei — excluir o que é intrusivo

O `.nuclei-ignore` padrão **não** exclui a tag `intrusive`. Sempre:
`-etags dos,intrusive,fuzz,bruteforce`. Só rode nuclei se a política
aceitar scanner automático (muitos não aceitam). O `-rl` é o único freio
confiável; ele prevalece sobre `-c` e `-bs`.
(https://github.com/projectdiscovery/nuclei-templates/blob/main/.nuclei-ignore)

## Wordlists

SecLists. Baixe o que precisar e aponte com `-w`:
`~/.local/share/wordlists/common.txt` já está na máquina
(Discovery/Web-Content/common.txt). Fonte: github.com/danielmiessler/SecLists.

## Reinstalar as ferramentas (via Go)

O caminho do módulo leva `/v2` e `/v3`:
```bash
go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install github.com/projectdiscovery/httpx/cmd/httpx@latest
go install github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
go install github.com/ffuf/ffuf/v2@latest
```
(https://docs.projectdiscovery.io/tools/subfinder/install)

## Leitura

Mais ferramenta não é mais resultado. Recon grande só mostra onde olhar; o
achado que paga quase sempre vem do teste manual na fase 3, num punhado de
endpoints escolhidos.
