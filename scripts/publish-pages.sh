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
git -c user.name="github-actions[bot]" \
    -c user.email="41898282+github-actions[bot]@users.noreply.github.com" \
    commit -m "Publish DP-cat slides to GitHub Pages"
if [ -n "${GITHUB_TOKEN:-}" ]; then
  git remote add origin "https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
elif [ -n "${GITHUB_REPOSITORY:-}" ]; then
  git remote add origin "https://github.com/${GITHUB_REPOSITORY}.git"
else
  git remote add origin "$(cd "$ROOT" && git remote get-url origin)"
fi
git push -f origin gh-pages
echo "Pushed gh-pages. Site: https://akshayshanker.github.io/DP-cat/"
