#!/usr/bin/env bash
# Rebuild the GitHub Pages site under docs/ from Marp sources.
set -euo pipefail
cd "$(dirname "$0")/.."

mkdir -p docs/categorical-types-and-agi docs/session-01-motivation

marp "Categorical types and AGI -1.md" \
  -o docs/categorical-types-and-agi/index.html \
  --allow-local-files \
  --html

marp talks/session-01-motivation/deck.md \
  -o docs/session-01-motivation/index.html \
  --allow-local-files \
  --html

mkdir -p docs/categorical-types-and-agi/assets
cp -R assets/. docs/categorical-types-and-agi/assets/

mkdir -p docs/session-01-motivation/assets
cp -R talks/session-01-motivation/assets/. docs/session-01-motivation/assets/

cp site-index.html docs/index.html
touch docs/.nojekyll

echo "Built docs/ for GitHub Pages."
