"""Mechanical overflow check for a Marp deck.
Renders two variants: (a) footnote hidden, (b) body hidden; measures ink rows per page
at 96 dpi (1280x720). Reports pages where the body's lowest ink is within GAP px of the
footnote's highest ink, or below the bottom padding when there is no footnote."""
import sys, os, subprocess, glob, shutil
import numpy as np
from PIL import Image
deck, theme, out = sys.argv[1], sys.argv[2], sys.argv[3]
GAP = 14           # minimum clearance between body ink and footnote ink, px
BOTTOM = 720 - 84  # bottom padding line of the theme (section padding-bottom 84/88)
os.makedirs(out, exist_ok=True)
base = open(theme, encoding="utf-8").read()
variants = {
 "body": base + "\nsection .footnote { visibility: hidden !important; } section::after { visibility: hidden !important; }\n",
 "foot": base + "\nsection > *:not(.footnote) { visibility: hidden !important; } section::after { visibility: hidden !important; }\n",
}
res = {}
for name, css in variants.items():
    tpath = os.path.join(out, "theme-%s.css" % name); open(tpath, "w", encoding="utf-8").write(css)
    pdf = os.path.join(out, "%s.pdf" % name)
    subprocess.run(["marp", "--no-stdin", deck, "--theme-set", tpath, "-o", pdf, "--allow-local-files", "--html"],
                   stdin=subprocess.DEVNULL, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, check=True)
    for f in glob.glob(os.path.join(out, "%s-*.png" % name)): os.remove(f)
    subprocess.run(["pdftoppm", "-r", "96", "-png", pdf, os.path.join(out, name)], check=True)
    pages = sorted(glob.glob(os.path.join(out, "%s-*.png" % name)))
    rows = []
    for p in pages:
        a = np.asarray(Image.open(p).convert("L")).copy()
        h, w = a.shape
        if np.median(a) < 128:   # dark title slide: skip
            rows.append(None); continue
        a[650:, 1080:] = 255       # mask the page number at bottom right
        ink = (a < 200).sum(axis=1)
        body_rows = np.where(ink > 0)[0]
        rows.append((int(body_rows.min()) if len(body_rows) else None, int(body_rows.max()) if len(body_rows) else None))
    res[name] = rows
bad = []
for i, (b, f) in enumerate(zip(res["body"], res["foot"]), start=1):
    if b is None or b[1] is None or f is None: continue
    body_bottom = b[1]
    foot_top = f[0] if (f is not None and f[0] is not None) else None
    limit = (foot_top - GAP) if foot_top is not None else BOTTOM
    if body_bottom > limit:
        bad.append((i, body_bottom, foot_top, limit))
for i, bb, ft, lim in bad:
    print("page %2d: body ends at y=%d, footnote starts at %s, limit %d  -> OVERFLOW by %d px" % (i, bb, ft, lim, bb - lim))
print("checked %d pages, %d overflow" % (len(res["body"]), len(bad)))
