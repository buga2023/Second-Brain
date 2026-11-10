#!/usr/bin/env bash
# Liga as skills deste backup em ~/.claude/skills/ via symlink,
# para que um `git pull` no vault já atualize a skill instalada.
# Não sobrescreve uma skill que já exista com o mesmo nome.
set -euo pipefail
src="$(cd "$(dirname "$0")" && pwd)"
dest="${HOME}/.claude/skills"
mkdir -p "$dest"
for dir in "$src"/*/; do
  name="$(basename "$dir")"
  [ -f "$dir/SKILL.md" ] || continue
  if [ -e "$dest/$name" ] && [ ! -L "$dest/$name" ]; then
    echo "pulei $name: já existe em $dest (não é symlink)"; continue
  fi
  ln -sfn "${dir%/}" "$dest/$name" && echo "ok $name -> $dest/$name"
done
