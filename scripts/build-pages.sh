#!/usr/bin/env bash
# Rebuild the GitHub Pages site under docs/ from Marp sources.
set -euo pipefail
cd "$(dirname "$0")/.."

rm -rf docs/session-01-motivation docs/categorical-types-and-agi
mkdir -p docs/categories-and-functors

marp "Categorical types and AGI -1.md" \
  -o docs/categories-and-functors/index.html \
  --theme-set theme/econ-ark-cat.css \
  --allow-local-files \
  --html

marp "Categorical types and AGI -1.md" \
  -o docs/categories-and-functors/categories-and-functors.pdf \
  --theme-set theme/econ-ark-cat.css \
  --allow-local-files \
  --html

mkdir -p docs/categories-and-functors/assets
cp -R assets/. docs/categories-and-functors/assets/

cp site-index.html docs/index.html
touch docs/.nojekyll

python3 scripts/check-pages-assets.py

echo "Built docs/ for GitHub Pages."
