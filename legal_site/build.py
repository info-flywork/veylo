"""Veylo yasal sayfaları (fly-work.com/veylo/...) üretir.

Çıktı: legal_site/veylo/{about,privacy-policy,terms,cookies,csae}/index.html
Her sayfa tek dosya (CSS/JS gömülü), Türkçe + İngilizce, çerez/depolama yok.
Çalıştır: python3 legal_site/build.py
"""

from pathlib import Path

from content import PAGES  # noqa: E402  (aynı klasör)

ROOT = Path(__file__).parent / "veylo"
YEAR = "2026"
UPDATED = {"tr": "Son güncelleme: 20 Kasım 2026", "en": "Last updated: November 20, 2026"}
NAV = [
    ("about", {"tr": "Hakkında", "en": "About"}),
    ("privacy-policy", {"tr": "Gizlilik", "en": "Privacy"}),
    ("terms", {"tr": "Kullanım Koşulları", "en": "Terms"}),
    ("cookies", {"tr": "Çerezler", "en": "Cookies"}),
    ("csae", {"tr": "Çocuk Güvenliği", "en": "Child Safety"}),
]

TEMPLATE = """<!doctype html>
<html lang="tr">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>{title_tr} · Veylo</title>
<meta name="description" content="{desc}">
<meta name="robots" content="index,follow">
<meta name="theme-color" content="#7D37FD">
<style>
:root {{
  --ink: #1A1714; --muted: #636363;
  --purple: #7D37FD; --purple-deep: #5E35B4; --purple-soft: #EDE6FF;
  --purple-mid: #998FED; --line: #E5E5E5; --bg: #FAFAFC; --card: #FFFFFF;
  --warn-bg: #FEF9E8; --warn-line: #F0D48A;
}}
* {{ box-sizing: border-box; }}
html {{ -webkit-text-size-adjust: 100%; }}
body {{
  margin: 0; background: var(--bg); color: var(--ink);
  font: 16px/1.65 -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
}}
header {{
  position: relative; overflow: hidden;
  background:
    radial-gradient(ellipse 80% 70% at 8% -20%, rgba(125,55,253,.22), transparent 55%),
    radial-gradient(ellipse 60% 50% at 95% 0%, rgba(153,143,237,.28), transparent 50%),
    linear-gradient(180deg, #F3EEFF 0%, #EDE6FF 45%, var(--bg) 100%);
  border-bottom: 1px solid var(--line);
}}
.wrap {{ max-width: 820px; margin: 0 auto; padding: 0 20px; position: relative; }}
.top {{ display: flex; align-items: center; justify-content: space-between; gap: 12px; padding: 20px 0 8px; }}
.brand {{
  display: inline-flex; align-items: center; gap: 10px;
  font-weight: 800; font-size: 22px; letter-spacing: -.35px;
  text-decoration: none; color: var(--ink);
}}
.brand-mark {{
  width: 34px; height: 34px; border-radius: 10px;
  background: linear-gradient(135deg, #7B2FFF, var(--purple-mid));
  box-shadow: 0 4px 12px rgba(125,55,253,.28);
  position: relative; flex: 0 0 auto;
}}
.brand-mark::after {{
  content: ""; position: absolute; inset: 9px; border-radius: 50%;
  border: 2px solid rgba(255,255,255,.92); border-bottom-color: transparent;
  transform: rotate(-35deg);
}}
.brand em {{ font-style: normal; color: var(--purple); }}
.lang {{
  display: inline-flex; border: 1px solid var(--line); border-radius: 999px;
  overflow: hidden; background: rgba(255,255,255,.9); backdrop-filter: blur(6px);
}}
.lang button {{
  border: 0; background: transparent; padding: 6px 14px; font: inherit; font-size: 14px;
  cursor: pointer; color: var(--muted);
}}
.lang button[aria-pressed="true"] {{ background: var(--purple); color: #fff; }}
nav.pages {{ display: flex; flex-wrap: wrap; gap: 6px 16px; padding: 4px 0 18px; font-size: 14px; }}
nav.pages a {{ color: var(--muted); text-decoration: none; }}
nav.pages a.active {{
  color: var(--ink); font-weight: 700;
  border-bottom: 3px solid var(--purple); padding-bottom: 2px;
}}
main {{ padding: 28px 0 56px; }}
h1 {{ font-size: 30px; line-height: 1.2; margin: 0 0 6px; letter-spacing: -.4px; color: var(--ink); }}
.updated {{ color: var(--muted); font-size: 14px; margin: 0 0 24px; }}
h2 {{
  font-size: 20px; margin: 34px 0 8px; padding-top: 10px;
  border-top: 1px dashed var(--line); color: var(--ink);
}}
h3 {{ font-size: 16px; margin: 20px 0 4px; color: var(--purple-deep); }}
p, li {{ color: #2A2622; }}
ul {{ padding-left: 22px; }}
li {{ margin: 4px 0; }}
a {{ color: var(--purple); }}
a:hover {{ color: var(--purple-deep); }}
.note {{
  background: linear-gradient(180deg, #fff, #F7F3FF);
  border: 1px solid #D9CEF8; border-radius: 18px; padding: 16px 18px; margin: 16px 0;
  box-shadow: 0 8px 0 rgba(125,55,253,.04);
}}
.warn {{
  background: linear-gradient(180deg, #FFFCF3, var(--warn-bg));
  border: 1px solid var(--warn-line); border-radius: 18px; padding: 16px 18px; margin: 16px 0;
}}
table {{ width: 100%; border-collapse: collapse; margin: 12px 0; font-size: 15px; }}
th, td {{ text-align: left; vertical-align: top; padding: 10px 12px; border-bottom: 1px solid var(--line); }}
th {{ background: var(--purple-soft); font-weight: 700; color: var(--ink); }}
.table {{
  overflow-x: auto; border: 1px solid var(--line); border-radius: 16px;
  background: var(--card); box-shadow: 0 6px 0 rgba(26,23,20,.03);
}}
.table table {{ margin: 0; }}
.table th:first-child, .table td:first-child {{ padding-left: 14px; }}
footer {{
  border-top: 1px solid var(--line); color: var(--muted); font-size: 14px;
  padding: 22px 0 40px;
  background: linear-gradient(180deg, transparent, rgba(125,55,253,.06));
}}
[data-lang] {{ display: none; }}
html[lang="tr"] [data-lang="tr"], html[lang="en"] [data-lang="en"] {{ display: block; }}
@media (max-width: 560px) {{
  h1 {{ font-size: 25px; }}
  body {{ font-size: 15.5px; }}
  .brand {{ font-size: 19px; }}
}}
</style>
</head>
<body>
<header>
  <div class="wrap">
    <div class="top">
      <a class="brand" href="../about/"><span class="brand-mark" aria-hidden="true"></span>V<em>eylo</em></a>
      <div class="lang" role="group" aria-label="Language">
        <button type="button" data-set="tr" aria-pressed="true">Türkçe</button>
        <button type="button" data-set="en" aria-pressed="false">English</button>
      </div>
    </div>
    <nav class="pages">{nav}</nav>
  </div>
</header>
<main class="wrap">
  <section data-lang="tr">
    <h1>{title_tr}</h1>
    <p class="updated">{updated_tr}</p>
{body_tr}
  </section>
  <section data-lang="en">
    <h1>{title_en}</h1>
    <p class="updated">{updated_en}</p>
{body_en}
  </section>
</main>
<footer>
  <div class="wrap">
    <span data-lang="tr">© {year} Veylo · Fly Work. Tüm hakları saklıdır. İletişim: <a href="mailto:support@fly-work.com">support@fly-work.com</a></span>
    <span data-lang="en">© {year} Veylo · Fly Work. All rights reserved. Contact: <a href="mailto:support@fly-work.com">support@fly-work.com</a></span>
  </div>
</footer>
<script>
/* Dil: ?lang=en / #en ya da tarayıcı dili. Çerez veya yerel depolama kullanılmaz. */
(function () {{
  var q = new URLSearchParams(location.search).get('lang') || location.hash.replace('#', '');
  var nav = (navigator.language || 'tr').slice(0, 2).toLowerCase();
  var lang = (q === 'tr' || q === 'en') ? q : (nav === 'tr' ? 'tr' : 'en');
  function set(l) {{
    document.documentElement.lang = l;
    document.querySelectorAll('.lang button').forEach(function (b) {{
      b.setAttribute('aria-pressed', String(b.dataset.set === l));
    }});
    document.querySelectorAll('nav.pages a').forEach(function (a) {{
      a.textContent = a.dataset[l];
      a.href = a.getAttribute('href').split('?')[0] + '?lang=' + l;
    }});
    var t = document.querySelector('section[data-lang="' + l + '"] h1');
    if (t) document.title = t.textContent + ' · Veylo';
  }}
  document.querySelectorAll('.lang button').forEach(function (b) {{
    b.addEventListener('click', function () {{ set(b.dataset.set); }});
  }});
  set(lang);
}})();
</script>
</body>
</html>
"""


def build():
    for slug, page in PAGES.items():
        active = ' class="active"'
        nav = "".join(
            f'<a href="../{s}/" data-tr="{t["tr"]}" data-en="{t["en"]}"'
            f'{active if s == slug else ""}>{t["tr"]}</a>'
            for s, t in NAV
        )
        html = TEMPLATE.format(
            title_tr=page["title"]["tr"],
            title_en=page["title"]["en"],
            desc=page["desc"],
            nav=nav,
            updated_tr=UPDATED["tr"],
            updated_en=UPDATED["en"],
            body_tr=page["body"]["tr"],
            body_en=page["body"]["en"],
            year=YEAR,
        )
        out = ROOT / slug / "index.html"
        out.parent.mkdir(parents=True, exist_ok=True)
        out.write_text(html, encoding="utf-8")
        print("written", out)


if __name__ == "__main__":
    build()
