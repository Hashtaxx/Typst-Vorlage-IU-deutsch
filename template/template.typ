

// ── Titelseiten-Klassen ───────────────────────────────────────────────────────
#let leading = 1em

/// Erstellt eine Abbildung oder Tabelle mit Quellenangabe unterhalb des Inhalts.
///
/// ```typst
/// #qfigure(image("/img/bild.jpg"), [Beschreibung], [Quelle])<key>
/// ```
///
/// - content (content): Der anzuzeigende Inhalt (z.B. `image("....jpg",args)` oder `table([..][..])`).
/// - caption (String): Beschriftung der Abbildung/Tabelle.
/// - source (String): Quellenangabe, wird unter dem Inhalt angezeigt.
#let qfigure(content, caption, source) = figure(
  stack(
    content, v(6pt),
    align(
      left,
      text(
        size: 10pt,
      )[Quelle: #source]
    )
  ),
  caption: caption
)

#let anhang(body) = {
  show figure: set figure(kind: "anhang")
  body
}

#let conf(doc) = {
  // ── Allgemeine Stile ────────────────────────────────────────────────────
  set page(
    paper: "a4",
    margin: (top: 2cm, bottom: 2cm, left: 2cm, right: 2cm),
    numbering: "I",
    number-align: center + bottom,
  )
  
  set text(
    font: "Arial",
    size: 11pt,
    fill: black,
    hyphenate: true,
    lang: "de",
  )
  
  set par(
    justify: true,
    leading: leading,
    spacing: leading + 6pt,
    linebreaks: "optimized",
  )
  
  set list(marker: ([•], [•], [•]))
  
// Alte Überschriften bis April 2026
  set heading(numbering: "1.1.1")
  show heading: it => {
    set align(left)
    set text(size: 12pt, weight: "bold")
    set block(above: 1em + 12pt, below: 1em + 12pt)
    it
  }
  
  // Neue Überschriftenformatierung ab April 2026
  // ───────────────────────────────────────────────────────
  // show heading: it => {
  //   set align(left)
  //   set text(weight: "bold")
  //   set block(above: 1em + 12pt)
  //   it
  // }
  // show heading.where(level: 1): it => {
  //   set text(size: 16pt)
  //   set block(below: 1em + 12pt)
  //   it
  // }
  // 
  // show heading.where(level: 2): it => {
  //   set text(size: 14pt)
  //   set block(below: 1em + 6pt)
  //   it
  // }
  // 
  // show heading.where(level: 3): it => {
  //   set text(size: 11pt)
  //   set block(below: 1em + 6pt)
  //   it
  // }
  // 
  // => Auch Anhang von 12 > 16pt erhöhen in Zeile 109 

  // ── Fußnoten ───────────────────────────────────────────────
  show footnote.entry: set text(font: "Arial", size: 10pt)
  show footnote.entry: set par(justify: true)
  
  // ── Inhaltsverzeichnis ──────────────────────────────────────
  show outline.entry.where(level: 1): set text(weight: "bold")
  show outline.entry.where(level: 1): set block(above: 1em + 6pt)

  // ── Abbildungs- und Tabellenbeschriftungen
  show figure: it => { 
    set figure.caption(position: top); 
    set align(left); 
    it 
  }

  show figure.caption: set text(size: 11pt)
  show figure.where(kind: image): set figure(supplement: "Abb.")
  show figure.where(kind: table): set figure(supplement: "Tab.")
  show figure.where(kind: "anhang"): set figure(
    supplement: "Anhang", 
    numbering: "A"
  )

  show figure.caption.where(kind: "anhang"): it => heading(level: 1, numbering: none, outlined: false)[#it]

  // ── Abbildungs- und Tabellenverzeichnis  
  show outline.where(target: figure.where(kind: image)): it => {
    show outline.entry: set text(weight: "regular")
    show outline.entry: set block(above: 1em)
    it
  }
  show outline.where(target: figure.where(kind: table)): it => {
    show outline.entry: set text(weight: "regular")
    show outline.entry: set block(above: 1em)
    it
  }
  // ── Literaturverzeichnis ────────────────────────────────────
  show bibliography: set par(
    hanging-indent: 1.27cm,
    justify: false,
  )

  // ── Anhang ──────────────────────────────────────────────────
  show outline.where(target: figure.where(kind: "anhang")): it => {
    show outline.entry: set text(weight: "regular")
    show outline.entry: set block(above: 1.5em)
    show outline.entry: it => link(
      it.element.location(),
      it.indented(it.prefix() + [:], it.body()),
    )
    it
  }
  doc

}

// ── Abkürzungsverzeichnis-Stil (zentral anpassbar) ─────────────────────────
#let abk_short_width = 2cm

// Benutzerdefinierte Darstellung für eine Glossarzeile (links: Kurzform, rechts: Langform).
#let abk_print_entry(
  entry,
  show-all: false,
  disable-back-references: false,
  deduplicate-back-references: false,
  minimum-refs: 1,
  description-separator: ": ",
  user-print-title: none,
  user-print-description: none,
  user-print-back-references: none,
) = {
  let key = entry.at("key")
  let cap = upper(key.first()) + key.slice(1)
  // Zählt alle unterstützten Kurzverweise, die einen Eintrag als verwendet markieren.
  let labels = (key, cap, key + ":pl", cap + ":pl", key + ":short", key + ":long")
  let refs = labels.map(l => query(ref.where(target: label(l))).len()).sum()
  if show-all or refs >= minimum-refs {
    let short = if "short" in entry { entry.at("short") } else { key }
    let long = if "long" in entry { entry.at("long") } else { short }

    grid(
      columns: (abk_short_width, 1fr),
      column-gutter: 0.5em,
      short, long,
    )
  }
}