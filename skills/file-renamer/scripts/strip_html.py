#!/usr/bin/env python3
"""
strip_html.py -- strip browser/formatting cruft from a saved-webpage HTML dump
so the remaining file is small enough (and clean enough) to read for content
identification / data extraction, and to file as the permanent record in place
of the raw original (see the filing note in file-renamer's SKILL.md -- only
the cleaned version gets kept in the archive).

Intended home: file-renamer/scripts/strip_html.py (drop it into the skill's
own folder as a bundled resource, then point Step 3's HTML-dump section at
`scripts/strip_html.py` instead of the embedded-and-extracted copy).

What it does, in order:
  1. Drops <script>, <style>, <link>, <noscript>, <svg>, <template>, <head>,
     comments. (The sibling "_files/" asset folder some browsers save next to
     the .html is never touched -- this script only reads/writes the one
     .html file you point it at.)
  2. Strips every attribute except a small whitelist needed to keep tables
     and links meaningful: href, src (on <img> only), colspan, rowspan,
     scope, alt.
  3. Removes attribute-only cruft like data-*, aria-*, on*, class, id,
     style, role, tabindex, jsaction -- anything not in the whitelist above.
  4. Iteratively unwraps "pass-through" wrapper tags: any non-protected tag
     (plain divs/spans as well as custom web-component tags like <sdps-*>,
     <app-*>, <slot-fb> that modern bank/broker sites render with) whose only
     content is a single child element with no text of its own gets replaced
     by that child. Repeats until stable, since these dumps commonly nest
     5-15+ layers of single-child wrappers around one real value.
  5. Drops now-empty tags (no text anywhere inside, no <img>/<a>/<table>).
  6. Pretty-prints the result.

Usage:
    python3 strip_html.py input.html [output.html]

If output.html is omitted, writes "<input>.clean.html" next to the input.
Prints a before/after size summary to stderr.

Tested against a real multi-megabyte brokerage "Account Summary" browser
dump: reduced by roughly 90% while keeping every real number, label, and
table row intact -- verified by diffing the visible text before/after.
"""
import sys
import re
from bs4 import BeautifulSoup, Comment, NavigableString

ATTR_WHITELIST = {"href", "src", "colspan", "rowspan", "scope", "alt"}

# Tags that are pure noise and get removed outright, with their contents.
DROP_TAGS = ["script", "style", "link", "noscript", "svg", "template",
             "head", "iframe", "meta", "path", "picture", "source"]

# Tags that must never be unwrapped, even as a single-child pass-through,
# because collapsing them would lose real structure or interactivity.
# Everything else -- including custom web-component tags like <sdps-number>,
# <app-page-header>, <slot-fb> that modern bank/broker sites render with --
# is treated as an unwrappable "div-equivalent" if it's just passing through
# one child with no text of its own. That covers the bulk of what these
# framework-heavy account-activity dumps are made of.
PROTECTED_TAGS = {"html", "body", "table", "thead", "tbody", "tfoot", "tr",
                   "td", "th", "a", "img", "button", "input", "select",
                   "option", "textarea", "time", "ul", "ol", "li"}


def strip_attrs(soup):
    for tag in soup.find_all(True):
        if not tag.attrs:
            continue
        keep = {}
        for k, v in tag.attrs.items():
            kl = k.lower()
            if kl == "src" and tag.name != "img":
                continue
            if kl in ATTR_WHITELIST:
                keep[k] = v
        tag.attrs = keep


def drop_noise_tags(soup):
    for tagname in DROP_TAGS:
        for t in soup.find_all(tagname):
            t.decompose()
    for c in soup.find_all(string=lambda s: isinstance(s, Comment)):
        c.extract()


def is_effectively_empty(tag):
    """True if tag has no visible text and no meaningful leaf content."""
    if tag.find(["img", "table", "a", "input", "br", "hr"]):
        return False
    text = tag.get_text(strip=True)
    return text == ""


def unwrap_single_child_wrappers(soup):
    """Repeatedly collapse any non-protected tag that only passes through one
    child element with no text of its own directly inside it."""
    changed = True
    passes = 0
    while changed and passes < 40:  # safety cap
        changed = False
        passes += 1
        for tag in soup.find_all(True):
            if tag.name in PROTECTED_TAGS:
                continue
            if tag.attrs:  # keep wrappers that still carry a whitelisted attr (rare)
                continue
            children = [c for c in tag.contents]
            elem_children = [c for c in children if not isinstance(c, NavigableString)]
            text_children = [c for c in children
                              if isinstance(c, NavigableString) and c.strip()]
            if len(elem_children) == 1 and not text_children:
                tag.replace_with(elem_children[0])
                changed = True


def drop_empty_tags(soup):
    changed = True
    passes = 0
    while changed and passes < 25:
        changed = False
        passes += 1
        for tag in soup.find_all(True):
            if tag.name in ("html", "body", "table", "tr", "td", "th"):
                continue
            if is_effectively_empty(tag):
                tag.decompose()
                changed = True


def clean(html_text):
    soup = BeautifulSoup(html_text, "lxml")
    drop_noise_tags(soup)
    strip_attrs(soup)
    drop_empty_tags(soup)
    unwrap_single_child_wrappers(soup)
    drop_empty_tags(soup)
    return soup.prettify()


def main():
    if len(sys.argv) < 2:
        print(__doc__)
        sys.exit(1)
    in_path = sys.argv[1]
    out_path = sys.argv[2] if len(sys.argv) > 2 else re.sub(
        r"\.html?$", ".clean.html", in_path, flags=re.IGNORECASE)

    with open(in_path, "r", encoding="utf-8", errors="ignore") as f:
        raw = f.read()

    cleaned = clean(raw)

    with open(out_path, "w", encoding="utf-8") as f:
        f.write(cleaned)

    before = len(raw.encode("utf-8"))
    after = len(cleaned.encode("utf-8"))
    pct = 100 * (1 - after / before) if before else 0
    print(f"[strip_html] {in_path}", file=sys.stderr)
    print(f"  before: {before:,} bytes", file=sys.stderr)
    print(f"  after:  {after:,} bytes  ({pct:.1f}% smaller)", file=sys.stderr)
    print(f"  wrote:  {out_path}", file=sys.stderr)


if __name__ == "__main__":
    main()
