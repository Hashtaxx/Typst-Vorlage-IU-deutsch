#import "template/template.typ": qfigure
#import "@preview/glossarium:0.5.10": gls, glspl, make-glossary, print-glossary, register-glossary

// Daten für Titelblatt eingeben
// Bei leerem Titel wird Kursname fett gedruckt
#let titel = ""
#let pruefungsform = "Z. B. Seminararbeit"
#let kursname = "Methoden der Einzel- und Gruppenberatung"
#let studiengang = "Soziale Arbeit"
#let author = "Max Mustermann"
#let matrikel = "123456"
#let betreuertyp = "Betreuende Person/ Tutor:in"
#let betreuer = "Prof. Dr. Simone Musterfrau"
#let date = datetime.today()

// Manuelle Seitenumbrüche vor Verzeichnissen
#let pagebreak_b4_abbildungsv = false
#let pagebreak_b4_tabellenv = false
#let pagebreak_b4_glossar = false

// Hier Text schreiben
#let body = [
	// ── BODY START ────────────────────────────────────────────────
	
	
	// ── BODY END ──────────────────────────────────────────────────
]

#let _qfigure = qfigure
#let anhang = [
	#set figure(kind: "anhang")
	#let qfigure(content, cap, src, kind: "anhang") = _qfigure(content, cap, src)
	#show figure.where(kind: "anhang"): set block(above: 1em + 12pt)
	// ── Anhang ────────────────────────────────────────────────────

	//	Beispiel:
	//	#qfigure(
	//		image("/img/IU_logo.jpg"),
	//		[IU Logo],
	//		[Quelle]
	//	)<iu_logo>
	 // 

]

#let entry-list = (
  // ── Glossar ───────────────────────────────────────────────────
  // Beispiel:
  // (
  //   key: "ki",
  //   short: "KI",
  //   plural: "KIs",
  //   long: "Künstliche Intelligenz",
  //   longplural: "Künstliche Intelligenzen",
  // ),
  // Nutzung: @ki, @ki:pl, @Ki, @Ki:pl, @ki:short, @ki:long
  // Doku: https://typst.app/universe/package/glossarium
)
