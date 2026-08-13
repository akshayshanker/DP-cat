#!/usr/bin/env bash
# Rebuild the GitHub Pages site under docs/ from Marp sources.
set -euo pipefail
cd "$(dirname "$0")/.."

rm -rf docs/session-01-motivation
mkdir -p docs/categorical-types-and-agi

marp "Categorical types and AGI -1.md" \
  -o docs/categorical-types-and-agi/index.html \
  --theme-set theme/econ-ark-cat.css \
  --allow-local-files \
  --html

marp "Categorical types and AGI -1.md" \
  -o docs/categorical-types-and-agi/categorical-types-and-agi.pdf \
  --theme-set theme/econ-ark-cat.css \
  --allow-local-files \
  --html

mkdir -p docs/categorical-types-and-agi/assets
cp -R assets/. docs/categorical-types-and-agi/assets/

cp site-index.html docs/index.html
touch docs/.nojekyll

python3 scripts/check-pages-assets.py

echo "Built docs/ for GitHub Pages."
