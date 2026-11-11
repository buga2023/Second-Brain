#!/usr/bin/env python3
"""Portao de escopo. Uso: escopo.py escopo.txt <host-ou-url>
Saida: IN (pode testar), OUT (nao toque), ERRO (arquivo/argumento ruim).
Codigo de saida: 0 = IN, 1 = OUT, 2 = ERRO. Use antes de qualquer comando.

Regra: o alvo esta dentro se casa UMA linha `in:` E NENHUMA `out:`.
Curinga `*` cobre um nivel de subdominio (*.exemplo.com casa a.exemplo.com,
nao exemplo.com nem a.b.exemplo.com). Linha `out:` vence sempre.
"""
import sys, re
from urllib.parse import urlparse

def host_de(alvo: str) -> str:
    alvo = alvo.strip()
    if "://" in alvo:
        alvo = urlparse(alvo).hostname or ""
    else:
        alvo = alvo.split("/")[0].split(":")[0]
    return alvo.lower().rstrip(".")

def casa(padrao: str, host: str) -> bool:
    padrao = padrao.lower().strip().rstrip(".")
    if padrao == host:
        return True
    # curinga: *.exemplo.com -> exatamente um rotulo antes
    rx = "^" + re.escape(padrao).replace(r"\*", r"[^.]+") + "$"
    return re.match(rx, host) is not None

def main() -> int:
    if len(sys.argv) != 3:
        print("ERRO: uso: escopo.py escopo.txt <host-ou-url>", file=sys.stderr)
        return 2
    arquivo, alvo = sys.argv[1], sys.argv[2]
    host = host_de(alvo)
    if not host:
        print(f"ERRO: nao consegui extrair host de '{alvo}'", file=sys.stderr)
        return 2
    try:
        linhas = open(arquivo, encoding="utf-8").read().splitlines()
    except OSError as e:
        print(f"ERRO: {e}", file=sys.stderr)
        return 2
    ins, outs = [], []
    for ln in linhas:
        ln = ln.split("#", 1)[0].strip()
        if ln.startswith("in:"):
            ins.append(ln[3:].strip())
        elif ln.startswith("out:"):
            p = ln[4:].strip()
            if "casa uma linha" not in p and p:  # ignora a linha de comentario-regra
                outs.append(p)
    for p in outs:
        if casa(p, host):
            print(f"OUT {host}  (casou out: {p})")
            return 1
    for p in ins:
        if casa(p, host):
            print(f"IN  {host}  (casou in: {p})")
            return 0
    print(f"OUT {host}  (nao casou nenhuma linha in:)")
    return 1

if __name__ == "__main__":
    sys.exit(main())
