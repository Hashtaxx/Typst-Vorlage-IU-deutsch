# Typst IU Vorlage

Diese Vorlage ist ein inoffizielles Community-Projekt und steht in keiner Verbindung zur IU Internationalen Hochschule
(keine Beauftragung, keine Unterstützung, keine offizielle Vorlage).
„IU“ sowie ggf. weitere Bezeichnungen können Marken der jeweiligen Rechteinhaber sein.

Diese Vorlage orientiert sich an den Formatvorgaben der IU Internationalen Hochschule für wissenschaftliche Arbeiten (Deutsch). Sie nutzt [Typst](https://typst.app/) als Textsatzsystem mit dem Plugin [Glossarium](https://typst.app/universe/package/glossarium) für das Abkürzungsverzeichnis.
Um das Literaturverzeichnis korrekt darzustellen, wird [Zotero](https://www.zotero.org/) in Kombination mit dem Plugin [Better BibTeX for Zotero](https://retorque.re/zotero-better-bibtex/) empfohlen.

---

## Lizenz

Dieses Projekt ist lizenziert unter:
- **MIT-Lizenz** für die Typst-Logik (alle Dateien außer `.csl`).
- **CC BY-SA 3.0** für die angepasste APA-Zitationsdatei (`.csl`).

Details findest du in der [LICENSE](LICENSE)-Datei.

---

## Haftungsausschluss

Es gelten die Richtlinien für schriftliche Prüfungsformen sowie der Zitierleitfaden der IU Internationalen Hochschule. Für die Korrektheit der Vorlage wird keine Verantwortung oder Haftung übernommen.

---

## Übersicht

- [Installation](#installation)
- [Anwendung](#anwendung)
- [Zotero](#zotero)

## Installation

1. [Typst](https://typst.app/) installieren (lokal über die [CLI](https://github.com/typst/typst) oder online über die [Web-App](https://typst.app/)).
2. Dieses Repository herunterladen oder mit "use this template" klonen.
3. Die Schriftart **Arial** muss auf dem System installiert sein (unter Linux z. B. via `ttf-mscorefonts-installer` bei Debian/Ubuntu).

## Anwendung

### Allgemein

Der gesamte Inhalt der Arbeit wird in `main.typ` geschrieben – dort werden Titelblatt-Daten, Text, Anhang und Glossareinträge gepflegt. Dieselbe Datei dient auch zur Vorschau und zum Export. Verzeichnisse (Inhalts-, Abbildungs-, Tabellen- und Abkürzungsverzeichnis) werden automatisch erstellt.

### Projektstruktur

| Datei / Ordner | Beschreibung |
| --- | --- |
| `main.typ` | **Einzige Arbeitsdatei** – Titelblatt-Daten, Inhalt, Anhang, Glossar, Vorschau & Export |
| `template/template.typ` | Formatierungsvorlage (Schrift, Abstände, Überschriften etc.) |
| `template/structure.typ` | Dokumentstruktur (Titelblatt, Verzeichnisse, Seitennummerierung) |
| `template/titelblatt.typ` | Titelblatt-Layout |
| `bib/literatur.bib` | Literaturverzeichnis (aus Zotero exportiert) |
| `csl/` | Zitierstile (APA 7 / IU-Anpassung) |
| `img/` | Bilder und Logo |
| `scripts/` | Zotero-Postscript |

## Logo
Aus rechtlichen Gründen wird kein IU-Logo mitgeliefert.

Wenn du ein eigenes Logo verwenden möchtest, lege es als `img/logo.jpg` ab.

### Kurzanleitung Typst-Syntax

Die wichtigsten Formatierungen für den Body in `main.typ`:

```typst
= Level 1 Überschrift
== Level 2 Überschrift

- Aufzählung (ungeordnet)
  - Verschachtelt
+ Nummerierte Aufzählung

_kursiver Text_
*fetter Text*
$Mathematische Ausdrücke$

// Zitieren
@quelle-key             // Autorenname (Jahr)
@quelle-key[S.~1--3]    // Autorenname (Jahr, S. 1–3)
#cite(<quelle-key>)     // Für mehr Einstellungen

// Verweise auf Anhang, Glossar, Abbildungen
@verweis-key
```

<details>
<summary><b>Abbildungen und Tabellen beschriften</b></summary>

Mit der Funktion `qfigure(content, [caption], [Quelle])` können Abbildungen und Tabellen korrekt beschriftet werden:

```typst
// Abbildung
#qfigure(
  image("/img/beispiel.jpg"),
  [Beschreibung der Abbildung],
  [Eigene Darstellung]
)<bild-key>

// Tabelle
#qfigure(
  table(columns: 2, [Zelle 1], [Zelle 2]),
  [Beschreibung der Tabelle],
  [Eigene Darstellung]
)<tabelle-key>
```
</details>

<details>
<summary><b>Anhang nutzen</b></summary>

Anhänge werden im `anhang`-Block in `main.typ` mit `qfigure` eingefügt:

```typst
#qfigure(
  image("/img/IU_logo.jpg"),
  [IU Logo],
  [Quelle]
)<iu_logo>
```
</details>

<details>
<summary><b>Glossar nutzen</b></summary>

Abkürzungen werden über das [Glossarium](https://typst.app/universe/package/glossarium)-Plugin verwaltet. Die Einträge werden in `main.typ` in der Liste `entry-list` definiert und können im Text mit `@abkürzung` referenziert werden. Das Abkürzungsverzeichnis wird nur angezeigt, wenn mindestens ein Eintrag referenziert wurde.

```typst
// Definition in entry-list:
(
  key: "ki",
  short: "KI",
  long: "Künstliche Intelligenz",
),

// Nutzung im Text:
@ki       // → KI
@ki:pl    // → KIs (Plural)
@ki:long  // → Künstliche Intelligenz
```
</details>

Weiterführende Links:
- [Typst Tutorial](https://typst.app/docs/tutorial/)
- [Image-Dokumentation](https://typst.app/docs/reference/visualize/image/)
- [Table-Dokumentation](https://typst.app/docs/reference/model/table/)
- [Mathe-Notation](https://typst.app/docs/reference/math/)


## Zotero (optional)

[Zotero](https://www.zotero.org/) ist ein kostenloses, quelloffenes Literaturverwaltungsprogramm, mit dem Quellen gesammelt, organisiert und zitiert werden können. Für das Literaturverzeichnis wird Zotero mit [Better BibTeX](https://retorque.re/zotero-better-bibtex/) empfohlen. Die `.bib`-Datei kann aber auch manuell gepflegt werden.

<details>
<summary><b>Schnellstart</b></summary>

1. [Zotero](https://www.zotero.org/download/) herunterladen und installieren.
2. Better BibTeX in Zotero installieren.
3. `scripts/zotero-postscript.js` in den Better-BibTeX-Postscript-Bereich kopieren.
4. Bibliothek/Sammlung als **Better BibLaTeX** nach `bib/literatur.bib` exportieren.

</details>

<details>
<summary><b>Ausführliche Anleitung</b></summary>

### 1. Zotero installieren

1. [Zotero](https://www.zotero.org/download/) herunterladen und installieren.
2. Optional: Den [Zotero Connector](https://www.zotero.org/download/connectors) als Browsererweiterung installieren (verfügbar für Chrome, Firefox und Safari). Damit lassen sich Quellen direkt aus dem Browser in die Zotero-Bibliothek übernehmen.

### 2. Better BibTeX für Zotero installieren

1. [Better BibTeX](https://retorque.re/zotero-better-bibtex/installation/) herunterladen (`.xpi`-Datei).
2. In Zotero: **Werkzeuge → Add-ons → Zahnrad-Symbol → Add-on aus Datei installieren** und die `.xpi`-Datei auswählen.
3. Zotero neu starten.

### 3. Postscript in Zotero kopieren

Das Postscript sorgt dafür, dass Namensfelder, Organisationsautoren und bestimmte Referenztypen korrekt für die IU-Zitierweise exportiert werden.

1. In Zotero: **Bearbeiten → Einstellungen → Better BibTeX → Export → Postscript**.
2. Den gesamten Inhalt von `scripts/zotero-postscript.js` in das Postscript-Feld einfügen und speichern.

### 4. Literatur exportieren

1. In Zotero die gewünschte Sammlung oder Bibliothek auswählen.
2. **Rechtsklick → Sammlung exportieren** (oder **Datei → Bibliothek exportieren**).
3. Als Format **Better BibLaTeX** wählen.
4. Die exportierte `.bib`-Datei als `bib/literatur.bib` in das Projektverzeichnis speichern (vorhandene Datei ersetzen).

</details>

<details>
<summary><b>Relevante Felder je Eintragsart in Zotero</b></summary>

Nur die hier gelisteten Felder werden für die korrekte Zitierung benötigt.

#### Zeitschriftenartikel

| Zotero-Feld | IU-Feld / Vorgabe |
| --- | --- |
| Autor | Name, Vorname |
| Datum | Jahr |
| Titel | Titel: Untertitel |
| Publikation | Name Zeitschrift / Proceedings of … |
| Band | Jahrgang, Volume, Band |
| Ausgabe | Heft, Nummer, Issue |
| Seiten | erste Seite–letzte Seite; bei Artikeln: Artikelnummer |
| DOI / URL | |

#### Zeitungsartikel

| Zotero-Feld | IU-Feld / Vorgabe |
| --- | --- |
| Autor | Name, Vorname |
| Datum | Vollständiges Datum |
| Titel | Titel: Untertitel |
| Verlag | Name der Zeitung |
| Seiten | erste Seite–letzte Seite |
| DOI / URL | |

#### Buch

| Zotero-Feld | IU-Feld / Vorgabe |
| --- | --- |
| Autor | Name, Vorname |
| Übersetzer | Name, Vorname |
| Datum | Jahr |
| Titel | Titel: Untertitel |
| Auflage | Auflage (nur wenn > 1) |
| Verlag | Verlag |
| DOI / URL | |
| extra | Original veröffentlicht {year} |

#### Buchteil

##### Buchbeitrag / Buchteil

| Zotero-Feld | IU-Feld / Vorgabe |
| --- | --- |
| Autor | Name, Vorname |
| Herausgeber | Name, Vorname |
| Datum | Jahr |
| Titel | Titel des Beitrags: Untertitel des Beitrags |
| Buchtitel | Titel des Sammelwerks: Untertitel des Sammelwerks |
| Auflage | Auflage (nur wenn > 1) |
| Seiten | erste Seite–letzte Seite |
| Verlag | Verlag |
| DOI / URL | |

##### Sammelwerk

| Zotero-Feld | IU-Feld / Vorgabe |
| --- | --- |
| Herausgeber | Name, Vorname |
| Datum | Jahr |
| Titel | Titel des Sammelwerks: Untertitel des Sammelwerks |
| Auflage | Auflage (nur wenn > 1) |
| Verlag | Verlag |
| DOI / URL | |

#### Webseite

##### Internetquelle mit Autor:in

| Zotero-Feld | IU-Feld / Vorgabe |
| --- | --- |
| Autor | Name, Vorname |
| Datum | Vollständiges Datum |
| Titel | Titel: Untertitel |
| Titel der Website | Institution oder Website |
| DOI / URL | |

##### Internetquelle mit Institution als Autor:in

| Zotero-Feld | IU-Feld / Vorgabe |
| --- | --- |
| Autor | Institution |
| Datum | Vollständiges Datum |
| Titel | Titel: Untertitel |
| Titel der Website | Website |
| DOI / URL | |

#### Schriftliche Arbeiten

##### Dissertation

| Zotero-Feld | IU-Feld / Vorgabe |
| --- | --- |
| Autor | Name, Vorname |
| Datum | Jahr |
| Titel | Titel: Untertitel |
| Art | Dissertation |
| Universität | Name der Universität |
| Ort | Verlag oder Datenbank |

> Das Postscript setzt die Universität automatisch als Verlag und wandelt den Typ `phdthesis` in „Dissertation" um.

##### Eigene schriftliche Arbeit an der IU

| Zotero-Feld | IU-Feld / Vorgabe |
| --- | --- |
| Autor | Name, Vorname |
| Datum | Jahr |
| Titel | Titel: Untertitel |
| Art | unveröffentlichte Arbeit |
| Ort | IU Internationale Hochschule |

</details>