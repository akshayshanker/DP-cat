# DP-cat

Slide decks on categorical types, type theory, and dynamic programming.

**Site:** [akshayshanker.github.io/DP-cat](https://akshayshanker.github.io/DP-cat/)

## Decks

| Deck | Source |
|------|--------|
| [Categorical types and AGI](https://akshayshanker.github.io/DP-cat/categorical-types-and-agi/) | `Categorical types and AGI -1.md` |
| [Session 01 — motivation](https://akshayshanker.github.io/DP-cat/session-01-motivation/) | `talks/session-01-motivation/deck.md` |

## Local preview

```bash
marp "Categorical types and AGI -1.md" -o /tmp/agi.html --allow-local-files
marp talks/session-01-motivation/deck.md -w
```

After editing a deck, rebuild the Pages HTML:

```bash
bash scripts/build-pages.sh
```

Reading-group notes, session sheets, and `CLAUDE.md` stay in the local vault (gitignored) and are not in this repository.
