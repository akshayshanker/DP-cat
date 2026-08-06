#!/usr/bin/env bash
# Build docs/ then force-push its contents to the gh-pages branch.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
bash scripts/build-pages.sh
WORK=$(mktemp -d)
trap 'rm -rf "$WORK"' EXIT
cp -R docs/. "$WORK/"
cd "$WORK"
git init -b gh-pages
git add -A
git -c user.name="akshayshanker" -c user.email="akshayshanker@users.noreply.github.com" \
  commit -m "Publish DP-cat slides to GitHub Pages"
git remote add origin "$(cd "$ROOT" && git remote get-url origin)"
git push -f origin gh-pages
echo "Pushed gh-pages. Site: https://akshayshanker.github.io/DP-cat/"
