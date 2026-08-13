#!/usr/bin/env python3
"""Fail when required Pages files or local image references are missing."""

from html.parser import HTMLParser
from pathlib import Path
from urllib.parse import unquote, urlsplit


class ImageSourceParser(HTMLParser):
    def __init__(self) -> None:
        super().__init__()
        self.sources: list[str] = []
        self.links: list[str] = []

    def handle_starttag(
        self, tag: str, attrs: list[tuple[str, str | None]]
    ) -> None:
        values = dict(attrs)
        if tag == "img":
            source = values.get("src")
            if source:
                self.sources.append(source)
        elif tag == "a":
            link = values.get("href")
            if link:
                self.links.append(link)


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

    pdf_link = "categories-and-functors/categories-and-functors.pdf"
    pdf = site / pdf_link
    index_parser = ImageSourceParser()
    index_parser.feed((site / "index.html").read_text(encoding="utf-8"))
    if not pdf.is_file():
        print(f"missing required PDF: {pdf.relative_to(site)}")
        return 1
    if pdf_link not in index_parser.links:
        print(f"index.html: missing link to {pdf_link}")
        return 1

    obsolete_deck = "session-01-motivation"
    if (site / obsolete_deck).exists():
        print(f"obsolete deck remains in published output: {obsolete_deck}")
        return 1
    if any(obsolete_deck in link for link in index_parser.links):
        print(f"index.html: obsolete deck remains linked: {obsolete_deck}")
        return 1

    print("All local image references and the single linked PDF resolve.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
