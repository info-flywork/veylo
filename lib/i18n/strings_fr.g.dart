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
class TranslationsFr extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsFr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.fr,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <fr>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key) ?? super[key];

	late final TranslationsFr _root = this; // ignore: unused_field

	@override 
	TranslationsFr $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsFr(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$app$fr app = _Translations$app$fr._(_root);
	@override late final _Translations$home$fr home = _Translations$home$fr._(_root);
	@override late final _Translations$chats$fr chats = _Translations$chats$fr._(_root);
	@override late final _Translations$profile$fr profile = _Translations$profile$fr._(_root);
	@override late final _Translations$nav$fr nav = _Translations$nav$fr._(_root);
	@override late final _Translations$call$fr call = _Translations$call$fr._(_root);
	@override late final _Translations$vibes$fr vibes = _Translations$vibes$fr._(_root);
	@override late final _Translations$discover$fr discover = _Translations$discover$fr._(_root);
	@override late final _Translations$common$fr common = _Translations$common$fr._(_root);
	@override late final _Translations$languages$fr languages = _Translations$languages$fr._(_root);
	@override late final _Translations$auth$fr auth = _Translations$auth$fr._(_root);
	@override late final _Translations$onboarding$fr onboarding = _Translations$onboarding$fr._(_root);
	@override late final _Translations$createProfile$fr createProfile = _Translations$createProfile$fr._(_root);
	@override late final _Translations$errors$fr errors = _Translations$errors$fr._(_root);
	@override late final _Translations$faq$fr faq = _Translations$faq$fr._(_root);
	@override late final _Translations$legal$fr legal = _Translations$legal$fr._(_root);
	@override late final _Translations$logout$fr logout = _Translations$logout$fr._(_root);
	@override late final _Translations$deleteAccount$fr deleteAccount = _Translations$deleteAccount$fr._(_root);
	@override late final _Translations$storyText$fr storyText = _Translations$storyText$fr._(_root);
}

// Path: app
class _Translations$app$fr extends Translations$app$tr {
	_Translations$app$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get name => 'Veylo';
	@override String get tagline => 'Bienvenue';
}

// Path: home
class _Translations$home$fr extends Translations$home$tr {
	_Translations$home$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Accueil';
	@override String get subtitle => 'L\'app est en préparation';
	@override String get body => 'L\'interface multilingue est gérée avec slang.';
}

// Path: chats
class _Translations$chats$fr extends Translations$chats$tr {
	_Translations$chats$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Discussions';
	@override String get search => 'Rechercher';
	@override String get messagesSection => 'Messages';
	@override String get request => 'Demandes';
	@override String get emptyRequestTitle => 'Aucune notification\nde message récente';
	@override String get emptyRequestSubtitle => 'Les demandes de plus de 30 jours ne sont pas affichées.';
	@override String get noteAdd => 'Ajouter une note';
	@override String get anonymous => 'Anonyme';
	@override String get online => 'en ligne';
	@override String get offline => 'hors ligne';
	@override String get connection => 'Lien';
	@override String connectionPercent({required Object n}) => '${n}%';
	@override String get connectionProgressTitle => 'Progression du lien';
	@override String get milestoneInitial => 'Initiale du prénom';
	@override String get milestoneInitialHint => 'Débloquée à 25 %';
	@override String get milestoneInitialLocked => 'Se débloque à 25 %';
	@override String get milestonePhoto => 'Aperçu de photo floutée';
	@override String get milestonePhotoHint => 'Se débloque à 70 %';
	@override String get milestoneFull => 'Profil complet';
	@override String get milestoneFullHint => 'Accord mutuel à 100 %';
	@override String get sampleAnonymousMessage => 'Salut, ravi(e) de te rencontrer. Tu peux me parler un peu de toi ?';
	@override String get strangerSampleMessage => 'Salut Jhon, ravi(e) de te rencontrer. Tu peux me parler un peu de toi ?';
	@override String get approve => 'Accepter';
	@override String get blockUser => 'Bloquer';
	@override String get reject => 'Refuser';
	@override String get messageHint => 'Salut ! Ça va ?';
	@override String get revealTitle => 'Vous avez atteint 100 %';
	@override String get revealSubtitle => 'Révéler vos profils complets l\'un à l\'autre ? Vous devez être d\'accord tous les deux.';
	@override String revealWaiting({required Object name}) => 'En attente de l\'accord de ${name}';
	@override String get revealCta => 'Révéler mon profil';
	@override String get revealNotYet => 'Pas encore';
	@override String get seen => 'Vu';
	@override String get typing => 'écrit…';
	@override String get noteYou => 'Toi';
	@override String get noteSheetTitle => 'Partager une note';
	@override String get noteSheetSubtitle => 'Ta note reste visible 24 heures';
	@override String get noteHint => 'Tu penses à quoi ?';
	@override String get noteShare => 'Partager';
	@override String get noteDelete => 'Supprimer la note';
}

// Path: profile
class _Translations$profile$fr extends Translations$profile$tr {
	_Translations$profile$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get eyebrow => 'Profil';
	@override String get title => 'Réglages';
	@override String get editProfile => 'Modifier le profil';
	@override String get statLike => 'J\'aime';
	@override String get statFollow => 'Abonnements';
	@override String get statFollower => 'Abonnés';
	@override String get promoTitle => 'Reçois plus de messages !';
	@override String get promoSubtitle => 'Démarque-toi, apparais en haut de la liste';
	@override String get standOut => 'Se démarquer';
	@override String get tabPosts => 'Posts';
	@override String get tabVideo => 'Vidéo';
	@override String get tabSaved => 'Enregistrés';
	@override String get save => 'Enregistrer';
	@override String get changePhoto => 'Changer la photo';
	@override String get changeBorder => 'Changer le cadre';
	@override String get interest => 'Centres d\'intérêt';
	@override String get name => 'Nom';
	@override String get changeName => 'Changer le nom';
	@override String get changePassword => 'Changer le mot de passe';
	@override String get confirmPassword => 'Confirmer le mot de passe';
	@override String get email => 'E-mail';
	@override String get accountManagement => 'Gestion du compte';
	@override String get settingsAbout => 'À propos';
	@override String get settingsAccount => 'Paramètres du compte';
	@override String get settingsSupport => 'Assistance';
	@override String get shareApp => 'Partager l\'app';
	@override String get shareAppTitle => 'Partage avec tes amis';
	@override String get shareAppSubtitle => 'Partage Veylo avec tes amis et découvrez ensemble !';
	@override String get shareAppLabel => 'Lien de l\'app';
	@override String get rateApp => 'Tu nous aimes ? Note-nous';
	@override String get notifications => 'Notifications';
	@override String get password => 'Mot de passe';
	@override String get deleteConversation => 'Supprimer les conversations';
	@override String get faqHelp => 'FAQ & Aide';
	@override String get restorePurchases => 'Restaurer les achats';
	@override String get termsOfService => 'Conditions d\'utilisation';
	@override String get privacyPolicy => 'Politique de confidentialité';
	@override String get restorePurchasesDone => 'Achats vérifiés';
	@override String get conversationsDeleted => 'Toutes les conversations ont été supprimées';
	@override String get logOut => 'Se déconnecter';
	@override String get deleteAccountAndData => 'Supprimer le compte et les données';
	@override String get passwordPlaceholder => '********';
	@override String get height => 'Taille';
	@override String get addHeight => 'Ajouter ta taille';
	@override String heightCm({required Object value}) => '${value} cm';
	@override String get languages => 'Langues';
	@override String get relationshipGoals => 'Objectifs de relation';
	@override String get lookingFor => 'Je cherche';
	@override String get newFriends => '👋 Nouveaux amis';
	@override String get goalLongTermOpenToShort => '💕 Du sérieux, ouvert(e) au court terme';
	@override String get goalLongTermRelationship => '💘 Relation sérieuse';
	@override String get goalNewFriends => '👋 Nouveaux amis';
	@override String get goalShortTermFun => '🥃 Fun sans engagement';
	@override String get goalStillFiguringItOut => '🤔 Je ne sais pas encore';
	@override String get basics => 'L\'essentiel';
	@override String get zodiac => 'Signe astro';
	@override String get zodiacValue => 'Scorpion';
	@override String get education => 'Études';
	@override String get educationValue => 'Licence';
	@override String get educationHighSchool => 'Lycée';
	@override String get educationAssociates => 'Bac +2';
	@override String get educationBachelors => 'Licence';
	@override String get educationMasters => 'Master';
	@override String get educationPhd => 'Doctorat';
	@override String get voiceRecord => 'Message vocal';
	@override String get addVoice => 'Ajouter un vocal';
	@override String get lifestyle => 'Mode de vie';
	@override String get pets => 'Animaux';
	@override String get petsValue => 'J\'ai un chat';
	@override String get petsDontWant => 'Je ne veux pas d\'animaux';
	@override String get petsAllergic => 'Je suis allergique aux animaux';
	@override String get petsHaveCat => 'J\'ai un chat';
	@override String get petsHaveDog => 'J\'ai un chien';
	@override String get petsHaveCatsAndDogs => 'J\'ai des chats et des chiens';
	@override String get petsHaveOther => 'J\'ai d\'autres animaux';
	@override String get drinking => 'Alcool';
	@override String get drinkingValue => 'Pour les grandes occasions';
	@override String get drinkingNever => 'Jamais';
	@override String get drinkingSpecialOccasions => 'Pour les grandes occasions';
	@override String get drinkingSocially => 'En soirée';
	@override String get drinkingFrequently => 'Souvent';
	@override String get drinkingSober => 'Sobre';
	@override String get drinkingPreferNotToSay => 'Je préfère ne pas le dire';
	@override String get smoking => 'Tabac';
	@override String get smokingValue => 'Non-fumeur';
	@override String get smokingNonSmoker => 'Non-fumeur';
	@override String get smokingSocialSmoker => 'Fumeur occasionnel';
	@override String get smokingSmoker => 'Fumeur';
	@override String get smokingTryingToQuit => 'J\'essaie d\'arrêter';
	@override String get smokingWhenDrinking => 'Fumeur quand je bois';
	@override String get smokingPreferNotToSay => 'Je préfère ne pas le dire';
	@override String get gender => 'Genre';
	@override String get genderFemale => 'Femme';
	@override String get genderMale => 'Homme';
	@override String get genderPreferNotToSay => 'Je préfère ne pas le dire';
	@override String get visible => 'Visible';
	@override String get profileVisibility => 'Visibilité du profil';
	@override String get language => 'Langue';
	@override String get borderTitle => 'Cadre de profil';
	@override String get borderSubtitle => 'Ajoute un cadre à ton profil pour\nte démarquer.';
	@override String get borderBuySection => 'Acheter un cadre';
	@override String get borderBuyCta => 'Acheter le cadre';
	@override String borderToken({required Object count}) => '${count} jetons';
	@override String get borderAmethystWings => 'Amethyst Wings';
	@override String get borderGoldenPhoenix => 'Golden Phoenix';
	@override String get borderFrostCrown => 'Frost Crown';
	@override String get borderEmeraldWhisper => 'Emerald Whisper';
	@override String get borderRoseQuartz => 'Rose Quartz';
	@override String get borderStarlitComet => 'Starlit Comet';
	@override String get borderCrimsonRoyal => 'Crimson Royal';
	@override String get borderSapphireHalo => 'Sapphire Halo';
	@override String get follow => 'Suivre';
	@override String get following => 'Abonné(e)';
	@override String get followPageTitle => 'Abonnements';
	@override String get followTabFollowing => 'Abonnements';
	@override String get followTabFollowers => 'Abonnés';
	@override String get followSearch => 'Rechercher';
	@override String get unfollow => 'Ne plus suivre';
	@override String get followSortTitle => 'Trier';
	@override String get followSortRecent => 'Mes abonnements les plus récents';
	@override String get followSortNotFollowingMe => 'Ceux qui ne me suivent pas en retour';
	@override String get followSortNotFollowedByMe => 'Ceux que je ne suis pas en retour';
	@override String get followSortShowResult => 'Voir les résultats';
	@override String get followSortEmpty => 'Aucun utilisateur ne correspond à ce filtre';
	@override String get shareTitle => 'Partage avec tes amis';
	@override String get shareSubtitle => 'Tout est plus fun quand tu te connectes\navec tes amis !';
	@override String get shareProfileLabel => 'Partager le profil';
	@override String get shareLinkCopied => 'Lien copié';
	@override String get restrict => 'Restreindre';
	@override String get block => 'Bloquer';
	@override String get report => 'Signaler';
	@override String blockTitle({required Object username}) => 'Bloquer ${username} ?';
	@override String get blockBody => 'Cela bloquera aussi tout autre compte que cette personne a ou pourrait créer. Tu peux la débloquer à tout moment.';
	@override String get blockAndReport => 'Bloquer et signaler';
	@override String restrictTitle({required Object username}) => 'Restreindre ${username} ?';
	@override String get restrictBody => 'Cette personne ne pourra pas voir quand tu es en ligne ni si tu as lu ses messages. Tu peux changer ça à tout moment.';
	@override String get restrictAndReport => 'Restreindre et signaler';
	@override String get reportTitle => 'Dis-nous pourquoi';
	@override String get reportSubtitle => 'Pour nous aider à améliorer ton expérience, peux-tu nous dire pourquoi tu veux signaler cet utilisateur ?';
	@override String get reportMessageLabel => 'Message du signalement';
	@override String get reportMessageHint => 'Écris ton message';
	@override String get reportCancel => 'Annuler';
	@override String get sendReport => 'Envoyer';
	@override String get notSet => 'Non renseigné';
	@override String get reportSent => 'Merci, nous avons bien reçu ton signalement.';
	@override String emailVerificationSent({required Object email}) => 'Nous avons envoyé un lien de confirmation à ${email}. Ton e-mail sera modifié après confirmation.';
	@override String get passwordChanged => 'Ton mot de passe a été mis à jour.';
	@override String get passwordMismatch => 'Les mots de passe ne correspondent pas.';
}

// Path: nav
class _Translations$nav$fr extends Translations$nav$tr {
	_Translations$nav$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get discover => 'Découvrir';
	@override String get chat => 'Chat';
	@override String get call => 'Appel';
	@override String get vibes => 'Vibes';
	@override String get profile => 'Profil';
}

// Path: call
class _Translations$call$fr extends Translations$call$tr {
	_Translations$call$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => '60 secondes avec un inconnu';
	@override String get subtitle => 'Parle 60 secondes avec un inconnu au hasard, en tout anonymat. Pas de profil, pas de photo, pas de nom. Juste une voix et un moment.';
	@override String get findingTitle => 'Recherche d\'un inconnu...';
	@override String get findingSubtitle => 'Vous parlerez anonymement pendant 60 secondes. Pas de profil, pas de noms.';
	@override String get callStranger => 'Appeler un inconnu - 10 jetons';
	@override String get cancel => 'Annuler';
	@override String get female => 'Femme';
	@override String get male => 'Homme';
	@override String get nonBinary => 'Non-binaire';
	@override String get preferNotToSay => 'Je préfère ne pas le dire';
	@override String get anonymousBadge => '🎙️ Appel vocal anonyme';
	@override String get stranger => 'Inconnu';
	@override String secondsLeft({required Object n}) => '${n}s';
	@override String get timesUpTitle => 'Temps écoulé !';
	@override String get timesUpSubtitle => 'Envie de continuer ? Si vous dites oui tous les deux, le chat se débloque.';
	@override String get keepTalking => 'Continuer';
	@override String get endCall => 'Raccrocher';
	@override String get waitingOther => 'En attente de l\'autre personne...';
	@override String get callStrangerFree => 'Appeler un inconnu';
	@override String get peerLeft => 'L\'autre personne a raccroché.';
	@override String get noKeep => 'Le chat ne s\'est pas débloqué cette fois.';
	@override String get videoWaiting => 'En attente de l\'acceptation de l\'appel vidéo...';
	@override String get videoDeclined => 'L\'appel vidéo a été refusé.';
	@override String get micDenied => 'L\'accès au micro est nécessaire pour les appels. Tu peux l\'activer dans les Réglages.';
	@override String get videoCost => 'Appel vidéo : 20 jetons / 15 min';
	@override String get calling => 'Appel en cours';
	@override String get accept => 'Accepter';
	@override String get decline => 'Refuser';
	@override String get switchToVideo => 'Passer en appel vidéo ?';
	@override String get noMatchTitle => 'Personne n\'est disponible pour l\'instant';
	@override String get noMatchBody => 'Nous n\'avons trouvé personne avec qui parler pour le moment. Réessaie un peu plus tard.';
	@override String get noMatchOk => 'OK';
}

// Path: vibes
class _Translations$vibes$fr extends Translations$vibes$tr {
	_Translations$vibes$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get search => 'Rechercher';
	@override String get sendMessage => 'Envoyer un message';
	@override String get wantsToTalk => 'Veut en parler maintenant';
	@override String get shareTitle => 'Partager une vibe';
	@override String get replyTitle => 'Répondre à la vibe';
	@override String get shareHint => 'Écris quelque chose';
	@override String get shareAnonymous => 'Partager anonymement';
	@override String get empty => 'Aucune vibe ces dernières 24 heures. Partage la première !';
	@override String get deleteTitle => 'Supprimer cette vibe ?';
	@override String get delete => 'Supprimer';
	@override String get cancel => 'Annuler';
}

// Path: discover
class _Translations$discover$fr extends Translations$discover$tr {
	_Translations$discover$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Découvrir';
	@override String get tabRooms => 'Salons';
	@override String get tabDiscover => 'Découvrir';
	@override String get tabAiMatch => 'AI Match';
	@override late final _Translations$discover$aiMatch$fr aiMatch = _Translations$discover$aiMatch$fr._(_root);
	@override String get searchHint => 'Rechercher';
	@override String get allRooms => 'Tous les salons';
	@override String get allGroups => 'Tous les groupes';
	@override String get seeAll => 'Tout voir';
	@override String get live => 'Live';
	@override String get join => 'Rejoindre';
	@override String get request => 'Demander';
	@override String get requested => 'Demandé';
	@override String get private => 'Privé';
	@override String moreCount({required Object count}) => '+${count} de plus';
	@override String activeCount({required Object count}) => '${count} actifs';
	@override String membersCount({required Object count}) => '${count} membres';
	@override late final _Translations$discover$privateRoom$fr privateRoom = _Translations$discover$privateRoom$fr._(_root);
	@override late final _Translations$discover$roomToken$fr roomToken = _Translations$discover$roomToken$fr._(_root);
	@override late final _Translations$discover$privateRequest$fr privateRequest = _Translations$discover$privateRequest$fr._(_root);
	@override late final _Translations$discover$roomApproved$fr roomApproved = _Translations$discover$roomApproved$fr._(_root);
	@override late final _Translations$discover$createSpace$fr createSpace = _Translations$discover$createSpace$fr._(_root);
	@override late final _Translations$discover$liveRoom$fr liveRoom = _Translations$discover$liveRoom$fr._(_root);
	@override late final _Translations$discover$groupChat$fr groupChat = _Translations$discover$groupChat$fr._(_root);
	@override late final _Translations$discover$groupInfo$fr groupInfo = _Translations$discover$groupInfo$fr._(_root);
	@override late final _Translations$discover$filters$fr filters = _Translations$discover$filters$fr._(_root);
	@override late final _Translations$discover$post$fr post = _Translations$discover$post$fr._(_root);
	@override late final _Translations$discover$story$fr story = _Translations$discover$story$fr._(_root);
	@override late final _Translations$discover$highlight$fr highlight = _Translations$discover$highlight$fr._(_root);
	@override late final _Translations$discover$stats$fr stats = _Translations$discover$stats$fr._(_root);
	@override String hostedBy({required Object name}) => 'Animé par ${name}';
}

// Path: common
class _Translations$common$fr extends Translations$common$tr {
	_Translations$common$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get loading => 'Chargement…';
	@override String get retry => 'Réessayer';
	@override String get cancel => 'Annuler';
	@override String get save => 'Enregistrer';
	@override String get continueAction => 'Continuer';
	@override String get language => 'Langue';
	@override String get or => 'OU';
}

// Path: languages
class _Translations$languages$fr extends Translations$languages$tr {
	_Translations$languages$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get tr => 'Türkçe';
	@override String get en => 'English';
}

// Path: auth
class _Translations$auth$fr extends Translations$auth$tr {
	_Translations$auth$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get createAccountTitle => 'Crée ton compte';
	@override String get createAccountSubtitle => 'Rejoins Veylo et commence à faire des rencontres.';
	@override String get welcomeBackTitle => 'Bon retour';
	@override String get welcomeBackSubtitle => 'Connecte-toi pour continuer sur Veylo.';
	@override String get username => 'Nom d\'utilisateur';
	@override String get usernameHint => 'Choisis un nom d\'utilisateur';
	@override String get email => 'E-mail';
	@override String get emailHint => 'Saisis ton e-mail';
	@override String get emailOrUsername => 'E-mail ou nom d\'utilisateur';
	@override String get emailOrUsernameHint => 'Saisis ton e-mail ou nom d\'utilisateur';
	@override String get password => 'Mot de passe';
	@override String get passwordCreateHint => 'Crée un mot de passe';
	@override String get passwordEnterHint => 'Saisis ton mot de passe';
	@override String get signUp => 'S\'inscrire';
	@override String get logIn => 'Se connecter';
	@override String get forgotPassword => 'Mot de passe oublié ?';
	@override String get continueWithApple => 'Continuer avec Apple';
	@override String get continueWithGoogle => 'Continuer avec Google';
	@override String get legalPrefix => 'En continuant, tu acceptes nos ';
	@override String get termsOfService => 'Conditions d\'utilisation';
	@override String get legalMiddle => ' et reconnais avoir lu notre ';
	@override String get privacyPolicy => 'Politique de confidentialité';
	@override String get legalSuffix => '.';
	@override String get passwordResetSent => 'Nous t\'avons envoyé un lien de réinitialisation par e-mail.';
}

// Path: onboarding
class _Translations$onboarding$fr extends Translations$onboarding$tr {
	_Translations$onboarding$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get skip => 'Passer';
	@override String get page1Title => 'Sois toi-même. Reste anonyme.';
	@override String get page1Subtitle => 'Rencontre de nouvelles personnes et discute\nsans révéler qui tu es.';
	@override String get page2Title => 'Écris. Parle. Ressens la vibe.';
	@override String get page2Subtitle => 'Commence anonymement, puis écris, appelle ou passe en face à face quand tu es prêt(e).';
	@override String get page3Title => 'Trouve ta tribu. Rejoins\nla conversation.';
	@override String get page3Subtitle => 'Entre dans des salons, fais des rencontres et\npartagez le moment ensemble.';
	@override String get getStarted => 'C\'est parti';
	@override String get alreadyHaveAccount => 'Déjà un compte Veylo ? ';
	@override String get logInAction => 'Se connecter';
}

// Path: createProfile
class _Translations$createProfile$fr extends Translations$createProfile$tr {
	_Translations$createProfile$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get navTitle => 'Créer le profil';
	@override String get stepUsername => '1/5 Nom d\'utilisateur';
	@override String get title => 'Crée ton profil';
	@override String get subtitle => 'Ton vrai nom sert uniquement à la vérification, il ne sera pas affiché publiquement.';
	@override String get subtitleLine1 => 'Ton vrai nom sert uniquement à la vérification,';
	@override String get subtitleLine2 => 'il ne sera pas affiché publiquement.';
	@override String get fullName => 'Nom complet';
	@override String get fullNameHint => 'Sam Lee';
	@override String get username => 'Nom d\'utilisateur';
	@override String get usernameHint => 'samlee123';
	@override String get usernameTaken => 'Ce nom d\'utilisateur existe déjà !';
	@override String get usernameAvailable => 'Nom d\'utilisateur disponible';
	@override String get mightWantToTry => 'Tu peux essayer...';
	@override String get stepPhoto => '2/5 Photo de profil';
	@override String get photoTitle => 'Ajoute une photo de profil';
	@override String get photoSubtitle => 'Les autres peuvent voir ta photo de profil pour s\'assurer que c\'est bien toi.';
	@override String get photoSubtitleLine1 => 'Les autres peuvent voir ta photo de profil pour';
	@override String get photoSubtitleLine2 => 's\'assurer que c\'est bien toi.';
	@override String get choosePhoto => 'Choisir une photo';
	@override String get continueWithoutPhoto => 'Continuer sans photo de profil';
	@override String get saveAndContinue => 'Enregistrer et continuer';
	@override String get choosePhotoSheetTitle => 'Choisir une photo';
	@override String get takePhoto => 'Prendre une photo';
	@override String get chooseFromGallery => 'Choisir dans la galerie';
	@override String get stepGender => '3/5 Genre';
	@override String get genderTitle => 'Choisis ton genre';
	@override String get genderSubtitle => 'Si tu choisis de nous donner cette info, nous pourrons l\'utiliser pour personnaliser ton contenu';
	@override String get genderSubtitleLine1 => 'Si tu choisis de nous donner cette info, nous';
	@override String get genderSubtitleLine2 => 'pourrons l\'utiliser pour personnaliser ton contenu';
	@override String get genderFemale => 'Femme';
	@override String get genderMale => 'Homme';
	@override String get genderNonBinary => 'Non-binaire';
	@override String get genderPreferNotToSay => 'Je préfère ne pas le dire';
	@override String get stepInterests => '4/5 Centres d\'intérêt';
	@override String get interestsTitle => 'Qu\'est-ce qui te plaît ?';
	@override String get interestsSubtitle => 'Choisis-en au moins 5, ça nous aide à te présenter des gens qui te comprennent vraiment.';
	@override late final _Translations$createProfile$interests$fr interests = _Translations$createProfile$interests$fr._(_root);
	@override String get stepChatGoal => '5/5 Objectif';
	@override String get chatGoalTitle => 'Tu cherches quoi aujourd\'hui ?';
	@override String get chatGoalSubtitle => 'Ça nous aide à trouver le bon match selon ton humeur du moment.';
	@override String get chatGoalQuickMatch => 'Match rapide : plonge direct dans une\nconversation';
	@override String get chatGoalFlirtyChat => 'Flirt : des échanges légers\net joueurs';
	@override String get chatGoalMoodMatch => 'Match d\'humeur : selon ce que tu\nressens';
	@override String get chatGoalLateNight => 'Discussions nocturnes : parler à cœur ouvert\nquand le monde dort';
	@override String get chatGoalMeetSomeoneNew => 'Nouvelle rencontre : pas d\'objectif précis,\njuste explorer';
	@override String get getStarted => 'C\'est parti';
	@override String get preparingTitleLine1 => 'Nous préparons';
	@override String get preparingTitleLine2 => 'des profils faits pour';
	@override String get preparingTitleLine3 => 'toi.';
	@override String get preparingSubtitleLine1 => 'D\'après tes réponses, nous sélectionnons';
	@override String get preparingSubtitleLine2 => 'les meilleurs matchs, patiente un instant.';
	@override String preparingPercent({required Object percent}) => '${percent}%';
	@override String get usernameInvalid => 'Utilise 3 à 30 lettres, chiffres, points ou tirets bas.';
}

// Path: errors
class _Translations$errors$fr extends Translations$errors$tr {
	_Translations$errors$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get network => 'Impossible de joindre Veylo. Vérifie ta connexion et réessaie.';
	@override String get generic => 'Un problème est survenu. Réessaie.';
	@override String get signInFailed => 'Échec de la connexion. Réessaie.';
	@override String get sessionExpired => 'Ta session a expiré. Reconnecte-toi.';
	@override String get accountSuspended => 'Ce compte a été suspendu.';
	@override String get unsupportedImage => 'Choisis une photo JPEG, PNG ou WebP.';
	@override String get fileTooLarge => 'Ce fichier est trop volumineux.';
	@override String get enterEmailForReset => 'Saisis ton e-mail ci-dessus pour réinitialiser ton mot de passe.';
	@override String get wrongCredentials => 'E-mail/nom d\'utilisateur ou mot de passe incorrect.';
	@override String get emailInUse => 'Cet e-mail est déjà enregistré. Essaie de te connecter.';
	@override String get weakPassword => 'Le mot de passe doit contenir au moins 6 caractères.';
	@override String get invalidEmail => 'Saisis une adresse e-mail valide.';
	@override String get tooManyAttempts => 'Trop de tentatives. Patiente un peu et réessaie.';
	@override String get fillAllFields => 'Remplis tous les champs.';
	@override String get insufficientTokens => 'Pas assez de jetons.';
	@override String get requestNotAccepted => 'Accepte la demande pour répondre.';
	@override String get requestPendingLimit => 'Tu pourras envoyer plus de messages une fois ta demande acceptée.';
	@override String get blocked => 'Tu ne peux pas écrire à cette personne.';
	@override String get peerUnavailable => 'Ce compte n\'est plus disponible.';
	@override String get vibeDailyLimit => 'Tu as partagé beaucoup de vibes aujourd\'hui. Réessaie plus tard.';
	@override String get groupFull => 'Ce groupe est complet.';
	@override String get groupCreateLimit => 'Tu as créé trop de groupes aujourd\'hui. Réessaie plus tard.';
	@override String get notFound => 'Ce contenu n\'est plus disponible.';
	@override String get recentLogin => 'Par sécurité, déconnecte-toi puis reconnecte-toi, et réessaie.';
	@override String get socialAccount => 'Ton e-mail et ton mot de passe sont gérés par ton compte Google ou Apple.';
	@override String get alreadyInCall => 'Tu es déjà en appel.';
	@override String get roomPrivate => 'Ce salon est privé. Demande à l\'hôte pour le rejoindre.';
	@override String get roomFull => 'Ce salon est complet.';
}

// Path: faq
class _Translations$faq$fr extends Translations$faq$tr {
	_Translations$faq$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get q1 => 'Comment fonctionne l\'app ?';
	@override String get q2 => 'C\'est quoi le chat anonyme ?';
	@override String get q3 => 'C\'est quoi la Progression du lien ?';
	@override String get q4 => 'Comment révéler mon profil ?';
	@override String get q5 => 'C\'est quoi 60 secondes avec un inconnu ?';
	@override String get q6 => 'C\'est quoi les Vibes ?';
	@override String get q7 => 'Comment modifier mon profil ?';
	@override String get q8 => 'Comment gérer les notifications ?';
	@override String get q9 => 'Comment restaurer mes achats ?';
	@override String get q10 => 'Puis-je supprimer toutes les conversations ?';
	@override String get q11 => 'Mes données sont-elles sécurisées ?';
	@override String get q12 => 'Comment bloquer ou signaler quelqu\'un ?';
	@override String get q13 => 'Comment partager l\'app ?';
	@override String get q14 => 'Comment supprimer mon compte ?';
	@override String get a1 => 'Sur Veylo, tu peux rencontrer de nouvelles personnes anonymement, discuter et révéler ton profil petit à petit à mesure que votre lien grandit. Passez à l\'écrit, à la voix ou au face à face quand vous êtes prêts tous les deux.';
	@override String get a2 => 'Dans le chat anonyme, ton identité et ta photo restent cachées. Plus le lien grandit, plus tu débloques de détails, comme l\'initiale du prénom et une photo floutée. À 100 %, vous devez être d\'accord tous les deux pour révéler vos profils complets.';
	@override String get a3 => 'Au fil de vos échanges, le pourcentage de lien augmente. À certaines étapes, tu débloques l\'initiale du prénom, une photo floutée, puis le profil complet. Touche le badge Lien pour voir les détails.';
	@override String get a4 => 'Quand le lien atteint 100 %, touche Révéler mon profil. Si l\'autre personne accepte aussi, vos deux profils complets deviennent visibles.';
	@override String get a5 => 'Depuis l\'onglet Appel, tu peux obtenir un court match au hasard. À la fin du temps, tu peux continuer à parler ou raccrocher.';
	@override String get a6 => 'Les Vibes te permettent de découvrir des personnes près de toi sur une carte ou une liste, et de lancer un chat avec quelqu\'un qui t\'intéresse.';
	@override String get a7 => 'Ouvre l\'onglet Profil, puis Modifier le profil pour mettre à jour ton nom, tes photos, ta bio et tes centres d\'intérêt. Les changements apparaissent après l\'enregistrement.';
	@override String get a8 => 'Ouvre Notifications dans les Réglages pour activer ou désactiver les alertes de messages, de matchs et autres.';
	@override String get a9 => 'Va dans Réglages → Gestion du compte → Restaurer les achats. Les achats éligibles effectués avec le même compte store seront restaurés.';
	@override String get a10 => 'Oui. Utilise Réglages → Supprimer les conversations et confirme. Tous les chats seront supprimés. Cette action est irréversible.';
	@override String get a11 => 'Les infos de ton compte et tes messages sont stockés sur des systèmes protégés. Tu peux aussi demander la suppression de ton compte et de tes données à tout moment depuis Gestion du compte.';
	@override String get a12 => 'Utilise le menu sur un profil ou un écran de chat pour bloquer ou signaler. Les signalements sont examinés par notre équipe.';
	@override String get a13 => 'Utilise Partager l\'app dans les Réglages pour copier le lien et l\'envoyer à tes amis.';
	@override String get a14 => 'Va dans Réglages → Gestion du compte → Supprimer le compte et les données. Après avoir indiqué une raison, confirme pour envoyer ta demande de suppression.';
}

// Path: legal
class _Translations$legal$fr extends Translations$legal$tr {
	_Translations$legal$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get termsTitle => 'Conditions d\'utilisation';
	@override String get privacyTitle => 'Politique de confidentialité';
	@override String get termsBody => 'Dernière mise à jour : 16 mars 2026\n\nBienvenue sur Veylo. En créant un compte ou en utilisant l\'app, tu acceptes les présentes Conditions d\'utilisation.\n\n1. Ce qu\'est Veylo\nVeylo est une app sociale où tu peux rencontrer des gens, discuter anonymement, créer un lien au fil du temps et, si vous êtes d\'accord tous les deux, passer à un appel vocal ou en face à face.\n\n2. Ton compte\nTu dois fournir des informations exactes et protéger tes identifiants de connexion. Tu es responsable de l\'activité de ton compte. Tu dois avoir l\'âge requis par les lois de ton pays pour utiliser Veylo.\n\n3. Utilisation respectueuse\nNe harcèle pas, ne menace pas, n\'escroque pas, n\'usurpe pas l\'identité d\'autrui, ne partage pas de contenu illégal et n\'essaie pas de contourner les fonctions de sécurité. Nous pouvons supprimer du contenu, limiter des fonctionnalités ou suspendre les comptes qui enfreignent ces règles.\n\n4. Chat anonyme et révélation du profil\nLes chats anonymes peuvent masquer ton nom et ta photo jusqu\'à ce que certaines étapes du lien soient atteintes. La révélation du profil complet nécessite un consentement mutuel. Ne fais pas pression sur les autres pour qu\'ils révèlent leur identité.\n\n5. Achats\nCertaines fonctionnalités peuvent être payantes. Les achats sont gérés par l\'App Store d\'Apple ou Google Play. Restaurer les achats permet de récupérer les achats éligibles effectués avec le même compte store. Les remboursements suivent la politique du store.\n\n6. Contenu que tu partages\nTu conserves les droits sur ton contenu, mais tu accordes à Veylo une licence pour l\'héberger et l\'afficher dans l\'app dans la mesure nécessaire au fonctionnement du service. Ne publie pas de contenu que tu n\'as pas le droit de partager.\n\n7. Fin de l\'utilisation\nTu peux arrêter d\'utiliser Veylo à tout moment et demander la suppression de ton compte depuis les Réglages. Nous pouvons également mettre fin au service ou le modifier, avec un préavis raisonnable lorsque cela est requis.\n\n8. Contact\nQuestions sur ces conditions : support@veylo.app';
	@override String get privacyBody => 'Dernière mise à jour : 16 mars 2026\n\nLa présente Politique de confidentialité explique comment Veylo collecte, utilise et protège tes informations.\n\n1. Informations que nous collectons\n• Données de compte : e-mail, nom affiché, photos de profil, bio, préférences\n• Données d\'utilisation : chats, progression du lien, fonctions d\'appel utilisées, informations de base sur l\'appareil et l\'app\n• Achats : données de reçu du store nécessaires pour débloquer et restaurer les fonctionnalités payantes\n\n2. Comment nous les utilisons\nNous utilisons tes données pour faire fonctionner Veylo, personnaliser les matchs et l\'expérience de chat, assurer la sécurité de la communauté, traiter les achats et améliorer le produit. Nous ne vendons pas tes données personnelles.\n\n3. Mode anonyme\nDans les chats anonymes, nous limitons ce que les autres voient (par exemple un nom masqué ou une photo floutée) jusqu\'à ce que les règles de déblocage et le consentement mutuel permettent d\'en montrer plus. En arrière-plan, nous avons tout de même besoin des identifiants de compte pour faire fonctionner cette fonctionnalité de manière sécurisée.\n\n4. Partage\nNous pouvons partager des données avec des prestataires qui nous aident à héberger, analyser ou traiter les paiements, uniquement dans la mesure nécessaire. Nous pouvons également divulguer des informations si la loi l\'exige ou pour protéger les utilisateurs contre un préjudice.\n\n5. Conservation\nNous conservons les données tant que ton compte est actif et aussi longtemps que nécessaire pour des raisons légales, de sécurité et de facturation. Une fois une demande de suppression traitée, nous supprimons ou anonymisons les données personnelles, sauf lorsque leur conservation est obligatoire.\n\n6. Tes choix\nTu peux modifier les informations de ton profil, gérer les notifications, demander la suppression de ton compte et nous contacter au sujet de tes données. Les achats effectués sur les stores sont également gérés via Apple ou Google.\n\n7. Sécurité\nNous mettons en œuvre des mesures techniques et organisationnelles raisonnables pour protéger tes informations. Aucun système n\'est parfaitement sûr ; utilise un mot de passe robuste et garde ton appareil à jour.\n\n8. Contact\nQuestions sur la confidentialité : privacy@veylo.app';
}

// Path: logout
class _Translations$logout$fr extends Translations$logout$tr {
	_Translations$logout$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Déconnexion';
	@override String get subtitle => 'Tu es sûr(e) de vouloir te déconnecter ?';
	@override String get cancel => 'Annuler';
	@override String get confirm => 'Se déconnecter';
}

// Path: deleteAccount
class _Translations$deleteAccount$fr extends Translations$deleteAccount$tr {
	_Translations$deleteAccount$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Demander la suppression du compte';
	@override String get subtitle => 'Tu es sûr(e) de vouloir supprimer ton compte ?';
	@override String get reasonTitle => 'On ne veut pas que tu partes, mais on comprend.';
	@override String get reasonBefore => 'Peux-tu nous dire pourquoi tu pars, pour nous aider à améliorer l\'expérience ';
	@override String get reasonAfter => ' ?';
	@override String get reasonLabel => 'Pourquoi veux-tu supprimer ton compte';
	@override String get reasonHint => 'Écris ton message';
	@override String get cancel => 'Annuler';
	@override String get createRequest => 'Créer une demande';
	@override String get confirmTitle => 'Tu es sûr(e) de vouloir envoyer une demande de suppression ?';
	@override String get confirmSubtitle => 'Si tu confirmes, ta demande de suppression de compte sera envoyée';
	@override String get delete => 'Supprimer';
}

// Path: storyText
class _Translations$storyText$fr extends Translations$storyText$tr {
	_Translations$storyText$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get bold => 'Gras';
	@override String get italic => 'Italique';
	@override String get uppercase => 'Majuscules';
	@override String get underline => 'Souligné';
	@override String get cancel => 'Annuler';
	@override String get galleryError => 'Impossible d\'ouvrir la galerie';
}

// Path: discover.aiMatch
class _Translations$discover$aiMatch$fr extends Translations$discover$aiMatch$tr {
	_Translations$discover$aiMatch$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get feelingTitle => 'Comment tu te sens aujourd\'hui';
	@override String get feelingSubtitle => 'L\'IA trouve le meilleur match selon ton choix';
	@override String get lookingTitle => 'Qu\'est-ce que tu cherches ?';
	@override String get moodSad => 'Triste';
	@override String get moodMeltie => 'Bof';
	@override String get moodBored => 'Ennuyé(e)';
	@override String get moodCrying => 'Pas top';
	@override String get moodSmile => 'Heureux(se)';
	@override String get lookingNewFriends => 'Nouveaux amis';
	@override String get lookingVenting => 'Vider mon sac';
	@override String get lookingFlirty => 'Flirt';
	@override String get lookingFun => 'Fun';
	@override String get lookingCultures => 'Autres cultures';
	@override String get lookingLanguage => 'Pratique de langue';
	@override String get statActiveUsers => 'Utilisateurs actifs';
	@override String get statMatchRate => 'Taux de match';
	@override String get statAvgTime => 'Temps moyen';
	@override String get statActiveValue => '843';
	@override String get statMatchValue => '87%';
	@override String get statAvgValue => '8s';
	@override String get startSmartMatch => 'Lancer le Smart Match';
	@override String get findingTitle => 'Recherche de ton match';
	@override String get findingSubtitle => 'On associe ton humeur et tes centres d\'intérêt à la bonne personne';
	@override String get findingStepMood => 'Humeur analysée';
	@override String get findingStepInterests => 'Centres d\'intérêt associés';
	@override String get findingStepCompatibility => 'Calcul de la compatibilité...';
	@override String get findingStepContent => 'Création du contenu...';
	@override String findingOnline({required Object count}) => '${count} personnes en ligne en ce moment';
	@override String get yourMatchTitle => 'Ton match';
	@override String get yourMatchSubtitle => 'Ton match a été trouvé selon tes réponses';
	@override String vibeMatch({required Object percent}) => '${percent}% de compatibilité';
	@override String get startChatting => 'Commencer à discuter';
	@override String matchNameAge({required Object name, required Object age}) => '${name}, ${age}';
	@override String get matchBio => 'Je vais te faire ressentir des choses que tu ne soupçonnais pas.';
	@override String get swipePrevious => 'Précédent';
	@override String get swipeNext => 'Suivant';
	@override String get swipeFinger => 'Fais glisser';
	@override String get noMatch => 'Personne ne correspond pour le moment. Réessaie un peu plus tard.';
}

// Path: discover.privateRoom
class _Translations$discover$privateRoom$fr extends Translations$discover$privateRoom$tr {
	_Translations$discover$privateRoom$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get subtitle => 'Ce salon est privé. Débloque l\'accès avec des jetons.';
	@override String get roomAccess => 'Accès au salon';
	@override String get yourBalance => 'Ton solde';
	@override String tokensAmount({required Object count}) => '${count} jetons';
	@override String joinForTokens({required Object count}) => 'Rejoindre pour ${count} jetons';
	@override String get cancel => 'Annuler';
}

// Path: discover.roomToken
class _Translations$discover$roomToken$fr extends Translations$discover$roomToken$tr {
	_Translations$discover$roomToken$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get subtitle => 'Débloque l\'accès avec des jetons.';
	@override String get roomAccess => 'Accès au salon';
	@override String get yourBalance => 'Ton solde';
	@override String tokensAmount({required Object count}) => '${count} jetons';
	@override String joinForTokens({required Object count}) => 'Rejoindre pour ${count} jetons';
	@override String get cancel => 'Annuler';
}

// Path: discover.privateRequest
class _Translations$discover$privateRequest$fr extends Translations$discover$privateRequest$tr {
	_Translations$discover$privateRequest$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Demande pour rejoindre';
	@override String roomInfo({required Object name, required Object count}) => '${name} · ${count} membres';
	@override String get messageHint => 'Dis quelque chose (facultatif)...';
	@override String get sendRequest => 'Envoyer la demande';
	@override String get adminReview => 'L\'admin du salon va examiner ta demande';
}

// Path: discover.roomApproved
class _Translations$discover$roomApproved$fr extends Translations$discover$roomApproved$tr {
	_Translations$discover$roomApproved$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'C\'est bon, tu es dedans !';
	@override String subtitle({required Object name}) => 'Ta place dans ${name} est réservée';
	@override String get continueLabel => 'Continuer';
}

// Path: discover.createSpace
class _Translations$discover$createSpace$fr extends Translations$discover$createSpace$tr {
	_Translations$discover$createSpace$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Créer un salon ou un groupe';
	@override String get subtitle => 'Touche plus de monde en créant un groupe ou un salon live';
	@override String get room => 'Salon';
	@override String get group => 'Groupe';
	@override String get hideAccount => 'Masquer ton compte';
	@override String get create => 'Créer';
	@override String get cancel => 'Annuler';
	@override String get createRoomTitle => 'Créer un salon';
	@override String get createGroupTitle => 'Créer un groupe';
	@override String get nameSubtitle => 'Donne un nom à ton groupe';
	@override String get nameHint => 'Oiseaux de nuit';
	@override String createRoomFor({required Object count}) => 'Créer pour ${count} jetons';
}

// Path: discover.liveRoom
class _Translations$discover$liveRoom$fr extends Translations$discover$liveRoom$tr {
	_Translations$discover$liveRoom$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get adminSuffix => '(Admin)';
	@override String get messageHint => 'Message';
	@override String get quickReplyHey => 'Salut tout le monde !';
	@override String get quickReplyTopic => 'C\'est quoi le sujet ?';
	@override String get quickReplyNew => 'Je suis nouveau ici !';
	@override String get sampleChatName => 'Sona';
	@override String get sampleChatBody => 'On fait quoi ? T\'as une idée ?';
	@override String get roomEnded => 'Le salon est terminé.';
	@override String wantsToJoin({required Object name}) => '${name} veut rejoindre';
	@override String get approve => 'Accepter';
}

// Path: discover.groupChat
class _Translations$discover$groupChat$fr extends Translations$discover$groupChat$tr {
	_Translations$discover$groupChat$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String usersCount({required Object count}) => '${count} utilisateurs';
	@override String get sampleVictoria => 'Je m\'ennuie trop. On fait un truc, les gars ?';
	@override String get sampleSona => 'On fait quoi ? T\'as une idée ?';
	@override String get sampleOwn => 'On se retrouve sur le quai';
}

// Path: discover.groupInfo
class _Translations$discover$groupInfo$fr extends Translations$discover$groupInfo$tr {
	_Translations$discover$groupInfo$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get media => 'Médias';
	@override String get gallery => 'Galerie';
	@override String get settings => 'Réglages';
	@override String get notifications => 'Notifications';
	@override String get blocked => 'Bloqués';
	@override String get private => 'Privé';
	@override String membersCount({required Object count}) => '${count} membres';
	@override String get addPeople => 'Ajouter des personnes';
	@override String get you => 'Toi';
	@override String get admin => 'Admin';
	@override String get leaveGroup => 'Quitter le groupe';
	@override String get requests => 'Demandes d\'adhésion';
	@override String get approve => 'Accepter';
	@override String get reject => 'Refuser';
	@override String get addPeopleEmpty => 'Suis des personnes pour les ajouter au groupe.';
	@override String get add => 'Ajouter';
	@override String get makeAdmin => 'Nommer admin';
	@override String get removeAdmin => 'Retirer l\'admin';
	@override String get remove => 'Retirer du groupe';
	@override String get leaveConfirm => 'Quitter ce groupe ?';
	@override String get leave => 'Quitter';
	@override String get cancel => 'Annuler';
}

// Path: discover.filters
class _Translations$discover$filters$fr extends Translations$discover$filters$tr {
	_Translations$discover$filters$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Filtres';
	@override String get ageRange => 'Tranche d\'âge';
	@override String ageRangeValue({required Object min, required Object max}) => '${min}-${max}';
	@override String get distance => 'Distance';
	@override String distanceValue({required Object km}) => '${km} km';
	@override String get showMe => 'Me montrer';
	@override String get everyone => 'Tout le monde';
	@override String get women => 'Femmes';
	@override String get men => 'Hommes';
	@override String get interests => 'Centres d\'intérêt';
	@override String get activeNow => 'Actif maintenant';
	@override String get activeNowSubtitle => 'Afficher seulement les personnes en ligne';
	@override String get showResult => 'Voir les résultats';
}

// Path: discover.post
class _Translations$discover$post$fr extends Translations$discover$post$tr {
	_Translations$discover$post$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get follow => 'Suivre';
	@override String get following => 'Abonné(e)';
	@override String get addComment => 'Ajouter un commentaire...';
	@override String get commentsTitle => 'Commentaires';
	@override String get sampleCaption => 'Rien de tel qu\'une tasse de café après une belle journée. <3';
	@override String hoursAgo({required Object hours}) => '${hours} h';
	@override String minutesAgo({required Object minutes}) => '${minutes} min';
	@override String daysAgo({required Object days}) => '${days} j';
	@override String get deleteCommentTitle => 'Supprimer ce commentaire ?';
}

// Path: discover.story
class _Translations$discover$story$fr extends Translations$discover$story$tr {
	_Translations$discover$story$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get draft => 'BROUILLON';
	@override String get story => 'STORY';
	@override String get share => 'Partager';
	@override String get textPlaceholder => 'Écris quelque chose...';
	@override String get draftPrompt => 'Enregistrer en brouillon ?';
	@override String get saveToDraft => 'Enregistrer le brouillon';
	@override String get moveToTrash => 'Mettre à la corbeille';
	@override String get save => 'Enregistrer';
	@override String get musicTitle => 'Musique';
	@override String get musicEmpty => 'Aucune musique trouvée.';
	@override String get musicError => 'Impossible de charger la musique.';
	@override String get downloaded => 'Enregistré dans la galerie';
	@override String get downloadFailed => 'Échec de l\'enregistrement';
}

// Path: discover.highlight
class _Translations$discover$highlight$fr extends Translations$discover$highlight$tr {
	_Translations$discover$highlight$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'À la une';
	@override String get view => 'Voir';
	@override String get aiComments => 'Commentaires IA';
	@override String get remove => 'Retirer de la une';
	@override String get sharedSuccess => 'Ton post a bien été partagé';
	@override String get boost => 'Booster';
}

// Path: discover.stats
class _Translations$discover$stats$fr extends Translations$discover$stats$tr {
	_Translations$discover$stats$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Statistiques';
	@override String get subtitle => 'Les statistiques de ton post\nsont ci-dessous.';
	@override String get viewers => 'Vues';
	@override String get comments => 'Commentaires';
	@override String get likes => 'J\'aime';
	@override String get boostCta => 'Booster 1 jour - 100 jetons';
	@override String get boosted => 'Boosté ! Ton post est en tête pendant 24 heures.';
}

// Path: createProfile.interests
class _Translations$createProfile$interests$fr extends Translations$createProfile$interests$tr {
	_Translations$createProfile$interests$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get music => 'Musique';
	@override String get movies => 'Films';
	@override String get tvShows => 'Séries';
	@override String get reading => 'Lecture';
	@override String get painting => 'Peinture';
	@override String get photography => 'Photo';
	@override String get theatre => 'Théâtre';
	@override String get fitness => 'Fitness';
	@override String get swimming => 'Natation';
	@override String get football => 'Football';
	@override String get basketball => 'Basket';
	@override String get coffee => 'Café';
	@override String get travel => 'Voyages';
	@override String get camping => 'Camping';
	@override String get meditation => 'Méditation';
	@override String get videoGames => 'Jeux vidéo';
	@override String get boardGames => 'Jeux de société';
	@override String get standUp => 'Stand-up';
	@override String get tech => 'Tech';
	@override String get coding => 'Code';
	@override String get ai => 'IA';
	@override String get podcast => 'Podcasts';
}

/// The flat map containing all translations for locale <fr>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsFr {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.name' => 'Veylo',
			'app.tagline' => 'Bienvenue',
			'home.title' => 'Accueil',
			'home.subtitle' => 'L\'app est en préparation',
			'home.body' => 'L\'interface multilingue est gérée avec slang.',
			'chats.title' => 'Discussions',
			'chats.search' => 'Rechercher',
			'chats.messagesSection' => 'Messages',
			'chats.request' => 'Demandes',
			'chats.emptyRequestTitle' => 'Aucune notification\nde message récente',
			'chats.emptyRequestSubtitle' => 'Les demandes de plus de 30 jours ne sont pas affichées.',
			'chats.noteAdd' => 'Ajouter une note',
			'chats.anonymous' => 'Anonyme',
			'chats.online' => 'en ligne',
			'chats.offline' => 'hors ligne',
			'chats.connection' => 'Lien',
			'chats.connectionPercent' => ({required Object n}) => '${n}%',
			'chats.connectionProgressTitle' => 'Progression du lien',
			'chats.milestoneInitial' => 'Initiale du prénom',
			'chats.milestoneInitialHint' => 'Débloquée à 25 %',
			'chats.milestoneInitialLocked' => 'Se débloque à 25 %',
			'chats.milestonePhoto' => 'Aperçu de photo floutée',
			'chats.milestonePhotoHint' => 'Se débloque à 70 %',
			'chats.milestoneFull' => 'Profil complet',
			'chats.milestoneFullHint' => 'Accord mutuel à 100 %',
			'chats.sampleAnonymousMessage' => 'Salut, ravi(e) de te rencontrer. Tu peux me parler un peu de toi ?',
			'chats.strangerSampleMessage' => 'Salut Jhon, ravi(e) de te rencontrer. Tu peux me parler un peu de toi ?',
			'chats.approve' => 'Accepter',
			'chats.blockUser' => 'Bloquer',
			'chats.reject' => 'Refuser',
			'chats.messageHint' => 'Salut ! Ça va ?',
			'chats.revealTitle' => 'Vous avez atteint 100 %',
			'chats.revealSubtitle' => 'Révéler vos profils complets l\'un à l\'autre ? Vous devez être d\'accord tous les deux.',
			'chats.revealWaiting' => ({required Object name}) => 'En attente de l\'accord de ${name}',
			'chats.revealCta' => 'Révéler mon profil',
			'chats.revealNotYet' => 'Pas encore',
			'chats.seen' => 'Vu',
			'chats.typing' => 'écrit…',
			'chats.noteYou' => 'Toi',
			'chats.noteSheetTitle' => 'Partager une note',
			'chats.noteSheetSubtitle' => 'Ta note reste visible 24 heures',
			'chats.noteHint' => 'Tu penses à quoi ?',
			'chats.noteShare' => 'Partager',
			'chats.noteDelete' => 'Supprimer la note',
			'profile.eyebrow' => 'Profil',
			'profile.title' => 'Réglages',
			'profile.editProfile' => 'Modifier le profil',
			'profile.statLike' => 'J\'aime',
			'profile.statFollow' => 'Abonnements',
			'profile.statFollower' => 'Abonnés',
			'profile.promoTitle' => 'Reçois plus de messages !',
			'profile.promoSubtitle' => 'Démarque-toi, apparais en haut de la liste',
			'profile.standOut' => 'Se démarquer',
			'profile.tabPosts' => 'Posts',
			'profile.tabVideo' => 'Vidéo',
			'profile.tabSaved' => 'Enregistrés',
			'profile.save' => 'Enregistrer',
			'profile.changePhoto' => 'Changer la photo',
			'profile.changeBorder' => 'Changer le cadre',
			'profile.interest' => 'Centres d\'intérêt',
			'profile.name' => 'Nom',
			'profile.changeName' => 'Changer le nom',
			'profile.changePassword' => 'Changer le mot de passe',
			'profile.confirmPassword' => 'Confirmer le mot de passe',
			'profile.email' => 'E-mail',
			'profile.accountManagement' => 'Gestion du compte',
			'profile.settingsAbout' => 'À propos',
			'profile.settingsAccount' => 'Paramètres du compte',
			'profile.settingsSupport' => 'Assistance',
			'profile.shareApp' => 'Partager l\'app',
			'profile.shareAppTitle' => 'Partage avec tes amis',
			'profile.shareAppSubtitle' => 'Partage Veylo avec tes amis et découvrez ensemble !',
			'profile.shareAppLabel' => 'Lien de l\'app',
			'profile.rateApp' => 'Tu nous aimes ? Note-nous',
			'profile.notifications' => 'Notifications',
			'profile.password' => 'Mot de passe',
			'profile.deleteConversation' => 'Supprimer les conversations',
			'profile.faqHelp' => 'FAQ & Aide',
			'profile.restorePurchases' => 'Restaurer les achats',
			'profile.termsOfService' => 'Conditions d\'utilisation',
			'profile.privacyPolicy' => 'Politique de confidentialité',
			'profile.restorePurchasesDone' => 'Achats vérifiés',
			'profile.conversationsDeleted' => 'Toutes les conversations ont été supprimées',
			'profile.logOut' => 'Se déconnecter',
			'profile.deleteAccountAndData' => 'Supprimer le compte et les données',
			'profile.passwordPlaceholder' => '********',
			'profile.height' => 'Taille',
			'profile.addHeight' => 'Ajouter ta taille',
			'profile.heightCm' => ({required Object value}) => '${value} cm',
			'profile.languages' => 'Langues',
			'profile.relationshipGoals' => 'Objectifs de relation',
			'profile.lookingFor' => 'Je cherche',
			'profile.newFriends' => '👋 Nouveaux amis',
			'profile.goalLongTermOpenToShort' => '💕 Du sérieux, ouvert(e) au court terme',
			'profile.goalLongTermRelationship' => '💘 Relation sérieuse',
			'profile.goalNewFriends' => '👋 Nouveaux amis',
			'profile.goalShortTermFun' => '🥃 Fun sans engagement',
			'profile.goalStillFiguringItOut' => '🤔 Je ne sais pas encore',
			'profile.basics' => 'L\'essentiel',
			'profile.zodiac' => 'Signe astro',
			'profile.zodiacValue' => 'Scorpion',
			'profile.education' => 'Études',
			'profile.educationValue' => 'Licence',
			'profile.educationHighSchool' => 'Lycée',
			'profile.educationAssociates' => 'Bac +2',
			'profile.educationBachelors' => 'Licence',
			'profile.educationMasters' => 'Master',
			'profile.educationPhd' => 'Doctorat',
			'profile.voiceRecord' => 'Message vocal',
			'profile.addVoice' => 'Ajouter un vocal',
			'profile.lifestyle' => 'Mode de vie',
			'profile.pets' => 'Animaux',
			'profile.petsValue' => 'J\'ai un chat',
			'profile.petsDontWant' => 'Je ne veux pas d\'animaux',
			'profile.petsAllergic' => 'Je suis allergique aux animaux',
			'profile.petsHaveCat' => 'J\'ai un chat',
			'profile.petsHaveDog' => 'J\'ai un chien',
			'profile.petsHaveCatsAndDogs' => 'J\'ai des chats et des chiens',
			'profile.petsHaveOther' => 'J\'ai d\'autres animaux',
			'profile.drinking' => 'Alcool',
			'profile.drinkingValue' => 'Pour les grandes occasions',
			'profile.drinkingNever' => 'Jamais',
			'profile.drinkingSpecialOccasions' => 'Pour les grandes occasions',
			'profile.drinkingSocially' => 'En soirée',
			'profile.drinkingFrequently' => 'Souvent',
			'profile.drinkingSober' => 'Sobre',
			'profile.drinkingPreferNotToSay' => 'Je préfère ne pas le dire',
			'profile.smoking' => 'Tabac',
			'profile.smokingValue' => 'Non-fumeur',
			'profile.smokingNonSmoker' => 'Non-fumeur',
			'profile.smokingSocialSmoker' => 'Fumeur occasionnel',
			'profile.smokingSmoker' => 'Fumeur',
			'profile.smokingTryingToQuit' => 'J\'essaie d\'arrêter',
			'profile.smokingWhenDrinking' => 'Fumeur quand je bois',
			'profile.smokingPreferNotToSay' => 'Je préfère ne pas le dire',
			'profile.gender' => 'Genre',
			'profile.genderFemale' => 'Femme',
			'profile.genderMale' => 'Homme',
			'profile.genderPreferNotToSay' => 'Je préfère ne pas le dire',
			'profile.visible' => 'Visible',
			'profile.profileVisibility' => 'Visibilité du profil',
			'profile.language' => 'Langue',
			'profile.borderTitle' => 'Cadre de profil',
			'profile.borderSubtitle' => 'Ajoute un cadre à ton profil pour\nte démarquer.',
			'profile.borderBuySection' => 'Acheter un cadre',
			'profile.borderBuyCta' => 'Acheter le cadre',
			'profile.borderToken' => ({required Object count}) => '${count} jetons',
			'profile.borderAmethystWings' => 'Amethyst Wings',
			'profile.borderGoldenPhoenix' => 'Golden Phoenix',
			'profile.borderFrostCrown' => 'Frost Crown',
			'profile.borderEmeraldWhisper' => 'Emerald Whisper',
			'profile.borderRoseQuartz' => 'Rose Quartz',
			'profile.borderStarlitComet' => 'Starlit Comet',
			'profile.borderCrimsonRoyal' => 'Crimson Royal',
			'profile.borderSapphireHalo' => 'Sapphire Halo',
			'profile.follow' => 'Suivre',
			'profile.following' => 'Abonné(e)',
			'profile.followPageTitle' => 'Abonnements',
			'profile.followTabFollowing' => 'Abonnements',
			'profile.followTabFollowers' => 'Abonnés',
			'profile.followSearch' => 'Rechercher',
			'profile.unfollow' => 'Ne plus suivre',
			'profile.followSortTitle' => 'Trier',
			'profile.followSortRecent' => 'Mes abonnements les plus récents',
			'profile.followSortNotFollowingMe' => 'Ceux qui ne me suivent pas en retour',
			'profile.followSortNotFollowedByMe' => 'Ceux que je ne suis pas en retour',
			'profile.followSortShowResult' => 'Voir les résultats',
			'profile.followSortEmpty' => 'Aucun utilisateur ne correspond à ce filtre',
			'profile.shareTitle' => 'Partage avec tes amis',
			'profile.shareSubtitle' => 'Tout est plus fun quand tu te connectes\navec tes amis !',
			'profile.shareProfileLabel' => 'Partager le profil',
			'profile.shareLinkCopied' => 'Lien copié',
			'profile.restrict' => 'Restreindre',
			'profile.block' => 'Bloquer',
			'profile.report' => 'Signaler',
			'profile.blockTitle' => ({required Object username}) => 'Bloquer ${username} ?',
			'profile.blockBody' => 'Cela bloquera aussi tout autre compte que cette personne a ou pourrait créer. Tu peux la débloquer à tout moment.',
			'profile.blockAndReport' => 'Bloquer et signaler',
			'profile.restrictTitle' => ({required Object username}) => 'Restreindre ${username} ?',
			'profile.restrictBody' => 'Cette personne ne pourra pas voir quand tu es en ligne ni si tu as lu ses messages. Tu peux changer ça à tout moment.',
			'profile.restrictAndReport' => 'Restreindre et signaler',
			'profile.reportTitle' => 'Dis-nous pourquoi',
			'profile.reportSubtitle' => 'Pour nous aider à améliorer ton expérience, peux-tu nous dire pourquoi tu veux signaler cet utilisateur ?',
			'profile.reportMessageLabel' => 'Message du signalement',
			'profile.reportMessageHint' => 'Écris ton message',
			'profile.reportCancel' => 'Annuler',
			'profile.sendReport' => 'Envoyer',
			'profile.notSet' => 'Non renseigné',
			'profile.reportSent' => 'Merci, nous avons bien reçu ton signalement.',
			'profile.emailVerificationSent' => ({required Object email}) => 'Nous avons envoyé un lien de confirmation à ${email}. Ton e-mail sera modifié après confirmation.',
			'profile.passwordChanged' => 'Ton mot de passe a été mis à jour.',
			'profile.passwordMismatch' => 'Les mots de passe ne correspondent pas.',
			'nav.discover' => 'Découvrir',
			'nav.chat' => 'Chat',
			'nav.call' => 'Appel',
			'nav.vibes' => 'Vibes',
			'nav.profile' => 'Profil',
			'call.title' => '60 secondes avec un inconnu',
			'call.subtitle' => 'Parle 60 secondes avec un inconnu au hasard, en tout anonymat. Pas de profil, pas de photo, pas de nom. Juste une voix et un moment.',
			'call.findingTitle' => 'Recherche d\'un inconnu...',
			'call.findingSubtitle' => 'Vous parlerez anonymement pendant 60 secondes. Pas de profil, pas de noms.',
			'call.callStranger' => 'Appeler un inconnu - 10 jetons',
			'call.cancel' => 'Annuler',
			'call.female' => 'Femme',
			'call.male' => 'Homme',
			'call.nonBinary' => 'Non-binaire',
			'call.preferNotToSay' => 'Je préfère ne pas le dire',
			'call.anonymousBadge' => '🎙️ Appel vocal anonyme',
			'call.stranger' => 'Inconnu',
			'call.secondsLeft' => ({required Object n}) => '${n}s',
			'call.timesUpTitle' => 'Temps écoulé !',
			'call.timesUpSubtitle' => 'Envie de continuer ? Si vous dites oui tous les deux, le chat se débloque.',
			'call.keepTalking' => 'Continuer',
			'call.endCall' => 'Raccrocher',
			'call.waitingOther' => 'En attente de l\'autre personne...',
			'call.callStrangerFree' => 'Appeler un inconnu',
			'call.peerLeft' => 'L\'autre personne a raccroché.',
			'call.noKeep' => 'Le chat ne s\'est pas débloqué cette fois.',
			'call.videoWaiting' => 'En attente de l\'acceptation de l\'appel vidéo...',
			'call.videoDeclined' => 'L\'appel vidéo a été refusé.',
			'call.micDenied' => 'L\'accès au micro est nécessaire pour les appels. Tu peux l\'activer dans les Réglages.',
			'call.videoCost' => 'Appel vidéo : 20 jetons / 15 min',
			'call.calling' => 'Appel en cours',
			'call.accept' => 'Accepter',
			'call.decline' => 'Refuser',
			'call.switchToVideo' => 'Passer en appel vidéo ?',
			'call.noMatchTitle' => 'Personne n\'est disponible pour l\'instant',
			'call.noMatchBody' => 'Nous n\'avons trouvé personne avec qui parler pour le moment. Réessaie un peu plus tard.',
			'call.noMatchOk' => 'OK',
			'vibes.search' => 'Rechercher',
			'vibes.sendMessage' => 'Envoyer un message',
			'vibes.wantsToTalk' => 'Veut en parler maintenant',
			'vibes.shareTitle' => 'Partager une vibe',
			'vibes.replyTitle' => 'Répondre à la vibe',
			'vibes.shareHint' => 'Écris quelque chose',
			'vibes.shareAnonymous' => 'Partager anonymement',
			'vibes.empty' => 'Aucune vibe ces dernières 24 heures. Partage la première !',
			'vibes.deleteTitle' => 'Supprimer cette vibe ?',
			'vibes.delete' => 'Supprimer',
			'vibes.cancel' => 'Annuler',
			'discover.title' => 'Découvrir',
			'discover.tabRooms' => 'Salons',
			'discover.tabDiscover' => 'Découvrir',
			'discover.tabAiMatch' => 'AI Match',
			'discover.aiMatch.feelingTitle' => 'Comment tu te sens aujourd\'hui',
			'discover.aiMatch.feelingSubtitle' => 'L\'IA trouve le meilleur match selon ton choix',
			'discover.aiMatch.lookingTitle' => 'Qu\'est-ce que tu cherches ?',
			'discover.aiMatch.moodSad' => 'Triste',
			'discover.aiMatch.moodMeltie' => 'Bof',
			'discover.aiMatch.moodBored' => 'Ennuyé(e)',
			'discover.aiMatch.moodCrying' => 'Pas top',
			'discover.aiMatch.moodSmile' => 'Heureux(se)',
			'discover.aiMatch.lookingNewFriends' => 'Nouveaux amis',
			'discover.aiMatch.lookingVenting' => 'Vider mon sac',
			'discover.aiMatch.lookingFlirty' => 'Flirt',
			'discover.aiMatch.lookingFun' => 'Fun',
			'discover.aiMatch.lookingCultures' => 'Autres cultures',
			'discover.aiMatch.lookingLanguage' => 'Pratique de langue',
			'discover.aiMatch.statActiveUsers' => 'Utilisateurs actifs',
			'discover.aiMatch.statMatchRate' => 'Taux de match',
			'discover.aiMatch.statAvgTime' => 'Temps moyen',
			'discover.aiMatch.statActiveValue' => '843',
			'discover.aiMatch.statMatchValue' => '87%',
			'discover.aiMatch.statAvgValue' => '8s',
			'discover.aiMatch.startSmartMatch' => 'Lancer le Smart Match',
			'discover.aiMatch.findingTitle' => 'Recherche de ton match',
			'discover.aiMatch.findingSubtitle' => 'On associe ton humeur et tes centres d\'intérêt à la bonne personne',
			'discover.aiMatch.findingStepMood' => 'Humeur analysée',
			'discover.aiMatch.findingStepInterests' => 'Centres d\'intérêt associés',
			'discover.aiMatch.findingStepCompatibility' => 'Calcul de la compatibilité...',
			'discover.aiMatch.findingStepContent' => 'Création du contenu...',
			'discover.aiMatch.findingOnline' => ({required Object count}) => '${count} personnes en ligne en ce moment',
			'discover.aiMatch.yourMatchTitle' => 'Ton match',
			'discover.aiMatch.yourMatchSubtitle' => 'Ton match a été trouvé selon tes réponses',
			'discover.aiMatch.vibeMatch' => ({required Object percent}) => '${percent}% de compatibilité',
			'discover.aiMatch.startChatting' => 'Commencer à discuter',
			'discover.aiMatch.matchNameAge' => ({required Object name, required Object age}) => '${name}, ${age}',
			'discover.aiMatch.matchBio' => 'Je vais te faire ressentir des choses que tu ne soupçonnais pas.',
			'discover.aiMatch.swipePrevious' => 'Précédent',
			'discover.aiMatch.swipeNext' => 'Suivant',
			'discover.aiMatch.swipeFinger' => 'Fais glisser',
			'discover.aiMatch.noMatch' => 'Personne ne correspond pour le moment. Réessaie un peu plus tard.',
			'discover.searchHint' => 'Rechercher',
			'discover.allRooms' => 'Tous les salons',
			'discover.allGroups' => 'Tous les groupes',
			'discover.seeAll' => 'Tout voir',
			'discover.live' => 'Live',
			'discover.join' => 'Rejoindre',
			'discover.request' => 'Demander',
			'discover.requested' => 'Demandé',
			'discover.private' => 'Privé',
			'discover.moreCount' => ({required Object count}) => '+${count} de plus',
			'discover.activeCount' => ({required Object count}) => '${count} actifs',
			'discover.membersCount' => ({required Object count}) => '${count} membres',
			'discover.privateRoom.subtitle' => 'Ce salon est privé. Débloque l\'accès avec des jetons.',
			'discover.privateRoom.roomAccess' => 'Accès au salon',
			'discover.privateRoom.yourBalance' => 'Ton solde',
			'discover.privateRoom.tokensAmount' => ({required Object count}) => '${count} jetons',
			'discover.privateRoom.joinForTokens' => ({required Object count}) => 'Rejoindre pour ${count} jetons',
			'discover.privateRoom.cancel' => 'Annuler',
			'discover.roomToken.subtitle' => 'Débloque l\'accès avec des jetons.',
			'discover.roomToken.roomAccess' => 'Accès au salon',
			'discover.roomToken.yourBalance' => 'Ton solde',
			'discover.roomToken.tokensAmount' => ({required Object count}) => '${count} jetons',
			'discover.roomToken.joinForTokens' => ({required Object count}) => 'Rejoindre pour ${count} jetons',
			'discover.roomToken.cancel' => 'Annuler',
			'discover.privateRequest.title' => 'Demande pour rejoindre',
			'discover.privateRequest.roomInfo' => ({required Object name, required Object count}) => '${name} · ${count} membres',
			'discover.privateRequest.messageHint' => 'Dis quelque chose (facultatif)...',
			'discover.privateRequest.sendRequest' => 'Envoyer la demande',
			'discover.privateRequest.adminReview' => 'L\'admin du salon va examiner ta demande',
			'discover.roomApproved.title' => 'C\'est bon, tu es dedans !',
			'discover.roomApproved.subtitle' => ({required Object name}) => 'Ta place dans ${name} est réservée',
			'discover.roomApproved.continueLabel' => 'Continuer',
			'discover.createSpace.title' => 'Créer un salon ou un groupe',
			'discover.createSpace.subtitle' => 'Touche plus de monde en créant un groupe ou un salon live',
			'discover.createSpace.room' => 'Salon',
			'discover.createSpace.group' => 'Groupe',
			'discover.createSpace.hideAccount' => 'Masquer ton compte',
			'discover.createSpace.create' => 'Créer',
			'discover.createSpace.cancel' => 'Annuler',
			'discover.createSpace.createRoomTitle' => 'Créer un salon',
			'discover.createSpace.createGroupTitle' => 'Créer un groupe',
			'discover.createSpace.nameSubtitle' => 'Donne un nom à ton groupe',
			'discover.createSpace.nameHint' => 'Oiseaux de nuit',
			'discover.createSpace.createRoomFor' => ({required Object count}) => 'Créer pour ${count} jetons',
			'discover.liveRoom.adminSuffix' => '(Admin)',
			'discover.liveRoom.messageHint' => 'Message',
			'discover.liveRoom.quickReplyHey' => 'Salut tout le monde !',
			'discover.liveRoom.quickReplyTopic' => 'C\'est quoi le sujet ?',
			'discover.liveRoom.quickReplyNew' => 'Je suis nouveau ici !',
			'discover.liveRoom.sampleChatName' => 'Sona',
			'discover.liveRoom.sampleChatBody' => 'On fait quoi ? T\'as une idée ?',
			'discover.liveRoom.roomEnded' => 'Le salon est terminé.',
			'discover.liveRoom.wantsToJoin' => ({required Object name}) => '${name} veut rejoindre',
			'discover.liveRoom.approve' => 'Accepter',
			'discover.groupChat.usersCount' => ({required Object count}) => '${count} utilisateurs',
			'discover.groupChat.sampleVictoria' => 'Je m\'ennuie trop. On fait un truc, les gars ?',
			'discover.groupChat.sampleSona' => 'On fait quoi ? T\'as une idée ?',
			'discover.groupChat.sampleOwn' => 'On se retrouve sur le quai',
			'discover.groupInfo.media' => 'Médias',
			'discover.groupInfo.gallery' => 'Galerie',
			'discover.groupInfo.settings' => 'Réglages',
			'discover.groupInfo.notifications' => 'Notifications',
			'discover.groupInfo.blocked' => 'Bloqués',
			'discover.groupInfo.private' => 'Privé',
			'discover.groupInfo.membersCount' => ({required Object count}) => '${count} membres',
			'discover.groupInfo.addPeople' => 'Ajouter des personnes',
			'discover.groupInfo.you' => 'Toi',
			'discover.groupInfo.admin' => 'Admin',
			'discover.groupInfo.leaveGroup' => 'Quitter le groupe',
			'discover.groupInfo.requests' => 'Demandes d\'adhésion',
			'discover.groupInfo.approve' => 'Accepter',
			'discover.groupInfo.reject' => 'Refuser',
			'discover.groupInfo.addPeopleEmpty' => 'Suis des personnes pour les ajouter au groupe.',
			'discover.groupInfo.add' => 'Ajouter',
			'discover.groupInfo.makeAdmin' => 'Nommer admin',
			'discover.groupInfo.removeAdmin' => 'Retirer l\'admin',
			'discover.groupInfo.remove' => 'Retirer du groupe',
			'discover.groupInfo.leaveConfirm' => 'Quitter ce groupe ?',
			'discover.groupInfo.leave' => 'Quitter',
			'discover.groupInfo.cancel' => 'Annuler',
			'discover.filters.title' => 'Filtres',
			'discover.filters.ageRange' => 'Tranche d\'âge',
			'discover.filters.ageRangeValue' => ({required Object min, required Object max}) => '${min}-${max}',
			'discover.filters.distance' => 'Distance',
			'discover.filters.distanceValue' => ({required Object km}) => '${km} km',
			'discover.filters.showMe' => 'Me montrer',
			'discover.filters.everyone' => 'Tout le monde',
			'discover.filters.women' => 'Femmes',
			'discover.filters.men' => 'Hommes',
			'discover.filters.interests' => 'Centres d\'intérêt',
			'discover.filters.activeNow' => 'Actif maintenant',
			'discover.filters.activeNowSubtitle' => 'Afficher seulement les personnes en ligne',
			'discover.filters.showResult' => 'Voir les résultats',
			'discover.post.follow' => 'Suivre',
			'discover.post.following' => 'Abonné(e)',
			'discover.post.addComment' => 'Ajouter un commentaire...',
			'discover.post.commentsTitle' => 'Commentaires',
			'discover.post.sampleCaption' => 'Rien de tel qu\'une tasse de café après une belle journée. <3',
			'discover.post.hoursAgo' => ({required Object hours}) => '${hours} h',
			'discover.post.minutesAgo' => ({required Object minutes}) => '${minutes} min',
			'discover.post.daysAgo' => ({required Object days}) => '${days} j',
			'discover.post.deleteCommentTitle' => 'Supprimer ce commentaire ?',
			'discover.story.draft' => 'BROUILLON',
			'discover.story.story' => 'STORY',
			'discover.story.share' => 'Partager',
			'discover.story.textPlaceholder' => 'Écris quelque chose...',
			'discover.story.draftPrompt' => 'Enregistrer en brouillon ?',
			'discover.story.saveToDraft' => 'Enregistrer le brouillon',
			'discover.story.moveToTrash' => 'Mettre à la corbeille',
			'discover.story.save' => 'Enregistrer',
			'discover.story.musicTitle' => 'Musique',
			'discover.story.musicEmpty' => 'Aucune musique trouvée.',
			'discover.story.musicError' => 'Impossible de charger la musique.',
			'discover.story.downloaded' => 'Enregistré dans la galerie',
			'discover.story.downloadFailed' => 'Échec de l\'enregistrement',
			'discover.highlight.title' => 'À la une',
			'discover.highlight.view' => 'Voir',
			'discover.highlight.aiComments' => 'Commentaires IA',
			'discover.highlight.remove' => 'Retirer de la une',
			'discover.highlight.sharedSuccess' => 'Ton post a bien été partagé',
			'discover.highlight.boost' => 'Booster',
			'discover.stats.title' => 'Statistiques',
			'discover.stats.subtitle' => 'Les statistiques de ton post\nsont ci-dessous.',
			'discover.stats.viewers' => 'Vues',
			'discover.stats.comments' => 'Commentaires',
			'discover.stats.likes' => 'J\'aime',
			'discover.stats.boostCta' => 'Booster 1 jour - 100 jetons',
			'discover.stats.boosted' => 'Boosté ! Ton post est en tête pendant 24 heures.',
			'discover.hostedBy' => ({required Object name}) => 'Animé par ${name}',
			'common.loading' => 'Chargement…',
			'common.retry' => 'Réessayer',
			'common.cancel' => 'Annuler',
			'common.save' => 'Enregistrer',
			'common.continueAction' => 'Continuer',
			'common.language' => 'Langue',
			'common.or' => 'OU',
			'languages.tr' => 'Türkçe',
			'languages.en' => 'English',
			'auth.createAccountTitle' => 'Crée ton compte',
			'auth.createAccountSubtitle' => 'Rejoins Veylo et commence à faire des rencontres.',
			'auth.welcomeBackTitle' => 'Bon retour',
			'auth.welcomeBackSubtitle' => 'Connecte-toi pour continuer sur Veylo.',
			'auth.username' => 'Nom d\'utilisateur',
			'auth.usernameHint' => 'Choisis un nom d\'utilisateur',
			'auth.email' => 'E-mail',
			'auth.emailHint' => 'Saisis ton e-mail',
			'auth.emailOrUsername' => 'E-mail ou nom d\'utilisateur',
			'auth.emailOrUsernameHint' => 'Saisis ton e-mail ou nom d\'utilisateur',
			'auth.password' => 'Mot de passe',
			'auth.passwordCreateHint' => 'Crée un mot de passe',
			'auth.passwordEnterHint' => 'Saisis ton mot de passe',
			'auth.signUp' => 'S\'inscrire',
			'auth.logIn' => 'Se connecter',
			'auth.forgotPassword' => 'Mot de passe oublié ?',
			'auth.continueWithApple' => 'Continuer avec Apple',
			'auth.continueWithGoogle' => 'Continuer avec Google',
			'auth.legalPrefix' => 'En continuant, tu acceptes nos ',
			'auth.termsOfService' => 'Conditions d\'utilisation',
			'auth.legalMiddle' => ' et reconnais avoir lu notre ',
			'auth.privacyPolicy' => 'Politique de confidentialité',
			'auth.legalSuffix' => '.',
			'auth.passwordResetSent' => 'Nous t\'avons envoyé un lien de réinitialisation par e-mail.',
			'onboarding.skip' => 'Passer',
			'onboarding.page1Title' => 'Sois toi-même. Reste anonyme.',
			'onboarding.page1Subtitle' => 'Rencontre de nouvelles personnes et discute\nsans révéler qui tu es.',
			'onboarding.page2Title' => 'Écris. Parle. Ressens la vibe.',
			'onboarding.page2Subtitle' => 'Commence anonymement, puis écris, appelle ou passe en face à face quand tu es prêt(e).',
			'onboarding.page3Title' => 'Trouve ta tribu. Rejoins\nla conversation.',
			'onboarding.page3Subtitle' => 'Entre dans des salons, fais des rencontres et\npartagez le moment ensemble.',
			'onboarding.getStarted' => 'C\'est parti',
			'onboarding.alreadyHaveAccount' => 'Déjà un compte Veylo ? ',
			'onboarding.logInAction' => 'Se connecter',
			'createProfile.navTitle' => 'Créer le profil',
			'createProfile.stepUsername' => '1/5 Nom d\'utilisateur',
			'createProfile.title' => 'Crée ton profil',
			'createProfile.subtitle' => 'Ton vrai nom sert uniquement à la vérification, il ne sera pas affiché publiquement.',
			'createProfile.subtitleLine1' => 'Ton vrai nom sert uniquement à la vérification,',
			'createProfile.subtitleLine2' => 'il ne sera pas affiché publiquement.',
			'createProfile.fullName' => 'Nom complet',
			'createProfile.fullNameHint' => 'Sam Lee',
			'createProfile.username' => 'Nom d\'utilisateur',
			'createProfile.usernameHint' => 'samlee123',
			'createProfile.usernameTaken' => 'Ce nom d\'utilisateur existe déjà !',
			'createProfile.usernameAvailable' => 'Nom d\'utilisateur disponible',
			'createProfile.mightWantToTry' => 'Tu peux essayer...',
			'createProfile.stepPhoto' => '2/5 Photo de profil',
			'createProfile.photoTitle' => 'Ajoute une photo de profil',
			'createProfile.photoSubtitle' => 'Les autres peuvent voir ta photo de profil pour s\'assurer que c\'est bien toi.',
			'createProfile.photoSubtitleLine1' => 'Les autres peuvent voir ta photo de profil pour',
			'createProfile.photoSubtitleLine2' => 's\'assurer que c\'est bien toi.',
			'createProfile.choosePhoto' => 'Choisir une photo',
			'createProfile.continueWithoutPhoto' => 'Continuer sans photo de profil',
			'createProfile.saveAndContinue' => 'Enregistrer et continuer',
			'createProfile.choosePhotoSheetTitle' => 'Choisir une photo',
			'createProfile.takePhoto' => 'Prendre une photo',
			'createProfile.chooseFromGallery' => 'Choisir dans la galerie',
			'createProfile.stepGender' => '3/5 Genre',
			'createProfile.genderTitle' => 'Choisis ton genre',
			'createProfile.genderSubtitle' => 'Si tu choisis de nous donner cette info, nous pourrons l\'utiliser pour personnaliser ton contenu',
			'createProfile.genderSubtitleLine1' => 'Si tu choisis de nous donner cette info, nous',
			'createProfile.genderSubtitleLine2' => 'pourrons l\'utiliser pour personnaliser ton contenu',
			'createProfile.genderFemale' => 'Femme',
			'createProfile.genderMale' => 'Homme',
			'createProfile.genderNonBinary' => 'Non-binaire',
			'createProfile.genderPreferNotToSay' => 'Je préfère ne pas le dire',
			'createProfile.stepInterests' => '4/5 Centres d\'intérêt',
			'createProfile.interestsTitle' => 'Qu\'est-ce qui te plaît ?',
			'createProfile.interestsSubtitle' => 'Choisis-en au moins 5, ça nous aide à te présenter des gens qui te comprennent vraiment.',
			'createProfile.interests.music' => 'Musique',
			'createProfile.interests.movies' => 'Films',
			'createProfile.interests.tvShows' => 'Séries',
			'createProfile.interests.reading' => 'Lecture',
			'createProfile.interests.painting' => 'Peinture',
			'createProfile.interests.photography' => 'Photo',
			'createProfile.interests.theatre' => 'Théâtre',
			'createProfile.interests.fitness' => 'Fitness',
			'createProfile.interests.swimming' => 'Natation',
			'createProfile.interests.football' => 'Football',
			'createProfile.interests.basketball' => 'Basket',
			'createProfile.interests.coffee' => 'Café',
			'createProfile.interests.travel' => 'Voyages',
			'createProfile.interests.camping' => 'Camping',
			'createProfile.interests.meditation' => 'Méditation',
			'createProfile.interests.videoGames' => 'Jeux vidéo',
			'createProfile.interests.boardGames' => 'Jeux de société',
			'createProfile.interests.standUp' => 'Stand-up',
			'createProfile.interests.tech' => 'Tech',
			'createProfile.interests.coding' => 'Code',
			'createProfile.interests.ai' => 'IA',
			'createProfile.interests.podcast' => 'Podcasts',
			_ => null,
		} ?? switch (path) {
			'createProfile.stepChatGoal' => '5/5 Objectif',
			'createProfile.chatGoalTitle' => 'Tu cherches quoi aujourd\'hui ?',
			'createProfile.chatGoalSubtitle' => 'Ça nous aide à trouver le bon match selon ton humeur du moment.',
			'createProfile.chatGoalQuickMatch' => 'Match rapide : plonge direct dans une\nconversation',
			'createProfile.chatGoalFlirtyChat' => 'Flirt : des échanges légers\net joueurs',
			'createProfile.chatGoalMoodMatch' => 'Match d\'humeur : selon ce que tu\nressens',
			'createProfile.chatGoalLateNight' => 'Discussions nocturnes : parler à cœur ouvert\nquand le monde dort',
			'createProfile.chatGoalMeetSomeoneNew' => 'Nouvelle rencontre : pas d\'objectif précis,\njuste explorer',
			'createProfile.getStarted' => 'C\'est parti',
			'createProfile.preparingTitleLine1' => 'Nous préparons',
			'createProfile.preparingTitleLine2' => 'des profils faits pour',
			'createProfile.preparingTitleLine3' => 'toi.',
			'createProfile.preparingSubtitleLine1' => 'D\'après tes réponses, nous sélectionnons',
			'createProfile.preparingSubtitleLine2' => 'les meilleurs matchs, patiente un instant.',
			'createProfile.preparingPercent' => ({required Object percent}) => '${percent}%',
			'createProfile.usernameInvalid' => 'Utilise 3 à 30 lettres, chiffres, points ou tirets bas.',
			'errors.network' => 'Impossible de joindre Veylo. Vérifie ta connexion et réessaie.',
			'errors.generic' => 'Un problème est survenu. Réessaie.',
			'errors.signInFailed' => 'Échec de la connexion. Réessaie.',
			'errors.sessionExpired' => 'Ta session a expiré. Reconnecte-toi.',
			'errors.accountSuspended' => 'Ce compte a été suspendu.',
			'errors.unsupportedImage' => 'Choisis une photo JPEG, PNG ou WebP.',
			'errors.fileTooLarge' => 'Ce fichier est trop volumineux.',
			'errors.enterEmailForReset' => 'Saisis ton e-mail ci-dessus pour réinitialiser ton mot de passe.',
			'errors.wrongCredentials' => 'E-mail/nom d\'utilisateur ou mot de passe incorrect.',
			'errors.emailInUse' => 'Cet e-mail est déjà enregistré. Essaie de te connecter.',
			'errors.weakPassword' => 'Le mot de passe doit contenir au moins 6 caractères.',
			'errors.invalidEmail' => 'Saisis une adresse e-mail valide.',
			'errors.tooManyAttempts' => 'Trop de tentatives. Patiente un peu et réessaie.',
			'errors.fillAllFields' => 'Remplis tous les champs.',
			'errors.insufficientTokens' => 'Pas assez de jetons.',
			'errors.requestNotAccepted' => 'Accepte la demande pour répondre.',
			'errors.requestPendingLimit' => 'Tu pourras envoyer plus de messages une fois ta demande acceptée.',
			'errors.blocked' => 'Tu ne peux pas écrire à cette personne.',
			'errors.peerUnavailable' => 'Ce compte n\'est plus disponible.',
			'errors.vibeDailyLimit' => 'Tu as partagé beaucoup de vibes aujourd\'hui. Réessaie plus tard.',
			'errors.groupFull' => 'Ce groupe est complet.',
			'errors.groupCreateLimit' => 'Tu as créé trop de groupes aujourd\'hui. Réessaie plus tard.',
			'errors.notFound' => 'Ce contenu n\'est plus disponible.',
			'errors.recentLogin' => 'Par sécurité, déconnecte-toi puis reconnecte-toi, et réessaie.',
			'errors.socialAccount' => 'Ton e-mail et ton mot de passe sont gérés par ton compte Google ou Apple.',
			'errors.alreadyInCall' => 'Tu es déjà en appel.',
			'errors.roomPrivate' => 'Ce salon est privé. Demande à l\'hôte pour le rejoindre.',
			'errors.roomFull' => 'Ce salon est complet.',
			'faq.q1' => 'Comment fonctionne l\'app ?',
			'faq.q2' => 'C\'est quoi le chat anonyme ?',
			'faq.q3' => 'C\'est quoi la Progression du lien ?',
			'faq.q4' => 'Comment révéler mon profil ?',
			'faq.q5' => 'C\'est quoi 60 secondes avec un inconnu ?',
			'faq.q6' => 'C\'est quoi les Vibes ?',
			'faq.q7' => 'Comment modifier mon profil ?',
			'faq.q8' => 'Comment gérer les notifications ?',
			'faq.q9' => 'Comment restaurer mes achats ?',
			'faq.q10' => 'Puis-je supprimer toutes les conversations ?',
			'faq.q11' => 'Mes données sont-elles sécurisées ?',
			'faq.q12' => 'Comment bloquer ou signaler quelqu\'un ?',
			'faq.q13' => 'Comment partager l\'app ?',
			'faq.q14' => 'Comment supprimer mon compte ?',
			'faq.a1' => 'Sur Veylo, tu peux rencontrer de nouvelles personnes anonymement, discuter et révéler ton profil petit à petit à mesure que votre lien grandit. Passez à l\'écrit, à la voix ou au face à face quand vous êtes prêts tous les deux.',
			'faq.a2' => 'Dans le chat anonyme, ton identité et ta photo restent cachées. Plus le lien grandit, plus tu débloques de détails, comme l\'initiale du prénom et une photo floutée. À 100 %, vous devez être d\'accord tous les deux pour révéler vos profils complets.',
			'faq.a3' => 'Au fil de vos échanges, le pourcentage de lien augmente. À certaines étapes, tu débloques l\'initiale du prénom, une photo floutée, puis le profil complet. Touche le badge Lien pour voir les détails.',
			'faq.a4' => 'Quand le lien atteint 100 %, touche Révéler mon profil. Si l\'autre personne accepte aussi, vos deux profils complets deviennent visibles.',
			'faq.a5' => 'Depuis l\'onglet Appel, tu peux obtenir un court match au hasard. À la fin du temps, tu peux continuer à parler ou raccrocher.',
			'faq.a6' => 'Les Vibes te permettent de découvrir des personnes près de toi sur une carte ou une liste, et de lancer un chat avec quelqu\'un qui t\'intéresse.',
			'faq.a7' => 'Ouvre l\'onglet Profil, puis Modifier le profil pour mettre à jour ton nom, tes photos, ta bio et tes centres d\'intérêt. Les changements apparaissent après l\'enregistrement.',
			'faq.a8' => 'Ouvre Notifications dans les Réglages pour activer ou désactiver les alertes de messages, de matchs et autres.',
			'faq.a9' => 'Va dans Réglages → Gestion du compte → Restaurer les achats. Les achats éligibles effectués avec le même compte store seront restaurés.',
			'faq.a10' => 'Oui. Utilise Réglages → Supprimer les conversations et confirme. Tous les chats seront supprimés. Cette action est irréversible.',
			'faq.a11' => 'Les infos de ton compte et tes messages sont stockés sur des systèmes protégés. Tu peux aussi demander la suppression de ton compte et de tes données à tout moment depuis Gestion du compte.',
			'faq.a12' => 'Utilise le menu sur un profil ou un écran de chat pour bloquer ou signaler. Les signalements sont examinés par notre équipe.',
			'faq.a13' => 'Utilise Partager l\'app dans les Réglages pour copier le lien et l\'envoyer à tes amis.',
			'faq.a14' => 'Va dans Réglages → Gestion du compte → Supprimer le compte et les données. Après avoir indiqué une raison, confirme pour envoyer ta demande de suppression.',
			'legal.termsTitle' => 'Conditions d\'utilisation',
			'legal.privacyTitle' => 'Politique de confidentialité',
			'legal.termsBody' => 'Dernière mise à jour : 16 mars 2026\n\nBienvenue sur Veylo. En créant un compte ou en utilisant l\'app, tu acceptes les présentes Conditions d\'utilisation.\n\n1. Ce qu\'est Veylo\nVeylo est une app sociale où tu peux rencontrer des gens, discuter anonymement, créer un lien au fil du temps et, si vous êtes d\'accord tous les deux, passer à un appel vocal ou en face à face.\n\n2. Ton compte\nTu dois fournir des informations exactes et protéger tes identifiants de connexion. Tu es responsable de l\'activité de ton compte. Tu dois avoir l\'âge requis par les lois de ton pays pour utiliser Veylo.\n\n3. Utilisation respectueuse\nNe harcèle pas, ne menace pas, n\'escroque pas, n\'usurpe pas l\'identité d\'autrui, ne partage pas de contenu illégal et n\'essaie pas de contourner les fonctions de sécurité. Nous pouvons supprimer du contenu, limiter des fonctionnalités ou suspendre les comptes qui enfreignent ces règles.\n\n4. Chat anonyme et révélation du profil\nLes chats anonymes peuvent masquer ton nom et ta photo jusqu\'à ce que certaines étapes du lien soient atteintes. La révélation du profil complet nécessite un consentement mutuel. Ne fais pas pression sur les autres pour qu\'ils révèlent leur identité.\n\n5. Achats\nCertaines fonctionnalités peuvent être payantes. Les achats sont gérés par l\'App Store d\'Apple ou Google Play. Restaurer les achats permet de récupérer les achats éligibles effectués avec le même compte store. Les remboursements suivent la politique du store.\n\n6. Contenu que tu partages\nTu conserves les droits sur ton contenu, mais tu accordes à Veylo une licence pour l\'héberger et l\'afficher dans l\'app dans la mesure nécessaire au fonctionnement du service. Ne publie pas de contenu que tu n\'as pas le droit de partager.\n\n7. Fin de l\'utilisation\nTu peux arrêter d\'utiliser Veylo à tout moment et demander la suppression de ton compte depuis les Réglages. Nous pouvons également mettre fin au service ou le modifier, avec un préavis raisonnable lorsque cela est requis.\n\n8. Contact\nQuestions sur ces conditions : support@veylo.app',
			'legal.privacyBody' => 'Dernière mise à jour : 16 mars 2026\n\nLa présente Politique de confidentialité explique comment Veylo collecte, utilise et protège tes informations.\n\n1. Informations que nous collectons\n• Données de compte : e-mail, nom affiché, photos de profil, bio, préférences\n• Données d\'utilisation : chats, progression du lien, fonctions d\'appel utilisées, informations de base sur l\'appareil et l\'app\n• Achats : données de reçu du store nécessaires pour débloquer et restaurer les fonctionnalités payantes\n\n2. Comment nous les utilisons\nNous utilisons tes données pour faire fonctionner Veylo, personnaliser les matchs et l\'expérience de chat, assurer la sécurité de la communauté, traiter les achats et améliorer le produit. Nous ne vendons pas tes données personnelles.\n\n3. Mode anonyme\nDans les chats anonymes, nous limitons ce que les autres voient (par exemple un nom masqué ou une photo floutée) jusqu\'à ce que les règles de déblocage et le consentement mutuel permettent d\'en montrer plus. En arrière-plan, nous avons tout de même besoin des identifiants de compte pour faire fonctionner cette fonctionnalité de manière sécurisée.\n\n4. Partage\nNous pouvons partager des données avec des prestataires qui nous aident à héberger, analyser ou traiter les paiements, uniquement dans la mesure nécessaire. Nous pouvons également divulguer des informations si la loi l\'exige ou pour protéger les utilisateurs contre un préjudice.\n\n5. Conservation\nNous conservons les données tant que ton compte est actif et aussi longtemps que nécessaire pour des raisons légales, de sécurité et de facturation. Une fois une demande de suppression traitée, nous supprimons ou anonymisons les données personnelles, sauf lorsque leur conservation est obligatoire.\n\n6. Tes choix\nTu peux modifier les informations de ton profil, gérer les notifications, demander la suppression de ton compte et nous contacter au sujet de tes données. Les achats effectués sur les stores sont également gérés via Apple ou Google.\n\n7. Sécurité\nNous mettons en œuvre des mesures techniques et organisationnelles raisonnables pour protéger tes informations. Aucun système n\'est parfaitement sûr ; utilise un mot de passe robuste et garde ton appareil à jour.\n\n8. Contact\nQuestions sur la confidentialité : privacy@veylo.app',
			'logout.title' => 'Déconnexion',
			'logout.subtitle' => 'Tu es sûr(e) de vouloir te déconnecter ?',
			'logout.cancel' => 'Annuler',
			'logout.confirm' => 'Se déconnecter',
			'deleteAccount.title' => 'Demander la suppression du compte',
			'deleteAccount.subtitle' => 'Tu es sûr(e) de vouloir supprimer ton compte ?',
			'deleteAccount.reasonTitle' => 'On ne veut pas que tu partes, mais on comprend.',
			'deleteAccount.reasonBefore' => 'Peux-tu nous dire pourquoi tu pars, pour nous aider à améliorer l\'expérience ',
			'deleteAccount.reasonAfter' => ' ?',
			'deleteAccount.reasonLabel' => 'Pourquoi veux-tu supprimer ton compte',
			'deleteAccount.reasonHint' => 'Écris ton message',
			'deleteAccount.cancel' => 'Annuler',
			'deleteAccount.createRequest' => 'Créer une demande',
			'deleteAccount.confirmTitle' => 'Tu es sûr(e) de vouloir envoyer une demande de suppression ?',
			'deleteAccount.confirmSubtitle' => 'Si tu confirmes, ta demande de suppression de compte sera envoyée',
			'deleteAccount.delete' => 'Supprimer',
			'storyText.bold' => 'Gras',
			'storyText.italic' => 'Italique',
			'storyText.uppercase' => 'Majuscules',
			'storyText.underline' => 'Souligné',
			'storyText.cancel' => 'Annuler',
			'storyText.galleryError' => 'Impossible d\'ouvrir la galerie',
			_ => null,
		};
	}
}
