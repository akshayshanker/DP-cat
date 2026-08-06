#!/usr/bin/env python3
"""Fail when generated Pages HTML refers to a missing local image."""

from html.parser import HTMLParser
from pathlib import Path
from urllib.parse import unquote, urlsplit


class ImageSourceParser(HTMLParser):
    def __init__(self) -> None:
        super().__init__()
        self.sources: list[str] = []

    def handle_starttag(
        self, tag: str, attrs: list[tuple[str, str | None]]
    ) -> None:
        if tag != "img":
            return
        source = dict(attrs).get("src")
        if source:
            self.sources.append(source)


def missing_images(site: Path) -> list[tuple[Path, str]]:
    missing: list[tuple[Path, str]] = []
    for page in site.rglob("*.html"):
        parser = ImageSourceParser()
        parser.feed(page.read_text(encoding="utf-8"))
        for source in parser.sources:
            parsed = urlsplit(source)
            if parsed.scheme or source.startswith(("/", "data:")):
                continue
            target = page.parent / unquote(parsed.path)
            if not target.is_file():
                missing.append((page, source))
    return missing


def main() -> int:
    site = Path(__file__).resolve().parents[1] / "docs"
    missing = missing_images(site)
    if missing:
        for page, source in missing:
            print(f"{page.relative_to(site)}: missing {source}")
        return 1
    print("All local image references resolve.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
