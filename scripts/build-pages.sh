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

# Session B and Session C
for pair in "Categorical types and AGI -2.md|free-category" "Categorical types and AGI -3.md|stages-and-yoneda"; do
  src="${pair%%|*}"; dir="${pair##*|}"
  mkdir -p "docs/$dir/assets"
  marp "$src" -o "docs/$dir/index.html" --theme-set theme/econ-ark-cat.css --allow-local-files --html
  marp "$src" -o "docs/$dir/$dir.pdf" --theme-set theme/econ-ark-cat.css --allow-local-files --html
  grep -oh 'assets/[^)" ]*' "$src" | sort -u | while read -r f; do cp "$f" "docs/$dir/assets/"; done
done

cp site-index.html docs/index.html
touch docs/.nojekyll

python3 scripts/check-pages-assets.py

echo "Built docs/ for GitHub Pages."
