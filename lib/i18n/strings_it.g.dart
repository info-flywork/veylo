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
class TranslationsIt extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsIt({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.it,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <it>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key) ?? super[key];

	late final TranslationsIt _root = this; // ignore: unused_field

	@override 
	TranslationsIt $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsIt(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$app$it app = _Translations$app$it._(_root);
	@override late final _Translations$home$it home = _Translations$home$it._(_root);
	@override late final _Translations$chats$it chats = _Translations$chats$it._(_root);
	@override late final _Translations$profile$it profile = _Translations$profile$it._(_root);
	@override late final _Translations$nav$it nav = _Translations$nav$it._(_root);
	@override late final _Translations$call$it call = _Translations$call$it._(_root);
	@override late final _Translations$vibes$it vibes = _Translations$vibes$it._(_root);
	@override late final _Translations$discover$it discover = _Translations$discover$it._(_root);
	@override late final _Translations$common$it common = _Translations$common$it._(_root);
	@override late final _Translations$languages$it languages = _Translations$languages$it._(_root);
	@override late final _Translations$auth$it auth = _Translations$auth$it._(_root);
	@override late final _Translations$onboarding$it onboarding = _Translations$onboarding$it._(_root);
	@override late final _Translations$createProfile$it createProfile = _Translations$createProfile$it._(_root);
	@override late final _Translations$errors$it errors = _Translations$errors$it._(_root);
	@override late final _Translations$faq$it faq = _Translations$faq$it._(_root);
	@override late final _Translations$legal$it legal = _Translations$legal$it._(_root);
	@override late final _Translations$logout$it logout = _Translations$logout$it._(_root);
	@override late final _Translations$deleteAccount$it deleteAccount = _Translations$deleteAccount$it._(_root);
	@override late final _Translations$storyText$it storyText = _Translations$storyText$it._(_root);
}

// Path: app
class _Translations$app$it extends Translations$app$tr {
	_Translations$app$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get name => 'Veylo';
	@override String get tagline => 'Benvenuto';
}

// Path: home
class _Translations$home$it extends Translations$home$tr {
	_Translations$home$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Home';
	@override String get subtitle => 'L\'app è in preparazione';
	@override String get body => 'L\'interfaccia multilingue è gestita con slang.';
}

// Path: chats
class _Translations$chats$it extends Translations$chats$tr {
	_Translations$chats$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Chat';
	@override String get search => 'Cerca';
	@override String get messagesSection => 'Messaggi';
	@override String get request => 'Richieste';
	@override String get emptyRequestTitle => 'Nessuna notifica di messaggi\nrecente';
	@override String get emptyRequestSubtitle => 'Le richieste più vecchie di 30 giorni non vengono mostrate.';
	@override String get noteAdd => 'Aggiungi nota';
	@override String get anonymous => 'Anonimo';
	@override String get online => 'online';
	@override String get offline => 'offline';
	@override String get connection => 'Connessione';
	@override String connectionPercent({required Object n}) => '${n}%';
	@override String get connectionProgressTitle => 'Progresso connessione';
	@override String get milestoneInitial => 'Iniziale del nome';
	@override String get milestoneInitialHint => 'Sbloccata al 25%';
	@override String get milestoneInitialLocked => 'Si sblocca al 25%';
	@override String get milestonePhoto => 'Anteprima foto sfocata';
	@override String get milestonePhotoHint => 'Si sblocca al 70%';
	@override String get milestoneFull => 'Profilo completo';
	@override String get milestoneFullHint => 'Consenso reciproco al 100%';
	@override String get sampleAnonymousMessage => 'Ciao, è stato un piacere conoscerti. Mi racconti un po\' di te?';
	@override String get strangerSampleMessage => 'Ciao Jhon, è stato un piacere conoscerti. Mi racconti un po\' di te?';
	@override String get approve => 'Accetta';
	@override String get blockUser => 'Blocca utente';
	@override String get reject => 'Rifiuta';
	@override String get messageHint => 'Ciao! Come stai?';
	@override String get revealTitle => 'Hai raggiunto il 100%';
	@override String get revealSubtitle => 'Volete mostrarvi i profili completi? Dovete essere d\'accordo entrambi.';
	@override String revealWaiting({required Object name}) => 'In attesa che ${name} accetti';
	@override String get revealCta => 'Mostra il mio profilo';
	@override String get revealNotYet => 'Non ancora';
	@override String get seen => 'Visto';
	@override String get typing => 'sta scrivendo…';
	@override String get noteYou => 'Tu';
	@override String get noteSheetTitle => 'Condividi una nota';
	@override String get noteSheetSubtitle => 'La tua nota resta per 24 ore';
	@override String get noteHint => 'A cosa stai pensando?';
	@override String get noteShare => 'Condividi';
	@override String get noteDelete => 'Elimina nota';
}

// Path: profile
class _Translations$profile$it extends Translations$profile$tr {
	_Translations$profile$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get eyebrow => 'Profilo';
	@override String get title => 'Impostazioni';
	@override String get editProfile => 'Modifica profilo';
	@override String get statLike => 'Mi piace';
	@override String get statFollow => 'Seguiti';
	@override String get statFollower => 'Follower';
	@override String get promoTitle => 'Ricevi più messaggi!';
	@override String get promoSubtitle => 'Fatti notare, appari in cima alla lista';
	@override String get standOut => 'Fatti notare';
	@override String get tabPosts => 'Post';
	@override String get tabVideo => 'Video';
	@override String get tabSaved => 'Salvati';
	@override String get save => 'Salva';
	@override String get changePhoto => 'Cambia foto';
	@override String get changeBorder => 'Cambia cornice';
	@override String get interest => 'Interessi';
	@override String get name => 'Nome';
	@override String get changeName => 'Cambia nome';
	@override String get changePassword => 'Cambia password';
	@override String get confirmPassword => 'Conferma password';
	@override String get email => 'Email';
	@override String get accountManagement => 'Gestione account';
	@override String get settingsAbout => 'Info';
	@override String get settingsAccount => 'Impostazioni account';
	@override String get settingsSupport => 'Supporto';
	@override String get shareApp => 'Condividi l\'app';
	@override String get shareAppTitle => 'Condividi con gli amici';
	@override String get shareAppSubtitle => 'Condividi Veylo con i tuoi amici e scoprite insieme!';
	@override String get shareAppLabel => 'Link dell\'app';
	@override String get rateApp => 'Ti piacciamo? Valutaci';
	@override String get notifications => 'Notifiche';
	@override String get password => 'Password';
	@override String get deleteConversation => 'Elimina conversazioni';
	@override String get faqHelp => 'FAQ e assistenza';
	@override String get restorePurchases => 'Ripristina acquisti';
	@override String get termsOfService => 'Termini di servizio';
	@override String get privacyPolicy => 'Informativa sulla privacy';
	@override String get restorePurchasesDone => 'Acquisti verificati';
	@override String get conversationsDeleted => 'Tutte le conversazioni eliminate';
	@override String get logOut => 'Esci';
	@override String get deleteAccountAndData => 'Elimina account e dati';
	@override String get passwordPlaceholder => '********';
	@override String get height => 'Altezza';
	@override String get addHeight => 'Aggiungi altezza';
	@override String heightCm({required Object value}) => '${value} cm';
	@override String get languages => 'Lingue';
	@override String get relationshipGoals => 'Obiettivi relazionali';
	@override String get lookingFor => 'Cerco';
	@override String get newFriends => '👋 Nuovi amici';
	@override String get goalLongTermOpenToShort => '💕 Lunga durata, aperto a breve';
	@override String get goalLongTermRelationship => '💘 Relazione duratura';
	@override String get goalNewFriends => '👋 Nuovi amici';
	@override String get goalShortTermFun => '🥃 Divertimento a breve termine';
	@override String get goalStillFiguringItOut => '🤔 Ci sto ancora pensando';
	@override String get basics => 'Info di base';
	@override String get zodiac => 'Segno zodiacale';
	@override String get zodiacValue => 'Scorpione';
	@override String get education => 'Istruzione';
	@override String get educationValue => 'Laurea triennale';
	@override String get educationHighSchool => 'Scuola superiore';
	@override String get educationAssociates => 'Diploma post-secondario';
	@override String get educationBachelors => 'Laurea triennale';
	@override String get educationMasters => 'Laurea magistrale';
	@override String get educationPhd => 'Dottorato';
	@override String get voiceRecord => 'Registrazione vocale';
	@override String get addVoice => 'Aggiungi voce';
	@override String get lifestyle => 'Stile di vita';
	@override String get pets => 'Animali';
	@override String get petsValue => 'Ho un gatto';
	@override String get petsDontWant => 'Non voglio animali';
	@override String get petsAllergic => 'Sono allergico agli animali';
	@override String get petsHaveCat => 'Ho un gatto';
	@override String get petsHaveDog => 'Ho un cane';
	@override String get petsHaveCatsAndDogs => 'Ho cani e gatti';
	@override String get petsHaveOther => 'Ho altri animali';
	@override String get drinking => 'Alcol';
	@override String get drinkingValue => 'In occasioni speciali';
	@override String get drinkingNever => 'Mai';
	@override String get drinkingSpecialOccasions => 'In occasioni speciali';
	@override String get drinkingSocially => 'In compagnia';
	@override String get drinkingFrequently => 'Spesso';
	@override String get drinkingSober => 'Astemio';
	@override String get drinkingPreferNotToSay => 'Preferisco non dirlo';
	@override String get smoking => 'Fumo';
	@override String get smokingValue => 'Non fumatore';
	@override String get smokingNonSmoker => 'Non fumatore';
	@override String get smokingSocialSmoker => 'Fumo in compagnia';
	@override String get smokingSmoker => 'Fumatore';
	@override String get smokingTryingToQuit => 'Sto cercando di smettere';
	@override String get smokingWhenDrinking => 'Fumo quando bevo';
	@override String get smokingPreferNotToSay => 'Preferisco non dirlo';
	@override String get gender => 'Genere';
	@override String get genderFemale => 'Donna';
	@override String get genderMale => 'Uomo';
	@override String get genderPreferNotToSay => 'Preferisco non dirlo';
	@override String get visible => 'Visibile';
	@override String get profileVisibility => 'Visibilità profilo';
	@override String get language => 'Lingua';
	@override String get borderTitle => 'Cornice profilo';
	@override String get borderSubtitle => 'Aggiungi una cornice al tuo profilo per\nfarti notare.';
	@override String get borderBuySection => 'Acquista una cornice';
	@override String get borderBuyCta => 'Acquista cornice';
	@override String borderToken({required Object count}) => '${count} token';
	@override String get borderAmethystWings => 'Amethyst Wings';
	@override String get borderGoldenPhoenix => 'Golden Phoenix';
	@override String get borderFrostCrown => 'Frost Crown';
	@override String get borderEmeraldWhisper => 'Emerald Whisper';
	@override String get borderRoseQuartz => 'Rose Quartz';
	@override String get borderStarlitComet => 'Starlit Comet';
	@override String get borderCrimsonRoyal => 'Crimson Royal';
	@override String get borderSapphireHalo => 'Sapphire Halo';
	@override String get follow => 'Segui';
	@override String get following => 'Segui già';
	@override String get followPageTitle => 'Segui';
	@override String get followTabFollowing => 'Seguiti';
	@override String get followTabFollowers => 'Follower';
	@override String get followSearch => 'Cerca';
	@override String get unfollow => 'Non seguire più';
	@override String get followSortTitle => 'Ordina';
	@override String get followSortRecent => 'Persone che ho seguito di recente';
	@override String get followSortNotFollowingMe => 'Chi non mi segue a sua volta';
	@override String get followSortNotFollowedByMe => 'Chi non seguo a mia volta';
	@override String get followSortShowResult => 'Mostra risultati';
	@override String get followSortEmpty => 'Nessun utente corrisponde al filtro';
	@override String get shareTitle => 'Condividi con gli amici';
	@override String get shareSubtitle => 'Tutto è più divertente quando ti connetti\ncon i tuoi amici!';
	@override String get shareProfileLabel => 'Condividi il profilo';
	@override String get shareLinkCopied => 'Link copiato';
	@override String get restrict => 'Limita';
	@override String get block => 'Blocca';
	@override String get report => 'Segnala';
	@override String blockTitle({required Object username}) => 'Bloccare ${username} ?';
	@override String get blockBody => 'Verranno bloccati anche eventuali altri account che ha o creerà in futuro. Puoi sbloccarlo quando vuoi.';
	@override String get blockAndReport => 'Blocca e segnala';
	@override String restrictTitle({required Object username}) => 'Limitare ${username} ?';
	@override String get restrictBody => 'Non potrà vedere quando sei online o se hai letto i suoi messaggi. Puoi cambiarlo quando vuoi.';
	@override String get restrictAndReport => 'Limita e segnala';
	@override String get reportTitle => 'Vorremmo sapere perché';
	@override String get reportSubtitle => 'Per offrirti un\'esperienza migliore, ci dici perché vuoi segnalare questo utente?';
	@override String get reportMessageLabel => 'Messaggio di segnalazione';
	@override String get reportMessageHint => 'Scrivi il tuo messaggio';
	@override String get reportCancel => 'Annulla';
	@override String get sendReport => 'Invia segnalazione';
	@override String get notSet => 'Non impostato';
	@override String get reportSent => 'Grazie, abbiamo ricevuto la tua segnalazione.';
	@override String emailVerificationSent({required Object email}) => 'Abbiamo inviato un link di conferma a ${email}. La tua email cambierà dopo la conferma.';
	@override String get passwordChanged => 'La tua password è stata aggiornata.';
	@override String get passwordMismatch => 'Le password non coincidono.';
}

// Path: nav
class _Translations$nav$it extends Translations$nav$tr {
	_Translations$nav$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get discover => 'Scopri';
	@override String get chat => 'Chat';
	@override String get call => 'Chiama';
	@override String get vibes => 'Vibes';
	@override String get profile => 'Profilo';
}

// Path: call
class _Translations$call$it extends Translations$call$tr {
	_Translations$call$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sconosciuto in 60 secondi';
	@override String get subtitle => 'Parla con uno sconosciuto a caso per 60 secondi, in totale anonimato. Niente profilo, niente foto, niente nome. Solo una voce e un momento.';
	@override String get findingTitle => 'Cerco uno sconosciuto...';
	@override String get findingSubtitle => 'Parlerete in anonimo per 60 secondi. Niente profili, niente nomi.';
	@override String get callStranger => 'Chiama uno sconosciuto - 10 token';
	@override String get cancel => 'Annulla';
	@override String get female => 'Donna';
	@override String get male => 'Uomo';
	@override String get nonBinary => 'Non binario';
	@override String get preferNotToSay => 'Preferisco non dirlo';
	@override String get anonymousBadge => '🎙️ Chiamata vocale anonima';
	@override String get stranger => 'Sconosciuto';
	@override String secondsLeft({required Object n}) => '${n}s';
	@override String get timesUpTitle => 'Tempo scaduto!';
	@override String get timesUpSubtitle => 'Vuoi continuare a parlare? Se dite sì entrambi, si sblocca la chat.';
	@override String get keepTalking => 'Continua a parlare';
	@override String get endCall => 'Termina';
	@override String get waitingOther => 'In attesa dell\'altra persona...';
	@override String get callStrangerFree => 'Chiama uno sconosciuto';
	@override String get peerLeft => 'L\'altra persona ha chiuso la chiamata.';
	@override String get noKeep => 'Stavolta la chat non si è sbloccata.';
	@override String get videoWaiting => 'In attesa che accetti la videochiamata...';
	@override String get videoDeclined => 'Ha rifiutato la videochiamata.';
	@override String get micDenied => 'Per le chiamate serve l\'accesso al microfono. Puoi attivarlo nelle Impostazioni.';
	@override String get videoCost => 'Videochiamata: 20 token / 15 min';
	@override String get calling => 'Chiamata in corso';
	@override String get accept => 'Accetta';
	@override String get decline => 'Rifiuta';
	@override String get switchToVideo => 'Vuoi passare a una videochiamata?';
	@override String get noMatchTitle => 'Nessuno è disponibile al momento';
	@override String get noMatchBody => 'Al momento non abbiamo trovato nessuno con cui parlare. Riprova tra un po\'.';
	@override String get noMatchOk => 'OK';
}

// Path: vibes
class _Translations$vibes$it extends Translations$vibes$tr {
	_Translations$vibes$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get search => 'Cerca';
	@override String get sendMessage => 'Invia messaggio';
	@override String get wantsToTalk => 'Vuole parlarne proprio ora';
	@override String get shareTitle => 'Condividi Vibe';
	@override String get replyTitle => 'Rispondi alla Vibe';
	@override String get shareHint => 'Scrivi qualcosa';
	@override String get shareAnonymous => 'Condividi in anonimo';
	@override String get empty => 'Nessuna vibe nelle ultime 24 ore. Condividi la prima!';
	@override String get deleteTitle => 'Eliminare questa vibe?';
	@override String get delete => 'Elimina';
	@override String get cancel => 'Annulla';
}

// Path: discover
class _Translations$discover$it extends Translations$discover$tr {
	_Translations$discover$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Scopri';
	@override String get tabRooms => 'Stanze';
	@override String get tabDiscover => 'Scopri';
	@override String get tabAiMatch => 'AI Match';
	@override late final _Translations$discover$aiMatch$it aiMatch = _Translations$discover$aiMatch$it._(_root);
	@override String get searchHint => 'Cerca';
	@override String get allRooms => 'Tutte le stanze';
	@override String get allGroups => 'Tutti i gruppi';
	@override String get seeAll => 'Vedi tutti';
	@override String get live => 'Live';
	@override String get join => 'Entra';
	@override String get request => 'Richiedi';
	@override String get requested => 'Richiesto';
	@override String get private => 'Privata';
	@override String moreCount({required Object count}) => '+${count} altri';
	@override String activeCount({required Object count}) => '${count} attivi';
	@override String membersCount({required Object count}) => '${count} membri';
	@override late final _Translations$discover$privateRoom$it privateRoom = _Translations$discover$privateRoom$it._(_root);
	@override late final _Translations$discover$roomToken$it roomToken = _Translations$discover$roomToken$it._(_root);
	@override late final _Translations$discover$privateRequest$it privateRequest = _Translations$discover$privateRequest$it._(_root);
	@override late final _Translations$discover$roomApproved$it roomApproved = _Translations$discover$roomApproved$it._(_root);
	@override late final _Translations$discover$createSpace$it createSpace = _Translations$discover$createSpace$it._(_root);
	@override late final _Translations$discover$liveRoom$it liveRoom = _Translations$discover$liveRoom$it._(_root);
	@override late final _Translations$discover$groupChat$it groupChat = _Translations$discover$groupChat$it._(_root);
	@override late final _Translations$discover$groupInfo$it groupInfo = _Translations$discover$groupInfo$it._(_root);
	@override late final _Translations$discover$filters$it filters = _Translations$discover$filters$it._(_root);
	@override late final _Translations$discover$post$it post = _Translations$discover$post$it._(_root);
	@override late final _Translations$discover$story$it story = _Translations$discover$story$it._(_root);
	@override late final _Translations$discover$highlight$it highlight = _Translations$discover$highlight$it._(_root);
	@override late final _Translations$discover$stats$it stats = _Translations$discover$stats$it._(_root);
	@override String hostedBy({required Object name}) => 'Organizzata da ${name}';
}

// Path: common
class _Translations$common$it extends Translations$common$tr {
	_Translations$common$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get loading => 'Caricamento…';
	@override String get retry => 'Riprova';
	@override String get cancel => 'Annulla';
	@override String get save => 'Salva';
	@override String get continueAction => 'Continua';
	@override String get language => 'Lingua';
	@override String get or => 'OPPURE';
}

// Path: languages
class _Translations$languages$it extends Translations$languages$tr {
	_Translations$languages$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get tr => 'Türkçe';
	@override String get en => 'English';
}

// Path: auth
class _Translations$auth$it extends Translations$auth$tr {
	_Translations$auth$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get createAccountTitle => 'Crea il tuo account';
	@override String get createAccountSubtitle => 'Unisciti a Veylo e inizia a conoscere gente.';
	@override String get welcomeBackTitle => 'Bentornato';
	@override String get welcomeBackSubtitle => 'Accedi per continuare su Veylo.';
	@override String get username => 'Nome utente';
	@override String get usernameHint => 'Scegli un nome utente';
	@override String get email => 'Email';
	@override String get emailHint => 'Inserisci la tua email';
	@override String get emailOrUsername => 'Email o nome utente';
	@override String get emailOrUsernameHint => 'Inserisci email o nome utente';
	@override String get password => 'Password';
	@override String get passwordCreateHint => 'Crea una password';
	@override String get passwordEnterHint => 'Inserisci la tua password';
	@override String get signUp => 'Registrati';
	@override String get logIn => 'Accedi';
	@override String get forgotPassword => 'Password dimenticata?';
	@override String get continueWithApple => 'Continua con Apple';
	@override String get continueWithGoogle => 'Continua con Google';
	@override String get legalPrefix => 'Continuando, accetti i nostri ';
	@override String get termsOfService => 'Termini di servizio';
	@override String get legalMiddle => ' e confermi di aver letto la nostra ';
	@override String get privacyPolicy => 'Informativa sulla privacy';
	@override String get legalSuffix => '.';
	@override String get passwordResetSent => 'Ti abbiamo inviato via email un link per reimpostare la password.';
}

// Path: onboarding
class _Translations$onboarding$it extends Translations$onboarding$tr {
	_Translations$onboarding$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get skip => 'Salta';
	@override String get page1Title => 'Sii te stesso. Resta anonimo.';
	@override String get page1Subtitle => 'Conosci persone nuove e inizia a chattare\nsenza rivelare chi sei.';
	@override String get page2Title => 'Scrivi. Parla. Senti la vibe.';
	@override String get page2Subtitle => 'Inizia in anonimo, poi scrivi, chiama o incontratevi quando ti senti pronto.';
	@override String get page3Title => 'Trova la tua gente. Unisciti\nalla conversazione.';
	@override String get page3Subtitle => 'Entra nelle stanze, conosci persone nuove e\nvivi il momento insieme.';
	@override String get getStarted => 'Iniziamo';
	@override String get alreadyHaveAccount => 'Hai già un account Veylo? ';
	@override String get logInAction => 'Accedi';
}

// Path: createProfile
class _Translations$createProfile$it extends Translations$createProfile$tr {
	_Translations$createProfile$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get navTitle => 'Crea profilo';
	@override String get stepUsername => '1/5 Nome utente';
	@override String get title => 'Crea il tuo profilo';
	@override String get subtitle => 'Il tuo nome reale serve solo per la verifica: non sarà visibile pubblicamente.';
	@override String get subtitleLine1 => 'Il tuo nome reale serve solo per la verifica: non';
	@override String get subtitleLine2 => 'sarà visibile pubblicamente.';
	@override String get fullName => 'Nome e cognome';
	@override String get fullNameHint => 'Sam Lee';
	@override String get username => 'Nome utente';
	@override String get usernameHint => 'samlee123';
	@override String get usernameTaken => 'Questo nome utente esiste già!';
	@override String get usernameAvailable => 'Nome utente disponibile';
	@override String get mightWantToTry => 'Potresti provare...';
	@override String get stepPhoto => '2/5 Foto profilo';
	@override String get photoTitle => 'Carica una foto profilo';
	@override String get photoSubtitle => 'Gli altri utenti possono vedere la tua foto profilo per sapere che sei tu.';
	@override String get photoSubtitleLine1 => 'Gli altri utenti possono vedere la tua foto profilo';
	@override String get photoSubtitleLine2 => 'per sapere che sei tu.';
	@override String get choosePhoto => 'Scegli una foto';
	@override String get continueWithoutPhoto => 'Continua senza foto profilo';
	@override String get saveAndContinue => 'Salva e continua';
	@override String get choosePhotoSheetTitle => 'Scegli una foto';
	@override String get takePhoto => 'Scatta una foto';
	@override String get chooseFromGallery => 'Scegli dalla libreria';
	@override String get stepGender => '3/5 Genere';
	@override String get genderTitle => 'Scegli il tuo genere';
	@override String get genderSubtitle => 'Se scegli di fornirci questa informazione, potremmo usarla per personalizzare i contenuti per te';
	@override String get genderSubtitleLine1 => 'Se scegli di fornirci questa informazione, potremmo';
	@override String get genderSubtitleLine2 => 'usarla per personalizzare i contenuti per te';
	@override String get genderFemale => 'Donna';
	@override String get genderMale => 'Uomo';
	@override String get genderNonBinary => 'Non binario';
	@override String get genderPreferNotToSay => 'Preferisco non dirlo';
	@override String get stepInterests => '4/5 Interessi';
	@override String get interestsTitle => 'Cosa ti appassiona?';
	@override String get interestsSubtitle => 'Scegline almeno 5: ci aiuta ad abbinarti a persone che ti capiscono davvero.';
	@override late final _Translations$createProfile$interests$it interests = _Translations$createProfile$interests$it._(_root);
	@override String get stepChatGoal => '5/5 Obiettivo chat';
	@override String get chatGoalTitle => 'Cosa cerchi oggi?';
	@override String get chatGoalSubtitle => 'Ci aiuta a trovare il match giusto per il tuo umore di adesso.';
	@override String get chatGoalQuickMatch => 'Match veloce: tuffati subito in una\nconversazione';
	@override String get chatGoalFlirtyChat => 'Flirt: conversazioni leggere e\ngiocose';
	@override String get chatGoalMoodMatch => 'Match d\'umore: abbinamento in base a come\nti senti';
	@override String get chatGoalLateNight => 'Chiacchiere notturne: discorsi profondi mentre il mondo\ndorme';
	@override String get chatGoalMeetSomeoneNew => 'Conosci qualcuno di nuovo: nessun obiettivo,\nsolo esplorare';
	@override String get getStarted => 'Iniziamo';
	@override String get preparingTitleLine1 => 'Stiamo preparando';
	@override String get preparingTitleLine2 => 'i profili giusti per';
	@override String get preparingTitleLine3 => 'te.';
	@override String get preparingSubtitleLine1 => 'In base alle tue risposte, stiamo scegliendo';
	@override String get preparingSubtitleLine2 => 'i match migliori: attendi un momento.';
	@override String preparingPercent({required Object percent}) => '${percent}%';
	@override String get usernameInvalid => 'Usa 3–30 lettere, numeri, punti o trattini bassi.';
}

// Path: errors
class _Translations$errors$it extends Translations$errors$tr {
	_Translations$errors$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get network => 'Impossibile raggiungere Veylo. Controlla la connessione e riprova.';
	@override String get generic => 'Qualcosa è andato storto. Riprova.';
	@override String get signInFailed => 'Accesso non riuscito. Riprova.';
	@override String get sessionExpired => 'La sessione è scaduta. Accedi di nuovo.';
	@override String get accountSuspended => 'Questo account è stato sospeso.';
	@override String get unsupportedImage => 'Scegli una foto JPEG, PNG o WebP.';
	@override String get fileTooLarge => 'Questo file è troppo grande.';
	@override String get enterEmailForReset => 'Inserisci la tua email qui sopra per reimpostare la password.';
	@override String get wrongCredentials => 'Email/nome utente o password errati.';
	@override String get emailInUse => 'Questa email è già registrata. Prova ad accedere.';
	@override String get weakPassword => 'La password deve avere almeno 6 caratteri.';
	@override String get invalidEmail => 'Inserisci un indirizzo email valido.';
	@override String get tooManyAttempts => 'Troppi tentativi. Attendi un po\' e riprova.';
	@override String get fillAllFields => 'Compila tutti i campi.';
	@override String get insufficientTokens => 'Token insufficienti.';
	@override String get requestNotAccepted => 'Accetta la richiesta per rispondere.';
	@override String get requestPendingLimit => 'Potrai inviare altri messaggi quando avrà accettato la tua richiesta.';
	@override String get blocked => 'Non puoi scrivere a questa persona.';
	@override String get peerUnavailable => 'Questo account non è più disponibile.';
	@override String get vibeDailyLimit => 'Oggi hai condiviso tante vibe. Riprova più tardi.';
	@override String get groupFull => 'Questo gruppo è pieno.';
	@override String get groupCreateLimit => 'Oggi hai creato troppi gruppi. Riprova più tardi.';
	@override String get notFound => 'Non è più disponibile.';
	@override String get recentLogin => 'Per sicurezza, esci e accedi di nuovo, poi riprova.';
	@override String get socialAccount => 'Email e password sono gestite dal tuo account Google o Apple.';
	@override String get alreadyInCall => 'Sei già in una chiamata.';
	@override String get roomPrivate => 'Questa stanza è privata. Chiedi all\'host di entrare.';
	@override String get roomFull => 'Questa stanza è piena.';
}

// Path: faq
class _Translations$faq$it extends Translations$faq$tr {
	_Translations$faq$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get q1 => 'Come funziona l\'app?';
	@override String get q2 => 'Cos\'è la chat anonima?';
	@override String get q3 => 'Cos\'è il Progresso connessione?';
	@override String get q4 => 'Come mostro il mio profilo?';
	@override String get q5 => 'Cos\'è Sconosciuto in 60 secondi?';
	@override String get q6 => 'Cosa sono le Vibes?';
	@override String get q7 => 'Come modifico il mio profilo?';
	@override String get q8 => 'Come gestisco le notifiche?';
	@override String get q9 => 'Come ripristino gli acquisti?';
	@override String get q10 => 'Posso eliminare tutte le conversazioni?';
	@override String get q11 => 'I miei dati sono al sicuro?';
	@override String get q12 => 'Come blocco o segnalo qualcuno?';
	@override String get q13 => 'Come condivido l\'app?';
	@override String get q14 => 'Come elimino il mio account?';
	@override String get a1 => 'Su Veylo puoi conoscere persone nuove in anonimo, chattare e rivelare gradualmente il tuo profilo man mano che la connessione cresce. Passate a messaggi, voce o faccia a faccia quando vi sentite pronti entrambi.';
	@override String get a2 => 'Nella chat anonima la tua identità e la tua foto restano nascoste. Con l\'aumentare della connessione sblocchi dettagli come l\'iniziale del nome e una foto sfocata. Al 100%, entrambi dovete accettare di mostrare i profili completi.';
	@override String get a3 => 'Mentre chattate, la percentuale di connessione cresce. A certe tappe sblocchi l\'iniziale del nome, una foto sfocata e il profilo completo. Tocca il badge Connessione per vedere i dettagli.';
	@override String get a4 => 'Quando la connessione arriva al 100%, tocca Mostra il mio profilo. Se accetta anche l\'altra persona, entrambi i profili completi diventano visibili.';
	@override String get a5 => 'Dalla scheda Chiama puoi ottenere un breve match casuale. Allo scadere del tempo puoi continuare a parlare o terminare la chiamata.';
	@override String get a6 => 'Vibes ti permette di scoprire persone vicine o intorno a te su una vista mappa/elenco e iniziare una chat con chi ti interessa.';
	@override String get a7 => 'Apri la scheda Profilo e vai su Modifica profilo per aggiornare nome, foto, bio e interessi. Le modifiche appaiono dopo il salvataggio.';
	@override String get a8 => 'Apri Notifiche nelle Impostazioni per attivare o disattivare gli avvisi di messaggi, match e altro.';
	@override String get a9 => 'Vai su Impostazioni → Gestione account → Ripristina acquisti. Gli acquisti idonei sullo stesso account dello store verranno ripristinati.';
	@override String get a10 => 'Sì. Usa Impostazioni → Elimina conversazioni e conferma. Tutte le chat verranno rimosse. L\'operazione non è reversibile.';
	@override String get a11 => 'I dati del tuo account e i messaggi sono conservati su sistemi protetti. Puoi anche richiedere l\'eliminazione dell\'account e dei dati da Gestione account in qualsiasi momento.';
	@override String get a12 => 'Usa il menu in un profilo o in una chat per bloccare o segnalare. Le segnalazioni vengono esaminate dal nostro team.';
	@override String get a13 => 'Usa Condividi l\'app nelle Impostazioni per copiare il link e inviarlo agli amici.';
	@override String get a14 => 'Vai su Impostazioni → Gestione account → Elimina account e dati. Dopo aver indicato un motivo, conferma per inviare la richiesta di eliminazione.';
}

// Path: legal
class _Translations$legal$it extends Translations$legal$tr {
	_Translations$legal$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get termsTitle => 'Termini di servizio';
	@override String get privacyTitle => 'Informativa sulla privacy';
	@override String get termsBody => 'Ultimo aggiornamento: 16 marzo 2026\n\nBenvenuto su Veylo. Creando un account o usando l\'app, accetti i presenti Termini di servizio.\n\n1. Cos\'è Veylo\nVeylo è un\'app social in cui puoi conoscere persone, chattare in anonimo, costruire una connessione nel tempo e, se entrambi siete d\'accordo, passare facoltativamente a chiamate vocali o faccia a faccia.\n\n2. Il tuo account\nDevi fornire informazioni accurate e mantenere sicuro il tuo accesso. Sei responsabile delle attività svolte con il tuo account. Devi avere l\'età minima richiesta dalle leggi del tuo Paese per usare Veylo.\n\n3. Uso rispettoso\nNon molestare, minacciare, truffare, impersonare altri, condividere contenuti illegali né tentare di aggirare le funzioni di sicurezza. Possiamo rimuovere contenuti, limitare funzioni o sospendere gli account che violano queste regole.\n\n4. Chat anonima e rivelazione del profilo\nLe chat anonime possono nascondere il tuo nome e la tua foto fino al raggiungimento di determinate tappe di connessione. La rivelazione del profilo completo richiede il consenso reciproco. Non fare pressione sugli altri perché rivelino la propria identità.\n\n5. Acquisti\nAlcune funzioni possono essere a pagamento. Gli acquisti sono gestiti dall\'App Store di Apple o da Google Play. Ripristina acquisti recupera gli acquisti idonei sullo stesso account dello store. I rimborsi seguono le condizioni dello store.\n\n6. Contenuti che condividi\nMantieni i diritti sui tuoi contenuti, ma concedi a Veylo una licenza per ospitarli e mostrarli nell\'app nella misura necessaria a fornire il servizio. Non pubblicare contenuti che non hai il diritto di condividere.\n\n7. Fine dell\'utilizzo\nPuoi smettere di usare Veylo in qualsiasi momento e richiedere l\'eliminazione dell\'account dalle Impostazioni. Possiamo anche interrompere o modificare il servizio con un ragionevole preavviso, ove previsto.\n\n8. Contatti\nDomande su questi termini: support@veylo.app';
	@override String get privacyBody => 'Ultimo aggiornamento: 16 marzo 2026\n\nLa presente Informativa sulla privacy spiega come Veylo raccoglie, usa e protegge le tue informazioni.\n\n1. Informazioni che raccogliamo\n• Dati dell\'account: email, nome visualizzato, foto profilo, bio, preferenze\n• Dati di utilizzo: chat, progresso della connessione, funzioni di chiamata che usi, dati di base del dispositivo/app\n• Acquisti: dati delle ricevute dello store necessari per sbloccare e ripristinare le funzioni a pagamento\n\n2. Come li usiamo\nUsiamo i tuoi dati per far funzionare Veylo, personalizzare i match e l\'esperienza di chat, mantenere la community sicura, elaborare gli acquisti e migliorare il prodotto. Non vendiamo i tuoi dati personali.\n\n3. Modalità anonima\nNelle chat anonime limitiamo ciò che gli altri vedono (ad esempio nome mascherato o foto sfocata) finché le regole di sblocco e il consenso reciproco non consentono di mostrare di più. Dietro le quinte abbiamo comunque bisogno degli identificativi dell\'account per far funzionare la funzione in modo sicuro.\n\n4. Condivisione\nPossiamo condividere dati con fornitori di servizi che ci aiutano con hosting, analisi o elaborazione dei pagamenti, solo nella misura necessaria. Possiamo inoltre divulgare informazioni se richiesto dalla legge o per proteggere gli utenti da danni.\n\n5. Conservazione\nConserviamo i dati finché il tuo account è attivo e per quanto necessario per motivi legali, di sicurezza e di fatturazione. Una volta completata una richiesta di eliminazione, rimuoviamo o anonimizziamo i dati personali, salvo i casi in cui la conservazione sia obbligatoria.\n\n6. Le tue scelte\nPuoi modificare le informazioni del profilo, gestire le notifiche, richiedere l\'eliminazione dell\'account e contattarci riguardo ai tuoi dati. Gli acquisti nello store sono gestiti anche tramite Apple o Google.\n\n7. Sicurezza\nAdottiamo misure tecniche e organizzative ragionevoli per proteggere le tue informazioni. Nessun sistema è perfettamente sicuro: usa una password robusta e tieni aggiornato il tuo dispositivo.\n\n8. Contatti\nDomande sulla privacy: privacy@veylo.app';
}

// Path: logout
class _Translations$logout$it extends Translations$logout$tr {
	_Translations$logout$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Esci';
	@override String get subtitle => 'Vuoi davvero uscire?';
	@override String get cancel => 'Annulla';
	@override String get confirm => 'Esci';
}

// Path: deleteAccount
class _Translations$deleteAccount$it extends Translations$deleteAccount$tr {
	_Translations$deleteAccount$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Invia una richiesta di eliminazione account';
	@override String get subtitle => 'Vuoi davvero eliminare il tuo account?';
	@override String get reasonTitle => 'Non vogliamo che tu te ne vada, ma capiamo.';
	@override String get reasonBefore => 'Ci dici perché vuoi andartene, così possiamo migliorare l\'esperienza su ';
	@override String get reasonAfter => '?';
	@override String get reasonLabel => 'Perché vuoi eliminare il tuo account';
	@override String get reasonHint => 'Scrivi il tuo messaggio';
	@override String get cancel => 'Annulla';
	@override String get createRequest => 'Crea richiesta';
	@override String get confirmTitle => 'Vuoi davvero inviare la richiesta di eliminazione?';
	@override String get confirmSubtitle => 'Se confermi, la richiesta di eliminazione del tuo account verrà inviata';
	@override String get delete => 'Elimina';
}

// Path: storyText
class _Translations$storyText$it extends Translations$storyText$tr {
	_Translations$storyText$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get bold => 'Grassetto';
	@override String get italic => 'Corsivo';
	@override String get uppercase => 'Maiuscolo';
	@override String get underline => 'Sottolineato';
	@override String get cancel => 'Annulla';
	@override String get galleryError => 'Impossibile aprire la galleria';
}

// Path: discover.aiMatch
class _Translations$discover$aiMatch$it extends Translations$discover$aiMatch$tr {
	_Translations$discover$aiMatch$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get feelingTitle => 'Come ti senti oggi';
	@override String get feelingSubtitle => 'L\'IA trova il match migliore in base alla tua scelta';
	@override String get lookingTitle => 'Cosa stai cercando?';
	@override String get moodSad => 'Triste';
	@override String get moodMeltie => 'Così così';
	@override String get moodBored => 'Annoiato';
	@override String get moodCrying => 'Giù';
	@override String get moodSmile => 'Felice';
	@override String get lookingNewFriends => 'Nuovi amici';
	@override String get lookingVenting => 'Sfogarmi';
	@override String get lookingFlirty => 'Flirt';
	@override String get lookingFun => 'Divertimento';
	@override String get lookingCultures => 'Nuove culture';
	@override String get lookingLanguage => 'Pratica lingue';
	@override String get statActiveUsers => 'Utenti attivi';
	@override String get statMatchRate => 'Tasso di match';
	@override String get statAvgTime => 'Tempo medio';
	@override String get statActiveValue => '843';
	@override String get statMatchValue => '87%';
	@override String get statAvgValue => '8s';
	@override String get startSmartMatch => 'Avvia Smart Match';
	@override String get findingTitle => 'Cerco il tuo match';
	@override String get findingSubtitle => 'Abbiniamo il tuo umore e i tuoi interessi alla persona giusta';
	@override String get findingStepMood => 'Umore analizzato';
	@override String get findingStepInterests => 'Interessi abbinati';
	@override String get findingStepCompatibility => 'Calcolo compatibilità...';
	@override String get findingStepContent => 'Creazione contenuti...';
	@override String findingOnline({required Object count}) => '${count} persone online ora';
	@override String get yourMatchTitle => 'Il tuo match';
	@override String get yourMatchSubtitle => 'Il match si basa sulle tue risposte';
	@override String vibeMatch({required Object percent}) => '${percent}% di affinità';
	@override String get startChatting => 'Inizia a chattare';
	@override String matchNameAge({required Object name, required Object age}) => '${name}, ${age}';
	@override String get matchBio => 'Ti farò provare emozioni che non sapevi di poter provare.';
	@override String get swipePrevious => 'Indietro';
	@override String get swipeNext => 'Avanti';
	@override String get swipeFinger => 'Scorri col dito';
	@override String get noMatch => 'Nessun match al momento. Riprova tra poco.';
}

// Path: discover.privateRoom
class _Translations$discover$privateRoom$it extends Translations$discover$privateRoom$tr {
	_Translations$discover$privateRoom$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get subtitle => 'Questa è una stanza privata. Sblocca l\'accesso con i token.';
	@override String get roomAccess => 'Accesso stanza';
	@override String get yourBalance => 'Il tuo saldo';
	@override String tokensAmount({required Object count}) => '${count} token';
	@override String joinForTokens({required Object count}) => 'Entra per ${count} token';
	@override String get cancel => 'Annulla';
}

// Path: discover.roomToken
class _Translations$discover$roomToken$it extends Translations$discover$roomToken$tr {
	_Translations$discover$roomToken$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get subtitle => 'Sblocca l\'accesso con i token.';
	@override String get roomAccess => 'Accesso stanza';
	@override String get yourBalance => 'Il tuo saldo';
	@override String tokensAmount({required Object count}) => '${count} token';
	@override String joinForTokens({required Object count}) => 'Entra per ${count} token';
	@override String get cancel => 'Annulla';
}

// Path: discover.privateRequest
class _Translations$discover$privateRequest$it extends Translations$discover$privateRequest$tr {
	_Translations$discover$privateRequest$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Richiesta di accesso';
	@override String roomInfo({required Object name, required Object count}) => '${name} · ${count} membri';
	@override String get messageHint => 'Scrivi qualcosa (facoltativo)...';
	@override String get sendRequest => 'Invia richiesta';
	@override String get adminReview => 'L\'admin della stanza esaminerà la tua richiesta';
}

// Path: discover.roomApproved
class _Translations$discover$roomApproved$it extends Translations$discover$roomApproved$tr {
	_Translations$discover$roomApproved$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sei dentro!';
	@override String subtitle({required Object name}) => 'Il tuo posto in ${name} è riservato';
	@override String get continueLabel => 'Continua';
}

// Path: discover.createSpace
class _Translations$discover$createSpace$it extends Translations$discover$createSpace$tr {
	_Translations$discover$createSpace$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Crea stanza o gruppo';
	@override String get subtitle => 'Raggiungi più persone creando un gruppo o una stanza live';
	@override String get room => 'Stanza';
	@override String get group => 'Gruppo';
	@override String get hideAccount => 'Nascondi il tuo account';
	@override String get create => 'Crea';
	@override String get cancel => 'Annulla';
	@override String get createRoomTitle => 'Crea stanza';
	@override String get createGroupTitle => 'Crea gruppo';
	@override String get nameSubtitle => 'Dai un nome al gruppo che hai creato';
	@override String get nameHint => 'Nottambuli';
	@override String createRoomFor({required Object count}) => 'Crea per ${count} token';
}

// Path: discover.liveRoom
class _Translations$discover$liveRoom$it extends Translations$discover$liveRoom$tr {
	_Translations$discover$liveRoom$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get adminSuffix => '(Admin)';
	@override String get messageHint => 'Messaggio';
	@override String get quickReplyHey => 'Ciao a tutti!';
	@override String get quickReplyTopic => 'Di cosa si parla?';
	@override String get quickReplyNew => 'Sono nuovo qui!';
	@override String get sampleChatName => 'Sona';
	@override String get sampleChatBody => 'Cosa possiamo fare? Che idee hai?';
	@override String get roomEnded => 'La stanza è terminata.';
	@override String wantsToJoin({required Object name}) => '${name} vuole entrare';
	@override String get approve => 'Accetta';
}

// Path: discover.groupChat
class _Translations$discover$groupChat$it extends Translations$discover$groupChat$tr {
	_Translations$discover$groupChat$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String usersCount({required Object count}) => '${count} utenti';
	@override String get sampleVictoria => 'Mi sto annoiando tantissimo. Facciamo qualcosa, ragazzi?';
	@override String get sampleSona => 'Cosa possiamo fare? Che idee hai?';
	@override String get sampleOwn => 'Vediamoci al molo';
}

// Path: discover.groupInfo
class _Translations$discover$groupInfo$it extends Translations$discover$groupInfo$tr {
	_Translations$discover$groupInfo$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get media => 'Media';
	@override String get gallery => 'Galleria';
	@override String get settings => 'Impostazioni';
	@override String get notifications => 'Notifiche';
	@override String get blocked => 'Bloccati';
	@override String get private => 'Privato';
	@override String membersCount({required Object count}) => '${count} membri';
	@override String get addPeople => 'Aggiungi persone';
	@override String get you => 'Tu';
	@override String get admin => 'Admin';
	@override String get leaveGroup => 'Esci dal gruppo';
	@override String get requests => 'Richieste di accesso';
	@override String get approve => 'Accetta';
	@override String get reject => 'Rifiuta';
	@override String get addPeopleEmpty => 'Segui delle persone per aggiungerle al gruppo.';
	@override String get add => 'Aggiungi';
	@override String get makeAdmin => 'Rendi admin';
	@override String get removeAdmin => 'Rimuovi admin';
	@override String get remove => 'Rimuovi dal gruppo';
	@override String get leaveConfirm => 'Uscire da questo gruppo?';
	@override String get leave => 'Esci';
	@override String get cancel => 'Annulla';
}

// Path: discover.filters
class _Translations$discover$filters$it extends Translations$discover$filters$tr {
	_Translations$discover$filters$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Filtri';
	@override String get ageRange => 'Fascia d\'età';
	@override String ageRangeValue({required Object min, required Object max}) => '${min}-${max}';
	@override String get distance => 'Distanza';
	@override String distanceValue({required Object km}) => '${km} km';
	@override String get showMe => 'Mostrami';
	@override String get everyone => 'Tutti';
	@override String get women => 'Donne';
	@override String get men => 'Uomini';
	@override String get interests => 'Interessi';
	@override String get activeNow => 'Attivi ora';
	@override String get activeNowSubtitle => 'Mostra solo chi è online ora';
	@override String get showResult => 'Mostra risultati';
}

// Path: discover.post
class _Translations$discover$post$it extends Translations$discover$post$tr {
	_Translations$discover$post$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get follow => 'Segui';
	@override String get following => 'Segui già';
	@override String get addComment => 'Aggiungi un commento...';
	@override String get commentsTitle => 'Commenti';
	@override String get sampleCaption => 'Non c\'è niente di meglio di un caffè dopo una bella giornata. <3';
	@override String hoursAgo({required Object hours}) => '${hours}h';
	@override String minutesAgo({required Object minutes}) => '${minutes}m';
	@override String daysAgo({required Object days}) => '${days}g';
	@override String get deleteCommentTitle => 'Eliminare questo commento?';
}

// Path: discover.story
class _Translations$discover$story$it extends Translations$discover$story$tr {
	_Translations$discover$story$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get draft => 'BOZZA';
	@override String get story => 'STORIA';
	@override String get share => 'Condividi';
	@override String get textPlaceholder => 'Scrivi qualcosa...';
	@override String get draftPrompt => 'Salvare come bozza?';
	@override String get saveToDraft => 'Salva in bozze';
	@override String get moveToTrash => 'Sposta nel cestino';
	@override String get save => 'Salva';
	@override String get musicTitle => 'Musica';
	@override String get musicEmpty => 'Nessuna musica trovata.';
	@override String get musicError => 'Impossibile caricare la musica.';
	@override String get downloaded => 'Salvato in galleria';
	@override String get downloadFailed => 'Impossibile salvare';
}

// Path: discover.highlight
class _Translations$discover$highlight$it extends Translations$discover$highlight$tr {
	_Translations$discover$highlight$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'In evidenza';
	@override String get view => 'Vedi';
	@override String get aiComments => 'Commenti IA';
	@override String get remove => 'Rimuovi evidenza';
	@override String get sharedSuccess => 'Il tuo post è stato condiviso';
	@override String get boost => 'Boost';
}

// Path: discover.stats
class _Translations$discover$stats$it extends Translations$discover$stats$tr {
	_Translations$discover$stats$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Statistiche';
	@override String get subtitle => 'Qui sotto trovi le statistiche\ndel tuo post.';
	@override String get viewers => 'Visualizzazioni';
	@override String get comments => 'Commenti';
	@override String get likes => 'Mi piace';
	@override String get boostCta => 'Boost per 1 giorno - 100 token';
	@override String get boosted => 'Boost attivo! Il tuo post resta in cima per 24 ore.';
}

// Path: createProfile.interests
class _Translations$createProfile$interests$it extends Translations$createProfile$interests$tr {
	_Translations$createProfile$interests$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get music => 'Musica';
	@override String get movies => 'Film';
	@override String get tvShows => 'Serie TV';
	@override String get reading => 'Lettura';
	@override String get painting => 'Pittura';
	@override String get photography => 'Fotografia';
	@override String get theatre => 'Teatro';
	@override String get fitness => 'Fitness';
	@override String get swimming => 'Nuoto';
	@override String get football => 'Calcio';
	@override String get basketball => 'Basket';
	@override String get coffee => 'Caffè';
	@override String get travel => 'Viaggi';
	@override String get camping => 'Campeggio';
	@override String get meditation => 'Meditazione';
	@override String get videoGames => 'Videogiochi';
	@override String get boardGames => 'Giochi da tavolo';
	@override String get standUp => 'Stand-up comedy';
	@override String get tech => 'Tecnologia';
	@override String get coding => 'Programmazione';
	@override String get ai => 'IA';
	@override String get podcast => 'Podcast';
}

/// The flat map containing all translations for locale <it>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsIt {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.name' => 'Veylo',
			'app.tagline' => 'Benvenuto',
			'home.title' => 'Home',
			'home.subtitle' => 'L\'app è in preparazione',
			'home.body' => 'L\'interfaccia multilingue è gestita con slang.',
			'chats.title' => 'Chat',
			'chats.search' => 'Cerca',
			'chats.messagesSection' => 'Messaggi',
			'chats.request' => 'Richieste',
			'chats.emptyRequestTitle' => 'Nessuna notifica di messaggi\nrecente',
			'chats.emptyRequestSubtitle' => 'Le richieste più vecchie di 30 giorni non vengono mostrate.',
			'chats.noteAdd' => 'Aggiungi nota',
			'chats.anonymous' => 'Anonimo',
			'chats.online' => 'online',
			'chats.offline' => 'offline',
			'chats.connection' => 'Connessione',
			'chats.connectionPercent' => ({required Object n}) => '${n}%',
			'chats.connectionProgressTitle' => 'Progresso connessione',
			'chats.milestoneInitial' => 'Iniziale del nome',
			'chats.milestoneInitialHint' => 'Sbloccata al 25%',
			'chats.milestoneInitialLocked' => 'Si sblocca al 25%',
			'chats.milestonePhoto' => 'Anteprima foto sfocata',
			'chats.milestonePhotoHint' => 'Si sblocca al 70%',
			'chats.milestoneFull' => 'Profilo completo',
			'chats.milestoneFullHint' => 'Consenso reciproco al 100%',
			'chats.sampleAnonymousMessage' => 'Ciao, è stato un piacere conoscerti. Mi racconti un po\' di te?',
			'chats.strangerSampleMessage' => 'Ciao Jhon, è stato un piacere conoscerti. Mi racconti un po\' di te?',
			'chats.approve' => 'Accetta',
			'chats.blockUser' => 'Blocca utente',
			'chats.reject' => 'Rifiuta',
			'chats.messageHint' => 'Ciao! Come stai?',
			'chats.revealTitle' => 'Hai raggiunto il 100%',
			'chats.revealSubtitle' => 'Volete mostrarvi i profili completi? Dovete essere d\'accordo entrambi.',
			'chats.revealWaiting' => ({required Object name}) => 'In attesa che ${name} accetti',
			'chats.revealCta' => 'Mostra il mio profilo',
			'chats.revealNotYet' => 'Non ancora',
			'chats.seen' => 'Visto',
			'chats.typing' => 'sta scrivendo…',
			'chats.noteYou' => 'Tu',
			'chats.noteSheetTitle' => 'Condividi una nota',
			'chats.noteSheetSubtitle' => 'La tua nota resta per 24 ore',
			'chats.noteHint' => 'A cosa stai pensando?',
			'chats.noteShare' => 'Condividi',
			'chats.noteDelete' => 'Elimina nota',
			'profile.eyebrow' => 'Profilo',
			'profile.title' => 'Impostazioni',
			'profile.editProfile' => 'Modifica profilo',
			'profile.statLike' => 'Mi piace',
			'profile.statFollow' => 'Seguiti',
			'profile.statFollower' => 'Follower',
			'profile.promoTitle' => 'Ricevi più messaggi!',
			'profile.promoSubtitle' => 'Fatti notare, appari in cima alla lista',
			'profile.standOut' => 'Fatti notare',
			'profile.tabPosts' => 'Post',
			'profile.tabVideo' => 'Video',
			'profile.tabSaved' => 'Salvati',
			'profile.save' => 'Salva',
			'profile.changePhoto' => 'Cambia foto',
			'profile.changeBorder' => 'Cambia cornice',
			'profile.interest' => 'Interessi',
			'profile.name' => 'Nome',
			'profile.changeName' => 'Cambia nome',
			'profile.changePassword' => 'Cambia password',
			'profile.confirmPassword' => 'Conferma password',
			'profile.email' => 'Email',
			'profile.accountManagement' => 'Gestione account',
			'profile.settingsAbout' => 'Info',
			'profile.settingsAccount' => 'Impostazioni account',
			'profile.settingsSupport' => 'Supporto',
			'profile.shareApp' => 'Condividi l\'app',
			'profile.shareAppTitle' => 'Condividi con gli amici',
			'profile.shareAppSubtitle' => 'Condividi Veylo con i tuoi amici e scoprite insieme!',
			'profile.shareAppLabel' => 'Link dell\'app',
			'profile.rateApp' => 'Ti piacciamo? Valutaci',
			'profile.notifications' => 'Notifiche',
			'profile.password' => 'Password',
			'profile.deleteConversation' => 'Elimina conversazioni',
			'profile.faqHelp' => 'FAQ e assistenza',
			'profile.restorePurchases' => 'Ripristina acquisti',
			'profile.termsOfService' => 'Termini di servizio',
			'profile.privacyPolicy' => 'Informativa sulla privacy',
			'profile.restorePurchasesDone' => 'Acquisti verificati',
			'profile.conversationsDeleted' => 'Tutte le conversazioni eliminate',
			'profile.logOut' => 'Esci',
			'profile.deleteAccountAndData' => 'Elimina account e dati',
			'profile.passwordPlaceholder' => '********',
			'profile.height' => 'Altezza',
			'profile.addHeight' => 'Aggiungi altezza',
			'profile.heightCm' => ({required Object value}) => '${value} cm',
			'profile.languages' => 'Lingue',
			'profile.relationshipGoals' => 'Obiettivi relazionali',
			'profile.lookingFor' => 'Cerco',
			'profile.newFriends' => '👋 Nuovi amici',
			'profile.goalLongTermOpenToShort' => '💕 Lunga durata, aperto a breve',
			'profile.goalLongTermRelationship' => '💘 Relazione duratura',
			'profile.goalNewFriends' => '👋 Nuovi amici',
			'profile.goalShortTermFun' => '🥃 Divertimento a breve termine',
			'profile.goalStillFiguringItOut' => '🤔 Ci sto ancora pensando',
			'profile.basics' => 'Info di base',
			'profile.zodiac' => 'Segno zodiacale',
			'profile.zodiacValue' => 'Scorpione',
			'profile.education' => 'Istruzione',
			'profile.educationValue' => 'Laurea triennale',
			'profile.educationHighSchool' => 'Scuola superiore',
			'profile.educationAssociates' => 'Diploma post-secondario',
			'profile.educationBachelors' => 'Laurea triennale',
			'profile.educationMasters' => 'Laurea magistrale',
			'profile.educationPhd' => 'Dottorato',
			'profile.voiceRecord' => 'Registrazione vocale',
			'profile.addVoice' => 'Aggiungi voce',
			'profile.lifestyle' => 'Stile di vita',
			'profile.pets' => 'Animali',
			'profile.petsValue' => 'Ho un gatto',
			'profile.petsDontWant' => 'Non voglio animali',
			'profile.petsAllergic' => 'Sono allergico agli animali',
			'profile.petsHaveCat' => 'Ho un gatto',
			'profile.petsHaveDog' => 'Ho un cane',
			'profile.petsHaveCatsAndDogs' => 'Ho cani e gatti',
			'profile.petsHaveOther' => 'Ho altri animali',
			'profile.drinking' => 'Alcol',
			'profile.drinkingValue' => 'In occasioni speciali',
			'profile.drinkingNever' => 'Mai',
			'profile.drinkingSpecialOccasions' => 'In occasioni speciali',
			'profile.drinkingSocially' => 'In compagnia',
			'profile.drinkingFrequently' => 'Spesso',
			'profile.drinkingSober' => 'Astemio',
			'profile.drinkingPreferNotToSay' => 'Preferisco non dirlo',
			'profile.smoking' => 'Fumo',
			'profile.smokingValue' => 'Non fumatore',
			'profile.smokingNonSmoker' => 'Non fumatore',
			'profile.smokingSocialSmoker' => 'Fumo in compagnia',
			'profile.smokingSmoker' => 'Fumatore',
			'profile.smokingTryingToQuit' => 'Sto cercando di smettere',
			'profile.smokingWhenDrinking' => 'Fumo quando bevo',
			'profile.smokingPreferNotToSay' => 'Preferisco non dirlo',
			'profile.gender' => 'Genere',
			'profile.genderFemale' => 'Donna',
			'profile.genderMale' => 'Uomo',
			'profile.genderPreferNotToSay' => 'Preferisco non dirlo',
			'profile.visible' => 'Visibile',
			'profile.profileVisibility' => 'Visibilità profilo',
			'profile.language' => 'Lingua',
			'profile.borderTitle' => 'Cornice profilo',
			'profile.borderSubtitle' => 'Aggiungi una cornice al tuo profilo per\nfarti notare.',
			'profile.borderBuySection' => 'Acquista una cornice',
			'profile.borderBuyCta' => 'Acquista cornice',
			'profile.borderToken' => ({required Object count}) => '${count} token',
			'profile.borderAmethystWings' => 'Amethyst Wings',
			'profile.borderGoldenPhoenix' => 'Golden Phoenix',
			'profile.borderFrostCrown' => 'Frost Crown',
			'profile.borderEmeraldWhisper' => 'Emerald Whisper',
			'profile.borderRoseQuartz' => 'Rose Quartz',
			'profile.borderStarlitComet' => 'Starlit Comet',
			'profile.borderCrimsonRoyal' => 'Crimson Royal',
			'profile.borderSapphireHalo' => 'Sapphire Halo',
			'profile.follow' => 'Segui',
			'profile.following' => 'Segui già',
			'profile.followPageTitle' => 'Segui',
			'profile.followTabFollowing' => 'Seguiti',
			'profile.followTabFollowers' => 'Follower',
			'profile.followSearch' => 'Cerca',
			'profile.unfollow' => 'Non seguire più',
			'profile.followSortTitle' => 'Ordina',
			'profile.followSortRecent' => 'Persone che ho seguito di recente',
			'profile.followSortNotFollowingMe' => 'Chi non mi segue a sua volta',
			'profile.followSortNotFollowedByMe' => 'Chi non seguo a mia volta',
			'profile.followSortShowResult' => 'Mostra risultati',
			'profile.followSortEmpty' => 'Nessun utente corrisponde al filtro',
			'profile.shareTitle' => 'Condividi con gli amici',
			'profile.shareSubtitle' => 'Tutto è più divertente quando ti connetti\ncon i tuoi amici!',
			'profile.shareProfileLabel' => 'Condividi il profilo',
			'profile.shareLinkCopied' => 'Link copiato',
			'profile.restrict' => 'Limita',
			'profile.block' => 'Blocca',
			'profile.report' => 'Segnala',
			'profile.blockTitle' => ({required Object username}) => 'Bloccare ${username} ?',
			'profile.blockBody' => 'Verranno bloccati anche eventuali altri account che ha o creerà in futuro. Puoi sbloccarlo quando vuoi.',
			'profile.blockAndReport' => 'Blocca e segnala',
			'profile.restrictTitle' => ({required Object username}) => 'Limitare ${username} ?',
			'profile.restrictBody' => 'Non potrà vedere quando sei online o se hai letto i suoi messaggi. Puoi cambiarlo quando vuoi.',
			'profile.restrictAndReport' => 'Limita e segnala',
			'profile.reportTitle' => 'Vorremmo sapere perché',
			'profile.reportSubtitle' => 'Per offrirti un\'esperienza migliore, ci dici perché vuoi segnalare questo utente?',
			'profile.reportMessageLabel' => 'Messaggio di segnalazione',
			'profile.reportMessageHint' => 'Scrivi il tuo messaggio',
			'profile.reportCancel' => 'Annulla',
			'profile.sendReport' => 'Invia segnalazione',
			'profile.notSet' => 'Non impostato',
			'profile.reportSent' => 'Grazie, abbiamo ricevuto la tua segnalazione.',
			'profile.emailVerificationSent' => ({required Object email}) => 'Abbiamo inviato un link di conferma a ${email}. La tua email cambierà dopo la conferma.',
			'profile.passwordChanged' => 'La tua password è stata aggiornata.',
			'profile.passwordMismatch' => 'Le password non coincidono.',
			'nav.discover' => 'Scopri',
			'nav.chat' => 'Chat',
			'nav.call' => 'Chiama',
			'nav.vibes' => 'Vibes',
			'nav.profile' => 'Profilo',
			'call.title' => 'Sconosciuto in 60 secondi',
			'call.subtitle' => 'Parla con uno sconosciuto a caso per 60 secondi, in totale anonimato. Niente profilo, niente foto, niente nome. Solo una voce e un momento.',
			'call.findingTitle' => 'Cerco uno sconosciuto...',
			'call.findingSubtitle' => 'Parlerete in anonimo per 60 secondi. Niente profili, niente nomi.',
			'call.callStranger' => 'Chiama uno sconosciuto - 10 token',
			'call.cancel' => 'Annulla',
			'call.female' => 'Donna',
			'call.male' => 'Uomo',
			'call.nonBinary' => 'Non binario',
			'call.preferNotToSay' => 'Preferisco non dirlo',
			'call.anonymousBadge' => '🎙️ Chiamata vocale anonima',
			'call.stranger' => 'Sconosciuto',
			'call.secondsLeft' => ({required Object n}) => '${n}s',
			'call.timesUpTitle' => 'Tempo scaduto!',
			'call.timesUpSubtitle' => 'Vuoi continuare a parlare? Se dite sì entrambi, si sblocca la chat.',
			'call.keepTalking' => 'Continua a parlare',
			'call.endCall' => 'Termina',
			'call.waitingOther' => 'In attesa dell\'altra persona...',
			'call.callStrangerFree' => 'Chiama uno sconosciuto',
			'call.peerLeft' => 'L\'altra persona ha chiuso la chiamata.',
			'call.noKeep' => 'Stavolta la chat non si è sbloccata.',
			'call.videoWaiting' => 'In attesa che accetti la videochiamata...',
			'call.videoDeclined' => 'Ha rifiutato la videochiamata.',
			'call.micDenied' => 'Per le chiamate serve l\'accesso al microfono. Puoi attivarlo nelle Impostazioni.',
			'call.videoCost' => 'Videochiamata: 20 token / 15 min',
			'call.calling' => 'Chiamata in corso',
			'call.accept' => 'Accetta',
			'call.decline' => 'Rifiuta',
			'call.switchToVideo' => 'Vuoi passare a una videochiamata?',
			'call.noMatchTitle' => 'Nessuno è disponibile al momento',
			'call.noMatchBody' => 'Al momento non abbiamo trovato nessuno con cui parlare. Riprova tra un po\'.',
			'call.noMatchOk' => 'OK',
			'vibes.search' => 'Cerca',
			'vibes.sendMessage' => 'Invia messaggio',
			'vibes.wantsToTalk' => 'Vuole parlarne proprio ora',
			'vibes.shareTitle' => 'Condividi Vibe',
			'vibes.replyTitle' => 'Rispondi alla Vibe',
			'vibes.shareHint' => 'Scrivi qualcosa',
			'vibes.shareAnonymous' => 'Condividi in anonimo',
			'vibes.empty' => 'Nessuna vibe nelle ultime 24 ore. Condividi la prima!',
			'vibes.deleteTitle' => 'Eliminare questa vibe?',
			'vibes.delete' => 'Elimina',
			'vibes.cancel' => 'Annulla',
			'discover.title' => 'Scopri',
			'discover.tabRooms' => 'Stanze',
			'discover.tabDiscover' => 'Scopri',
			'discover.tabAiMatch' => 'AI Match',
			'discover.aiMatch.feelingTitle' => 'Come ti senti oggi',
			'discover.aiMatch.feelingSubtitle' => 'L\'IA trova il match migliore in base alla tua scelta',
			'discover.aiMatch.lookingTitle' => 'Cosa stai cercando?',
			'discover.aiMatch.moodSad' => 'Triste',
			'discover.aiMatch.moodMeltie' => 'Così così',
			'discover.aiMatch.moodBored' => 'Annoiato',
			'discover.aiMatch.moodCrying' => 'Giù',
			'discover.aiMatch.moodSmile' => 'Felice',
			'discover.aiMatch.lookingNewFriends' => 'Nuovi amici',
			'discover.aiMatch.lookingVenting' => 'Sfogarmi',
			'discover.aiMatch.lookingFlirty' => 'Flirt',
			'discover.aiMatch.lookingFun' => 'Divertimento',
			'discover.aiMatch.lookingCultures' => 'Nuove culture',
			'discover.aiMatch.lookingLanguage' => 'Pratica lingue',
			'discover.aiMatch.statActiveUsers' => 'Utenti attivi',
			'discover.aiMatch.statMatchRate' => 'Tasso di match',
			'discover.aiMatch.statAvgTime' => 'Tempo medio',
			'discover.aiMatch.statActiveValue' => '843',
			'discover.aiMatch.statMatchValue' => '87%',
			'discover.aiMatch.statAvgValue' => '8s',
			'discover.aiMatch.startSmartMatch' => 'Avvia Smart Match',
			'discover.aiMatch.findingTitle' => 'Cerco il tuo match',
			'discover.aiMatch.findingSubtitle' => 'Abbiniamo il tuo umore e i tuoi interessi alla persona giusta',
			'discover.aiMatch.findingStepMood' => 'Umore analizzato',
			'discover.aiMatch.findingStepInterests' => 'Interessi abbinati',
			'discover.aiMatch.findingStepCompatibility' => 'Calcolo compatibilità...',
			'discover.aiMatch.findingStepContent' => 'Creazione contenuti...',
			'discover.aiMatch.findingOnline' => ({required Object count}) => '${count} persone online ora',
			'discover.aiMatch.yourMatchTitle' => 'Il tuo match',
			'discover.aiMatch.yourMatchSubtitle' => 'Il match si basa sulle tue risposte',
			'discover.aiMatch.vibeMatch' => ({required Object percent}) => '${percent}% di affinità',
			'discover.aiMatch.startChatting' => 'Inizia a chattare',
			'discover.aiMatch.matchNameAge' => ({required Object name, required Object age}) => '${name}, ${age}',
			'discover.aiMatch.matchBio' => 'Ti farò provare emozioni che non sapevi di poter provare.',
			'discover.aiMatch.swipePrevious' => 'Indietro',
			'discover.aiMatch.swipeNext' => 'Avanti',
			'discover.aiMatch.swipeFinger' => 'Scorri col dito',
			'discover.aiMatch.noMatch' => 'Nessun match al momento. Riprova tra poco.',
			'discover.searchHint' => 'Cerca',
			'discover.allRooms' => 'Tutte le stanze',
			'discover.allGroups' => 'Tutti i gruppi',
			'discover.seeAll' => 'Vedi tutti',
			'discover.live' => 'Live',
			'discover.join' => 'Entra',
			'discover.request' => 'Richiedi',
			'discover.requested' => 'Richiesto',
			'discover.private' => 'Privata',
			'discover.moreCount' => ({required Object count}) => '+${count} altri',
			'discover.activeCount' => ({required Object count}) => '${count} attivi',
			'discover.membersCount' => ({required Object count}) => '${count} membri',
			'discover.privateRoom.subtitle' => 'Questa è una stanza privata. Sblocca l\'accesso con i token.',
			'discover.privateRoom.roomAccess' => 'Accesso stanza',
			'discover.privateRoom.yourBalance' => 'Il tuo saldo',
			'discover.privateRoom.tokensAmount' => ({required Object count}) => '${count} token',
			'discover.privateRoom.joinForTokens' => ({required Object count}) => 'Entra per ${count} token',
			'discover.privateRoom.cancel' => 'Annulla',
			'discover.roomToken.subtitle' => 'Sblocca l\'accesso con i token.',
			'discover.roomToken.roomAccess' => 'Accesso stanza',
			'discover.roomToken.yourBalance' => 'Il tuo saldo',
			'discover.roomToken.tokensAmount' => ({required Object count}) => '${count} token',
			'discover.roomToken.joinForTokens' => ({required Object count}) => 'Entra per ${count} token',
			'discover.roomToken.cancel' => 'Annulla',
			'discover.privateRequest.title' => 'Richiesta di accesso',
			'discover.privateRequest.roomInfo' => ({required Object name, required Object count}) => '${name} · ${count} membri',
			'discover.privateRequest.messageHint' => 'Scrivi qualcosa (facoltativo)...',
			'discover.privateRequest.sendRequest' => 'Invia richiesta',
			'discover.privateRequest.adminReview' => 'L\'admin della stanza esaminerà la tua richiesta',
			'discover.roomApproved.title' => 'Sei dentro!',
			'discover.roomApproved.subtitle' => ({required Object name}) => 'Il tuo posto in ${name} è riservato',
			'discover.roomApproved.continueLabel' => 'Continua',
			'discover.createSpace.title' => 'Crea stanza o gruppo',
			'discover.createSpace.subtitle' => 'Raggiungi più persone creando un gruppo o una stanza live',
			'discover.createSpace.room' => 'Stanza',
			'discover.createSpace.group' => 'Gruppo',
			'discover.createSpace.hideAccount' => 'Nascondi il tuo account',
			'discover.createSpace.create' => 'Crea',
			'discover.createSpace.cancel' => 'Annulla',
			'discover.createSpace.createRoomTitle' => 'Crea stanza',
			'discover.createSpace.createGroupTitle' => 'Crea gruppo',
			'discover.createSpace.nameSubtitle' => 'Dai un nome al gruppo che hai creato',
			'discover.createSpace.nameHint' => 'Nottambuli',
			'discover.createSpace.createRoomFor' => ({required Object count}) => 'Crea per ${count} token',
			'discover.liveRoom.adminSuffix' => '(Admin)',
			'discover.liveRoom.messageHint' => 'Messaggio',
			'discover.liveRoom.quickReplyHey' => 'Ciao a tutti!',
			'discover.liveRoom.quickReplyTopic' => 'Di cosa si parla?',
			'discover.liveRoom.quickReplyNew' => 'Sono nuovo qui!',
			'discover.liveRoom.sampleChatName' => 'Sona',
			'discover.liveRoom.sampleChatBody' => 'Cosa possiamo fare? Che idee hai?',
			'discover.liveRoom.roomEnded' => 'La stanza è terminata.',
			'discover.liveRoom.wantsToJoin' => ({required Object name}) => '${name} vuole entrare',
			'discover.liveRoom.approve' => 'Accetta',
			'discover.groupChat.usersCount' => ({required Object count}) => '${count} utenti',
			'discover.groupChat.sampleVictoria' => 'Mi sto annoiando tantissimo. Facciamo qualcosa, ragazzi?',
			'discover.groupChat.sampleSona' => 'Cosa possiamo fare? Che idee hai?',
			'discover.groupChat.sampleOwn' => 'Vediamoci al molo',
			'discover.groupInfo.media' => 'Media',
			'discover.groupInfo.gallery' => 'Galleria',
			'discover.groupInfo.settings' => 'Impostazioni',
			'discover.groupInfo.notifications' => 'Notifiche',
			'discover.groupInfo.blocked' => 'Bloccati',
			'discover.groupInfo.private' => 'Privato',
			'discover.groupInfo.membersCount' => ({required Object count}) => '${count} membri',
			'discover.groupInfo.addPeople' => 'Aggiungi persone',
			'discover.groupInfo.you' => 'Tu',
			'discover.groupInfo.admin' => 'Admin',
			'discover.groupInfo.leaveGroup' => 'Esci dal gruppo',
			'discover.groupInfo.requests' => 'Richieste di accesso',
			'discover.groupInfo.approve' => 'Accetta',
			'discover.groupInfo.reject' => 'Rifiuta',
			'discover.groupInfo.addPeopleEmpty' => 'Segui delle persone per aggiungerle al gruppo.',
			'discover.groupInfo.add' => 'Aggiungi',
			'discover.groupInfo.makeAdmin' => 'Rendi admin',
			'discover.groupInfo.removeAdmin' => 'Rimuovi admin',
			'discover.groupInfo.remove' => 'Rimuovi dal gruppo',
			'discover.groupInfo.leaveConfirm' => 'Uscire da questo gruppo?',
			'discover.groupInfo.leave' => 'Esci',
			'discover.groupInfo.cancel' => 'Annulla',
			'discover.filters.title' => 'Filtri',
			'discover.filters.ageRange' => 'Fascia d\'età',
			'discover.filters.ageRangeValue' => ({required Object min, required Object max}) => '${min}-${max}',
			'discover.filters.distance' => 'Distanza',
			'discover.filters.distanceValue' => ({required Object km}) => '${km} km',
			'discover.filters.showMe' => 'Mostrami',
			'discover.filters.everyone' => 'Tutti',
			'discover.filters.women' => 'Donne',
			'discover.filters.men' => 'Uomini',
			'discover.filters.interests' => 'Interessi',
			'discover.filters.activeNow' => 'Attivi ora',
			'discover.filters.activeNowSubtitle' => 'Mostra solo chi è online ora',
			'discover.filters.showResult' => 'Mostra risultati',
			'discover.post.follow' => 'Segui',
			'discover.post.following' => 'Segui già',
			'discover.post.addComment' => 'Aggiungi un commento...',
			'discover.post.commentsTitle' => 'Commenti',
			'discover.post.sampleCaption' => 'Non c\'è niente di meglio di un caffè dopo una bella giornata. <3',
			'discover.post.hoursAgo' => ({required Object hours}) => '${hours}h',
			'discover.post.minutesAgo' => ({required Object minutes}) => '${minutes}m',
			'discover.post.daysAgo' => ({required Object days}) => '${days}g',
			'discover.post.deleteCommentTitle' => 'Eliminare questo commento?',
			'discover.story.draft' => 'BOZZA',
			'discover.story.story' => 'STORIA',
			'discover.story.share' => 'Condividi',
			'discover.story.textPlaceholder' => 'Scrivi qualcosa...',
			'discover.story.draftPrompt' => 'Salvare come bozza?',
			'discover.story.saveToDraft' => 'Salva in bozze',
			'discover.story.moveToTrash' => 'Sposta nel cestino',
			'discover.story.save' => 'Salva',
			'discover.story.musicTitle' => 'Musica',
			'discover.story.musicEmpty' => 'Nessuna musica trovata.',
			'discover.story.musicError' => 'Impossibile caricare la musica.',
			'discover.story.downloaded' => 'Salvato in galleria',
			'discover.story.downloadFailed' => 'Impossibile salvare',
			'discover.highlight.title' => 'In evidenza',
			'discover.highlight.view' => 'Vedi',
			'discover.highlight.aiComments' => 'Commenti IA',
			'discover.highlight.remove' => 'Rimuovi evidenza',
			'discover.highlight.sharedSuccess' => 'Il tuo post è stato condiviso',
			'discover.highlight.boost' => 'Boost',
			'discover.stats.title' => 'Statistiche',
			'discover.stats.subtitle' => 'Qui sotto trovi le statistiche\ndel tuo post.',
			'discover.stats.viewers' => 'Visualizzazioni',
			'discover.stats.comments' => 'Commenti',
			'discover.stats.likes' => 'Mi piace',
			'discover.stats.boostCta' => 'Boost per 1 giorno - 100 token',
			'discover.stats.boosted' => 'Boost attivo! Il tuo post resta in cima per 24 ore.',
			'discover.hostedBy' => ({required Object name}) => 'Organizzata da ${name}',
			'common.loading' => 'Caricamento…',
			'common.retry' => 'Riprova',
			'common.cancel' => 'Annulla',
			'common.save' => 'Salva',
			'common.continueAction' => 'Continua',
			'common.language' => 'Lingua',
			'common.or' => 'OPPURE',
			'languages.tr' => 'Türkçe',
			'languages.en' => 'English',
			'auth.createAccountTitle' => 'Crea il tuo account',
			'auth.createAccountSubtitle' => 'Unisciti a Veylo e inizia a conoscere gente.',
			'auth.welcomeBackTitle' => 'Bentornato',
			'auth.welcomeBackSubtitle' => 'Accedi per continuare su Veylo.',
			'auth.username' => 'Nome utente',
			'auth.usernameHint' => 'Scegli un nome utente',
			'auth.email' => 'Email',
			'auth.emailHint' => 'Inserisci la tua email',
			'auth.emailOrUsername' => 'Email o nome utente',
			'auth.emailOrUsernameHint' => 'Inserisci email o nome utente',
			'auth.password' => 'Password',
			'auth.passwordCreateHint' => 'Crea una password',
			'auth.passwordEnterHint' => 'Inserisci la tua password',
			'auth.signUp' => 'Registrati',
			'auth.logIn' => 'Accedi',
			'auth.forgotPassword' => 'Password dimenticata?',
			'auth.continueWithApple' => 'Continua con Apple',
			'auth.continueWithGoogle' => 'Continua con Google',
			'auth.legalPrefix' => 'Continuando, accetti i nostri ',
			'auth.termsOfService' => 'Termini di servizio',
			'auth.legalMiddle' => ' e confermi di aver letto la nostra ',
			'auth.privacyPolicy' => 'Informativa sulla privacy',
			'auth.legalSuffix' => '.',
			'auth.passwordResetSent' => 'Ti abbiamo inviato via email un link per reimpostare la password.',
			'onboarding.skip' => 'Salta',
			'onboarding.page1Title' => 'Sii te stesso. Resta anonimo.',
			'onboarding.page1Subtitle' => 'Conosci persone nuove e inizia a chattare\nsenza rivelare chi sei.',
			'onboarding.page2Title' => 'Scrivi. Parla. Senti la vibe.',
			'onboarding.page2Subtitle' => 'Inizia in anonimo, poi scrivi, chiama o incontratevi quando ti senti pronto.',
			'onboarding.page3Title' => 'Trova la tua gente. Unisciti\nalla conversazione.',
			'onboarding.page3Subtitle' => 'Entra nelle stanze, conosci persone nuove e\nvivi il momento insieme.',
			'onboarding.getStarted' => 'Iniziamo',
			'onboarding.alreadyHaveAccount' => 'Hai già un account Veylo? ',
			'onboarding.logInAction' => 'Accedi',
			'createProfile.navTitle' => 'Crea profilo',
			'createProfile.stepUsername' => '1/5 Nome utente',
			'createProfile.title' => 'Crea il tuo profilo',
			'createProfile.subtitle' => 'Il tuo nome reale serve solo per la verifica: non sarà visibile pubblicamente.',
			'createProfile.subtitleLine1' => 'Il tuo nome reale serve solo per la verifica: non',
			'createProfile.subtitleLine2' => 'sarà visibile pubblicamente.',
			'createProfile.fullName' => 'Nome e cognome',
			'createProfile.fullNameHint' => 'Sam Lee',
			'createProfile.username' => 'Nome utente',
			'createProfile.usernameHint' => 'samlee123',
			'createProfile.usernameTaken' => 'Questo nome utente esiste già!',
			'createProfile.usernameAvailable' => 'Nome utente disponibile',
			'createProfile.mightWantToTry' => 'Potresti provare...',
			'createProfile.stepPhoto' => '2/5 Foto profilo',
			'createProfile.photoTitle' => 'Carica una foto profilo',
			'createProfile.photoSubtitle' => 'Gli altri utenti possono vedere la tua foto profilo per sapere che sei tu.',
			'createProfile.photoSubtitleLine1' => 'Gli altri utenti possono vedere la tua foto profilo',
			'createProfile.photoSubtitleLine2' => 'per sapere che sei tu.',
			'createProfile.choosePhoto' => 'Scegli una foto',
			'createProfile.continueWithoutPhoto' => 'Continua senza foto profilo',
			'createProfile.saveAndContinue' => 'Salva e continua',
			'createProfile.choosePhotoSheetTitle' => 'Scegli una foto',
			'createProfile.takePhoto' => 'Scatta una foto',
			'createProfile.chooseFromGallery' => 'Scegli dalla libreria',
			'createProfile.stepGender' => '3/5 Genere',
			'createProfile.genderTitle' => 'Scegli il tuo genere',
			'createProfile.genderSubtitle' => 'Se scegli di fornirci questa informazione, potremmo usarla per personalizzare i contenuti per te',
			'createProfile.genderSubtitleLine1' => 'Se scegli di fornirci questa informazione, potremmo',
			'createProfile.genderSubtitleLine2' => 'usarla per personalizzare i contenuti per te',
			'createProfile.genderFemale' => 'Donna',
			'createProfile.genderMale' => 'Uomo',
			'createProfile.genderNonBinary' => 'Non binario',
			'createProfile.genderPreferNotToSay' => 'Preferisco non dirlo',
			'createProfile.stepInterests' => '4/5 Interessi',
			'createProfile.interestsTitle' => 'Cosa ti appassiona?',
			'createProfile.interestsSubtitle' => 'Scegline almeno 5: ci aiuta ad abbinarti a persone che ti capiscono davvero.',
			'createProfile.interests.music' => 'Musica',
			'createProfile.interests.movies' => 'Film',
			'createProfile.interests.tvShows' => 'Serie TV',
			'createProfile.interests.reading' => 'Lettura',
			'createProfile.interests.painting' => 'Pittura',
			'createProfile.interests.photography' => 'Fotografia',
			'createProfile.interests.theatre' => 'Teatro',
			'createProfile.interests.fitness' => 'Fitness',
			'createProfile.interests.swimming' => 'Nuoto',
			'createProfile.interests.football' => 'Calcio',
			'createProfile.interests.basketball' => 'Basket',
			'createProfile.interests.coffee' => 'Caffè',
			'createProfile.interests.travel' => 'Viaggi',
			'createProfile.interests.camping' => 'Campeggio',
			'createProfile.interests.meditation' => 'Meditazione',
			'createProfile.interests.videoGames' => 'Videogiochi',
			'createProfile.interests.boardGames' => 'Giochi da tavolo',
			'createProfile.interests.standUp' => 'Stand-up comedy',
			'createProfile.interests.tech' => 'Tecnologia',
			'createProfile.interests.coding' => 'Programmazione',
			'createProfile.interests.ai' => 'IA',
			'createProfile.interests.podcast' => 'Podcast',
			_ => null,
		} ?? switch (path) {
			'createProfile.stepChatGoal' => '5/5 Obiettivo chat',
			'createProfile.chatGoalTitle' => 'Cosa cerchi oggi?',
			'createProfile.chatGoalSubtitle' => 'Ci aiuta a trovare il match giusto per il tuo umore di adesso.',
			'createProfile.chatGoalQuickMatch' => 'Match veloce: tuffati subito in una\nconversazione',
			'createProfile.chatGoalFlirtyChat' => 'Flirt: conversazioni leggere e\ngiocose',
			'createProfile.chatGoalMoodMatch' => 'Match d\'umore: abbinamento in base a come\nti senti',
			'createProfile.chatGoalLateNight' => 'Chiacchiere notturne: discorsi profondi mentre il mondo\ndorme',
			'createProfile.chatGoalMeetSomeoneNew' => 'Conosci qualcuno di nuovo: nessun obiettivo,\nsolo esplorare',
			'createProfile.getStarted' => 'Iniziamo',
			'createProfile.preparingTitleLine1' => 'Stiamo preparando',
			'createProfile.preparingTitleLine2' => 'i profili giusti per',
			'createProfile.preparingTitleLine3' => 'te.',
			'createProfile.preparingSubtitleLine1' => 'In base alle tue risposte, stiamo scegliendo',
			'createProfile.preparingSubtitleLine2' => 'i match migliori: attendi un momento.',
			'createProfile.preparingPercent' => ({required Object percent}) => '${percent}%',
			'createProfile.usernameInvalid' => 'Usa 3–30 lettere, numeri, punti o trattini bassi.',
			'errors.network' => 'Impossibile raggiungere Veylo. Controlla la connessione e riprova.',
			'errors.generic' => 'Qualcosa è andato storto. Riprova.',
			'errors.signInFailed' => 'Accesso non riuscito. Riprova.',
			'errors.sessionExpired' => 'La sessione è scaduta. Accedi di nuovo.',
			'errors.accountSuspended' => 'Questo account è stato sospeso.',
			'errors.unsupportedImage' => 'Scegli una foto JPEG, PNG o WebP.',
			'errors.fileTooLarge' => 'Questo file è troppo grande.',
			'errors.enterEmailForReset' => 'Inserisci la tua email qui sopra per reimpostare la password.',
			'errors.wrongCredentials' => 'Email/nome utente o password errati.',
			'errors.emailInUse' => 'Questa email è già registrata. Prova ad accedere.',
			'errors.weakPassword' => 'La password deve avere almeno 6 caratteri.',
			'errors.invalidEmail' => 'Inserisci un indirizzo email valido.',
			'errors.tooManyAttempts' => 'Troppi tentativi. Attendi un po\' e riprova.',
			'errors.fillAllFields' => 'Compila tutti i campi.',
			'errors.insufficientTokens' => 'Token insufficienti.',
			'errors.requestNotAccepted' => 'Accetta la richiesta per rispondere.',
			'errors.requestPendingLimit' => 'Potrai inviare altri messaggi quando avrà accettato la tua richiesta.',
			'errors.blocked' => 'Non puoi scrivere a questa persona.',
			'errors.peerUnavailable' => 'Questo account non è più disponibile.',
			'errors.vibeDailyLimit' => 'Oggi hai condiviso tante vibe. Riprova più tardi.',
			'errors.groupFull' => 'Questo gruppo è pieno.',
			'errors.groupCreateLimit' => 'Oggi hai creato troppi gruppi. Riprova più tardi.',
			'errors.notFound' => 'Non è più disponibile.',
			'errors.recentLogin' => 'Per sicurezza, esci e accedi di nuovo, poi riprova.',
			'errors.socialAccount' => 'Email e password sono gestite dal tuo account Google o Apple.',
			'errors.alreadyInCall' => 'Sei già in una chiamata.',
			'errors.roomPrivate' => 'Questa stanza è privata. Chiedi all\'host di entrare.',
			'errors.roomFull' => 'Questa stanza è piena.',
			'faq.q1' => 'Come funziona l\'app?',
			'faq.q2' => 'Cos\'è la chat anonima?',
			'faq.q3' => 'Cos\'è il Progresso connessione?',
			'faq.q4' => 'Come mostro il mio profilo?',
			'faq.q5' => 'Cos\'è Sconosciuto in 60 secondi?',
			'faq.q6' => 'Cosa sono le Vibes?',
			'faq.q7' => 'Come modifico il mio profilo?',
			'faq.q8' => 'Come gestisco le notifiche?',
			'faq.q9' => 'Come ripristino gli acquisti?',
			'faq.q10' => 'Posso eliminare tutte le conversazioni?',
			'faq.q11' => 'I miei dati sono al sicuro?',
			'faq.q12' => 'Come blocco o segnalo qualcuno?',
			'faq.q13' => 'Come condivido l\'app?',
			'faq.q14' => 'Come elimino il mio account?',
			'faq.a1' => 'Su Veylo puoi conoscere persone nuove in anonimo, chattare e rivelare gradualmente il tuo profilo man mano che la connessione cresce. Passate a messaggi, voce o faccia a faccia quando vi sentite pronti entrambi.',
			'faq.a2' => 'Nella chat anonima la tua identità e la tua foto restano nascoste. Con l\'aumentare della connessione sblocchi dettagli come l\'iniziale del nome e una foto sfocata. Al 100%, entrambi dovete accettare di mostrare i profili completi.',
			'faq.a3' => 'Mentre chattate, la percentuale di connessione cresce. A certe tappe sblocchi l\'iniziale del nome, una foto sfocata e il profilo completo. Tocca il badge Connessione per vedere i dettagli.',
			'faq.a4' => 'Quando la connessione arriva al 100%, tocca Mostra il mio profilo. Se accetta anche l\'altra persona, entrambi i profili completi diventano visibili.',
			'faq.a5' => 'Dalla scheda Chiama puoi ottenere un breve match casuale. Allo scadere del tempo puoi continuare a parlare o terminare la chiamata.',
			'faq.a6' => 'Vibes ti permette di scoprire persone vicine o intorno a te su una vista mappa/elenco e iniziare una chat con chi ti interessa.',
			'faq.a7' => 'Apri la scheda Profilo e vai su Modifica profilo per aggiornare nome, foto, bio e interessi. Le modifiche appaiono dopo il salvataggio.',
			'faq.a8' => 'Apri Notifiche nelle Impostazioni per attivare o disattivare gli avvisi di messaggi, match e altro.',
			'faq.a9' => 'Vai su Impostazioni → Gestione account → Ripristina acquisti. Gli acquisti idonei sullo stesso account dello store verranno ripristinati.',
			'faq.a10' => 'Sì. Usa Impostazioni → Elimina conversazioni e conferma. Tutte le chat verranno rimosse. L\'operazione non è reversibile.',
			'faq.a11' => 'I dati del tuo account e i messaggi sono conservati su sistemi protetti. Puoi anche richiedere l\'eliminazione dell\'account e dei dati da Gestione account in qualsiasi momento.',
			'faq.a12' => 'Usa il menu in un profilo o in una chat per bloccare o segnalare. Le segnalazioni vengono esaminate dal nostro team.',
			'faq.a13' => 'Usa Condividi l\'app nelle Impostazioni per copiare il link e inviarlo agli amici.',
			'faq.a14' => 'Vai su Impostazioni → Gestione account → Elimina account e dati. Dopo aver indicato un motivo, conferma per inviare la richiesta di eliminazione.',
			'legal.termsTitle' => 'Termini di servizio',
			'legal.privacyTitle' => 'Informativa sulla privacy',
			'legal.termsBody' => 'Ultimo aggiornamento: 16 marzo 2026\n\nBenvenuto su Veylo. Creando un account o usando l\'app, accetti i presenti Termini di servizio.\n\n1. Cos\'è Veylo\nVeylo è un\'app social in cui puoi conoscere persone, chattare in anonimo, costruire una connessione nel tempo e, se entrambi siete d\'accordo, passare facoltativamente a chiamate vocali o faccia a faccia.\n\n2. Il tuo account\nDevi fornire informazioni accurate e mantenere sicuro il tuo accesso. Sei responsabile delle attività svolte con il tuo account. Devi avere l\'età minima richiesta dalle leggi del tuo Paese per usare Veylo.\n\n3. Uso rispettoso\nNon molestare, minacciare, truffare, impersonare altri, condividere contenuti illegali né tentare di aggirare le funzioni di sicurezza. Possiamo rimuovere contenuti, limitare funzioni o sospendere gli account che violano queste regole.\n\n4. Chat anonima e rivelazione del profilo\nLe chat anonime possono nascondere il tuo nome e la tua foto fino al raggiungimento di determinate tappe di connessione. La rivelazione del profilo completo richiede il consenso reciproco. Non fare pressione sugli altri perché rivelino la propria identità.\n\n5. Acquisti\nAlcune funzioni possono essere a pagamento. Gli acquisti sono gestiti dall\'App Store di Apple o da Google Play. Ripristina acquisti recupera gli acquisti idonei sullo stesso account dello store. I rimborsi seguono le condizioni dello store.\n\n6. Contenuti che condividi\nMantieni i diritti sui tuoi contenuti, ma concedi a Veylo una licenza per ospitarli e mostrarli nell\'app nella misura necessaria a fornire il servizio. Non pubblicare contenuti che non hai il diritto di condividere.\n\n7. Fine dell\'utilizzo\nPuoi smettere di usare Veylo in qualsiasi momento e richiedere l\'eliminazione dell\'account dalle Impostazioni. Possiamo anche interrompere o modificare il servizio con un ragionevole preavviso, ove previsto.\n\n8. Contatti\nDomande su questi termini: support@veylo.app',
			'legal.privacyBody' => 'Ultimo aggiornamento: 16 marzo 2026\n\nLa presente Informativa sulla privacy spiega come Veylo raccoglie, usa e protegge le tue informazioni.\n\n1. Informazioni che raccogliamo\n• Dati dell\'account: email, nome visualizzato, foto profilo, bio, preferenze\n• Dati di utilizzo: chat, progresso della connessione, funzioni di chiamata che usi, dati di base del dispositivo/app\n• Acquisti: dati delle ricevute dello store necessari per sbloccare e ripristinare le funzioni a pagamento\n\n2. Come li usiamo\nUsiamo i tuoi dati per far funzionare Veylo, personalizzare i match e l\'esperienza di chat, mantenere la community sicura, elaborare gli acquisti e migliorare il prodotto. Non vendiamo i tuoi dati personali.\n\n3. Modalità anonima\nNelle chat anonime limitiamo ciò che gli altri vedono (ad esempio nome mascherato o foto sfocata) finché le regole di sblocco e il consenso reciproco non consentono di mostrare di più. Dietro le quinte abbiamo comunque bisogno degli identificativi dell\'account per far funzionare la funzione in modo sicuro.\n\n4. Condivisione\nPossiamo condividere dati con fornitori di servizi che ci aiutano con hosting, analisi o elaborazione dei pagamenti, solo nella misura necessaria. Possiamo inoltre divulgare informazioni se richiesto dalla legge o per proteggere gli utenti da danni.\n\n5. Conservazione\nConserviamo i dati finché il tuo account è attivo e per quanto necessario per motivi legali, di sicurezza e di fatturazione. Una volta completata una richiesta di eliminazione, rimuoviamo o anonimizziamo i dati personali, salvo i casi in cui la conservazione sia obbligatoria.\n\n6. Le tue scelte\nPuoi modificare le informazioni del profilo, gestire le notifiche, richiedere l\'eliminazione dell\'account e contattarci riguardo ai tuoi dati. Gli acquisti nello store sono gestiti anche tramite Apple o Google.\n\n7. Sicurezza\nAdottiamo misure tecniche e organizzative ragionevoli per proteggere le tue informazioni. Nessun sistema è perfettamente sicuro: usa una password robusta e tieni aggiornato il tuo dispositivo.\n\n8. Contatti\nDomande sulla privacy: privacy@veylo.app',
			'logout.title' => 'Esci',
			'logout.subtitle' => 'Vuoi davvero uscire?',
			'logout.cancel' => 'Annulla',
			'logout.confirm' => 'Esci',
			'deleteAccount.title' => 'Invia una richiesta di eliminazione account',
			'deleteAccount.subtitle' => 'Vuoi davvero eliminare il tuo account?',
			'deleteAccount.reasonTitle' => 'Non vogliamo che tu te ne vada, ma capiamo.',
			'deleteAccount.reasonBefore' => 'Ci dici perché vuoi andartene, così possiamo migliorare l\'esperienza su ',
			'deleteAccount.reasonAfter' => '?',
			'deleteAccount.reasonLabel' => 'Perché vuoi eliminare il tuo account',
			'deleteAccount.reasonHint' => 'Scrivi il tuo messaggio',
			'deleteAccount.cancel' => 'Annulla',
			'deleteAccount.createRequest' => 'Crea richiesta',
			'deleteAccount.confirmTitle' => 'Vuoi davvero inviare la richiesta di eliminazione?',
			'deleteAccount.confirmSubtitle' => 'Se confermi, la richiesta di eliminazione del tuo account verrà inviata',
			'deleteAccount.delete' => 'Elimina',
			'storyText.bold' => 'Grassetto',
			'storyText.italic' => 'Corsivo',
			'storyText.uppercase' => 'Maiuscolo',
			'storyText.underline' => 'Sottolineato',
			'storyText.cancel' => 'Annulla',
			'storyText.galleryError' => 'Impossibile aprire la galleria',
			_ => null,
		};
	}
}
