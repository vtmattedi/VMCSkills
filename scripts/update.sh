#!/usr/bin/env bash
set -euo pipefail

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
cd "$repo"

if [[ ! -d .git ]]; then
  echo "Not a Git checkout: $repo" >&2
  exit 1
fi
if [[ -n "$(git status --porcelain --untracked-files=normal)" ]]; then
  echo "Refusing update: working tree contains local changes or untracked files." >&2
  exit 1
fi
branch="$(git symbolic-ref --quiet --short HEAD)" || {
  echo "Refusing update: detached HEAD." >&2
  exit 1
}
upstream="$(git rev-parse --abbrev-ref --symbolic-full-name '@{upstream}' 2>/dev/null)" || {
  echo "Refusing update: branch $branch has no upstream." >&2
  exit 1
}
echo "Updating $repo ($branch tracking $upstream)"
git pull --ff-only
bash "$repo/scripts/install.sh"
echo "Update complete at $(git rev-parse --short HEAD)."
