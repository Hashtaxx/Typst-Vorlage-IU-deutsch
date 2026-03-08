#import "template/template.typ": conf as template, qfigure, abk_print_entry
#import "@preview/glossarium:0.5.10": make-glossary, register-glossary, print-glossary, gls, glspl
#import "template/titelblatt.typ": titelblatt
#import "content.typ": titel, pruefungsform, kursname, studiengang, author, matrikel, betreuertyp, betreuer, date, body, anhang, pagebreak_b4_abbildungsv, pagebreak_b4_glossar, pagebreak_b4_tabellenv, entry-list

#show: template.with()
#show: make-glossary
#register-glossary(entry-list)


// Metainformationen
#set document(
	title: if titel == "" { kursname } else { titel },
	author: author,
	description: pruefungsform,
	date: date,
)

// ── Titelblatt ───────────────────────────────────────────
#set page(numbering: none)
#titelblatt(
	pruefungsform: pruefungsform,
	kursname: kursname,
	studiengang: studiengang,
	titel: titel,
	author: author,
	matrikel: matrikel,
	betreuertyp: betreuertyp,
	betreuer: betreuer,
	date: date,
)

// ── Inhaltsverzeichnis & Abbildungsverzeichnis ───────────
#set page(numbering: "I")
#outline()

// Anzeige ab 3 Abbildungen
#context if query(figure.where(kind: image)).len() >= 3 {
	if pagebreak_b4_abbildungsv { pagebreak() } else { v(6pt) }
	outline(title: heading(level: 1, outlined: true, numbering: none)[Abbildungsverzeichnis], target: figure.where(kind: image))
}

// Anzeige ab 3 Tabellen
#context if query(figure.where(kind: table)).len() >= 3 {
	if pagebreak_b4_tabellenv { pagebreak() } else { v(6pt) }
	outline(title: heading(level: 1, outlined: true, numbering: none)[Tabellenverzeichnis], target: figure.where(kind: table))
}

// Anzeige ab 1 referenziertem Glossareintrag
#let has-gloss-ref(key) = {
	let cap = upper(key.first()) + key.slice(1)
	let labels = (
		key,
		cap,
		key + ":pl",
		cap + ":pl",
		key + ":short",
		key + ":long",
	)
	labels.any(lbl => query(ref.where(target: label(lbl))).len() > 0)
}

#if entry-list.len() > 0 {
	context {
		let used = entry-list.filter(e => has-gloss-ref(e.at("key")))
		if used.len() > 0 {
			if pagebreak_b4_glossar { pagebreak() }
			heading(numbering: none, outlined: true)[Abkürzungsverzeichnis]
		}
	}

	print-glossary(
		entry-list,
		user-print-gloss: abk_print_entry,
	)
}

#pagebreak()

// ── Body ─────────────────────────────────────────────────
#set page(numbering: "1")
#counter(page).update(1)

#body

// ── Quellenverzeichnis ───────────────────────────────────
// Inspiriert von @yemouus Code (GitHub)
#show bibliography: bib-it => {
	set block(inset: 0in)
	show block: block-it => context {
		if block-it.body == auto {
			block-it
		} else {
			if block-it.body.func() != [].func() {
				block-it.body
				parbreak()
			} else {
				par(block-it.body)
			}
		}
	}
	
	bib-it
}

/* TODO:
- Podcast fehlt Rolle, Episodennummer sollte kein Präfix haben, Typ wird nicht angezeigt
- Filmen fehlt die Rolle
*/

#show bibliography: it => context if query(cite).len() > 0 { pagebreak(); it }
#bibliography(
	"bib/literatur.bib",
	title: "Literaturverzeichnis",
	style: "/csl/apa7-iu.csl"
)

// ── Anhangsverzeichnis ───────────────────────────────────
#context if query(figure.where(kind: "anhang")).len() > 1 {
	pagebreak()
	outline(title: heading(level: 1, outlined: true, numbering: none)[Anhangsverzeichnis], target: figure.where(kind: "anhang"))
}

#show outline.entry: it => link(
	it.element.location(),
	it.indented(it.prefix(), it.inner()),
)

#context if query(figure.where(kind: "anhang")).len() > 0 {
	pagebreak()
}

#anhang