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
	late final Translations$faq$tr faq = Translations$faq$tr.internal(_root);
	late final Translations$legal$tr legal = Translations$legal$tr.internal(_root);
	late final Translations$logout$tr logout = Translations$logout$tr.internal(_root);
	late final Translations$deleteAccount$tr deleteAccount = Translations$deleteAccount$tr.internal(_root);
	late final Translations$storyText$tr storyText = Translations$storyText$tr.internal(_root);
	late final Translations$tokens$tr tokens = Translations$tokens$tr.internal(_root);
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

	/// tr: 'Sohbetler'
	String get title => 'Sohbetler';

	/// tr: 'Ara'
	String get search => 'Ara';

	/// tr: 'Mesajlar'
	String get messagesSection => 'Mesajlar';

	/// tr: 'İstekler'
	String get request => 'İstekler';

	/// tr: 'Son mesaj bildirimi yok'
	String get emptyRequestTitle => 'Son mesaj bildirimi yok';

	/// tr: '30 günden eski istekler gösterilmez.'
	String get emptyRequestSubtitle => '30 günden eski istekler gösterilmez.';

	/// tr: 'Not Ekle'
	String get noteAdd => 'Not Ekle';

	/// tr: 'Anonim'
	String get anonymous => 'Anonim';

	/// tr: 'çevrimiçi'
	String get online => 'çevrimiçi';

	/// tr: 'çevrimdışı'
	String get offline => 'çevrimdışı';

	/// tr: 'Bağlantı'
	String get connection => 'Bağlantı';

	/// tr: '%{n}'
	String connectionPercent({required Object n}) => '%${n}';

	/// tr: 'Bağlantı İlerlemesi'
	String get connectionProgressTitle => 'Bağlantı İlerlemesi';

	/// tr: 'Adının baş harfi'
	String get milestoneInitial => 'Adının baş harfi';

	/// tr: '%25'te açıldı'
	String get milestoneInitialHint => '%25\'te açıldı';

	/// tr: '%25'te açılır'
	String get milestoneInitialLocked => '%25\'te açılır';

	/// tr: 'Bulanık fotoğraf önizlemesi'
	String get milestonePhoto => 'Bulanık fotoğraf önizlemesi';

	/// tr: '%70'te açılır'
	String get milestonePhotoHint => '%70\'te açılır';

	/// tr: 'Tam profil görüntüleme'
	String get milestoneFull => 'Tam profil görüntüleme';

	/// tr: '%100'de karşılıklı onayla'
	String get milestoneFullHint => '%100\'de karşılıklı onayla';

	/// tr: 'Merhaba, tanıştığımıza memnun oldum. Biraz kendinden bahseder misin?'
	String get sampleAnonymousMessage => 'Merhaba, tanıştığımıza memnun oldum. Biraz kendinden bahseder misin?';

	/// tr: 'Merhaba, tanıştığımıza memnun oldum. Biraz kendinden bahseder misin?'
	String get strangerSampleMessage => 'Merhaba, tanıştığımıza memnun oldum. Biraz kendinden bahseder misin?';

	/// tr: 'Onayla'
	String get approve => 'Onayla';

	/// tr: 'Engelle'
	String get blockUser => 'Engelle';

	/// tr: 'Reddet'
	String get reject => 'Reddet';

	/// tr: 'Selam! Nasılsın?'
	String get messageHint => 'Selam! Nasılsın?';

	/// tr: '%100'e ulaştınız'
	String get revealTitle => '%100\'e ulaştınız';

	/// tr: 'Tam profillerinizi birbirinize açmak ister misiniz? İki tarafın da onaylaması gerekir.'
	String get revealSubtitle => 'Tam profillerinizi birbirinize açmak ister misiniz? İki tarafın da onaylaması gerekir.';

	/// tr: '{name} kişisinin onayı bekleniyor'
	String revealWaiting({required Object name}) => '${name} kişisinin onayı bekleniyor';

	/// tr: 'Profilimi aç'
	String get revealCta => 'Profilimi aç';

	/// tr: 'Henüz değil'
	String get revealNotYet => 'Henüz değil';

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

	/// tr: 'Profil'
	String get eyebrow => 'Profil';

	/// tr: 'Ayarlar'
	String get title => 'Ayarlar';

	/// tr: 'Profili Düzenle'
	String get editProfile => 'Profili Düzenle';

	/// tr: 'Beğeni'
	String get statLike => 'Beğeni';

	/// tr: 'Takip'
	String get statFollow => 'Takip';

	/// tr: 'Takipçi'
	String get statFollower => 'Takipçi';

	/// tr: 'Daha Fazla Mesaj Al!'
	String get promoTitle => 'Daha Fazla Mesaj Al!';

	/// tr: 'Öne çık, listenin en üstünde görün'
	String get promoSubtitle => 'Öne çık, listenin en üstünde görün';

	/// tr: 'Öne Çık'
	String get standOut => 'Öne Çık';

	/// tr: 'Gönderi'
	String get tabPosts => 'Gönderi';

	/// tr: 'Video'
	String get tabVideo => 'Video';

	/// tr: 'Kaydedilenler'
	String get tabSaved => 'Kaydedilenler';

	/// tr: 'Kaydet'
	String get save => 'Kaydet';

	/// tr: 'Fotoğrafı Değiştir'
	String get changePhoto => 'Fotoğrafı Değiştir';

	/// tr: 'Çerçeveyi Değiştir'
	String get changeBorder => 'Çerçeveyi Değiştir';

	/// tr: 'İlgi Alanları'
	String get interest => 'İlgi Alanları';

	/// tr: 'Ad'
	String get name => 'Ad';

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

	/// tr: 'Hesap Ayarları'
	String get settingsAccount => 'Hesap Ayarları';

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

	/// tr: 'Bildirimler'
	String get notifications => 'Bildirimler';

	/// tr: 'Şifre'
	String get password => 'Şifre';

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

	/// tr: 'Çıkış Yap'
	String get logOut => 'Çıkış Yap';

	/// tr: 'Hesabı ve Verileri Sil'
	String get deleteAccountAndData => 'Hesabı ve Verileri Sil';

	/// tr: '********'
	String get passwordPlaceholder => '********';

	/// tr: 'Boy'
	String get height => 'Boy';

	/// tr: 'Boy Ekle'
	String get addHeight => 'Boy Ekle';

	/// tr: '{value} cm'
	String heightCm({required Object value}) => '${value} cm';

	/// tr: 'Diller'
	String get languages => 'Diller';

	/// tr: 'İlişki Hedefleri'
	String get relationshipGoals => 'İlişki Hedefleri';

	/// tr: 'Aradığım'
	String get lookingFor => 'Aradığım';

	/// tr: '👋 Yeni Arkadaşlar'
	String get newFriends => '👋 Yeni Arkadaşlar';

	/// tr: '💕 Uzun vadeli, kısaya da açığım'
	String get goalLongTermOpenToShort => '💕 Uzun vadeli, kısaya da açığım';

	/// tr: '💘 Uzun vadeli ilişki'
	String get goalLongTermRelationship => '💘 Uzun vadeli ilişki';

	/// tr: '👋 Yeni arkadaşlar'
	String get goalNewFriends => '👋 Yeni arkadaşlar';

	/// tr: '🥃 Kısa süreli eğlence'
	String get goalShortTermFun => '🥃 Kısa süreli eğlence';

	/// tr: '🤔 Henüz karar vermedim'
	String get goalStillFiguringItOut => '🤔 Henüz karar vermedim';

	/// tr: 'Temel Bilgiler'
	String get basics => 'Temel Bilgiler';

	/// tr: 'Burç'
	String get zodiac => 'Burç';

	/// tr: 'Akrep'
	String get zodiacValue => 'Akrep';

	/// tr: 'Eğitim'
	String get education => 'Eğitim';

	/// tr: 'Lisans'
	String get educationValue => 'Lisans';

	/// tr: 'Lise'
	String get educationHighSchool => 'Lise';

	/// tr: 'Ön Lisans'
	String get educationAssociates => 'Ön Lisans';

	/// tr: 'Lisans'
	String get educationBachelors => 'Lisans';

	/// tr: 'Yüksek Lisans'
	String get educationMasters => 'Yüksek Lisans';

	/// tr: 'Doktora'
	String get educationPhd => 'Doktora';

	/// tr: 'Ses Kaydı'
	String get voiceRecord => 'Ses Kaydı';

	/// tr: 'Ses Ekle'
	String get addVoice => 'Ses Ekle';

	/// tr: 'Yaşam Tarzı'
	String get lifestyle => 'Yaşam Tarzı';

	/// tr: 'Evcil Hayvanlar'
	String get pets => 'Evcil Hayvanlar';

	/// tr: 'Kedim var'
	String get petsValue => 'Kedim var';

	/// tr: 'Evcil hayvan istemiyorum'
	String get petsDontWant => 'Evcil hayvan istemiyorum';

	/// tr: 'Evcil hayvanlara alerjim var'
	String get petsAllergic => 'Evcil hayvanlara alerjim var';

	/// tr: 'Kedim var'
	String get petsHaveCat => 'Kedim var';

	/// tr: 'Köpeğim var'
	String get petsHaveDog => 'Köpeğim var';

	/// tr: 'Kedilerim ve köpeklerim var'
	String get petsHaveCatsAndDogs => 'Kedilerim ve köpeklerim var';

	/// tr: 'Başka evcil hayvanlarım var'
	String get petsHaveOther => 'Başka evcil hayvanlarım var';

	/// tr: 'Alkol'
	String get drinking => 'Alkol';

	/// tr: 'Özel günlerde'
	String get drinkingValue => 'Özel günlerde';

	/// tr: 'Hiç'
	String get drinkingNever => 'Hiç';

	/// tr: 'Özel günlerde'
	String get drinkingSpecialOccasions => 'Özel günlerde';

	/// tr: 'Sosyal ortamlarda'
	String get drinkingSocially => 'Sosyal ortamlarda';

	/// tr: 'Sık sık'
	String get drinkingFrequently => 'Sık sık';

	/// tr: 'Hiç içmiyorum'
	String get drinkingSober => 'Hiç içmiyorum';

	/// tr: 'Belirtmek istemiyorum'
	String get drinkingPreferNotToSay => 'Belirtmek istemiyorum';

	/// tr: 'Sigara'
	String get smoking => 'Sigara';

	/// tr: 'İçmiyorum'
	String get smokingValue => 'İçmiyorum';

	/// tr: 'İçmiyorum'
	String get smokingNonSmoker => 'İçmiyorum';

	/// tr: 'Sosyal ortamlarda'
	String get smokingSocialSmoker => 'Sosyal ortamlarda';

	/// tr: 'İçiyorum'
	String get smokingSmoker => 'İçiyorum';

	/// tr: 'Bırakmaya çalışıyorum'
	String get smokingTryingToQuit => 'Bırakmaya çalışıyorum';

	/// tr: 'İçki içerken'
	String get smokingWhenDrinking => 'İçki içerken';

	/// tr: 'Belirtmek istemiyorum'
	String get smokingPreferNotToSay => 'Belirtmek istemiyorum';

	/// tr: 'Cinsiyet'
	String get gender => 'Cinsiyet';

	/// tr: 'Kadın'
	String get genderFemale => 'Kadın';

	/// tr: 'Erkek'
	String get genderMale => 'Erkek';

	/// tr: 'Belirtmek istemiyorum'
	String get genderPreferNotToSay => 'Belirtmek istemiyorum';

	/// tr: 'Görünür'
	String get visible => 'Görünür';

	/// tr: 'Profil Görünürlüğü'
	String get profileVisibility => 'Profil Görünürlüğü';

	/// tr: 'Dil'
	String get language => 'Dil';

	/// tr: 'Profil Çerçevesi'
	String get borderTitle => 'Profil Çerçevesi';

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

	/// tr: 'Takip Et'
	String get follow => 'Takip Et';

	/// tr: 'Takip Ediliyor'
	String get following => 'Takip Ediliyor';

	/// tr: 'Takip'
	String get followPageTitle => 'Takip';

	/// tr: 'Takip'
	String get followTabFollowing => 'Takip';

	/// tr: 'Takipçi'
	String get followTabFollowers => 'Takipçi';

	/// tr: 'Ara'
	String get followSearch => 'Ara';

	/// tr: 'Takibi Bırak'
	String get unfollow => 'Takibi Bırak';

	/// tr: 'Sırala'
	String get followSortTitle => 'Sırala';

	/// tr: 'En son takip ettiğim kişiler'
	String get followSortRecent => 'En son takip ettiğim kişiler';

	/// tr: 'Beni takip etmeyenler'
	String get followSortNotFollowingMe => 'Beni takip etmeyenler';

	/// tr: 'Benim takip etmediklerim'
	String get followSortNotFollowedByMe => 'Benim takip etmediklerim';

	/// tr: 'Sonuçları Göster'
	String get followSortShowResult => 'Sonuçları Göster';

	/// tr: 'Bu filtreye uyan kimse yok'
	String get followSortEmpty => 'Bu filtreye uyan kimse yok';

	/// tr: 'Arkadaşlarınla Paylaş'
	String get shareTitle => 'Arkadaşlarınla Paylaş';

	/// tr: 'Arkadaşlarınla bağlantı kurunca her şey daha eğlenceli!'
	String get shareSubtitle => 'Arkadaşlarınla bağlantı kurunca\nher şey daha eğlenceli!';

	/// tr: 'Profili paylaş'
	String get shareProfileLabel => 'Profili paylaş';

	/// tr: 'Bağlantı kopyalandı'
	String get shareLinkCopied => 'Bağlantı kopyalandı';

	/// tr: 'Kısıtla'
	String get restrict => 'Kısıtla';

	/// tr: 'Engelle'
	String get block => 'Engelle';

	/// tr: 'Şikayet Et'
	String get report => 'Şikayet Et';

	/// tr: '{username} engellensin mi?'
	String blockTitle({required Object username}) => '${username} engellensin mi?';

	/// tr: 'Bu, kişinin sahip olduğu ya da ileride oluşturacağı diğer hesapları da engeller. Engeli istediğin zaman kaldırabilirsin.'
	String get blockBody => 'Bu, kişinin sahip olduğu ya da ileride oluşturacağı diğer hesapları da engeller. Engeli istediğin zaman kaldırabilirsin.';

	/// tr: 'Engelle ve şikayet et'
	String get blockAndReport => 'Engelle ve şikayet et';

	/// tr: '{username} kısıtlansın mı?'
	String restrictTitle({required Object username}) => '${username} kısıtlansın mı?';

	/// tr: 'Çevrimiçi olduğunu ya da mesajlarını okuduğunu göremez. Bunu istediğin zaman değiştirebilirsin.'
	String get restrictBody => 'Çevrimiçi olduğunu ya da mesajlarını okuduğunu göremez. Bunu istediğin zaman değiştirebilirsin.';

	/// tr: 'Kısıtla ve şikayet et'
	String get restrictAndReport => 'Kısıtla ve şikayet et';

	/// tr: 'Şikayet sebebini merak ediyoruz'
	String get reportTitle => 'Şikayet sebebini merak ediyoruz';

	/// tr: 'Sana daha iyi bir deneyim sunabilmek için kullanıcıyı neden şikayet etmek istediğini açıklar mısın?'
	String get reportSubtitle => 'Sana daha iyi bir deneyim sunabilmek için kullanıcıyı neden şikayet etmek istediğini açıklar mısın?';

	/// tr: 'Şikayet Mesajı'
	String get reportMessageLabel => 'Şikayet Mesajı';

	/// tr: 'Mesajınızı yazın'
	String get reportMessageHint => 'Mesajınızı yazın';

	/// tr: 'İptal'
	String get reportCancel => 'İptal';

	/// tr: 'Şikayeti Gönder'
	String get sendReport => 'Şikayeti Gönder';

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

	/// tr: 'Keşfet'
	String get discover => 'Keşfet';

	/// tr: 'Sohbet'
	String get chat => 'Sohbet';

	/// tr: 'Ara'
	String get call => 'Ara';

	/// tr: 'Vibes'
	String get vibes => 'Vibes';

	/// tr: 'Profil'
	String get profile => 'Profil';
}

// Path: call
class Translations$call$tr {
	Translations$call$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: '60 Saniyelik Yabancı'
	String get title => '60 Saniyelik Yabancı';

	/// tr: 'Rastgele bir yabancıyla 60 saniye konuş — tamamen anonim. Profil yok, fotoğraf yok, isim yok. Sadece bir ses ve bir an.'
	String get subtitle => 'Rastgele bir yabancıyla 60 saniye konuş — tamamen anonim. Profil yok, fotoğraf yok, isim yok. Sadece bir ses ve bir an.';

	/// tr: 'Bir yabancı aranıyor...'
	String get findingTitle => 'Bir yabancı aranıyor...';

	/// tr: '60 saniye anonim konuşacaksın. Profil yok, isim yok.'
	String get findingSubtitle => '60 saniye anonim konuşacaksın. Profil yok, isim yok.';

	/// tr: 'Yabancıyı Ara - 10 Token'
	String get callStranger => 'Yabancıyı Ara - 10 Token';

	/// tr: 'İptal'
	String get cancel => 'İptal';

	/// tr: 'Kadın'
	String get female => 'Kadın';

	/// tr: 'Erkek'
	String get male => 'Erkek';

	/// tr: 'Non-binary'
	String get nonBinary => 'Non-binary';

	/// tr: 'Fark etmez'
	String get preferNotToSay => 'Fark etmez';

	/// tr: '🎙️ Anonim sesli arama'
	String get anonymousBadge => '🎙️ Anonim sesli arama';

	/// tr: 'Yabancı'
	String get stranger => 'Yabancı';

	/// tr: '{n} sn'
	String secondsLeft({required Object n}) => '${n} sn';

	/// tr: 'Süre doldu!'
	String get timesUpTitle => 'Süre doldu!';

	/// tr: 'Konuşmaya devam etmek ister misin? İkiniz de evet derseniz sohbet açılır.'
	String get timesUpSubtitle => 'Konuşmaya devam etmek ister misin? İkiniz de evet derseniz sohbet açılır.';

	/// tr: 'Konuşmaya Devam Et'
	String get keepTalking => 'Konuşmaya Devam Et';

	/// tr: 'Aramayı Bitir'
	String get endCall => 'Aramayı Bitir';

	/// tr: 'Karşı taraf bekleniyor...'
	String get waitingOther => 'Karşı taraf bekleniyor...';

	/// tr: 'Yabancıyı Ara'
	String get callStrangerFree => 'Yabancıyı Ara';

	/// tr: 'Karşı taraf aramayı bitirdi.'
	String get peerLeft => 'Karşı taraf aramayı bitirdi.';

	/// tr: 'Bu sefer sohbet açılmadı.'
	String get noKeep => 'Bu sefer sohbet açılmadı.';

	/// tr: 'Görüntülü aramayı kabul etmesi bekleniyor...'
	String get videoWaiting => 'Görüntülü aramayı kabul etmesi bekleniyor...';

	/// tr: 'Görüntülü aramayı reddetti.'
	String get videoDeclined => 'Görüntülü aramayı reddetti.';

	/// tr: 'Arama için mikrofon izni gerekli. Ayarlar'dan açabilirsin.'
	String get micDenied => 'Arama için mikrofon izni gerekli. Ayarlar\'dan açabilirsin.';

	/// tr: 'Görüntülü arama: 15 dk / 20 token'
	String get videoCost => 'Görüntülü arama: 15 dk / 20 token';

	/// tr: 'Aranıyor'
	String get calling => 'Aranıyor';

	/// tr: 'Kabul et'
	String get accept => 'Kabul et';

	/// tr: 'Reddet'
	String get decline => 'Reddet';

	/// tr: 'Görüntülü aramaya geçmek ister misin?'
	String get switchToVideo => 'Görüntülü aramaya geçmek ister misin?';

	/// tr: 'Şu an uygun kimse yok'
	String get noMatchTitle => 'Şu an uygun kimse yok';

	/// tr: 'Şu anda konuşmaya müsait bir anonim kullanıcı bulamadık. Biraz sonra tekrar dene.'
	String get noMatchBody => 'Şu anda konuşmaya müsait bir anonim kullanıcı bulamadık. Biraz sonra tekrar dene.';

	/// tr: 'Tamam'
	String get noMatchOk => 'Tamam';
}

// Path: vibes
class Translations$vibes$tr {
	Translations$vibes$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: 'Ara'
	String get search => 'Ara';

	/// tr: 'Mesaj Gönder'
	String get sendMessage => 'Mesaj Gönder';

	/// tr: 'Şu an bunun hakkında konuşmak istiyor'
	String get wantsToTalk => 'Şu an bunun hakkında konuşmak istiyor';

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

	/// tr: 'Keşfet'
	String get title => 'Keşfet';

	/// tr: 'Odalar'
	String get tabRooms => 'Odalar';

	/// tr: 'Keşfet'
	String get tabDiscover => 'Keşfet';

	/// tr: 'AI Match'
	String get tabAiMatch => 'AI Match';

	late final Translations$discover$aiMatch$tr aiMatch = Translations$discover$aiMatch$tr.internal(_root);

	/// tr: 'Ara'
	String get searchHint => 'Ara';

	/// tr: 'Tüm Odalar'
	String get allRooms => 'Tüm Odalar';

	/// tr: 'Tüm Gruplar'
	String get allGroups => 'Tüm Gruplar';

	/// tr: 'Tümünü Gör'
	String get seeAll => 'Tümünü Gör';

	/// tr: 'Canlı'
	String get live => 'Canlı';

	/// tr: 'Katıl'
	String get join => 'Katıl';

	/// tr: 'İstek Gönder'
	String get request => 'İstek Gönder';

	/// tr: 'İstek Gönderildi'
	String get requested => 'İstek Gönderildi';

	/// tr: 'Gizli'
	String get private => 'Gizli';

	/// tr: '+{count} kişi daha'
	String moreCount({required Object count}) => '+${count} kişi daha';

	/// tr: '{count} aktif'
	String activeCount({required Object count}) => '${count} aktif';

	/// tr: '{count} üye'
	String membersCount({required Object count}) => '${count} üye';

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

	/// tr: '{name} sunuyor'
	String hostedBy({required Object name}) => '${name} sunuyor';
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

	/// tr: 'Zaten bir aramadasın.'
	String get alreadyInCall => 'Zaten bir aramadasın.';

	/// tr: 'Bu oda gizli. Katılmak için istek gönder.'
	String get roomPrivate => 'Bu oda gizli. Katılmak için istek gönder.';

	/// tr: 'Oda dolu.'
	String get roomFull => 'Oda dolu.';

	/// tr: 'Bugünün ödülünü zaten topladın.'
	String get alreadyCheckedIn => 'Bugünün ödülünü zaten topladın.';

	/// tr: 'Satın alma şu an kullanılamıyor.'
	String get purchasesUnavailable => 'Satın alma şu an kullanılamıyor.';
}

// Path: faq
class Translations$faq$tr {
	Translations$faq$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: 'Bu uygulama nasıl çalışır?'
	String get q1 => 'Bu uygulama nasıl çalışır?';

	/// tr: 'Anonim sohbet nedir?'
	String get q2 => 'Anonim sohbet nedir?';

	/// tr: 'Bağlantı İlerlemesi ne işe yarar?'
	String get q3 => 'Bağlantı İlerlemesi ne işe yarar?';

	/// tr: 'Profilimi nasıl açarım?'
	String get q4 => 'Profilimi nasıl açarım?';

	/// tr: '60 Saniyelik Yabancı nedir?'
	String get q5 => '60 Saniyelik Yabancı nedir?';

	/// tr: 'Vibes nedir?'
	String get q6 => 'Vibes nedir?';

	/// tr: 'Profilimi nasıl düzenlerim?'
	String get q7 => 'Profilimi nasıl düzenlerim?';

	/// tr: 'Bildirimleri nasıl yönetirim?'
	String get q8 => 'Bildirimleri nasıl yönetirim?';

	/// tr: 'Satın alımları nasıl geri yüklerim?'
	String get q9 => 'Satın alımları nasıl geri yüklerim?';

	/// tr: 'Tüm sohbetleri silebilir miyim?'
	String get q10 => 'Tüm sohbetleri silebilir miyim?';

	/// tr: 'Verilerim güvende mi?'
	String get q11 => 'Verilerim güvende mi?';

	/// tr: 'Bir kullanıcıyı nasıl engeller veya şikayet ederim?'
	String get q12 => 'Bir kullanıcıyı nasıl engeller veya şikayet ederim?';

	/// tr: 'Uygulamayı nasıl paylaşırım?'
	String get q13 => 'Uygulamayı nasıl paylaşırım?';

	/// tr: 'Hesabımı nasıl silebilirim?'
	String get q14 => 'Hesabımı nasıl silebilirim?';

	/// tr: 'Veylo’da anonim olarak yeni insanlarla tanışabilir, sohbet edebilir ve bağlantın güçlendikçe profilini adım adım açabilirsin. İstediğin zaman yazışma, sesli arama veya yüz yüze görüşmeye geçebilirsin.'
	String get a1 => 'Veylo’da anonim olarak yeni insanlarla tanışabilir, sohbet edebilir ve bağlantın güçlendikçe profilini adım adım açabilirsin. İstediğin zaman yazışma, sesli arama veya yüz yüze görüşmeye geçebilirsin.';

	/// tr: 'Anonim sohbette kimliğin ve fotoğrafın gizli kalır. Bağlantı yüzdesi arttıkça isim baş harfi, bulanık fotoğraf gibi bilgiler açılır; %100’de karşılıklı onayla tam profil paylaşılır.'
	String get a2 => 'Anonim sohbette kimliğin ve fotoğrafın gizli kalır. Bağlantı yüzdesi arttıkça isim baş harfi, bulanık fotoğraf gibi bilgiler açılır; %100’de karşılıklı onayla tam profil paylaşılır.';

	/// tr: 'Sohbet ettikçe bağlantı yüzdeniz artar. Belirli eşiklerde isim baş harfi, bulanık fotoğraf ve tam profil gibi adımlar açılır. Detayları Bağlantı göstergesine dokunarak görebilirsin.'
	String get a3 => 'Sohbet ettikçe bağlantı yüzdeniz artar. Belirli eşiklerde isim baş harfi, bulanık fotoğraf ve tam profil gibi adımlar açılır. Detayları Bağlantı göstergesine dokunarak görebilirsin.';

	/// tr: 'Bağlantı %100 olduğunda Profilimi aç ile talep gönderebilirsin. Karşı taraf da kabul ederse karşılıklı tam profiller görünür.'
	String get a4 => 'Bağlantı %100 olduğunda Profilimi aç ile talep gönderebilirsin. Karşı taraf da kabul ederse karşılıklı tam profiller görünür.';

	/// tr: 'Ara sekmesinden kısa süreli rastgele bir eşleşme bulabilirsin. Süre bitince görüşmeyi uzatmayı seçebilir veya kapatabilirsin.'
	String get a5 => 'Ara sekmesinden kısa süreli rastgele bir eşleşme bulabilirsin. Süre bitince görüşmeyi uzatmayı seçebilir veya kapatabilirsin.';

	/// tr: 'Vibes, yakındaki veya keşfedilebilir insanları harita / liste üzerinden görmeni sağlar. İlgilendiğin kişiye yaklaşıp sohbet başlatabilirsin.'
	String get a6 => 'Vibes, yakındaki veya keşfedilebilir insanları harita / liste üzerinden görmeni sağlar. İlgilendiğin kişiye yaklaşıp sohbet başlatabilirsin.';

	/// tr: 'Profil sekmesinden Profili Düzenle’ye girerek adını, fotoğraflarını, hakkında bilgilerini ve ilgi alanlarını güncelleyebilirsin. Değişiklikler kaydettikten sonra görünür olur.'
	String get a7 => 'Profil sekmesinden Profili Düzenle’ye girerek adını, fotoğraflarını, hakkında bilgilerini ve ilgi alanlarını güncelleyebilirsin. Değişiklikler kaydettikten sonra görünür olur.';

	/// tr: 'Ayarlar’daki Bildirimler bölümünden mesaj, eşleşme ve diğer uyarıları açıp kapatabilirsin.'
	String get a8 => 'Ayarlar’daki Bildirimler bölümünden mesaj, eşleşme ve diğer uyarıları açıp kapatabilirsin.';

	/// tr: 'Ayarlar → Hesap Yönetimi → Satın Alımları Geri Yükle’ye dokun. Aynı mağaza hesabındaki uygun satın alımlar geri yüklenir.'
	String get a9 => 'Ayarlar → Hesap Yönetimi → Satın Alımları Geri Yükle’ye dokun. Aynı mağaza hesabındaki uygun satın alımlar geri yüklenir.';

	/// tr: 'Evet. Ayarlar → Sohbetleri Sil ile onayladıktan sonra tüm konuşmaların silinir. Bu işlem geri alınamaz.'
	String get a10 => 'Evet. Ayarlar → Sohbetleri Sil ile onayladıktan sonra tüm konuşmaların silinir. Bu işlem geri alınamaz.';

	/// tr: 'Hesap bilgilerin ve mesajların korumalı sistemlerde saklanır. İstersen hesap yönetimi üzerinden hesabını ve verilerini silme talebi oluşturabilirsin.'
	String get a11 => 'Hesap bilgilerin ve mesajların korumalı sistemlerde saklanır. İstersen hesap yönetimi üzerinden hesabını ve verilerini silme talebi oluşturabilirsin.';

	/// tr: 'Profil veya sohbet ekranındaki menüden engelle veya şikayet et seçeneklerini kullanabilirsin. Şikayetler ekibimiz tarafından incelenir.'
	String get a12 => 'Profil veya sohbet ekranındaki menüden engelle veya şikayet et seçeneklerini kullanabilirsin. Şikayetler ekibimiz tarafından incelenir.';

	/// tr: 'Ayarlar’daki Uygulamayı Paylaş ile bağlantıyı kopyalayıp arkadaşlarınla paylaşabilirsin.'
	String get a13 => 'Ayarlar’daki Uygulamayı Paylaş ile bağlantıyı kopyalayıp arkadaşlarınla paylaşabilirsin.';

	/// tr: 'Ayarlar → Hesap Yönetimi → Hesabı ve Verileri Sil yolunu izle. Sebep belirttikten sonra silme talebini onaylaman gerekir.'
	String get a14 => 'Ayarlar → Hesap Yönetimi → Hesabı ve Verileri Sil yolunu izle. Sebep belirttikten sonra silme talebini onaylaman gerekir.';
}

// Path: legal
class Translations$legal$tr {
	Translations$legal$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: 'Hizmet Şartları'
	String get termsTitle => 'Hizmet Şartları';

	/// tr: 'Gizlilik Politikası'
	String get privacyTitle => 'Gizlilik Politikası';

	/// tr: 'Son güncelleme: 16 Mart 2026 Veylo’ya hoş geldin. Hesap oluşturarak veya uygulamayı kullanarak bu Hizmet Şartları’nı kabul etmiş olursun. 1. Veylo nedir? Veylo; insanlarla tanışabileceğin, anonim sohbet edebileceğin, bağlantını zamanla güçlendirebileceğin ve karşılıklı onayla sesli veya yüz yüze aramaya geçebileceğin bir sosyal uygulamadır. 2. Hesabın Doğru bilgi vermeli ve giriş bilgilerini güvende tutmalısın. Hesabındaki aktivitelerden sen sorumlusun. Yaşadığın ülkenin yasalarına göre Veylo’yu kullanabilecek yaşta olmalısın. 3. Saygılı kullanım Taciz, tehdit, dolandırıcılık, kimliğe bürünme, yasa dışı içerik veya güvenlik özelliklerini atlatma girişimleri yasaktır. Kuralları ihlal eden içerik kaldırılabilir, özellikler kısıtlanabilir veya hesap askıya alınabilir. 4. Anonim sohbet ve profil açma Anonim sohbetlerde isim ve fotoğraf, bağlantı eşiklerine kadar gizli kalabilir. Tam profil açılışı karşılıklı onay gerektirir. Kimliğini açması için kimseyi zorlama. 5. Satın alımlar Bazı özellikler ücretli olabilir. Ödemeler App Store veya Google Play üzerinden yapılır. Restore Purchases, aynı mağaza hesabındaki uygun satın alımları geri yükler. İadeler mağaza politikasına tabidir. 6. Paylaştığın içerik İçeriğinin hakları sende kalır; Veylo’ya hizmeti sunmak için gereken ölçüde barındırma ve gösterme lisansı verirsin. Hakkın olmayan içeriği paylaşma. 7. Kullanımı sonlandırma İstediğin zaman Veylo’yu bırakabilir ve Ayarlar’dan hesap silme talebi oluşturabilirsin. Gerekirse hizmeti makul bildirimle değiştirebilir veya sonlandırabiliriz. 8. İletişim Bu şartlarla ilgili soruların için: support@veylo.app'
	String get termsBody => 'Son güncelleme: 16 Mart 2026\n\nVeylo’ya hoş geldin. Hesap oluşturarak veya uygulamayı kullanarak bu Hizmet Şartları’nı kabul etmiş olursun.\n\n1. Veylo nedir?\nVeylo; insanlarla tanışabileceğin, anonim sohbet edebileceğin, bağlantını zamanla güçlendirebileceğin ve karşılıklı onayla sesli veya yüz yüze aramaya geçebileceğin bir sosyal uygulamadır.\n\n2. Hesabın\nDoğru bilgi vermeli ve giriş bilgilerini güvende tutmalısın. Hesabındaki aktivitelerden sen sorumlusun. Yaşadığın ülkenin yasalarına göre Veylo’yu kullanabilecek yaşta olmalısın.\n\n3. Saygılı kullanım\nTaciz, tehdit, dolandırıcılık, kimliğe bürünme, yasa dışı içerik veya güvenlik özelliklerini atlatma girişimleri yasaktır. Kuralları ihlal eden içerik kaldırılabilir, özellikler kısıtlanabilir veya hesap askıya alınabilir.\n\n4. Anonim sohbet ve profil açma\nAnonim sohbetlerde isim ve fotoğraf, bağlantı eşiklerine kadar gizli kalabilir. Tam profil açılışı karşılıklı onay gerektirir. Kimliğini açması için kimseyi zorlama.\n\n5. Satın alımlar\nBazı özellikler ücretli olabilir. Ödemeler App Store veya Google Play üzerinden yapılır. Restore Purchases, aynı mağaza hesabındaki uygun satın alımları geri yükler. İadeler mağaza politikasına tabidir.\n\n6. Paylaştığın içerik\nİçeriğinin hakları sende kalır; Veylo’ya hizmeti sunmak için gereken ölçüde barındırma ve gösterme lisansı verirsin. Hakkın olmayan içeriği paylaşma.\n\n7. Kullanımı sonlandırma\nİstediğin zaman Veylo’yu bırakabilir ve Ayarlar’dan hesap silme talebi oluşturabilirsin. Gerekirse hizmeti makul bildirimle değiştirebilir veya sonlandırabiliriz.\n\n8. İletişim\nBu şartlarla ilgili soruların için: support@veylo.app';

	/// tr: 'Son güncelleme: 16 Mart 2026 Bu Gizlilik Politikası, Veylo’nun bilgilerini nasıl topladığını, kullandığını ve koruduğunu açıklar. 1. Topladığımız bilgiler • Hesap verileri: e-posta, görünen ad, profil fotoğrafları, bio, tercihler • Kullanım verileri: sohbetler, bağlantı ilerlemesi, kullandığın arama özellikleri, temel cihaz/uygulama bilgileri • Satın alımlar: ücretli özellikleri açmak ve geri yüklemek için gerekli mağaza fiş bilgileri 2. Nasıl kullanırız? Verilerini Veylo’yu işletmek, eşleşme ve sohbet deneyimini kişiselleştirmek, topluluğu güvende tutmak, satın alımları işlemek ve ürünü geliştirmek için kullanırız. Kişisel verilerini satmayız. 3. Anonim mod Anonim sohbetlerde diğer kullanıcıların gördüğü bilgiler (ör. maskeli isim veya bulanık fotoğraf) kilit açma kuralları ve karşılıklı onayla sınırlıdır. Özelliğin güvenli çalışması için hesap tanımlayıcılarına yine ihtiyaç duyarız. 4. Paylaşım Verileri yalnızca barındırma, analiz veya ödeme gibi hizmet sağlayıcılarla gerektiği ölçüde paylaşabiliriz. Yasal zorunluluk veya kullanıcıları zarardan koruma durumlarında da açıklama yapılabilir. 5. Saklama Hesabın aktifken ve yasal, güvenlik ile faturalama gerekçeleriyle gerektiği süre veriyi saklarız. Silme talebi tamamlandıktan sonra, zorunlu saklama dışında kişisel veriler silinir veya anonimleştirilir. 6. Seçeneklerin Profilini düzenleyebilir, bildirimleri yönetebilir, hesap silme talebi oluşturabilir ve verilerin hakkında bize yazabilirsin. Mağaza satın alımları Apple veya Google üzerinden de yönetilir. 7. Güvenlik Bilgilerini korumak için makul teknik ve idari önlemler alırız. Hiçbir sistem tamamen risksiz değildir; güçlü parola kullan ve cihazını güncel tut. 8. İletişim Gizlilik soruları: privacy@veylo.app'
	String get privacyBody => 'Son güncelleme: 16 Mart 2026\n\nBu Gizlilik Politikası, Veylo’nun bilgilerini nasıl topladığını, kullandığını ve koruduğunu açıklar.\n\n1. Topladığımız bilgiler\n• Hesap verileri: e-posta, görünen ad, profil fotoğrafları, bio, tercihler\n• Kullanım verileri: sohbetler, bağlantı ilerlemesi, kullandığın arama özellikleri, temel cihaz/uygulama bilgileri\n• Satın alımlar: ücretli özellikleri açmak ve geri yüklemek için gerekli mağaza fiş bilgileri\n\n2. Nasıl kullanırız?\nVerilerini Veylo’yu işletmek, eşleşme ve sohbet deneyimini kişiselleştirmek, topluluğu güvende tutmak, satın alımları işlemek ve ürünü geliştirmek için kullanırız. Kişisel verilerini satmayız.\n\n3. Anonim mod\nAnonim sohbetlerde diğer kullanıcıların gördüğü bilgiler (ör. maskeli isim veya bulanık fotoğraf) kilit açma kuralları ve karşılıklı onayla sınırlıdır. Özelliğin güvenli çalışması için hesap tanımlayıcılarına yine ihtiyaç duyarız.\n\n4. Paylaşım\nVerileri yalnızca barındırma, analiz veya ödeme gibi hizmet sağlayıcılarla gerektiği ölçüde paylaşabiliriz. Yasal zorunluluk veya kullanıcıları zarardan koruma durumlarında da açıklama yapılabilir.\n\n5. Saklama\nHesabın aktifken ve yasal, güvenlik ile faturalama gerekçeleriyle gerektiği süre veriyi saklarız. Silme talebi tamamlandıktan sonra, zorunlu saklama dışında kişisel veriler silinir veya anonimleştirilir.\n\n6. Seçeneklerin\nProfilini düzenleyebilir, bildirimleri yönetebilir, hesap silme talebi oluşturabilir ve verilerin hakkında bize yazabilirsin. Mağaza satın alımları Apple veya Google üzerinden de yönetilir.\n\n7. Güvenlik\nBilgilerini korumak için makul teknik ve idari önlemler alırız. Hiçbir sistem tamamen risksiz değildir; güçlü parola kullan ve cihazını güncel tut.\n\n8. İletişim\nGizlilik soruları: privacy@veylo.app';
}

// Path: logout
class Translations$logout$tr {
	Translations$logout$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: 'Çıkış yap'
	String get title => 'Çıkış yap';

	/// tr: 'Çıkış yapmak istediğinden emin misin?'
	String get subtitle => 'Çıkış yapmak istediğinden emin misin?';

	/// tr: 'İptal'
	String get cancel => 'İptal';

	/// tr: 'Çıkış yap'
	String get confirm => 'Çıkış yap';
}

// Path: deleteAccount
class Translations$deleteAccount$tr {
	Translations$deleteAccount$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: 'Hesap silme talebi gönder'
	String get title => 'Hesap silme talebi gönder';

	/// tr: 'Hesabını silmek istediğinden emin misin?'
	String get subtitle => 'Hesabını silmek istediğinden emin misin?';

	/// tr: 'Gitmeni istemiyoruz ama seni anlıyoruz.'
	String get reasonTitle => 'Gitmeni istemiyoruz ama seni anlıyoruz.';

	/// tr: ''
	String get reasonBefore => '';

	/// tr: ' deneyimini iyileştirmemiz için bize neden ayrılmak istediğini söyler misin?'
	String get reasonAfter => ' deneyimini iyileştirmemiz için bize neden ayrılmak istediğini söyler misin?';

	/// tr: 'Hesabını neden silmek istiyorsun'
	String get reasonLabel => 'Hesabını neden silmek istiyorsun';

	/// tr: 'Mesajınızı yazın'
	String get reasonHint => 'Mesajınızı yazın';

	/// tr: 'İptal'
	String get cancel => 'İptal';

	/// tr: 'Talep Oluştur'
	String get createRequest => 'Talep Oluştur';

	/// tr: 'Hesap silme talebini göndermek istediğinden emin misin?'
	String get confirmTitle => 'Hesap silme talebini göndermek istediğinden emin misin?';

	/// tr: 'Onaylarsan hesap silme talebin oluşturulacak'
	String get confirmSubtitle => 'Onaylarsan hesap silme talebin oluşturulacak';

	/// tr: 'Sil'
	String get delete => 'Sil';
}

// Path: storyText
class Translations$storyText$tr {
	Translations$storyText$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: 'Kalın'
	String get bold => 'Kalın';

	/// tr: 'İtalik'
	String get italic => 'İtalik';

	/// tr: 'Büyük harf'
	String get uppercase => 'Büyük harf';

	/// tr: 'Altı çizili'
	String get underline => 'Altı çizili';

	/// tr: 'İptal'
	String get cancel => 'İptal';

	/// tr: 'Galeri açılamadı'
	String get galleryError => 'Galeri açılamadı';
}

// Path: tokens
class Translations$tokens$tr {
	Translations$tokens$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: 'Boost'
	String get boostTitle => 'Boost';

	/// tr: 'Geçmiş'
	String get history => 'Geçmiş';

	/// tr: 'Bakiyen'
	String get yourBalance => 'Bakiyen';

	/// tr: '{count} Token'
	String balanceTokens({required Object count}) => '${count} Token';

	/// tr: 'Daha fazla token al'
	String get getMore => 'Daha fazla token al';

	/// tr: 'Günlük giriş'
	String get checkinTitle => 'Günlük giriş';

	/// tr: 'Her gün üst üste topla, günde {max} tokene kadar kazan'
	String checkinSubtitle({required Object max}) => 'Her gün üst üste topla, günde ${max} tokene kadar kazan';

	/// tr: '{n}. Gün'
	String day({required Object n}) => '${n}. Gün';

	/// tr: '{n}. gün tokenlerini topla'
	String collectDay({required Object n}) => '${n}. gün tokenlerini topla';

	/// tr: '{n}. gün için yarın tekrar gel'
	String collectedToday({required Object n}) => '${n}. gün için yarın tekrar gel';

	/// tr: '30 dakika'
	String get duration30m => '30 dakika';

	/// tr: '1 saat'
	String get duration1h => '1 saat';

	/// tr: '2 saat'
	String get duration2h => '2 saat';

	/// tr: '{n} kat görünürlük'
	String visibility({required Object n}) => '${n} kat görünürlük';

	/// tr: '{count} token ile Boost'
	String boostFor({required Object count}) => '${count} token ile Boost';

	/// tr: '{time} saatine kadar öne çıkarıldı'
	String boostActive({required Object time}) => '${time} saatine kadar öne çıkarıldı';

	/// tr: 'Profilin öne çıkarıldı!'
	String get boostDone => 'Profilin öne çıkarıldı!';

	/// tr: 'Henüz token hareketi yok'
	String get historyEmpty => 'Henüz token hareketi yok';

	/// tr: 'Bakiyen {count} token'
	String balanceLine({required Object count}) => 'Bakiyen ${count} token';

	/// tr: 'Token Satın Alma'
	String get reasonPurchase => 'Token Satın Alma';

	/// tr: 'Günlük giriş'
	String get reasonCheckin => 'Günlük giriş';

	/// tr: 'Hoş geldin hediyesi'
	String get reasonWelcome => 'Hoş geldin hediyesi';

	/// tr: 'Cinsiyet filtreli arama'
	String get reasonGenderFilter => 'Cinsiyet filtreli arama';

	/// tr: 'Görüntülü arama'
	String get reasonVideoCall => 'Görüntülü arama';

	/// tr: 'Oda oluşturma'
	String get reasonRoomCreate => 'Oda oluşturma';

	/// tr: 'Profil çerçevesi'
	String get reasonBorder => 'Profil çerçevesi';

	/// tr: 'Gönderi öne çıkarma'
	String get reasonPostBoost => 'Gönderi öne çıkarma';

	/// tr: 'İade'
	String get reasonRefund => 'İade';

	/// tr: 'Bakiye düzeltme'
	String get reasonAdjust => 'Bakiye düzeltme';

	/// tr: 'Daha fazla token al'
	String get packsTitle => 'Daha fazla token al';

	/// tr: 'Bir token paketi seç'
	String get packsSubtitle => 'Bir token paketi seç';

	/// tr: '{count} token'
	String packTokens({required Object count}) => '${count} token';

	/// tr: 'Satın al'
	String get buy => 'Satın al';

	/// tr: 'Bakiyene {count} token eklendi'
	String purchaseDone({required Object count}) => 'Bakiyene ${count} token eklendi';

	/// tr: 'Yeterli token yok'
	String get notEnoughTitle => 'Yeterli token yok';

	/// tr: 'Devam etmek için bakiyeni yükle.'
	String get notEnoughSubtitle => 'Devam etmek için bakiyeni yükle.';
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

	/// tr: '8 sn'
	String get statAvgValue => '8 sn';

	/// tr: 'Akıllı Eşleşmeyi Başlat'
	String get startSmartMatch => 'Akıllı Eşleşmeyi Başlat';

	/// tr: 'Eşleşmen aranıyor'
	String get findingTitle => 'Eşleşmen aranıyor';

	/// tr: 'Ruh halin ve ilgi alanların doğru kişiyle eşleştiriliyor'
	String get findingSubtitle => 'Ruh halin ve ilgi alanların doğru kişiyle eşleştiriliyor';

	/// tr: 'Ruh hali analiz edildi'
	String get findingStepMood => 'Ruh hali analiz edildi';

	/// tr: 'İlgi alanları eşleşti'
	String get findingStepInterests => 'İlgi alanları eşleşti';

	/// tr: 'Uyum hesaplanıyor...'
	String get findingStepCompatibility => 'Uyum hesaplanıyor...';

	/// tr: 'İçerik hazırlanıyor...'
	String get findingStepContent => 'İçerik hazırlanıyor...';

	/// tr: 'Şu an {count} kişi çevrimiçi'
	String findingOnline({required Object count}) => 'Şu an ${count} kişi çevrimiçi';

	/// tr: 'Eşleşmen'
	String get yourMatchTitle => 'Eşleşmen';

	/// tr: 'Cevaplarına göre eşleştin'
	String get yourMatchSubtitle => 'Cevaplarına göre eşleştin';

	/// tr: '%{percent} uyum'
	String vibeMatch({required Object percent}) => '%${percent} uyum';

	/// tr: 'Sohbete Başla'
	String get startChatting => 'Sohbete Başla';

	/// tr: '{name}, {age}'
	String matchNameAge({required Object name, required Object age}) => '${name}, ${age}';

	/// tr: 'Hissedebileceğini bilmediğin şeyleri hissettireceğim.'
	String get matchBio => 'Hissedebileceğini bilmediğin şeyleri hissettireceğim.';

	/// tr: 'Önceki'
	String get swipePrevious => 'Önceki';

	/// tr: 'Sonraki'
	String get swipeNext => 'Sonraki';

	/// tr: 'Parmağını Kaydır'
	String get swipeFinger => 'Parmağını Kaydır';

	/// tr: 'Şu an uygun kimse yok. Biraz sonra tekrar dene.'
	String get noMatch => 'Şu an uygun kimse yok. Biraz sonra tekrar dene.';
}

// Path: discover.privateRoom
class Translations$discover$privateRoom$tr {
	Translations$discover$privateRoom$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: 'Bu gizli bir oda. Erişimi token ile aç.'
	String get subtitle => 'Bu gizli bir oda. Erişimi token ile aç.';

	/// tr: 'Oda erişimi'
	String get roomAccess => 'Oda erişimi';

	/// tr: 'Bakiyen'
	String get yourBalance => 'Bakiyen';

	/// tr: '{count} token'
	String tokensAmount({required Object count}) => '${count} token';

	/// tr: '{count} token ile katıl'
	String joinForTokens({required Object count}) => '${count} token ile katıl';

	/// tr: 'İptal'
	String get cancel => 'İptal';
}

// Path: discover.roomToken
class Translations$discover$roomToken$tr {
	Translations$discover$roomToken$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: 'Erişimi token ile aç.'
	String get subtitle => 'Erişimi token ile aç.';

	/// tr: 'Oda erişimi'
	String get roomAccess => 'Oda erişimi';

	/// tr: 'Bakiyen'
	String get yourBalance => 'Bakiyen';

	/// tr: '{count} token'
	String tokensAmount({required Object count}) => '${count} token';

	/// tr: '{count} token ile katıl'
	String joinForTokens({required Object count}) => '${count} token ile katıl';

	/// tr: 'İptal'
	String get cancel => 'İptal';
}

// Path: discover.privateRequest
class Translations$discover$privateRequest$tr {
	Translations$discover$privateRequest$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: 'Katılma isteği'
	String get title => 'Katılma isteği';

	/// tr: '{name} · {count} üye'
	String roomInfo({required Object name, required Object count}) => '${name} · ${count} üye';

	/// tr: 'Bir şey yaz (isteğe bağlı)...'
	String get messageHint => 'Bir şey yaz (isteğe bağlı)...';

	/// tr: 'İstek Gönder'
	String get sendRequest => 'İstek Gönder';

	/// tr: 'İsteğini oda yöneticisi inceleyecek'
	String get adminReview => 'İsteğini oda yöneticisi inceleyecek';
}

// Path: discover.roomApproved
class Translations$discover$roomApproved$tr {
	Translations$discover$roomApproved$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: 'İçeridesin!'
	String get title => 'İçeridesin!';

	/// tr: '{name} içinde yerin hazır'
	String subtitle({required Object name}) => '${name} içinde yerin hazır';

	/// tr: 'Devam Et'
	String get continueLabel => 'Devam Et';
}

// Path: discover.createSpace
class Translations$discover$createSpace$tr {
	Translations$discover$createSpace$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: 'Oda veya Grup Oluştur'
	String get title => 'Oda veya Grup Oluştur';

	/// tr: 'Grup veya canlı oda oluşturarak kitlelere hitap et'
	String get subtitle => 'Grup veya canlı oda oluşturarak kitlelere hitap et';

	/// tr: 'Oda'
	String get room => 'Oda';

	/// tr: 'Grup'
	String get group => 'Grup';

	/// tr: 'Hesabımı Gizle'
	String get hideAccount => 'Hesabımı Gizle';

	/// tr: 'Oluştur'
	String get create => 'Oluştur';

	/// tr: 'İptal'
	String get cancel => 'İptal';

	/// tr: 'Oda Oluştur'
	String get createRoomTitle => 'Oda Oluştur';

	/// tr: 'Grup Oluştur'
	String get createGroupTitle => 'Grup Oluştur';

	/// tr: 'Oluşturduğun gruba bir isim ver'
	String get nameSubtitle => 'Oluşturduğun gruba bir isim ver';

	/// tr: 'Gece Kuşu'
	String get nameHint => 'Gece Kuşu';

	/// tr: '{count} tokene oluştur'
	String createRoomFor({required Object count}) => '${count} tokene oluştur';
}

// Path: discover.liveRoom
class Translations$discover$liveRoom$tr {
	Translations$discover$liveRoom$tr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// tr: '(Yönetici)'
	String get adminSuffix => '(Yönetici)';

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

	/// tr: 'Oda kapandı.'
	String get roomEnded => 'Oda kapandı.';

	/// tr: '{name} katılmak istiyor'
	String wantsToJoin({required Object name}) => '${name} katılmak istiyor';

	/// tr: 'Onayla'
	String get approve => 'Onayla';

	/// tr: 'Odadan çıkar'
	String get remove => 'Odadan çıkar';

	/// tr: 'Odadan çıkarıldın.'
	String get removed => 'Odadan çıkarıldın.';

	/// tr: 'Profilini görmek istiyorum'
	String get seeProfile => 'Profilini görmek istiyorum';

	/// tr: 'Mikrofonunu kapat'
	String get muteMic => 'Mikrofonunu kapat';

	/// tr: 'Mikrofonunu aç'
	String get unmuteMic => 'Mikrofonunu aç';

	/// tr: '{room} odasındaki {name} seni görmek istedi.'
	String wantsToSeeYou({required Object room, required Object name}) => '${room} odasındaki ${name} seni görmek istedi.';

	/// tr: '{name} mikrofonunu açmanı istiyor.'
	String wantsMic({required Object name}) => '${name} mikrofonunu açmanı istiyor.';
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

	/// tr: 'Yönetici'
	String get admin => 'Yönetici';

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

	/// tr: 'Filtreler'
	String get title => 'Filtreler';

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

	/// tr: 'Güzel bir günün ardından bir fincan kahve gibisi yok. <3'
	String get sampleCaption => 'Güzel bir günün ardından bir fincan kahve gibisi yok. <3';

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

	/// tr: 'TASLAK'
	String get draft => 'TASLAK';

	/// tr: 'HİKÂYE'
	String get story => 'HİKÂYE';

	/// tr: 'Paylaş'
	String get share => 'Paylaş';

	/// tr: 'Bir şeyler yaz...'
	String get textPlaceholder => 'Bir şeyler yaz...';

	/// tr: 'Taslak olarak kaydedilsin mi?'
	String get draftPrompt => 'Taslak olarak kaydedilsin mi?';

	/// tr: 'Taslağa Kaydet'
	String get saveToDraft => 'Taslağa Kaydet';

	/// tr: 'Çöpe Taşı'
	String get moveToTrash => 'Çöpe Taşı';

	/// tr: 'Kaydet'
	String get save => 'Kaydet';

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

	/// tr: 'Öne Çıkan'
	String get title => 'Öne Çıkan';

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
			'chats.title' => 'Sohbetler',
			'chats.search' => 'Ara',
			'chats.messagesSection' => 'Mesajlar',
			'chats.request' => 'İstekler',
			'chats.emptyRequestTitle' => 'Son mesaj bildirimi yok',
			'chats.emptyRequestSubtitle' => '30 günden eski istekler gösterilmez.',
			'chats.noteAdd' => 'Not Ekle',
			'chats.anonymous' => 'Anonim',
			'chats.online' => 'çevrimiçi',
			'chats.offline' => 'çevrimdışı',
			'chats.connection' => 'Bağlantı',
			'chats.connectionPercent' => ({required Object n}) => '%${n}',
			'chats.connectionProgressTitle' => 'Bağlantı İlerlemesi',
			'chats.milestoneInitial' => 'Adının baş harfi',
			'chats.milestoneInitialHint' => '%25\'te açıldı',
			'chats.milestoneInitialLocked' => '%25\'te açılır',
			'chats.milestonePhoto' => 'Bulanık fotoğraf önizlemesi',
			'chats.milestonePhotoHint' => '%70\'te açılır',
			'chats.milestoneFull' => 'Tam profil görüntüleme',
			'chats.milestoneFullHint' => '%100\'de karşılıklı onayla',
			'chats.sampleAnonymousMessage' => 'Merhaba, tanıştığımıza memnun oldum. Biraz kendinden bahseder misin?',
			'chats.strangerSampleMessage' => 'Merhaba, tanıştığımıza memnun oldum. Biraz kendinden bahseder misin?',
			'chats.approve' => 'Onayla',
			'chats.blockUser' => 'Engelle',
			'chats.reject' => 'Reddet',
			'chats.messageHint' => 'Selam! Nasılsın?',
			'chats.revealTitle' => '%100\'e ulaştınız',
			'chats.revealSubtitle' => 'Tam profillerinizi birbirinize açmak ister misiniz? İki tarafın da onaylaması gerekir.',
			'chats.revealWaiting' => ({required Object name}) => '${name} kişisinin onayı bekleniyor',
			'chats.revealCta' => 'Profilimi aç',
			'chats.revealNotYet' => 'Henüz değil',
			'chats.seen' => 'Görüldü',
			'chats.typing' => 'yazıyor…',
			'chats.noteYou' => 'Sen',
			'chats.noteSheetTitle' => 'Not paylaş',
			'chats.noteSheetSubtitle' => 'Notun 24 saat görünür',
			'chats.noteHint' => 'Aklında ne var?',
			'chats.noteShare' => 'Paylaş',
			'chats.noteDelete' => 'Notu sil',
			'profile.eyebrow' => 'Profil',
			'profile.title' => 'Ayarlar',
			'profile.editProfile' => 'Profili Düzenle',
			'profile.statLike' => 'Beğeni',
			'profile.statFollow' => 'Takip',
			'profile.statFollower' => 'Takipçi',
			'profile.promoTitle' => 'Daha Fazla Mesaj Al!',
			'profile.promoSubtitle' => 'Öne çık, listenin en üstünde görün',
			'profile.standOut' => 'Öne Çık',
			'profile.tabPosts' => 'Gönderi',
			'profile.tabVideo' => 'Video',
			'profile.tabSaved' => 'Kaydedilenler',
			'profile.save' => 'Kaydet',
			'profile.changePhoto' => 'Fotoğrafı Değiştir',
			'profile.changeBorder' => 'Çerçeveyi Değiştir',
			'profile.interest' => 'İlgi Alanları',
			'profile.name' => 'Ad',
			'profile.changeName' => 'İsim Değiştir',
			'profile.changePassword' => 'Şifre Değiştir',
			'profile.confirmPassword' => 'Şifreyi Onayla',
			'profile.email' => 'E-posta',
			'profile.accountManagement' => 'Hesap Yönetimi',
			'profile.settingsAbout' => 'Hakkında',
			'profile.settingsAccount' => 'Hesap Ayarları',
			'profile.settingsSupport' => 'Destek',
			'profile.shareApp' => 'Uygulamayı Paylaş',
			'profile.shareAppTitle' => 'Arkadaşlarınla Paylaş',
			'profile.shareAppSubtitle' => 'Veylo’yu arkadaşlarınla paylaş, birlikte keşfedin!',
			'profile.shareAppLabel' => 'Uygulama bağlantısı',
			'profile.rateApp' => 'Bizi Beğendin mi? Puan Ver',
			'profile.notifications' => 'Bildirimler',
			'profile.password' => 'Şifre',
			'profile.deleteConversation' => 'Sohbetleri Sil',
			'profile.faqHelp' => 'SSS ve Yardım',
			'profile.restorePurchases' => 'Satın Alımları Geri Yükle',
			'profile.termsOfService' => 'Hizmet Şartları',
			'profile.privacyPolicy' => 'Gizlilik Politikası',
			'profile.restorePurchasesDone' => 'Satın alımlar kontrol edildi',
			'profile.conversationsDeleted' => 'Tüm sohbetler silindi',
			'profile.logOut' => 'Çıkış Yap',
			'profile.deleteAccountAndData' => 'Hesabı ve Verileri Sil',
			'profile.passwordPlaceholder' => '********',
			'profile.height' => 'Boy',
			'profile.addHeight' => 'Boy Ekle',
			'profile.heightCm' => ({required Object value}) => '${value} cm',
			'profile.languages' => 'Diller',
			'profile.relationshipGoals' => 'İlişki Hedefleri',
			'profile.lookingFor' => 'Aradığım',
			'profile.newFriends' => '👋 Yeni Arkadaşlar',
			'profile.goalLongTermOpenToShort' => '💕 Uzun vadeli, kısaya da açığım',
			'profile.goalLongTermRelationship' => '💘 Uzun vadeli ilişki',
			'profile.goalNewFriends' => '👋 Yeni arkadaşlar',
			'profile.goalShortTermFun' => '🥃 Kısa süreli eğlence',
			'profile.goalStillFiguringItOut' => '🤔 Henüz karar vermedim',
			'profile.basics' => 'Temel Bilgiler',
			'profile.zodiac' => 'Burç',
			'profile.zodiacValue' => 'Akrep',
			'profile.education' => 'Eğitim',
			'profile.educationValue' => 'Lisans',
			'profile.educationHighSchool' => 'Lise',
			'profile.educationAssociates' => 'Ön Lisans',
			'profile.educationBachelors' => 'Lisans',
			'profile.educationMasters' => 'Yüksek Lisans',
			'profile.educationPhd' => 'Doktora',
			'profile.voiceRecord' => 'Ses Kaydı',
			'profile.addVoice' => 'Ses Ekle',
			'profile.lifestyle' => 'Yaşam Tarzı',
			'profile.pets' => 'Evcil Hayvanlar',
			'profile.petsValue' => 'Kedim var',
			'profile.petsDontWant' => 'Evcil hayvan istemiyorum',
			'profile.petsAllergic' => 'Evcil hayvanlara alerjim var',
			'profile.petsHaveCat' => 'Kedim var',
			'profile.petsHaveDog' => 'Köpeğim var',
			'profile.petsHaveCatsAndDogs' => 'Kedilerim ve köpeklerim var',
			'profile.petsHaveOther' => 'Başka evcil hayvanlarım var',
			'profile.drinking' => 'Alkol',
			'profile.drinkingValue' => 'Özel günlerde',
			'profile.drinkingNever' => 'Hiç',
			'profile.drinkingSpecialOccasions' => 'Özel günlerde',
			'profile.drinkingSocially' => 'Sosyal ortamlarda',
			'profile.drinkingFrequently' => 'Sık sık',
			'profile.drinkingSober' => 'Hiç içmiyorum',
			'profile.drinkingPreferNotToSay' => 'Belirtmek istemiyorum',
			'profile.smoking' => 'Sigara',
			'profile.smokingValue' => 'İçmiyorum',
			'profile.smokingNonSmoker' => 'İçmiyorum',
			'profile.smokingSocialSmoker' => 'Sosyal ortamlarda',
			'profile.smokingSmoker' => 'İçiyorum',
			'profile.smokingTryingToQuit' => 'Bırakmaya çalışıyorum',
			'profile.smokingWhenDrinking' => 'İçki içerken',
			'profile.smokingPreferNotToSay' => 'Belirtmek istemiyorum',
			'profile.gender' => 'Cinsiyet',
			'profile.genderFemale' => 'Kadın',
			'profile.genderMale' => 'Erkek',
			'profile.genderPreferNotToSay' => 'Belirtmek istemiyorum',
			'profile.visible' => 'Görünür',
			'profile.profileVisibility' => 'Profil Görünürlüğü',
			'profile.language' => 'Dil',
			'profile.borderTitle' => 'Profil Çerçevesi',
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
			'profile.follow' => 'Takip Et',
			'profile.following' => 'Takip Ediliyor',
			'profile.followPageTitle' => 'Takip',
			'profile.followTabFollowing' => 'Takip',
			'profile.followTabFollowers' => 'Takipçi',
			'profile.followSearch' => 'Ara',
			'profile.unfollow' => 'Takibi Bırak',
			'profile.followSortTitle' => 'Sırala',
			'profile.followSortRecent' => 'En son takip ettiğim kişiler',
			'profile.followSortNotFollowingMe' => 'Beni takip etmeyenler',
			'profile.followSortNotFollowedByMe' => 'Benim takip etmediklerim',
			'profile.followSortShowResult' => 'Sonuçları Göster',
			'profile.followSortEmpty' => 'Bu filtreye uyan kimse yok',
			'profile.shareTitle' => 'Arkadaşlarınla Paylaş',
			'profile.shareSubtitle' => 'Arkadaşlarınla bağlantı kurunca\nher şey daha eğlenceli!',
			'profile.shareProfileLabel' => 'Profili paylaş',
			'profile.shareLinkCopied' => 'Bağlantı kopyalandı',
			'profile.restrict' => 'Kısıtla',
			'profile.block' => 'Engelle',
			'profile.report' => 'Şikayet Et',
			'profile.blockTitle' => ({required Object username}) => '${username} engellensin mi?',
			'profile.blockBody' => 'Bu, kişinin sahip olduğu ya da ileride oluşturacağı diğer hesapları da engeller. Engeli istediğin zaman kaldırabilirsin.',
			'profile.blockAndReport' => 'Engelle ve şikayet et',
			'profile.restrictTitle' => ({required Object username}) => '${username} kısıtlansın mı?',
			'profile.restrictBody' => 'Çevrimiçi olduğunu ya da mesajlarını okuduğunu göremez. Bunu istediğin zaman değiştirebilirsin.',
			'profile.restrictAndReport' => 'Kısıtla ve şikayet et',
			'profile.reportTitle' => 'Şikayet sebebini merak ediyoruz',
			'profile.reportSubtitle' => 'Sana daha iyi bir deneyim sunabilmek için kullanıcıyı neden şikayet etmek istediğini açıklar mısın?',
			'profile.reportMessageLabel' => 'Şikayet Mesajı',
			'profile.reportMessageHint' => 'Mesajınızı yazın',
			'profile.reportCancel' => 'İptal',
			'profile.sendReport' => 'Şikayeti Gönder',
			'profile.notSet' => 'Belirtilmedi',
			'profile.reportSent' => 'Teşekkürler, raporunu aldık.',
			'profile.emailVerificationSent' => ({required Object email}) => '${email} adresine onay bağlantısı gönderdik. Onaylayınca e-postan değişir.',
			'profile.passwordChanged' => 'Şifren güncellendi.',
			'profile.passwordMismatch' => 'Şifreler eşleşmiyor.',
			'nav.discover' => 'Keşfet',
			'nav.chat' => 'Sohbet',
			'nav.call' => 'Ara',
			'nav.vibes' => 'Vibes',
			'nav.profile' => 'Profil',
			'call.title' => '60 Saniyelik Yabancı',
			'call.subtitle' => 'Rastgele bir yabancıyla 60 saniye konuş — tamamen anonim. Profil yok, fotoğraf yok, isim yok. Sadece bir ses ve bir an.',
			'call.findingTitle' => 'Bir yabancı aranıyor...',
			'call.findingSubtitle' => '60 saniye anonim konuşacaksın. Profil yok, isim yok.',
			'call.callStranger' => 'Yabancıyı Ara - 10 Token',
			'call.cancel' => 'İptal',
			'call.female' => 'Kadın',
			'call.male' => 'Erkek',
			'call.nonBinary' => 'Non-binary',
			'call.preferNotToSay' => 'Fark etmez',
			'call.anonymousBadge' => '🎙️ Anonim sesli arama',
			'call.stranger' => 'Yabancı',
			'call.secondsLeft' => ({required Object n}) => '${n} sn',
			'call.timesUpTitle' => 'Süre doldu!',
			'call.timesUpSubtitle' => 'Konuşmaya devam etmek ister misin? İkiniz de evet derseniz sohbet açılır.',
			'call.keepTalking' => 'Konuşmaya Devam Et',
			'call.endCall' => 'Aramayı Bitir',
			'call.waitingOther' => 'Karşı taraf bekleniyor...',
			'call.callStrangerFree' => 'Yabancıyı Ara',
			'call.peerLeft' => 'Karşı taraf aramayı bitirdi.',
			'call.noKeep' => 'Bu sefer sohbet açılmadı.',
			'call.videoWaiting' => 'Görüntülü aramayı kabul etmesi bekleniyor...',
			'call.videoDeclined' => 'Görüntülü aramayı reddetti.',
			'call.micDenied' => 'Arama için mikrofon izni gerekli. Ayarlar\'dan açabilirsin.',
			'call.videoCost' => 'Görüntülü arama: 15 dk / 20 token',
			'call.calling' => 'Aranıyor',
			'call.accept' => 'Kabul et',
			'call.decline' => 'Reddet',
			'call.switchToVideo' => 'Görüntülü aramaya geçmek ister misin?',
			'call.noMatchTitle' => 'Şu an uygun kimse yok',
			'call.noMatchBody' => 'Şu anda konuşmaya müsait bir anonim kullanıcı bulamadık. Biraz sonra tekrar dene.',
			'call.noMatchOk' => 'Tamam',
			'vibes.search' => 'Ara',
			'vibes.sendMessage' => 'Mesaj Gönder',
			'vibes.wantsToTalk' => 'Şu an bunun hakkında konuşmak istiyor',
			'vibes.shareTitle' => 'Vibe Paylaş',
			'vibes.replyTitle' => 'Vibe\'a Cevap Ver',
			'vibes.shareHint' => 'Bir şeyler yaz',
			'vibes.shareAnonymous' => 'Anonim olarak paylaş',
			'vibes.empty' => 'Son 24 saatte vibe yok. İlkini sen paylaş!',
			'vibes.deleteTitle' => 'Bu vibe silinsin mi?',
			'vibes.delete' => 'Sil',
			'vibes.cancel' => 'Vazgeç',
			'discover.title' => 'Keşfet',
			'discover.tabRooms' => 'Odalar',
			'discover.tabDiscover' => 'Keşfet',
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
			'discover.aiMatch.statAvgValue' => '8 sn',
			'discover.aiMatch.startSmartMatch' => 'Akıllı Eşleşmeyi Başlat',
			'discover.aiMatch.findingTitle' => 'Eşleşmen aranıyor',
			'discover.aiMatch.findingSubtitle' => 'Ruh halin ve ilgi alanların doğru kişiyle eşleştiriliyor',
			'discover.aiMatch.findingStepMood' => 'Ruh hali analiz edildi',
			'discover.aiMatch.findingStepInterests' => 'İlgi alanları eşleşti',
			'discover.aiMatch.findingStepCompatibility' => 'Uyum hesaplanıyor...',
			'discover.aiMatch.findingStepContent' => 'İçerik hazırlanıyor...',
			'discover.aiMatch.findingOnline' => ({required Object count}) => 'Şu an ${count} kişi çevrimiçi',
			'discover.aiMatch.yourMatchTitle' => 'Eşleşmen',
			'discover.aiMatch.yourMatchSubtitle' => 'Cevaplarına göre eşleştin',
			'discover.aiMatch.vibeMatch' => ({required Object percent}) => '%${percent} uyum',
			'discover.aiMatch.startChatting' => 'Sohbete Başla',
			'discover.aiMatch.matchNameAge' => ({required Object name, required Object age}) => '${name}, ${age}',
			'discover.aiMatch.matchBio' => 'Hissedebileceğini bilmediğin şeyleri hissettireceğim.',
			'discover.aiMatch.swipePrevious' => 'Önceki',
			'discover.aiMatch.swipeNext' => 'Sonraki',
			'discover.aiMatch.swipeFinger' => 'Parmağını Kaydır',
			'discover.aiMatch.noMatch' => 'Şu an uygun kimse yok. Biraz sonra tekrar dene.',
			'discover.searchHint' => 'Ara',
			'discover.allRooms' => 'Tüm Odalar',
			'discover.allGroups' => 'Tüm Gruplar',
			'discover.seeAll' => 'Tümünü Gör',
			'discover.live' => 'Canlı',
			'discover.join' => 'Katıl',
			'discover.request' => 'İstek Gönder',
			'discover.requested' => 'İstek Gönderildi',
			'discover.private' => 'Gizli',
			'discover.moreCount' => ({required Object count}) => '+${count} kişi daha',
			'discover.activeCount' => ({required Object count}) => '${count} aktif',
			'discover.membersCount' => ({required Object count}) => '${count} üye',
			'discover.privateRoom.subtitle' => 'Bu gizli bir oda. Erişimi token ile aç.',
			'discover.privateRoom.roomAccess' => 'Oda erişimi',
			'discover.privateRoom.yourBalance' => 'Bakiyen',
			'discover.privateRoom.tokensAmount' => ({required Object count}) => '${count} token',
			'discover.privateRoom.joinForTokens' => ({required Object count}) => '${count} token ile katıl',
			'discover.privateRoom.cancel' => 'İptal',
			'discover.roomToken.subtitle' => 'Erişimi token ile aç.',
			'discover.roomToken.roomAccess' => 'Oda erişimi',
			'discover.roomToken.yourBalance' => 'Bakiyen',
			'discover.roomToken.tokensAmount' => ({required Object count}) => '${count} token',
			'discover.roomToken.joinForTokens' => ({required Object count}) => '${count} token ile katıl',
			'discover.roomToken.cancel' => 'İptal',
			'discover.privateRequest.title' => 'Katılma isteği',
			'discover.privateRequest.roomInfo' => ({required Object name, required Object count}) => '${name} · ${count} üye',
			'discover.privateRequest.messageHint' => 'Bir şey yaz (isteğe bağlı)...',
			'discover.privateRequest.sendRequest' => 'İstek Gönder',
			'discover.privateRequest.adminReview' => 'İsteğini oda yöneticisi inceleyecek',
			'discover.roomApproved.title' => 'İçeridesin!',
			'discover.roomApproved.subtitle' => ({required Object name}) => '${name} içinde yerin hazır',
			'discover.roomApproved.continueLabel' => 'Devam Et',
			'discover.createSpace.title' => 'Oda veya Grup Oluştur',
			'discover.createSpace.subtitle' => 'Grup veya canlı oda oluşturarak kitlelere hitap et',
			'discover.createSpace.room' => 'Oda',
			'discover.createSpace.group' => 'Grup',
			'discover.createSpace.hideAccount' => 'Hesabımı Gizle',
			'discover.createSpace.create' => 'Oluştur',
			'discover.createSpace.cancel' => 'İptal',
			'discover.createSpace.createRoomTitle' => 'Oda Oluştur',
			'discover.createSpace.createGroupTitle' => 'Grup Oluştur',
			'discover.createSpace.nameSubtitle' => 'Oluşturduğun gruba bir isim ver',
			'discover.createSpace.nameHint' => 'Gece Kuşu',
			'discover.createSpace.createRoomFor' => ({required Object count}) => '${count} tokene oluştur',
			'discover.liveRoom.adminSuffix' => '(Yönetici)',
			'discover.liveRoom.messageHint' => 'Mesaj',
			'discover.liveRoom.quickReplyHey' => 'Herkese merhaba!',
			'discover.liveRoom.quickReplyTopic' => 'Konu ne?',
			'discover.liveRoom.quickReplyNew' => 'Ben yeniyim!',
			'discover.liveRoom.sampleChatName' => 'Sona',
			'discover.liveRoom.sampleChatBody' => 'Ne yapabiliriz? Aklında ne var?',
			'discover.liveRoom.roomEnded' => 'Oda kapandı.',
			'discover.liveRoom.wantsToJoin' => ({required Object name}) => '${name} katılmak istiyor',
			'discover.liveRoom.approve' => 'Onayla',
			'discover.liveRoom.remove' => 'Odadan çıkar',
			'discover.liveRoom.removed' => 'Odadan çıkarıldın.',
			'discover.liveRoom.seeProfile' => 'Profilini görmek istiyorum',
			'discover.liveRoom.muteMic' => 'Mikrofonunu kapat',
			'discover.liveRoom.unmuteMic' => 'Mikrofonunu aç',
			'discover.liveRoom.wantsToSeeYou' => ({required Object room, required Object name}) => '${room} odasındaki ${name} seni görmek istedi.',
			'discover.liveRoom.wantsMic' => ({required Object name}) => '${name} mikrofonunu açmanı istiyor.',
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
			'discover.groupInfo.admin' => 'Yönetici',
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
			'discover.filters.title' => 'Filtreler',
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
			'discover.post.sampleCaption' => 'Güzel bir günün ardından bir fincan kahve gibisi yok. <3',
			'discover.post.hoursAgo' => ({required Object hours}) => '${hours}s',
			'discover.post.minutesAgo' => ({required Object minutes}) => '${minutes}dk',
			'discover.post.daysAgo' => ({required Object days}) => '${days}g',
			'discover.post.deleteCommentTitle' => 'Bu yorum silinsin mi?',
			'discover.story.draft' => 'TASLAK',
			'discover.story.story' => 'HİKÂYE',
			'discover.story.share' => 'Paylaş',
			'discover.story.textPlaceholder' => 'Bir şeyler yaz...',
			'discover.story.draftPrompt' => 'Taslak olarak kaydedilsin mi?',
			'discover.story.saveToDraft' => 'Taslağa Kaydet',
			'discover.story.moveToTrash' => 'Çöpe Taşı',
			'discover.story.save' => 'Kaydet',
			'discover.story.musicTitle' => 'Müzik',
			'discover.story.musicEmpty' => 'Müzik bulunamadı.',
			'discover.story.musicError' => 'Müzikler yüklenemedi.',
			'discover.story.downloaded' => 'Galeriye kaydedildi',
			'discover.story.downloadFailed' => 'Kaydedilemedi',
			'discover.highlight.title' => 'Öne Çıkan',
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
			'discover.hostedBy' => ({required Object name}) => '${name} sunuyor',
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
			_ => null,
		} ?? switch (path) {
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
			'errors.alreadyInCall' => 'Zaten bir aramadasın.',
			'errors.roomPrivate' => 'Bu oda gizli. Katılmak için istek gönder.',
			'errors.roomFull' => 'Oda dolu.',
			'errors.alreadyCheckedIn' => 'Bugünün ödülünü zaten topladın.',
			'errors.purchasesUnavailable' => 'Satın alma şu an kullanılamıyor.',
			'faq.q1' => 'Bu uygulama nasıl çalışır?',
			'faq.q2' => 'Anonim sohbet nedir?',
			'faq.q3' => 'Bağlantı İlerlemesi ne işe yarar?',
			'faq.q4' => 'Profilimi nasıl açarım?',
			'faq.q5' => '60 Saniyelik Yabancı nedir?',
			'faq.q6' => 'Vibes nedir?',
			'faq.q7' => 'Profilimi nasıl düzenlerim?',
			'faq.q8' => 'Bildirimleri nasıl yönetirim?',
			'faq.q9' => 'Satın alımları nasıl geri yüklerim?',
			'faq.q10' => 'Tüm sohbetleri silebilir miyim?',
			'faq.q11' => 'Verilerim güvende mi?',
			'faq.q12' => 'Bir kullanıcıyı nasıl engeller veya şikayet ederim?',
			'faq.q13' => 'Uygulamayı nasıl paylaşırım?',
			'faq.q14' => 'Hesabımı nasıl silebilirim?',
			'faq.a1' => 'Veylo’da anonim olarak yeni insanlarla tanışabilir, sohbet edebilir ve bağlantın güçlendikçe profilini adım adım açabilirsin. İstediğin zaman yazışma, sesli arama veya yüz yüze görüşmeye geçebilirsin.',
			'faq.a2' => 'Anonim sohbette kimliğin ve fotoğrafın gizli kalır. Bağlantı yüzdesi arttıkça isim baş harfi, bulanık fotoğraf gibi bilgiler açılır; %100’de karşılıklı onayla tam profil paylaşılır.',
			'faq.a3' => 'Sohbet ettikçe bağlantı yüzdeniz artar. Belirli eşiklerde isim baş harfi, bulanık fotoğraf ve tam profil gibi adımlar açılır. Detayları Bağlantı göstergesine dokunarak görebilirsin.',
			'faq.a4' => 'Bağlantı %100 olduğunda Profilimi aç ile talep gönderebilirsin. Karşı taraf da kabul ederse karşılıklı tam profiller görünür.',
			'faq.a5' => 'Ara sekmesinden kısa süreli rastgele bir eşleşme bulabilirsin. Süre bitince görüşmeyi uzatmayı seçebilir veya kapatabilirsin.',
			'faq.a6' => 'Vibes, yakındaki veya keşfedilebilir insanları harita / liste üzerinden görmeni sağlar. İlgilendiğin kişiye yaklaşıp sohbet başlatabilirsin.',
			'faq.a7' => 'Profil sekmesinden Profili Düzenle’ye girerek adını, fotoğraflarını, hakkında bilgilerini ve ilgi alanlarını güncelleyebilirsin. Değişiklikler kaydettikten sonra görünür olur.',
			'faq.a8' => 'Ayarlar’daki Bildirimler bölümünden mesaj, eşleşme ve diğer uyarıları açıp kapatabilirsin.',
			'faq.a9' => 'Ayarlar → Hesap Yönetimi → Satın Alımları Geri Yükle’ye dokun. Aynı mağaza hesabındaki uygun satın alımlar geri yüklenir.',
			'faq.a10' => 'Evet. Ayarlar → Sohbetleri Sil ile onayladıktan sonra tüm konuşmaların silinir. Bu işlem geri alınamaz.',
			'faq.a11' => 'Hesap bilgilerin ve mesajların korumalı sistemlerde saklanır. İstersen hesap yönetimi üzerinden hesabını ve verilerini silme talebi oluşturabilirsin.',
			'faq.a12' => 'Profil veya sohbet ekranındaki menüden engelle veya şikayet et seçeneklerini kullanabilirsin. Şikayetler ekibimiz tarafından incelenir.',
			'faq.a13' => 'Ayarlar’daki Uygulamayı Paylaş ile bağlantıyı kopyalayıp arkadaşlarınla paylaşabilirsin.',
			'faq.a14' => 'Ayarlar → Hesap Yönetimi → Hesabı ve Verileri Sil yolunu izle. Sebep belirttikten sonra silme talebini onaylaman gerekir.',
			'legal.termsTitle' => 'Hizmet Şartları',
			'legal.privacyTitle' => 'Gizlilik Politikası',
			'legal.termsBody' => 'Son güncelleme: 16 Mart 2026\n\nVeylo’ya hoş geldin. Hesap oluşturarak veya uygulamayı kullanarak bu Hizmet Şartları’nı kabul etmiş olursun.\n\n1. Veylo nedir?\nVeylo; insanlarla tanışabileceğin, anonim sohbet edebileceğin, bağlantını zamanla güçlendirebileceğin ve karşılıklı onayla sesli veya yüz yüze aramaya geçebileceğin bir sosyal uygulamadır.\n\n2. Hesabın\nDoğru bilgi vermeli ve giriş bilgilerini güvende tutmalısın. Hesabındaki aktivitelerden sen sorumlusun. Yaşadığın ülkenin yasalarına göre Veylo’yu kullanabilecek yaşta olmalısın.\n\n3. Saygılı kullanım\nTaciz, tehdit, dolandırıcılık, kimliğe bürünme, yasa dışı içerik veya güvenlik özelliklerini atlatma girişimleri yasaktır. Kuralları ihlal eden içerik kaldırılabilir, özellikler kısıtlanabilir veya hesap askıya alınabilir.\n\n4. Anonim sohbet ve profil açma\nAnonim sohbetlerde isim ve fotoğraf, bağlantı eşiklerine kadar gizli kalabilir. Tam profil açılışı karşılıklı onay gerektirir. Kimliğini açması için kimseyi zorlama.\n\n5. Satın alımlar\nBazı özellikler ücretli olabilir. Ödemeler App Store veya Google Play üzerinden yapılır. Restore Purchases, aynı mağaza hesabındaki uygun satın alımları geri yükler. İadeler mağaza politikasına tabidir.\n\n6. Paylaştığın içerik\nİçeriğinin hakları sende kalır; Veylo’ya hizmeti sunmak için gereken ölçüde barındırma ve gösterme lisansı verirsin. Hakkın olmayan içeriği paylaşma.\n\n7. Kullanımı sonlandırma\nİstediğin zaman Veylo’yu bırakabilir ve Ayarlar’dan hesap silme talebi oluşturabilirsin. Gerekirse hizmeti makul bildirimle değiştirebilir veya sonlandırabiliriz.\n\n8. İletişim\nBu şartlarla ilgili soruların için: support@veylo.app',
			'legal.privacyBody' => 'Son güncelleme: 16 Mart 2026\n\nBu Gizlilik Politikası, Veylo’nun bilgilerini nasıl topladığını, kullandığını ve koruduğunu açıklar.\n\n1. Topladığımız bilgiler\n• Hesap verileri: e-posta, görünen ad, profil fotoğrafları, bio, tercihler\n• Kullanım verileri: sohbetler, bağlantı ilerlemesi, kullandığın arama özellikleri, temel cihaz/uygulama bilgileri\n• Satın alımlar: ücretli özellikleri açmak ve geri yüklemek için gerekli mağaza fiş bilgileri\n\n2. Nasıl kullanırız?\nVerilerini Veylo’yu işletmek, eşleşme ve sohbet deneyimini kişiselleştirmek, topluluğu güvende tutmak, satın alımları işlemek ve ürünü geliştirmek için kullanırız. Kişisel verilerini satmayız.\n\n3. Anonim mod\nAnonim sohbetlerde diğer kullanıcıların gördüğü bilgiler (ör. maskeli isim veya bulanık fotoğraf) kilit açma kuralları ve karşılıklı onayla sınırlıdır. Özelliğin güvenli çalışması için hesap tanımlayıcılarına yine ihtiyaç duyarız.\n\n4. Paylaşım\nVerileri yalnızca barındırma, analiz veya ödeme gibi hizmet sağlayıcılarla gerektiği ölçüde paylaşabiliriz. Yasal zorunluluk veya kullanıcıları zarardan koruma durumlarında da açıklama yapılabilir.\n\n5. Saklama\nHesabın aktifken ve yasal, güvenlik ile faturalama gerekçeleriyle gerektiği süre veriyi saklarız. Silme talebi tamamlandıktan sonra, zorunlu saklama dışında kişisel veriler silinir veya anonimleştirilir.\n\n6. Seçeneklerin\nProfilini düzenleyebilir, bildirimleri yönetebilir, hesap silme talebi oluşturabilir ve verilerin hakkında bize yazabilirsin. Mağaza satın alımları Apple veya Google üzerinden de yönetilir.\n\n7. Güvenlik\nBilgilerini korumak için makul teknik ve idari önlemler alırız. Hiçbir sistem tamamen risksiz değildir; güçlü parola kullan ve cihazını güncel tut.\n\n8. İletişim\nGizlilik soruları: privacy@veylo.app',
			'logout.title' => 'Çıkış yap',
			'logout.subtitle' => 'Çıkış yapmak istediğinden emin misin?',
			'logout.cancel' => 'İptal',
			'logout.confirm' => 'Çıkış yap',
			'deleteAccount.title' => 'Hesap silme talebi gönder',
			'deleteAccount.subtitle' => 'Hesabını silmek istediğinden emin misin?',
			'deleteAccount.reasonTitle' => 'Gitmeni istemiyoruz ama seni anlıyoruz.',
			'deleteAccount.reasonBefore' => '',
			'deleteAccount.reasonAfter' => ' deneyimini iyileştirmemiz için bize neden ayrılmak istediğini söyler misin?',
			'deleteAccount.reasonLabel' => 'Hesabını neden silmek istiyorsun',
			'deleteAccount.reasonHint' => 'Mesajınızı yazın',
			'deleteAccount.cancel' => 'İptal',
			'deleteAccount.createRequest' => 'Talep Oluştur',
			'deleteAccount.confirmTitle' => 'Hesap silme talebini göndermek istediğinden emin misin?',
			'deleteAccount.confirmSubtitle' => 'Onaylarsan hesap silme talebin oluşturulacak',
			'deleteAccount.delete' => 'Sil',
			'storyText.bold' => 'Kalın',
			'storyText.italic' => 'İtalik',
			'storyText.uppercase' => 'Büyük harf',
			'storyText.underline' => 'Altı çizili',
			'storyText.cancel' => 'İptal',
			'storyText.galleryError' => 'Galeri açılamadı',
			'tokens.boostTitle' => 'Boost',
			'tokens.history' => 'Geçmiş',
			'tokens.yourBalance' => 'Bakiyen',
			'tokens.balanceTokens' => ({required Object count}) => '${count} Token',
			'tokens.getMore' => 'Daha fazla token al',
			'tokens.checkinTitle' => 'Günlük giriş',
			'tokens.checkinSubtitle' => ({required Object max}) => 'Her gün üst üste topla, günde ${max} tokene kadar kazan',
			'tokens.day' => ({required Object n}) => '${n}. Gün',
			'tokens.collectDay' => ({required Object n}) => '${n}. gün tokenlerini topla',
			'tokens.collectedToday' => ({required Object n}) => '${n}. gün için yarın tekrar gel',
			'tokens.duration30m' => '30 dakika',
			'tokens.duration1h' => '1 saat',
			'tokens.duration2h' => '2 saat',
			'tokens.visibility' => ({required Object n}) => '${n} kat görünürlük',
			'tokens.boostFor' => ({required Object count}) => '${count} token ile Boost',
			'tokens.boostActive' => ({required Object time}) => '${time} saatine kadar öne çıkarıldı',
			'tokens.boostDone' => 'Profilin öne çıkarıldı!',
			'tokens.historyEmpty' => 'Henüz token hareketi yok',
			'tokens.balanceLine' => ({required Object count}) => 'Bakiyen ${count} token',
			'tokens.reasonPurchase' => 'Token Satın Alma',
			'tokens.reasonCheckin' => 'Günlük giriş',
			'tokens.reasonWelcome' => 'Hoş geldin hediyesi',
			'tokens.reasonGenderFilter' => 'Cinsiyet filtreli arama',
			'tokens.reasonVideoCall' => 'Görüntülü arama',
			'tokens.reasonRoomCreate' => 'Oda oluşturma',
			'tokens.reasonBorder' => 'Profil çerçevesi',
			'tokens.reasonPostBoost' => 'Gönderi öne çıkarma',
			'tokens.reasonRefund' => 'İade',
			'tokens.reasonAdjust' => 'Bakiye düzeltme',
			'tokens.packsTitle' => 'Daha fazla token al',
			'tokens.packsSubtitle' => 'Bir token paketi seç',
			'tokens.packTokens' => ({required Object count}) => '${count} token',
			'tokens.buy' => 'Satın al',
			'tokens.purchaseDone' => ({required Object count}) => 'Bakiyene ${count} token eklendi',
			'tokens.notEnoughTitle' => 'Yeterli token yok',
			'tokens.notEnoughSubtitle' => 'Devam etmek için bakiyeni yükle.',
			_ => null,
		};
	}
}
