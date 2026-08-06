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
AUTHOR_NAME="${GIT_AUTHOR_NAME:-akshayshanker}"
AUTHOR_EMAIL="${GIT_AUTHOR_EMAIL:-akshayshanker@users.noreply.github.com}"
if [ -n "${GITHUB_ACTIONS:-}" ]; then
  AUTHOR_NAME="github-actions[bot]"
  AUTHOR_EMAIL="41898282+github-actions[bot]@users.noreply.github.com"
fi
git -c user.name="$AUTHOR_NAME" -c user.email="$AUTHOR_EMAIL" \
  commit -m "Publish DP-cat slides to GitHub Pages"
if [ -n "${GITHUB_TOKEN:-}" ] && [ -n "${GITHUB_REPOSITORY:-}" ]; then
  git remote add origin "https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
else
  git remote add origin "$(cd "$ROOT" && git remote get-url origin)"
fi
git push -f origin gh-pages
echo "Pushed gh-pages. Site: https://akshayshanker.github.io/DP-cat/"
