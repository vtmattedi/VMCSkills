#!/usr/bin/env bash
set -euo pipefail

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
source_root="$repo/.agents/skills"
if [[ ! -d "$source_root" ]]; then
  echo "Missing skill source directory: $source_root" >&2
  exit 1
fi

skills=()
for skillfile in "$source_root"/*/SKILL.md; do
  [[ -f "$skillfile" ]] || continue
  skills+=("$(dirname "$skillfile")")
done
if (( ${#skills[@]} == 0 )); then
  echo "No skills found under $source_root" >&2
  exit 1
fi

# Preflight all destinations before modifying anything.
destinations=("$HOME/.agents/skills" "$HOME/.claude/skills")
for destination in "${destinations[@]}"; do
  for source in "${skills[@]}"; do
    name="$(basename "$source")"
    link="$destination/$name"
    if [[ -L "$link" ]]; then
      existing="$(readlink "$link")"
      if [[ "$existing" != "$source" ]]; then
        echo "Conflict: $link is a symlink to $existing, not $source" >&2
        exit 1
      fi
    elif [[ -e "$link" ]]; then
      echo "Conflict: $link already exists and is not a VMCSkills symlink" >&2
      exit 1
    fi
  done
done

for destination in "${destinations[@]}"; do
  mkdir -p "$destination"
  for source in "${skills[@]}"; do
    link="$destination/$(basename "$source")"
    if [[ -L "$link" ]]; then
      echo "Already linked: $link"
    else
      ln -s "$source" "$link"
      echo "Linked: $link -> $source"
    fi
  done
done
echo "VMCSkills installation complete."
