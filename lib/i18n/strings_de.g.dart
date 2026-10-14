///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsDe extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsDe({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.de,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <de>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key) ?? super[key];

	late final TranslationsDe _root = this; // ignore: unused_field

	@override 
	TranslationsDe $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsDe(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$app$de app = _Translations$app$de._(_root);
	@override late final _Translations$home$de home = _Translations$home$de._(_root);
	@override late final _Translations$chats$de chats = _Translations$chats$de._(_root);
	@override late final _Translations$profile$de profile = _Translations$profile$de._(_root);
	@override late final _Translations$nav$de nav = _Translations$nav$de._(_root);
	@override late final _Translations$call$de call = _Translations$call$de._(_root);
	@override late final _Translations$vibes$de vibes = _Translations$vibes$de._(_root);
	@override late final _Translations$discover$de discover = _Translations$discover$de._(_root);
	@override late final _Translations$common$de common = _Translations$common$de._(_root);
	@override late final _Translations$languages$de languages = _Translations$languages$de._(_root);
	@override late final _Translations$auth$de auth = _Translations$auth$de._(_root);
	@override late final _Translations$onboarding$de onboarding = _Translations$onboarding$de._(_root);
	@override late final _Translations$createProfile$de createProfile = _Translations$createProfile$de._(_root);
	@override late final _Translations$errors$de errors = _Translations$errors$de._(_root);
	@override late final _Translations$faq$de faq = _Translations$faq$de._(_root);
	@override late final _Translations$legal$de legal = _Translations$legal$de._(_root);
	@override late final _Translations$logout$de logout = _Translations$logout$de._(_root);
	@override late final _Translations$deleteAccount$de deleteAccount = _Translations$deleteAccount$de._(_root);
	@override late final _Translations$storyText$de storyText = _Translations$storyText$de._(_root);
}

// Path: app
class _Translations$app$de extends Translations$app$tr {
	_Translations$app$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Veylo';
	@override String get tagline => 'Willkommen';
}

// Path: home
class _Translations$home$de extends Translations$home$tr {
	_Translations$home$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Start';
	@override String get subtitle => 'App wird vorbereitet';
	@override String get body => 'Die mehrsprachige Oberfläche wird mit slang verwaltet.';
}

// Path: chats
class _Translations$chats$de extends Translations$chats$tr {
	_Translations$chats$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Chats';
	@override String get search => 'Suchen';
	@override String get messagesSection => 'Nachrichten';
	@override String get request => 'Anfragen';
	@override String get emptyRequestTitle => 'Keine neuen Nachrichten-\nbenachrichtigungen';
	@override String get emptyRequestSubtitle => 'Anfragen, die älter als 30 Tage sind, werden nicht angezeigt.';
	@override String get noteAdd => 'Notiz hinzufügen';
	@override String get anonymous => 'Anonym';
	@override String get online => 'online';
	@override String get offline => 'offline';
	@override String get connection => 'Verbindung';
	@override String connectionPercent({required Object n}) => '${n}%';
	@override String get connectionProgressTitle => 'Verbindungsfortschritt';
	@override String get milestoneInitial => 'Anfangsbuchstabe des Vornamens';
	@override String get milestoneInitialHint => 'Freigeschaltet bei 25%';
	@override String get milestoneInitialLocked => 'Wird bei 25% freigeschaltet';
	@override String get milestonePhoto => 'Verschwommene Fotovorschau';
	@override String get milestonePhotoHint => 'Wird bei 70% freigeschaltet';
	@override String get milestoneFull => 'Komplettes Profil ansehen';
	@override String get milestoneFullHint => 'Gegenseitige Zustimmung bei 100%';
	@override String get sampleAnonymousMessage => 'Hallo, schön, dich kennenzulernen. Magst du mir ein bisschen von dir erzählen?';
	@override String get strangerSampleMessage => 'Hallo Jhon, schön, dich kennenzulernen. Magst du mir ein bisschen von dir erzählen?';
	@override String get approve => 'Annehmen';
	@override String get blockUser => 'Nutzer blockieren';
	@override String get reject => 'Ablehnen';
	@override String get messageHint => 'Hi! Wie geht’s dir?';
	@override String get revealTitle => 'Ihr habt 100% erreicht';
	@override String get revealSubtitle => 'Wollt ihr euch eure kompletten Profile zeigen? Beide müssen zustimmen.';
	@override String revealWaiting({required Object name}) => 'Warte, bis ${name} zustimmt';
	@override String get revealCta => 'Mein Profil zeigen';
	@override String get revealNotYet => 'Noch nicht';
	@override String get seen => 'Gesehen';
	@override String get typing => 'schreibt…';
	@override String get noteYou => 'Du';
	@override String get noteSheetTitle => 'Notiz teilen';
	@override String get noteSheetSubtitle => 'Deine Notiz bleibt 24 Stunden sichtbar';
	@override String get noteHint => 'Was geht dir durch den Kopf?';
	@override String get noteShare => 'Teilen';
	@override String get noteDelete => 'Notiz löschen';
}

// Path: profile
class _Translations$profile$de extends Translations$profile$tr {
	_Translations$profile$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get eyebrow => 'Profil';
	@override String get title => 'Einstellungen';
	@override String get editProfile => 'Profil bearbeiten';
	@override String get statLike => 'Likes';
	@override String get statFollow => 'Folge ich';
	@override String get statFollower => 'Follower';
	@override String get promoTitle => 'Mehr Nachrichten bekommen!';
	@override String get promoSubtitle => 'Fall auf und erscheine ganz oben in der Liste';
	@override String get standOut => 'Auffallen';
	@override String get tabPosts => 'Beiträge';
	@override String get tabVideo => 'Video';
	@override String get tabSaved => 'Gespeichert';
	@override String get save => 'Speichern';
	@override String get changePhoto => 'Foto ändern';
	@override String get changeBorder => 'Rahmen ändern';
	@override String get interest => 'Interessen';
	@override String get name => 'Name';
	@override String get changeName => 'Name ändern';
	@override String get changePassword => 'Passwort ändern';
	@override String get confirmPassword => 'Passwort bestätigen';
	@override String get email => 'E-Mail';
	@override String get accountManagement => 'Kontoverwaltung';
	@override String get settingsAbout => 'Info';
	@override String get settingsAccount => 'Kontoeinstellungen';
	@override String get settingsSupport => 'Support';
	@override String get shareApp => 'App teilen';
	@override String get shareAppTitle => 'Mit Freunden teilen';
	@override String get shareAppSubtitle => 'Teile Veylo mit deinen Freunden und entdeckt es gemeinsam!';
	@override String get shareAppLabel => 'App-Link';
	@override String get rateApp => 'Gefällt dir die App? Bewerte uns';
	@override String get notifications => 'Benachrichtigungen';
	@override String get password => 'Passwort';
	@override String get deleteConversation => 'Unterhaltungen löschen';
	@override String get faqHelp => 'FAQ & Hilfe';
	@override String get restorePurchases => 'Käufe wiederherstellen';
	@override String get termsOfService => 'Nutzungsbedingungen';
	@override String get privacyPolicy => 'Datenschutzerklärung';
	@override String get restorePurchasesDone => 'Käufe überprüft';
	@override String get conversationsDeleted => 'Alle Unterhaltungen gelöscht';
	@override String get logOut => 'Abmelden';
	@override String get deleteAccountAndData => 'Konto und Daten löschen';
	@override String get passwordPlaceholder => '********';
	@override String get height => 'Größe';
	@override String get addHeight => 'Größe hinzufügen';
	@override String heightCm({required Object value}) => '${value} cm';
	@override String get languages => 'Sprachen';
	@override String get relationshipGoals => 'Beziehungsziele';
	@override String get lookingFor => 'Auf der Suche nach';
	@override String get newFriends => '👋 Neuen Freunden';
	@override String get goalLongTermOpenToShort => '💕 Langfristig, offen für Kurzes';
	@override String get goalLongTermRelationship => '💘 Feste Beziehung';
	@override String get goalNewFriends => '👋 Neue Freunde';
	@override String get goalShortTermFun => '🥃 Kurzer Spaß';
	@override String get goalStillFiguringItOut => '🤔 Weiß ich noch nicht';
	@override String get basics => 'Basics';
	@override String get zodiac => 'Sternzeichen';
	@override String get zodiacValue => 'Skorpion';
	@override String get education => 'Bildung';
	@override String get educationValue => 'Bachelor';
	@override String get educationHighSchool => 'Abitur';
	@override String get educationAssociates => 'Berufsausbildung';
	@override String get educationBachelors => 'Bachelor';
	@override String get educationMasters => 'Master';
	@override String get educationPhd => 'Promotion';
	@override String get voiceRecord => 'Sprachaufnahme';
	@override String get addVoice => 'Stimme hinzufügen';
	@override String get lifestyle => 'Lebensstil';
	@override String get pets => 'Haustiere';
	@override String get petsValue => 'Ich habe eine Katze';
	@override String get petsDontWant => 'Ich möchte keine Haustiere';
	@override String get petsAllergic => 'Ich bin allergisch gegen Tiere';
	@override String get petsHaveCat => 'Ich habe eine Katze';
	@override String get petsHaveDog => 'Ich habe einen Hund';
	@override String get petsHaveCatsAndDogs => 'Ich habe Katzen und Hunde';
	@override String get petsHaveOther => 'Ich habe andere Haustiere';
	@override String get drinking => 'Alkohol';
	@override String get drinkingValue => 'Zu besonderen Anlässen';
	@override String get drinkingNever => 'Nie';
	@override String get drinkingSpecialOccasions => 'Zu besonderen Anlässen';
	@override String get drinkingSocially => 'Gesellig';
	@override String get drinkingFrequently => 'Häufig';
	@override String get drinkingSober => 'Nüchtern';
	@override String get drinkingPreferNotToSay => 'Keine Angabe';
	@override String get smoking => 'Rauchen';
	@override String get smokingValue => 'Nichtraucher';
	@override String get smokingNonSmoker => 'Nichtraucher';
	@override String get smokingSocialSmoker => 'Gelegenheitsraucher';
	@override String get smokingSmoker => 'Raucher';
	@override String get smokingTryingToQuit => 'Versuche aufzuhören';
	@override String get smokingWhenDrinking => 'Raucher beim Trinken';
	@override String get smokingPreferNotToSay => 'Keine Angabe';
	@override String get gender => 'Geschlecht';
	@override String get genderFemale => 'Weiblich';
	@override String get genderMale => 'Männlich';
	@override String get genderPreferNotToSay => 'Möchte ich nicht angeben';
	@override String get visible => 'Sichtbar';
	@override String get profileVisibility => 'Profilsichtbarkeit';
	@override String get language => 'Sprache';
	@override String get borderTitle => 'Profilrahmen';
	@override String get borderSubtitle => 'Gib deinem Profil einen Rahmen,\ndamit du auffällst.';
	@override String get borderBuySection => 'Rahmen kaufen';
	@override String get borderBuyCta => 'Rahmen kaufen';
	@override String borderToken({required Object count}) => '${count} Token';
	@override String get borderAmethystWings => 'Amethyst Wings';
	@override String get borderGoldenPhoenix => 'Golden Phoenix';
	@override String get borderFrostCrown => 'Frost Crown';
	@override String get borderEmeraldWhisper => 'Emerald Whisper';
	@override String get borderRoseQuartz => 'Rose Quartz';
	@override String get borderStarlitComet => 'Starlit Comet';
	@override String get borderCrimsonRoyal => 'Crimson Royal';
	@override String get borderSapphireHalo => 'Sapphire Halo';
	@override String get follow => 'Folgen';
	@override String get following => 'Folge ich';
	@override String get followPageTitle => 'Folgen';
	@override String get followTabFollowing => 'Folge ich';
	@override String get followTabFollowers => 'Follower';
	@override String get followSearch => 'Suchen';
	@override String get unfollow => 'Entfolgen';
	@override String get followSortTitle => 'Sortieren';
	@override String get followSortRecent => 'Zuletzt gefolgt';
	@override String get followSortNotFollowingMe => 'Folgen mir nicht zurück';
	@override String get followSortNotFollowedByMe => 'Denen ich nicht zurückfolge';
	@override String get followSortShowResult => 'Ergebnis anzeigen';
	@override String get followSortEmpty => 'Keine Nutzer passen zu diesem Filter';
	@override String get shareTitle => 'Mit Freunden teilen';
	@override String get shareSubtitle => 'Alles macht mehr Spaß, wenn du dich\nmit deinen Freunden verbindest!';
	@override String get shareProfileLabel => 'Profil teilen';
	@override String get shareLinkCopied => 'Link kopiert';
	@override String get restrict => 'Einschränken';
	@override String get block => 'Blockieren';
	@override String get report => 'Melden';
	@override String blockTitle({required Object username}) => '${username} blockieren?';
	@override String get blockBody => 'Damit werden auch alle anderen Konten blockiert, die diese Person hat oder künftig erstellt. Du kannst die Blockierung jederzeit aufheben.';
	@override String get blockAndReport => 'Blockieren und melden';
	@override String restrictTitle({required Object username}) => '${username} einschränken?';
	@override String get restrictBody => 'Die Person sieht dann nicht, wann du online bist oder ob du ihre Nachrichten gelesen hast. Du kannst das jederzeit ändern.';
	@override String get restrictAndReport => 'Einschränken und melden';
	@override String get reportTitle => 'Wir würden gern wissen, warum';
	@override String get reportSubtitle => 'Damit wir dir ein besseres Erlebnis bieten können: Magst du uns sagen, warum du diesen Nutzer melden möchtest?';
	@override String get reportMessageLabel => 'Nachricht zur Meldung';
	@override String get reportMessageHint => 'Schreib deine Nachricht';
	@override String get reportCancel => 'Abbrechen';
	@override String get sendReport => 'Meldung senden';
	@override String get notSet => 'Nicht angegeben';
	@override String get reportSent => 'Danke, wir haben deine Meldung erhalten.';
	@override String emailVerificationSent({required Object email}) => 'Wir haben einen Bestätigungslink an ${email} gesendet. Deine E-Mail ändert sich, sobald du bestätigst.';
	@override String get passwordChanged => 'Dein Passwort wurde aktualisiert.';
	@override String get passwordMismatch => 'Die Passwörter stimmen nicht überein.';
}

// Path: nav
class _Translations$nav$de extends Translations$nav$tr {
	_Translations$nav$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get discover => 'Entdecken';
	@override String get chat => 'Chat';
	@override String get call => 'Anruf';
	@override String get vibes => 'Vibes';
	@override String get profile => 'Profil';
}

// Path: call
class _Translations$call$de extends Translations$call$tr {
	_Translations$call$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => '60-Sekunden-Fremde';
	@override String get subtitle => 'Sprich 60 Sekunden lang mit einer zufälligen fremden Person – komplett anonym. Kein Profil, kein Foto, kein Name. Nur eine Stimme und ein Moment.';
	@override String get findingTitle => 'Suche nach jemandem...';
	@override String get findingSubtitle => 'Ihr sprecht 60 Sekunden lang anonym. Keine Profile, keine Namen.';
	@override String get callStranger => 'Fremde anrufen - 10 Token';
	@override String get cancel => 'Abbrechen';
	@override String get female => 'Weiblich';
	@override String get male => 'Männlich';
	@override String get nonBinary => 'Nicht-binär';
	@override String get preferNotToSay => 'Keine Angabe';
	@override String get anonymousBadge => '🎙️ Anonymer Sprachanruf';
	@override String get stranger => 'Fremde Person';
	@override String secondsLeft({required Object n}) => '${n} s';
	@override String get timesUpTitle => 'Die Zeit ist um!';
	@override String get timesUpSubtitle => 'Wollt ihr weiterreden? Wenn ihr beide Ja sagt, wird der Chat freigeschaltet.';
	@override String get keepTalking => 'Weiterreden';
	@override String get endCall => 'Auflegen';
	@override String get waitingOther => 'Warte auf die andere Person...';
	@override String get callStrangerFree => 'Fremde anrufen';
	@override String get peerLeft => 'Die andere Person hat aufgelegt.';
	@override String get noKeep => 'Der Chat wurde diesmal nicht freigeschaltet.';
	@override String get videoWaiting => 'Warte, bis der Videoanruf angenommen wird...';
	@override String get videoDeclined => 'Der Videoanruf wurde abgelehnt.';
	@override String get micDenied => 'Für Anrufe brauchen wir Zugriff auf dein Mikrofon. Du kannst ihn in den Einstellungen erlauben.';
	@override String get videoCost => 'Videoanruf: 20 Token / 15 Min.';
	@override String get calling => 'Anruf läuft';
	@override String get accept => 'Annehmen';
	@override String get decline => 'Ablehnen';
	@override String get switchToVideo => 'Möchtest du zu einem Videoanruf wechseln?';
}

// Path: vibes
class _Translations$vibes$de extends Translations$vibes$tr {
	_Translations$vibes$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get search => 'Suchen';
	@override String get sendMessage => 'Nachricht senden';
	@override String get wantsToTalk => 'Will gerade darüber reden';
	@override String get shareTitle => 'Vibe teilen';
	@override String get replyTitle => 'Auf Vibe antworten';
	@override String get shareHint => 'Schreib etwas';
	@override String get shareAnonymous => 'Anonym teilen';
	@override String get empty => 'Keine Vibes in den letzten 24 Stunden. Teile den ersten!';
	@override String get deleteTitle => 'Diesen Vibe löschen?';
	@override String get delete => 'Löschen';
	@override String get cancel => 'Abbrechen';
}

// Path: discover
class _Translations$discover$de extends Translations$discover$tr {
	_Translations$discover$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Entdecken';
	@override String get tabRooms => 'Räume';
	@override String get tabDiscover => 'Entdecken';
	@override String get tabAiMatch => 'AI Match';
	@override late final _Translations$discover$aiMatch$de aiMatch = _Translations$discover$aiMatch$de._(_root);
	@override String get searchHint => 'Suchen';
	@override String get allRooms => 'Alle Räume';
	@override String get allGroups => 'Alle Gruppen';
	@override String get seeAll => 'Alle ansehen';
	@override String get live => 'Live';
	@override String get join => 'Beitreten';
	@override String get request => 'Anfragen';
	@override String get requested => 'Angefragt';
	@override String get private => 'Privat';
	@override String moreCount({required Object count}) => '+${count} weitere';
	@override String activeCount({required Object count}) => '${count} aktiv';
	@override String membersCount({required Object count}) => '${count} Mitglieder';
	@override late final _Translations$discover$privateRoom$de privateRoom = _Translations$discover$privateRoom$de._(_root);
	@override late final _Translations$discover$roomToken$de roomToken = _Translations$discover$roomToken$de._(_root);
	@override late final _Translations$discover$privateRequest$de privateRequest = _Translations$discover$privateRequest$de._(_root);
	@override late final _Translations$discover$roomApproved$de roomApproved = _Translations$discover$roomApproved$de._(_root);
	@override late final _Translations$discover$createSpace$de createSpace = _Translations$discover$createSpace$de._(_root);
	@override late final _Translations$discover$liveRoom$de liveRoom = _Translations$discover$liveRoom$de._(_root);
	@override late final _Translations$discover$groupChat$de groupChat = _Translations$discover$groupChat$de._(_root);
	@override late final _Translations$discover$groupInfo$de groupInfo = _Translations$discover$groupInfo$de._(_root);
	@override late final _Translations$discover$filters$de filters = _Translations$discover$filters$de._(_root);
	@override late final _Translations$discover$post$de post = _Translations$discover$post$de._(_root);
	@override late final _Translations$discover$story$de story = _Translations$discover$story$de._(_root);
	@override late final _Translations$discover$highlight$de highlight = _Translations$discover$highlight$de._(_root);
	@override late final _Translations$discover$stats$de stats = _Translations$discover$stats$de._(_root);
	@override String hostedBy({required Object name}) => 'Gehostet von ${name}';
}

// Path: common
class _Translations$common$de extends Translations$common$tr {
	_Translations$common$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get loading => 'Wird geladen…';
	@override String get retry => 'Erneut versuchen';
	@override String get cancel => 'Abbrechen';
	@override String get save => 'Speichern';
	@override String get continueAction => 'Weiter';
	@override String get language => 'Sprache';
	@override String get or => 'ODER';
}

// Path: languages
class _Translations$languages$de extends Translations$languages$tr {
	_Translations$languages$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get tr => 'Türkçe';
	@override String get en => 'English';
}

// Path: auth
class _Translations$auth$de extends Translations$auth$tr {
	_Translations$auth$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get createAccountTitle => 'Erstelle dein Konto';
	@override String get createAccountSubtitle => 'Tritt Veylo bei und knüpf neue Kontakte.';
	@override String get welcomeBackTitle => 'Willkommen zurück';
	@override String get welcomeBackSubtitle => 'Melde dich an, um mit Veylo weiterzumachen.';
	@override String get username => 'Nutzername';
	@override String get usernameHint => 'Wähle einen Nutzernamen';
	@override String get email => 'E-Mail';
	@override String get emailHint => 'Gib deine E-Mail ein';
	@override String get emailOrUsername => 'E-Mail oder Nutzername';
	@override String get emailOrUsernameHint => 'Wähle einen Nutzernamen';
	@override String get password => 'Passwort';
	@override String get passwordCreateHint => 'Erstelle ein Passwort';
	@override String get passwordEnterHint => 'Gib dein Passwort ein';
	@override String get signUp => 'Registrieren';
	@override String get logIn => 'Anmelden';
	@override String get forgotPassword => 'Passwort vergessen?';
	@override String get continueWithApple => 'Weiter mit Apple';
	@override String get continueWithGoogle => 'Weiter mit Google';
	@override String get legalPrefix => 'Indem du fortfährst, stimmst du unseren ';
	@override String get termsOfService => 'Nutzungsbedingungen';
	@override String get legalMiddle => ' zu und bestätigst unsere ';
	@override String get privacyPolicy => 'Datenschutzerklärung';
	@override String get legalSuffix => '.';
	@override String get passwordResetSent => 'Wir haben dir einen Link zum Zurücksetzen des Passworts per E-Mail geschickt.';
}

// Path: onboarding
class _Translations$onboarding$de extends Translations$onboarding$tr {
	_Translations$onboarding$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get skip => 'Überspringen';
	@override String get page1Title => 'Sei du selbst. Bleib anonym.';
	@override String get page1Subtitle => 'Lerne neue Leute kennen und starte Gespräche,\nohne zu verraten, wer du bist.';
	@override String get page2Title => 'Schreiben. Reden. Den Vibe spüren.';
	@override String get page2Subtitle => 'Starte anonym und schreib, ruf an oder triff dich persönlich, wenn du bereit bist.';
	@override String get page3Title => 'Finde deine Leute. Mach\nmit beim Gespräch.';
	@override String get page3Subtitle => 'Spring in Räume, lerne neue Leute kennen\nund teilt den Moment zusammen.';
	@override String get getStarted => 'Los geht’s';
	@override String get alreadyHaveAccount => 'Du hast schon ein Veylo-Konto? ';
	@override String get logInAction => 'Anmelden';
}

// Path: createProfile
class _Translations$createProfile$de extends Translations$createProfile$tr {
	_Translations$createProfile$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get navTitle => 'Profil erstellen';
	@override String get stepUsername => '1/5 Nutzername';
	@override String get title => 'Erstelle dein Profil';
	@override String get subtitle => 'Dein echter Name dient nur zur Verifizierung – er wird nicht öffentlich angezeigt.';
	@override String get subtitleLine1 => 'Dein echter Name dient nur zur Verifizierung – er';
	@override String get subtitleLine2 => 'wird nicht öffentlich angezeigt.';
	@override String get fullName => 'Vollständiger Name';
	@override String get fullNameHint => 'Sam Lee';
	@override String get username => 'Nutzername';
	@override String get usernameHint => 'samlee123';
	@override String get usernameTaken => 'Dieser Nutzername ist schon vergeben!';
	@override String get usernameAvailable => 'Nutzername ist verfügbar';
	@override String get mightWantToTry => 'Wie wäre es mit...';
	@override String get stepPhoto => '2/5 Profilfoto';
	@override String get photoTitle => 'Lade ein Profilfoto hoch';
	@override String get photoSubtitle => 'Andere können dein Profilfoto sehen, um sicherzugehen, dass du es bist.';
	@override String get photoSubtitleLine1 => 'Andere können dein Profilfoto sehen, um';
	@override String get photoSubtitleLine2 => 'sicherzugehen, dass du es bist.';
	@override String get choosePhoto => 'Foto auswählen';
	@override String get continueWithoutPhoto => 'Ohne Profilfoto fortfahren';
	@override String get saveAndContinue => 'Speichern & weiter';
	@override String get choosePhotoSheetTitle => 'Foto auswählen';
	@override String get takePhoto => 'Foto aufnehmen';
	@override String get chooseFromGallery => 'Aus Mediathek wählen';
	@override String get stepGender => '3/5 Geschlecht';
	@override String get genderTitle => 'Wähle dein Geschlecht';
	@override String get genderSubtitle => 'Wenn du uns diese Angabe machst, können wir damit Inhalte für dich personalisieren';
	@override String get genderSubtitleLine1 => 'Wenn du uns diese Angabe machst, können wir';
	@override String get genderSubtitleLine2 => 'damit Inhalte für dich personalisieren';
	@override String get genderFemale => 'Weiblich';
	@override String get genderMale => 'Männlich';
	@override String get genderNonBinary => 'Nicht-binär';
	@override String get genderPreferNotToSay => 'Keine Angabe';
	@override String get stepInterests => '4/5 Interessen';
	@override String get interestsTitle => 'Worauf stehst du?';
	@override String get interestsSubtitle => 'Wähle mindestens 5 – so finden wir Leute, die dich wirklich verstehen.';
	@override late final _Translations$createProfile$interests$de interests = _Translations$createProfile$interests$de._(_root);
	@override String get stepChatGoal => '5/5 Chat-Ziel';
	@override String get chatGoalTitle => 'Wonach suchst du heute?';
	@override String get chatGoalSubtitle => 'So finden wir das richtige Match für deine aktuelle Stimmung.';
	@override String get chatGoalQuickMatch => 'Schnelles Match – direkt rein\nins Gespräch';
	@override String get chatGoalFlirtyChat => 'Flirt-Chat – leichte, verspielte\nGespräche';
	@override String get chatGoalMoodMatch => 'Stimmungs-Match – passend dazu, wie\ndu dich fühlst';
	@override String get chatGoalLateNight => 'Late-Night-Talk – tiefe Gespräche, wenn die\nWelt schläft';
	@override String get chatGoalMeetSomeoneNew => 'Jemand Neues – kein bestimmtes Ziel,\neinfach entdecken';
	@override String get getStarted => 'Los geht’s';
	@override String get preparingTitleLine1 => 'Wir bereiten';
	@override String get preparingTitleLine2 => 'passende Profile für';
	@override String get preparingTitleLine3 => 'dich vor.';
	@override String get preparingSubtitleLine1 => 'Anhand deiner Antworten wählen wir';
	@override String get preparingSubtitleLine2 => 'die besten Matches aus – einen Moment bitte.';
	@override String preparingPercent({required Object percent}) => '${percent} %';
	@override String get usernameInvalid => 'Nutze 3–30 Buchstaben, Zahlen, Punkte oder Unterstriche.';
}

// Path: errors
class _Translations$errors$de extends Translations$errors$tr {
	_Translations$errors$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get network => 'Veylo ist nicht erreichbar. Prüfe deine Verbindung und versuch es erneut.';
	@override String get generic => 'Etwas ist schiefgelaufen. Bitte versuch es erneut.';
	@override String get signInFailed => 'Anmeldung fehlgeschlagen. Bitte versuch es erneut.';
	@override String get sessionExpired => 'Deine Sitzung ist abgelaufen. Bitte melde dich erneut an.';
	@override String get accountSuspended => 'Dieses Konto wurde gesperrt.';
	@override String get unsupportedImage => 'Bitte wähle ein JPEG-, PNG- oder WebP-Foto.';
	@override String get fileTooLarge => 'Diese Datei ist zu groß.';
	@override String get enterEmailForReset => 'Gib oben deine E-Mail ein, um dein Passwort zurückzusetzen.';
	@override String get wrongCredentials => 'E-Mail/Nutzername oder Passwort ist falsch.';
	@override String get emailInUse => 'Diese E-Mail ist bereits registriert. Versuch dich anzumelden.';
	@override String get weakPassword => 'Das Passwort muss mindestens 6 Zeichen haben.';
	@override String get invalidEmail => 'Bitte gib eine gültige E-Mail-Adresse ein.';
	@override String get tooManyAttempts => 'Zu viele Versuche. Bitte warte kurz und versuch es erneut.';
	@override String get fillAllFields => 'Bitte fülle alle Felder aus.';
	@override String get insufficientTokens => 'Nicht genug Token.';
	@override String get requestNotAccepted => 'Nimm die Anfrage an, um zu antworten.';
	@override String get requestPendingLimit => 'Du kannst weitere Nachrichten senden, sobald deine Anfrage angenommen wurde.';
	@override String get blocked => 'Du kannst dieser Person keine Nachricht senden.';
	@override String get peerUnavailable => 'Dieses Konto ist nicht mehr verfügbar.';
	@override String get vibeDailyLimit => 'Du hast heute schon viele Vibes geteilt. Versuch es später erneut.';
	@override String get groupFull => 'Diese Gruppe ist voll.';
	@override String get groupCreateLimit => 'Du hast heute zu viele Gruppen erstellt. Versuch es später erneut.';
	@override String get notFound => 'Das ist nicht mehr verfügbar.';
	@override String get recentLogin => 'Aus Sicherheitsgründen: Melde dich ab und wieder an und versuch es dann noch einmal.';
	@override String get socialAccount => 'Deine E-Mail und dein Passwort werden über dein Google- oder Apple-Konto verwaltet.';
	@override String get alreadyInCall => 'Du bist bereits in einem Anruf.';
	@override String get roomPrivate => 'Dieser Raum ist privat. Frag den Host, ob du beitreten darfst.';
	@override String get roomFull => 'Dieser Raum ist voll.';
}

// Path: faq
class _Translations$faq$de extends Translations$faq$tr {
	_Translations$faq$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get q1 => 'Wie funktioniert die App?';
	@override String get q2 => 'Was ist ein anonymer Chat?';
	@override String get q3 => 'Was ist der Verbindungsfortschritt?';
	@override String get q4 => 'Wie zeige ich mein Profil?';
	@override String get q5 => 'Was ist 60-Sekunden-Fremde?';
	@override String get q6 => 'Was sind Vibes?';
	@override String get q7 => 'Wie bearbeite ich mein Profil?';
	@override String get q8 => 'Wie verwalte ich Benachrichtigungen?';
	@override String get q9 => 'Wie stelle ich Käufe wieder her?';
	@override String get q10 => 'Kann ich alle Unterhaltungen löschen?';
	@override String get q11 => 'Sind meine Daten sicher?';
	@override String get q12 => 'Wie blockiere oder melde ich jemanden?';
	@override String get q13 => 'Wie teile ich die App?';
	@override String get q14 => 'Wie lösche ich mein Konto?';
	@override String get a1 => 'Auf Veylo lernst du anonym neue Leute kennen, chattest und zeigst nach und nach mehr von deinem Profil, je stärker eure Verbindung wird. Wechselt zu Text, Sprache oder einem persönlichen Treffen, wann immer ihr beide bereit seid.';
	@override String get a2 => 'Im anonymen Chat bleiben deine Identität und dein Foto verborgen. Je stärker die Verbindung, desto mehr schaltest du frei, etwa den Anfangsbuchstaben des Namens und ein verschwommenes Foto. Bei 100% müssen beide zustimmen, um die kompletten Profile zu zeigen.';
	@override String get a3 => 'Während ihr chattet, steigt euer Verbindungsprozentsatz. Bei bestimmten Meilensteinen schaltest du den Anfangsbuchstaben des Namens, ein verschwommenes Foto und das komplette Profil frei. Tippe auf die Anzeige „Verbindung“, um Details zu sehen.';
	@override String get a4 => 'Wenn die Verbindung 100% erreicht, tippe auf „Mein Profil zeigen“. Wenn die andere Person ebenfalls zustimmt, werden beide kompletten Profile sichtbar.';
	@override String get a5 => 'Im Tab „Anruf“ bekommst du ein kurzes zufälliges Match. Wenn die Zeit um ist, könnt ihr weiterreden oder den Anruf beenden.';
	@override String get a6 => 'Mit Vibes entdeckst du Leute in deiner Nähe oder um dich herum in einer Karten-/Listenansicht und kannst mit jemandem, der dich interessiert, einen Chat starten.';
	@override String get a7 => 'Öffne den Tab „Profil“ und gehe zu „Profil bearbeiten“, um Namen, Fotos, Bio und Interessen zu aktualisieren. Änderungen erscheinen nach dem Speichern.';
	@override String get a8 => 'Öffne „Benachrichtigungen“ in den Einstellungen, um Hinweise zu Nachrichten, Matches und mehr ein- oder auszuschalten.';
	@override String get a9 => 'Gehe zu Einstellungen → Kontoverwaltung → Käufe wiederherstellen. Berechtigte Käufe mit demselben Store-Konto werden wiederhergestellt.';
	@override String get a10 => 'Ja. Nutze Einstellungen → Unterhaltungen löschen und bestätige. Alle Chats werden entfernt. Das kann nicht rückgängig gemacht werden.';
	@override String get a11 => 'Deine Kontodaten und Nachrichten werden auf geschützten Systemen gespeichert. Du kannst außerdem jederzeit in der Kontoverwaltung die Löschung deines Kontos und deiner Daten beantragen.';
	@override String get a12 => 'Nutze das Menü auf einem Profil oder im Chat, um jemanden zu blockieren oder zu melden. Meldungen werden von unserem Team geprüft.';
	@override String get a13 => 'Nutze „App teilen“ in den Einstellungen, um den Link zu kopieren und an Freunde zu senden.';
	@override String get a14 => 'Gehe zu Einstellungen → Kontoverwaltung → Konto und Daten löschen. Nenne einen Grund und bestätige, um deinen Löschantrag zu senden.';
}

// Path: legal
class _Translations$legal$de extends Translations$legal$tr {
	_Translations$legal$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get termsTitle => 'Nutzungsbedingungen';
	@override String get privacyTitle => 'Datenschutzerklärung';
	@override String get termsBody => 'Zuletzt aktualisiert: 16. März 2026\n\nWillkommen bei Veylo. Indem du ein Konto erstellst oder die App nutzt, stimmst du diesen Nutzungsbedingungen zu.\n\n1. Was Veylo ist\nVeylo ist eine soziale App, in der du Leute kennenlernen, anonym chatten, mit der Zeit eine Verbindung aufbauen und optional zu Sprach- oder Videoanrufen wechseln kannst, wenn beide Seiten zustimmen.\n\n2. Dein Konto\nDu musst korrekte Angaben machen und deine Anmeldedaten sicher aufbewahren. Du bist für alle Aktivitäten unter deinem Konto verantwortlich. Du musst nach den Gesetzen deines Landes alt genug sein, um Veylo zu nutzen.\n\n3. Respektvolle Nutzung\nBelästige, bedrohe oder betrüge niemanden, gib dich nicht als andere aus, teile keine illegalen Inhalte und versuche nicht, Sicherheitsfunktionen zu umgehen. Wir können Inhalte entfernen, Funktionen einschränken oder Konten sperren, die gegen diese Regeln verstoßen.\n\n4. Anonymer Chat & Profilfreigabe\nIn anonymen Chats können dein Name und dein Foto verborgen bleiben, bis bestimmte Verbindungsmeilensteine erreicht sind. Die vollständige Profilfreigabe erfordert gegenseitige Zustimmung. Setze andere nicht unter Druck, ihre Identität preiszugeben.\n\n5. Käufe\nEinige Funktionen können kostenpflichtig sein. Käufe werden über den Apple App Store oder Google Play abgewickelt. „Käufe wiederherstellen“ stellt berechtigte Käufe mit demselben Store-Konto wieder her. Erstattungen richten sich nach den Richtlinien des jeweiligen Stores.\n\n6. Inhalte, die du teilst\nDu behältst die Rechte an deinen Inhalten, räumst Veylo jedoch eine Lizenz ein, sie in der App zu hosten und anzuzeigen, soweit dies für den Betrieb des Dienstes erforderlich ist. Veröffentliche keine Inhalte, zu deren Weitergabe du nicht berechtigt bist.\n\n7. Beendigung der Nutzung\nDu kannst die Nutzung von Veylo jederzeit beenden und in den Einstellungen die Löschung deines Kontos beantragen. Wir können den Dienst ebenfalls beenden oder ändern und informieren dich, wenn erforderlich, mit angemessener Frist.\n\n8. Kontakt\nFragen zu diesen Bedingungen: support@veylo.app';
	@override String get privacyBody => 'Zuletzt aktualisiert: 16. März 2026\n\nDiese Datenschutzerklärung erläutert, wie Veylo deine Daten erhebt, verwendet und schützt.\n\n1. Welche Daten wir erheben\n• Kontodaten: E-Mail, Anzeigename, Profilfotos, Bio, Präferenzen\n• Nutzungsdaten: Chats, Verbindungsfortschritt, genutzte Anruffunktionen, grundlegende Geräte-/App-Daten\n• Käufe: Store-Belegdaten, die zum Freischalten und Wiederherstellen kostenpflichtiger Funktionen nötig sind\n\n2. Wie wir sie verwenden\nWir verwenden deine Daten, um Veylo zu betreiben, Matching und Chat-Erlebnisse zu personalisieren, die Community zu schützen, Käufe abzuwickeln und das Produkt zu verbessern. Wir verkaufen deine personenbezogenen Daten nicht.\n\n3. Anonymer Modus\nIn anonymen Chats begrenzen wir, was andere sehen (zum Beispiel einen maskierten Namen oder ein verschwommenes Foto), bis Freischaltregeln und gegenseitige Zustimmung mehr erlauben. Im Hintergrund benötigen wir weiterhin Konto-Kennungen, um die Funktion sicher zu betreiben.\n\n4. Weitergabe\nWir können Daten an Dienstleister weitergeben, die uns beim Hosting, bei Analysen oder bei der Zahlungsabwicklung unterstützen – nur soweit erforderlich. Außerdem können wir Informationen offenlegen, wenn dies gesetzlich vorgeschrieben ist oder um Nutzer vor Schaden zu schützen.\n\n5. Speicherdauer\nWir speichern Daten, solange dein Konto aktiv ist und soweit dies aus rechtlichen, sicherheitsbezogenen oder abrechnungsbezogenen Gründen erforderlich ist. Nach Abschluss eines Löschantrags entfernen oder anonymisieren wir personenbezogene Daten, sofern keine Aufbewahrungspflicht besteht.\n\n6. Deine Wahlmöglichkeiten\nDu kannst deine Profilangaben bearbeiten, Benachrichtigungen verwalten, die Löschung deines Kontos beantragen und uns zu deinen Daten kontaktieren. Store-Käufe werden außerdem über Apple oder Google verwaltet.\n\n7. Sicherheit\nWir setzen angemessene technische und organisatorische Maßnahmen ein, um deine Daten zu schützen. Kein System ist vollkommen sicher; bitte verwende ein starkes Passwort und halte dein Gerät aktuell.\n\n8. Kontakt\nFragen zum Datenschutz: privacy@veylo.app';
}

// Path: logout
class _Translations$logout$de extends Translations$logout$tr {
	_Translations$logout$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Abmelden';
	@override String get subtitle => 'Möchtest du dich wirklich abmelden?';
	@override String get cancel => 'Abbrechen';
	@override String get confirm => 'Abmelden';
}

// Path: deleteAccount
class _Translations$deleteAccount$de extends Translations$deleteAccount$tr {
	_Translations$deleteAccount$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kontolöschung beantragen';
	@override String get subtitle => 'Möchtest du dein Konto wirklich löschen?';
	@override String get reasonTitle => 'Wir wollen nicht, dass du gehst, aber wir verstehen es.';
	@override String get reasonBefore => 'Verrätst du uns, warum du gehen möchtest, damit wir das ';
	@override String get reasonAfter => '-Erlebnis verbessern können?';
	@override String get reasonLabel => 'Warum möchtest du dein Konto löschen?';
	@override String get reasonHint => 'Schreib deine Nachricht';
	@override String get cancel => 'Abbrechen';
	@override String get createRequest => 'Antrag erstellen';
	@override String get confirmTitle => 'Möchtest du den Löschantrag wirklich senden?';
	@override String get confirmSubtitle => 'Wenn du bestätigst, wird dein Antrag auf Kontolöschung gesendet';
	@override String get delete => 'Löschen';
}

// Path: storyText
class _Translations$storyText$de extends Translations$storyText$tr {
	_Translations$storyText$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get bold => 'Fett';
	@override String get italic => 'Kursiv';
	@override String get uppercase => 'Großbuchstaben';
	@override String get underline => 'Unterstrichen';
	@override String get cancel => 'Abbrechen';
	@override String get galleryError => 'Galerie konnte nicht geöffnet werden';
}

// Path: discover.aiMatch
class _Translations$discover$aiMatch$de extends Translations$discover$aiMatch$tr {
	_Translations$discover$aiMatch$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get feelingTitle => 'Wie fühlst du dich heute?';
	@override String get feelingSubtitle => 'Die KI findet das beste Match passend zu deiner Wahl';
	@override String get lookingTitle => 'Wonach suchst du?';
	@override String get moodSad => 'Traurig';
	@override String get moodMeltie => 'Naja';
	@override String get moodBored => 'Gelangweilt';
	@override String get moodCrying => 'Down';
	@override String get moodSmile => 'Glücklich';
	@override String get lookingNewFriends => 'Neue Freunde';
	@override String get lookingVenting => 'Dampf ablassen';
	@override String get lookingFlirty => 'Flirten';
	@override String get lookingFun => 'Spaß';
	@override String get lookingCultures => 'Neue Kulturen';
	@override String get lookingLanguage => 'Sprache üben';
	@override String get statActiveUsers => 'Aktive Nutzer';
	@override String get statMatchRate => 'Match-Rate';
	@override String get statAvgTime => 'Ø Zeit';
	@override String get statActiveValue => '843';
	@override String get statMatchValue => '87%';
	@override String get statAvgValue => '8 s';
	@override String get startSmartMatch => 'Smart Match starten';
	@override String get findingTitle => 'Wir suchen dein Match';
	@override String get findingSubtitle => 'Wir bringen deine Stimmung und Interessen mit der richtigen Person zusammen';
	@override String get findingStepMood => 'Stimmung analysiert';
	@override String get findingStepInterests => 'Interessen abgeglichen';
	@override String get findingStepCompatibility => 'Kompatibilität wird berechnet...';
	@override String get findingStepContent => 'Inhalte werden erstellt...';
	@override String findingOnline({required Object count}) => '${count} Leute gerade online';
	@override String get yourMatchTitle => 'Dein Match';
	@override String get yourMatchSubtitle => 'Dein Match basiert auf deinen Antworten';
	@override String vibeMatch({required Object percent}) => '${percent}% Vibe-Match';
	@override String get startChatting => 'Chat starten';
	@override String matchNameAge({required Object name, required Object age}) => '${name}, ${age}';
	@override String get matchBio => 'Ich lasse dich Dinge fühlen, von denen du nicht wusstest, dass du sie fühlen kannst.';
	@override String get swipePrevious => 'Zurück';
	@override String get swipeNext => 'Weiter';
	@override String get swipeFinger => 'Wischen';
	@override String get noMatch => 'Gerade passt niemand. Versuch es gleich noch mal.';
}

// Path: discover.privateRoom
class _Translations$discover$privateRoom$de extends Translations$discover$privateRoom$tr {
	_Translations$discover$privateRoom$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get subtitle => 'Das ist ein privater Raum. Schalte den Zugang mit Token frei.';
	@override String get roomAccess => 'Raumzugang';
	@override String get yourBalance => 'Dein Guthaben';
	@override String tokensAmount({required Object count}) => '${count} Token';
	@override String joinForTokens({required Object count}) => 'Für ${count} Token beitreten';
	@override String get cancel => 'Abbrechen';
}

// Path: discover.roomToken
class _Translations$discover$roomToken$de extends Translations$discover$roomToken$tr {
	_Translations$discover$roomToken$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get subtitle => 'Schalte den Zugang mit Token frei.';
	@override String get roomAccess => 'Raumzugang';
	@override String get yourBalance => 'Dein Guthaben';
	@override String tokensAmount({required Object count}) => '${count} Token';
	@override String joinForTokens({required Object count}) => 'Für ${count} Token beitreten';
	@override String get cancel => 'Abbrechen';
}

// Path: discover.privateRequest
class _Translations$discover$privateRequest$de extends Translations$discover$privateRequest$tr {
	_Translations$discover$privateRequest$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Beitritt anfragen';
	@override String roomInfo({required Object name, required Object count}) => '${name} · ${count} Mitglieder';
	@override String get messageHint => 'Sag etwas (optional)...';
	@override String get sendRequest => 'Anfrage senden';
	@override String get adminReview => 'Der Raum-Admin prüft deine Anfrage';
}

// Path: discover.roomApproved
class _Translations$discover$roomApproved$de extends Translations$discover$roomApproved$tr {
	_Translations$discover$roomApproved$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Du bist drin!';
	@override String subtitle({required Object name}) => 'Dein Platz in ${name} ist reserviert';
	@override String get continueLabel => 'Weiter';
}

// Path: discover.createSpace
class _Translations$discover$createSpace$de extends Translations$discover$createSpace$tr {
	_Translations$discover$createSpace$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Raum oder Gruppe erstellen';
	@override String get subtitle => 'Erreiche mehr Leute mit einer Gruppe oder einem Live-Raum';
	@override String get room => 'Raum';
	@override String get group => 'Gruppe';
	@override String get hideAccount => 'Konto verbergen';
	@override String get create => 'Erstellen';
	@override String get cancel => 'Abbrechen';
	@override String get createRoomTitle => 'Raum erstellen';
	@override String get createGroupTitle => 'Gruppe erstellen';
	@override String get nameSubtitle => 'Gib deiner Gruppe einen Namen';
	@override String get nameHint => 'Nachteule';
	@override String createRoomFor({required Object count}) => 'Für ${count} Token erstellen';
}

// Path: discover.liveRoom
class _Translations$discover$liveRoom$de extends Translations$discover$liveRoom$tr {
	_Translations$discover$liveRoom$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get adminSuffix => '(Admin)';
	@override String get messageHint => 'Nachricht';
	@override String get quickReplyHey => 'Hey, alle zusammen!';
	@override String get quickReplyTopic => 'Was ist das Thema?';
	@override String get quickReplyNew => 'Ich bin neu hier!';
	@override String get sampleChatName => 'Sona';
	@override String get sampleChatBody => 'Was können wir machen? Was hast du im Kopf?';
	@override String get roomEnded => 'Der Raum wurde beendet.';
	@override String wantsToJoin({required Object name}) => '${name} möchte beitreten';
	@override String get approve => 'Annehmen';
}

// Path: discover.groupChat
class _Translations$discover$groupChat$de extends Translations$discover$groupChat$tr {
	_Translations$discover$groupChat$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String usersCount({required Object count}) => '${count} Nutzer';
	@override String get sampleVictoria => 'Mir ist so langweilig. Wollen wir was machen, Leute?';
	@override String get sampleSona => 'Was können wir machen? Was hast du im Kopf?';
	@override String get sampleOwn => 'Lass uns am Steg treffen';
}

// Path: discover.groupInfo
class _Translations$discover$groupInfo$de extends Translations$discover$groupInfo$tr {
	_Translations$discover$groupInfo$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get media => 'Medien';
	@override String get gallery => 'Galerie';
	@override String get settings => 'Einstellungen';
	@override String get notifications => 'Benachrichtigungen';
	@override String get blocked => 'Blockiert';
	@override String get private => 'Privat';
	@override String membersCount({required Object count}) => '${count} Mitglieder';
	@override String get addPeople => 'Leute hinzufügen';
	@override String get you => 'Du';
	@override String get admin => 'Admin';
	@override String get leaveGroup => 'Gruppe verlassen';
	@override String get requests => 'Beitrittsanfragen';
	@override String get approve => 'Annehmen';
	@override String get reject => 'Ablehnen';
	@override String get addPeopleEmpty => 'Folge Leuten, um sie zur Gruppe hinzuzufügen.';
	@override String get add => 'Hinzufügen';
	@override String get makeAdmin => 'Zum Admin machen';
	@override String get removeAdmin => 'Admin entfernen';
	@override String get remove => 'Aus Gruppe entfernen';
	@override String get leaveConfirm => 'Diese Gruppe verlassen?';
	@override String get leave => 'Verlassen';
	@override String get cancel => 'Abbrechen';
}

// Path: discover.filters
class _Translations$discover$filters$de extends Translations$discover$filters$tr {
	_Translations$discover$filters$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Filter';
	@override String get ageRange => 'Altersspanne';
	@override String ageRangeValue({required Object min, required Object max}) => '${min}-${max}';
	@override String get distance => 'Entfernung';
	@override String distanceValue({required Object km}) => '${km} km';
	@override String get showMe => 'Zeig mir';
	@override String get everyone => 'Alle';
	@override String get women => 'Frauen';
	@override String get men => 'Männer';
	@override String get interests => 'Interessen';
	@override String get activeNow => 'Gerade aktiv';
	@override String get activeNowSubtitle => 'Nur Leute anzeigen, die gerade online sind';
	@override String get showResult => 'Ergebnis anzeigen';
}

// Path: discover.post
class _Translations$discover$post$de extends Translations$discover$post$tr {
	_Translations$discover$post$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get follow => 'Folgen';
	@override String get following => 'Folge ich';
	@override String get addComment => 'Kommentar hinzufügen...';
	@override String get commentsTitle => 'Kommentare';
	@override String get sampleCaption => 'Es geht nichts über eine Tasse Kaffee nach einem schönen Tag. <3';
	@override String hoursAgo({required Object hours}) => '${hours} Std.';
	@override String minutesAgo({required Object minutes}) => '${minutes} Min.';
	@override String daysAgo({required Object days}) => '${days} T.';
	@override String get deleteCommentTitle => 'Diesen Kommentar löschen?';
}

// Path: discover.story
class _Translations$discover$story$de extends Translations$discover$story$tr {
	_Translations$discover$story$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get draft => 'ENTWURF';
	@override String get story => 'STORY';
	@override String get share => 'Teilen';
	@override String get textPlaceholder => 'Schreib etwas...';
	@override String get draftPrompt => 'Als Entwurf speichern?';
	@override String get saveToDraft => 'Als Entwurf speichern';
	@override String get moveToTrash => 'In den Papierkorb';
	@override String get save => 'Speichern';
	@override String get musicTitle => 'Musik';
	@override String get musicEmpty => 'Keine Musik gefunden.';
	@override String get musicError => 'Musik konnte nicht geladen werden.';
	@override String get downloaded => 'In der Galerie gespeichert';
	@override String get downloadFailed => 'Speichern fehlgeschlagen';
}

// Path: discover.highlight
class _Translations$discover$highlight$de extends Translations$discover$highlight$tr {
	_Translations$discover$highlight$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Highlight';
	@override String get view => 'Ansehen';
	@override String get aiComments => 'KI-Kommentare';
	@override String get remove => 'Highlight entfernen';
	@override String get sharedSuccess => 'Dein Beitrag wurde erfolgreich geteilt';
	@override String get boost => 'Boosten';
}

// Path: discover.stats
class _Translations$discover$stats$de extends Translations$discover$stats$tr {
	_Translations$discover$stats$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Statistiken';
	@override String get subtitle => 'Hier siehst du die Statistiken\nzu deinem Beitrag.';
	@override String get viewers => 'Aufrufe';
	@override String get comments => 'Kommentare';
	@override String get likes => 'Likes';
	@override String get boostCta => '1 Tag boosten - 100 Token';
	@override String get boosted => 'Geboostet! Dein Beitrag ist 24 Stunden lang ganz oben.';
}

// Path: createProfile.interests
class _Translations$createProfile$interests$de extends Translations$createProfile$interests$tr {
	_Translations$createProfile$interests$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get music => 'Musik';
	@override String get movies => 'Filme';
	@override String get tvShows => 'Serien';
	@override String get reading => 'Lesen';
	@override String get painting => 'Malen';
	@override String get photography => 'Fotografie';
	@override String get theatre => 'Theater';
	@override String get fitness => 'Fitness';
	@override String get swimming => 'Schwimmen';
	@override String get football => 'Fußball';
	@override String get basketball => 'Basketball';
	@override String get coffee => 'Kaffee';
	@override String get travel => 'Reisen';
	@override String get camping => 'Camping';
	@override String get meditation => 'Meditation';
	@override String get videoGames => 'Videospiele';
	@override String get boardGames => 'Brettspiele';
	@override String get standUp => 'Stand-up-Comedy';
	@override String get tech => 'Technik';
	@override String get coding => 'Programmieren';
	@override String get ai => 'KI';
	@override String get podcast => 'Podcasts';
}

/// The flat map containing all translations for locale <de>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsDe {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.name' => 'Veylo',
			'app.tagline' => 'Willkommen',
			'home.title' => 'Start',
			'home.subtitle' => 'App wird vorbereitet',
			'home.body' => 'Die mehrsprachige Oberfläche wird mit slang verwaltet.',
			'chats.title' => 'Chats',
			'chats.search' => 'Suchen',
			'chats.messagesSection' => 'Nachrichten',
			'chats.request' => 'Anfragen',
			'chats.emptyRequestTitle' => 'Keine neuen Nachrichten-\nbenachrichtigungen',
			'chats.emptyRequestSubtitle' => 'Anfragen, die älter als 30 Tage sind, werden nicht angezeigt.',
			'chats.noteAdd' => 'Notiz hinzufügen',
			'chats.anonymous' => 'Anonym',
			'chats.online' => 'online',
			'chats.offline' => 'offline',
			'chats.connection' => 'Verbindung',
			'chats.connectionPercent' => ({required Object n}) => '${n}%',
			'chats.connectionProgressTitle' => 'Verbindungsfortschritt',
			'chats.milestoneInitial' => 'Anfangsbuchstabe des Vornamens',
			'chats.milestoneInitialHint' => 'Freigeschaltet bei 25%',
			'chats.milestoneInitialLocked' => 'Wird bei 25% freigeschaltet',
			'chats.milestonePhoto' => 'Verschwommene Fotovorschau',
			'chats.milestonePhotoHint' => 'Wird bei 70% freigeschaltet',
			'chats.milestoneFull' => 'Komplettes Profil ansehen',
			'chats.milestoneFullHint' => 'Gegenseitige Zustimmung bei 100%',
			'chats.sampleAnonymousMessage' => 'Hallo, schön, dich kennenzulernen. Magst du mir ein bisschen von dir erzählen?',
			'chats.strangerSampleMessage' => 'Hallo Jhon, schön, dich kennenzulernen. Magst du mir ein bisschen von dir erzählen?',
			'chats.approve' => 'Annehmen',
			'chats.blockUser' => 'Nutzer blockieren',
			'chats.reject' => 'Ablehnen',
			'chats.messageHint' => 'Hi! Wie geht’s dir?',
			'chats.revealTitle' => 'Ihr habt 100% erreicht',
			'chats.revealSubtitle' => 'Wollt ihr euch eure kompletten Profile zeigen? Beide müssen zustimmen.',
			'chats.revealWaiting' => ({required Object name}) => 'Warte, bis ${name} zustimmt',
			'chats.revealCta' => 'Mein Profil zeigen',
			'chats.revealNotYet' => 'Noch nicht',
			'chats.seen' => 'Gesehen',
			'chats.typing' => 'schreibt…',
			'chats.noteYou' => 'Du',
			'chats.noteSheetTitle' => 'Notiz teilen',
			'chats.noteSheetSubtitle' => 'Deine Notiz bleibt 24 Stunden sichtbar',
			'chats.noteHint' => 'Was geht dir durch den Kopf?',
			'chats.noteShare' => 'Teilen',
			'chats.noteDelete' => 'Notiz löschen',
			'profile.eyebrow' => 'Profil',
			'profile.title' => 'Einstellungen',
			'profile.editProfile' => 'Profil bearbeiten',
			'profile.statLike' => 'Likes',
			'profile.statFollow' => 'Folge ich',
			'profile.statFollower' => 'Follower',
			'profile.promoTitle' => 'Mehr Nachrichten bekommen!',
			'profile.promoSubtitle' => 'Fall auf und erscheine ganz oben in der Liste',
			'profile.standOut' => 'Auffallen',
			'profile.tabPosts' => 'Beiträge',
			'profile.tabVideo' => 'Video',
			'profile.tabSaved' => 'Gespeichert',
			'profile.save' => 'Speichern',
			'profile.changePhoto' => 'Foto ändern',
			'profile.changeBorder' => 'Rahmen ändern',
			'profile.interest' => 'Interessen',
			'profile.name' => 'Name',
			'profile.changeName' => 'Name ändern',
			'profile.changePassword' => 'Passwort ändern',
			'profile.confirmPassword' => 'Passwort bestätigen',
			'profile.email' => 'E-Mail',
			'profile.accountManagement' => 'Kontoverwaltung',
			'profile.settingsAbout' => 'Info',
			'profile.settingsAccount' => 'Kontoeinstellungen',
			'profile.settingsSupport' => 'Support',
			'profile.shareApp' => 'App teilen',
			'profile.shareAppTitle' => 'Mit Freunden teilen',
			'profile.shareAppSubtitle' => 'Teile Veylo mit deinen Freunden und entdeckt es gemeinsam!',
			'profile.shareAppLabel' => 'App-Link',
			'profile.rateApp' => 'Gefällt dir die App? Bewerte uns',
			'profile.notifications' => 'Benachrichtigungen',
			'profile.password' => 'Passwort',
			'profile.deleteConversation' => 'Unterhaltungen löschen',
			'profile.faqHelp' => 'FAQ & Hilfe',
			'profile.restorePurchases' => 'Käufe wiederherstellen',
			'profile.termsOfService' => 'Nutzungsbedingungen',
			'profile.privacyPolicy' => 'Datenschutzerklärung',
			'profile.restorePurchasesDone' => 'Käufe überprüft',
			'profile.conversationsDeleted' => 'Alle Unterhaltungen gelöscht',
			'profile.logOut' => 'Abmelden',
			'profile.deleteAccountAndData' => 'Konto und Daten löschen',
			'profile.passwordPlaceholder' => '********',
			'profile.height' => 'Größe',
			'profile.addHeight' => 'Größe hinzufügen',
			'profile.heightCm' => ({required Object value}) => '${value} cm',
			'profile.languages' => 'Sprachen',
			'profile.relationshipGoals' => 'Beziehungsziele',
			'profile.lookingFor' => 'Auf der Suche nach',
			'profile.newFriends' => '👋 Neuen Freunden',
			'profile.goalLongTermOpenToShort' => '💕 Langfristig, offen für Kurzes',
			'profile.goalLongTermRelationship' => '💘 Feste Beziehung',
			'profile.goalNewFriends' => '👋 Neue Freunde',
			'profile.goalShortTermFun' => '🥃 Kurzer Spaß',
			'profile.goalStillFiguringItOut' => '🤔 Weiß ich noch nicht',
			'profile.basics' => 'Basics',
			'profile.zodiac' => 'Sternzeichen',
			'profile.zodiacValue' => 'Skorpion',
			'profile.education' => 'Bildung',
			'profile.educationValue' => 'Bachelor',
			'profile.educationHighSchool' => 'Abitur',
			'profile.educationAssociates' => 'Berufsausbildung',
			'profile.educationBachelors' => 'Bachelor',
			'profile.educationMasters' => 'Master',
			'profile.educationPhd' => 'Promotion',
			'profile.voiceRecord' => 'Sprachaufnahme',
			'profile.addVoice' => 'Stimme hinzufügen',
			'profile.lifestyle' => 'Lebensstil',
			'profile.pets' => 'Haustiere',
			'profile.petsValue' => 'Ich habe eine Katze',
			'profile.petsDontWant' => 'Ich möchte keine Haustiere',
			'profile.petsAllergic' => 'Ich bin allergisch gegen Tiere',
			'profile.petsHaveCat' => 'Ich habe eine Katze',
			'profile.petsHaveDog' => 'Ich habe einen Hund',
			'profile.petsHaveCatsAndDogs' => 'Ich habe Katzen und Hunde',
			'profile.petsHaveOther' => 'Ich habe andere Haustiere',
			'profile.drinking' => 'Alkohol',
			'profile.drinkingValue' => 'Zu besonderen Anlässen',
			'profile.drinkingNever' => 'Nie',
			'profile.drinkingSpecialOccasions' => 'Zu besonderen Anlässen',
			'profile.drinkingSocially' => 'Gesellig',
			'profile.drinkingFrequently' => 'Häufig',
			'profile.drinkingSober' => 'Nüchtern',
			'profile.drinkingPreferNotToSay' => 'Keine Angabe',
			'profile.smoking' => 'Rauchen',
			'profile.smokingValue' => 'Nichtraucher',
			'profile.smokingNonSmoker' => 'Nichtraucher',
			'profile.smokingSocialSmoker' => 'Gelegenheitsraucher',
			'profile.smokingSmoker' => 'Raucher',
			'profile.smokingTryingToQuit' => 'Versuche aufzuhören',
			'profile.smokingWhenDrinking' => 'Raucher beim Trinken',
			'profile.smokingPreferNotToSay' => 'Keine Angabe',
			'profile.gender' => 'Geschlecht',
			'profile.genderFemale' => 'Weiblich',
			'profile.genderMale' => 'Männlich',
			'profile.genderPreferNotToSay' => 'Möchte ich nicht angeben',
			'profile.visible' => 'Sichtbar',
			'profile.profileVisibility' => 'Profilsichtbarkeit',
			'profile.language' => 'Sprache',
			'profile.borderTitle' => 'Profilrahmen',
			'profile.borderSubtitle' => 'Gib deinem Profil einen Rahmen,\ndamit du auffällst.',
			'profile.borderBuySection' => 'Rahmen kaufen',
			'profile.borderBuyCta' => 'Rahmen kaufen',
			'profile.borderToken' => ({required Object count}) => '${count} Token',
			'profile.borderAmethystWings' => 'Amethyst Wings',
			'profile.borderGoldenPhoenix' => 'Golden Phoenix',
			'profile.borderFrostCrown' => 'Frost Crown',
			'profile.borderEmeraldWhisper' => 'Emerald Whisper',
			'profile.borderRoseQuartz' => 'Rose Quartz',
			'profile.borderStarlitComet' => 'Starlit Comet',
			'profile.borderCrimsonRoyal' => 'Crimson Royal',
			'profile.borderSapphireHalo' => 'Sapphire Halo',
			'profile.follow' => 'Folgen',
			'profile.following' => 'Folge ich',
			'profile.followPageTitle' => 'Folgen',
			'profile.followTabFollowing' => 'Folge ich',
			'profile.followTabFollowers' => 'Follower',
			'profile.followSearch' => 'Suchen',
			'profile.unfollow' => 'Entfolgen',
			'profile.followSortTitle' => 'Sortieren',
			'profile.followSortRecent' => 'Zuletzt gefolgt',
			'profile.followSortNotFollowingMe' => 'Folgen mir nicht zurück',
			'profile.followSortNotFollowedByMe' => 'Denen ich nicht zurückfolge',
			'profile.followSortShowResult' => 'Ergebnis anzeigen',
			'profile.followSortEmpty' => 'Keine Nutzer passen zu diesem Filter',
			'profile.shareTitle' => 'Mit Freunden teilen',
			'profile.shareSubtitle' => 'Alles macht mehr Spaß, wenn du dich\nmit deinen Freunden verbindest!',
			'profile.shareProfileLabel' => 'Profil teilen',
			'profile.shareLinkCopied' => 'Link kopiert',
			'profile.restrict' => 'Einschränken',
			'profile.block' => 'Blockieren',
			'profile.report' => 'Melden',
			'profile.blockTitle' => ({required Object username}) => '${username} blockieren?',
			'profile.blockBody' => 'Damit werden auch alle anderen Konten blockiert, die diese Person hat oder künftig erstellt. Du kannst die Blockierung jederzeit aufheben.',
			'profile.blockAndReport' => 'Blockieren und melden',
			'profile.restrictTitle' => ({required Object username}) => '${username} einschränken?',
			'profile.restrictBody' => 'Die Person sieht dann nicht, wann du online bist oder ob du ihre Nachrichten gelesen hast. Du kannst das jederzeit ändern.',
			'profile.restrictAndReport' => 'Einschränken und melden',
			'profile.reportTitle' => 'Wir würden gern wissen, warum',
			'profile.reportSubtitle' => 'Damit wir dir ein besseres Erlebnis bieten können: Magst du uns sagen, warum du diesen Nutzer melden möchtest?',
			'profile.reportMessageLabel' => 'Nachricht zur Meldung',
			'profile.reportMessageHint' => 'Schreib deine Nachricht',
			'profile.reportCancel' => 'Abbrechen',
			'profile.sendReport' => 'Meldung senden',
			'profile.notSet' => 'Nicht angegeben',
			'profile.reportSent' => 'Danke, wir haben deine Meldung erhalten.',
			'profile.emailVerificationSent' => ({required Object email}) => 'Wir haben einen Bestätigungslink an ${email} gesendet. Deine E-Mail ändert sich, sobald du bestätigst.',
			'profile.passwordChanged' => 'Dein Passwort wurde aktualisiert.',
			'profile.passwordMismatch' => 'Die Passwörter stimmen nicht überein.',
			'nav.discover' => 'Entdecken',
			'nav.chat' => 'Chat',
			'nav.call' => 'Anruf',
			'nav.vibes' => 'Vibes',
			'nav.profile' => 'Profil',
			'call.title' => '60-Sekunden-Fremde',
			'call.subtitle' => 'Sprich 60 Sekunden lang mit einer zufälligen fremden Person – komplett anonym. Kein Profil, kein Foto, kein Name. Nur eine Stimme und ein Moment.',
			'call.findingTitle' => 'Suche nach jemandem...',
			'call.findingSubtitle' => 'Ihr sprecht 60 Sekunden lang anonym. Keine Profile, keine Namen.',
			'call.callStranger' => 'Fremde anrufen - 10 Token',
			'call.cancel' => 'Abbrechen',
			'call.female' => 'Weiblich',
			'call.male' => 'Männlich',
			'call.nonBinary' => 'Nicht-binär',
			'call.preferNotToSay' => 'Keine Angabe',
			'call.anonymousBadge' => '🎙️ Anonymer Sprachanruf',
			'call.stranger' => 'Fremde Person',
			'call.secondsLeft' => ({required Object n}) => '${n} s',
			'call.timesUpTitle' => 'Die Zeit ist um!',
			'call.timesUpSubtitle' => 'Wollt ihr weiterreden? Wenn ihr beide Ja sagt, wird der Chat freigeschaltet.',
			'call.keepTalking' => 'Weiterreden',
			'call.endCall' => 'Auflegen',
			'call.waitingOther' => 'Warte auf die andere Person...',
			'call.callStrangerFree' => 'Fremde anrufen',
			'call.peerLeft' => 'Die andere Person hat aufgelegt.',
			'call.noKeep' => 'Der Chat wurde diesmal nicht freigeschaltet.',
			'call.videoWaiting' => 'Warte, bis der Videoanruf angenommen wird...',
			'call.videoDeclined' => 'Der Videoanruf wurde abgelehnt.',
			'call.micDenied' => 'Für Anrufe brauchen wir Zugriff auf dein Mikrofon. Du kannst ihn in den Einstellungen erlauben.',
			'call.videoCost' => 'Videoanruf: 20 Token / 15 Min.',
			'call.calling' => 'Anruf läuft',
			'call.accept' => 'Annehmen',
			'call.decline' => 'Ablehnen',
			'call.switchToVideo' => 'Möchtest du zu einem Videoanruf wechseln?',
			'vibes.search' => 'Suchen',
			'vibes.sendMessage' => 'Nachricht senden',
			'vibes.wantsToTalk' => 'Will gerade darüber reden',
			'vibes.shareTitle' => 'Vibe teilen',
			'vibes.replyTitle' => 'Auf Vibe antworten',
			'vibes.shareHint' => 'Schreib etwas',
			'vibes.shareAnonymous' => 'Anonym teilen',
			'vibes.empty' => 'Keine Vibes in den letzten 24 Stunden. Teile den ersten!',
			'vibes.deleteTitle' => 'Diesen Vibe löschen?',
			'vibes.delete' => 'Löschen',
			'vibes.cancel' => 'Abbrechen',
			'discover.title' => 'Entdecken',
			'discover.tabRooms' => 'Räume',
			'discover.tabDiscover' => 'Entdecken',
			'discover.tabAiMatch' => 'AI Match',
			'discover.aiMatch.feelingTitle' => 'Wie fühlst du dich heute?',
			'discover.aiMatch.feelingSubtitle' => 'Die KI findet das beste Match passend zu deiner Wahl',
			'discover.aiMatch.lookingTitle' => 'Wonach suchst du?',
			'discover.aiMatch.moodSad' => 'Traurig',
			'discover.aiMatch.moodMeltie' => 'Naja',
			'discover.aiMatch.moodBored' => 'Gelangweilt',
			'discover.aiMatch.moodCrying' => 'Down',
			'discover.aiMatch.moodSmile' => 'Glücklich',
			'discover.aiMatch.lookingNewFriends' => 'Neue Freunde',
			'discover.aiMatch.lookingVenting' => 'Dampf ablassen',
			'discover.aiMatch.lookingFlirty' => 'Flirten',
			'discover.aiMatch.lookingFun' => 'Spaß',
			'discover.aiMatch.lookingCultures' => 'Neue Kulturen',
			'discover.aiMatch.lookingLanguage' => 'Sprache üben',
			'discover.aiMatch.statActiveUsers' => 'Aktive Nutzer',
			'discover.aiMatch.statMatchRate' => 'Match-Rate',
			'discover.aiMatch.statAvgTime' => 'Ø Zeit',
			'discover.aiMatch.statActiveValue' => '843',
			'discover.aiMatch.statMatchValue' => '87%',
			'discover.aiMatch.statAvgValue' => '8 s',
			'discover.aiMatch.startSmartMatch' => 'Smart Match starten',
			'discover.aiMatch.findingTitle' => 'Wir suchen dein Match',
			'discover.aiMatch.findingSubtitle' => 'Wir bringen deine Stimmung und Interessen mit der richtigen Person zusammen',
			'discover.aiMatch.findingStepMood' => 'Stimmung analysiert',
			'discover.aiMatch.findingStepInterests' => 'Interessen abgeglichen',
			'discover.aiMatch.findingStepCompatibility' => 'Kompatibilität wird berechnet...',
			'discover.aiMatch.findingStepContent' => 'Inhalte werden erstellt...',
			'discover.aiMatch.findingOnline' => ({required Object count}) => '${count} Leute gerade online',
			'discover.aiMatch.yourMatchTitle' => 'Dein Match',
			'discover.aiMatch.yourMatchSubtitle' => 'Dein Match basiert auf deinen Antworten',
			'discover.aiMatch.vibeMatch' => ({required Object percent}) => '${percent}% Vibe-Match',
			'discover.aiMatch.startChatting' => 'Chat starten',
			'discover.aiMatch.matchNameAge' => ({required Object name, required Object age}) => '${name}, ${age}',
			'discover.aiMatch.matchBio' => 'Ich lasse dich Dinge fühlen, von denen du nicht wusstest, dass du sie fühlen kannst.',
			'discover.aiMatch.swipePrevious' => 'Zurück',
			'discover.aiMatch.swipeNext' => 'Weiter',
			'discover.aiMatch.swipeFinger' => 'Wischen',
			'discover.aiMatch.noMatch' => 'Gerade passt niemand. Versuch es gleich noch mal.',
			'discover.searchHint' => 'Suchen',
			'discover.allRooms' => 'Alle Räume',
			'discover.allGroups' => 'Alle Gruppen',
			'discover.seeAll' => 'Alle ansehen',
			'discover.live' => 'Live',
			'discover.join' => 'Beitreten',
			'discover.request' => 'Anfragen',
			'discover.requested' => 'Angefragt',
			'discover.private' => 'Privat',
			'discover.moreCount' => ({required Object count}) => '+${count} weitere',
			'discover.activeCount' => ({required Object count}) => '${count} aktiv',
			'discover.membersCount' => ({required Object count}) => '${count} Mitglieder',
			'discover.privateRoom.subtitle' => 'Das ist ein privater Raum. Schalte den Zugang mit Token frei.',
			'discover.privateRoom.roomAccess' => 'Raumzugang',
			'discover.privateRoom.yourBalance' => 'Dein Guthaben',
			'discover.privateRoom.tokensAmount' => ({required Object count}) => '${count} Token',
			'discover.privateRoom.joinForTokens' => ({required Object count}) => 'Für ${count} Token beitreten',
			'discover.privateRoom.cancel' => 'Abbrechen',
			'discover.roomToken.subtitle' => 'Schalte den Zugang mit Token frei.',
			'discover.roomToken.roomAccess' => 'Raumzugang',
			'discover.roomToken.yourBalance' => 'Dein Guthaben',
			'discover.roomToken.tokensAmount' => ({required Object count}) => '${count} Token',
			'discover.roomToken.joinForTokens' => ({required Object count}) => 'Für ${count} Token beitreten',
			'discover.roomToken.cancel' => 'Abbrechen',
			'discover.privateRequest.title' => 'Beitritt anfragen',
			'discover.privateRequest.roomInfo' => ({required Object name, required Object count}) => '${name} · ${count} Mitglieder',
			'discover.privateRequest.messageHint' => 'Sag etwas (optional)...',
			'discover.privateRequest.sendRequest' => 'Anfrage senden',
			'discover.privateRequest.adminReview' => 'Der Raum-Admin prüft deine Anfrage',
			'discover.roomApproved.title' => 'Du bist drin!',
			'discover.roomApproved.subtitle' => ({required Object name}) => 'Dein Platz in ${name} ist reserviert',
			'discover.roomApproved.continueLabel' => 'Weiter',
			'discover.createSpace.title' => 'Raum oder Gruppe erstellen',
			'discover.createSpace.subtitle' => 'Erreiche mehr Leute mit einer Gruppe oder einem Live-Raum',
			'discover.createSpace.room' => 'Raum',
			'discover.createSpace.group' => 'Gruppe',
			'discover.createSpace.hideAccount' => 'Konto verbergen',
			'discover.createSpace.create' => 'Erstellen',
			'discover.createSpace.cancel' => 'Abbrechen',
			'discover.createSpace.createRoomTitle' => 'Raum erstellen',
			'discover.createSpace.createGroupTitle' => 'Gruppe erstellen',
			'discover.createSpace.nameSubtitle' => 'Gib deiner Gruppe einen Namen',
			'discover.createSpace.nameHint' => 'Nachteule',
			'discover.createSpace.createRoomFor' => ({required Object count}) => 'Für ${count} Token erstellen',
			'discover.liveRoom.adminSuffix' => '(Admin)',
			'discover.liveRoom.messageHint' => 'Nachricht',
			'discover.liveRoom.quickReplyHey' => 'Hey, alle zusammen!',
			'discover.liveRoom.quickReplyTopic' => 'Was ist das Thema?',
			'discover.liveRoom.quickReplyNew' => 'Ich bin neu hier!',
			'discover.liveRoom.sampleChatName' => 'Sona',
			'discover.liveRoom.sampleChatBody' => 'Was können wir machen? Was hast du im Kopf?',
			'discover.liveRoom.roomEnded' => 'Der Raum wurde beendet.',
			'discover.liveRoom.wantsToJoin' => ({required Object name}) => '${name} möchte beitreten',
			'discover.liveRoom.approve' => 'Annehmen',
			'discover.groupChat.usersCount' => ({required Object count}) => '${count} Nutzer',
			'discover.groupChat.sampleVictoria' => 'Mir ist so langweilig. Wollen wir was machen, Leute?',
			'discover.groupChat.sampleSona' => 'Was können wir machen? Was hast du im Kopf?',
			'discover.groupChat.sampleOwn' => 'Lass uns am Steg treffen',
			'discover.groupInfo.media' => 'Medien',
			'discover.groupInfo.gallery' => 'Galerie',
			'discover.groupInfo.settings' => 'Einstellungen',
			'discover.groupInfo.notifications' => 'Benachrichtigungen',
			'discover.groupInfo.blocked' => 'Blockiert',
			'discover.groupInfo.private' => 'Privat',
			'discover.groupInfo.membersCount' => ({required Object count}) => '${count} Mitglieder',
			'discover.groupInfo.addPeople' => 'Leute hinzufügen',
			'discover.groupInfo.you' => 'Du',
			'discover.groupInfo.admin' => 'Admin',
			'discover.groupInfo.leaveGroup' => 'Gruppe verlassen',
			'discover.groupInfo.requests' => 'Beitrittsanfragen',
			'discover.groupInfo.approve' => 'Annehmen',
			'discover.groupInfo.reject' => 'Ablehnen',
			'discover.groupInfo.addPeopleEmpty' => 'Folge Leuten, um sie zur Gruppe hinzuzufügen.',
			'discover.groupInfo.add' => 'Hinzufügen',
			'discover.groupInfo.makeAdmin' => 'Zum Admin machen',
			'discover.groupInfo.removeAdmin' => 'Admin entfernen',
			'discover.groupInfo.remove' => 'Aus Gruppe entfernen',
			'discover.groupInfo.leaveConfirm' => 'Diese Gruppe verlassen?',
			'discover.groupInfo.leave' => 'Verlassen',
			'discover.groupInfo.cancel' => 'Abbrechen',
			'discover.filters.title' => 'Filter',
			'discover.filters.ageRange' => 'Altersspanne',
			'discover.filters.ageRangeValue' => ({required Object min, required Object max}) => '${min}-${max}',
			'discover.filters.distance' => 'Entfernung',
			'discover.filters.distanceValue' => ({required Object km}) => '${km} km',
			'discover.filters.showMe' => 'Zeig mir',
			'discover.filters.everyone' => 'Alle',
			'discover.filters.women' => 'Frauen',
			'discover.filters.men' => 'Männer',
			'discover.filters.interests' => 'Interessen',
			'discover.filters.activeNow' => 'Gerade aktiv',
			'discover.filters.activeNowSubtitle' => 'Nur Leute anzeigen, die gerade online sind',
			'discover.filters.showResult' => 'Ergebnis anzeigen',
			'discover.post.follow' => 'Folgen',
			'discover.post.following' => 'Folge ich',
			'discover.post.addComment' => 'Kommentar hinzufügen...',
			'discover.post.commentsTitle' => 'Kommentare',
			'discover.post.sampleCaption' => 'Es geht nichts über eine Tasse Kaffee nach einem schönen Tag. <3',
			'discover.post.hoursAgo' => ({required Object hours}) => '${hours} Std.',
			'discover.post.minutesAgo' => ({required Object minutes}) => '${minutes} Min.',
			'discover.post.daysAgo' => ({required Object days}) => '${days} T.',
			'discover.post.deleteCommentTitle' => 'Diesen Kommentar löschen?',
			'discover.story.draft' => 'ENTWURF',
			'discover.story.story' => 'STORY',
			'discover.story.share' => 'Teilen',
			'discover.story.textPlaceholder' => 'Schreib etwas...',
			'discover.story.draftPrompt' => 'Als Entwurf speichern?',
			'discover.story.saveToDraft' => 'Als Entwurf speichern',
			'discover.story.moveToTrash' => 'In den Papierkorb',
			'discover.story.save' => 'Speichern',
			'discover.story.musicTitle' => 'Musik',
			'discover.story.musicEmpty' => 'Keine Musik gefunden.',
			'discover.story.musicError' => 'Musik konnte nicht geladen werden.',
			'discover.story.downloaded' => 'In der Galerie gespeichert',
			'discover.story.downloadFailed' => 'Speichern fehlgeschlagen',
			'discover.highlight.title' => 'Highlight',
			'discover.highlight.view' => 'Ansehen',
			'discover.highlight.aiComments' => 'KI-Kommentare',
			'discover.highlight.remove' => 'Highlight entfernen',
			'discover.highlight.sharedSuccess' => 'Dein Beitrag wurde erfolgreich geteilt',
			'discover.highlight.boost' => 'Boosten',
			'discover.stats.title' => 'Statistiken',
			'discover.stats.subtitle' => 'Hier siehst du die Statistiken\nzu deinem Beitrag.',
			'discover.stats.viewers' => 'Aufrufe',
			'discover.stats.comments' => 'Kommentare',
			'discover.stats.likes' => 'Likes',
			'discover.stats.boostCta' => '1 Tag boosten - 100 Token',
			'discover.stats.boosted' => 'Geboostet! Dein Beitrag ist 24 Stunden lang ganz oben.',
			'discover.hostedBy' => ({required Object name}) => 'Gehostet von ${name}',
			'common.loading' => 'Wird geladen…',
			'common.retry' => 'Erneut versuchen',
			'common.cancel' => 'Abbrechen',
			'common.save' => 'Speichern',
			'common.continueAction' => 'Weiter',
			'common.language' => 'Sprache',
			'common.or' => 'ODER',
			'languages.tr' => 'Türkçe',
			'languages.en' => 'English',
			'auth.createAccountTitle' => 'Erstelle dein Konto',
			'auth.createAccountSubtitle' => 'Tritt Veylo bei und knüpf neue Kontakte.',
			'auth.welcomeBackTitle' => 'Willkommen zurück',
			'auth.welcomeBackSubtitle' => 'Melde dich an, um mit Veylo weiterzumachen.',
			'auth.username' => 'Nutzername',
			'auth.usernameHint' => 'Wähle einen Nutzernamen',
			'auth.email' => 'E-Mail',
			'auth.emailHint' => 'Gib deine E-Mail ein',
			'auth.emailOrUsername' => 'E-Mail oder Nutzername',
			'auth.emailOrUsernameHint' => 'Wähle einen Nutzernamen',
			'auth.password' => 'Passwort',
			'auth.passwordCreateHint' => 'Erstelle ein Passwort',
			'auth.passwordEnterHint' => 'Gib dein Passwort ein',
			'auth.signUp' => 'Registrieren',
			'auth.logIn' => 'Anmelden',
			'auth.forgotPassword' => 'Passwort vergessen?',
			'auth.continueWithApple' => 'Weiter mit Apple',
			'auth.continueWithGoogle' => 'Weiter mit Google',
			'auth.legalPrefix' => 'Indem du fortfährst, stimmst du unseren ',
			'auth.termsOfService' => 'Nutzungsbedingungen',
			'auth.legalMiddle' => ' zu und bestätigst unsere ',
			'auth.privacyPolicy' => 'Datenschutzerklärung',
			'auth.legalSuffix' => '.',
			'auth.passwordResetSent' => 'Wir haben dir einen Link zum Zurücksetzen des Passworts per E-Mail geschickt.',
			'onboarding.skip' => 'Überspringen',
			'onboarding.page1Title' => 'Sei du selbst. Bleib anonym.',
			'onboarding.page1Subtitle' => 'Lerne neue Leute kennen und starte Gespräche,\nohne zu verraten, wer du bist.',
			'onboarding.page2Title' => 'Schreiben. Reden. Den Vibe spüren.',
			'onboarding.page2Subtitle' => 'Starte anonym und schreib, ruf an oder triff dich persönlich, wenn du bereit bist.',
			'onboarding.page3Title' => 'Finde deine Leute. Mach\nmit beim Gespräch.',
			'onboarding.page3Subtitle' => 'Spring in Räume, lerne neue Leute kennen\nund teilt den Moment zusammen.',
			'onboarding.getStarted' => 'Los geht’s',
			'onboarding.alreadyHaveAccount' => 'Du hast schon ein Veylo-Konto? ',
			'onboarding.logInAction' => 'Anmelden',
			'createProfile.navTitle' => 'Profil erstellen',
			'createProfile.stepUsername' => '1/5 Nutzername',
			'createProfile.title' => 'Erstelle dein Profil',
			'createProfile.subtitle' => 'Dein echter Name dient nur zur Verifizierung – er wird nicht öffentlich angezeigt.',
			'createProfile.subtitleLine1' => 'Dein echter Name dient nur zur Verifizierung – er',
			'createProfile.subtitleLine2' => 'wird nicht öffentlich angezeigt.',
			'createProfile.fullName' => 'Vollständiger Name',
			'createProfile.fullNameHint' => 'Sam Lee',
			'createProfile.username' => 'Nutzername',
			'createProfile.usernameHint' => 'samlee123',
			'createProfile.usernameTaken' => 'Dieser Nutzername ist schon vergeben!',
			'createProfile.usernameAvailable' => 'Nutzername ist verfügbar',
			'createProfile.mightWantToTry' => 'Wie wäre es mit...',
			'createProfile.stepPhoto' => '2/5 Profilfoto',
			'createProfile.photoTitle' => 'Lade ein Profilfoto hoch',
			'createProfile.photoSubtitle' => 'Andere können dein Profilfoto sehen, um sicherzugehen, dass du es bist.',
			'createProfile.photoSubtitleLine1' => 'Andere können dein Profilfoto sehen, um',
			'createProfile.photoSubtitleLine2' => 'sicherzugehen, dass du es bist.',
			'createProfile.choosePhoto' => 'Foto auswählen',
			'createProfile.continueWithoutPhoto' => 'Ohne Profilfoto fortfahren',
			'createProfile.saveAndContinue' => 'Speichern & weiter',
			'createProfile.choosePhotoSheetTitle' => 'Foto auswählen',
			'createProfile.takePhoto' => 'Foto aufnehmen',
			'createProfile.chooseFromGallery' => 'Aus Mediathek wählen',
			'createProfile.stepGender' => '3/5 Geschlecht',
			'createProfile.genderTitle' => 'Wähle dein Geschlecht',
			'createProfile.genderSubtitle' => 'Wenn du uns diese Angabe machst, können wir damit Inhalte für dich personalisieren',
			'createProfile.genderSubtitleLine1' => 'Wenn du uns diese Angabe machst, können wir',
			'createProfile.genderSubtitleLine2' => 'damit Inhalte für dich personalisieren',
			'createProfile.genderFemale' => 'Weiblich',
			'createProfile.genderMale' => 'Männlich',
			'createProfile.genderNonBinary' => 'Nicht-binär',
			'createProfile.genderPreferNotToSay' => 'Keine Angabe',
			'createProfile.stepInterests' => '4/5 Interessen',
			'createProfile.interestsTitle' => 'Worauf stehst du?',
			'createProfile.interestsSubtitle' => 'Wähle mindestens 5 – so finden wir Leute, die dich wirklich verstehen.',
			'createProfile.interests.music' => 'Musik',
			'createProfile.interests.movies' => 'Filme',
			'createProfile.interests.tvShows' => 'Serien',
			'createProfile.interests.reading' => 'Lesen',
			'createProfile.interests.painting' => 'Malen',
			'createProfile.interests.photography' => 'Fotografie',
			'createProfile.interests.theatre' => 'Theater',
			'createProfile.interests.fitness' => 'Fitness',
			'createProfile.interests.swimming' => 'Schwimmen',
			'createProfile.interests.football' => 'Fußball',
			'createProfile.interests.basketball' => 'Basketball',
			'createProfile.interests.coffee' => 'Kaffee',
			'createProfile.interests.travel' => 'Reisen',
			'createProfile.interests.camping' => 'Camping',
			'createProfile.interests.meditation' => 'Meditation',
			'createProfile.interests.videoGames' => 'Videospiele',
			'createProfile.interests.boardGames' => 'Brettspiele',
			'createProfile.interests.standUp' => 'Stand-up-Comedy',
			'createProfile.interests.tech' => 'Technik',
			'createProfile.interests.coding' => 'Programmieren',
			'createProfile.interests.ai' => 'KI',
			'createProfile.interests.podcast' => 'Podcasts',
			'createProfile.stepChatGoal' => '5/5 Chat-Ziel',
			'createProfile.chatGoalTitle' => 'Wonach suchst du heute?',
			'createProfile.chatGoalSubtitle' => 'So finden wir das richtige Match für deine aktuelle Stimmung.',
			_ => null,
		} ?? switch (path) {
			'createProfile.chatGoalQuickMatch' => 'Schnelles Match – direkt rein\nins Gespräch',
			'createProfile.chatGoalFlirtyChat' => 'Flirt-Chat – leichte, verspielte\nGespräche',
			'createProfile.chatGoalMoodMatch' => 'Stimmungs-Match – passend dazu, wie\ndu dich fühlst',
			'createProfile.chatGoalLateNight' => 'Late-Night-Talk – tiefe Gespräche, wenn die\nWelt schläft',
			'createProfile.chatGoalMeetSomeoneNew' => 'Jemand Neues – kein bestimmtes Ziel,\neinfach entdecken',
			'createProfile.getStarted' => 'Los geht’s',
			'createProfile.preparingTitleLine1' => 'Wir bereiten',
			'createProfile.preparingTitleLine2' => 'passende Profile für',
			'createProfile.preparingTitleLine3' => 'dich vor.',
			'createProfile.preparingSubtitleLine1' => 'Anhand deiner Antworten wählen wir',
			'createProfile.preparingSubtitleLine2' => 'die besten Matches aus – einen Moment bitte.',
			'createProfile.preparingPercent' => ({required Object percent}) => '${percent} %',
			'createProfile.usernameInvalid' => 'Nutze 3–30 Buchstaben, Zahlen, Punkte oder Unterstriche.',
			'errors.network' => 'Veylo ist nicht erreichbar. Prüfe deine Verbindung und versuch es erneut.',
			'errors.generic' => 'Etwas ist schiefgelaufen. Bitte versuch es erneut.',
			'errors.signInFailed' => 'Anmeldung fehlgeschlagen. Bitte versuch es erneut.',
			'errors.sessionExpired' => 'Deine Sitzung ist abgelaufen. Bitte melde dich erneut an.',
			'errors.accountSuspended' => 'Dieses Konto wurde gesperrt.',
			'errors.unsupportedImage' => 'Bitte wähle ein JPEG-, PNG- oder WebP-Foto.',
			'errors.fileTooLarge' => 'Diese Datei ist zu groß.',
			'errors.enterEmailForReset' => 'Gib oben deine E-Mail ein, um dein Passwort zurückzusetzen.',
			'errors.wrongCredentials' => 'E-Mail/Nutzername oder Passwort ist falsch.',
			'errors.emailInUse' => 'Diese E-Mail ist bereits registriert. Versuch dich anzumelden.',
			'errors.weakPassword' => 'Das Passwort muss mindestens 6 Zeichen haben.',
			'errors.invalidEmail' => 'Bitte gib eine gültige E-Mail-Adresse ein.',
			'errors.tooManyAttempts' => 'Zu viele Versuche. Bitte warte kurz und versuch es erneut.',
			'errors.fillAllFields' => 'Bitte fülle alle Felder aus.',
			'errors.insufficientTokens' => 'Nicht genug Token.',
			'errors.requestNotAccepted' => 'Nimm die Anfrage an, um zu antworten.',
			'errors.requestPendingLimit' => 'Du kannst weitere Nachrichten senden, sobald deine Anfrage angenommen wurde.',
			'errors.blocked' => 'Du kannst dieser Person keine Nachricht senden.',
			'errors.peerUnavailable' => 'Dieses Konto ist nicht mehr verfügbar.',
			'errors.vibeDailyLimit' => 'Du hast heute schon viele Vibes geteilt. Versuch es später erneut.',
			'errors.groupFull' => 'Diese Gruppe ist voll.',
			'errors.groupCreateLimit' => 'Du hast heute zu viele Gruppen erstellt. Versuch es später erneut.',
			'errors.notFound' => 'Das ist nicht mehr verfügbar.',
			'errors.recentLogin' => 'Aus Sicherheitsgründen: Melde dich ab und wieder an und versuch es dann noch einmal.',
			'errors.socialAccount' => 'Deine E-Mail und dein Passwort werden über dein Google- oder Apple-Konto verwaltet.',
			'errors.alreadyInCall' => 'Du bist bereits in einem Anruf.',
			'errors.roomPrivate' => 'Dieser Raum ist privat. Frag den Host, ob du beitreten darfst.',
			'errors.roomFull' => 'Dieser Raum ist voll.',
			'faq.q1' => 'Wie funktioniert die App?',
			'faq.q2' => 'Was ist ein anonymer Chat?',
			'faq.q3' => 'Was ist der Verbindungsfortschritt?',
			'faq.q4' => 'Wie zeige ich mein Profil?',
			'faq.q5' => 'Was ist 60-Sekunden-Fremde?',
			'faq.q6' => 'Was sind Vibes?',
			'faq.q7' => 'Wie bearbeite ich mein Profil?',
			'faq.q8' => 'Wie verwalte ich Benachrichtigungen?',
			'faq.q9' => 'Wie stelle ich Käufe wieder her?',
			'faq.q10' => 'Kann ich alle Unterhaltungen löschen?',
			'faq.q11' => 'Sind meine Daten sicher?',
			'faq.q12' => 'Wie blockiere oder melde ich jemanden?',
			'faq.q13' => 'Wie teile ich die App?',
			'faq.q14' => 'Wie lösche ich mein Konto?',
			'faq.a1' => 'Auf Veylo lernst du anonym neue Leute kennen, chattest und zeigst nach und nach mehr von deinem Profil, je stärker eure Verbindung wird. Wechselt zu Text, Sprache oder einem persönlichen Treffen, wann immer ihr beide bereit seid.',
			'faq.a2' => 'Im anonymen Chat bleiben deine Identität und dein Foto verborgen. Je stärker die Verbindung, desto mehr schaltest du frei, etwa den Anfangsbuchstaben des Namens und ein verschwommenes Foto. Bei 100% müssen beide zustimmen, um die kompletten Profile zu zeigen.',
			'faq.a3' => 'Während ihr chattet, steigt euer Verbindungsprozentsatz. Bei bestimmten Meilensteinen schaltest du den Anfangsbuchstaben des Namens, ein verschwommenes Foto und das komplette Profil frei. Tippe auf die Anzeige „Verbindung“, um Details zu sehen.',
			'faq.a4' => 'Wenn die Verbindung 100% erreicht, tippe auf „Mein Profil zeigen“. Wenn die andere Person ebenfalls zustimmt, werden beide kompletten Profile sichtbar.',
			'faq.a5' => 'Im Tab „Anruf“ bekommst du ein kurzes zufälliges Match. Wenn die Zeit um ist, könnt ihr weiterreden oder den Anruf beenden.',
			'faq.a6' => 'Mit Vibes entdeckst du Leute in deiner Nähe oder um dich herum in einer Karten-/Listenansicht und kannst mit jemandem, der dich interessiert, einen Chat starten.',
			'faq.a7' => 'Öffne den Tab „Profil“ und gehe zu „Profil bearbeiten“, um Namen, Fotos, Bio und Interessen zu aktualisieren. Änderungen erscheinen nach dem Speichern.',
			'faq.a8' => 'Öffne „Benachrichtigungen“ in den Einstellungen, um Hinweise zu Nachrichten, Matches und mehr ein- oder auszuschalten.',
			'faq.a9' => 'Gehe zu Einstellungen → Kontoverwaltung → Käufe wiederherstellen. Berechtigte Käufe mit demselben Store-Konto werden wiederhergestellt.',
			'faq.a10' => 'Ja. Nutze Einstellungen → Unterhaltungen löschen und bestätige. Alle Chats werden entfernt. Das kann nicht rückgängig gemacht werden.',
			'faq.a11' => 'Deine Kontodaten und Nachrichten werden auf geschützten Systemen gespeichert. Du kannst außerdem jederzeit in der Kontoverwaltung die Löschung deines Kontos und deiner Daten beantragen.',
			'faq.a12' => 'Nutze das Menü auf einem Profil oder im Chat, um jemanden zu blockieren oder zu melden. Meldungen werden von unserem Team geprüft.',
			'faq.a13' => 'Nutze „App teilen“ in den Einstellungen, um den Link zu kopieren und an Freunde zu senden.',
			'faq.a14' => 'Gehe zu Einstellungen → Kontoverwaltung → Konto und Daten löschen. Nenne einen Grund und bestätige, um deinen Löschantrag zu senden.',
			'legal.termsTitle' => 'Nutzungsbedingungen',
			'legal.privacyTitle' => 'Datenschutzerklärung',
			'legal.termsBody' => 'Zuletzt aktualisiert: 16. März 2026\n\nWillkommen bei Veylo. Indem du ein Konto erstellst oder die App nutzt, stimmst du diesen Nutzungsbedingungen zu.\n\n1. Was Veylo ist\nVeylo ist eine soziale App, in der du Leute kennenlernen, anonym chatten, mit der Zeit eine Verbindung aufbauen und optional zu Sprach- oder Videoanrufen wechseln kannst, wenn beide Seiten zustimmen.\n\n2. Dein Konto\nDu musst korrekte Angaben machen und deine Anmeldedaten sicher aufbewahren. Du bist für alle Aktivitäten unter deinem Konto verantwortlich. Du musst nach den Gesetzen deines Landes alt genug sein, um Veylo zu nutzen.\n\n3. Respektvolle Nutzung\nBelästige, bedrohe oder betrüge niemanden, gib dich nicht als andere aus, teile keine illegalen Inhalte und versuche nicht, Sicherheitsfunktionen zu umgehen. Wir können Inhalte entfernen, Funktionen einschränken oder Konten sperren, die gegen diese Regeln verstoßen.\n\n4. Anonymer Chat & Profilfreigabe\nIn anonymen Chats können dein Name und dein Foto verborgen bleiben, bis bestimmte Verbindungsmeilensteine erreicht sind. Die vollständige Profilfreigabe erfordert gegenseitige Zustimmung. Setze andere nicht unter Druck, ihre Identität preiszugeben.\n\n5. Käufe\nEinige Funktionen können kostenpflichtig sein. Käufe werden über den Apple App Store oder Google Play abgewickelt. „Käufe wiederherstellen“ stellt berechtigte Käufe mit demselben Store-Konto wieder her. Erstattungen richten sich nach den Richtlinien des jeweiligen Stores.\n\n6. Inhalte, die du teilst\nDu behältst die Rechte an deinen Inhalten, räumst Veylo jedoch eine Lizenz ein, sie in der App zu hosten und anzuzeigen, soweit dies für den Betrieb des Dienstes erforderlich ist. Veröffentliche keine Inhalte, zu deren Weitergabe du nicht berechtigt bist.\n\n7. Beendigung der Nutzung\nDu kannst die Nutzung von Veylo jederzeit beenden und in den Einstellungen die Löschung deines Kontos beantragen. Wir können den Dienst ebenfalls beenden oder ändern und informieren dich, wenn erforderlich, mit angemessener Frist.\n\n8. Kontakt\nFragen zu diesen Bedingungen: support@veylo.app',
			'legal.privacyBody' => 'Zuletzt aktualisiert: 16. März 2026\n\nDiese Datenschutzerklärung erläutert, wie Veylo deine Daten erhebt, verwendet und schützt.\n\n1. Welche Daten wir erheben\n• Kontodaten: E-Mail, Anzeigename, Profilfotos, Bio, Präferenzen\n• Nutzungsdaten: Chats, Verbindungsfortschritt, genutzte Anruffunktionen, grundlegende Geräte-/App-Daten\n• Käufe: Store-Belegdaten, die zum Freischalten und Wiederherstellen kostenpflichtiger Funktionen nötig sind\n\n2. Wie wir sie verwenden\nWir verwenden deine Daten, um Veylo zu betreiben, Matching und Chat-Erlebnisse zu personalisieren, die Community zu schützen, Käufe abzuwickeln und das Produkt zu verbessern. Wir verkaufen deine personenbezogenen Daten nicht.\n\n3. Anonymer Modus\nIn anonymen Chats begrenzen wir, was andere sehen (zum Beispiel einen maskierten Namen oder ein verschwommenes Foto), bis Freischaltregeln und gegenseitige Zustimmung mehr erlauben. Im Hintergrund benötigen wir weiterhin Konto-Kennungen, um die Funktion sicher zu betreiben.\n\n4. Weitergabe\nWir können Daten an Dienstleister weitergeben, die uns beim Hosting, bei Analysen oder bei der Zahlungsabwicklung unterstützen – nur soweit erforderlich. Außerdem können wir Informationen offenlegen, wenn dies gesetzlich vorgeschrieben ist oder um Nutzer vor Schaden zu schützen.\n\n5. Speicherdauer\nWir speichern Daten, solange dein Konto aktiv ist und soweit dies aus rechtlichen, sicherheitsbezogenen oder abrechnungsbezogenen Gründen erforderlich ist. Nach Abschluss eines Löschantrags entfernen oder anonymisieren wir personenbezogene Daten, sofern keine Aufbewahrungspflicht besteht.\n\n6. Deine Wahlmöglichkeiten\nDu kannst deine Profilangaben bearbeiten, Benachrichtigungen verwalten, die Löschung deines Kontos beantragen und uns zu deinen Daten kontaktieren. Store-Käufe werden außerdem über Apple oder Google verwaltet.\n\n7. Sicherheit\nWir setzen angemessene technische und organisatorische Maßnahmen ein, um deine Daten zu schützen. Kein System ist vollkommen sicher; bitte verwende ein starkes Passwort und halte dein Gerät aktuell.\n\n8. Kontakt\nFragen zum Datenschutz: privacy@veylo.app',
			'logout.title' => 'Abmelden',
			'logout.subtitle' => 'Möchtest du dich wirklich abmelden?',
			'logout.cancel' => 'Abbrechen',
			'logout.confirm' => 'Abmelden',
			'deleteAccount.title' => 'Kontolöschung beantragen',
			'deleteAccount.subtitle' => 'Möchtest du dein Konto wirklich löschen?',
			'deleteAccount.reasonTitle' => 'Wir wollen nicht, dass du gehst, aber wir verstehen es.',
			'deleteAccount.reasonBefore' => 'Verrätst du uns, warum du gehen möchtest, damit wir das ',
			'deleteAccount.reasonAfter' => '-Erlebnis verbessern können?',
			'deleteAccount.reasonLabel' => 'Warum möchtest du dein Konto löschen?',
			'deleteAccount.reasonHint' => 'Schreib deine Nachricht',
			'deleteAccount.cancel' => 'Abbrechen',
			'deleteAccount.createRequest' => 'Antrag erstellen',
			'deleteAccount.confirmTitle' => 'Möchtest du den Löschantrag wirklich senden?',
			'deleteAccount.confirmSubtitle' => 'Wenn du bestätigst, wird dein Antrag auf Kontolöschung gesendet',
			'deleteAccount.delete' => 'Löschen',
			'storyText.bold' => 'Fett',
			'storyText.italic' => 'Kursiv',
			'storyText.uppercase' => 'Großbuchstaben',
			'storyText.underline' => 'Unterstrichen',
			'storyText.cancel' => 'Abbrechen',
			'storyText.galleryError' => 'Galerie konnte nicht geöffnet werden',
			_ => null,
		};
	}
}
