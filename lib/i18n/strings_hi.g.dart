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
class TranslationsHi extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsHi({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.hi,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <hi>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key) ?? super[key];

	late final TranslationsHi _root = this; // ignore: unused_field

	@override 
	TranslationsHi $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsHi(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$app$hi app = _Translations$app$hi._(_root);
	@override late final _Translations$home$hi home = _Translations$home$hi._(_root);
	@override late final _Translations$chats$hi chats = _Translations$chats$hi._(_root);
	@override late final _Translations$profile$hi profile = _Translations$profile$hi._(_root);
	@override late final _Translations$nav$hi nav = _Translations$nav$hi._(_root);
	@override late final _Translations$call$hi call = _Translations$call$hi._(_root);
	@override late final _Translations$vibes$hi vibes = _Translations$vibes$hi._(_root);
	@override late final _Translations$discover$hi discover = _Translations$discover$hi._(_root);
	@override late final _Translations$common$hi common = _Translations$common$hi._(_root);
	@override late final _Translations$languages$hi languages = _Translations$languages$hi._(_root);
	@override late final _Translations$auth$hi auth = _Translations$auth$hi._(_root);
	@override late final _Translations$onboarding$hi onboarding = _Translations$onboarding$hi._(_root);
	@override late final _Translations$createProfile$hi createProfile = _Translations$createProfile$hi._(_root);
	@override late final _Translations$errors$hi errors = _Translations$errors$hi._(_root);
	@override late final _Translations$faq$hi faq = _Translations$faq$hi._(_root);
	@override late final _Translations$legal$hi legal = _Translations$legal$hi._(_root);
	@override late final _Translations$logout$hi logout = _Translations$logout$hi._(_root);
	@override late final _Translations$deleteAccount$hi deleteAccount = _Translations$deleteAccount$hi._(_root);
	@override late final _Translations$storyText$hi storyText = _Translations$storyText$hi._(_root);
}

// Path: app
class _Translations$app$hi extends Translations$app$tr {
	_Translations$app$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get name => 'Veylo';
	@override String get tagline => 'स्वागत है';
}

// Path: home
class _Translations$home$hi extends Translations$home$tr {
	_Translations$home$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'होम';
	@override String get subtitle => 'ऐप तैयार हो रहा है';
	@override String get body => 'बहुभाषी UI को slang से मैनेज किया जाता है।';
}

// Path: chats
class _Translations$chats$hi extends Translations$chats$tr {
	_Translations$chats$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'चैट';
	@override String get search => 'खोजें';
	@override String get messagesSection => 'मैसेज';
	@override String get request => 'रिक्वेस्ट';
	@override String get emptyRequestTitle => 'कोई नया मैसेज\nनोटिफ़िकेशन नहीं है';
	@override String get emptyRequestSubtitle => '30 दिन से पुरानी रिक्वेस्ट नहीं दिखाई जातीं।';
	@override String get noteAdd => 'नोट जोड़ें';
	@override String get anonymous => 'गुमनाम';
	@override String get online => 'ऑनलाइन';
	@override String get offline => 'ऑफ़लाइन';
	@override String get connection => 'कनेक्शन';
	@override String connectionPercent({required Object n}) => '${n}%';
	@override String get connectionProgressTitle => 'कनेक्शन प्रोग्रेस';
	@override String get milestoneInitial => 'नाम का पहला अक्षर';
	@override String get milestoneInitialHint => '25% पर अनलॉक हुआ';
	@override String get milestoneInitialLocked => '25% पर अनलॉक होगा';
	@override String get milestonePhoto => 'धुंधली फ़ोटो प्रीव्यू';
	@override String get milestonePhotoHint => '70% पर अनलॉक होगा';
	@override String get milestoneFull => 'पूरी प्रोफ़ाइल देखें';
	@override String get milestoneFullHint => '100% पर दोनों की सहमति से';
	@override String get sampleAnonymousMessage => 'नमस्ते, आपसे मिलकर अच्छा लगा। क्या आप अपने बारे में थोड़ा बता सकते हैं?';
	@override String get strangerSampleMessage => 'नमस्ते Jhon, आपसे मिलकर अच्छा लगा। क्या आप अपने बारे में थोड़ा बता सकते हैं?';
	@override String get approve => 'स्वीकार करें';
	@override String get blockUser => 'यूज़र ब्लॉक करें';
	@override String get reject => 'अस्वीकार करें';
	@override String get messageHint => 'हाय! कैसे हैं आप?';
	@override String get revealTitle => 'आप 100% तक पहुँच गए';
	@override String get revealSubtitle => 'एक-दूसरे को पूरी प्रोफ़ाइल दिखाएँ? दोनों की सहमति ज़रूरी है।';
	@override String revealWaiting({required Object name}) => '${name} की मंज़ूरी का इंतज़ार है';
	@override String get revealCta => 'मेरी प्रोफ़ाइल दिखाएँ';
	@override String get revealNotYet => 'अभी नहीं';
	@override String get seen => 'देखा गया';
	@override String get typing => 'टाइप कर रहे हैं…';
	@override String get noteYou => 'आप';
	@override String get noteSheetTitle => 'नोट शेयर करें';
	@override String get noteSheetSubtitle => 'आपका नोट 24 घंटे तक रहेगा';
	@override String get noteHint => 'आपके मन में क्या है?';
	@override String get noteShare => 'शेयर करें';
	@override String get noteDelete => 'नोट डिलीट करें';
}

// Path: profile
class _Translations$profile$hi extends Translations$profile$tr {
	_Translations$profile$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get eyebrow => 'प्रोफ़ाइल';
	@override String get title => 'सेटिंग्स';
	@override String get editProfile => 'प्रोफ़ाइल एडिट करें';
	@override String get statLike => 'लाइक';
	@override String get statFollow => 'फ़ॉलो';
	@override String get statFollower => 'फ़ॉलोअर';
	@override String get promoTitle => 'ज़्यादा मैसेज पाएँ!';
	@override String get promoSubtitle => 'अलग दिखें, लिस्ट में सबसे ऊपर आएँ';
	@override String get standOut => 'अलग दिखें';
	@override String get tabPosts => 'पोस्ट';
	@override String get tabVideo => 'वीडियो';
	@override String get tabSaved => 'सेव किए गए';
	@override String get save => 'सेव करें';
	@override String get changePhoto => 'फ़ोटो बदलें';
	@override String get changeBorder => 'बॉर्डर बदलें';
	@override String get interest => 'रुचि';
	@override String get name => 'नाम';
	@override String get changeName => 'नाम बदलें';
	@override String get changePassword => 'पासवर्ड बदलें';
	@override String get confirmPassword => 'पासवर्ड कन्फ़र्म करें';
	@override String get email => 'ईमेल';
	@override String get accountManagement => 'अकाउंट मैनेजमेंट';
	@override String get settingsAbout => 'जानकारी';
	@override String get settingsAccount => 'अकाउंट सेटिंग्स';
	@override String get settingsSupport => 'सहायता';
	@override String get shareApp => 'ऐप शेयर करें';
	@override String get shareAppTitle => 'दोस्तों के साथ शेयर करें';
	@override String get shareAppSubtitle => 'Veylo को दोस्तों के साथ शेयर करें और साथ मिलकर खोजें!';
	@override String get shareAppLabel => 'ऐप लिंक';
	@override String get rateApp => 'हम पसंद आए? रेटिंग दें';
	@override String get notifications => 'नोटिफ़िकेशन';
	@override String get password => 'पासवर्ड';
	@override String get deleteConversation => 'चैट डिलीट करें';
	@override String get faqHelp => 'FAQ और सहायता';
	@override String get restorePurchases => 'खरीदारी रीस्टोर करें';
	@override String get termsOfService => 'सेवा की शर्तें';
	@override String get privacyPolicy => 'प्राइवेसी पॉलिसी';
	@override String get restorePurchasesDone => 'खरीदारी चेक हो गई';
	@override String get conversationsDeleted => 'सभी चैट डिलीट हो गईं';
	@override String get logOut => 'लॉग आउट';
	@override String get deleteAccountAndData => 'अकाउंट और डेटा डिलीट करें';
	@override String get passwordPlaceholder => '********';
	@override String get height => 'लंबाई';
	@override String get addHeight => 'लंबाई जोड़ें';
	@override String heightCm({required Object value}) => '${value} सेमी';
	@override String get languages => 'भाषाएँ';
	@override String get relationshipGoals => 'रिश्ते का लक्ष्य';
	@override String get lookingFor => 'किसकी तलाश है';
	@override String get newFriends => '👋 नए दोस्त';
	@override String get goalLongTermOpenToShort => '💕 लंबा रिश्ता, छोटा भी चलेगा';
	@override String get goalLongTermRelationship => '💘 लंबा रिश्ता';
	@override String get goalNewFriends => '👋 नए दोस्त';
	@override String get goalShortTermFun => '🥃 थोड़े समय की मस्ती';
	@override String get goalStillFiguringItOut => '🤔 अभी सोच रहे हैं';
	@override String get basics => 'बेसिक जानकारी';
	@override String get zodiac => 'राशि';
	@override String get zodiacValue => 'वृश्चिक';
	@override String get education => 'शिक्षा';
	@override String get educationValue => 'ग्रेजुएट';
	@override String get educationHighSchool => 'हाई स्कूल';
	@override String get educationAssociates => 'डिप्लोमा';
	@override String get educationBachelors => 'ग्रेजुएशन';
	@override String get educationMasters => 'पोस्ट ग्रेजुएशन';
	@override String get educationPhd => 'PhD / डॉक्टरेट';
	@override String get voiceRecord => 'वॉइस रिकॉर्ड';
	@override String get addVoice => 'वॉइस जोड़ें';
	@override String get lifestyle => 'लाइफ़स्टाइल';
	@override String get pets => 'पालतू जानवर';
	@override String get petsValue => 'मेरे पास बिल्ली है';
	@override String get petsDontWant => 'पालतू जानवर नहीं चाहिए';
	@override String get petsAllergic => 'मुझे पालतू जानवरों से एलर्जी है';
	@override String get petsHaveCat => 'मेरे पास बिल्ली है';
	@override String get petsHaveDog => 'मेरे पास कुत्ता है';
	@override String get petsHaveCatsAndDogs => 'मेरे पास बिल्लियाँ और कुत्ते हैं';
	@override String get petsHaveOther => 'मेरे पास दूसरे पालतू हैं';
	@override String get drinking => 'ड्रिंकिंग';
	@override String get drinkingValue => 'खास मौकों पर';
	@override String get drinkingNever => 'कभी नहीं';
	@override String get drinkingSpecialOccasions => 'खास मौकों पर';
	@override String get drinkingSocially => 'दोस्तों के साथ';
	@override String get drinkingFrequently => 'अक्सर';
	@override String get drinkingSober => 'बिल्कुल नहीं पीते';
	@override String get drinkingPreferNotToSay => 'बताना नहीं चाहते';
	@override String get smoking => 'स्मोकिंग';
	@override String get smokingValue => 'स्मोक नहीं करते';
	@override String get smokingNonSmoker => 'स्मोक नहीं करते';
	@override String get smokingSocialSmoker => 'कभी-कभार दोस्तों के साथ';
	@override String get smokingSmoker => 'स्मोक करते हैं';
	@override String get smokingTryingToQuit => 'छोड़ने की कोशिश में';
	@override String get smokingWhenDrinking => 'ड्रिंक करते समय';
	@override String get smokingPreferNotToSay => 'बताना नहीं चाहते';
	@override String get gender => 'जेंडर';
	@override String get genderFemale => 'महिला';
	@override String get genderMale => 'पुरुष';
	@override String get genderPreferNotToSay => 'बताना नहीं चाहते';
	@override String get visible => 'दिखाई दे रहा है';
	@override String get profileVisibility => 'प्रोफ़ाइल विज़िबिलिटी';
	@override String get language => 'भाषा';
	@override String get borderTitle => 'प्रोफ़ाइल बॉर्डर';
	@override String get borderSubtitle => 'अपनी प्रोफ़ाइल में बॉर्डर जोड़ें और\nसबसे अलग दिखें।';
	@override String get borderBuySection => 'बॉर्डर खरीदें';
	@override String get borderBuyCta => 'बॉर्डर खरीदें';
	@override String borderToken({required Object count}) => '${count} टोकन';
	@override String get borderAmethystWings => 'Amethyst Wings';
	@override String get borderGoldenPhoenix => 'Golden Phoenix';
	@override String get borderFrostCrown => 'Frost Crown';
	@override String get borderEmeraldWhisper => 'Emerald Whisper';
	@override String get borderRoseQuartz => 'Rose Quartz';
	@override String get borderStarlitComet => 'Starlit Comet';
	@override String get borderCrimsonRoyal => 'Crimson Royal';
	@override String get borderSapphireHalo => 'Sapphire Halo';
	@override String get follow => 'फ़ॉलो करें';
	@override String get following => 'फ़ॉलो कर रहे हैं';
	@override String get followPageTitle => 'फ़ॉलो';
	@override String get followTabFollowing => 'फ़ॉलोइंग';
	@override String get followTabFollowers => 'फ़ॉलोअर्स';
	@override String get followSearch => 'खोजें';
	@override String get unfollow => 'अनफ़ॉलो करें';
	@override String get followSortTitle => 'क्रम';
	@override String get followSortRecent => 'जिन्हें हाल ही में फ़ॉलो किया';
	@override String get followSortNotFollowingMe => 'जो मुझे वापस फ़ॉलो नहीं करते';
	@override String get followSortNotFollowedByMe => 'जिन्हें मैं वापस फ़ॉलो नहीं करता';
	@override String get followSortShowResult => 'रिज़ल्ट दिखाएँ';
	@override String get followSortEmpty => 'इस फ़िल्टर से कोई यूज़र नहीं मिला';
	@override String get shareTitle => 'दोस्तों के साथ शेयर करें';
	@override String get shareSubtitle => 'दोस्तों के साथ जुड़ने पर हर चीज़\nज़्यादा मज़ेदार होती है!';
	@override String get shareProfileLabel => 'प्रोफ़ाइल शेयर करें';
	@override String get shareLinkCopied => 'लिंक कॉपी हो गया';
	@override String get restrict => 'रिस्ट्रिक्ट करें';
	@override String get block => 'ब्लॉक करें';
	@override String get report => 'रिपोर्ट करें';
	@override String blockTitle({required Object username}) => '${username} को ब्लॉक करें?';
	@override String get blockBody => 'इससे उनके दूसरे मौजूदा या भविष्य में बनने वाले अकाउंट भी ब्लॉक हो जाएँगे। आप कभी भी अनब्लॉक कर सकते हैं।';
	@override String get blockAndReport => 'ब्लॉक और रिपोर्ट करें';
	@override String restrictTitle({required Object username}) => '${username} को रिस्ट्रिक्ट करें?';
	@override String get restrictBody => 'वे नहीं देख पाएँगे कि आप कब ऑनलाइन हैं या आपने उनके मैसेज पढ़े हैं। आप इसे कभी भी बदल सकते हैं।';
	@override String get restrictAndReport => 'रिस्ट्रिक्ट और रिपोर्ट करें';
	@override String get reportTitle => 'हम वजह जानना चाहेंगे';
	@override String get reportSubtitle => 'आपको बेहतर अनुभव देने के लिए, क्या आप बता सकते हैं कि आप इस यूज़र को क्यों रिपोर्ट करना चाहते हैं?';
	@override String get reportMessageLabel => 'रिपोर्ट मैसेज';
	@override String get reportMessageHint => 'अपना मैसेज लिखें';
	@override String get reportCancel => 'रद्द करें';
	@override String get sendReport => 'रिपोर्ट भेजें';
	@override String get notSet => 'सेट नहीं है';
	@override String get reportSent => 'धन्यवाद, हमें आपकी रिपोर्ट मिल गई है।';
	@override String emailVerificationSent({required Object email}) => 'हमने ${email} पर कन्फ़र्मेशन लिंक भेजा है। कन्फ़र्म करने के बाद आपका ईमेल बदल जाएगा।';
	@override String get passwordChanged => 'आपका पासवर्ड अपडेट हो गया है।';
	@override String get passwordMismatch => 'पासवर्ड मेल नहीं खाते।';
}

// Path: nav
class _Translations$nav$hi extends Translations$nav$tr {
	_Translations$nav$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get discover => 'डिस्कवर';
	@override String get chat => 'चैट';
	@override String get call => 'कॉल';
	@override String get vibes => 'Vibes';
	@override String get profile => 'प्रोफ़ाइल';
}

// Path: call
class _Translations$call$hi extends Translations$call$tr {
	_Translations$call$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => '60 सेकंड स्ट्रेंजर';
	@override String get subtitle => 'किसी अनजान व्यक्ति से 60 सेकंड बात करें — पूरी तरह गुमनाम। न प्रोफ़ाइल, न फ़ोटो, न नाम। बस एक आवाज़ और एक पल।';
	@override String get findingTitle => 'स्ट्रेंजर ढूँढ रहे हैं...';
	@override String get findingSubtitle => 'आप 60 सेकंड तक गुमनाम बात करेंगे। न प्रोफ़ाइल, न नाम।';
	@override String get callStranger => 'स्ट्रेंजर को कॉल करें - 10 टोकन';
	@override String get cancel => 'रद्द करें';
	@override String get female => 'महिला';
	@override String get male => 'पुरुष';
	@override String get nonBinary => 'नॉन-बाइनरी';
	@override String get preferNotToSay => 'बताना नहीं चाहते';
	@override String get anonymousBadge => '🎙️ गुमनाम वॉइस कॉल';
	@override String get stranger => 'स्ट्रेंजर';
	@override String secondsLeft({required Object n}) => '${n}s';
	@override String get timesUpTitle => 'समय खत्म!';
	@override String get timesUpSubtitle => 'और बात करनी है? अगर दोनों हाँ कहें, तो चैट अनलॉक हो जाएगी।';
	@override String get keepTalking => 'बात जारी रखें';
	@override String get endCall => 'कॉल खत्म करें';
	@override String get waitingOther => 'दूसरे व्यक्ति का इंतज़ार...';
	@override String get callStrangerFree => 'स्ट्रेंजर को कॉल करें';
	@override String get peerLeft => 'दूसरे व्यक्ति ने कॉल खत्म कर दी।';
	@override String get noKeep => 'इस बार चैट अनलॉक नहीं हुई।';
	@override String get videoWaiting => 'वीडियो कॉल स्वीकार होने का इंतज़ार...';
	@override String get videoDeclined => 'उन्होंने वीडियो कॉल अस्वीकार कर दी।';
	@override String get micDenied => 'कॉल के लिए माइक्रोफ़ोन एक्सेस ज़रूरी है। आप इसे सेटिंग्स में चालू कर सकते हैं।';
	@override String get videoCost => 'वीडियो कॉल: 20 टोकन / 15 मिनट';
	@override String get calling => 'कॉल हो रही है';
	@override String get accept => 'स्वीकार करें';
	@override String get decline => 'अस्वीकार करें';
	@override String get switchToVideo => 'क्या आप वीडियो कॉल पर जाना चाहेंगे?';
	@override String get noMatchTitle => 'अभी कोई उपलब्ध नहीं है';
	@override String get noMatchBody => 'इस समय बात करने के लिए कोई नहीं मिला। थोड़ी देर बाद फिर से कोशिश करें।';
	@override String get noMatchOk => 'ठीक है';
}

// Path: vibes
class _Translations$vibes$hi extends Translations$vibes$tr {
	_Translations$vibes$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get search => 'खोजें';
	@override String get sendMessage => 'मैसेज भेजें';
	@override String get wantsToTalk => 'अभी इस बारे में बात करना चाहते हैं';
	@override String get shareTitle => 'Vibe शेयर करें';
	@override String get replyTitle => 'Vibe का जवाब दें';
	@override String get shareHint => 'कुछ लिखें';
	@override String get shareAnonymous => 'गुमनाम रूप से शेयर करें';
	@override String get empty => 'पिछले 24 घंटों में कोई Vibe नहीं। पहला आप शेयर करें!';
	@override String get deleteTitle => 'यह Vibe डिलीट करें?';
	@override String get delete => 'डिलीट करें';
	@override String get cancel => 'रद्द करें';
}

// Path: discover
class _Translations$discover$hi extends Translations$discover$tr {
	_Translations$discover$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'डिस्कवर';
	@override String get tabRooms => 'रूम';
	@override String get tabDiscover => 'डिस्कवर';
	@override String get tabAiMatch => 'AI Match';
	@override late final _Translations$discover$aiMatch$hi aiMatch = _Translations$discover$aiMatch$hi._(_root);
	@override String get searchHint => 'खोजें';
	@override String get allRooms => 'सभी रूम';
	@override String get allGroups => 'सभी ग्रुप';
	@override String get seeAll => 'सब देखें';
	@override String get live => 'लाइव';
	@override String get join => 'जॉइन करें';
	@override String get request => 'रिक्वेस्ट';
	@override String get requested => 'रिक्वेस्ट भेजी';
	@override String get private => 'प्राइवेट';
	@override String moreCount({required Object count}) => '+${count} और';
	@override String activeCount({required Object count}) => '${count} एक्टिव';
	@override String membersCount({required Object count}) => '${count} मेंबर';
	@override late final _Translations$discover$privateRoom$hi privateRoom = _Translations$discover$privateRoom$hi._(_root);
	@override late final _Translations$discover$roomToken$hi roomToken = _Translations$discover$roomToken$hi._(_root);
	@override late final _Translations$discover$privateRequest$hi privateRequest = _Translations$discover$privateRequest$hi._(_root);
	@override late final _Translations$discover$roomApproved$hi roomApproved = _Translations$discover$roomApproved$hi._(_root);
	@override late final _Translations$discover$createSpace$hi createSpace = _Translations$discover$createSpace$hi._(_root);
	@override late final _Translations$discover$liveRoom$hi liveRoom = _Translations$discover$liveRoom$hi._(_root);
	@override late final _Translations$discover$groupChat$hi groupChat = _Translations$discover$groupChat$hi._(_root);
	@override late final _Translations$discover$groupInfo$hi groupInfo = _Translations$discover$groupInfo$hi._(_root);
	@override late final _Translations$discover$filters$hi filters = _Translations$discover$filters$hi._(_root);
	@override late final _Translations$discover$post$hi post = _Translations$discover$post$hi._(_root);
	@override late final _Translations$discover$story$hi story = _Translations$discover$story$hi._(_root);
	@override late final _Translations$discover$highlight$hi highlight = _Translations$discover$highlight$hi._(_root);
	@override late final _Translations$discover$stats$hi stats = _Translations$discover$stats$hi._(_root);
	@override String hostedBy({required Object name}) => 'होस्ट: ${name}';
}

// Path: common
class _Translations$common$hi extends Translations$common$tr {
	_Translations$common$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get loading => 'लोड हो रहा है…';
	@override String get retry => 'फिर कोशिश करें';
	@override String get cancel => 'रद्द करें';
	@override String get save => 'सेव करें';
	@override String get continueAction => 'जारी रखें';
	@override String get language => 'भाषा';
	@override String get or => 'या';
}

// Path: languages
class _Translations$languages$hi extends Translations$languages$tr {
	_Translations$languages$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get tr => 'Türkçe';
	@override String get en => 'English';
}

// Path: auth
class _Translations$auth$hi extends Translations$auth$tr {
	_Translations$auth$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get createAccountTitle => 'अपना अकाउंट बनाएँ';
	@override String get createAccountSubtitle => 'Veylo से जुड़ें और कनेक्ट करना शुरू करें।';
	@override String get welcomeBackTitle => 'फिर से स्वागत है';
	@override String get welcomeBackSubtitle => 'Veylo पर जारी रखने के लिए लॉग इन करें।';
	@override String get username => 'यूज़रनेम';
	@override String get usernameHint => 'यूज़रनेम चुनें';
	@override String get email => 'ईमेल';
	@override String get emailHint => 'अपना ईमेल डालें';
	@override String get emailOrUsername => 'ईमेल या यूज़रनेम';
	@override String get emailOrUsernameHint => 'ईमेल या यूज़रनेम डालें';
	@override String get password => 'पासवर्ड';
	@override String get passwordCreateHint => 'पासवर्ड बनाएँ';
	@override String get passwordEnterHint => 'अपना पासवर्ड डालें';
	@override String get signUp => 'साइन अप';
	@override String get logIn => 'लॉग इन';
	@override String get forgotPassword => 'पासवर्ड भूल गए?';
	@override String get continueWithApple => 'Apple से जारी रखें';
	@override String get continueWithGoogle => 'Google से जारी रखें';
	@override String get legalPrefix => 'जारी रखकर, आप हमारी ';
	@override String get termsOfService => 'सेवा की शर्तों';
	@override String get legalMiddle => ' से सहमत होते हैं और हमारी ';
	@override String get privacyPolicy => 'प्राइवेसी पॉलिसी';
	@override String get legalSuffix => ' को स्वीकार करते हैं।';
	@override String get passwordResetSent => 'हमने आपके ईमेल पर पासवर्ड रीसेट लिंक भेजा है।';
}

// Path: onboarding
class _Translations$onboarding$hi extends Translations$onboarding$tr {
	_Translations$onboarding$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get skip => 'छोड़ें';
	@override String get page1Title => 'जैसे हैं वैसे रहें। गुमनाम रहें।';
	@override String get page1Subtitle => 'बिना अपनी पहचान बताए नए लोगों से\nमिलें और बातचीत शुरू करें।';
	@override String get page2Title => 'लिखें। बात करें। Vibe महसूस करें।';
	@override String get page2Subtitle => 'गुमनाम शुरुआत करें, फिर तैयार होने पर मैसेज, कॉल या आमने-सामने बात करें।';
	@override String get page3Title => 'अपने लोग ढूँढें। बातचीत में\nशामिल हों।';
	@override String get page3Subtitle => 'रूम में जाएँ, नए लोगों से मिलें और\nसाथ मिलकर पल शेयर करें।';
	@override String get getStarted => 'शुरू करें';
	@override String get alreadyHaveAccount => 'पहले से Veylo अकाउंट है? ';
	@override String get logInAction => 'लॉग इन';
}

// Path: createProfile
class _Translations$createProfile$hi extends Translations$createProfile$tr {
	_Translations$createProfile$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get navTitle => 'प्रोफ़ाइल बनाएँ';
	@override String get stepUsername => '1/5 यूज़रनेम';
	@override String get title => 'अपनी प्रोफ़ाइल बनाएँ';
	@override String get subtitle => 'आपका असली नाम सिर्फ़ वेरिफ़िकेशन के लिए है — यह सबको नहीं दिखेगा।';
	@override String get subtitleLine1 => 'आपका असली नाम सिर्फ़ वेरिफ़िकेशन के लिए है —';
	@override String get subtitleLine2 => 'यह सबको नहीं दिखेगा।';
	@override String get fullName => 'पूरा नाम';
	@override String get fullNameHint => 'Sam Lee';
	@override String get username => 'यूज़रनेम';
	@override String get usernameHint => 'samlee123';
	@override String get usernameTaken => 'यह यूज़रनेम पहले से मौजूद है!';
	@override String get usernameAvailable => 'यूज़रनेम उपलब्ध है';
	@override String get mightWantToTry => 'ये भी आज़मा सकते हैं...';
	@override String get stepPhoto => '2/5 प्रोफ़ाइल फ़ोटो';
	@override String get photoTitle => 'प्रोफ़ाइल फ़ोटो अपलोड करें';
	@override String get photoSubtitle => 'दूसरे यूज़र आपकी प्रोफ़ाइल फ़ोटो देखकर पक्का कर सकते हैं कि यह आप ही हैं।';
	@override String get photoSubtitleLine1 => 'दूसरे यूज़र आपकी प्रोफ़ाइल फ़ोटो देखकर पक्का';
	@override String get photoSubtitleLine2 => 'कर सकते हैं कि यह आप ही हैं।';
	@override String get choosePhoto => 'फ़ोटो चुनें';
	@override String get continueWithoutPhoto => 'बिना प्रोफ़ाइल फ़ोटो के जारी रखें';
	@override String get saveAndContinue => 'सेव करें और जारी रखें';
	@override String get choosePhotoSheetTitle => 'फ़ोटो चुनें';
	@override String get takePhoto => 'फ़ोटो लें';
	@override String get chooseFromGallery => 'गैलरी से चुनें';
	@override String get stepGender => '3/5 जेंडर';
	@override String get genderTitle => 'अपना जेंडर चुनें';
	@override String get genderSubtitle => 'अगर आप यह जानकारी देते हैं, तो हम इसका इस्तेमाल आपके लिए कंटेंट पर्सनलाइज़ करने में कर सकते हैं';
	@override String get genderSubtitleLine1 => 'अगर आप यह जानकारी देते हैं, तो हम इसका इस्तेमाल';
	@override String get genderSubtitleLine2 => 'आपके लिए कंटेंट पर्सनलाइज़ करने में कर सकते हैं';
	@override String get genderFemale => 'महिला';
	@override String get genderMale => 'पुरुष';
	@override String get genderNonBinary => 'नॉन-बाइनरी';
	@override String get genderPreferNotToSay => 'बताना नहीं चाहते';
	@override String get stepInterests => '4/5 रुचियाँ';
	@override String get interestsTitle => 'आपको क्या पसंद है?';
	@override String get interestsSubtitle => 'कम से कम 5 चुनें — इससे हम आपको ऐसे लोगों से मिला पाएँगे जो सच में आपको समझें।';
	@override late final _Translations$createProfile$interests$hi interests = _Translations$createProfile$interests$hi._(_root);
	@override String get stepChatGoal => '5/5 चैट का लक्ष्य';
	@override String get chatGoalTitle => 'आज आप क्या ढूँढ रहे हैं?';
	@override String get chatGoalSubtitle => 'इससे हम आपके अभी के मूड के हिसाब से सही मैच ढूँढ पाएँगे।';
	@override String get chatGoalQuickMatch => 'क्विक मैच — सीधे बातचीत\nशुरू करें';
	@override String get chatGoalFlirtyChat => 'फ़्लर्टी चैट — हल्की-फुल्की, मज़ेदार\nबातें';
	@override String get chatGoalMoodMatch => 'मूड मैच — आपके मूड के हिसाब से\nमैच';
	@override String get chatGoalLateNight => 'लेट नाइट टॉक — जब दुनिया सो रही हो\nतब गहरी बातें';
	@override String get chatGoalMeetSomeoneNew => 'किसी नए से मिलें — कोई खास लक्ष्य नहीं, बस\nएक्सप्लोर करें';
	@override String get getStarted => 'शुरू करें';
	@override String get preparingTitleLine1 => 'हम आपके लिए';
	@override String get preparingTitleLine2 => 'सही प्रोफ़ाइल';
	@override String get preparingTitleLine3 => 'तैयार कर रहे हैं।';
	@override String get preparingSubtitleLine1 => 'आपके जवाबों के आधार पर हम';
	@override String get preparingSubtitleLine2 => 'बेस्ट मैच चुन रहे हैं—थोड़ा इंतज़ार करें।';
	@override String preparingPercent({required Object percent}) => '${percent}%';
	@override String get usernameInvalid => '3–30 अक्षर, नंबर, डॉट या अंडरस्कोर इस्तेमाल करें।';
}

// Path: errors
class _Translations$errors$hi extends Translations$errors$tr {
	_Translations$errors$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get network => 'Veylo से कनेक्ट नहीं हो सका। अपना कनेक्शन चेक करें और फिर कोशिश करें।';
	@override String get generic => 'कुछ गलत हो गया। कृपया फिर कोशिश करें।';
	@override String get signInFailed => 'साइन इन नहीं हो सका। कृपया फिर कोशिश करें।';
	@override String get sessionExpired => 'आपका सेशन खत्म हो गया है। कृपया फिर से साइन इन करें।';
	@override String get accountSuspended => 'यह अकाउंट सस्पेंड कर दिया गया है।';
	@override String get unsupportedImage => 'कृपया JPEG, PNG या WebP फ़ोटो चुनें।';
	@override String get fileTooLarge => 'यह फ़ाइल बहुत बड़ी है।';
	@override String get enterEmailForReset => 'पासवर्ड रीसेट करने के लिए ऊपर अपना ईमेल डालें।';
	@override String get wrongCredentials => 'ईमेल/यूज़रनेम या पासवर्ड गलत है।';
	@override String get emailInUse => 'यह ईमेल पहले से रजिस्टर्ड है। लॉग इन करके देखें।';
	@override String get weakPassword => 'पासवर्ड कम से कम 6 अक्षरों का होना चाहिए।';
	@override String get invalidEmail => 'कृपया सही ईमेल एड्रेस डालें।';
	@override String get tooManyAttempts => 'बहुत ज़्यादा कोशिशें हो गईं। थोड़ा रुककर फिर कोशिश करें।';
	@override String get fillAllFields => 'कृपया सभी फ़ील्ड भरें।';
	@override String get insufficientTokens => 'टोकन कम हैं।';
	@override String get requestNotAccepted => 'जवाब देने के लिए रिक्वेस्ट स्वीकार करें।';
	@override String get requestPendingLimit => 'रिक्वेस्ट स्वीकार होने के बाद आप और मैसेज भेज सकते हैं।';
	@override String get blocked => 'आप इस व्यक्ति को मैसेज नहीं कर सकते।';
	@override String get peerUnavailable => 'यह अकाउंट अब उपलब्ध नहीं है।';
	@override String get vibeDailyLimit => 'आज आपने बहुत सारे Vibes शेयर किए हैं। बाद में फिर कोशिश करें।';
	@override String get groupFull => 'यह ग्रुप भर चुका है।';
	@override String get groupCreateLimit => 'आज आपने बहुत सारे ग्रुप बना लिए हैं। बाद में फिर कोशिश करें।';
	@override String get notFound => 'यह अब उपलब्ध नहीं है।';
	@override String get recentLogin => 'आपकी सुरक्षा के लिए, लॉग आउट करके फिर से लॉग इन करें, फिर दोबारा कोशिश करें।';
	@override String get socialAccount => 'आपका ईमेल और पासवर्ड आपके Google या Apple अकाउंट से मैनेज होता है।';
	@override String get alreadyInCall => 'आप पहले से एक कॉल पर हैं।';
	@override String get roomPrivate => 'यह रूम प्राइवेट है। जॉइन करने के लिए होस्ट से पूछें।';
	@override String get roomFull => 'यह रूम भर चुका है।';
}

// Path: faq
class _Translations$faq$hi extends Translations$faq$tr {
	_Translations$faq$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get q1 => 'यह ऐप कैसे काम करता है?';
	@override String get q2 => 'गुमनाम चैट क्या है?';
	@override String get q3 => 'कनेक्शन प्रोग्रेस क्या है?';
	@override String get q4 => 'मैं अपनी प्रोफ़ाइल कैसे दिखाऊँ?';
	@override String get q5 => '60 सेकंड स्ट्रेंजर क्या है?';
	@override String get q6 => 'Vibes क्या हैं?';
	@override String get q7 => 'मैं अपनी प्रोफ़ाइल कैसे एडिट करूँ?';
	@override String get q8 => 'मैं नोटिफ़िकेशन कैसे मैनेज करूँ?';
	@override String get q9 => 'मैं खरीदारी कैसे रीस्टोर करूँ?';
	@override String get q10 => 'क्या मैं सारी चैट डिलीट कर सकता/सकती हूँ?';
	@override String get q11 => 'क्या मेरा डेटा सुरक्षित है?';
	@override String get q12 => 'मैं किसी को ब्लॉक या रिपोर्ट कैसे करूँ?';
	@override String get q13 => 'मैं ऐप कैसे शेयर करूँ?';
	@override String get q14 => 'मैं अपना अकाउंट कैसे डिलीट करूँ?';
	@override String get a1 => 'Veylo पर आप गुमनाम रूप से नए लोगों से मिल सकते हैं, चैट कर सकते हैं और कनेक्शन बढ़ने के साथ धीरे-धीरे अपनी प्रोफ़ाइल दिखा सकते हैं। जब दोनों तैयार हों, तब मैसेज, वॉइस या आमने-सामने बात पर जाएँ।';
	@override String get a2 => 'गुमनाम चैट में आपकी पहचान और फ़ोटो छिपी रहती है। कनेक्शन बढ़ने पर नाम का पहला अक्षर और धुंधली फ़ोटो जैसी जानकारी अनलॉक होती है। 100% पर पूरी प्रोफ़ाइल दिखाने के लिए दोनों की सहमति ज़रूरी है।';
	@override String get a3 => 'जैसे-जैसे आप चैट करते हैं, आपका कनेक्शन प्रतिशत बढ़ता है। कुछ पड़ावों पर नाम का पहला अक्षर, धुंधली फ़ोटो और पूरी प्रोफ़ाइल अनलॉक होती है। डिटेल देखने के लिए कनेक्शन बटन पर टैप करें।';
	@override String get a4 => 'कनेक्शन 100% होने पर "मेरी प्रोफ़ाइल दिखाएँ" पर टैप करें। अगर दूसरा व्यक्ति भी स्वीकार करता है, तो दोनों की पूरी प्रोफ़ाइल दिख जाएगी।';
	@override String get a5 => 'कॉल टैब से आपको एक छोटा रैंडम मैच मिलता है। समय खत्म होने पर आप बात जारी रख सकते हैं या कॉल खत्म कर सकते हैं।';
	@override String get a6 => 'Vibes से आप आस-पास के लोगों को मैप/लिस्ट व्यू में खोज सकते हैं और जिसमें दिलचस्पी हो उससे चैट शुरू कर सकते हैं।';
	@override String get a7 => 'प्रोफ़ाइल टैब खोलें और "प्रोफ़ाइल एडिट करें" में जाकर अपना नाम, फ़ोटो, बायो और रुचियाँ अपडेट करें। सेव करने के बाद बदलाव दिखेंगे।';
	@override String get a8 => 'मैसेज, मैच और दूसरे अलर्ट चालू या बंद करने के लिए सेटिंग्स में नोटिफ़िकेशन खोलें।';
	@override String get a9 => 'सेटिंग्स → अकाउंट मैनेजमेंट → खरीदारी रीस्टोर करें पर जाएँ। उसी स्टोर अकाउंट की योग्य खरीदारी रीस्टोर हो जाएगी।';
	@override String get a10 => 'हाँ। सेटिंग्स → चैट डिलीट करें इस्तेमाल करें और कन्फ़र्म करें। सारी चैट हट जाएँगी। इसे वापस नहीं किया जा सकता।';
	@override String get a11 => 'आपके अकाउंट की जानकारी और मैसेज सुरक्षित सिस्टम पर रखे जाते हैं। आप कभी भी अकाउंट मैनेजमेंट से अकाउंट और डेटा डिलीट करने की रिक्वेस्ट भी कर सकते हैं।';
	@override String get a12 => 'ब्लॉक या रिपोर्ट करने के लिए प्रोफ़ाइल या चैट स्क्रीन पर मेन्यू इस्तेमाल करें। रिपोर्ट हमारी टीम देखती है।';
	@override String get a13 => 'लिंक कॉपी करके दोस्तों को भेजने के लिए सेटिंग्स में "ऐप शेयर करें" इस्तेमाल करें।';
	@override String get a14 => 'सेटिंग्स → अकाउंट मैनेजमेंट → अकाउंट और डेटा डिलीट करें पर जाएँ। वजह बताने के बाद, डिलीट रिक्वेस्ट भेजने के लिए कन्फ़र्म करें।';
}

// Path: legal
class _Translations$legal$hi extends Translations$legal$tr {
	_Translations$legal$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get termsTitle => 'सेवा की शर्तें';
	@override String get privacyTitle => 'प्राइवेसी पॉलिसी';
	@override String get termsBody => 'अंतिम अपडेट: 16 मार्च 2026\n\nVeylo में आपका स्वागत है। अकाउंट बनाकर या ऐप का इस्तेमाल करके, आप सेवा की इन शर्तों से सहमत होते हैं।\n\n1. Veylo क्या है\nVeylo एक सोशल ऐप है जहाँ आप लोगों से मिल सकते हैं, गुमनाम चैट कर सकते हैं, समय के साथ कनेक्शन बना सकते हैं, और दोनों की सहमति होने पर चाहें तो वॉइस या आमने-सामने की कॉल पर जा सकते हैं।\n\n2. आपका अकाउंट\nआपको सही जानकारी देनी होगी और अपना लॉगिन सुरक्षित रखना होगा। आपके अकाउंट से होने वाली गतिविधि की ज़िम्मेदारी आपकी है। अपने देश के कानून के अनुसार Veylo इस्तेमाल करने के लिए आपकी उम्र पर्याप्त होनी चाहिए।\n\n3. सम्मानजनक इस्तेमाल\nपरेशान न करें, धमकी न दें, धोखाधड़ी न करें, किसी और का रूप न धरें, गैरकानूनी कंटेंट शेयर न करें, या सुरक्षा फ़ीचर्स को बायपास करने की कोशिश न करें। इन नियमों को तोड़ने वाले कंटेंट को हम हटा सकते हैं, फ़ीचर्स सीमित कर सकते हैं या अकाउंट सस्पेंड कर सकते हैं।\n\n4. गुमनाम चैट और प्रोफ़ाइल दिखाना\nगुमनाम चैट में कनेक्शन के पड़ाव पूरे होने तक आपका नाम और फ़ोटो छिपे रह सकते हैं। पूरी प्रोफ़ाइल दिखाने के लिए दोनों की सहमति ज़रूरी है। दूसरों पर अपनी पहचान बताने का दबाव न डालें।\n\n5. खरीदारी\nकुछ फ़ीचर्स पेड हो सकते हैं। खरीदारी Apple App Store या Google Play द्वारा प्रोसेस की जाती है। "खरीदारी रीस्टोर करें" उसी स्टोर अकाउंट की योग्य खरीदारी वापस लाता है। रिफ़ंड स्टोर की पॉलिसी के अनुसार होते हैं।\n\n6. आपके द्वारा शेयर किया गया कंटेंट\nआपके कंटेंट के अधिकार आपके पास रहते हैं, लेकिन सेवा चलाने के लिए ज़रूरत के अनुसार आप Veylo को इसे ऐप में होस्ट करने और दिखाने का लाइसेंस देते हैं। ऐसा कंटेंट पोस्ट न करें जिसे शेयर करने का आपको अधिकार नहीं है।\n\n7. इस्तेमाल बंद करना\nआप कभी भी Veylo का इस्तेमाल बंद कर सकते हैं और सेटिंग्स से अकाउंट डिलीट करने की रिक्वेस्ट कर सकते हैं। ज़रूरत पड़ने पर हम उचित सूचना देकर सेवा बंद या उसमें बदलाव भी कर सकते हैं।\n\n8. संपर्क\nइन शर्तों के बारे में सवाल: support@veylo.app';
	@override String get privacyBody => 'अंतिम अपडेट: 16 मार्च 2026\n\nयह प्राइवेसी पॉलिसी बताती है कि Veylo आपकी जानकारी कैसे इकट्ठा करता है, इस्तेमाल करता है और सुरक्षित रखता है।\n\n1. हम कौन-सी जानकारी इकट्ठा करते हैं\n• अकाउंट डेटा: ईमेल, डिस्प्ले नाम, प्रोफ़ाइल फ़ोटो, बायो, पसंद\n• इस्तेमाल का डेटा: चैट, कनेक्शन प्रोग्रेस, आपके द्वारा इस्तेमाल किए गए कॉल फ़ीचर्स, डिवाइस/ऐप की बुनियादी जानकारी\n• खरीदारी: पेड फ़ीचर्स अनलॉक और रीस्टोर करने के लिए ज़रूरी स्टोर रसीद डेटा\n\n2. हम इसका इस्तेमाल कैसे करते हैं\nहम आपके डेटा का इस्तेमाल Veylo चलाने, मैचिंग और चैट अनुभव को पर्सनलाइज़ करने, कम्युनिटी को सुरक्षित रखने, खरीदारी प्रोसेस करने और प्रोडक्ट को बेहतर बनाने के लिए करते हैं। हम आपका पर्सनल डेटा नहीं बेचते।\n\n3. गुमनाम मोड\nगुमनाम चैट में, अनलॉक नियम और दोनों की सहमति ज़्यादा दिखाने की अनुमति देने तक, हम सीमित रखते हैं कि दूसरे क्या देखें (जैसे छिपा हुआ नाम या धुंधली फ़ोटो)। फ़ीचर को सुरक्षित रूप से चलाने के लिए हमें बैकग्राउंड में फिर भी अकाउंट आइडेंटिफ़ायर की ज़रूरत होती है।\n\n4. शेयर करना\nहम ऐसे सर्विस प्रोवाइडर्स के साथ डेटा शेयर कर सकते हैं जो होस्टिंग, एनालिसिस या पेमेंट प्रोसेस करने में हमारी मदद करते हैं—सिर्फ़ ज़रूरत के अनुसार। कानून द्वारा ज़रूरी होने पर या यूज़र्स को नुकसान से बचाने के लिए भी हम जानकारी दे सकते हैं।\n\n5. डेटा रखना\nजब तक आपका अकाउंट एक्टिव है और कानूनी, सुरक्षा और बिलिंग कारणों से जितना ज़रूरी हो, हम डेटा रखते हैं। डिलीट करने की रिक्वेस्ट पूरी होने के बाद, जहाँ रखना ज़रूरी हो उसके अलावा, हम पर्सनल डेटा हटा देते हैं या उसे गुमनाम कर देते हैं।\n\n6. आपके विकल्प\nआप प्रोफ़ाइल की जानकारी एडिट कर सकते हैं, नोटिफ़िकेशन मैनेज कर सकते हैं, अकाउंट डिलीट करने की रिक्वेस्ट कर सकते हैं और अपने डेटा के बारे में हमसे संपर्क कर सकते हैं। स्टोर की खरीदारी Apple या Google के ज़रिए भी मैनेज होती है।\n\n7. सुरक्षा\nआपकी जानकारी की सुरक्षा के लिए हम उचित तकनीकी और संगठनात्मक उपाय अपनाते हैं। कोई भी सिस्टम पूरी तरह सुरक्षित नहीं है; कृपया मज़बूत पासवर्ड इस्तेमाल करें और अपना डिवाइस अपडेट रखें।\n\n8. संपर्क\nप्राइवेसी से जुड़े सवाल: privacy@veylo.app';
}

// Path: logout
class _Translations$logout$hi extends Translations$logout$tr {
	_Translations$logout$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'लॉग आउट';
	@override String get subtitle => 'क्या आप सच में लॉग आउट करना चाहते हैं?';
	@override String get cancel => 'रद्द करें';
	@override String get confirm => 'लॉग आउट';
}

// Path: deleteAccount
class _Translations$deleteAccount$hi extends Translations$deleteAccount$tr {
	_Translations$deleteAccount$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'अकाउंट डिलीट करने की रिक्वेस्ट भेजें';
	@override String get subtitle => 'क्या आप सच में अपना अकाउंट डिलीट करना चाहते हैं?';
	@override String get reasonTitle => 'हम नहीं चाहते कि आप जाएँ, पर हम समझते हैं।';
	@override String get reasonBefore => 'क्या आप बताएँगे कि आप क्यों जाना चाहते हैं, ताकि हम ';
	@override String get reasonAfter => ' का अनुभव बेहतर बना सकें?';
	@override String get reasonLabel => 'आप अपना अकाउंट क्यों डिलीट करना चाहते हैं';
	@override String get reasonHint => 'अपना मैसेज लिखें';
	@override String get cancel => 'रद्द करें';
	@override String get createRequest => 'रिक्वेस्ट बनाएँ';
	@override String get confirmTitle => 'क्या आप सच में डिलीट रिक्वेस्ट भेजना चाहते हैं?';
	@override String get confirmSubtitle => 'कन्फ़र्म करने पर आपके अकाउंट को डिलीट करने की रिक्वेस्ट भेज दी जाएगी';
	@override String get delete => 'डिलीट करें';
}

// Path: storyText
class _Translations$storyText$hi extends Translations$storyText$tr {
	_Translations$storyText$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get bold => 'बोल्ड';
	@override String get italic => 'इटैलिक';
	@override String get uppercase => 'अपरकेस';
	@override String get underline => 'अंडरलाइन';
	@override String get cancel => 'रद्द करें';
	@override String get galleryError => 'गैलरी नहीं खुल सकी';
}

// Path: discover.aiMatch
class _Translations$discover$aiMatch$hi extends Translations$discover$aiMatch$tr {
	_Translations$discover$aiMatch$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get feelingTitle => 'आज आप कैसा महसूस कर रहे हैं';
	@override String get feelingSubtitle => 'आपकी पसंद के आधार पर AI सबसे अच्छा मैच ढूँढता है';
	@override String get lookingTitle => 'आप क्या ढूँढ रहे हैं?';
	@override String get moodSad => 'उदास';
	@override String get moodMeltie => 'ठीक-ठाक';
	@override String get moodBored => 'बोर';
	@override String get moodCrying => 'मायूस';
	@override String get moodSmile => 'खुश';
	@override String get lookingNewFriends => 'नए दोस्त';
	@override String get lookingVenting => 'दिल की बात';
	@override String get lookingFlirty => 'फ़्लर्टी चैट';
	@override String get lookingFun => 'मस्ती';
	@override String get lookingCultures => 'नई संस्कृतियाँ';
	@override String get lookingLanguage => 'भाषा प्रैक्टिस';
	@override String get statActiveUsers => 'एक्टिव यूज़र';
	@override String get statMatchRate => 'मैच रेट';
	@override String get statAvgTime => 'औसत समय';
	@override String get statActiveValue => '843';
	@override String get statMatchValue => '87%';
	@override String get statAvgValue => '8s';
	@override String get startSmartMatch => 'स्मार्ट मैच शुरू करें';
	@override String get findingTitle => 'आपका मैच ढूँढ रहे हैं';
	@override String get findingSubtitle => 'आपके मूड और रुचियों को सही व्यक्ति से मिला रहे हैं';
	@override String get findingStepMood => 'मूड का विश्लेषण हुआ';
	@override String get findingStepInterests => 'रुचियाँ मैच हुईं';
	@override String get findingStepCompatibility => 'कम्पैटिबिलिटी देख रहे हैं...';
	@override String get findingStepContent => 'कंटेंट तैयार हो रहा है...';
	@override String findingOnline({required Object count}) => 'अभी ${count} लोग ऑनलाइन हैं';
	@override String get yourMatchTitle => 'आपका मैच';
	@override String get yourMatchSubtitle => 'आपके जवाबों के आधार पर आपका मैच हुआ है';
	@override String vibeMatch({required Object percent}) => '${percent}% Vibe मैच';
	@override String get startChatting => 'चैट शुरू करें';
	@override String matchNameAge({required Object name, required Object age}) => '${name}, ${age}';
	@override String get matchBio => 'मैं आपको वो महसूस कराऊँगा जो आपने कभी सोचा भी नहीं था।';
	@override String get swipePrevious => 'पिछला';
	@override String get swipeNext => 'अगला';
	@override String get swipeFinger => 'उंगली से स्वाइप करें';
	@override String get noMatch => 'अभी कोई मैच नहीं मिला। थोड़ी देर बाद फिर कोशिश करें।';
}

// Path: discover.privateRoom
class _Translations$discover$privateRoom$hi extends Translations$discover$privateRoom$tr {
	_Translations$discover$privateRoom$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get subtitle => 'यह एक प्राइवेट रूम है। टोकन से एक्सेस अनलॉक करें।';
	@override String get roomAccess => 'रूम एक्सेस';
	@override String get yourBalance => 'आपका बैलेंस';
	@override String tokensAmount({required Object count}) => '${count} टोकन';
	@override String joinForTokens({required Object count}) => '${count} टोकन में जॉइन करें';
	@override String get cancel => 'रद्द करें';
}

// Path: discover.roomToken
class _Translations$discover$roomToken$hi extends Translations$discover$roomToken$tr {
	_Translations$discover$roomToken$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get subtitle => 'टोकन से एक्सेस अनलॉक करें।';
	@override String get roomAccess => 'रूम एक्सेस';
	@override String get yourBalance => 'आपका बैलेंस';
	@override String tokensAmount({required Object count}) => '${count} टोकन';
	@override String joinForTokens({required Object count}) => '${count} टोकन में जॉइन करें';
	@override String get cancel => 'रद्द करें';
}

// Path: discover.privateRequest
class _Translations$discover$privateRequest$hi extends Translations$discover$privateRequest$tr {
	_Translations$discover$privateRequest$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'जॉइन करने की रिक्वेस्ट';
	@override String roomInfo({required Object name, required Object count}) => '${name} · ${count} मेंबर';
	@override String get messageHint => 'कुछ कहें (वैकल्पिक)...';
	@override String get sendRequest => 'रिक्वेस्ट भेजें';
	@override String get adminReview => 'रूम एडमिन आपकी रिक्वेस्ट देखेंगे';
}

// Path: discover.roomApproved
class _Translations$discover$roomApproved$hi extends Translations$discover$roomApproved$tr {
	_Translations$discover$roomApproved$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'आप अंदर हैं!';
	@override String subtitle({required Object name}) => '${name} में आपकी जगह पक्की है';
	@override String get continueLabel => 'जारी रखें';
}

// Path: discover.createSpace
class _Translations$discover$createSpace$hi extends Translations$discover$createSpace$tr {
	_Translations$discover$createSpace$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'रूम या ग्रुप बनाएँ';
	@override String get subtitle => 'ग्रुप या लाइव रूम बनाकर ज़्यादा लोगों तक पहुँचें';
	@override String get room => 'रूम';
	@override String get group => 'ग्रुप';
	@override String get hideAccount => 'अपना अकाउंट छिपाएँ';
	@override String get create => 'बनाएँ';
	@override String get cancel => 'रद्द करें';
	@override String get createRoomTitle => 'रूम बनाएँ';
	@override String get createGroupTitle => 'ग्रुप बनाएँ';
	@override String get nameSubtitle => 'अपने ग्रुप को एक नाम दें';
	@override String get nameHint => 'रात के उल्लू';
	@override String createRoomFor({required Object count}) => '${count} टोकन में बनाएँ';
}

// Path: discover.liveRoom
class _Translations$discover$liveRoom$hi extends Translations$discover$liveRoom$tr {
	_Translations$discover$liveRoom$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get adminSuffix => '(एडमिन)';
	@override String get messageHint => 'मैसेज';
	@override String get quickReplyHey => 'हाय, सब लोग!';
	@override String get quickReplyTopic => 'टॉपिक क्या है?';
	@override String get quickReplyNew => 'मैं यहाँ नया हूँ!';
	@override String get sampleChatName => 'Sona';
	@override String get sampleChatBody => 'क्या करें? आपके मन में क्या है?';
	@override String get roomEnded => 'रूम खत्म हो गया है।';
	@override String wantsToJoin({required Object name}) => '${name} जॉइन करना चाहते हैं';
	@override String get approve => 'स्वीकार करें';
}

// Path: discover.groupChat
class _Translations$discover$groupChat$hi extends Translations$discover$groupChat$tr {
	_Translations$discover$groupChat$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String usersCount({required Object count}) => '${count} यूज़र';
	@override String get sampleVictoria => 'मैं बहुत बोर हो रही हूँ। दोस्तों, कुछ करें?';
	@override String get sampleSona => 'क्या करें? आपके मन में क्या है?';
	@override String get sampleOwn => 'चलो घाट पर मिलते हैं';
}

// Path: discover.groupInfo
class _Translations$discover$groupInfo$hi extends Translations$discover$groupInfo$tr {
	_Translations$discover$groupInfo$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get media => 'मीडिया';
	@override String get gallery => 'गैलरी';
	@override String get settings => 'सेटिंग्स';
	@override String get notifications => 'नोटिफ़िकेशन';
	@override String get blocked => 'ब्लॉक किए गए';
	@override String get private => 'प्राइवेट';
	@override String membersCount({required Object count}) => '${count} मेंबर';
	@override String get addPeople => 'लोग जोड़ें';
	@override String get you => 'आप';
	@override String get admin => 'एडमिन';
	@override String get leaveGroup => 'ग्रुप छोड़ें';
	@override String get requests => 'जॉइन रिक्वेस्ट';
	@override String get approve => 'स्वीकार करें';
	@override String get reject => 'अस्वीकार करें';
	@override String get addPeopleEmpty => 'लोगों को ग्रुप में जोड़ने के लिए पहले उन्हें फ़ॉलो करें।';
	@override String get add => 'जोड़ें';
	@override String get makeAdmin => 'एडमिन बनाएँ';
	@override String get removeAdmin => 'एडमिन से हटाएँ';
	@override String get remove => 'ग्रुप से हटाएँ';
	@override String get leaveConfirm => 'यह ग्रुप छोड़ें?';
	@override String get leave => 'छोड़ें';
	@override String get cancel => 'रद्द करें';
}

// Path: discover.filters
class _Translations$discover$filters$hi extends Translations$discover$filters$tr {
	_Translations$discover$filters$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'फ़िल्टर';
	@override String get ageRange => 'उम्र सीमा';
	@override String ageRangeValue({required Object min, required Object max}) => '${min}-${max}';
	@override String get distance => 'दूरी';
	@override String distanceValue({required Object km}) => '${km} किमी';
	@override String get showMe => 'मुझे दिखाएँ';
	@override String get everyone => 'सभी';
	@override String get women => 'महिलाएँ';
	@override String get men => 'पुरुष';
	@override String get interests => 'रुचियाँ';
	@override String get activeNow => 'अभी एक्टिव';
	@override String get activeNowSubtitle => 'सिर्फ़ अभी ऑनलाइन लोग दिखाएँ';
	@override String get showResult => 'रिज़ल्ट दिखाएँ';
}

// Path: discover.post
class _Translations$discover$post$hi extends Translations$discover$post$tr {
	_Translations$discover$post$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get follow => 'फ़ॉलो करें';
	@override String get following => 'फ़ॉलो कर रहे हैं';
	@override String get addComment => 'कमेंट करें...';
	@override String get commentsTitle => 'कमेंट';
	@override String get sampleCaption => 'एक खूबसूरत दिन के बाद एक कप कॉफ़ी जैसा कुछ नहीं। <3';
	@override String hoursAgo({required Object hours}) => '${hours} घं.';
	@override String minutesAgo({required Object minutes}) => '${minutes} मि.';
	@override String daysAgo({required Object days}) => '${days} दि.';
	@override String get deleteCommentTitle => 'यह कमेंट डिलीट करें?';
}

// Path: discover.story
class _Translations$discover$story$hi extends Translations$discover$story$tr {
	_Translations$discover$story$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get draft => 'ड्राफ़्ट';
	@override String get story => 'स्टोरी';
	@override String get share => 'शेयर करें';
	@override String get textPlaceholder => 'कुछ लिखें...';
	@override String get draftPrompt => 'ड्राफ़्ट में सेव करें?';
	@override String get saveToDraft => 'ड्राफ़्ट में सेव करें';
	@override String get moveToTrash => 'ट्रैश में डालें';
	@override String get save => 'सेव करें';
	@override String get musicTitle => 'म्यूज़िक';
	@override String get musicEmpty => 'कोई म्यूज़िक नहीं मिला।';
	@override String get musicError => 'म्यूज़िक लोड नहीं हो सका।';
	@override String get downloaded => 'गैलरी में सेव हो गया';
	@override String get downloadFailed => 'सेव नहीं हो सका';
}

// Path: discover.highlight
class _Translations$discover$highlight$hi extends Translations$discover$highlight$tr {
	_Translations$discover$highlight$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'हाइलाइट';
	@override String get view => 'देखें';
	@override String get aiComments => 'AI कमेंट';
	@override String get remove => 'हाइलाइट हटाएँ';
	@override String get sharedSuccess => 'आपकी पोस्ट शेयर हो गई';
	@override String get boost => 'बूस्ट करें';
}

// Path: discover.stats
class _Translations$discover$stats$hi extends Translations$discover$stats$tr {
	_Translations$discover$stats$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'आँकड़े';
	@override String get subtitle => 'आपकी पोस्ट से जुड़े आँकड़े\nनीचे दिए गए हैं।';
	@override String get viewers => 'व्यूअर';
	@override String get comments => 'कमेंट';
	@override String get likes => 'लाइक';
	@override String get boostCta => '1 दिन बूस्ट करें - 100 टोकन';
	@override String get boosted => 'बूस्ट हो गया! आपकी पोस्ट 24 घंटे तक सबसे ऊपर रहेगी।';
}

// Path: createProfile.interests
class _Translations$createProfile$interests$hi extends Translations$createProfile$interests$tr {
	_Translations$createProfile$interests$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get music => 'म्यूज़िक';
	@override String get movies => 'फ़िल्में';
	@override String get tvShows => 'TV शो';
	@override String get reading => 'पढ़ना';
	@override String get painting => 'पेंटिंग';
	@override String get photography => 'फ़ोटोग्राफ़ी';
	@override String get theatre => 'थिएटर';
	@override String get fitness => 'फ़िटनेस';
	@override String get swimming => 'तैराकी';
	@override String get football => 'फ़ुटबॉल';
	@override String get basketball => 'बास्केटबॉल';
	@override String get coffee => 'कॉफ़ी';
	@override String get travel => 'घूमना-फिरना';
	@override String get camping => 'कैंपिंग';
	@override String get meditation => 'मेडिटेशन';
	@override String get videoGames => 'वीडियो गेम';
	@override String get boardGames => 'बोर्ड गेम';
	@override String get standUp => 'स्टैंड-अप कॉमेडी';
	@override String get tech => 'टेक';
	@override String get coding => 'कोडिंग';
	@override String get ai => 'AI';
	@override String get podcast => 'पॉडकास्ट';
}

/// The flat map containing all translations for locale <hi>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsHi {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.name' => 'Veylo',
			'app.tagline' => 'स्वागत है',
			'home.title' => 'होम',
			'home.subtitle' => 'ऐप तैयार हो रहा है',
			'home.body' => 'बहुभाषी UI को slang से मैनेज किया जाता है।',
			'chats.title' => 'चैट',
			'chats.search' => 'खोजें',
			'chats.messagesSection' => 'मैसेज',
			'chats.request' => 'रिक्वेस्ट',
			'chats.emptyRequestTitle' => 'कोई नया मैसेज\nनोटिफ़िकेशन नहीं है',
			'chats.emptyRequestSubtitle' => '30 दिन से पुरानी रिक्वेस्ट नहीं दिखाई जातीं।',
			'chats.noteAdd' => 'नोट जोड़ें',
			'chats.anonymous' => 'गुमनाम',
			'chats.online' => 'ऑनलाइन',
			'chats.offline' => 'ऑफ़लाइन',
			'chats.connection' => 'कनेक्शन',
			'chats.connectionPercent' => ({required Object n}) => '${n}%',
			'chats.connectionProgressTitle' => 'कनेक्शन प्रोग्रेस',
			'chats.milestoneInitial' => 'नाम का पहला अक्षर',
			'chats.milestoneInitialHint' => '25% पर अनलॉक हुआ',
			'chats.milestoneInitialLocked' => '25% पर अनलॉक होगा',
			'chats.milestonePhoto' => 'धुंधली फ़ोटो प्रीव्यू',
			'chats.milestonePhotoHint' => '70% पर अनलॉक होगा',
			'chats.milestoneFull' => 'पूरी प्रोफ़ाइल देखें',
			'chats.milestoneFullHint' => '100% पर दोनों की सहमति से',
			'chats.sampleAnonymousMessage' => 'नमस्ते, आपसे मिलकर अच्छा लगा। क्या आप अपने बारे में थोड़ा बता सकते हैं?',
			'chats.strangerSampleMessage' => 'नमस्ते Jhon, आपसे मिलकर अच्छा लगा। क्या आप अपने बारे में थोड़ा बता सकते हैं?',
			'chats.approve' => 'स्वीकार करें',
			'chats.blockUser' => 'यूज़र ब्लॉक करें',
			'chats.reject' => 'अस्वीकार करें',
			'chats.messageHint' => 'हाय! कैसे हैं आप?',
			'chats.revealTitle' => 'आप 100% तक पहुँच गए',
			'chats.revealSubtitle' => 'एक-दूसरे को पूरी प्रोफ़ाइल दिखाएँ? दोनों की सहमति ज़रूरी है।',
			'chats.revealWaiting' => ({required Object name}) => '${name} की मंज़ूरी का इंतज़ार है',
			'chats.revealCta' => 'मेरी प्रोफ़ाइल दिखाएँ',
			'chats.revealNotYet' => 'अभी नहीं',
			'chats.seen' => 'देखा गया',
			'chats.typing' => 'टाइप कर रहे हैं…',
			'chats.noteYou' => 'आप',
			'chats.noteSheetTitle' => 'नोट शेयर करें',
			'chats.noteSheetSubtitle' => 'आपका नोट 24 घंटे तक रहेगा',
			'chats.noteHint' => 'आपके मन में क्या है?',
			'chats.noteShare' => 'शेयर करें',
			'chats.noteDelete' => 'नोट डिलीट करें',
			'profile.eyebrow' => 'प्रोफ़ाइल',
			'profile.title' => 'सेटिंग्स',
			'profile.editProfile' => 'प्रोफ़ाइल एडिट करें',
			'profile.statLike' => 'लाइक',
			'profile.statFollow' => 'फ़ॉलो',
			'profile.statFollower' => 'फ़ॉलोअर',
			'profile.promoTitle' => 'ज़्यादा मैसेज पाएँ!',
			'profile.promoSubtitle' => 'अलग दिखें, लिस्ट में सबसे ऊपर आएँ',
			'profile.standOut' => 'अलग दिखें',
			'profile.tabPosts' => 'पोस्ट',
			'profile.tabVideo' => 'वीडियो',
			'profile.tabSaved' => 'सेव किए गए',
			'profile.save' => 'सेव करें',
			'profile.changePhoto' => 'फ़ोटो बदलें',
			'profile.changeBorder' => 'बॉर्डर बदलें',
			'profile.interest' => 'रुचि',
			'profile.name' => 'नाम',
			'profile.changeName' => 'नाम बदलें',
			'profile.changePassword' => 'पासवर्ड बदलें',
			'profile.confirmPassword' => 'पासवर्ड कन्फ़र्म करें',
			'profile.email' => 'ईमेल',
			'profile.accountManagement' => 'अकाउंट मैनेजमेंट',
			'profile.settingsAbout' => 'जानकारी',
			'profile.settingsAccount' => 'अकाउंट सेटिंग्स',
			'profile.settingsSupport' => 'सहायता',
			'profile.shareApp' => 'ऐप शेयर करें',
			'profile.shareAppTitle' => 'दोस्तों के साथ शेयर करें',
			'profile.shareAppSubtitle' => 'Veylo को दोस्तों के साथ शेयर करें और साथ मिलकर खोजें!',
			'profile.shareAppLabel' => 'ऐप लिंक',
			'profile.rateApp' => 'हम पसंद आए? रेटिंग दें',
			'profile.notifications' => 'नोटिफ़िकेशन',
			'profile.password' => 'पासवर्ड',
			'profile.deleteConversation' => 'चैट डिलीट करें',
			'profile.faqHelp' => 'FAQ और सहायता',
			'profile.restorePurchases' => 'खरीदारी रीस्टोर करें',
			'profile.termsOfService' => 'सेवा की शर्तें',
			'profile.privacyPolicy' => 'प्राइवेसी पॉलिसी',
			'profile.restorePurchasesDone' => 'खरीदारी चेक हो गई',
			'profile.conversationsDeleted' => 'सभी चैट डिलीट हो गईं',
			'profile.logOut' => 'लॉग आउट',
			'profile.deleteAccountAndData' => 'अकाउंट और डेटा डिलीट करें',
			'profile.passwordPlaceholder' => '********',
			'profile.height' => 'लंबाई',
			'profile.addHeight' => 'लंबाई जोड़ें',
			'profile.heightCm' => ({required Object value}) => '${value} सेमी',
			'profile.languages' => 'भाषाएँ',
			'profile.relationshipGoals' => 'रिश्ते का लक्ष्य',
			'profile.lookingFor' => 'किसकी तलाश है',
			'profile.newFriends' => '👋 नए दोस्त',
			'profile.goalLongTermOpenToShort' => '💕 लंबा रिश्ता, छोटा भी चलेगा',
			'profile.goalLongTermRelationship' => '💘 लंबा रिश्ता',
			'profile.goalNewFriends' => '👋 नए दोस्त',
			'profile.goalShortTermFun' => '🥃 थोड़े समय की मस्ती',
			'profile.goalStillFiguringItOut' => '🤔 अभी सोच रहे हैं',
			'profile.basics' => 'बेसिक जानकारी',
			'profile.zodiac' => 'राशि',
			'profile.zodiacValue' => 'वृश्चिक',
			'profile.education' => 'शिक्षा',
			'profile.educationValue' => 'ग्रेजुएट',
			'profile.educationHighSchool' => 'हाई स्कूल',
			'profile.educationAssociates' => 'डिप्लोमा',
			'profile.educationBachelors' => 'ग्रेजुएशन',
			'profile.educationMasters' => 'पोस्ट ग्रेजुएशन',
			'profile.educationPhd' => 'PhD / डॉक्टरेट',
			'profile.voiceRecord' => 'वॉइस रिकॉर्ड',
			'profile.addVoice' => 'वॉइस जोड़ें',
			'profile.lifestyle' => 'लाइफ़स्टाइल',
			'profile.pets' => 'पालतू जानवर',
			'profile.petsValue' => 'मेरे पास बिल्ली है',
			'profile.petsDontWant' => 'पालतू जानवर नहीं चाहिए',
			'profile.petsAllergic' => 'मुझे पालतू जानवरों से एलर्जी है',
			'profile.petsHaveCat' => 'मेरे पास बिल्ली है',
			'profile.petsHaveDog' => 'मेरे पास कुत्ता है',
			'profile.petsHaveCatsAndDogs' => 'मेरे पास बिल्लियाँ और कुत्ते हैं',
			'profile.petsHaveOther' => 'मेरे पास दूसरे पालतू हैं',
			'profile.drinking' => 'ड्रिंकिंग',
			'profile.drinkingValue' => 'खास मौकों पर',
			'profile.drinkingNever' => 'कभी नहीं',
			'profile.drinkingSpecialOccasions' => 'खास मौकों पर',
			'profile.drinkingSocially' => 'दोस्तों के साथ',
			'profile.drinkingFrequently' => 'अक्सर',
			'profile.drinkingSober' => 'बिल्कुल नहीं पीते',
			'profile.drinkingPreferNotToSay' => 'बताना नहीं चाहते',
			'profile.smoking' => 'स्मोकिंग',
			'profile.smokingValue' => 'स्मोक नहीं करते',
			'profile.smokingNonSmoker' => 'स्मोक नहीं करते',
			'profile.smokingSocialSmoker' => 'कभी-कभार दोस्तों के साथ',
			'profile.smokingSmoker' => 'स्मोक करते हैं',
			'profile.smokingTryingToQuit' => 'छोड़ने की कोशिश में',
			'profile.smokingWhenDrinking' => 'ड्रिंक करते समय',
			'profile.smokingPreferNotToSay' => 'बताना नहीं चाहते',
			'profile.gender' => 'जेंडर',
			'profile.genderFemale' => 'महिला',
			'profile.genderMale' => 'पुरुष',
			'profile.genderPreferNotToSay' => 'बताना नहीं चाहते',
			'profile.visible' => 'दिखाई दे रहा है',
			'profile.profileVisibility' => 'प्रोफ़ाइल विज़िबिलिटी',
			'profile.language' => 'भाषा',
			'profile.borderTitle' => 'प्रोफ़ाइल बॉर्डर',
			'profile.borderSubtitle' => 'अपनी प्रोफ़ाइल में बॉर्डर जोड़ें और\nसबसे अलग दिखें।',
			'profile.borderBuySection' => 'बॉर्डर खरीदें',
			'profile.borderBuyCta' => 'बॉर्डर खरीदें',
			'profile.borderToken' => ({required Object count}) => '${count} टोकन',
			'profile.borderAmethystWings' => 'Amethyst Wings',
			'profile.borderGoldenPhoenix' => 'Golden Phoenix',
			'profile.borderFrostCrown' => 'Frost Crown',
			'profile.borderEmeraldWhisper' => 'Emerald Whisper',
			'profile.borderRoseQuartz' => 'Rose Quartz',
			'profile.borderStarlitComet' => 'Starlit Comet',
			'profile.borderCrimsonRoyal' => 'Crimson Royal',
			'profile.borderSapphireHalo' => 'Sapphire Halo',
			'profile.follow' => 'फ़ॉलो करें',
			'profile.following' => 'फ़ॉलो कर रहे हैं',
			'profile.followPageTitle' => 'फ़ॉलो',
			'profile.followTabFollowing' => 'फ़ॉलोइंग',
			'profile.followTabFollowers' => 'फ़ॉलोअर्स',
			'profile.followSearch' => 'खोजें',
			'profile.unfollow' => 'अनफ़ॉलो करें',
			'profile.followSortTitle' => 'क्रम',
			'profile.followSortRecent' => 'जिन्हें हाल ही में फ़ॉलो किया',
			'profile.followSortNotFollowingMe' => 'जो मुझे वापस फ़ॉलो नहीं करते',
			'profile.followSortNotFollowedByMe' => 'जिन्हें मैं वापस फ़ॉलो नहीं करता',
			'profile.followSortShowResult' => 'रिज़ल्ट दिखाएँ',
			'profile.followSortEmpty' => 'इस फ़िल्टर से कोई यूज़र नहीं मिला',
			'profile.shareTitle' => 'दोस्तों के साथ शेयर करें',
			'profile.shareSubtitle' => 'दोस्तों के साथ जुड़ने पर हर चीज़\nज़्यादा मज़ेदार होती है!',
			'profile.shareProfileLabel' => 'प्रोफ़ाइल शेयर करें',
			'profile.shareLinkCopied' => 'लिंक कॉपी हो गया',
			'profile.restrict' => 'रिस्ट्रिक्ट करें',
			'profile.block' => 'ब्लॉक करें',
			'profile.report' => 'रिपोर्ट करें',
			'profile.blockTitle' => ({required Object username}) => '${username} को ब्लॉक करें?',
			'profile.blockBody' => 'इससे उनके दूसरे मौजूदा या भविष्य में बनने वाले अकाउंट भी ब्लॉक हो जाएँगे। आप कभी भी अनब्लॉक कर सकते हैं।',
			'profile.blockAndReport' => 'ब्लॉक और रिपोर्ट करें',
			'profile.restrictTitle' => ({required Object username}) => '${username} को रिस्ट्रिक्ट करें?',
			'profile.restrictBody' => 'वे नहीं देख पाएँगे कि आप कब ऑनलाइन हैं या आपने उनके मैसेज पढ़े हैं। आप इसे कभी भी बदल सकते हैं।',
			'profile.restrictAndReport' => 'रिस्ट्रिक्ट और रिपोर्ट करें',
			'profile.reportTitle' => 'हम वजह जानना चाहेंगे',
			'profile.reportSubtitle' => 'आपको बेहतर अनुभव देने के लिए, क्या आप बता सकते हैं कि आप इस यूज़र को क्यों रिपोर्ट करना चाहते हैं?',
			'profile.reportMessageLabel' => 'रिपोर्ट मैसेज',
			'profile.reportMessageHint' => 'अपना मैसेज लिखें',
			'profile.reportCancel' => 'रद्द करें',
			'profile.sendReport' => 'रिपोर्ट भेजें',
			'profile.notSet' => 'सेट नहीं है',
			'profile.reportSent' => 'धन्यवाद, हमें आपकी रिपोर्ट मिल गई है।',
			'profile.emailVerificationSent' => ({required Object email}) => 'हमने ${email} पर कन्फ़र्मेशन लिंक भेजा है। कन्फ़र्म करने के बाद आपका ईमेल बदल जाएगा।',
			'profile.passwordChanged' => 'आपका पासवर्ड अपडेट हो गया है।',
			'profile.passwordMismatch' => 'पासवर्ड मेल नहीं खाते।',
			'nav.discover' => 'डिस्कवर',
			'nav.chat' => 'चैट',
			'nav.call' => 'कॉल',
			'nav.vibes' => 'Vibes',
			'nav.profile' => 'प्रोफ़ाइल',
			'call.title' => '60 सेकंड स्ट्रेंजर',
			'call.subtitle' => 'किसी अनजान व्यक्ति से 60 सेकंड बात करें — पूरी तरह गुमनाम। न प्रोफ़ाइल, न फ़ोटो, न नाम। बस एक आवाज़ और एक पल।',
			'call.findingTitle' => 'स्ट्रेंजर ढूँढ रहे हैं...',
			'call.findingSubtitle' => 'आप 60 सेकंड तक गुमनाम बात करेंगे। न प्रोफ़ाइल, न नाम।',
			'call.callStranger' => 'स्ट्रेंजर को कॉल करें - 10 टोकन',
			'call.cancel' => 'रद्द करें',
			'call.female' => 'महिला',
			'call.male' => 'पुरुष',
			'call.nonBinary' => 'नॉन-बाइनरी',
			'call.preferNotToSay' => 'बताना नहीं चाहते',
			'call.anonymousBadge' => '🎙️ गुमनाम वॉइस कॉल',
			'call.stranger' => 'स्ट्रेंजर',
			'call.secondsLeft' => ({required Object n}) => '${n}s',
			'call.timesUpTitle' => 'समय खत्म!',
			'call.timesUpSubtitle' => 'और बात करनी है? अगर दोनों हाँ कहें, तो चैट अनलॉक हो जाएगी।',
			'call.keepTalking' => 'बात जारी रखें',
			'call.endCall' => 'कॉल खत्म करें',
			'call.waitingOther' => 'दूसरे व्यक्ति का इंतज़ार...',
			'call.callStrangerFree' => 'स्ट्रेंजर को कॉल करें',
			'call.peerLeft' => 'दूसरे व्यक्ति ने कॉल खत्म कर दी।',
			'call.noKeep' => 'इस बार चैट अनलॉक नहीं हुई।',
			'call.videoWaiting' => 'वीडियो कॉल स्वीकार होने का इंतज़ार...',
			'call.videoDeclined' => 'उन्होंने वीडियो कॉल अस्वीकार कर दी।',
			'call.micDenied' => 'कॉल के लिए माइक्रोफ़ोन एक्सेस ज़रूरी है। आप इसे सेटिंग्स में चालू कर सकते हैं।',
			'call.videoCost' => 'वीडियो कॉल: 20 टोकन / 15 मिनट',
			'call.calling' => 'कॉल हो रही है',
			'call.accept' => 'स्वीकार करें',
			'call.decline' => 'अस्वीकार करें',
			'call.switchToVideo' => 'क्या आप वीडियो कॉल पर जाना चाहेंगे?',
			'call.noMatchTitle' => 'अभी कोई उपलब्ध नहीं है',
			'call.noMatchBody' => 'इस समय बात करने के लिए कोई नहीं मिला। थोड़ी देर बाद फिर से कोशिश करें।',
			'call.noMatchOk' => 'ठीक है',
			'vibes.search' => 'खोजें',
			'vibes.sendMessage' => 'मैसेज भेजें',
			'vibes.wantsToTalk' => 'अभी इस बारे में बात करना चाहते हैं',
			'vibes.shareTitle' => 'Vibe शेयर करें',
			'vibes.replyTitle' => 'Vibe का जवाब दें',
			'vibes.shareHint' => 'कुछ लिखें',
			'vibes.shareAnonymous' => 'गुमनाम रूप से शेयर करें',
			'vibes.empty' => 'पिछले 24 घंटों में कोई Vibe नहीं। पहला आप शेयर करें!',
			'vibes.deleteTitle' => 'यह Vibe डिलीट करें?',
			'vibes.delete' => 'डिलीट करें',
			'vibes.cancel' => 'रद्द करें',
			'discover.title' => 'डिस्कवर',
			'discover.tabRooms' => 'रूम',
			'discover.tabDiscover' => 'डिस्कवर',
			'discover.tabAiMatch' => 'AI Match',
			'discover.aiMatch.feelingTitle' => 'आज आप कैसा महसूस कर रहे हैं',
			'discover.aiMatch.feelingSubtitle' => 'आपकी पसंद के आधार पर AI सबसे अच्छा मैच ढूँढता है',
			'discover.aiMatch.lookingTitle' => 'आप क्या ढूँढ रहे हैं?',
			'discover.aiMatch.moodSad' => 'उदास',
			'discover.aiMatch.moodMeltie' => 'ठीक-ठाक',
			'discover.aiMatch.moodBored' => 'बोर',
			'discover.aiMatch.moodCrying' => 'मायूस',
			'discover.aiMatch.moodSmile' => 'खुश',
			'discover.aiMatch.lookingNewFriends' => 'नए दोस्त',
			'discover.aiMatch.lookingVenting' => 'दिल की बात',
			'discover.aiMatch.lookingFlirty' => 'फ़्लर्टी चैट',
			'discover.aiMatch.lookingFun' => 'मस्ती',
			'discover.aiMatch.lookingCultures' => 'नई संस्कृतियाँ',
			'discover.aiMatch.lookingLanguage' => 'भाषा प्रैक्टिस',
			'discover.aiMatch.statActiveUsers' => 'एक्टिव यूज़र',
			'discover.aiMatch.statMatchRate' => 'मैच रेट',
			'discover.aiMatch.statAvgTime' => 'औसत समय',
			'discover.aiMatch.statActiveValue' => '843',
			'discover.aiMatch.statMatchValue' => '87%',
			'discover.aiMatch.statAvgValue' => '8s',
			'discover.aiMatch.startSmartMatch' => 'स्मार्ट मैच शुरू करें',
			'discover.aiMatch.findingTitle' => 'आपका मैच ढूँढ रहे हैं',
			'discover.aiMatch.findingSubtitle' => 'आपके मूड और रुचियों को सही व्यक्ति से मिला रहे हैं',
			'discover.aiMatch.findingStepMood' => 'मूड का विश्लेषण हुआ',
			'discover.aiMatch.findingStepInterests' => 'रुचियाँ मैच हुईं',
			'discover.aiMatch.findingStepCompatibility' => 'कम्पैटिबिलिटी देख रहे हैं...',
			'discover.aiMatch.findingStepContent' => 'कंटेंट तैयार हो रहा है...',
			'discover.aiMatch.findingOnline' => ({required Object count}) => 'अभी ${count} लोग ऑनलाइन हैं',
			'discover.aiMatch.yourMatchTitle' => 'आपका मैच',
			'discover.aiMatch.yourMatchSubtitle' => 'आपके जवाबों के आधार पर आपका मैच हुआ है',
			'discover.aiMatch.vibeMatch' => ({required Object percent}) => '${percent}% Vibe मैच',
			'discover.aiMatch.startChatting' => 'चैट शुरू करें',
			'discover.aiMatch.matchNameAge' => ({required Object name, required Object age}) => '${name}, ${age}',
			'discover.aiMatch.matchBio' => 'मैं आपको वो महसूस कराऊँगा जो आपने कभी सोचा भी नहीं था।',
			'discover.aiMatch.swipePrevious' => 'पिछला',
			'discover.aiMatch.swipeNext' => 'अगला',
			'discover.aiMatch.swipeFinger' => 'उंगली से स्वाइप करें',
			'discover.aiMatch.noMatch' => 'अभी कोई मैच नहीं मिला। थोड़ी देर बाद फिर कोशिश करें।',
			'discover.searchHint' => 'खोजें',
			'discover.allRooms' => 'सभी रूम',
			'discover.allGroups' => 'सभी ग्रुप',
			'discover.seeAll' => 'सब देखें',
			'discover.live' => 'लाइव',
			'discover.join' => 'जॉइन करें',
			'discover.request' => 'रिक्वेस्ट',
			'discover.requested' => 'रिक्वेस्ट भेजी',
			'discover.private' => 'प्राइवेट',
			'discover.moreCount' => ({required Object count}) => '+${count} और',
			'discover.activeCount' => ({required Object count}) => '${count} एक्टिव',
			'discover.membersCount' => ({required Object count}) => '${count} मेंबर',
			'discover.privateRoom.subtitle' => 'यह एक प्राइवेट रूम है। टोकन से एक्सेस अनलॉक करें।',
			'discover.privateRoom.roomAccess' => 'रूम एक्सेस',
			'discover.privateRoom.yourBalance' => 'आपका बैलेंस',
			'discover.privateRoom.tokensAmount' => ({required Object count}) => '${count} टोकन',
			'discover.privateRoom.joinForTokens' => ({required Object count}) => '${count} टोकन में जॉइन करें',
			'discover.privateRoom.cancel' => 'रद्द करें',
			'discover.roomToken.subtitle' => 'टोकन से एक्सेस अनलॉक करें।',
			'discover.roomToken.roomAccess' => 'रूम एक्सेस',
			'discover.roomToken.yourBalance' => 'आपका बैलेंस',
			'discover.roomToken.tokensAmount' => ({required Object count}) => '${count} टोकन',
			'discover.roomToken.joinForTokens' => ({required Object count}) => '${count} टोकन में जॉइन करें',
			'discover.roomToken.cancel' => 'रद्द करें',
			'discover.privateRequest.title' => 'जॉइन करने की रिक्वेस्ट',
			'discover.privateRequest.roomInfo' => ({required Object name, required Object count}) => '${name} · ${count} मेंबर',
			'discover.privateRequest.messageHint' => 'कुछ कहें (वैकल्पिक)...',
			'discover.privateRequest.sendRequest' => 'रिक्वेस्ट भेजें',
			'discover.privateRequest.adminReview' => 'रूम एडमिन आपकी रिक्वेस्ट देखेंगे',
			'discover.roomApproved.title' => 'आप अंदर हैं!',
			'discover.roomApproved.subtitle' => ({required Object name}) => '${name} में आपकी जगह पक्की है',
			'discover.roomApproved.continueLabel' => 'जारी रखें',
			'discover.createSpace.title' => 'रूम या ग्रुप बनाएँ',
			'discover.createSpace.subtitle' => 'ग्रुप या लाइव रूम बनाकर ज़्यादा लोगों तक पहुँचें',
			'discover.createSpace.room' => 'रूम',
			'discover.createSpace.group' => 'ग्रुप',
			'discover.createSpace.hideAccount' => 'अपना अकाउंट छिपाएँ',
			'discover.createSpace.create' => 'बनाएँ',
			'discover.createSpace.cancel' => 'रद्द करें',
			'discover.createSpace.createRoomTitle' => 'रूम बनाएँ',
			'discover.createSpace.createGroupTitle' => 'ग्रुप बनाएँ',
			'discover.createSpace.nameSubtitle' => 'अपने ग्रुप को एक नाम दें',
			'discover.createSpace.nameHint' => 'रात के उल्लू',
			'discover.createSpace.createRoomFor' => ({required Object count}) => '${count} टोकन में बनाएँ',
			'discover.liveRoom.adminSuffix' => '(एडमिन)',
			'discover.liveRoom.messageHint' => 'मैसेज',
			'discover.liveRoom.quickReplyHey' => 'हाय, सब लोग!',
			'discover.liveRoom.quickReplyTopic' => 'टॉपिक क्या है?',
			'discover.liveRoom.quickReplyNew' => 'मैं यहाँ नया हूँ!',
			'discover.liveRoom.sampleChatName' => 'Sona',
			'discover.liveRoom.sampleChatBody' => 'क्या करें? आपके मन में क्या है?',
			'discover.liveRoom.roomEnded' => 'रूम खत्म हो गया है।',
			'discover.liveRoom.wantsToJoin' => ({required Object name}) => '${name} जॉइन करना चाहते हैं',
			'discover.liveRoom.approve' => 'स्वीकार करें',
			'discover.groupChat.usersCount' => ({required Object count}) => '${count} यूज़र',
			'discover.groupChat.sampleVictoria' => 'मैं बहुत बोर हो रही हूँ। दोस्तों, कुछ करें?',
			'discover.groupChat.sampleSona' => 'क्या करें? आपके मन में क्या है?',
			'discover.groupChat.sampleOwn' => 'चलो घाट पर मिलते हैं',
			'discover.groupInfo.media' => 'मीडिया',
			'discover.groupInfo.gallery' => 'गैलरी',
			'discover.groupInfo.settings' => 'सेटिंग्स',
			'discover.groupInfo.notifications' => 'नोटिफ़िकेशन',
			'discover.groupInfo.blocked' => 'ब्लॉक किए गए',
			'discover.groupInfo.private' => 'प्राइवेट',
			'discover.groupInfo.membersCount' => ({required Object count}) => '${count} मेंबर',
			'discover.groupInfo.addPeople' => 'लोग जोड़ें',
			'discover.groupInfo.you' => 'आप',
			'discover.groupInfo.admin' => 'एडमिन',
			'discover.groupInfo.leaveGroup' => 'ग्रुप छोड़ें',
			'discover.groupInfo.requests' => 'जॉइन रिक्वेस्ट',
			'discover.groupInfo.approve' => 'स्वीकार करें',
			'discover.groupInfo.reject' => 'अस्वीकार करें',
			'discover.groupInfo.addPeopleEmpty' => 'लोगों को ग्रुप में जोड़ने के लिए पहले उन्हें फ़ॉलो करें।',
			'discover.groupInfo.add' => 'जोड़ें',
			'discover.groupInfo.makeAdmin' => 'एडमिन बनाएँ',
			'discover.groupInfo.removeAdmin' => 'एडमिन से हटाएँ',
			'discover.groupInfo.remove' => 'ग्रुप से हटाएँ',
			'discover.groupInfo.leaveConfirm' => 'यह ग्रुप छोड़ें?',
			'discover.groupInfo.leave' => 'छोड़ें',
			'discover.groupInfo.cancel' => 'रद्द करें',
			'discover.filters.title' => 'फ़िल्टर',
			'discover.filters.ageRange' => 'उम्र सीमा',
			'discover.filters.ageRangeValue' => ({required Object min, required Object max}) => '${min}-${max}',
			'discover.filters.distance' => 'दूरी',
			'discover.filters.distanceValue' => ({required Object km}) => '${km} किमी',
			'discover.filters.showMe' => 'मुझे दिखाएँ',
			'discover.filters.everyone' => 'सभी',
			'discover.filters.women' => 'महिलाएँ',
			'discover.filters.men' => 'पुरुष',
			'discover.filters.interests' => 'रुचियाँ',
			'discover.filters.activeNow' => 'अभी एक्टिव',
			'discover.filters.activeNowSubtitle' => 'सिर्फ़ अभी ऑनलाइन लोग दिखाएँ',
			'discover.filters.showResult' => 'रिज़ल्ट दिखाएँ',
			'discover.post.follow' => 'फ़ॉलो करें',
			'discover.post.following' => 'फ़ॉलो कर रहे हैं',
			'discover.post.addComment' => 'कमेंट करें...',
			'discover.post.commentsTitle' => 'कमेंट',
			'discover.post.sampleCaption' => 'एक खूबसूरत दिन के बाद एक कप कॉफ़ी जैसा कुछ नहीं। <3',
			'discover.post.hoursAgo' => ({required Object hours}) => '${hours} घं.',
			'discover.post.minutesAgo' => ({required Object minutes}) => '${minutes} मि.',
			'discover.post.daysAgo' => ({required Object days}) => '${days} दि.',
			'discover.post.deleteCommentTitle' => 'यह कमेंट डिलीट करें?',
			'discover.story.draft' => 'ड्राफ़्ट',
			'discover.story.story' => 'स्टोरी',
			'discover.story.share' => 'शेयर करें',
			'discover.story.textPlaceholder' => 'कुछ लिखें...',
			'discover.story.draftPrompt' => 'ड्राफ़्ट में सेव करें?',
			'discover.story.saveToDraft' => 'ड्राफ़्ट में सेव करें',
			'discover.story.moveToTrash' => 'ट्रैश में डालें',
			'discover.story.save' => 'सेव करें',
			'discover.story.musicTitle' => 'म्यूज़िक',
			'discover.story.musicEmpty' => 'कोई म्यूज़िक नहीं मिला।',
			'discover.story.musicError' => 'म्यूज़िक लोड नहीं हो सका।',
			'discover.story.downloaded' => 'गैलरी में सेव हो गया',
			'discover.story.downloadFailed' => 'सेव नहीं हो सका',
			'discover.highlight.title' => 'हाइलाइट',
			'discover.highlight.view' => 'देखें',
			'discover.highlight.aiComments' => 'AI कमेंट',
			'discover.highlight.remove' => 'हाइलाइट हटाएँ',
			'discover.highlight.sharedSuccess' => 'आपकी पोस्ट शेयर हो गई',
			'discover.highlight.boost' => 'बूस्ट करें',
			'discover.stats.title' => 'आँकड़े',
			'discover.stats.subtitle' => 'आपकी पोस्ट से जुड़े आँकड़े\nनीचे दिए गए हैं।',
			'discover.stats.viewers' => 'व्यूअर',
			'discover.stats.comments' => 'कमेंट',
			'discover.stats.likes' => 'लाइक',
			'discover.stats.boostCta' => '1 दिन बूस्ट करें - 100 टोकन',
			'discover.stats.boosted' => 'बूस्ट हो गया! आपकी पोस्ट 24 घंटे तक सबसे ऊपर रहेगी।',
			'discover.hostedBy' => ({required Object name}) => 'होस्ट: ${name}',
			'common.loading' => 'लोड हो रहा है…',
			'common.retry' => 'फिर कोशिश करें',
			'common.cancel' => 'रद्द करें',
			'common.save' => 'सेव करें',
			'common.continueAction' => 'जारी रखें',
			'common.language' => 'भाषा',
			'common.or' => 'या',
			'languages.tr' => 'Türkçe',
			'languages.en' => 'English',
			'auth.createAccountTitle' => 'अपना अकाउंट बनाएँ',
			'auth.createAccountSubtitle' => 'Veylo से जुड़ें और कनेक्ट करना शुरू करें।',
			'auth.welcomeBackTitle' => 'फिर से स्वागत है',
			'auth.welcomeBackSubtitle' => 'Veylo पर जारी रखने के लिए लॉग इन करें।',
			'auth.username' => 'यूज़रनेम',
			'auth.usernameHint' => 'यूज़रनेम चुनें',
			'auth.email' => 'ईमेल',
			'auth.emailHint' => 'अपना ईमेल डालें',
			'auth.emailOrUsername' => 'ईमेल या यूज़रनेम',
			'auth.emailOrUsernameHint' => 'ईमेल या यूज़रनेम डालें',
			'auth.password' => 'पासवर्ड',
			'auth.passwordCreateHint' => 'पासवर्ड बनाएँ',
			'auth.passwordEnterHint' => 'अपना पासवर्ड डालें',
			'auth.signUp' => 'साइन अप',
			'auth.logIn' => 'लॉग इन',
			'auth.forgotPassword' => 'पासवर्ड भूल गए?',
			'auth.continueWithApple' => 'Apple से जारी रखें',
			'auth.continueWithGoogle' => 'Google से जारी रखें',
			'auth.legalPrefix' => 'जारी रखकर, आप हमारी ',
			'auth.termsOfService' => 'सेवा की शर्तों',
			'auth.legalMiddle' => ' से सहमत होते हैं और हमारी ',
			'auth.privacyPolicy' => 'प्राइवेसी पॉलिसी',
			'auth.legalSuffix' => ' को स्वीकार करते हैं।',
			'auth.passwordResetSent' => 'हमने आपके ईमेल पर पासवर्ड रीसेट लिंक भेजा है।',
			'onboarding.skip' => 'छोड़ें',
			'onboarding.page1Title' => 'जैसे हैं वैसे रहें। गुमनाम रहें।',
			'onboarding.page1Subtitle' => 'बिना अपनी पहचान बताए नए लोगों से\nमिलें और बातचीत शुरू करें।',
			'onboarding.page2Title' => 'लिखें। बात करें। Vibe महसूस करें।',
			'onboarding.page2Subtitle' => 'गुमनाम शुरुआत करें, फिर तैयार होने पर मैसेज, कॉल या आमने-सामने बात करें।',
			'onboarding.page3Title' => 'अपने लोग ढूँढें। बातचीत में\nशामिल हों।',
			'onboarding.page3Subtitle' => 'रूम में जाएँ, नए लोगों से मिलें और\nसाथ मिलकर पल शेयर करें।',
			'onboarding.getStarted' => 'शुरू करें',
			'onboarding.alreadyHaveAccount' => 'पहले से Veylo अकाउंट है? ',
			'onboarding.logInAction' => 'लॉग इन',
			'createProfile.navTitle' => 'प्रोफ़ाइल बनाएँ',
			'createProfile.stepUsername' => '1/5 यूज़रनेम',
			'createProfile.title' => 'अपनी प्रोफ़ाइल बनाएँ',
			'createProfile.subtitle' => 'आपका असली नाम सिर्फ़ वेरिफ़िकेशन के लिए है — यह सबको नहीं दिखेगा।',
			'createProfile.subtitleLine1' => 'आपका असली नाम सिर्फ़ वेरिफ़िकेशन के लिए है —',
			'createProfile.subtitleLine2' => 'यह सबको नहीं दिखेगा।',
			'createProfile.fullName' => 'पूरा नाम',
			'createProfile.fullNameHint' => 'Sam Lee',
			'createProfile.username' => 'यूज़रनेम',
			'createProfile.usernameHint' => 'samlee123',
			'createProfile.usernameTaken' => 'यह यूज़रनेम पहले से मौजूद है!',
			'createProfile.usernameAvailable' => 'यूज़रनेम उपलब्ध है',
			'createProfile.mightWantToTry' => 'ये भी आज़मा सकते हैं...',
			'createProfile.stepPhoto' => '2/5 प्रोफ़ाइल फ़ोटो',
			'createProfile.photoTitle' => 'प्रोफ़ाइल फ़ोटो अपलोड करें',
			'createProfile.photoSubtitle' => 'दूसरे यूज़र आपकी प्रोफ़ाइल फ़ोटो देखकर पक्का कर सकते हैं कि यह आप ही हैं।',
			'createProfile.photoSubtitleLine1' => 'दूसरे यूज़र आपकी प्रोफ़ाइल फ़ोटो देखकर पक्का',
			'createProfile.photoSubtitleLine2' => 'कर सकते हैं कि यह आप ही हैं।',
			'createProfile.choosePhoto' => 'फ़ोटो चुनें',
			'createProfile.continueWithoutPhoto' => 'बिना प्रोफ़ाइल फ़ोटो के जारी रखें',
			'createProfile.saveAndContinue' => 'सेव करें और जारी रखें',
			'createProfile.choosePhotoSheetTitle' => 'फ़ोटो चुनें',
			'createProfile.takePhoto' => 'फ़ोटो लें',
			'createProfile.chooseFromGallery' => 'गैलरी से चुनें',
			'createProfile.stepGender' => '3/5 जेंडर',
			'createProfile.genderTitle' => 'अपना जेंडर चुनें',
			'createProfile.genderSubtitle' => 'अगर आप यह जानकारी देते हैं, तो हम इसका इस्तेमाल आपके लिए कंटेंट पर्सनलाइज़ करने में कर सकते हैं',
			'createProfile.genderSubtitleLine1' => 'अगर आप यह जानकारी देते हैं, तो हम इसका इस्तेमाल',
			'createProfile.genderSubtitleLine2' => 'आपके लिए कंटेंट पर्सनलाइज़ करने में कर सकते हैं',
			'createProfile.genderFemale' => 'महिला',
			'createProfile.genderMale' => 'पुरुष',
			'createProfile.genderNonBinary' => 'नॉन-बाइनरी',
			'createProfile.genderPreferNotToSay' => 'बताना नहीं चाहते',
			'createProfile.stepInterests' => '4/5 रुचियाँ',
			'createProfile.interestsTitle' => 'आपको क्या पसंद है?',
			'createProfile.interestsSubtitle' => 'कम से कम 5 चुनें — इससे हम आपको ऐसे लोगों से मिला पाएँगे जो सच में आपको समझें।',
			'createProfile.interests.music' => 'म्यूज़िक',
			'createProfile.interests.movies' => 'फ़िल्में',
			'createProfile.interests.tvShows' => 'TV शो',
			'createProfile.interests.reading' => 'पढ़ना',
			'createProfile.interests.painting' => 'पेंटिंग',
			'createProfile.interests.photography' => 'फ़ोटोग्राफ़ी',
			'createProfile.interests.theatre' => 'थिएटर',
			'createProfile.interests.fitness' => 'फ़िटनेस',
			'createProfile.interests.swimming' => 'तैराकी',
			'createProfile.interests.football' => 'फ़ुटबॉल',
			'createProfile.interests.basketball' => 'बास्केटबॉल',
			'createProfile.interests.coffee' => 'कॉफ़ी',
			'createProfile.interests.travel' => 'घूमना-फिरना',
			'createProfile.interests.camping' => 'कैंपिंग',
			'createProfile.interests.meditation' => 'मेडिटेशन',
			'createProfile.interests.videoGames' => 'वीडियो गेम',
			'createProfile.interests.boardGames' => 'बोर्ड गेम',
			'createProfile.interests.standUp' => 'स्टैंड-अप कॉमेडी',
			'createProfile.interests.tech' => 'टेक',
			'createProfile.interests.coding' => 'कोडिंग',
			'createProfile.interests.ai' => 'AI',
			'createProfile.interests.podcast' => 'पॉडकास्ट',
			_ => null,
		} ?? switch (path) {
			'createProfile.stepChatGoal' => '5/5 चैट का लक्ष्य',
			'createProfile.chatGoalTitle' => 'आज आप क्या ढूँढ रहे हैं?',
			'createProfile.chatGoalSubtitle' => 'इससे हम आपके अभी के मूड के हिसाब से सही मैच ढूँढ पाएँगे।',
			'createProfile.chatGoalQuickMatch' => 'क्विक मैच — सीधे बातचीत\nशुरू करें',
			'createProfile.chatGoalFlirtyChat' => 'फ़्लर्टी चैट — हल्की-फुल्की, मज़ेदार\nबातें',
			'createProfile.chatGoalMoodMatch' => 'मूड मैच — आपके मूड के हिसाब से\nमैच',
			'createProfile.chatGoalLateNight' => 'लेट नाइट टॉक — जब दुनिया सो रही हो\nतब गहरी बातें',
			'createProfile.chatGoalMeetSomeoneNew' => 'किसी नए से मिलें — कोई खास लक्ष्य नहीं, बस\nएक्सप्लोर करें',
			'createProfile.getStarted' => 'शुरू करें',
			'createProfile.preparingTitleLine1' => 'हम आपके लिए',
			'createProfile.preparingTitleLine2' => 'सही प्रोफ़ाइल',
			'createProfile.preparingTitleLine3' => 'तैयार कर रहे हैं।',
			'createProfile.preparingSubtitleLine1' => 'आपके जवाबों के आधार पर हम',
			'createProfile.preparingSubtitleLine2' => 'बेस्ट मैच चुन रहे हैं—थोड़ा इंतज़ार करें।',
			'createProfile.preparingPercent' => ({required Object percent}) => '${percent}%',
			'createProfile.usernameInvalid' => '3–30 अक्षर, नंबर, डॉट या अंडरस्कोर इस्तेमाल करें।',
			'errors.network' => 'Veylo से कनेक्ट नहीं हो सका। अपना कनेक्शन चेक करें और फिर कोशिश करें।',
			'errors.generic' => 'कुछ गलत हो गया। कृपया फिर कोशिश करें।',
			'errors.signInFailed' => 'साइन इन नहीं हो सका। कृपया फिर कोशिश करें।',
			'errors.sessionExpired' => 'आपका सेशन खत्म हो गया है। कृपया फिर से साइन इन करें।',
			'errors.accountSuspended' => 'यह अकाउंट सस्पेंड कर दिया गया है।',
			'errors.unsupportedImage' => 'कृपया JPEG, PNG या WebP फ़ोटो चुनें।',
			'errors.fileTooLarge' => 'यह फ़ाइल बहुत बड़ी है।',
			'errors.enterEmailForReset' => 'पासवर्ड रीसेट करने के लिए ऊपर अपना ईमेल डालें।',
			'errors.wrongCredentials' => 'ईमेल/यूज़रनेम या पासवर्ड गलत है।',
			'errors.emailInUse' => 'यह ईमेल पहले से रजिस्टर्ड है। लॉग इन करके देखें।',
			'errors.weakPassword' => 'पासवर्ड कम से कम 6 अक्षरों का होना चाहिए।',
			'errors.invalidEmail' => 'कृपया सही ईमेल एड्रेस डालें।',
			'errors.tooManyAttempts' => 'बहुत ज़्यादा कोशिशें हो गईं। थोड़ा रुककर फिर कोशिश करें।',
			'errors.fillAllFields' => 'कृपया सभी फ़ील्ड भरें।',
			'errors.insufficientTokens' => 'टोकन कम हैं।',
			'errors.requestNotAccepted' => 'जवाब देने के लिए रिक्वेस्ट स्वीकार करें।',
			'errors.requestPendingLimit' => 'रिक्वेस्ट स्वीकार होने के बाद आप और मैसेज भेज सकते हैं।',
			'errors.blocked' => 'आप इस व्यक्ति को मैसेज नहीं कर सकते।',
			'errors.peerUnavailable' => 'यह अकाउंट अब उपलब्ध नहीं है।',
			'errors.vibeDailyLimit' => 'आज आपने बहुत सारे Vibes शेयर किए हैं। बाद में फिर कोशिश करें।',
			'errors.groupFull' => 'यह ग्रुप भर चुका है।',
			'errors.groupCreateLimit' => 'आज आपने बहुत सारे ग्रुप बना लिए हैं। बाद में फिर कोशिश करें।',
			'errors.notFound' => 'यह अब उपलब्ध नहीं है।',
			'errors.recentLogin' => 'आपकी सुरक्षा के लिए, लॉग आउट करके फिर से लॉग इन करें, फिर दोबारा कोशिश करें।',
			'errors.socialAccount' => 'आपका ईमेल और पासवर्ड आपके Google या Apple अकाउंट से मैनेज होता है।',
			'errors.alreadyInCall' => 'आप पहले से एक कॉल पर हैं।',
			'errors.roomPrivate' => 'यह रूम प्राइवेट है। जॉइन करने के लिए होस्ट से पूछें।',
			'errors.roomFull' => 'यह रूम भर चुका है।',
			'faq.q1' => 'यह ऐप कैसे काम करता है?',
			'faq.q2' => 'गुमनाम चैट क्या है?',
			'faq.q3' => 'कनेक्शन प्रोग्रेस क्या है?',
			'faq.q4' => 'मैं अपनी प्रोफ़ाइल कैसे दिखाऊँ?',
			'faq.q5' => '60 सेकंड स्ट्रेंजर क्या है?',
			'faq.q6' => 'Vibes क्या हैं?',
			'faq.q7' => 'मैं अपनी प्रोफ़ाइल कैसे एडिट करूँ?',
			'faq.q8' => 'मैं नोटिफ़िकेशन कैसे मैनेज करूँ?',
			'faq.q9' => 'मैं खरीदारी कैसे रीस्टोर करूँ?',
			'faq.q10' => 'क्या मैं सारी चैट डिलीट कर सकता/सकती हूँ?',
			'faq.q11' => 'क्या मेरा डेटा सुरक्षित है?',
			'faq.q12' => 'मैं किसी को ब्लॉक या रिपोर्ट कैसे करूँ?',
			'faq.q13' => 'मैं ऐप कैसे शेयर करूँ?',
			'faq.q14' => 'मैं अपना अकाउंट कैसे डिलीट करूँ?',
			'faq.a1' => 'Veylo पर आप गुमनाम रूप से नए लोगों से मिल सकते हैं, चैट कर सकते हैं और कनेक्शन बढ़ने के साथ धीरे-धीरे अपनी प्रोफ़ाइल दिखा सकते हैं। जब दोनों तैयार हों, तब मैसेज, वॉइस या आमने-सामने बात पर जाएँ।',
			'faq.a2' => 'गुमनाम चैट में आपकी पहचान और फ़ोटो छिपी रहती है। कनेक्शन बढ़ने पर नाम का पहला अक्षर और धुंधली फ़ोटो जैसी जानकारी अनलॉक होती है। 100% पर पूरी प्रोफ़ाइल दिखाने के लिए दोनों की सहमति ज़रूरी है।',
			'faq.a3' => 'जैसे-जैसे आप चैट करते हैं, आपका कनेक्शन प्रतिशत बढ़ता है। कुछ पड़ावों पर नाम का पहला अक्षर, धुंधली फ़ोटो और पूरी प्रोफ़ाइल अनलॉक होती है। डिटेल देखने के लिए कनेक्शन बटन पर टैप करें।',
			'faq.a4' => 'कनेक्शन 100% होने पर "मेरी प्रोफ़ाइल दिखाएँ" पर टैप करें। अगर दूसरा व्यक्ति भी स्वीकार करता है, तो दोनों की पूरी प्रोफ़ाइल दिख जाएगी।',
			'faq.a5' => 'कॉल टैब से आपको एक छोटा रैंडम मैच मिलता है। समय खत्म होने पर आप बात जारी रख सकते हैं या कॉल खत्म कर सकते हैं।',
			'faq.a6' => 'Vibes से आप आस-पास के लोगों को मैप/लिस्ट व्यू में खोज सकते हैं और जिसमें दिलचस्पी हो उससे चैट शुरू कर सकते हैं।',
			'faq.a7' => 'प्रोफ़ाइल टैब खोलें और "प्रोफ़ाइल एडिट करें" में जाकर अपना नाम, फ़ोटो, बायो और रुचियाँ अपडेट करें। सेव करने के बाद बदलाव दिखेंगे।',
			'faq.a8' => 'मैसेज, मैच और दूसरे अलर्ट चालू या बंद करने के लिए सेटिंग्स में नोटिफ़िकेशन खोलें।',
			'faq.a9' => 'सेटिंग्स → अकाउंट मैनेजमेंट → खरीदारी रीस्टोर करें पर जाएँ। उसी स्टोर अकाउंट की योग्य खरीदारी रीस्टोर हो जाएगी।',
			'faq.a10' => 'हाँ। सेटिंग्स → चैट डिलीट करें इस्तेमाल करें और कन्फ़र्म करें। सारी चैट हट जाएँगी। इसे वापस नहीं किया जा सकता।',
			'faq.a11' => 'आपके अकाउंट की जानकारी और मैसेज सुरक्षित सिस्टम पर रखे जाते हैं। आप कभी भी अकाउंट मैनेजमेंट से अकाउंट और डेटा डिलीट करने की रिक्वेस्ट भी कर सकते हैं।',
			'faq.a12' => 'ब्लॉक या रिपोर्ट करने के लिए प्रोफ़ाइल या चैट स्क्रीन पर मेन्यू इस्तेमाल करें। रिपोर्ट हमारी टीम देखती है।',
			'faq.a13' => 'लिंक कॉपी करके दोस्तों को भेजने के लिए सेटिंग्स में "ऐप शेयर करें" इस्तेमाल करें।',
			'faq.a14' => 'सेटिंग्स → अकाउंट मैनेजमेंट → अकाउंट और डेटा डिलीट करें पर जाएँ। वजह बताने के बाद, डिलीट रिक्वेस्ट भेजने के लिए कन्फ़र्म करें।',
			'legal.termsTitle' => 'सेवा की शर्तें',
			'legal.privacyTitle' => 'प्राइवेसी पॉलिसी',
			'legal.termsBody' => 'अंतिम अपडेट: 16 मार्च 2026\n\nVeylo में आपका स्वागत है। अकाउंट बनाकर या ऐप का इस्तेमाल करके, आप सेवा की इन शर्तों से सहमत होते हैं।\n\n1. Veylo क्या है\nVeylo एक सोशल ऐप है जहाँ आप लोगों से मिल सकते हैं, गुमनाम चैट कर सकते हैं, समय के साथ कनेक्शन बना सकते हैं, और दोनों की सहमति होने पर चाहें तो वॉइस या आमने-सामने की कॉल पर जा सकते हैं।\n\n2. आपका अकाउंट\nआपको सही जानकारी देनी होगी और अपना लॉगिन सुरक्षित रखना होगा। आपके अकाउंट से होने वाली गतिविधि की ज़िम्मेदारी आपकी है। अपने देश के कानून के अनुसार Veylo इस्तेमाल करने के लिए आपकी उम्र पर्याप्त होनी चाहिए।\n\n3. सम्मानजनक इस्तेमाल\nपरेशान न करें, धमकी न दें, धोखाधड़ी न करें, किसी और का रूप न धरें, गैरकानूनी कंटेंट शेयर न करें, या सुरक्षा फ़ीचर्स को बायपास करने की कोशिश न करें। इन नियमों को तोड़ने वाले कंटेंट को हम हटा सकते हैं, फ़ीचर्स सीमित कर सकते हैं या अकाउंट सस्पेंड कर सकते हैं।\n\n4. गुमनाम चैट और प्रोफ़ाइल दिखाना\nगुमनाम चैट में कनेक्शन के पड़ाव पूरे होने तक आपका नाम और फ़ोटो छिपे रह सकते हैं। पूरी प्रोफ़ाइल दिखाने के लिए दोनों की सहमति ज़रूरी है। दूसरों पर अपनी पहचान बताने का दबाव न डालें।\n\n5. खरीदारी\nकुछ फ़ीचर्स पेड हो सकते हैं। खरीदारी Apple App Store या Google Play द्वारा प्रोसेस की जाती है। "खरीदारी रीस्टोर करें" उसी स्टोर अकाउंट की योग्य खरीदारी वापस लाता है। रिफ़ंड स्टोर की पॉलिसी के अनुसार होते हैं।\n\n6. आपके द्वारा शेयर किया गया कंटेंट\nआपके कंटेंट के अधिकार आपके पास रहते हैं, लेकिन सेवा चलाने के लिए ज़रूरत के अनुसार आप Veylo को इसे ऐप में होस्ट करने और दिखाने का लाइसेंस देते हैं। ऐसा कंटेंट पोस्ट न करें जिसे शेयर करने का आपको अधिकार नहीं है।\n\n7. इस्तेमाल बंद करना\nआप कभी भी Veylo का इस्तेमाल बंद कर सकते हैं और सेटिंग्स से अकाउंट डिलीट करने की रिक्वेस्ट कर सकते हैं। ज़रूरत पड़ने पर हम उचित सूचना देकर सेवा बंद या उसमें बदलाव भी कर सकते हैं।\n\n8. संपर्क\nइन शर्तों के बारे में सवाल: support@veylo.app',
			'legal.privacyBody' => 'अंतिम अपडेट: 16 मार्च 2026\n\nयह प्राइवेसी पॉलिसी बताती है कि Veylo आपकी जानकारी कैसे इकट्ठा करता है, इस्तेमाल करता है और सुरक्षित रखता है।\n\n1. हम कौन-सी जानकारी इकट्ठा करते हैं\n• अकाउंट डेटा: ईमेल, डिस्प्ले नाम, प्रोफ़ाइल फ़ोटो, बायो, पसंद\n• इस्तेमाल का डेटा: चैट, कनेक्शन प्रोग्रेस, आपके द्वारा इस्तेमाल किए गए कॉल फ़ीचर्स, डिवाइस/ऐप की बुनियादी जानकारी\n• खरीदारी: पेड फ़ीचर्स अनलॉक और रीस्टोर करने के लिए ज़रूरी स्टोर रसीद डेटा\n\n2. हम इसका इस्तेमाल कैसे करते हैं\nहम आपके डेटा का इस्तेमाल Veylo चलाने, मैचिंग और चैट अनुभव को पर्सनलाइज़ करने, कम्युनिटी को सुरक्षित रखने, खरीदारी प्रोसेस करने और प्रोडक्ट को बेहतर बनाने के लिए करते हैं। हम आपका पर्सनल डेटा नहीं बेचते।\n\n3. गुमनाम मोड\nगुमनाम चैट में, अनलॉक नियम और दोनों की सहमति ज़्यादा दिखाने की अनुमति देने तक, हम सीमित रखते हैं कि दूसरे क्या देखें (जैसे छिपा हुआ नाम या धुंधली फ़ोटो)। फ़ीचर को सुरक्षित रूप से चलाने के लिए हमें बैकग्राउंड में फिर भी अकाउंट आइडेंटिफ़ायर की ज़रूरत होती है।\n\n4. शेयर करना\nहम ऐसे सर्विस प्रोवाइडर्स के साथ डेटा शेयर कर सकते हैं जो होस्टिंग, एनालिसिस या पेमेंट प्रोसेस करने में हमारी मदद करते हैं—सिर्फ़ ज़रूरत के अनुसार। कानून द्वारा ज़रूरी होने पर या यूज़र्स को नुकसान से बचाने के लिए भी हम जानकारी दे सकते हैं।\n\n5. डेटा रखना\nजब तक आपका अकाउंट एक्टिव है और कानूनी, सुरक्षा और बिलिंग कारणों से जितना ज़रूरी हो, हम डेटा रखते हैं। डिलीट करने की रिक्वेस्ट पूरी होने के बाद, जहाँ रखना ज़रूरी हो उसके अलावा, हम पर्सनल डेटा हटा देते हैं या उसे गुमनाम कर देते हैं।\n\n6. आपके विकल्प\nआप प्रोफ़ाइल की जानकारी एडिट कर सकते हैं, नोटिफ़िकेशन मैनेज कर सकते हैं, अकाउंट डिलीट करने की रिक्वेस्ट कर सकते हैं और अपने डेटा के बारे में हमसे संपर्क कर सकते हैं। स्टोर की खरीदारी Apple या Google के ज़रिए भी मैनेज होती है।\n\n7. सुरक्षा\nआपकी जानकारी की सुरक्षा के लिए हम उचित तकनीकी और संगठनात्मक उपाय अपनाते हैं। कोई भी सिस्टम पूरी तरह सुरक्षित नहीं है; कृपया मज़बूत पासवर्ड इस्तेमाल करें और अपना डिवाइस अपडेट रखें।\n\n8. संपर्क\nप्राइवेसी से जुड़े सवाल: privacy@veylo.app',
			'logout.title' => 'लॉग आउट',
			'logout.subtitle' => 'क्या आप सच में लॉग आउट करना चाहते हैं?',
			'logout.cancel' => 'रद्द करें',
			'logout.confirm' => 'लॉग आउट',
			'deleteAccount.title' => 'अकाउंट डिलीट करने की रिक्वेस्ट भेजें',
			'deleteAccount.subtitle' => 'क्या आप सच में अपना अकाउंट डिलीट करना चाहते हैं?',
			'deleteAccount.reasonTitle' => 'हम नहीं चाहते कि आप जाएँ, पर हम समझते हैं।',
			'deleteAccount.reasonBefore' => 'क्या आप बताएँगे कि आप क्यों जाना चाहते हैं, ताकि हम ',
			'deleteAccount.reasonAfter' => ' का अनुभव बेहतर बना सकें?',
			'deleteAccount.reasonLabel' => 'आप अपना अकाउंट क्यों डिलीट करना चाहते हैं',
			'deleteAccount.reasonHint' => 'अपना मैसेज लिखें',
			'deleteAccount.cancel' => 'रद्द करें',
			'deleteAccount.createRequest' => 'रिक्वेस्ट बनाएँ',
			'deleteAccount.confirmTitle' => 'क्या आप सच में डिलीट रिक्वेस्ट भेजना चाहते हैं?',
			'deleteAccount.confirmSubtitle' => 'कन्फ़र्म करने पर आपके अकाउंट को डिलीट करने की रिक्वेस्ट भेज दी जाएगी',
			'deleteAccount.delete' => 'डिलीट करें',
			'storyText.bold' => 'बोल्ड',
			'storyText.italic' => 'इटैलिक',
			'storyText.uppercase' => 'अपरकेस',
			'storyText.underline' => 'अंडरलाइन',
			'storyText.cancel' => 'रद्द करें',
			'storyText.galleryError' => 'गैलरी नहीं खुल सकी',
			_ => null,
		};
	}
}
