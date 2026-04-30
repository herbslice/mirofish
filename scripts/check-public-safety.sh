#!/usr/bin/env bash
set -euo pipefail

root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$root"

terms=(
  "M""ark"
  "M""ARQUE"
  "M""arque"
  "m""arque"
)

exclude=(
  --glob '!.git'
  --glob '!.git/**'
  --glob '!node_modules/**'
  --glob '!frontend/node_modules/**'
  --glob '!backend/.venv/**'
  --glob '!backend/data/**'
  --glob '!backend/logs/**'
  --glob '!backend/uploads/**'
  --glob '!uploads/**'
  --glob '!package-lock.json'
  --glob '!frontend/package-lock.json'
)

failed=0
for term in "${terms[@]}"; do
  pattern="\b${term}\b"
  if rg -n --hidden "${exclude[@]}" --pcre2 -- "$pattern" .; then
    failed=1
  fi
done

if [[ "$failed" -ne 0 ]]; then
  echo "Safety check failed: blocked internal wording was found." >&2
  exit 1
fi

echo "Safety check passed."
