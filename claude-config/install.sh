#!/usr/bin/env bash
# Instala skills e regras do Second-Brain em ~/.claude (Linux, macOS, WSL, nuvem).
# Uso: bash claude-config/install.sh [--skills-only]
set -euo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
vault="$(dirname "$here")"
claude="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
stamp="$(date +%Y%m%d-%H%M%S)"

mkdir -p "$claude/skills"
for src in "$vault"/skills/*/; do
  name="$(basename "$src")"
  [ -f "$src/SKILL.md" ] || continue
  dst="$claude/skills/$name"
  if [ -e "$dst" ]; then
    mkdir -p "$claude/skills-backup/$stamp"
    mv "$dst" "$claude/skills-backup/$stamp/$name"
  fi
  cp -R "$src" "$dst"
  echo "skill: $name"
done

if [ "${1:-}" != "--skills-only" ]; then
  mkdir -p "$claude/rules"
  esc="$(printf '%s' "$vault" | sed 's/[&|\\]/\\&/g')"
  sed "s|{{VAULT}}|$esc|g" "$here/regras.md" > "$claude/rules/fluxo-gustavo.md"
  echo "regras: $claude/rules/fluxo-gustavo.md"
fi

if [ -d "$claude/skills-backup/$stamp" ]; then
  echo "versoes anteriores guardadas em: $claude/skills-backup/$stamp"
fi
