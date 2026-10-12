///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsTr = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.tr,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <tr>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	dynamic operator[](String key) => _meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final Translations$app$tr app = Translations$app$tr.internal(_root);
	late final Translations$home$tr home = Translations$home$tr.internal(_root);
	late final Translations$chats$tr chats = Translations$chats$tr.internal(_root);
	late final Translations$profile$tr profile = Translations$profile$tr.internal(_root);
	late final Translations$nav$tr nav = Translations$nav$tr.internal(_root);
	late final Translations$call$tr call = Translations$call$tr.internal(_root);
	late final Translations$vibes$tr vibes = Translations$vibes$tr.internal(_root);
	late final Translations$discover$tr discover = Translations$discover$tr.internal(_root);
	late final Translations$common$tr common = Translations$common$tr.internal(_root);
	late final Translations$languages$tr languages = Translations$languages$tr.internal(_root);
	late final Translations$auth$tr auth = Translations$auth$tr.internal(_root);
	late final Translations$onboarding$tr onboarding = Translations$onboarding$tr.internal(_root);
	late final Translations$createProfile$tr createProfile = Translations$createProfile$tr.internal(_root);
	late final Translations$errors$tr errors = Translations$errors$tr.internal(_root);
}

// Path: app
class Translations$app$tr {
	Translations$app$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: 'Veylo'
	String get name => 'Veylo';

	/// tr: 'Hoş geldiniz'
	String get tagline => 'Hoş geldiniz';
}

// Path: home
class Translations$home$tr {
	Translations$home$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: 'Ana Sayfa'
	String get title => 'Ana Sayfa';

	/// tr: 'Uygulama hazırlanıyor'
	String get subtitle => 'Uygulama hazırlanıyor';

	/// tr: 'Çok dilli arayüz slang ile yönetiliyor.'
	String get body => 'Çok dilli arayüz slang ile yönetiliyor.';
}

// Path: chats
class Translations$chats$tr {
	Translations$chats$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: 'Chats'
	String get title => 'Chats';

	/// tr: 'Search'
	String get search => 'Search';

	/// tr: 'Messages'
	String get messagesSection => 'Messages';

	/// tr: 'Request'
	String get request => 'Request';

	/// tr: 'Son mesaj bildirimi yok'
	String get emptyRequestTitle => 'Son mesaj bildirimi yok';

	/// tr: '30 günden eski istekler gösterilmez.'
	String get emptyRequestSubtitle => '30 günden eski istekler gösterilmez.';

	/// tr: 'Not Ekle'
	String get noteAdd => 'Not Ekle';

	/// tr: 'Anonymous'
	String get anonymous => 'Anonymous';

	/// tr: 'online'
	String get online => 'online';

	/// tr: 'offline'
	String get offline => 'offline';

	/// tr: 'Connection'
	String get connection => 'Connection';

	/// tr: '{n}%'
	String connectionPercent({required Object n}) => '${n}%';

	/// tr: 'Connection Progress'
	String get connectionProgressTitle => 'Connection Progress';

	/// tr: 'First name initial'
	String get milestoneInitial => 'First name initial';

	/// tr: 'Unlocked at 25%'
	String get milestoneInitialHint => 'Unlocked at 25%';

	/// tr: 'Unlocks at 25%'
	String get milestoneInitialLocked => 'Unlocks at 25%';

	/// tr: 'Blurred photo preview'
	String get milestonePhoto => 'Blurred photo preview';

	/// tr: 'Unlocks at 70%'
	String get milestonePhotoHint => 'Unlocks at 70%';

	/// tr: 'Full profile review'
	String get milestoneFull => 'Full profile review';

	/// tr: 'Mutual consent at 100%'
	String get milestoneFullHint => 'Mutual consent at 100%';

	/// tr: 'Hello, it was a pleasure meeting you. Could you tell me a little about yourself?'
	String get sampleAnonymousMessage => 'Hello, it was a pleasure meeting you. Could you tell me a little about yourself?';

	/// tr: 'Hello Jhon, it was a pleasure meeting you. Could you tell me a little about yourself?'
	String get strangerSampleMessage => 'Hello Jhon, it was a pleasure meeting you. Could you tell me a little about yourself?';

	/// tr: 'Onayla'
	String get approve => 'Onayla';

	/// tr: 'Engelle'
	String get blockUser => 'Engelle';

	/// tr: 'Reddet'
	String get reject => 'Reddet';

	/// tr: 'Hi! how are you?'
	String get messageHint => 'Hi! how are you?';

	/// tr: 'You've reached 100%'
	String get revealTitle => 'You\'ve reached 100%';

	/// tr: 'Reveal your full profiles to each other? Both sides must agree.'
	String get revealSubtitle => 'Reveal your full profiles to each other? Both sides must agree.';

	/// tr: 'Waiting for {name} to accept'
	String revealWaiting({required Object name}) => 'Waiting for ${name} to accept';

	/// tr: 'Reveal my profile'
	String get revealCta => 'Reveal my profile';

	/// tr: 'Not Yet'
	String get revealNotYet => 'Not Yet';

	/// tr: 'Görüldü'
	String get seen => 'Görüldü';

	/// tr: 'yazıyor…'
	String get typing => 'yazıyor…';

	/// tr: 'Sen'
	String get noteYou => 'Sen';

	/// tr: 'Not paylaş'
	String get noteSheetTitle => 'Not paylaş';

	/// tr: 'Notun 24 saat görünür'
	String get noteSheetSubtitle => 'Notun 24 saat görünür';

	/// tr: 'Aklında ne var?'
	String get noteHint => 'Aklında ne var?';

	/// tr: 'Paylaş'
	String get noteShare => 'Paylaş';

	/// tr: 'Notu sil'
	String get noteDelete => 'Notu sil';
}

// Path: profile
class Translations$profile$tr {
	Translations$profile$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: 'Profile'
	String get eyebrow => 'Profile';

	/// tr: 'Settings'
	String get title => 'Settings';

	/// tr: 'Edit Profile'
	String get editProfile => 'Edit Profile';

	/// tr: 'Like'
	String get statLike => 'Like';

	/// tr: 'Follow'
	String get statFollow => 'Follow';

	/// tr: 'Follower'
	String get statFollower => 'Follower';

	/// tr: 'Get More Messages!'
	String get promoTitle => 'Get More Messages!';

	/// tr: 'Stand out, appear at the top of the list'
	String get promoSubtitle => 'Stand out, appear at the top of the list';

	/// tr: 'Stand Out'
	String get standOut => 'Stand Out';

	/// tr: 'Gönderi'
	String get tabPosts => 'Gönderi';

	/// tr: 'Video'
	String get tabVideo => 'Video';

	/// tr: 'Kaydedilenler'
	String get tabSaved => 'Kaydedilenler';

	/// tr: 'Save'
	String get save => 'Save';

	/// tr: 'Change Photo'
	String get changePhoto => 'Change Photo';

	/// tr: 'Change Border'
	String get changeBorder => 'Change Border';

	/// tr: 'Interest'
	String get interest => 'Interest';

	/// tr: 'Name'
	String get name => 'Name';

	/// tr: 'İsim Değiştir'
	String get changeName => 'İsim Değiştir';

	/// tr: 'Şifre Değiştir'
	String get changePassword => 'Şifre Değiştir';

	/// tr: 'Şifreyi Onayla'
	String get confirmPassword => 'Şifreyi Onayla';

	/// tr: 'E-posta'
	String get email => 'E-posta';

	/// tr: 'Hesap Yönetimi'
	String get accountManagement => 'Hesap Yönetimi';

	/// tr: 'Hakkında'
	String get settingsAbout => 'Hakkında';

	/// tr: 'Account Settings'
	String get settingsAccount => 'Account Settings';

	/// tr: 'Destek'
	String get settingsSupport => 'Destek';

	/// tr: 'Uygulamayı Paylaş'
	String get shareApp => 'Uygulamayı Paylaş';

	/// tr: 'Arkadaşlarınla Paylaş'
	String get shareAppTitle => 'Arkadaşlarınla Paylaş';

	/// tr: 'Veylo’yu arkadaşlarınla paylaş, birlikte keşfedin!'
	String get shareAppSubtitle => 'Veylo’yu arkadaşlarınla paylaş, birlikte keşfedin!';

	/// tr: 'Uygulama bağlantısı'
	String get shareAppLabel => 'Uygulama bağlantısı';

	/// tr: 'Bizi Beğendin mi? Puan Ver'
	String get rateApp => 'Bizi Beğendin mi? Puan Ver';

	/// tr: 'Notifications'
	String get notifications => 'Notifications';

	/// tr: 'Password'
	String get password => 'Password';

	/// tr: 'Sohbetleri Sil'
	String get deleteConversation => 'Sohbetleri Sil';

	/// tr: 'SSS ve Yardım'
	String get faqHelp => 'SSS ve Yardım';

	/// tr: 'Satın Alımları Geri Yükle'
	String get restorePurchases => 'Satın Alımları Geri Yükle';

	/// tr: 'Hizmet Şartları'
	String get termsOfService => 'Hizmet Şartları';

	/// tr: 'Gizlilik Politikası'
	String get privacyPolicy => 'Gizlilik Politikası';

	/// tr: 'Satın alımlar kontrol edildi'
	String get restorePurchasesDone => 'Satın alımlar kontrol edildi';

	/// tr: 'Tüm sohbetler silindi'
	String get conversationsDeleted => 'Tüm sohbetler silindi';

	/// tr: 'Log Out'
	String get logOut => 'Log Out';

	/// tr: 'Delete Account and Data'
	String get deleteAccountAndData => 'Delete Account and Data';

	/// tr: '********'
	String get passwordPlaceholder => '********';

	/// tr: 'Height'
	String get height => 'Height';

	/// tr: 'Add Height'
	String get addHeight => 'Add Height';

	/// tr: '{value} cm'
	String heightCm({required Object value}) => '${value} cm';

	/// tr: 'Languages'
	String get languages => 'Languages';

	/// tr: 'Relationship Goals'
	String get relationshipGoals => 'Relationship Goals';

	/// tr: 'Looking for'
	String get lookingFor => 'Looking for';

	/// tr: '👋 New Friends'
	String get newFriends => '👋 New Friends';

	/// tr: '💕 Long-term, Open to Short'
	String get goalLongTermOpenToShort => '💕 Long-term, Open to Short';

	/// tr: '💘 Long-term Relationship'
	String get goalLongTermRelationship => '💘 Long-term Relationship';

	/// tr: '👋 New friends'
	String get goalNewFriends => '👋 New friends';

	/// tr: '🥃 Short-term Fun'
	String get goalShortTermFun => '🥃 Short-term Fun';

	/// tr: '🤔 Still Figuring It Out'
	String get goalStillFiguringItOut => '🤔 Still Figuring It Out';

	/// tr: 'Basics'
	String get basics => 'Basics';

	/// tr: 'Zodiac'
	String get zodiac => 'Zodiac';

	/// tr: 'Scorpion'
	String get zodiacValue => 'Scorpion';

	/// tr: 'Education'
	String get education => 'Education';

	/// tr: 'Bachelors'
	String get educationValue => 'Bachelors';

	/// tr: 'High School'
	String get educationHighSchool => 'High School';

	/// tr: 'Associate's Degree'
	String get educationAssociates => 'Associate\'s Degree';

	/// tr: 'Bachelor's Degree'
	String get educationBachelors => 'Bachelor\'s Degree';

	/// tr: 'Master's Degree'
	String get educationMasters => 'Master\'s Degree';

	/// tr: 'PhD / Doctorate'
	String get educationPhd => 'PhD / Doctorate';

	/// tr: 'Voice Record'
	String get voiceRecord => 'Voice Record';

	/// tr: 'Add Voice'
	String get addVoice => 'Add Voice';

	/// tr: 'Lifestyle'
	String get lifestyle => 'Lifestyle';

	/// tr: 'Pets'
	String get pets => 'Pets';

	/// tr: 'I have a cat'
	String get petsValue => 'I have a cat';

	/// tr: 'I don't want pets'
	String get petsDontWant => 'I don\'t want pets';

	/// tr: 'I'm allergic to pets'
	String get petsAllergic => 'I\'m allergic to pets';

	/// tr: 'I have a cat'
	String get petsHaveCat => 'I have a cat';

	/// tr: 'I have a dog'
	String get petsHaveDog => 'I have a dog';

	/// tr: 'I have cats and dogs'
	String get petsHaveCatsAndDogs => 'I have cats and dogs';

	/// tr: 'I have other pets'
	String get petsHaveOther => 'I have other pets';

	/// tr: 'Drinking'
	String get drinking => 'Drinking';

	/// tr: 'On special occasions'
	String get drinkingValue => 'On special occasions';

	/// tr: 'Never'
	String get drinkingNever => 'Never';

	/// tr: 'On special occasions'
	String get drinkingSpecialOccasions => 'On special occasions';

	/// tr: 'Socially'
	String get drinkingSocially => 'Socially';

	/// tr: 'Frequently'
	String get drinkingFrequently => 'Frequently';

	/// tr: 'Sober'
	String get drinkingSober => 'Sober';

	/// tr: 'Prefer not to say'
	String get drinkingPreferNotToSay => 'Prefer not to say';

	/// tr: 'Smoking'
	String get smoking => 'Smoking';

	/// tr: 'Non-smoker'
	String get smokingValue => 'Non-smoker';

	/// tr: 'Non-smoker'
	String get smokingNonSmoker => 'Non-smoker';

	/// tr: 'Social smoker'
	String get smokingSocialSmoker => 'Social smoker';

	/// tr: 'Smoker'
	String get smokingSmoker => 'Smoker';

	/// tr: 'Trying to quit'
	String get smokingTryingToQuit => 'Trying to quit';

	/// tr: 'Smoker when drinking'
	String get smokingWhenDrinking => 'Smoker when drinking';

	/// tr: 'Prefer not to say'
	String get smokingPreferNotToSay => 'Prefer not to say';

	/// tr: 'Gender'
	String get gender => 'Gender';

	/// tr: 'Female'
	String get genderFemale => 'Female';

	/// tr: 'Male'
	String get genderMale => 'Male';

	/// tr: 'I don't want to mention it'
	String get genderPreferNotToSay => 'I don\'t want to mention it';

	/// tr: 'Visible'
	String get visible => 'Visible';

	/// tr: 'Profile Visibility'
	String get profileVisibility => 'Profile Visibility';

	/// tr: 'Language'
	String get language => 'Language';

	/// tr: 'Profile Border'
	String get borderTitle => 'Profile Border';

	/// tr: 'Profilinize çerçeve ekleyerek kendinizi öne çıkarabilirsiniz.'
	String get borderSubtitle => 'Profilinize çerçeve ekleyerek kendinizi öne\nçıkarabilirsiniz.';

	/// tr: 'Çerçeve satın al'
	String get borderBuySection => 'Çerçeve satın al';

	/// tr: 'Çerçeve Satın Al'
	String get borderBuyCta => 'Çerçeve Satın Al';

	/// tr: '{count} Token'
	String borderToken({required Object count}) => '${count} Token';

	/// tr: 'Amethyst Wings'
	String get borderAmethystWings => 'Amethyst Wings';

	/// tr: 'Golden Phoenix'
	String get borderGoldenPhoenix => 'Golden Phoenix';

	/// tr: 'Frost Crown'
	String get borderFrostCrown => 'Frost Crown';

	/// tr: 'Emerald Whisper'
	String get borderEmeraldWhisper => 'Emerald Whisper';

	/// tr: 'Rose Quartz'
	String get borderRoseQuartz => 'Rose Quartz';

	/// tr: 'Starlit Comet'
	String get borderStarlitComet => 'Starlit Comet';

	/// tr: 'Crimson Royal'
	String get borderCrimsonRoyal => 'Crimson Royal';

	/// tr: 'Sapphire Halo'
	String get borderSapphireHalo => 'Sapphire Halo';

	/// tr: 'Follow'
	String get follow => 'Follow';

	/// tr: 'Following'
	String get following => 'Following';

	/// tr: 'Follow'
	String get followPageTitle => 'Follow';

	/// tr: 'Takip'
	String get followTabFollowing => 'Takip';

	/// tr: 'Takipçi'
	String get followTabFollowers => 'Takipçi';

	/// tr: 'Search'
	String get followSearch => 'Search';

	/// tr: 'Unfollow'
	String get unfollow => 'Unfollow';

	/// tr: 'Sırala'
	String get followSortTitle => 'Sırala';

	/// tr: 'En son takip ettiğim kişiler'
	String get followSortRecent => 'En son takip ettiğim kişiler';

	/// tr: 'Beni takip etmeyenler'
	String get followSortNotFollowingMe => 'Beni takip etmeyenler';

	/// tr: 'Benim takip etmediklerim'
	String get followSortNotFollowedByMe => 'Benim takip etmediklerim';

	/// tr: 'Show Result'
	String get followSortShowResult => 'Show Result';

	/// tr: 'Bu filtreye uyan kimse yok'
	String get followSortEmpty => 'Bu filtreye uyan kimse yok';

	/// tr: 'Share with Friends'
	String get shareTitle => 'Share with Friends';

	/// tr: 'Everything is more fun when you connect with your friends!'
	String get shareSubtitle => 'Everything is more fun when you connect\nwith your friends!';

	/// tr: 'Share the profile'
	String get shareProfileLabel => 'Share the profile';

	/// tr: 'Link copied'
	String get shareLinkCopied => 'Link copied';

	/// tr: 'Restrict'
	String get restrict => 'Restrict';

	/// tr: 'Block'
	String get block => 'Block';

	/// tr: 'Report'
	String get report => 'Report';

	/// tr: 'Block {username} ?'
	String blockTitle({required Object username}) => 'Block ${username} ?';

	/// tr: 'This will also block any other accounts they may have or create in the future. You can unlock them anytime.'
	String get blockBody => 'This will also block any other accounts they may have or create in the future. You can unlock them anytime.';

	/// tr: 'Block and report'
	String get blockAndReport => 'Block and report';

	/// tr: 'Restrict {username} ?'
	String restrictTitle({required Object username}) => 'Restrict ${username} ?';

	/// tr: 'They won't be able to see when you're online or that you've read their messages. You can change this anytime.'
	String get restrictBody => 'They won\'t be able to see when you\'re online or that you\'ve read their messages. You can change this anytime.';

	/// tr: 'Restrict and report'
	String get restrictAndReport => 'Restrict and report';

	/// tr: 'Report sebebini merak ediyoruz'
	String get reportTitle => 'Report sebebini merak ediyoruz';

	/// tr: 'Sana daha iyi bir deneyim sunabilmek için kullanıcıyı neden report etmek istediğini açıklar mısın?'
	String get reportSubtitle => 'Sana daha iyi bir deneyim sunabilmek için kullanıcıyı neden report etmek istediğini açıklar mısın?';

	/// tr: 'Report Mesajı'
	String get reportMessageLabel => 'Report Mesajı';

	/// tr: 'Mesajınızı yazın'
	String get reportMessageHint => 'Mesajınızı yazın';

	/// tr: 'Cancel'
	String get reportCancel => 'Cancel';

	/// tr: 'Send Report'
	String get sendReport => 'Send Report';

	/// tr: 'Belirtilmedi'
	String get notSet => 'Belirtilmedi';

	/// tr: 'Teşekkürler, raporunu aldık.'
	String get reportSent => 'Teşekkürler, raporunu aldık.';

	/// tr: '{email} adresine onay bağlantısı gönderdik. Onaylayınca e-postan değişir.'
	String emailVerificationSent({required Object email}) => '${email} adresine onay bağlantısı gönderdik. Onaylayınca e-postan değişir.';

	/// tr: 'Şifren güncellendi.'
	String get passwordChanged => 'Şifren güncellendi.';

	/// tr: 'Şifreler eşleşmiyor.'
	String get passwordMismatch => 'Şifreler eşleşmiyor.';
}

// Path: nav
class Translations$nav$tr {
	Translations$nav$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: 'Discover'
	String get discover => 'Discover';

	/// tr: 'Chat'
	String get chat => 'Chat';

	/// tr: 'Call'
	String get call => 'Call';

	/// tr: 'Vibes'
	String get vibes => 'Vibes';

	/// tr: 'Profile'
	String get profile => 'Profile';
}

// Path: call
class Translations$call$tr {
	Translations$call$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: '60 Second Stranger'
	String get title => '60 Second Stranger';

	/// tr: 'Talk to a random stranger for 60 seconds — completely anonymous. No profile, no photo, no name. Just a voice and a moment.'
	String get subtitle => 'Talk to a random stranger for 60 seconds — completely anonymous. No profile, no photo, no name. Just a voice and a moment.';

	/// tr: 'Finding a stranger...'
	String get findingTitle => 'Finding a stranger...';

	/// tr: 'You'll talk anonymously for 60 seconds. No profile, no names.'
	String get findingSubtitle => 'You\'ll talk anonymously for 60 seconds. No profile, no names.';

	/// tr: 'Call Stranger - 10 Token'
	String get callStranger => 'Call Stranger - 10 Token';

	/// tr: 'Cancel'
	String get cancel => 'Cancel';

	/// tr: 'Female'
	String get female => 'Female';

	/// tr: 'Male'
	String get male => 'Male';

	/// tr: 'Non-binary'
	String get nonBinary => 'Non-binary';

	/// tr: 'Prefer not to say'
	String get preferNotToSay => 'Prefer not to say';

	/// tr: '🎙️ Anonymous voice call'
	String get anonymousBadge => '🎙️ Anonymous voice call';

	/// tr: 'Stranger'
	String get stranger => 'Stranger';

	/// tr: '{n}sn'
	String secondsLeft({required Object n}) => '${n}sn';

	/// tr: 'Time's up!'
	String get timesUpTitle => 'Time\'s up!';

	/// tr: 'Want to keep talking? If you both say yes, chat unlocks.'
	String get timesUpSubtitle => 'Want to keep talking? If you both say yes, chat unlocks.';

	/// tr: 'Keep Talking'
	String get keepTalking => 'Keep Talking';

	/// tr: 'End Call'
	String get endCall => 'End Call';

	/// tr: 'Waiting for the other person...'
	String get waitingOther => 'Waiting for the other person...';
}

// Path: vibes
class Translations$vibes$tr {
	Translations$vibes$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: 'Search'
	String get search => 'Search';

	/// tr: 'Mesaj Gönder'
	String get sendMessage => 'Mesaj Gönder';

	/// tr: 'Wants to talk about this right now'
	String get wantsToTalk => 'Wants to talk about this right now';

	/// tr: 'Vibe Paylaş'
	String get shareTitle => 'Vibe Paylaş';

	/// tr: 'Vibe'a Cevap Ver'
	String get replyTitle => 'Vibe\'a Cevap Ver';

	/// tr: 'Bir şeyler yaz'
	String get shareHint => 'Bir şeyler yaz';

	/// tr: 'Anonim olarak paylaş'
	String get shareAnonymous => 'Anonim olarak paylaş';

	/// tr: 'Son 24 saatte vibe yok. İlkini sen paylaş!'
	String get empty => 'Son 24 saatte vibe yok. İlkini sen paylaş!';

	/// tr: 'Bu vibe silinsin mi?'
	String get deleteTitle => 'Bu vibe silinsin mi?';

	/// tr: 'Sil'
	String get delete => 'Sil';

	/// tr: 'Vazgeç'
	String get cancel => 'Vazgeç';
}

// Path: discover
class Translations$discover$tr {
	Translations$discover$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: 'Discover'
	String get title => 'Discover';

	/// tr: 'Rooms'
	String get tabRooms => 'Rooms';

	/// tr: 'Discover'
	String get tabDiscover => 'Discover';

	/// tr: 'AI Match'
	String get tabAiMatch => 'AI Match';

	late final Translations$discover$aiMatch$tr aiMatch = Translations$discover$aiMatch$tr.internal(_root);

	/// tr: 'Search'
	String get searchHint => 'Search';

	/// tr: 'All Rooms'
	String get allRooms => 'All Rooms';

	/// tr: 'All Groups'
	String get allGroups => 'All Groups';

	/// tr: 'See All'
	String get seeAll => 'See All';

	/// tr: 'Live'
	String get live => 'Live';

	/// tr: 'Join'
	String get join => 'Join';

	/// tr: 'Request'
	String get request => 'Request';

	/// tr: 'Requested'
	String get requested => 'Requested';

	/// tr: 'Private'
	String get private => 'Private';

	/// tr: '+{count} more'
	String moreCount({required Object count}) => '+${count} more';

	/// tr: '{count} active'
	String activeCount({required Object count}) => '${count} active';

	/// tr: '{count} members'
	String membersCount({required Object count}) => '${count} members';

	late final Translations$discover$privateRoom$tr privateRoom = Translations$discover$privateRoom$tr.internal(_root);
	late final Translations$discover$roomToken$tr roomToken = Translations$discover$roomToken$tr.internal(_root);
	late final Translations$discover$privateRequest$tr privateRequest = Translations$discover$privateRequest$tr.internal(_root);
	late final Translations$discover$roomApproved$tr roomApproved = Translations$discover$roomApproved$tr.internal(_root);
	late final Translations$discover$createSpace$tr createSpace = Translations$discover$createSpace$tr.internal(_root);
	late final Translations$discover$liveRoom$tr liveRoom = Translations$discover$liveRoom$tr.internal(_root);
	late final Translations$discover$groupChat$tr groupChat = Translations$discover$groupChat$tr.internal(_root);
	late final Translations$discover$groupInfo$tr groupInfo = Translations$discover$groupInfo$tr.internal(_root);
	late final Translations$discover$filters$tr filters = Translations$discover$filters$tr.internal(_root);
	late final Translations$discover$post$tr post = Translations$discover$post$tr.internal(_root);
	late final Translations$discover$story$tr story = Translations$discover$story$tr.internal(_root);
	late final Translations$discover$highlight$tr highlight = Translations$discover$highlight$tr.internal(_root);
	late final Translations$discover$stats$tr stats = Translations$discover$stats$tr.internal(_root);
}

// Path: common
class Translations$common$tr {
	Translations$common$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: 'Yükleniyor…'
	String get loading => 'Yükleniyor…';

	/// tr: 'Tekrar dene'
	String get retry => 'Tekrar dene';

	/// tr: 'İptal'
	String get cancel => 'İptal';

	/// tr: 'Kaydet'
	String get save => 'Kaydet';

	/// tr: 'Devam et'
	String get continueAction => 'Devam et';

	/// tr: 'Dil'
	String get language => 'Dil';

	/// tr: 'VEYA'
	String get or => 'VEYA';
}

// Path: languages
class Translations$languages$tr {
	Translations$languages$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: 'Türkçe'
	String get tr => 'Türkçe';

	/// tr: 'English'
	String get en => 'English';
}

// Path: auth
class Translations$auth$tr {
	Translations$auth$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: 'Hesabını oluştur'
	String get createAccountTitle => 'Hesabını oluştur';

	/// tr: 'Veylo’ya katıl ve bağlantı kurmaya başla.'
	String get createAccountSubtitle => 'Veylo’ya katıl ve bağlantı kurmaya başla.';

	/// tr: 'Tekrar hoş geldin'
	String get welcomeBackTitle => 'Tekrar hoş geldin';

	/// tr: 'Veylo’ya devam etmek için giriş yap.'
	String get welcomeBackSubtitle => 'Veylo’ya devam etmek için giriş yap.';

	/// tr: 'Kullanıcı adı'
	String get username => 'Kullanıcı adı';

	/// tr: 'Bir kullanıcı adı seç'
	String get usernameHint => 'Bir kullanıcı adı seç';

	/// tr: 'E-posta'
	String get email => 'E-posta';

	/// tr: 'E-postanı gir'
	String get emailHint => 'E-postanı gir';

	/// tr: 'E-posta veya kullanıcı adı'
	String get emailOrUsername => 'E-posta veya kullanıcı adı';

	/// tr: 'E-posta veya kullanıcı adını gir'
	String get emailOrUsernameHint => 'E-posta veya kullanıcı adını gir';

	/// tr: 'Şifre'
	String get password => 'Şifre';

	/// tr: 'Bir şifre oluştur'
	String get passwordCreateHint => 'Bir şifre oluştur';

	/// tr: 'Şifreni gir'
	String get passwordEnterHint => 'Şifreni gir';

	/// tr: 'Kayıt ol'
	String get signUp => 'Kayıt ol';

	/// tr: 'Giriş yap'
	String get logIn => 'Giriş yap';

	/// tr: 'Şifremi unuttum?'
	String get forgotPassword => 'Şifremi unuttum?';

	/// tr: 'Apple ile devam et'
	String get continueWithApple => 'Apple ile devam et';

	/// tr: 'Google ile devam et'
	String get continueWithGoogle => 'Google ile devam et';

	/// tr: 'Devam ederek '
	String get legalPrefix => 'Devam ederek ';

	/// tr: 'Hizmet Şartları'
	String get termsOfService => 'Hizmet Şartları';

	/// tr: '’nı kabul etmiş ve '
	String get legalMiddle => '’nı kabul etmiş ve ';

	/// tr: 'Gizlilik Politikası'
	String get privacyPolicy => 'Gizlilik Politikası';

	/// tr: '’nı onaylamış olursun.'
	String get legalSuffix => '’nı onaylamış olursun.';

	/// tr: 'Şifre sıfırlama bağlantısını e-postana gönderdik.'
	String get passwordResetSent => 'Şifre sıfırlama bağlantısını e-postana gönderdik.';
}

// Path: onboarding
class Translations$onboarding$tr {
	Translations$onboarding$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: 'Atla'
	String get skip => 'Atla';

	/// tr: 'Kendin ol. Anonim kal.'
	String get page1Title => 'Kendin ol. Anonim kal.';

	/// tr: 'Kimliğini paylaşmadan yeni insanlarla tanış ve sohbet et.'
	String get page1Subtitle => 'Kimliğini paylaşmadan yeni insanlarla tanış ve sohbet et.';

	/// tr: 'Yaz. Konuş. Vibes’i hisset.'
	String get page2Title => 'Yaz. Konuş. Vibes’i hisset.';

	/// tr: 'Anonim başla; hazır olunca yaz, ara veya yüz yüze geç.'
	String get page2Subtitle => 'Anonim başla; hazır olunca yaz, ara veya yüz yüze geç.';

	/// tr: 'İnsanlarını bul. Sohbete katıl.'
	String get page3Title => 'İnsanlarını bul. Sohbete katıl.';

	/// tr: 'Yeni insanlarla odalara gir ve anı birlikte paylaş.'
	String get page3Subtitle => 'Yeni insanlarla odalara gir ve anı birlikte paylaş.';

	/// tr: 'Başla'
	String get getStarted => 'Başla';

	/// tr: 'Zaten Veylo hesabın var mı? '
	String get alreadyHaveAccount => 'Zaten Veylo hesabın var mı? ';

	/// tr: 'Giriş yap'
	String get logInAction => 'Giriş yap';
}

// Path: createProfile
class Translations$createProfile$tr {
	Translations$createProfile$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: 'Profil oluştur'
	String get navTitle => 'Profil oluştur';

	/// tr: '1/5 Kullanıcı adı'
	String get stepUsername => '1/5 Kullanıcı adı';

	/// tr: 'Profilini oluştur'
	String get title => 'Profilini oluştur';

	/// tr: 'Gerçek adın yalnızca doğrulama için kullanılır — herkese açık görünmez.'
	String get subtitle => 'Gerçek adın yalnızca doğrulama için kullanılır — herkese açık görünmez.';

	/// tr: 'Gerçek adın yalnızca doğrulama için kullanılır —'
	String get subtitleLine1 => 'Gerçek adın yalnızca doğrulama için kullanılır —';

	/// tr: 'herkese açık görünmez.'
	String get subtitleLine2 => 'herkese açık görünmez.';

	/// tr: 'Ad soyad'
	String get fullName => 'Ad soyad';

	/// tr: 'Sam Lee'
	String get fullNameHint => 'Sam Lee';

	/// tr: 'Kullanıcı adı'
	String get username => 'Kullanıcı adı';

	/// tr: 'samlee123'
	String get usernameHint => 'samlee123';

	/// tr: 'Bu kullanıcı adı zaten alınmış!'
	String get usernameTaken => 'Bu kullanıcı adı zaten alınmış!';

	/// tr: 'Kullanıcı adı müsait'
	String get usernameAvailable => 'Kullanıcı adı müsait';

	/// tr: 'Şunları deneyebilirsin…'
	String get mightWantToTry => 'Şunları deneyebilirsin…';

	/// tr: '2/5 Profil fotoğrafı'
	String get stepPhoto => '2/5 Profil fotoğrafı';

	/// tr: 'Profil fotoğrafı yükle'
	String get photoTitle => 'Profil fotoğrafı yükle';

	/// tr: 'Diğer kullanıcılar senin olduğunu doğrulamak için profil fotoğrafını görebilir.'
	String get photoSubtitle => 'Diğer kullanıcılar senin olduğunu doğrulamak için profil fotoğrafını görebilir.';

	/// tr: 'Diğer kullanıcılar senin olduğunu doğrulamak için'
	String get photoSubtitleLine1 => 'Diğer kullanıcılar senin olduğunu doğrulamak için';

	/// tr: 'profil fotoğrafını görebilir.'
	String get photoSubtitleLine2 => 'profil fotoğrafını görebilir.';

	/// tr: 'Fotoğraf seç'
	String get choosePhoto => 'Fotoğraf seç';

	/// tr: 'Fotoğrafsız devam et'
	String get continueWithoutPhoto => 'Fotoğrafsız devam et';

	/// tr: 'Kaydet ve devam et'
	String get saveAndContinue => 'Kaydet ve devam et';

	/// tr: 'Fotoğraf seç'
	String get choosePhotoSheetTitle => 'Fotoğraf seç';

	/// tr: 'Fotoğraf çek'
	String get takePhoto => 'Fotoğraf çek';

	/// tr: 'Galeriden seç'
	String get chooseFromGallery => 'Galeriden seç';

	/// tr: '3/5 Cinsiyet'
	String get stepGender => '3/5 Cinsiyet';

	/// tr: 'Cinsiyetini seç'
	String get genderTitle => 'Cinsiyetini seç';

	/// tr: 'Bu bilgiyi paylaşırsan, içeriği sana göre kişiselleştirmek için kullanabiliriz.'
	String get genderSubtitle => 'Bu bilgiyi paylaşırsan, içeriği sana göre kişiselleştirmek için kullanabiliriz.';

	/// tr: 'Bu bilgiyi paylaşırsan, içeriği sana göre'
	String get genderSubtitleLine1 => 'Bu bilgiyi paylaşırsan, içeriği sana göre';

	/// tr: 'kişiselleştirmek için kullanabiliriz.'
	String get genderSubtitleLine2 => 'kişiselleştirmek için kullanabiliriz.';

	/// tr: 'Kadın'
	String get genderFemale => 'Kadın';

	/// tr: 'Erkek'
	String get genderMale => 'Erkek';

	/// tr: 'Non-binary'
	String get genderNonBinary => 'Non-binary';

	/// tr: 'Belirtmek istemiyorum'
	String get genderPreferNotToSay => 'Belirtmek istemiyorum';

	/// tr: '4/5 İlgi alanları'
	String get stepInterests => '4/5 İlgi alanları';

	/// tr: 'Nelerden hoşlanırsın?'
	String get interestsTitle => 'Nelerden hoşlanırsın?';

	/// tr: 'En az 5 seç — seni gerçekten anlayan insanlarla eşleşmene yardımcı olur.'
	String get interestsSubtitle => 'En az 5 seç — seni gerçekten anlayan insanlarla eşleşmene yardımcı olur.';

	late final Translations$createProfile$interests$tr interests = Translations$createProfile$interests$tr.internal(_root);

	/// tr: '5/5 Sohbet hedefi'
	String get stepChatGoal => '5/5 Sohbet hedefi';

	/// tr: 'Bugün ne arıyorsun?'
	String get chatGoalTitle => 'Bugün ne arıyorsun?';

	/// tr: 'Bu, şu anki ruh haline uygun eşleşmeyi bulmamıza yardımcı olur.'
	String get chatGoalSubtitle => 'Bu, şu anki ruh haline uygun eşleşmeyi bulmamıza yardımcı olur.';

	/// tr: 'Hızlı eşleşme — doğrudan sohbete gir'
	String get chatGoalQuickMatch => 'Hızlı eşleşme — doğrudan sohbete gir';

	/// tr: 'Flört sohbeti — hafif, eğlenceli muhabbet'
	String get chatGoalFlirtyChat => 'Flört sohbeti — hafif, eğlenceli muhabbet';

	/// tr: 'Ruh hali eşleşmesi — nasıl hissettiğine göre'
	String get chatGoalMoodMatch => 'Ruh hali eşleşmesi — nasıl hissettiğine göre';

	/// tr: 'Gece sohbeti — dünya uyurken derin konuşmalar'
	String get chatGoalLateNight => 'Gece sohbeti — dünya uyurken derin konuşmalar';

	/// tr: 'Yeni biriyle tanış — özel hedef yok, keşfet'
	String get chatGoalMeetSomeoneNew => 'Yeni biriyle tanış — özel hedef yok, keşfet';

	/// tr: 'Başla'
	String get getStarted => 'Başla';

	/// tr: 'Sana uygun'
	String get preparingTitleLine1 => 'Sana uygun';

	/// tr: 'profilleri'
	String get preparingTitleLine2 => 'profilleri';

	/// tr: 'hazırlıyoruz.'
	String get preparingTitleLine3 => 'hazırlıyoruz.';

	/// tr: 'Cevaplarına göre en iyi eşleşmeleri'
	String get preparingSubtitleLine1 => 'Cevaplarına göre en iyi eşleşmeleri';

	/// tr: 'seçiyoruz—lütfen bir an bekle.'
	String get preparingSubtitleLine2 => 'seçiyoruz—lütfen bir an bekle.';

	/// tr: '%{percent}'
	String preparingPercent({required Object percent}) => '%${percent}';

	/// tr: '3–30 karakter: harf, rakam, nokta veya alt çizgi kullan.'
	String get usernameInvalid => '3–30 karakter: harf, rakam, nokta veya alt çizgi kullan.';
}

// Path: errors
class Translations$errors$tr {
	Translations$errors$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: 'Veylo’ya ulaşılamadı. Bağlantını kontrol edip tekrar dene.'
	String get network => 'Veylo’ya ulaşılamadı. Bağlantını kontrol edip tekrar dene.';

	/// tr: 'Bir şeyler ters gitti. Lütfen tekrar dene.'
	String get generic => 'Bir şeyler ters gitti. Lütfen tekrar dene.';

	/// tr: 'Giriş yapılamadı. Lütfen tekrar dene.'
	String get signInFailed => 'Giriş yapılamadı. Lütfen tekrar dene.';

	/// tr: 'Oturumun sona erdi. Lütfen tekrar giriş yap.'
	String get sessionExpired => 'Oturumun sona erdi. Lütfen tekrar giriş yap.';

	/// tr: 'Bu hesap askıya alındı.'
	String get accountSuspended => 'Bu hesap askıya alındı.';

	/// tr: 'Lütfen JPEG, PNG veya WebP bir fotoğraf seç.'
	String get unsupportedImage => 'Lütfen JPEG, PNG veya WebP bir fotoğraf seç.';

	/// tr: 'Bu dosya çok büyük.'
	String get fileTooLarge => 'Bu dosya çok büyük.';

	/// tr: 'Şifreni sıfırlamak için yukarıya e-postanı yaz.'
	String get enterEmailForReset => 'Şifreni sıfırlamak için yukarıya e-postanı yaz.';

	/// tr: 'E-posta/kullanıcı adı veya şifre hatalı.'
	String get wrongCredentials => 'E-posta/kullanıcı adı veya şifre hatalı.';

	/// tr: 'Bu e-posta zaten kayıtlı. Giriş yapmayı dene.'
	String get emailInUse => 'Bu e-posta zaten kayıtlı. Giriş yapmayı dene.';

	/// tr: 'Şifre en az 6 karakter olmalı.'
	String get weakPassword => 'Şifre en az 6 karakter olmalı.';

	/// tr: 'Lütfen geçerli bir e-posta adresi gir.'
	String get invalidEmail => 'Lütfen geçerli bir e-posta adresi gir.';

	/// tr: 'Çok fazla deneme yapıldı. Biraz bekleyip tekrar dene.'
	String get tooManyAttempts => 'Çok fazla deneme yapıldı. Biraz bekleyip tekrar dene.';

	/// tr: 'Lütfen tüm alanları doldur.'
	String get fillAllFields => 'Lütfen tüm alanları doldur.';

	/// tr: 'Yeterli token yok.'
	String get insufficientTokens => 'Yeterli token yok.';

	/// tr: 'Cevap vermek için isteği onayla.'
	String get requestNotAccepted => 'Cevap vermek için isteği onayla.';

	/// tr: 'İsteğini kabul ettiğinde daha fazla mesaj gönderebilirsin.'
	String get requestPendingLimit => 'İsteğini kabul ettiğinde daha fazla mesaj gönderebilirsin.';

	/// tr: 'Bu kişiye mesaj gönderemezsin.'
	String get blocked => 'Bu kişiye mesaj gönderemezsin.';

	/// tr: 'Bu hesap artık kullanılamıyor.'
	String get peerUnavailable => 'Bu hesap artık kullanılamıyor.';

	/// tr: 'Bugün çok vibe paylaştın. Biraz sonra tekrar dene.'
	String get vibeDailyLimit => 'Bugün çok vibe paylaştın. Biraz sonra tekrar dene.';

	/// tr: 'Bu grup dolu.'
	String get groupFull => 'Bu grup dolu.';

	/// tr: 'Bugün çok grup oluşturdun. Biraz sonra tekrar dene.'
	String get groupCreateLimit => 'Bugün çok grup oluşturdun. Biraz sonra tekrar dene.';

	/// tr: 'Bu artık mevcut değil.'
	String get notFound => 'Bu artık mevcut değil.';

	/// tr: 'Güvenliğin için çıkış yapıp tekrar giriş yap, sonra yeniden dene.'
	String get recentLogin => 'Güvenliğin için çıkış yapıp tekrar giriş yap, sonra yeniden dene.';

	/// tr: 'E-posta ve şifren Google ya da Apple hesabın tarafından yönetiliyor.'
	String get socialAccount => 'E-posta ve şifren Google ya da Apple hesabın tarafından yönetiliyor.';
}

// Path: discover.aiMatch
class Translations$discover$aiMatch$tr {
	Translations$discover$aiMatch$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: 'Bugün nasıl hissediyorsun'
	String get feelingTitle => 'Bugün nasıl hissediyorsun';

	/// tr: 'AI, seçimine göre en iyi eşleşmeyi bulur'
	String get feelingSubtitle => 'AI, seçimine göre en iyi eşleşmeyi bulur';

	/// tr: 'Ne arıyorsun?'
	String get lookingTitle => 'Ne arıyorsun?';

	/// tr: 'Üzgün'
	String get moodSad => 'Üzgün';

	/// tr: 'Bitkin'
	String get moodMeltie => 'Bitkin';

	/// tr: 'Sıkılmış'
	String get moodBored => 'Sıkılmış';

	/// tr: 'Kötü'
	String get moodCrying => 'Kötü';

	/// tr: 'Mutlu'
	String get moodSmile => 'Mutlu';

	/// tr: 'Yeni arkadaşlar'
	String get lookingNewFriends => 'Yeni arkadaşlar';

	/// tr: 'Dertleşme'
	String get lookingVenting => 'Dertleşme';

	/// tr: 'Flört sohbeti'
	String get lookingFlirty => 'Flört sohbeti';

	/// tr: 'Eğlence'
	String get lookingFun => 'Eğlence';

	/// tr: 'Yeni kültürler'
	String get lookingCultures => 'Yeni kültürler';

	/// tr: 'Dil pratiği'
	String get lookingLanguage => 'Dil pratiği';

	/// tr: 'Aktif kullanıcı'
	String get statActiveUsers => 'Aktif kullanıcı';

	/// tr: 'Eşleşme oranı'
	String get statMatchRate => 'Eşleşme oranı';

	/// tr: 'Ort. süre'
	String get statAvgTime => 'Ort. süre';

	/// tr: '843'
	String get statActiveValue => '843';

	/// tr: '87%'
	String get statMatchValue => '87%';

	/// tr: '8s'
	String get statAvgValue => '8s';

	/// tr: 'Start Smart Match'
	String get startSmartMatch => 'Start Smart Match';

	/// tr: 'Finding your match'
	String get findingTitle => 'Finding your match';

	/// tr: 'Matching your mood and interests with the right person'
	String get findingSubtitle => 'Matching your mood and interests with the right person';

	/// tr: 'Mood analyzed'
	String get findingStepMood => 'Mood analyzed';

	/// tr: 'Interests matched'
	String get findingStepInterests => 'Interests matched';

	/// tr: 'Calculating compatibility...'
	String get findingStepCompatibility => 'Calculating compatibility...';

	/// tr: 'Content is being created...'
	String get findingStepContent => 'Content is being created...';

	/// tr: '{count} people online right now'
	String findingOnline({required Object count}) => '${count} people online right now';

	/// tr: 'Your Match'
	String get yourMatchTitle => 'Your Match';

	/// tr: 'You have been matched based on your answers'
	String get yourMatchSubtitle => 'You have been matched based on your answers';

	/// tr: '{percent}% Vibe match'
	String vibeMatch({required Object percent}) => '${percent}% Vibe match';

	/// tr: 'Start Chatting'
	String get startChatting => 'Start Chatting';

	/// tr: '{name}, {age}'
	String matchNameAge({required Object name, required Object age}) => '${name}, ${age}';

	/// tr: 'I'll make you feel things you didn't know you could feel.'
	String get matchBio => 'I\'ll make you feel things you didn\'t know you could feel.';

	/// tr: 'Previous'
	String get swipePrevious => 'Previous';

	/// tr: 'Next'
	String get swipeNext => 'Next';

	/// tr: 'Swipe Finger'
	String get swipeFinger => 'Swipe Finger';

	/// tr: 'Şu an uygun kimse yok. Biraz sonra tekrar dene.'
	String get noMatch => 'Şu an uygun kimse yok. Biraz sonra tekrar dene.';
}

// Path: discover.privateRoom
class Translations$discover$privateRoom$tr {
	Translations$discover$privateRoom$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: 'This is a private room. Unlock access with tokens.'
	String get subtitle => 'This is a private room. Unlock access with tokens.';

	/// tr: 'Room access'
	String get roomAccess => 'Room access';

	/// tr: 'Your balance'
	String get yourBalance => 'Your balance';

	/// tr: '{count} tokens'
	String tokensAmount({required Object count}) => '${count} tokens';

	/// tr: 'Join for {count} tokens'
	String joinForTokens({required Object count}) => 'Join for ${count} tokens';

	/// tr: 'Cancel'
	String get cancel => 'Cancel';
}

// Path: discover.roomToken
class Translations$discover$roomToken$tr {
	Translations$discover$roomToken$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: 'Unlock access with tokens.'
	String get subtitle => 'Unlock access with tokens.';

	/// tr: 'Room access'
	String get roomAccess => 'Room access';

	/// tr: 'Your balance'
	String get yourBalance => 'Your balance';

	/// tr: '{count} tokens'
	String tokensAmount({required Object count}) => '${count} tokens';

	/// tr: 'Join for {count} tokens'
	String joinForTokens({required Object count}) => 'Join for ${count} tokens';

	/// tr: 'Cancel'
	String get cancel => 'Cancel';
}

// Path: discover.privateRequest
class Translations$discover$privateRequest$tr {
	Translations$discover$privateRequest$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: 'Request to join'
	String get title => 'Request to join';

	/// tr: '{name} · {count} members'
	String roomInfo({required Object name, required Object count}) => '${name} · ${count} members';

	/// tr: 'Say something (optional)...'
	String get messageHint => 'Say something (optional)...';

	/// tr: 'Send Request'
	String get sendRequest => 'Send Request';

	/// tr: 'The room admin will review your request'
	String get adminReview => 'The room admin will review your request';
}

// Path: discover.roomApproved
class Translations$discover$roomApproved$tr {
	Translations$discover$roomApproved$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: 'You're in!'
	String get title => 'You\'re in!';

	/// tr: 'Your spot in {name} is reserved'
	String subtitle({required Object name}) => 'Your spot in ${name} is reserved';

	/// tr: 'Continue'
	String get continueLabel => 'Continue';
}

// Path: discover.createSpace
class Translations$discover$createSpace$tr {
	Translations$discover$createSpace$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: 'Create Room or Group'
	String get title => 'Create Room or Group';

	/// tr: 'Grup veya canlı oda oluşturarak kitlelere hitap et'
	String get subtitle => 'Grup veya canlı oda oluşturarak kitlelere hitap et';

	/// tr: 'Room'
	String get room => 'Room';

	/// tr: 'Group'
	String get group => 'Group';

	/// tr: 'Hide Your Account'
	String get hideAccount => 'Hide Your Account';

	/// tr: 'Create'
	String get create => 'Create';

	/// tr: 'Cancel'
	String get cancel => 'Cancel';

	/// tr: 'Create Room'
	String get createRoomTitle => 'Create Room';

	/// tr: 'Create Group'
	String get createGroupTitle => 'Create Group';

	/// tr: 'Give the group you created a name'
	String get nameSubtitle => 'Give the group you created a name';

	/// tr: 'Night Owl'
	String get nameHint => 'Night Owl';
}

// Path: discover.liveRoom
class Translations$discover$liveRoom$tr {
	Translations$discover$liveRoom$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: '(Admin)'
	String get adminSuffix => '(Admin)';

	/// tr: 'Mesaj'
	String get messageHint => 'Mesaj';

	/// tr: 'Herkese merhaba!'
	String get quickReplyHey => 'Herkese merhaba!';

	/// tr: 'Konu ne?'
	String get quickReplyTopic => 'Konu ne?';

	/// tr: 'Ben yeniyim!'
	String get quickReplyNew => 'Ben yeniyim!';

	/// tr: 'Sona'
	String get sampleChatName => 'Sona';

	/// tr: 'Ne yapabiliriz? Aklında ne var?'
	String get sampleChatBody => 'Ne yapabiliriz? Aklında ne var?';
}

// Path: discover.groupChat
class Translations$discover$groupChat$tr {
	Translations$discover$groupChat$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: '{count} Kullanıcı'
	String usersCount({required Object count}) => '${count} Kullanıcı';

	/// tr: 'Çok sıkıldım. Bir şeyler yapalım mı?'
	String get sampleVictoria => 'Çok sıkıldım. Bir şeyler yapalım mı?';

	/// tr: 'Ne yapabiliriz? Aklında ne var?'
	String get sampleSona => 'Ne yapabiliriz? Aklında ne var?';

	/// tr: 'İskelede buluşalım'
	String get sampleOwn => 'İskelede buluşalım';
}

// Path: discover.groupInfo
class Translations$discover$groupInfo$tr {
	Translations$discover$groupInfo$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: 'Medya'
	String get media => 'Medya';

	/// tr: 'Galeri'
	String get gallery => 'Galeri';

	/// tr: 'Ayarlar'
	String get settings => 'Ayarlar';

	/// tr: 'Bildirimler'
	String get notifications => 'Bildirimler';

	/// tr: 'Engellenenler'
	String get blocked => 'Engellenenler';

	/// tr: 'Gizli'
	String get private => 'Gizli';

	/// tr: '{count} üye'
	String membersCount({required Object count}) => '${count} üye';

	/// tr: 'Kişi Ekle'
	String get addPeople => 'Kişi Ekle';

	/// tr: 'Sen'
	String get you => 'Sen';

	/// tr: 'Admin'
	String get admin => 'Admin';

	/// tr: 'Gruptan ayrıl'
	String get leaveGroup => 'Gruptan ayrıl';

	/// tr: 'Katılma istekleri'
	String get requests => 'Katılma istekleri';

	/// tr: 'Onayla'
	String get approve => 'Onayla';

	/// tr: 'Reddet'
	String get reject => 'Reddet';

	/// tr: 'Gruba eklemek için önce birilerini takip et.'
	String get addPeopleEmpty => 'Gruba eklemek için önce birilerini takip et.';

	/// tr: 'Ekle'
	String get add => 'Ekle';

	/// tr: 'Yönetici yap'
	String get makeAdmin => 'Yönetici yap';

	/// tr: 'Yöneticilikten al'
	String get removeAdmin => 'Yöneticilikten al';

	/// tr: 'Gruptan çıkar'
	String get remove => 'Gruptan çıkar';

	/// tr: 'Bu gruptan ayrılmak istiyor musun?'
	String get leaveConfirm => 'Bu gruptan ayrılmak istiyor musun?';

	/// tr: 'Ayrıl'
	String get leave => 'Ayrıl';

	/// tr: 'Vazgeç'
	String get cancel => 'Vazgeç';
}

// Path: discover.filters
class Translations$discover$filters$tr {
	Translations$discover$filters$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: 'Filters'
	String get title => 'Filters';

	/// tr: 'Yaş aralığı'
	String get ageRange => 'Yaş aralığı';

	/// tr: '{min}-{max}'
	String ageRangeValue({required Object min, required Object max}) => '${min}-${max}';

	/// tr: 'Mesafe'
	String get distance => 'Mesafe';

	/// tr: '{km} km'
	String distanceValue({required Object km}) => '${km} km';

	/// tr: 'Göster'
	String get showMe => 'Göster';

	/// tr: 'Herkes'
	String get everyone => 'Herkes';

	/// tr: 'Kadınlar'
	String get women => 'Kadınlar';

	/// tr: 'Erkekler'
	String get men => 'Erkekler';

	/// tr: 'İlgi alanları'
	String get interests => 'İlgi alanları';

	/// tr: 'Şu an aktif'
	String get activeNow => 'Şu an aktif';

	/// tr: 'Yalnızca şu an çevrimiçi olanları göster'
	String get activeNowSubtitle => 'Yalnızca şu an çevrimiçi olanları göster';

	/// tr: 'Sonuçları göster'
	String get showResult => 'Sonuçları göster';
}

// Path: discover.post
class Translations$discover$post$tr {
	Translations$discover$post$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: 'Takip Et'
	String get follow => 'Takip Et';

	/// tr: 'Takipte'
	String get following => 'Takipte';

	/// tr: 'Yorum ekle...'
	String get addComment => 'Yorum ekle...';

	/// tr: 'Yorumlar'
	String get commentsTitle => 'Yorumlar';

	/// tr: 'There's nothing quite like having a cup of coffee after a beautiful day. <3'
	String get sampleCaption => 'There\'s nothing quite like having a cup of coffee after a beautiful day. <3';

	/// tr: '{hours}s'
	String hoursAgo({required Object hours}) => '${hours}s';

	/// tr: '{minutes}dk'
	String minutesAgo({required Object minutes}) => '${minutes}dk';

	/// tr: '{days}g'
	String daysAgo({required Object days}) => '${days}g';

	/// tr: 'Bu yorum silinsin mi?'
	String get deleteCommentTitle => 'Bu yorum silinsin mi?';
}

// Path: discover.story
class Translations$discover$story$tr {
	Translations$discover$story$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: 'DRAFT'
	String get draft => 'DRAFT';

	/// tr: 'STORY'
	String get story => 'STORY';

	/// tr: 'Paylaş'
	String get share => 'Paylaş';

	/// tr: 'Bir şeyler yaz...'
	String get textPlaceholder => 'Bir şeyler yaz...';

	/// tr: 'Taslak olarak kaydedilsin mi?'
	String get draftPrompt => 'Taslak olarak kaydedilsin mi?';

	/// tr: 'Save to Draft'
	String get saveToDraft => 'Save to Draft';

	/// tr: 'Move to Trash'
	String get moveToTrash => 'Move to Trash';

	/// tr: 'Save'
	String get save => 'Save';

	/// tr: 'Müzik'
	String get musicTitle => 'Müzik';

	/// tr: 'Müzik bulunamadı.'
	String get musicEmpty => 'Müzik bulunamadı.';

	/// tr: 'Müzikler yüklenemedi.'
	String get musicError => 'Müzikler yüklenemedi.';

	/// tr: 'Galeriye kaydedildi'
	String get downloaded => 'Galeriye kaydedildi';

	/// tr: 'Kaydedilemedi'
	String get downloadFailed => 'Kaydedilemedi';
}

// Path: discover.highlight
class Translations$discover$highlight$tr {
	Translations$discover$highlight$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: 'Highlight'
	String get title => 'Highlight';

	/// tr: 'Görüntüle'
	String get view => 'Görüntüle';

	/// tr: 'AI yorumlar'
	String get aiComments => 'AI yorumlar';

	/// tr: 'Highlight’ı kaldır'
	String get remove => 'Highlight’ı kaldır';

	/// tr: 'Gönderin başarıyla paylaşıldı'
	String get sharedSuccess => 'Gönderin başarıyla paylaşıldı';

	/// tr: 'Öne Çıkar'
	String get boost => 'Öne Çıkar';
}

// Path: discover.stats
class Translations$discover$stats$tr {
	Translations$discover$stats$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: 'İstatistik'
	String get title => 'İstatistik';

	/// tr: 'Gönderinle alakalı istatistikler aşağıdadır.'
	String get subtitle => 'Gönderinle alakalı istatistikler\naşağıdadır.';

	/// tr: 'Görüntüleyenler'
	String get viewers => 'Görüntüleyenler';

	/// tr: 'Yorum'
	String get comments => 'Yorum';

	/// tr: 'Beğeni'
	String get likes => 'Beğeni';

	/// tr: '1 gün boyunca öne çıkar - 100 token'
	String get boostCta => '1 gün boyunca öne çıkar - 100 token';

	/// tr: 'Öne çıkarıldı! Gönderin 24 saat boyunca en üstte.'
	String get boosted => 'Öne çıkarıldı! Gönderin 24 saat boyunca en üstte.';
}

// Path: createProfile.interests
class Translations$createProfile$interests$tr {
	Translations$createProfile$interests$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: 'Müzik'
	String get music => 'Müzik';

	/// tr: 'Film'
	String get movies => 'Film';

	/// tr: 'Dizi'
	String get tvShows => 'Dizi';

	/// tr: 'Okuma'
	String get reading => 'Okuma';

	/// tr: 'Resim'
	String get painting => 'Resim';

	/// tr: 'Fotoğraf'
	String get photography => 'Fotoğraf';

	/// tr: 'Tiyatro'
	String get theatre => 'Tiyatro';

	/// tr: 'Fitness'
	String get fitness => 'Fitness';

	/// tr: 'Yüzme'
	String get swimming => 'Yüzme';

	/// tr: 'Futbol'
	String get football => 'Futbol';

	/// tr: 'Basketbol'
	String get basketball => 'Basketbol';

	/// tr: 'Kahve'
	String get coffee => 'Kahve';

	/// tr: 'Seyahat'
	String get travel => 'Seyahat';

	/// tr: 'Kamp'
	String get camping => 'Kamp';

	/// tr: 'Meditasyon'
	String get meditation => 'Meditasyon';

	/// tr: 'Video oyunları'
	String get videoGames => 'Video oyunları';

	/// tr: 'Kutu oyunları'
	String get boardGames => 'Kutu oyunları';

	/// tr: 'Stand-up'
	String get standUp => 'Stand-up';

	/// tr: 'Teknoloji'
	String get tech => 'Teknoloji';

	/// tr: 'Kodlama'
	String get coding => 'Kodlama';

	/// tr: 'YZ'
	String get ai => 'YZ';

	/// tr: 'Podcast'
	String get podcast => 'Podcast';
}

/// The flat map containing all translations for locale <tr>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.name' => 'Veylo',
			'app.tagline' => 'Hoş geldiniz',
			'home.title' => 'Ana Sayfa',
			'home.subtitle' => 'Uygulama hazırlanıyor',
			'home.body' => 'Çok dilli arayüz slang ile yönetiliyor.',
			'chats.title' => 'Chats',
			'chats.search' => 'Search',
			'chats.messagesSection' => 'Messages',
			'chats.request' => 'Request',
			'chats.emptyRequestTitle' => 'Son mesaj bildirimi yok',
			'chats.emptyRequestSubtitle' => '30 günden eski istekler gösterilmez.',
			'chats.noteAdd' => 'Not Ekle',
			'chats.anonymous' => 'Anonymous',
			'chats.online' => 'online',
			'chats.offline' => 'offline',
			'chats.connection' => 'Connection',
			'chats.connectionPercent' => ({required Object n}) => '${n}%',
			'chats.connectionProgressTitle' => 'Connection Progress',
			'chats.milestoneInitial' => 'First name initial',
			'chats.milestoneInitialHint' => 'Unlocked at 25%',
			'chats.milestoneInitialLocked' => 'Unlocks at 25%',
			'chats.milestonePhoto' => 'Blurred photo preview',
			'chats.milestonePhotoHint' => 'Unlocks at 70%',
			'chats.milestoneFull' => 'Full profile review',
			'chats.milestoneFullHint' => 'Mutual consent at 100%',
			'chats.sampleAnonymousMessage' => 'Hello, it was a pleasure meeting you. Could you tell me a little about yourself?',
			'chats.strangerSampleMessage' => 'Hello Jhon, it was a pleasure meeting you. Could you tell me a little about yourself?',
			'chats.approve' => 'Onayla',
			'chats.blockUser' => 'Engelle',
			'chats.reject' => 'Reddet',
			'chats.messageHint' => 'Hi! how are you?',
			'chats.revealTitle' => 'You\'ve reached 100%',
			'chats.revealSubtitle' => 'Reveal your full profiles to each other? Both sides must agree.',
			'chats.revealWaiting' => ({required Object name}) => 'Waiting for ${name} to accept',
			'chats.revealCta' => 'Reveal my profile',
			'chats.revealNotYet' => 'Not Yet',
			'chats.seen' => 'Görüldü',
			'chats.typing' => 'yazıyor…',
			'chats.noteYou' => 'Sen',
			'chats.noteSheetTitle' => 'Not paylaş',
			'chats.noteSheetSubtitle' => 'Notun 24 saat görünür',
			'chats.noteHint' => 'Aklında ne var?',
			'chats.noteShare' => 'Paylaş',
			'chats.noteDelete' => 'Notu sil',
			'profile.eyebrow' => 'Profile',
			'profile.title' => 'Settings',
			'profile.editProfile' => 'Edit Profile',
			'profile.statLike' => 'Like',
			'profile.statFollow' => 'Follow',
			'profile.statFollower' => 'Follower',
			'profile.promoTitle' => 'Get More Messages!',
			'profile.promoSubtitle' => 'Stand out, appear at the top of the list',
			'profile.standOut' => 'Stand Out',
			'profile.tabPosts' => 'Gönderi',
			'profile.tabVideo' => 'Video',
			'profile.tabSaved' => 'Kaydedilenler',
			'profile.save' => 'Save',
			'profile.changePhoto' => 'Change Photo',
			'profile.changeBorder' => 'Change Border',
			'profile.interest' => 'Interest',
			'profile.name' => 'Name',
			'profile.changeName' => 'İsim Değiştir',
			'profile.changePassword' => 'Şifre Değiştir',
			'profile.confirmPassword' => 'Şifreyi Onayla',
			'profile.email' => 'E-posta',
			'profile.accountManagement' => 'Hesap Yönetimi',
			'profile.settingsAbout' => 'Hakkında',
			'profile.settingsAccount' => 'Account Settings',
			'profile.settingsSupport' => 'Destek',
			'profile.shareApp' => 'Uygulamayı Paylaş',
			'profile.shareAppTitle' => 'Arkadaşlarınla Paylaş',
			'profile.shareAppSubtitle' => 'Veylo’yu arkadaşlarınla paylaş, birlikte keşfedin!',
			'profile.shareAppLabel' => 'Uygulama bağlantısı',
			'profile.rateApp' => 'Bizi Beğendin mi? Puan Ver',
			'profile.notifications' => 'Notifications',
			'profile.password' => 'Password',
			'profile.deleteConversation' => 'Sohbetleri Sil',
			'profile.faqHelp' => 'SSS ve Yardım',
			'profile.restorePurchases' => 'Satın Alımları Geri Yükle',
			'profile.termsOfService' => 'Hizmet Şartları',
			'profile.privacyPolicy' => 'Gizlilik Politikası',
			'profile.restorePurchasesDone' => 'Satın alımlar kontrol edildi',
			'profile.conversationsDeleted' => 'Tüm sohbetler silindi',
			'profile.logOut' => 'Log Out',
			'profile.deleteAccountAndData' => 'Delete Account and Data',
			'profile.passwordPlaceholder' => '********',
			'profile.height' => 'Height',
			'profile.addHeight' => 'Add Height',
			'profile.heightCm' => ({required Object value}) => '${value} cm',
			'profile.languages' => 'Languages',
			'profile.relationshipGoals' => 'Relationship Goals',
			'profile.lookingFor' => 'Looking for',
			'profile.newFriends' => '👋 New Friends',
			'profile.goalLongTermOpenToShort' => '💕 Long-term, Open to Short',
			'profile.goalLongTermRelationship' => '💘 Long-term Relationship',
			'profile.goalNewFriends' => '👋 New friends',
			'profile.goalShortTermFun' => '🥃 Short-term Fun',
			'profile.goalStillFiguringItOut' => '🤔 Still Figuring It Out',
			'profile.basics' => 'Basics',
			'profile.zodiac' => 'Zodiac',
			'profile.zodiacValue' => 'Scorpion',
			'profile.education' => 'Education',
			'profile.educationValue' => 'Bachelors',
			'profile.educationHighSchool' => 'High School',
			'profile.educationAssociates' => 'Associate\'s Degree',
			'profile.educationBachelors' => 'Bachelor\'s Degree',
			'profile.educationMasters' => 'Master\'s Degree',
			'profile.educationPhd' => 'PhD / Doctorate',
			'profile.voiceRecord' => 'Voice Record',
			'profile.addVoice' => 'Add Voice',
			'profile.lifestyle' => 'Lifestyle',
			'profile.pets' => 'Pets',
			'profile.petsValue' => 'I have a cat',
			'profile.petsDontWant' => 'I don\'t want pets',
			'profile.petsAllergic' => 'I\'m allergic to pets',
			'profile.petsHaveCat' => 'I have a cat',
			'profile.petsHaveDog' => 'I have a dog',
			'profile.petsHaveCatsAndDogs' => 'I have cats and dogs',
			'profile.petsHaveOther' => 'I have other pets',
			'profile.drinking' => 'Drinking',
			'profile.drinkingValue' => 'On special occasions',
			'profile.drinkingNever' => 'Never',
			'profile.drinkingSpecialOccasions' => 'On special occasions',
			'profile.drinkingSocially' => 'Socially',
			'profile.drinkingFrequently' => 'Frequently',
			'profile.drinkingSober' => 'Sober',
			'profile.drinkingPreferNotToSay' => 'Prefer not to say',
			'profile.smoking' => 'Smoking',
			'profile.smokingValue' => 'Non-smoker',
			'profile.smokingNonSmoker' => 'Non-smoker',
			'profile.smokingSocialSmoker' => 'Social smoker',
			'profile.smokingSmoker' => 'Smoker',
			'profile.smokingTryingToQuit' => 'Trying to quit',
			'profile.smokingWhenDrinking' => 'Smoker when drinking',
			'profile.smokingPreferNotToSay' => 'Prefer not to say',
			'profile.gender' => 'Gender',
			'profile.genderFemale' => 'Female',
			'profile.genderMale' => 'Male',
			'profile.genderPreferNotToSay' => 'I don\'t want to mention it',
			'profile.visible' => 'Visible',
			'profile.profileVisibility' => 'Profile Visibility',
			'profile.language' => 'Language',
			'profile.borderTitle' => 'Profile Border',
			'profile.borderSubtitle' => 'Profilinize çerçeve ekleyerek kendinizi öne\nçıkarabilirsiniz.',
			'profile.borderBuySection' => 'Çerçeve satın al',
			'profile.borderBuyCta' => 'Çerçeve Satın Al',
			'profile.borderToken' => ({required Object count}) => '${count} Token',
			'profile.borderAmethystWings' => 'Amethyst Wings',
			'profile.borderGoldenPhoenix' => 'Golden Phoenix',
			'profile.borderFrostCrown' => 'Frost Crown',
			'profile.borderEmeraldWhisper' => 'Emerald Whisper',
			'profile.borderRoseQuartz' => 'Rose Quartz',
			'profile.borderStarlitComet' => 'Starlit Comet',
			'profile.borderCrimsonRoyal' => 'Crimson Royal',
			'profile.borderSapphireHalo' => 'Sapphire Halo',
			'profile.follow' => 'Follow',
			'profile.following' => 'Following',
			'profile.followPageTitle' => 'Follow',
			'profile.followTabFollowing' => 'Takip',
			'profile.followTabFollowers' => 'Takipçi',
			'profile.followSearch' => 'Search',
			'profile.unfollow' => 'Unfollow',
			'profile.followSortTitle' => 'Sırala',
			'profile.followSortRecent' => 'En son takip ettiğim kişiler',
			'profile.followSortNotFollowingMe' => 'Beni takip etmeyenler',
			'profile.followSortNotFollowedByMe' => 'Benim takip etmediklerim',
			'profile.followSortShowResult' => 'Show Result',
			'profile.followSortEmpty' => 'Bu filtreye uyan kimse yok',
			'profile.shareTitle' => 'Share with Friends',
			'profile.shareSubtitle' => 'Everything is more fun when you connect\nwith your friends!',
			'profile.shareProfileLabel' => 'Share the profile',
			'profile.shareLinkCopied' => 'Link copied',
			'profile.restrict' => 'Restrict',
			'profile.block' => 'Block',
			'profile.report' => 'Report',
			'profile.blockTitle' => ({required Object username}) => 'Block ${username} ?',
			'profile.blockBody' => 'This will also block any other accounts they may have or create in the future. You can unlock them anytime.',
			'profile.blockAndReport' => 'Block and report',
			'profile.restrictTitle' => ({required Object username}) => 'Restrict ${username} ?',
			'profile.restrictBody' => 'They won\'t be able to see when you\'re online or that you\'ve read their messages. You can change this anytime.',
			'profile.restrictAndReport' => 'Restrict and report',
			'profile.reportTitle' => 'Report sebebini merak ediyoruz',
			'profile.reportSubtitle' => 'Sana daha iyi bir deneyim sunabilmek için kullanıcıyı neden report etmek istediğini açıklar mısın?',
			'profile.reportMessageLabel' => 'Report Mesajı',
			'profile.reportMessageHint' => 'Mesajınızı yazın',
			'profile.reportCancel' => 'Cancel',
			'profile.sendReport' => 'Send Report',
			'profile.notSet' => 'Belirtilmedi',
			'profile.reportSent' => 'Teşekkürler, raporunu aldık.',
			'profile.emailVerificationSent' => ({required Object email}) => '${email} adresine onay bağlantısı gönderdik. Onaylayınca e-postan değişir.',
			'profile.passwordChanged' => 'Şifren güncellendi.',
			'profile.passwordMismatch' => 'Şifreler eşleşmiyor.',
			'nav.discover' => 'Discover',
			'nav.chat' => 'Chat',
			'nav.call' => 'Call',
			'nav.vibes' => 'Vibes',
			'nav.profile' => 'Profile',
			'call.title' => '60 Second Stranger',
			'call.subtitle' => 'Talk to a random stranger for 60 seconds — completely anonymous. No profile, no photo, no name. Just a voice and a moment.',
			'call.findingTitle' => 'Finding a stranger...',
			'call.findingSubtitle' => 'You\'ll talk anonymously for 60 seconds. No profile, no names.',
			'call.callStranger' => 'Call Stranger - 10 Token',
			'call.cancel' => 'Cancel',
			'call.female' => 'Female',
			'call.male' => 'Male',
			'call.nonBinary' => 'Non-binary',
			'call.preferNotToSay' => 'Prefer not to say',
			'call.anonymousBadge' => '🎙️ Anonymous voice call',
			'call.stranger' => 'Stranger',
			'call.secondsLeft' => ({required Object n}) => '${n}sn',
			'call.timesUpTitle' => 'Time\'s up!',
			'call.timesUpSubtitle' => 'Want to keep talking? If you both say yes, chat unlocks.',
			'call.keepTalking' => 'Keep Talking',
			'call.endCall' => 'End Call',
			'call.waitingOther' => 'Waiting for the other person...',
			'vibes.search' => 'Search',
			'vibes.sendMessage' => 'Mesaj Gönder',
			'vibes.wantsToTalk' => 'Wants to talk about this right now',
			'vibes.shareTitle' => 'Vibe Paylaş',
			'vibes.replyTitle' => 'Vibe\'a Cevap Ver',
			'vibes.shareHint' => 'Bir şeyler yaz',
			'vibes.shareAnonymous' => 'Anonim olarak paylaş',
			'vibes.empty' => 'Son 24 saatte vibe yok. İlkini sen paylaş!',
			'vibes.deleteTitle' => 'Bu vibe silinsin mi?',
			'vibes.delete' => 'Sil',
			'vibes.cancel' => 'Vazgeç',
			'discover.title' => 'Discover',
			'discover.tabRooms' => 'Rooms',
			'discover.tabDiscover' => 'Discover',
			'discover.tabAiMatch' => 'AI Match',
			'discover.aiMatch.feelingTitle' => 'Bugün nasıl hissediyorsun',
			'discover.aiMatch.feelingSubtitle' => 'AI, seçimine göre en iyi eşleşmeyi bulur',
			'discover.aiMatch.lookingTitle' => 'Ne arıyorsun?',
			'discover.aiMatch.moodSad' => 'Üzgün',
			'discover.aiMatch.moodMeltie' => 'Bitkin',
			'discover.aiMatch.moodBored' => 'Sıkılmış',
			'discover.aiMatch.moodCrying' => 'Kötü',
			'discover.aiMatch.moodSmile' => 'Mutlu',
			'discover.aiMatch.lookingNewFriends' => 'Yeni arkadaşlar',
			'discover.aiMatch.lookingVenting' => 'Dertleşme',
			'discover.aiMatch.lookingFlirty' => 'Flört sohbeti',
			'discover.aiMatch.lookingFun' => 'Eğlence',
			'discover.aiMatch.lookingCultures' => 'Yeni kültürler',
			'discover.aiMatch.lookingLanguage' => 'Dil pratiği',
			'discover.aiMatch.statActiveUsers' => 'Aktif kullanıcı',
			'discover.aiMatch.statMatchRate' => 'Eşleşme oranı',
			'discover.aiMatch.statAvgTime' => 'Ort. süre',
			'discover.aiMatch.statActiveValue' => '843',
			'discover.aiMatch.statMatchValue' => '87%',
			'discover.aiMatch.statAvgValue' => '8s',
			'discover.aiMatch.startSmartMatch' => 'Start Smart Match',
			'discover.aiMatch.findingTitle' => 'Finding your match',
			'discover.aiMatch.findingSubtitle' => 'Matching your mood and interests with the right person',
			'discover.aiMatch.findingStepMood' => 'Mood analyzed',
			'discover.aiMatch.findingStepInterests' => 'Interests matched',
			'discover.aiMatch.findingStepCompatibility' => 'Calculating compatibility...',
			'discover.aiMatch.findingStepContent' => 'Content is being created...',
			'discover.aiMatch.findingOnline' => ({required Object count}) => '${count} people online right now',
			'discover.aiMatch.yourMatchTitle' => 'Your Match',
			'discover.aiMatch.yourMatchSubtitle' => 'You have been matched based on your answers',
			'discover.aiMatch.vibeMatch' => ({required Object percent}) => '${percent}% Vibe match',
			'discover.aiMatch.startChatting' => 'Start Chatting',
			'discover.aiMatch.matchNameAge' => ({required Object name, required Object age}) => '${name}, ${age}',
			'discover.aiMatch.matchBio' => 'I\'ll make you feel things you didn\'t know you could feel.',
			'discover.aiMatch.swipePrevious' => 'Previous',
			'discover.aiMatch.swipeNext' => 'Next',
			'discover.aiMatch.swipeFinger' => 'Swipe Finger',
			'discover.aiMatch.noMatch' => 'Şu an uygun kimse yok. Biraz sonra tekrar dene.',
			'discover.searchHint' => 'Search',
			'discover.allRooms' => 'All Rooms',
			'discover.allGroups' => 'All Groups',
			'discover.seeAll' => 'See All',
			'discover.live' => 'Live',
			'discover.join' => 'Join',
			'discover.request' => 'Request',
			'discover.requested' => 'Requested',
			'discover.private' => 'Private',
			'discover.moreCount' => ({required Object count}) => '+${count} more',
			'discover.activeCount' => ({required Object count}) => '${count} active',
			'discover.membersCount' => ({required Object count}) => '${count} members',
			'discover.privateRoom.subtitle' => 'This is a private room. Unlock access with tokens.',
			'discover.privateRoom.roomAccess' => 'Room access',
			'discover.privateRoom.yourBalance' => 'Your balance',
			'discover.privateRoom.tokensAmount' => ({required Object count}) => '${count} tokens',
			'discover.privateRoom.joinForTokens' => ({required Object count}) => 'Join for ${count} tokens',
			'discover.privateRoom.cancel' => 'Cancel',
			'discover.roomToken.subtitle' => 'Unlock access with tokens.',
			'discover.roomToken.roomAccess' => 'Room access',
			'discover.roomToken.yourBalance' => 'Your balance',
			'discover.roomToken.tokensAmount' => ({required Object count}) => '${count} tokens',
			'discover.roomToken.joinForTokens' => ({required Object count}) => 'Join for ${count} tokens',
			'discover.roomToken.cancel' => 'Cancel',
			'discover.privateRequest.title' => 'Request to join',
			'discover.privateRequest.roomInfo' => ({required Object name, required Object count}) => '${name} · ${count} members',
			'discover.privateRequest.messageHint' => 'Say something (optional)...',
			'discover.privateRequest.sendRequest' => 'Send Request',
			'discover.privateRequest.adminReview' => 'The room admin will review your request',
			'discover.roomApproved.title' => 'You\'re in!',
			'discover.roomApproved.subtitle' => ({required Object name}) => 'Your spot in ${name} is reserved',
			'discover.roomApproved.continueLabel' => 'Continue',
			'discover.createSpace.title' => 'Create Room or Group',
			'discover.createSpace.subtitle' => 'Grup veya canlı oda oluşturarak kitlelere hitap et',
			'discover.createSpace.room' => 'Room',
			'discover.createSpace.group' => 'Group',
			'discover.createSpace.hideAccount' => 'Hide Your Account',
			'discover.createSpace.create' => 'Create',
			'discover.createSpace.cancel' => 'Cancel',
			'discover.createSpace.createRoomTitle' => 'Create Room',
			'discover.createSpace.createGroupTitle' => 'Create Group',
			'discover.createSpace.nameSubtitle' => 'Give the group you created a name',
			'discover.createSpace.nameHint' => 'Night Owl',
			'discover.liveRoom.adminSuffix' => '(Admin)',
			'discover.liveRoom.messageHint' => 'Mesaj',
			'discover.liveRoom.quickReplyHey' => 'Herkese merhaba!',
			'discover.liveRoom.quickReplyTopic' => 'Konu ne?',
			'discover.liveRoom.quickReplyNew' => 'Ben yeniyim!',
			'discover.liveRoom.sampleChatName' => 'Sona',
			'discover.liveRoom.sampleChatBody' => 'Ne yapabiliriz? Aklında ne var?',
			'discover.groupChat.usersCount' => ({required Object count}) => '${count} Kullanıcı',
			'discover.groupChat.sampleVictoria' => 'Çok sıkıldım. Bir şeyler yapalım mı?',
			'discover.groupChat.sampleSona' => 'Ne yapabiliriz? Aklında ne var?',
			'discover.groupChat.sampleOwn' => 'İskelede buluşalım',
			'discover.groupInfo.media' => 'Medya',
			'discover.groupInfo.gallery' => 'Galeri',
			'discover.groupInfo.settings' => 'Ayarlar',
			'discover.groupInfo.notifications' => 'Bildirimler',
			'discover.groupInfo.blocked' => 'Engellenenler',
			'discover.groupInfo.private' => 'Gizli',
			'discover.groupInfo.membersCount' => ({required Object count}) => '${count} üye',
			'discover.groupInfo.addPeople' => 'Kişi Ekle',
			'discover.groupInfo.you' => 'Sen',
			'discover.groupInfo.admin' => 'Admin',
			'discover.groupInfo.leaveGroup' => 'Gruptan ayrıl',
			'discover.groupInfo.requests' => 'Katılma istekleri',
			'discover.groupInfo.approve' => 'Onayla',
			'discover.groupInfo.reject' => 'Reddet',
			'discover.groupInfo.addPeopleEmpty' => 'Gruba eklemek için önce birilerini takip et.',
			'discover.groupInfo.add' => 'Ekle',
			'discover.groupInfo.makeAdmin' => 'Yönetici yap',
			'discover.groupInfo.removeAdmin' => 'Yöneticilikten al',
			'discover.groupInfo.remove' => 'Gruptan çıkar',
			'discover.groupInfo.leaveConfirm' => 'Bu gruptan ayrılmak istiyor musun?',
			'discover.groupInfo.leave' => 'Ayrıl',
			'discover.groupInfo.cancel' => 'Vazgeç',
			'discover.filters.title' => 'Filters',
			'discover.filters.ageRange' => 'Yaş aralığı',
			'discover.filters.ageRangeValue' => ({required Object min, required Object max}) => '${min}-${max}',
			'discover.filters.distance' => 'Mesafe',
			'discover.filters.distanceValue' => ({required Object km}) => '${km} km',
			'discover.filters.showMe' => 'Göster',
			'discover.filters.everyone' => 'Herkes',
			'discover.filters.women' => 'Kadınlar',
			'discover.filters.men' => 'Erkekler',
			'discover.filters.interests' => 'İlgi alanları',
			'discover.filters.activeNow' => 'Şu an aktif',
			'discover.filters.activeNowSubtitle' => 'Yalnızca şu an çevrimiçi olanları göster',
			'discover.filters.showResult' => 'Sonuçları göster',
			'discover.post.follow' => 'Takip Et',
			'discover.post.following' => 'Takipte',
			'discover.post.addComment' => 'Yorum ekle...',
			'discover.post.commentsTitle' => 'Yorumlar',
			'discover.post.sampleCaption' => 'There\'s nothing quite like having a cup of coffee after a beautiful day. <3',
			'discover.post.hoursAgo' => ({required Object hours}) => '${hours}s',
			'discover.post.minutesAgo' => ({required Object minutes}) => '${minutes}dk',
			'discover.post.daysAgo' => ({required Object days}) => '${days}g',
			'discover.post.deleteCommentTitle' => 'Bu yorum silinsin mi?',
			'discover.story.draft' => 'DRAFT',
			'discover.story.story' => 'STORY',
			'discover.story.share' => 'Paylaş',
			'discover.story.textPlaceholder' => 'Bir şeyler yaz...',
			'discover.story.draftPrompt' => 'Taslak olarak kaydedilsin mi?',
			'discover.story.saveToDraft' => 'Save to Draft',
			'discover.story.moveToTrash' => 'Move to Trash',
			'discover.story.save' => 'Save',
			'discover.story.musicTitle' => 'Müzik',
			'discover.story.musicEmpty' => 'Müzik bulunamadı.',
			'discover.story.musicError' => 'Müzikler yüklenemedi.',
			'discover.story.downloaded' => 'Galeriye kaydedildi',
			'discover.story.downloadFailed' => 'Kaydedilemedi',
			'discover.highlight.title' => 'Highlight',
			'discover.highlight.view' => 'Görüntüle',
			'discover.highlight.aiComments' => 'AI yorumlar',
			'discover.highlight.remove' => 'Highlight’ı kaldır',
			'discover.highlight.sharedSuccess' => 'Gönderin başarıyla paylaşıldı',
			'discover.highlight.boost' => 'Öne Çıkar',
			'discover.stats.title' => 'İstatistik',
			'discover.stats.subtitle' => 'Gönderinle alakalı istatistikler\naşağıdadır.',
			'discover.stats.viewers' => 'Görüntüleyenler',
			'discover.stats.comments' => 'Yorum',
			'discover.stats.likes' => 'Beğeni',
			'discover.stats.boostCta' => '1 gün boyunca öne çıkar - 100 token',
			'discover.stats.boosted' => 'Öne çıkarıldı! Gönderin 24 saat boyunca en üstte.',
			'common.loading' => 'Yükleniyor…',
			'common.retry' => 'Tekrar dene',
			'common.cancel' => 'İptal',
			'common.save' => 'Kaydet',
			'common.continueAction' => 'Devam et',
			'common.language' => 'Dil',
			'common.or' => 'VEYA',
			'languages.tr' => 'Türkçe',
			'languages.en' => 'English',
			'auth.createAccountTitle' => 'Hesabını oluştur',
			'auth.createAccountSubtitle' => 'Veylo’ya katıl ve bağlantı kurmaya başla.',
			'auth.welcomeBackTitle' => 'Tekrar hoş geldin',
			'auth.welcomeBackSubtitle' => 'Veylo’ya devam etmek için giriş yap.',
			'auth.username' => 'Kullanıcı adı',
			'auth.usernameHint' => 'Bir kullanıcı adı seç',
			'auth.email' => 'E-posta',
			'auth.emailHint' => 'E-postanı gir',
			'auth.emailOrUsername' => 'E-posta veya kullanıcı adı',
			'auth.emailOrUsernameHint' => 'E-posta veya kullanıcı adını gir',
			'auth.password' => 'Şifre',
			'auth.passwordCreateHint' => 'Bir şifre oluştur',
			'auth.passwordEnterHint' => 'Şifreni gir',
			'auth.signUp' => 'Kayıt ol',
			'auth.logIn' => 'Giriş yap',
			'auth.forgotPassword' => 'Şifremi unuttum?',
			'auth.continueWithApple' => 'Apple ile devam et',
			'auth.continueWithGoogle' => 'Google ile devam et',
			'auth.legalPrefix' => 'Devam ederek ',
			'auth.termsOfService' => 'Hizmet Şartları',
			'auth.legalMiddle' => '’nı kabul etmiş ve ',
			'auth.privacyPolicy' => 'Gizlilik Politikası',
			'auth.legalSuffix' => '’nı onaylamış olursun.',
			'auth.passwordResetSent' => 'Şifre sıfırlama bağlantısını e-postana gönderdik.',
			'onboarding.skip' => 'Atla',
			'onboarding.page1Title' => 'Kendin ol. Anonim kal.',
			'onboarding.page1Subtitle' => 'Kimliğini paylaşmadan yeni insanlarla tanış ve sohbet et.',
			'onboarding.page2Title' => 'Yaz. Konuş. Vibes’i hisset.',
			'onboarding.page2Subtitle' => 'Anonim başla; hazır olunca yaz, ara veya yüz yüze geç.',
			'onboarding.page3Title' => 'İnsanlarını bul. Sohbete katıl.',
			'onboarding.page3Subtitle' => 'Yeni insanlarla odalara gir ve anı birlikte paylaş.',
			'onboarding.getStarted' => 'Başla',
			'onboarding.alreadyHaveAccount' => 'Zaten Veylo hesabın var mı? ',
			'onboarding.logInAction' => 'Giriş yap',
			'createProfile.navTitle' => 'Profil oluştur',
			'createProfile.stepUsername' => '1/5 Kullanıcı adı',
			'createProfile.title' => 'Profilini oluştur',
			'createProfile.subtitle' => 'Gerçek adın yalnızca doğrulama için kullanılır — herkese açık görünmez.',
			'createProfile.subtitleLine1' => 'Gerçek adın yalnızca doğrulama için kullanılır —',
			'createProfile.subtitleLine2' => 'herkese açık görünmez.',
			'createProfile.fullName' => 'Ad soyad',
			'createProfile.fullNameHint' => 'Sam Lee',
			'createProfile.username' => 'Kullanıcı adı',
			'createProfile.usernameHint' => 'samlee123',
			'createProfile.usernameTaken' => 'Bu kullanıcı adı zaten alınmış!',
			'createProfile.usernameAvailable' => 'Kullanıcı adı müsait',
			'createProfile.mightWantToTry' => 'Şunları deneyebilirsin…',
			'createProfile.stepPhoto' => '2/5 Profil fotoğrafı',
			'createProfile.photoTitle' => 'Profil fotoğrafı yükle',
			'createProfile.photoSubtitle' => 'Diğer kullanıcılar senin olduğunu doğrulamak için profil fotoğrafını görebilir.',
			'createProfile.photoSubtitleLine1' => 'Diğer kullanıcılar senin olduğunu doğrulamak için',
			'createProfile.photoSubtitleLine2' => 'profil fotoğrafını görebilir.',
			'createProfile.choosePhoto' => 'Fotoğraf seç',
			'createProfile.continueWithoutPhoto' => 'Fotoğrafsız devam et',
			'createProfile.saveAndContinue' => 'Kaydet ve devam et',
			'createProfile.choosePhotoSheetTitle' => 'Fotoğraf seç',
			'createProfile.takePhoto' => 'Fotoğraf çek',
			'createProfile.chooseFromGallery' => 'Galeriden seç',
			'createProfile.stepGender' => '3/5 Cinsiyet',
			'createProfile.genderTitle' => 'Cinsiyetini seç',
			'createProfile.genderSubtitle' => 'Bu bilgiyi paylaşırsan, içeriği sana göre kişiselleştirmek için kullanabiliriz.',
			'createProfile.genderSubtitleLine1' => 'Bu bilgiyi paylaşırsan, içeriği sana göre',
			'createProfile.genderSubtitleLine2' => 'kişiselleştirmek için kullanabiliriz.',
			'createProfile.genderFemale' => 'Kadın',
			'createProfile.genderMale' => 'Erkek',
			'createProfile.genderNonBinary' => 'Non-binary',
			'createProfile.genderPreferNotToSay' => 'Belirtmek istemiyorum',
			'createProfile.stepInterests' => '4/5 İlgi alanları',
			'createProfile.interestsTitle' => 'Nelerden hoşlanırsın?',
			'createProfile.interestsSubtitle' => 'En az 5 seç — seni gerçekten anlayan insanlarla eşleşmene yardımcı olur.',
			'createProfile.interests.music' => 'Müzik',
			'createProfile.interests.movies' => 'Film',
			'createProfile.interests.tvShows' => 'Dizi',
			'createProfile.interests.reading' => 'Okuma',
			'createProfile.interests.painting' => 'Resim',
			'createProfile.interests.photography' => 'Fotoğraf',
			'createProfile.interests.theatre' => 'Tiyatro',
			'createProfile.interests.fitness' => 'Fitness',
			'createProfile.interests.swimming' => 'Yüzme',
			'createProfile.interests.football' => 'Futbol',
			'createProfile.interests.basketball' => 'Basketbol',
			'createProfile.interests.coffee' => 'Kahve',
			'createProfile.interests.travel' => 'Seyahat',
			'createProfile.interests.camping' => 'Kamp',
			'createProfile.interests.meditation' => 'Meditasyon',
			'createProfile.interests.videoGames' => 'Video oyunları',
			'createProfile.interests.boardGames' => 'Kutu oyunları',
			'createProfile.interests.standUp' => 'Stand-up',
			'createProfile.interests.tech' => 'Teknoloji',
			'createProfile.interests.coding' => 'Kodlama',
			'createProfile.interests.ai' => 'YZ',
			'createProfile.interests.podcast' => 'Podcast',
			'createProfile.stepChatGoal' => '5/5 Sohbet hedefi',
			'createProfile.chatGoalTitle' => 'Bugün ne arıyorsun?',
			'createProfile.chatGoalSubtitle' => 'Bu, şu anki ruh haline uygun eşleşmeyi bulmamıza yardımcı olur.',
			'createProfile.chatGoalQuickMatch' => 'Hızlı eşleşme — doğrudan sohbete gir',
			'createProfile.chatGoalFlirtyChat' => 'Flört sohbeti — hafif, eğlenceli muhabbet',
			'createProfile.chatGoalMoodMatch' => 'Ruh hali eşleşmesi — nasıl hissettiğine göre',
			'createProfile.chatGoalLateNight' => 'Gece sohbeti — dünya uyurken derin konuşmalar',
			'createProfile.chatGoalMeetSomeoneNew' => 'Yeni biriyle tanış — özel hedef yok, keşfet',
			'createProfile.getStarted' => 'Başla',
			'createProfile.preparingTitleLine1' => 'Sana uygun',
			'createProfile.preparingTitleLine2' => 'profilleri',
			'createProfile.preparingTitleLine3' => 'hazırlıyoruz.',
			'createProfile.preparingSubtitleLine1' => 'Cevaplarına göre en iyi eşleşmeleri',
			'createProfile.preparingSubtitleLine2' => 'seçiyoruz—lütfen bir an bekle.',
			'createProfile.preparingPercent' => ({required Object percent}) => '%${percent}',
			'createProfile.usernameInvalid' => '3–30 karakter: harf, rakam, nokta veya alt çizgi kullan.',
			'errors.network' => 'Veylo’ya ulaşılamadı. Bağlantını kontrol edip tekrar dene.',
			'errors.generic' => 'Bir şeyler ters gitti. Lütfen tekrar dene.',
			'errors.signInFailed' => 'Giriş yapılamadı. Lütfen tekrar dene.',
			_ => null,
		} ?? switch (path) {
			'errors.sessionExpired' => 'Oturumun sona erdi. Lütfen tekrar giriş yap.',
			'errors.accountSuspended' => 'Bu hesap askıya alındı.',
			'errors.unsupportedImage' => 'Lütfen JPEG, PNG veya WebP bir fotoğraf seç.',
			'errors.fileTooLarge' => 'Bu dosya çok büyük.',
			'errors.enterEmailForReset' => 'Şifreni sıfırlamak için yukarıya e-postanı yaz.',
			'errors.wrongCredentials' => 'E-posta/kullanıcı adı veya şifre hatalı.',
			'errors.emailInUse' => 'Bu e-posta zaten kayıtlı. Giriş yapmayı dene.',
			'errors.weakPassword' => 'Şifre en az 6 karakter olmalı.',
			'errors.invalidEmail' => 'Lütfen geçerli bir e-posta adresi gir.',
			'errors.tooManyAttempts' => 'Çok fazla deneme yapıldı. Biraz bekleyip tekrar dene.',
			'errors.fillAllFields' => 'Lütfen tüm alanları doldur.',
			'errors.insufficientTokens' => 'Yeterli token yok.',
			'errors.requestNotAccepted' => 'Cevap vermek için isteği onayla.',
			'errors.requestPendingLimit' => 'İsteğini kabul ettiğinde daha fazla mesaj gönderebilirsin.',
			'errors.blocked' => 'Bu kişiye mesaj gönderemezsin.',
			'errors.peerUnavailable' => 'Bu hesap artık kullanılamıyor.',
			'errors.vibeDailyLimit' => 'Bugün çok vibe paylaştın. Biraz sonra tekrar dene.',
			'errors.groupFull' => 'Bu grup dolu.',
			'errors.groupCreateLimit' => 'Bugün çok grup oluşturdun. Biraz sonra tekrar dene.',
			'errors.notFound' => 'Bu artık mevcut değil.',
			'errors.recentLogin' => 'Güvenliğin için çıkış yapıp tekrar giriş yap, sonra yeniden dene.',
			'errors.socialAccount' => 'E-posta ve şifren Google ya da Apple hesabın tarafından yönetiliyor.',
			_ => null,
		};
	}
}
