if (Translator.BetterBibLaTeX) {

	// Hilfsfunktion: Normalisiert ein Namensobjekt in das Format "family=X, given=Y"
	function normalizeName(nameObj) {
		let family = nameObj.family || '';
		let given	= nameObj.given	|| '';
		let prefix = nameObj.prefix || nameObj['dropping-particle'] || nameObj['non-dropping-particle'] || '';

		// Präfix mit Familienname zusammenführen
		if (prefix) {
			family = prefix + ' ' + family;
		}

		if (family && given) {
			return `family=${family}, given=${given}`;
		} else if (family) {
			return `family=${family}`;
		} else {
			return given;
		}
	}

	// @online: Wenn kein Autor vorhanden, aber Organisation existiert, Organisation als Autor verwenden
	// Muss VOR der Normalisierung laufen, damit der Überspringen-Flag gesetzt werden kann
	let organizationAsAuthor = false;
	if (reference.referencetype === 'online') {
		if (!tex.has.author) {
			if (tex.has.organization) {
				const orgName = tex.has.organization.value;
				tex.add({ name: 'author', value: `{{${orgName}}}`, raw: true });
				tex.remove('organization');
				organizationAsAuthor = true;
			}
		} else {
			if (tex.has.organization && !tex.has.publisher) {
				const orgName = tex.has.organization.value;
				tex.add({ name: 'publisher', value: `{{${orgName}}}`, raw: true });
				tex.remove('organization');
			}
		}
	}

	// Alle Namensfelder normalisieren:
	// Exakt: author, editor, translator, name
	// Erweitert: editora, editorb, authorb, translatora, namea, nameb, namec, usw.
	const nameBaseFields = ['author', 'editor', 'translator', 'name'];

	for (const fieldName of Object.keys(tex.has)) {
		// Autor-Normalisierung überspringen, wenn aus Organisation gesetzt
		if (fieldName === 'author' && organizationAsAuthor) continue;

		const isNameField = nameBaseFields.some(base =>
			fieldName === base ||
			(fieldName.startsWith(base) && fieldName.length === base.length + 1)
		);

		if (!isNameField) continue;

		const names = reference.item.creators
			.filter(c => {
				if (fieldName.startsWith('author'))		 return c.creatorType === 'author';
				if (fieldName.startsWith('editor'))		 return c.creatorType === 'editor';
				if (fieldName.startsWith('translator')) return c.creatorType === 'translator';
				// namea/nameb/namec: Auf alle übrigen Erstellertypen abbilden
				if (fieldName.startsWith('name'))			 return !['author', 'editor', 'translator'].includes(c.creatorType);
			})
			.map(c => {
				// Einfeld-Name (institutionell) in Zotero → in {{}} einschließen, um Parsing zu verhindern
				if (c.name) return `{{${c.name}}}`;
				return normalizeName({
					family: c.lastName,
					given:	c.firstName,
					prefix: c.prefix || ''
				});
			})
			.filter(n => n.trim() !== '');

		if (names.length > 0) {
			reference.add({
				name: fieldName,
				value: names.join(' and '),
				replace: true,
				raw: true
			});
		}
	}

	// @thesis: type = {phdthesis} → type = {Dissertation}
	// @thesis: institution = {} → publisher = {}
	if (reference.referencetype === 'thesis') {

		if (tex.has.type && tex.has.type.value === 'phdthesis') {
			reference.add({ name: 'type', value: 'Dissertation', replace: true });
		}

		if (tex.has.institution) {
			reference.add({ name: 'publisher', value: tex.has.institution.value, replace: true });
			reference.remove('institution');
		}

	}

	// @article mit entrysubtype = {newspaper} → @article-newspaper
	if (reference.referencetype === 'article') {
		if (tex.has.entrysubtype && tex.has.entrysubtype.value === 'newspaper') {
			// Typ = {newspaper} hinzufügen
			tex.add({ name: 'type', value: 'newspaper' });
			
			// Verlag nach journaltitle kopieren
			if (tex.has.publisher) {
				tex.add({ name: 'journaltitle', value: tex.has.publisher.value });
			}
		}
	}

}