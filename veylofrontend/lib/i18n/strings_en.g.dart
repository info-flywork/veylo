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
class TranslationsEn extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEn({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key) ?? super[key];

	late final TranslationsEn _root = this; // ignore: unused_field

	@override 
	TranslationsEn $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsEn(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$app$en app = _Translations$app$en._(_root);
	@override late final _Translations$home$en home = _Translations$home$en._(_root);
	@override late final _Translations$chats$en chats = _Translations$chats$en._(_root);
	@override late final _Translations$profile$en profile = _Translations$profile$en._(_root);
	@override late final _Translations$nav$en nav = _Translations$nav$en._(_root);
	@override late final _Translations$call$en call = _Translations$call$en._(_root);
	@override late final _Translations$vibes$en vibes = _Translations$vibes$en._(_root);
	@override late final _Translations$discover$en discover = _Translations$discover$en._(_root);
	@override late final _Translations$common$en common = _Translations$common$en._(_root);
	@override late final _Translations$languages$en languages = _Translations$languages$en._(_root);
	@override late final _Translations$auth$en auth = _Translations$auth$en._(_root);
	@override late final _Translations$onboarding$en onboarding = _Translations$onboarding$en._(_root);
	@override late final _Translations$createProfile$en createProfile = _Translations$createProfile$en._(_root);
	@override late final _Translations$errors$en errors = _Translations$errors$en._(_root);
	@override late final _Translations$faq$en faq = _Translations$faq$en._(_root);
	@override late final _Translations$legal$en legal = _Translations$legal$en._(_root);
	@override late final _Translations$logout$en logout = _Translations$logout$en._(_root);
	@override late final _Translations$deleteAccount$en deleteAccount = _Translations$deleteAccount$en._(_root);
	@override late final _Translations$storyText$en storyText = _Translations$storyText$en._(_root);
}

// Path: app
class _Translations$app$en extends Translations$app$tr {
	_Translations$app$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get name => 'Veylo';
	@override String get tagline => 'Welcome';
}

// Path: home
class _Translations$home$en extends Translations$home$tr {
	_Translations$home$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Home';
	@override String get subtitle => 'App is being prepared';
	@override String get body => 'The multilingual UI is managed with slang.';
}

// Path: chats
class _Translations$chats$en extends Translations$chats$tr {
	_Translations$chats$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Chats';
	@override String get search => 'Search';
	@override String get messagesSection => 'Messages';
	@override String get request => 'Request';
	@override String get emptyRequestTitle => 'There are no recent message\nnotifications';
	@override String get emptyRequestSubtitle => 'Requests older than 30 days are not displayed.';
	@override String get noteAdd => 'Add Note';
	@override String get anonymous => 'Anonymous';
	@override String get online => 'online';
	@override String get offline => 'offline';
	@override String get connection => 'Connection';
	@override String connectionPercent({required Object n}) => '${n}%';
	@override String get connectionProgressTitle => 'Connection Progress';
	@override String get milestoneInitial => 'First name initial';
	@override String get milestoneInitialHint => 'Unlocked at 25%';
	@override String get milestoneInitialLocked => 'Unlocks at 25%';
	@override String get milestonePhoto => 'Blurred photo preview';
	@override String get milestonePhotoHint => 'Unlocks at 70%';
	@override String get milestoneFull => 'Full profile review';
	@override String get milestoneFullHint => 'Mutual consent at 100%';
	@override String get sampleAnonymousMessage => 'Hello, it was a pleasure meeting you. Could you tell me a little about yourself?';
	@override String get strangerSampleMessage => 'Hello Jhon, it was a pleasure meeting you. Could you tell me a little about yourself?';
	@override String get approve => 'Approve';
	@override String get blockUser => 'Block User';
	@override String get reject => 'Reject';
	@override String get messageHint => 'Hi! how are you?';
	@override String get revealTitle => 'You\'ve reached 100%';
	@override String get revealSubtitle => 'Reveal your full profiles to each other? Both sides must agree.';
	@override String revealWaiting({required Object name}) => 'Waiting for ${name} to accept';
	@override String get revealCta => 'Reveal my profile';
	@override String get revealNotYet => 'Not Yet';
	@override String get seen => 'Seen';
	@override String get typing => 'typing…';
	@override String get noteYou => 'You';
	@override String get noteSheetTitle => 'Share a note';
	@override String get noteSheetSubtitle => 'Your note stays for 24 hours';
	@override String get noteHint => 'What’s on your mind?';
	@override String get noteShare => 'Share';
	@override String get noteDelete => 'Delete note';
}

// Path: profile
class _Translations$profile$en extends Translations$profile$tr {
	_Translations$profile$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get eyebrow => 'Profile';
	@override String get title => 'Settings';
	@override String get editProfile => 'Edit Profile';
	@override String get statLike => 'Like';
	@override String get statFollow => 'Follow';
	@override String get statFollower => 'Follower';
	@override String get promoTitle => 'Get More Messages!';
	@override String get promoSubtitle => 'Stand out, appear at the top of the list';
	@override String get standOut => 'Stand Out';
	@override String get tabPosts => 'Posts';
	@override String get tabVideo => 'Video';
	@override String get tabSaved => 'Saved';
	@override String get save => 'Save';
	@override String get changePhoto => 'Change Photo';
	@override String get changeBorder => 'Change Border';
	@override String get interest => 'Interest';
	@override String get name => 'Name';
	@override String get changeName => 'Change Name';
	@override String get changePassword => 'Change Password';
	@override String get confirmPassword => 'Confirm Password';
	@override String get email => 'Email';
	@override String get accountManagement => 'Account Management';
	@override String get settingsAbout => 'About';
	@override String get settingsAccount => 'Account Settings';
	@override String get settingsSupport => 'Support';
	@override String get shareApp => 'Share the App';
	@override String get shareAppTitle => 'Share with Friends';
	@override String get shareAppSubtitle => 'Share Veylo with your friends and discover together!';
	@override String get shareAppLabel => 'App link';
	@override String get rateApp => 'Did you like us? Rate us';
	@override String get notifications => 'Notifications';
	@override String get password => 'Password';
	@override String get deleteConversation => 'Delete Conversation';
	@override String get faqHelp => 'F.A.Q & Help';
	@override String get restorePurchases => 'Restore Purchases';
	@override String get termsOfService => 'Terms Of Service';
	@override String get privacyPolicy => 'Privacy Policy';
	@override String get restorePurchasesDone => 'Purchases checked';
	@override String get conversationsDeleted => 'All conversations deleted';
	@override String get logOut => 'Log Out';
	@override String get deleteAccountAndData => 'Delete Account and Data';
	@override String get passwordPlaceholder => '********';
	@override String get height => 'Height';
	@override String get addHeight => 'Add Height';
	@override String heightCm({required Object value}) => '${value} cm';
	@override String get languages => 'Languages';
	@override String get relationshipGoals => 'Relationship Goals';
	@override String get lookingFor => 'Looking for';
	@override String get newFriends => '👋 New Friends';
	@override String get goalLongTermOpenToShort => '💕 Long-term, Open to Short';
	@override String get goalLongTermRelationship => '💘 Long-term Relationship';
	@override String get goalNewFriends => '👋 New friends';
	@override String get goalShortTermFun => '🥃 Short-term Fun';
	@override String get goalStillFiguringItOut => '🤔 Still Figuring It Out';
	@override String get basics => 'Basics';
	@override String get zodiac => 'Zodiac';
	@override String get zodiacValue => 'Scorpion';
	@override String get education => 'Education';
	@override String get educationValue => 'Bachelors';
	@override String get educationHighSchool => 'High School';
	@override String get educationAssociates => 'Associate\'s Degree';
	@override String get educationBachelors => 'Bachelor\'s Degree';
	@override String get educationMasters => 'Master\'s Degree';
	@override String get educationPhd => 'PhD / Doctorate';
	@override String get voiceRecord => 'Voice Record';
	@override String get addVoice => 'Add Voice';
	@override String get lifestyle => 'Lifestyle';
	@override String get pets => 'Pets';
	@override String get petsValue => 'I have a cat';
	@override String get petsDontWant => 'I don\'t want pets';
	@override String get petsAllergic => 'I\'m allergic to pets';
	@override String get petsHaveCat => 'I have a cat';
	@override String get petsHaveDog => 'I have a dog';
	@override String get petsHaveCatsAndDogs => 'I have cats and dogs';
	@override String get petsHaveOther => 'I have other pets';
	@override String get drinking => 'Drinking';
	@override String get drinkingValue => 'On special occasions';
	@override String get drinkingNever => 'Never';
	@override String get drinkingSpecialOccasions => 'On special occasions';
	@override String get drinkingSocially => 'Socially';
	@override String get drinkingFrequently => 'Frequently';
	@override String get drinkingSober => 'Sober';
	@override String get drinkingPreferNotToSay => 'Prefer not to say';
	@override String get smoking => 'Smoking';
	@override String get smokingValue => 'Non-smoker';
	@override String get smokingNonSmoker => 'Non-smoker';
	@override String get smokingSocialSmoker => 'Social smoker';
	@override String get smokingSmoker => 'Smoker';
	@override String get smokingTryingToQuit => 'Trying to quit';
	@override String get smokingWhenDrinking => 'Smoker when drinking';
	@override String get smokingPreferNotToSay => 'Prefer not to say';
	@override String get gender => 'Gender';
	@override String get genderFemale => 'Female';
	@override String get genderMale => 'Male';
	@override String get genderPreferNotToSay => 'I don\'t want to mention it';
	@override String get visible => 'Visible';
	@override String get profileVisibility => 'Profile Visibility';
	@override String get language => 'Language';
	@override String get borderTitle => 'Profile Border';
	@override String get borderSubtitle => 'Add a border to your profile to make\nyourself stand out.';
	@override String get borderBuySection => 'Buy a border';
	@override String get borderBuyCta => 'Buy Border';
	@override String borderToken({required Object count}) => '${count} Token';
	@override String get borderAmethystWings => 'Amethyst Wings';
	@override String get borderGoldenPhoenix => 'Golden Phoenix';
	@override String get borderFrostCrown => 'Frost Crown';
	@override String get borderEmeraldWhisper => 'Emerald Whisper';
	@override String get borderRoseQuartz => 'Rose Quartz';
	@override String get borderStarlitComet => 'Starlit Comet';
	@override String get borderCrimsonRoyal => 'Crimson Royal';
	@override String get borderSapphireHalo => 'Sapphire Halo';
	@override String get follow => 'Follow';
	@override String get following => 'Following';
	@override String get followPageTitle => 'Follow';
	@override String get followTabFollowing => 'Following';
	@override String get followTabFollowers => 'Followers';
	@override String get followSearch => 'Search';
	@override String get unfollow => 'Unfollow';
	@override String get followSortTitle => 'Sort';
	@override String get followSortRecent => 'People I followed most recently';
	@override String get followSortNotFollowingMe => 'People who don\'t follow me back';
	@override String get followSortNotFollowedByMe => 'People I don\'t follow back';
	@override String get followSortShowResult => 'Show Result';
	@override String get followSortEmpty => 'No users match this filter';
	@override String get shareTitle => 'Share with Friends';
	@override String get shareSubtitle => 'Everything is more fun when you connect\nwith your friends!';
	@override String get shareProfileLabel => 'Share the profile';
	@override String get shareLinkCopied => 'Link copied';
	@override String get restrict => 'Restrict';
	@override String get block => 'Block';
	@override String get report => 'Report';
	@override String blockTitle({required Object username}) => 'Block ${username} ?';
	@override String get blockBody => 'This will also block any other accounts they may have or create in the future. You can unlock them anytime.';
	@override String get blockAndReport => 'Block and report';
	@override String restrictTitle({required Object username}) => 'Restrict ${username} ?';
	@override String get restrictBody => 'They won\'t be able to see when you\'re online or that you\'ve read their messages. You can change this anytime.';
	@override String get restrictAndReport => 'Restrict and report';
	@override String get reportTitle => 'We\'d like to know why';
	@override String get reportSubtitle => 'To help us give you a better experience, could you tell us why you want to report this user?';
	@override String get reportMessageLabel => 'Report Message';
	@override String get reportMessageHint => 'Type your message';
	@override String get reportCancel => 'Cancel';
	@override String get sendReport => 'Send Report';
	@override String get notSet => 'Not set';
	@override String get reportSent => 'Thanks, we received your report.';
	@override String emailVerificationSent({required Object email}) => 'We sent a confirmation link to ${email}. Your email changes after you confirm.';
	@override String get passwordChanged => 'Your password has been updated.';
	@override String get passwordMismatch => 'Passwords don’t match.';
}

// Path: nav
class _Translations$nav$en extends Translations$nav$tr {
	_Translations$nav$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get discover => 'Discover';
	@override String get chat => 'Chat';
	@override String get call => 'Call';
	@override String get vibes => 'Vibes';
	@override String get profile => 'Profile';
}

// Path: call
class _Translations$call$en extends Translations$call$tr {
	_Translations$call$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => '60 Second Stranger';
	@override String get subtitle => 'Talk to a random stranger for 60 seconds — completely anonymous. No profile, no photo, no name. Just a voice and a moment.';
	@override String get findingTitle => 'Finding a stranger...';
	@override String get findingSubtitle => 'You\'ll talk anonymously for 60 seconds. No profile, no names.';
	@override String get callStranger => 'Call Stranger - 10 Token';
	@override String get cancel => 'Cancel';
	@override String get female => 'Female';
	@override String get male => 'Male';
	@override String get nonBinary => 'Non-binary';
	@override String get preferNotToSay => 'Prefer not to say';
	@override String get anonymousBadge => '🎙️ Anonymous voice call';
	@override String get stranger => 'Stranger';
	@override String secondsLeft({required Object n}) => '${n}sn';
	@override String get timesUpTitle => 'Time\'s up!';
	@override String get timesUpSubtitle => 'Want to keep talking? If you both say yes, chat unlocks.';
	@override String get keepTalking => 'Keep Talking';
	@override String get endCall => 'End Call';
	@override String get waitingOther => 'Waiting for the other person...';
	@override String get callStrangerFree => 'Call Stranger';
	@override String get peerLeft => 'The other person ended the call.';
	@override String get noKeep => 'Chat didn\'t unlock this time.';
	@override String get videoWaiting => 'Waiting for them to accept the video call...';
	@override String get videoDeclined => 'They declined the video call.';
	@override String get micDenied => 'Microphone access is needed for calls. You can enable it in Settings.';
	@override String get videoCost => 'Video call: 20 tokens / 15 min';
	@override String get calling => 'Calling';
	@override String get accept => 'Accept';
	@override String get decline => 'Decline';
	@override String get switchToVideo => 'Would you like to switch to a video call?';
}

// Path: vibes
class _Translations$vibes$en extends Translations$vibes$tr {
	_Translations$vibes$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get search => 'Search';
	@override String get sendMessage => 'Send Message';
	@override String get wantsToTalk => 'Wants to talk about this right now';
	@override String get shareTitle => 'Share Vibe';
	@override String get replyTitle => 'Reply to Vibe';
	@override String get shareHint => 'Write something';
	@override String get shareAnonymous => 'Share anonymously';
	@override String get empty => 'No vibes in the last 24 hours. Share the first one!';
	@override String get deleteTitle => 'Delete this vibe?';
	@override String get delete => 'Delete';
	@override String get cancel => 'Cancel';
}

// Path: discover
class _Translations$discover$en extends Translations$discover$tr {
	_Translations$discover$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Discover';
	@override String get tabRooms => 'Rooms';
	@override String get tabDiscover => 'Discover';
	@override String get tabAiMatch => 'AI Match';
	@override late final _Translations$discover$aiMatch$en aiMatch = _Translations$discover$aiMatch$en._(_root);
	@override String get searchHint => 'Search';
	@override String get allRooms => 'All Rooms';
	@override String get allGroups => 'All Groups';
	@override String get seeAll => 'See All';
	@override String get live => 'Live';
	@override String get join => 'Join';
	@override String get request => 'Request';
	@override String get requested => 'Requested';
	@override String get private => 'Private';
	@override String moreCount({required Object count}) => '+${count} more';
	@override String activeCount({required Object count}) => '${count} active';
	@override String membersCount({required Object count}) => '${count} members';
	@override late final _Translations$discover$privateRoom$en privateRoom = _Translations$discover$privateRoom$en._(_root);
	@override late final _Translations$discover$roomToken$en roomToken = _Translations$discover$roomToken$en._(_root);
	@override late final _Translations$discover$privateRequest$en privateRequest = _Translations$discover$privateRequest$en._(_root);
	@override late final _Translations$discover$roomApproved$en roomApproved = _Translations$discover$roomApproved$en._(_root);
	@override late final _Translations$discover$createSpace$en createSpace = _Translations$discover$createSpace$en._(_root);
	@override late final _Translations$discover$liveRoom$en liveRoom = _Translations$discover$liveRoom$en._(_root);
	@override late final _Translations$discover$groupChat$en groupChat = _Translations$discover$groupChat$en._(_root);
	@override late final _Translations$discover$groupInfo$en groupInfo = _Translations$discover$groupInfo$en._(_root);
	@override late final _Translations$discover$filters$en filters = _Translations$discover$filters$en._(_root);
	@override late final _Translations$discover$post$en post = _Translations$discover$post$en._(_root);
	@override late final _Translations$discover$story$en story = _Translations$discover$story$en._(_root);
	@override late final _Translations$discover$highlight$en highlight = _Translations$discover$highlight$en._(_root);
	@override late final _Translations$discover$stats$en stats = _Translations$discover$stats$en._(_root);
	@override String hostedBy({required Object name}) => 'Hosted by ${name}';
}

// Path: common
class _Translations$common$en extends Translations$common$tr {
	_Translations$common$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get loading => 'Loading…';
	@override String get retry => 'Retry';
	@override String get cancel => 'Cancel';
	@override String get save => 'Save';
	@override String get continueAction => 'Continue';
	@override String get language => 'Language';
	@override String get or => 'OR';
}

// Path: languages
class _Translations$languages$en extends Translations$languages$tr {
	_Translations$languages$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get tr => 'Türkçe';
	@override String get en => 'English';
}

// Path: auth
class _Translations$auth$en extends Translations$auth$tr {
	_Translations$auth$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get createAccountTitle => 'Create your account';
	@override String get createAccountSubtitle => 'Join Veylo and start connecting.';
	@override String get welcomeBackTitle => 'Welcome back';
	@override String get welcomeBackSubtitle => 'Log in to continue to Veylo.';
	@override String get username => 'Username';
	@override String get usernameHint => 'Choose a username';
	@override String get email => 'Email';
	@override String get emailHint => 'Enter your email';
	@override String get emailOrUsername => 'Email or Username';
	@override String get emailOrUsernameHint => 'Choose a username';
	@override String get password => 'Password';
	@override String get passwordCreateHint => 'Create a password';
	@override String get passwordEnterHint => 'Enter your password';
	@override String get signUp => 'Sign Up';
	@override String get logIn => 'Log In';
	@override String get forgotPassword => 'Forgot Password?';
	@override String get continueWithApple => 'Continue with Apple';
	@override String get continueWithGoogle => 'Continue with Google';
	@override String get legalPrefix => 'By continuing, you agree to our ';
	@override String get termsOfService => 'Terms of Service';
	@override String get legalMiddle => ' and acknowledge our ';
	@override String get privacyPolicy => 'Privacy Policy';
	@override String get legalSuffix => '.';
	@override String get passwordResetSent => 'We sent a password reset link to your email.';
}

// Path: onboarding
class _Translations$onboarding$en extends Translations$onboarding$tr {
	_Translations$onboarding$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get skip => 'Skip';
	@override String get page1Title => 'Be yourself. Stay anonymous.';
	@override String get page1Subtitle => 'Meet new people and start conversations\nwithout revealing who you are.';
	@override String get page2Title => 'Text. Talk. Feel the vibe.';
	@override String get page2Subtitle => 'Start anonymously, then text, call, or go face to face when you\'re ready.';
	@override String get page3Title => 'Find your people. Join\nthe conversation.';
	@override String get page3Subtitle => 'Jump into rooms, meet new people, and\nshare the moment together.';
	@override String get getStarted => 'Get Started';
	@override String get alreadyHaveAccount => 'Already have a Veylo account? ';
	@override String get logInAction => 'Log In';
}

// Path: createProfile
class _Translations$createProfile$en extends Translations$createProfile$tr {
	_Translations$createProfile$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get navTitle => 'Create Profile';
	@override String get stepUsername => '1/5 Username';
	@override String get title => 'Create your profile';
	@override String get subtitle => 'Your real name is only used for verification — it won\'t appear publicly.';
	@override String get subtitleLine1 => 'Your real name is only used for verification — it';
	@override String get subtitleLine2 => 'won\'t appear publicly.';
	@override String get fullName => 'Full name';
	@override String get fullNameHint => 'Sam Lee';
	@override String get username => 'Username';
	@override String get usernameHint => 'samlee123';
	@override String get usernameTaken => 'This username already exists!';
	@override String get usernameAvailable => 'Username is available';
	@override String get mightWantToTry => 'Might want to try...';
	@override String get stepPhoto => '2/5 Profile Photo';
	@override String get photoTitle => 'Upload a profile photo';
	@override String get photoSubtitle => 'Other users can see your profile photo to make sure it\'s you.';
	@override String get photoSubtitleLine1 => 'Other users can see your profile photo to make';
	@override String get photoSubtitleLine2 => 'sure it\'s you.';
	@override String get choosePhoto => 'Choose a photo';
	@override String get continueWithoutPhoto => 'Continue without a profile photo';
	@override String get saveAndContinue => 'Save & Continue';
	@override String get choosePhotoSheetTitle => 'Choose a photo';
	@override String get takePhoto => 'Take a photo';
	@override String get chooseFromGallery => 'Choose from library';
	@override String get stepGender => '3/5 Gender';
	@override String get genderTitle => 'Choose your gender';
	@override String get genderSubtitle => 'If you choose to provide this information to us, we may use it to personalize content for you';
	@override String get genderSubtitleLine1 => 'If you choose to provide this information to us, we';
	@override String get genderSubtitleLine2 => 'may use it to personalize content for you';
	@override String get genderFemale => 'Female';
	@override String get genderMale => 'Male';
	@override String get genderNonBinary => 'Non-binary';
	@override String get genderPreferNotToSay => 'Prefer not to say';
	@override String get stepInterests => '4/5 Interests';
	@override String get interestsTitle => 'What are you into?';
	@override String get interestsSubtitle => 'Pick at least 5 — this helps us match you with people who actually get you.';
	@override late final _Translations$createProfile$interests$en interests = _Translations$createProfile$interests$en._(_root);
	@override String get stepChatGoal => '5/5 Chat goal';
	@override String get chatGoalTitle => 'What are you looking for today?';
	@override String get chatGoalSubtitle => 'This helps us find the right match for your mood right now.';
	@override String get chatGoalQuickMatch => 'Quick match — jump straight into a\nconversation';
	@override String get chatGoalFlirtyChat => 'Flirty chat — light, playful\nconversations';
	@override String get chatGoalMoodMatch => 'Mood match — match based on how you\'re\nfeeling';
	@override String get chatGoalLateNight => 'Late night talk — deep chats when the world\'s\nasleep';
	@override String get chatGoalMeetSomeoneNew => 'Meet someone new — no specific goal, just\nexplore';
	@override String get getStarted => 'Get Started';
	@override String get preparingTitleLine1 => 'We\'re preparing';
	@override String get preparingTitleLine2 => 'profiles that are right for';
	@override String get preparingTitleLine3 => 'you.';
	@override String get preparingSubtitleLine1 => 'Based on your answers, we\'re selecting';
	@override String get preparingSubtitleLine2 => 'the best matches—please wait a moment.';
	@override String preparingPercent({required Object percent}) => '%${percent}';
	@override String get usernameInvalid => 'Use 3–30 letters, numbers, dots or underscores.';
}

// Path: errors
class _Translations$errors$en extends Translations$errors$tr {
	_Translations$errors$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get network => 'Couldn’t reach Veylo. Check your connection and try again.';
	@override String get generic => 'Something went wrong. Please try again.';
	@override String get signInFailed => 'Sign in failed. Please try again.';
	@override String get sessionExpired => 'Your session has ended. Please sign in again.';
	@override String get accountSuspended => 'This account has been suspended.';
	@override String get unsupportedImage => 'Please choose a JPEG, PNG or WebP photo.';
	@override String get fileTooLarge => 'This file is too large.';
	@override String get enterEmailForReset => 'Enter your email above to reset your password.';
	@override String get wrongCredentials => 'Email/username or password is incorrect.';
	@override String get emailInUse => 'This email is already registered. Try logging in.';
	@override String get weakPassword => 'Password must be at least 6 characters.';
	@override String get invalidEmail => 'Please enter a valid email address.';
	@override String get tooManyAttempts => 'Too many attempts. Please wait a bit and try again.';
	@override String get fillAllFields => 'Please fill in all fields.';
	@override String get insufficientTokens => 'Not enough tokens.';
	@override String get requestNotAccepted => 'Accept the request to reply.';
	@override String get requestPendingLimit => 'You can send more messages after they accept your request.';
	@override String get blocked => 'You can’t message this person.';
	@override String get peerUnavailable => 'This account is no longer available.';
	@override String get vibeDailyLimit => 'You’ve shared a lot of vibes today. Try again later.';
	@override String get groupFull => 'This group is full.';
	@override String get groupCreateLimit => 'You’ve created too many groups today. Try again later.';
	@override String get notFound => 'This is no longer available.';
	@override String get recentLogin => 'For your security, log out and log in again, then try once more.';
	@override String get socialAccount => 'Your email and password are managed by your Google or Apple account.';
	@override String get alreadyInCall => 'You are already in a call.';
	@override String get roomPrivate => 'This room is private. Ask the host to join.';
	@override String get roomFull => 'This room is full.';
}

// Path: faq
class _Translations$faq$en extends Translations$faq$tr {
	_Translations$faq$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get q1 => 'How does this app work?';
	@override String get q2 => 'What is anonymous chat?';
	@override String get q3 => 'What is Connection Progress?';
	@override String get q4 => 'How do I reveal my profile?';
	@override String get q5 => 'What is 60 Second Stranger?';
	@override String get q6 => 'What are Vibes?';
	@override String get q7 => 'How do I edit my profile?';
	@override String get q8 => 'How do I manage notifications?';
	@override String get q9 => 'How do I restore purchases?';
	@override String get q10 => 'Can I delete all conversations?';
	@override String get q11 => 'Is my data secure?';
	@override String get q12 => 'How do I block or report someone?';
	@override String get q13 => 'How do I share the app?';
	@override String get q14 => 'How do I delete my account?';
	@override String get a1 => 'On Veylo you can meet new people anonymously, chat, and gradually reveal your profile as your connection grows. Switch to text, voice, or face-to-face whenever you both feel ready.';
	@override String get a2 => 'In anonymous chat your identity and photo stay hidden. As connection rises you unlock details like a name initial and a blurred photo. At 100%, both sides must agree to reveal full profiles.';
	@override String get a3 => 'As you chat, your connection percentage grows. At certain milestones you unlock a name initial, a blurred photo, and full profile. Tap the Connection pill to see details.';
	@override String get a4 => 'When connection reaches 100%, tap Reveal my profile. If the other person also accepts, both full profiles become visible.';
	@override String get a5 => 'From the Call tab you can get a short random match. When time is up you can keep talking or end the call.';
	@override String get a6 => 'Vibes lets you discover people nearby or around you on a map/list view and start a chat with someone you’re interested in.';
	@override String get a7 => 'Open the Profile tab and go to Edit Profile to update your name, photos, bio, and interests. Changes appear after you save.';
	@override String get a8 => 'Open Notifications in Settings to turn message, match, and other alerts on or off.';
	@override String get a9 => 'Go to Settings → Account Management → Restore Purchases. Eligible buys on the same store account will be restored.';
	@override String get a10 => 'Yes. Use Settings → Delete Conversation and confirm. All chats will be removed. This can’t be undone.';
	@override String get a11 => 'Your account details and messages are stored on protected systems. You can also request account and data deletion from Account Management anytime.';
	@override String get a12 => 'Use the menu on a profile or chat screen to block or report. Reports are reviewed by our team.';
	@override String get a13 => 'Use Share App in Settings to copy the link and send it to friends.';
	@override String get a14 => 'Go to Settings → Account Management → Delete Account and Data. After sharing a reason, confirm to submit your deletion request.';
}

// Path: legal
class _Translations$legal$en extends Translations$legal$tr {
	_Translations$legal$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get termsTitle => 'Terms of Service';
	@override String get privacyTitle => 'Privacy Policy';
	@override String get termsBody => 'Last updated: March 16, 2026\n\nWelcome to Veylo. By creating an account or using the app, you agree to these Terms of Service.\n\n1. What Veylo is\nVeylo is a social app where you can meet people, chat anonymously, build connection over time, and optionally move to voice or face-to-face calls when both sides agree.\n\n2. Your account\nYou must provide accurate information and keep your login secure. You are responsible for activity under your account. You must be old enough to use Veylo under the laws of your country.\n\n3. Respectful use\nDo not harass, threaten, scam, impersonate others, share illegal content, or try to bypass safety features. We may remove content, limit features, or suspend accounts that break these rules.\n\n4. Anonymous chat & profile reveal\nAnonymous chats may hide your name and photo until connection milestones are reached. Full profile reveal requires mutual consent. Do not pressure others to reveal identity.\n\n5. Purchases\nSome features may be paid. Purchases are handled by Apple App Store or Google Play. Restore Purchases recovers eligible buys on the same store account. Refunds follow the store’s policy.\n\n6. Content you share\nYou keep rights to your content, but grant Veylo a license to host and display it in the app as needed to operate the service. Do not post content you do not have rights to share.\n\n7. Ending use\nYou can stop using Veylo anytime and request account deletion from Settings. We may also end or change the service with reasonable notice when required.\n\n8. Contact\nQuestions about these terms: support@veylo.app';
	@override String get privacyBody => 'Last updated: March 16, 2026\n\nThis Privacy Policy explains how Veylo collects, uses, and protects your information.\n\n1. Information we collect\n• Account data: email, display name, profile photos, bio, preferences\n• Usage data: chats, connection progress, call features you use, device/app basics\n• Purchases: store receipt data needed to unlock and restore paid features\n\n2. How we use it\nWe use your data to run Veylo, personalize matching and chat experiences, keep the community safe, process purchases, and improve the product. We do not sell your personal data.\n\n3. Anonymous mode\nIn anonymous chats we limit what others see (for example masked name or blurred photo) until unlock rules and mutual consent allow more. Behind the scenes we still need account identifiers to operate the feature securely.\n\n4. Sharing\nWe may share data with service providers that help us host, analyze, or process payments—only as needed. We may also disclose information if required by law or to protect users from harm.\n\n5. Retention\nWe keep data while your account is active and as needed for legal, safety, and billing reasons. After a deletion request is completed, we remove or anonymize personal data except where retention is required.\n\n6. Your choices\nYou can edit profile info, manage notifications, request account deletion, and contact us about your data. Store purchases are also managed through Apple or Google.\n\n7. Security\nWe use reasonable technical and organizational measures to protect your information. No system is perfectly secure; please use a strong password and keep your device updated.\n\n8. Contact\nPrivacy questions: privacy@veylo.app';
}

// Path: logout
class _Translations$logout$en extends Translations$logout$tr {
	_Translations$logout$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Log out';
	@override String get subtitle => 'Are you sure you want to log out?';
	@override String get cancel => 'Cancel';
	@override String get confirm => 'Log out';
}

// Path: deleteAccount
class _Translations$deleteAccount$en extends Translations$deleteAccount$tr {
	_Translations$deleteAccount$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Submit an account deletion request';
	@override String get subtitle => 'Are you sure you want to delete your account?';
	@override String get reasonTitle => 'We don\'t want you to leave, but we understand.';
	@override String get reasonBefore => 'Would you tell us why you want to leave so we can improve the ';
	@override String get reasonAfter => ' experience?';
	@override String get reasonLabel => 'Why do you want to delete your account';
	@override String get reasonHint => 'Type your message';
	@override String get cancel => 'Cancel';
	@override String get createRequest => 'Create a Request';
	@override String get confirmTitle => 'Are you sure you want to submit a deletion request?';
	@override String get confirmSubtitle => 'If you confirm, your account deletion request will be submitted';
	@override String get delete => 'Delete';
}

// Path: storyText
class _Translations$storyText$en extends Translations$storyText$tr {
	_Translations$storyText$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get bold => 'Bold';
	@override String get italic => 'Italic';
	@override String get uppercase => 'Uppercase';
	@override String get underline => 'Underline';
	@override String get cancel => 'Cancel';
	@override String get galleryError => 'Could not open the gallery';
}

// Path: discover.aiMatch
class _Translations$discover$aiMatch$en extends Translations$discover$aiMatch$tr {
	_Translations$discover$aiMatch$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get feelingTitle => 'How are you feeling today';
	@override String get feelingSubtitle => 'AI finds the best match based on your pick';
	@override String get lookingTitle => 'What are you looking for?';
	@override String get moodSad => 'Sad';
	@override String get moodMeltie => 'Meh';
	@override String get moodBored => 'Bored';
	@override String get moodCrying => 'Down';
	@override String get moodSmile => 'Happy';
	@override String get lookingNewFriends => 'New friends';
	@override String get lookingVenting => 'Venting';
	@override String get lookingFlirty => 'Flirty chat';
	@override String get lookingFun => 'Fun';
	@override String get lookingCultures => 'New cultures';
	@override String get lookingLanguage => 'Language practice';
	@override String get statActiveUsers => 'Active users';
	@override String get statMatchRate => 'Match rate';
	@override String get statAvgTime => 'Avg time';
	@override String get statActiveValue => '843';
	@override String get statMatchValue => '87%';
	@override String get statAvgValue => '8s';
	@override String get startSmartMatch => 'Start Smart Match';
	@override String get findingTitle => 'Finding your match';
	@override String get findingSubtitle => 'Matching your mood and interests with the right person';
	@override String get findingStepMood => 'Mood analyzed';
	@override String get findingStepInterests => 'Interests matched';
	@override String get findingStepCompatibility => 'Calculating compatibility...';
	@override String get findingStepContent => 'Content is being created...';
	@override String findingOnline({required Object count}) => '${count} people online right now';
	@override String get yourMatchTitle => 'Your Match';
	@override String get yourMatchSubtitle => 'You have been matched based on your answers';
	@override String vibeMatch({required Object percent}) => '${percent}% Vibe match';
	@override String get startChatting => 'Start Chatting';
	@override String matchNameAge({required Object name, required Object age}) => '${name}, ${age}';
	@override String get matchBio => 'I\'ll make you feel things you didn\'t know you could feel.';
	@override String get swipePrevious => 'Previous';
	@override String get swipeNext => 'Next';
	@override String get swipeFinger => 'Swipe Finger';
	@override String get noMatch => 'No one matches right now. Try again in a little while.';
}

// Path: discover.privateRoom
class _Translations$discover$privateRoom$en extends Translations$discover$privateRoom$tr {
	_Translations$discover$privateRoom$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get subtitle => 'This is a private room. Unlock access with tokens.';
	@override String get roomAccess => 'Room access';
	@override String get yourBalance => 'Your balance';
	@override String tokensAmount({required Object count}) => '${count} tokens';
	@override String joinForTokens({required Object count}) => 'Join for ${count} tokens';
	@override String get cancel => 'Cancel';
}

// Path: discover.roomToken
class _Translations$discover$roomToken$en extends Translations$discover$roomToken$tr {
	_Translations$discover$roomToken$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get subtitle => 'Unlock access with tokens.';
	@override String get roomAccess => 'Room access';
	@override String get yourBalance => 'Your balance';
	@override String tokensAmount({required Object count}) => '${count} tokens';
	@override String joinForTokens({required Object count}) => 'Join for ${count} tokens';
	@override String get cancel => 'Cancel';
}

// Path: discover.privateRequest
class _Translations$discover$privateRequest$en extends Translations$discover$privateRequest$tr {
	_Translations$discover$privateRequest$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Request to join';
	@override String roomInfo({required Object name, required Object count}) => '${name} · ${count} members';
	@override String get messageHint => 'Say something (optional)...';
	@override String get sendRequest => 'Send Request';
	@override String get adminReview => 'The room admin will review your request';
}

// Path: discover.roomApproved
class _Translations$discover$roomApproved$en extends Translations$discover$roomApproved$tr {
	_Translations$discover$roomApproved$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'You\'re in!';
	@override String subtitle({required Object name}) => 'Your spot in ${name} is reserved';
	@override String get continueLabel => 'Continue';
}

// Path: discover.createSpace
class _Translations$discover$createSpace$en extends Translations$discover$createSpace$tr {
	_Translations$discover$createSpace$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Create Room or Group';
	@override String get subtitle => 'Reach more people by creating a group or a live room';
	@override String get room => 'Room';
	@override String get group => 'Group';
	@override String get hideAccount => 'Hide Your Account';
	@override String get create => 'Create';
	@override String get cancel => 'Cancel';
	@override String get createRoomTitle => 'Create Room';
	@override String get createGroupTitle => 'Create Group';
	@override String get nameSubtitle => 'Give the group you created a name';
	@override String get nameHint => 'Night Owl';
	@override String createRoomFor({required Object count}) => 'Create for ${count} tokens';
}

// Path: discover.liveRoom
class _Translations$discover$liveRoom$en extends Translations$discover$liveRoom$tr {
	_Translations$discover$liveRoom$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get adminSuffix => '(Admin)';
	@override String get messageHint => 'Message';
	@override String get quickReplyHey => 'Hey, everyone!';
	@override String get quickReplyTopic => 'What\'s the topic?';
	@override String get quickReplyNew => 'I\'m new here!';
	@override String get sampleChatName => 'Sona';
	@override String get sampleChatBody => 'What can we do? What do you have in mind?';
	@override String get roomEnded => 'The room has ended.';
	@override String wantsToJoin({required Object name}) => '${name} wants to join';
	@override String get approve => 'Approve';
}

// Path: discover.groupChat
class _Translations$discover$groupChat$en extends Translations$discover$groupChat$tr {
	_Translations$discover$groupChat$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String usersCount({required Object count}) => '${count} Users';
	@override String get sampleVictoria => 'I\'m really bored. Should we do something, guys?';
	@override String get sampleSona => 'What can we do? What do you have in mind?';
	@override String get sampleOwn => 'Let\'s meet at the pier';
}

// Path: discover.groupInfo
class _Translations$discover$groupInfo$en extends Translations$discover$groupInfo$tr {
	_Translations$discover$groupInfo$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get media => 'Media';
	@override String get gallery => 'Gallery';
	@override String get settings => 'Settings';
	@override String get notifications => 'Notifications';
	@override String get blocked => 'Blocked';
	@override String get private => 'Private';
	@override String membersCount({required Object count}) => '${count} members';
	@override String get addPeople => 'Add people';
	@override String get you => 'You';
	@override String get admin => 'Admin';
	@override String get leaveGroup => 'Leave the group';
	@override String get requests => 'Join requests';
	@override String get approve => 'Approve';
	@override String get reject => 'Reject';
	@override String get addPeopleEmpty => 'Follow people to add them to the group.';
	@override String get add => 'Add';
	@override String get makeAdmin => 'Make admin';
	@override String get removeAdmin => 'Remove admin';
	@override String get remove => 'Remove from group';
	@override String get leaveConfirm => 'Leave this group?';
	@override String get leave => 'Leave';
	@override String get cancel => 'Cancel';
}

// Path: discover.filters
class _Translations$discover$filters$en extends Translations$discover$filters$tr {
	_Translations$discover$filters$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Filters';
	@override String get ageRange => 'Age Range';
	@override String ageRangeValue({required Object min, required Object max}) => '${min}-${max}';
	@override String get distance => 'Distance';
	@override String distanceValue({required Object km}) => '${km} km';
	@override String get showMe => 'Show me';
	@override String get everyone => 'Everyone';
	@override String get women => 'Women';
	@override String get men => 'Men';
	@override String get interests => 'Interests';
	@override String get activeNow => 'Active now';
	@override String get activeNowSubtitle => 'Only show people online right now';
	@override String get showResult => 'Show Result';
}

// Path: discover.post
class _Translations$discover$post$en extends Translations$discover$post$tr {
	_Translations$discover$post$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get follow => 'Follow';
	@override String get following => 'Following';
	@override String get addComment => 'Add comment...';
	@override String get commentsTitle => 'Comments';
	@override String get sampleCaption => 'There\'s nothing quite like having a cup of coffee after a beautiful day. <3';
	@override String hoursAgo({required Object hours}) => '${hours}h';
	@override String minutesAgo({required Object minutes}) => '${minutes}m';
	@override String daysAgo({required Object days}) => '${days}d';
	@override String get deleteCommentTitle => 'Delete this comment?';
}

// Path: discover.story
class _Translations$discover$story$en extends Translations$discover$story$tr {
	_Translations$discover$story$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get draft => 'DRAFT';
	@override String get story => 'STORY';
	@override String get share => 'Share';
	@override String get textPlaceholder => 'Text something...';
	@override String get draftPrompt => 'Save as draft?';
	@override String get saveToDraft => 'Save to Draft';
	@override String get moveToTrash => 'Move to Trash';
	@override String get save => 'Save';
	@override String get musicTitle => 'Music';
	@override String get musicEmpty => 'No music found.';
	@override String get musicError => 'Could not load music.';
	@override String get downloaded => 'Saved to gallery';
	@override String get downloadFailed => 'Could not save';
}

// Path: discover.highlight
class _Translations$discover$highlight$en extends Translations$discover$highlight$tr {
	_Translations$discover$highlight$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Highlight';
	@override String get view => 'View';
	@override String get aiComments => 'AI comments';
	@override String get remove => 'Remove highlight';
	@override String get sharedSuccess => 'Your post was shared successfully';
	@override String get boost => 'Boost';
}

// Path: discover.stats
class _Translations$discover$stats$en extends Translations$discover$stats$tr {
	_Translations$discover$stats$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Statistics';
	@override String get subtitle => 'Statistics related to your post\nare below.';
	@override String get viewers => 'Viewers';
	@override String get comments => 'Comments';
	@override String get likes => 'Likes';
	@override String get boostCta => 'Boost for 1 day - 100 tokens';
	@override String get boosted => 'Boosted! Your post is at the top for 24 hours.';
}

// Path: createProfile.interests
class _Translations$createProfile$interests$en extends Translations$createProfile$interests$tr {
	_Translations$createProfile$interests$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get music => 'Music';
	@override String get movies => 'Movies';
	@override String get tvShows => 'TV shows';
	@override String get reading => 'Reading';
	@override String get painting => 'Painting';
	@override String get photography => 'Photography';
	@override String get theatre => 'Theatre';
	@override String get fitness => 'Fitness';
	@override String get swimming => 'Swimming';
	@override String get football => 'Football';
	@override String get basketball => 'Basketball';
	@override String get coffee => 'Coffee';
	@override String get travel => 'Travel';
	@override String get camping => 'Camping';
	@override String get meditation => 'Meditation';
	@override String get videoGames => 'Video games';
	@override String get boardGames => 'Board games';
	@override String get standUp => 'Stand-up comedy';
	@override String get tech => 'Tech';
	@override String get coding => 'Coding';
	@override String get ai => 'AI';
	@override String get podcast => 'Podcasts';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsEn {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.name' => 'Veylo',
			'app.tagline' => 'Welcome',
			'home.title' => 'Home',
			'home.subtitle' => 'App is being prepared',
			'home.body' => 'The multilingual UI is managed with slang.',
			'chats.title' => 'Chats',
			'chats.search' => 'Search',
			'chats.messagesSection' => 'Messages',
			'chats.request' => 'Request',
			'chats.emptyRequestTitle' => 'There are no recent message\nnotifications',
			'chats.emptyRequestSubtitle' => 'Requests older than 30 days are not displayed.',
			'chats.noteAdd' => 'Add Note',
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
			'chats.approve' => 'Approve',
			'chats.blockUser' => 'Block User',
			'chats.reject' => 'Reject',
			'chats.messageHint' => 'Hi! how are you?',
			'chats.revealTitle' => 'You\'ve reached 100%',
			'chats.revealSubtitle' => 'Reveal your full profiles to each other? Both sides must agree.',
			'chats.revealWaiting' => ({required Object name}) => 'Waiting for ${name} to accept',
			'chats.revealCta' => 'Reveal my profile',
			'chats.revealNotYet' => 'Not Yet',
			'chats.seen' => 'Seen',
			'chats.typing' => 'typing…',
			'chats.noteYou' => 'You',
			'chats.noteSheetTitle' => 'Share a note',
			'chats.noteSheetSubtitle' => 'Your note stays for 24 hours',
			'chats.noteHint' => 'What’s on your mind?',
			'chats.noteShare' => 'Share',
			'chats.noteDelete' => 'Delete note',
			'profile.eyebrow' => 'Profile',
			'profile.title' => 'Settings',
			'profile.editProfile' => 'Edit Profile',
			'profile.statLike' => 'Like',
			'profile.statFollow' => 'Follow',
			'profile.statFollower' => 'Follower',
			'profile.promoTitle' => 'Get More Messages!',
			'profile.promoSubtitle' => 'Stand out, appear at the top of the list',
			'profile.standOut' => 'Stand Out',
			'profile.tabPosts' => 'Posts',
			'profile.tabVideo' => 'Video',
			'profile.tabSaved' => 'Saved',
			'profile.save' => 'Save',
			'profile.changePhoto' => 'Change Photo',
			'profile.changeBorder' => 'Change Border',
			'profile.interest' => 'Interest',
			'profile.name' => 'Name',
			'profile.changeName' => 'Change Name',
			'profile.changePassword' => 'Change Password',
			'profile.confirmPassword' => 'Confirm Password',
			'profile.email' => 'Email',
			'profile.accountManagement' => 'Account Management',
			'profile.settingsAbout' => 'About',
			'profile.settingsAccount' => 'Account Settings',
			'profile.settingsSupport' => 'Support',
			'profile.shareApp' => 'Share the App',
			'profile.shareAppTitle' => 'Share with Friends',
			'profile.shareAppSubtitle' => 'Share Veylo with your friends and discover together!',
			'profile.shareAppLabel' => 'App link',
			'profile.rateApp' => 'Did you like us? Rate us',
			'profile.notifications' => 'Notifications',
			'profile.password' => 'Password',
			'profile.deleteConversation' => 'Delete Conversation',
			'profile.faqHelp' => 'F.A.Q & Help',
			'profile.restorePurchases' => 'Restore Purchases',
			'profile.termsOfService' => 'Terms Of Service',
			'profile.privacyPolicy' => 'Privacy Policy',
			'profile.restorePurchasesDone' => 'Purchases checked',
			'profile.conversationsDeleted' => 'All conversations deleted',
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
			'profile.borderSubtitle' => 'Add a border to your profile to make\nyourself stand out.',
			'profile.borderBuySection' => 'Buy a border',
			'profile.borderBuyCta' => 'Buy Border',
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
			'profile.followTabFollowing' => 'Following',
			'profile.followTabFollowers' => 'Followers',
			'profile.followSearch' => 'Search',
			'profile.unfollow' => 'Unfollow',
			'profile.followSortTitle' => 'Sort',
			'profile.followSortRecent' => 'People I followed most recently',
			'profile.followSortNotFollowingMe' => 'People who don\'t follow me back',
			'profile.followSortNotFollowedByMe' => 'People I don\'t follow back',
			'profile.followSortShowResult' => 'Show Result',
			'profile.followSortEmpty' => 'No users match this filter',
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
			'profile.reportTitle' => 'We\'d like to know why',
			'profile.reportSubtitle' => 'To help us give you a better experience, could you tell us why you want to report this user?',
			'profile.reportMessageLabel' => 'Report Message',
			'profile.reportMessageHint' => 'Type your message',
			'profile.reportCancel' => 'Cancel',
			'profile.sendReport' => 'Send Report',
			'profile.notSet' => 'Not set',
			'profile.reportSent' => 'Thanks, we received your report.',
			'profile.emailVerificationSent' => ({required Object email}) => 'We sent a confirmation link to ${email}. Your email changes after you confirm.',
			'profile.passwordChanged' => 'Your password has been updated.',
			'profile.passwordMismatch' => 'Passwords don’t match.',
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
			'call.callStrangerFree' => 'Call Stranger',
			'call.peerLeft' => 'The other person ended the call.',
			'call.noKeep' => 'Chat didn\'t unlock this time.',
			'call.videoWaiting' => 'Waiting for them to accept the video call...',
			'call.videoDeclined' => 'They declined the video call.',
			'call.micDenied' => 'Microphone access is needed for calls. You can enable it in Settings.',
			'call.videoCost' => 'Video call: 20 tokens / 15 min',
			'call.calling' => 'Calling',
			'call.accept' => 'Accept',
			'call.decline' => 'Decline',
			'call.switchToVideo' => 'Would you like to switch to a video call?',
			'vibes.search' => 'Search',
			'vibes.sendMessage' => 'Send Message',
			'vibes.wantsToTalk' => 'Wants to talk about this right now',
			'vibes.shareTitle' => 'Share Vibe',
			'vibes.replyTitle' => 'Reply to Vibe',
			'vibes.shareHint' => 'Write something',
			'vibes.shareAnonymous' => 'Share anonymously',
			'vibes.empty' => 'No vibes in the last 24 hours. Share the first one!',
			'vibes.deleteTitle' => 'Delete this vibe?',
			'vibes.delete' => 'Delete',
			'vibes.cancel' => 'Cancel',
			'discover.title' => 'Discover',
			'discover.tabRooms' => 'Rooms',
			'discover.tabDiscover' => 'Discover',
			'discover.tabAiMatch' => 'AI Match',
			'discover.aiMatch.feelingTitle' => 'How are you feeling today',
			'discover.aiMatch.feelingSubtitle' => 'AI finds the best match based on your pick',
			'discover.aiMatch.lookingTitle' => 'What are you looking for?',
			'discover.aiMatch.moodSad' => 'Sad',
			'discover.aiMatch.moodMeltie' => 'Meh',
			'discover.aiMatch.moodBored' => 'Bored',
			'discover.aiMatch.moodCrying' => 'Down',
			'discover.aiMatch.moodSmile' => 'Happy',
			'discover.aiMatch.lookingNewFriends' => 'New friends',
			'discover.aiMatch.lookingVenting' => 'Venting',
			'discover.aiMatch.lookingFlirty' => 'Flirty chat',
			'discover.aiMatch.lookingFun' => 'Fun',
			'discover.aiMatch.lookingCultures' => 'New cultures',
			'discover.aiMatch.lookingLanguage' => 'Language practice',
			'discover.aiMatch.statActiveUsers' => 'Active users',
			'discover.aiMatch.statMatchRate' => 'Match rate',
			'discover.aiMatch.statAvgTime' => 'Avg time',
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
			'discover.aiMatch.noMatch' => 'No one matches right now. Try again in a little while.',
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
			'discover.createSpace.subtitle' => 'Reach more people by creating a group or a live room',
			'discover.createSpace.room' => 'Room',
			'discover.createSpace.group' => 'Group',
			'discover.createSpace.hideAccount' => 'Hide Your Account',
			'discover.createSpace.create' => 'Create',
			'discover.createSpace.cancel' => 'Cancel',
			'discover.createSpace.createRoomTitle' => 'Create Room',
			'discover.createSpace.createGroupTitle' => 'Create Group',
			'discover.createSpace.nameSubtitle' => 'Give the group you created a name',
			'discover.createSpace.nameHint' => 'Night Owl',
			'discover.createSpace.createRoomFor' => ({required Object count}) => 'Create for ${count} tokens',
			'discover.liveRoom.adminSuffix' => '(Admin)',
			'discover.liveRoom.messageHint' => 'Message',
			'discover.liveRoom.quickReplyHey' => 'Hey, everyone!',
			'discover.liveRoom.quickReplyTopic' => 'What\'s the topic?',
			'discover.liveRoom.quickReplyNew' => 'I\'m new here!',
			'discover.liveRoom.sampleChatName' => 'Sona',
			'discover.liveRoom.sampleChatBody' => 'What can we do? What do you have in mind?',
			'discover.liveRoom.roomEnded' => 'The room has ended.',
			'discover.liveRoom.wantsToJoin' => ({required Object name}) => '${name} wants to join',
			'discover.liveRoom.approve' => 'Approve',
			'discover.groupChat.usersCount' => ({required Object count}) => '${count} Users',
			'discover.groupChat.sampleVictoria' => 'I\'m really bored. Should we do something, guys?',
			'discover.groupChat.sampleSona' => 'What can we do? What do you have in mind?',
			'discover.groupChat.sampleOwn' => 'Let\'s meet at the pier',
			'discover.groupInfo.media' => 'Media',
			'discover.groupInfo.gallery' => 'Gallery',
			'discover.groupInfo.settings' => 'Settings',
			'discover.groupInfo.notifications' => 'Notifications',
			'discover.groupInfo.blocked' => 'Blocked',
			'discover.groupInfo.private' => 'Private',
			'discover.groupInfo.membersCount' => ({required Object count}) => '${count} members',
			'discover.groupInfo.addPeople' => 'Add people',
			'discover.groupInfo.you' => 'You',
			'discover.groupInfo.admin' => 'Admin',
			'discover.groupInfo.leaveGroup' => 'Leave the group',
			'discover.groupInfo.requests' => 'Join requests',
			'discover.groupInfo.approve' => 'Approve',
			'discover.groupInfo.reject' => 'Reject',
			'discover.groupInfo.addPeopleEmpty' => 'Follow people to add them to the group.',
			'discover.groupInfo.add' => 'Add',
			'discover.groupInfo.makeAdmin' => 'Make admin',
			'discover.groupInfo.removeAdmin' => 'Remove admin',
			'discover.groupInfo.remove' => 'Remove from group',
			'discover.groupInfo.leaveConfirm' => 'Leave this group?',
			'discover.groupInfo.leave' => 'Leave',
			'discover.groupInfo.cancel' => 'Cancel',
			'discover.filters.title' => 'Filters',
			'discover.filters.ageRange' => 'Age Range',
			'discover.filters.ageRangeValue' => ({required Object min, required Object max}) => '${min}-${max}',
			'discover.filters.distance' => 'Distance',
			'discover.filters.distanceValue' => ({required Object km}) => '${km} km',
			'discover.filters.showMe' => 'Show me',
			'discover.filters.everyone' => 'Everyone',
			'discover.filters.women' => 'Women',
			'discover.filters.men' => 'Men',
			'discover.filters.interests' => 'Interests',
			'discover.filters.activeNow' => 'Active now',
			'discover.filters.activeNowSubtitle' => 'Only show people online right now',
			'discover.filters.showResult' => 'Show Result',
			'discover.post.follow' => 'Follow',
			'discover.post.following' => 'Following',
			'discover.post.addComment' => 'Add comment...',
			'discover.post.commentsTitle' => 'Comments',
			'discover.post.sampleCaption' => 'There\'s nothing quite like having a cup of coffee after a beautiful day. <3',
			'discover.post.hoursAgo' => ({required Object hours}) => '${hours}h',
			'discover.post.minutesAgo' => ({required Object minutes}) => '${minutes}m',
			'discover.post.daysAgo' => ({required Object days}) => '${days}d',
			'discover.post.deleteCommentTitle' => 'Delete this comment?',
			'discover.story.draft' => 'DRAFT',
			'discover.story.story' => 'STORY',
			'discover.story.share' => 'Share',
			'discover.story.textPlaceholder' => 'Text something...',
			'discover.story.draftPrompt' => 'Save as draft?',
			'discover.story.saveToDraft' => 'Save to Draft',
			'discover.story.moveToTrash' => 'Move to Trash',
			'discover.story.save' => 'Save',
			'discover.story.musicTitle' => 'Music',
			'discover.story.musicEmpty' => 'No music found.',
			'discover.story.musicError' => 'Could not load music.',
			'discover.story.downloaded' => 'Saved to gallery',
			'discover.story.downloadFailed' => 'Could not save',
			'discover.highlight.title' => 'Highlight',
			'discover.highlight.view' => 'View',
			'discover.highlight.aiComments' => 'AI comments',
			'discover.highlight.remove' => 'Remove highlight',
			'discover.highlight.sharedSuccess' => 'Your post was shared successfully',
			'discover.highlight.boost' => 'Boost',
			'discover.stats.title' => 'Statistics',
			'discover.stats.subtitle' => 'Statistics related to your post\nare below.',
			'discover.stats.viewers' => 'Viewers',
			'discover.stats.comments' => 'Comments',
			'discover.stats.likes' => 'Likes',
			'discover.stats.boostCta' => 'Boost for 1 day - 100 tokens',
			'discover.stats.boosted' => 'Boosted! Your post is at the top for 24 hours.',
			'discover.hostedBy' => ({required Object name}) => 'Hosted by ${name}',
			'common.loading' => 'Loading…',
			'common.retry' => 'Retry',
			'common.cancel' => 'Cancel',
			'common.save' => 'Save',
			'common.continueAction' => 'Continue',
			'common.language' => 'Language',
			'common.or' => 'OR',
			'languages.tr' => 'Türkçe',
			'languages.en' => 'English',
			'auth.createAccountTitle' => 'Create your account',
			'auth.createAccountSubtitle' => 'Join Veylo and start connecting.',
			'auth.welcomeBackTitle' => 'Welcome back',
			'auth.welcomeBackSubtitle' => 'Log in to continue to Veylo.',
			'auth.username' => 'Username',
			'auth.usernameHint' => 'Choose a username',
			'auth.email' => 'Email',
			'auth.emailHint' => 'Enter your email',
			'auth.emailOrUsername' => 'Email or Username',
			'auth.emailOrUsernameHint' => 'Choose a username',
			'auth.password' => 'Password',
			'auth.passwordCreateHint' => 'Create a password',
			'auth.passwordEnterHint' => 'Enter your password',
			'auth.signUp' => 'Sign Up',
			'auth.logIn' => 'Log In',
			'auth.forgotPassword' => 'Forgot Password?',
			'auth.continueWithApple' => 'Continue with Apple',
			'auth.continueWithGoogle' => 'Continue with Google',
			'auth.legalPrefix' => 'By continuing, you agree to our ',
			'auth.termsOfService' => 'Terms of Service',
			'auth.legalMiddle' => ' and acknowledge our ',
			'auth.privacyPolicy' => 'Privacy Policy',
			'auth.legalSuffix' => '.',
			'auth.passwordResetSent' => 'We sent a password reset link to your email.',
			'onboarding.skip' => 'Skip',
			'onboarding.page1Title' => 'Be yourself. Stay anonymous.',
			'onboarding.page1Subtitle' => 'Meet new people and start conversations\nwithout revealing who you are.',
			'onboarding.page2Title' => 'Text. Talk. Feel the vibe.',
			'onboarding.page2Subtitle' => 'Start anonymously, then text, call, or go face to face when you\'re ready.',
			'onboarding.page3Title' => 'Find your people. Join\nthe conversation.',
			'onboarding.page3Subtitle' => 'Jump into rooms, meet new people, and\nshare the moment together.',
			'onboarding.getStarted' => 'Get Started',
			'onboarding.alreadyHaveAccount' => 'Already have a Veylo account? ',
			'onboarding.logInAction' => 'Log In',
			'createProfile.navTitle' => 'Create Profile',
			'createProfile.stepUsername' => '1/5 Username',
			'createProfile.title' => 'Create your profile',
			'createProfile.subtitle' => 'Your real name is only used for verification — it won\'t appear publicly.',
			'createProfile.subtitleLine1' => 'Your real name is only used for verification — it',
			'createProfile.subtitleLine2' => 'won\'t appear publicly.',
			'createProfile.fullName' => 'Full name',
			'createProfile.fullNameHint' => 'Sam Lee',
			'createProfile.username' => 'Username',
			'createProfile.usernameHint' => 'samlee123',
			'createProfile.usernameTaken' => 'This username already exists!',
			'createProfile.usernameAvailable' => 'Username is available',
			'createProfile.mightWantToTry' => 'Might want to try...',
			'createProfile.stepPhoto' => '2/5 Profile Photo',
			'createProfile.photoTitle' => 'Upload a profile photo',
			'createProfile.photoSubtitle' => 'Other users can see your profile photo to make sure it\'s you.',
			'createProfile.photoSubtitleLine1' => 'Other users can see your profile photo to make',
			'createProfile.photoSubtitleLine2' => 'sure it\'s you.',
			'createProfile.choosePhoto' => 'Choose a photo',
			'createProfile.continueWithoutPhoto' => 'Continue without a profile photo',
			'createProfile.saveAndContinue' => 'Save & Continue',
			'createProfile.choosePhotoSheetTitle' => 'Choose a photo',
			'createProfile.takePhoto' => 'Take a photo',
			'createProfile.chooseFromGallery' => 'Choose from library',
			'createProfile.stepGender' => '3/5 Gender',
			'createProfile.genderTitle' => 'Choose your gender',
			'createProfile.genderSubtitle' => 'If you choose to provide this information to us, we may use it to personalize content for you',
			'createProfile.genderSubtitleLine1' => 'If you choose to provide this information to us, we',
			'createProfile.genderSubtitleLine2' => 'may use it to personalize content for you',
			'createProfile.genderFemale' => 'Female',
			'createProfile.genderMale' => 'Male',
			'createProfile.genderNonBinary' => 'Non-binary',
			'createProfile.genderPreferNotToSay' => 'Prefer not to say',
			'createProfile.stepInterests' => '4/5 Interests',
			'createProfile.interestsTitle' => 'What are you into?',
			'createProfile.interestsSubtitle' => 'Pick at least 5 — this helps us match you with people who actually get you.',
			'createProfile.interests.music' => 'Music',
			'createProfile.interests.movies' => 'Movies',
			'createProfile.interests.tvShows' => 'TV shows',
			'createProfile.interests.reading' => 'Reading',
			'createProfile.interests.painting' => 'Painting',
			'createProfile.interests.photography' => 'Photography',
			'createProfile.interests.theatre' => 'Theatre',
			'createProfile.interests.fitness' => 'Fitness',
			'createProfile.interests.swimming' => 'Swimming',
			'createProfile.interests.football' => 'Football',
			'createProfile.interests.basketball' => 'Basketball',
			'createProfile.interests.coffee' => 'Coffee',
			'createProfile.interests.travel' => 'Travel',
			'createProfile.interests.camping' => 'Camping',
			'createProfile.interests.meditation' => 'Meditation',
			'createProfile.interests.videoGames' => 'Video games',
			'createProfile.interests.boardGames' => 'Board games',
			'createProfile.interests.standUp' => 'Stand-up comedy',
			'createProfile.interests.tech' => 'Tech',
			'createProfile.interests.coding' => 'Coding',
			'createProfile.interests.ai' => 'AI',
			'createProfile.interests.podcast' => 'Podcasts',
			'createProfile.stepChatGoal' => '5/5 Chat goal',
			'createProfile.chatGoalTitle' => 'What are you looking for today?',
			'createProfile.chatGoalSubtitle' => 'This helps us find the right match for your mood right now.',
			_ => null,
		} ?? switch (path) {
			'createProfile.chatGoalQuickMatch' => 'Quick match — jump straight into a\nconversation',
			'createProfile.chatGoalFlirtyChat' => 'Flirty chat — light, playful\nconversations',
			'createProfile.chatGoalMoodMatch' => 'Mood match — match based on how you\'re\nfeeling',
			'createProfile.chatGoalLateNight' => 'Late night talk — deep chats when the world\'s\nasleep',
			'createProfile.chatGoalMeetSomeoneNew' => 'Meet someone new — no specific goal, just\nexplore',
			'createProfile.getStarted' => 'Get Started',
			'createProfile.preparingTitleLine1' => 'We\'re preparing',
			'createProfile.preparingTitleLine2' => 'profiles that are right for',
			'createProfile.preparingTitleLine3' => 'you.',
			'createProfile.preparingSubtitleLine1' => 'Based on your answers, we\'re selecting',
			'createProfile.preparingSubtitleLine2' => 'the best matches—please wait a moment.',
			'createProfile.preparingPercent' => ({required Object percent}) => '%${percent}',
			'createProfile.usernameInvalid' => 'Use 3–30 letters, numbers, dots or underscores.',
			'errors.network' => 'Couldn’t reach Veylo. Check your connection and try again.',
			'errors.generic' => 'Something went wrong. Please try again.',
			'errors.signInFailed' => 'Sign in failed. Please try again.',
			'errors.sessionExpired' => 'Your session has ended. Please sign in again.',
			'errors.accountSuspended' => 'This account has been suspended.',
			'errors.unsupportedImage' => 'Please choose a JPEG, PNG or WebP photo.',
			'errors.fileTooLarge' => 'This file is too large.',
			'errors.enterEmailForReset' => 'Enter your email above to reset your password.',
			'errors.wrongCredentials' => 'Email/username or password is incorrect.',
			'errors.emailInUse' => 'This email is already registered. Try logging in.',
			'errors.weakPassword' => 'Password must be at least 6 characters.',
			'errors.invalidEmail' => 'Please enter a valid email address.',
			'errors.tooManyAttempts' => 'Too many attempts. Please wait a bit and try again.',
			'errors.fillAllFields' => 'Please fill in all fields.',
			'errors.insufficientTokens' => 'Not enough tokens.',
			'errors.requestNotAccepted' => 'Accept the request to reply.',
			'errors.requestPendingLimit' => 'You can send more messages after they accept your request.',
			'errors.blocked' => 'You can’t message this person.',
			'errors.peerUnavailable' => 'This account is no longer available.',
			'errors.vibeDailyLimit' => 'You’ve shared a lot of vibes today. Try again later.',
			'errors.groupFull' => 'This group is full.',
			'errors.groupCreateLimit' => 'You’ve created too many groups today. Try again later.',
			'errors.notFound' => 'This is no longer available.',
			'errors.recentLogin' => 'For your security, log out and log in again, then try once more.',
			'errors.socialAccount' => 'Your email and password are managed by your Google or Apple account.',
			'errors.alreadyInCall' => 'You are already in a call.',
			'errors.roomPrivate' => 'This room is private. Ask the host to join.',
			'errors.roomFull' => 'This room is full.',
			'faq.q1' => 'How does this app work?',
			'faq.q2' => 'What is anonymous chat?',
			'faq.q3' => 'What is Connection Progress?',
			'faq.q4' => 'How do I reveal my profile?',
			'faq.q5' => 'What is 60 Second Stranger?',
			'faq.q6' => 'What are Vibes?',
			'faq.q7' => 'How do I edit my profile?',
			'faq.q8' => 'How do I manage notifications?',
			'faq.q9' => 'How do I restore purchases?',
			'faq.q10' => 'Can I delete all conversations?',
			'faq.q11' => 'Is my data secure?',
			'faq.q12' => 'How do I block or report someone?',
			'faq.q13' => 'How do I share the app?',
			'faq.q14' => 'How do I delete my account?',
			'faq.a1' => 'On Veylo you can meet new people anonymously, chat, and gradually reveal your profile as your connection grows. Switch to text, voice, or face-to-face whenever you both feel ready.',
			'faq.a2' => 'In anonymous chat your identity and photo stay hidden. As connection rises you unlock details like a name initial and a blurred photo. At 100%, both sides must agree to reveal full profiles.',
			'faq.a3' => 'As you chat, your connection percentage grows. At certain milestones you unlock a name initial, a blurred photo, and full profile. Tap the Connection pill to see details.',
			'faq.a4' => 'When connection reaches 100%, tap Reveal my profile. If the other person also accepts, both full profiles become visible.',
			'faq.a5' => 'From the Call tab you can get a short random match. When time is up you can keep talking or end the call.',
			'faq.a6' => 'Vibes lets you discover people nearby or around you on a map/list view and start a chat with someone you’re interested in.',
			'faq.a7' => 'Open the Profile tab and go to Edit Profile to update your name, photos, bio, and interests. Changes appear after you save.',
			'faq.a8' => 'Open Notifications in Settings to turn message, match, and other alerts on or off.',
			'faq.a9' => 'Go to Settings → Account Management → Restore Purchases. Eligible buys on the same store account will be restored.',
			'faq.a10' => 'Yes. Use Settings → Delete Conversation and confirm. All chats will be removed. This can’t be undone.',
			'faq.a11' => 'Your account details and messages are stored on protected systems. You can also request account and data deletion from Account Management anytime.',
			'faq.a12' => 'Use the menu on a profile or chat screen to block or report. Reports are reviewed by our team.',
			'faq.a13' => 'Use Share App in Settings to copy the link and send it to friends.',
			'faq.a14' => 'Go to Settings → Account Management → Delete Account and Data. After sharing a reason, confirm to submit your deletion request.',
			'legal.termsTitle' => 'Terms of Service',
			'legal.privacyTitle' => 'Privacy Policy',
			'legal.termsBody' => 'Last updated: March 16, 2026\n\nWelcome to Veylo. By creating an account or using the app, you agree to these Terms of Service.\n\n1. What Veylo is\nVeylo is a social app where you can meet people, chat anonymously, build connection over time, and optionally move to voice or face-to-face calls when both sides agree.\n\n2. Your account\nYou must provide accurate information and keep your login secure. You are responsible for activity under your account. You must be old enough to use Veylo under the laws of your country.\n\n3. Respectful use\nDo not harass, threaten, scam, impersonate others, share illegal content, or try to bypass safety features. We may remove content, limit features, or suspend accounts that break these rules.\n\n4. Anonymous chat & profile reveal\nAnonymous chats may hide your name and photo until connection milestones are reached. Full profile reveal requires mutual consent. Do not pressure others to reveal identity.\n\n5. Purchases\nSome features may be paid. Purchases are handled by Apple App Store or Google Play. Restore Purchases recovers eligible buys on the same store account. Refunds follow the store’s policy.\n\n6. Content you share\nYou keep rights to your content, but grant Veylo a license to host and display it in the app as needed to operate the service. Do not post content you do not have rights to share.\n\n7. Ending use\nYou can stop using Veylo anytime and request account deletion from Settings. We may also end or change the service with reasonable notice when required.\n\n8. Contact\nQuestions about these terms: support@veylo.app',
			'legal.privacyBody' => 'Last updated: March 16, 2026\n\nThis Privacy Policy explains how Veylo collects, uses, and protects your information.\n\n1. Information we collect\n• Account data: email, display name, profile photos, bio, preferences\n• Usage data: chats, connection progress, call features you use, device/app basics\n• Purchases: store receipt data needed to unlock and restore paid features\n\n2. How we use it\nWe use your data to run Veylo, personalize matching and chat experiences, keep the community safe, process purchases, and improve the product. We do not sell your personal data.\n\n3. Anonymous mode\nIn anonymous chats we limit what others see (for example masked name or blurred photo) until unlock rules and mutual consent allow more. Behind the scenes we still need account identifiers to operate the feature securely.\n\n4. Sharing\nWe may share data with service providers that help us host, analyze, or process payments—only as needed. We may also disclose information if required by law or to protect users from harm.\n\n5. Retention\nWe keep data while your account is active and as needed for legal, safety, and billing reasons. After a deletion request is completed, we remove or anonymize personal data except where retention is required.\n\n6. Your choices\nYou can edit profile info, manage notifications, request account deletion, and contact us about your data. Store purchases are also managed through Apple or Google.\n\n7. Security\nWe use reasonable technical and organizational measures to protect your information. No system is perfectly secure; please use a strong password and keep your device updated.\n\n8. Contact\nPrivacy questions: privacy@veylo.app',
			'logout.title' => 'Log out',
			'logout.subtitle' => 'Are you sure you want to log out?',
			'logout.cancel' => 'Cancel',
			'logout.confirm' => 'Log out',
			'deleteAccount.title' => 'Submit an account deletion request',
			'deleteAccount.subtitle' => 'Are you sure you want to delete your account?',
			'deleteAccount.reasonTitle' => 'We don\'t want you to leave, but we understand.',
			'deleteAccount.reasonBefore' => 'Would you tell us why you want to leave so we can improve the ',
			'deleteAccount.reasonAfter' => ' experience?',
			'deleteAccount.reasonLabel' => 'Why do you want to delete your account',
			'deleteAccount.reasonHint' => 'Type your message',
			'deleteAccount.cancel' => 'Cancel',
			'deleteAccount.createRequest' => 'Create a Request',
			'deleteAccount.confirmTitle' => 'Are you sure you want to submit a deletion request?',
			'deleteAccount.confirmSubtitle' => 'If you confirm, your account deletion request will be submitted',
			'deleteAccount.delete' => 'Delete',
			'storyText.bold' => 'Bold',
			'storyText.italic' => 'Italic',
			'storyText.uppercase' => 'Uppercase',
			'storyText.underline' => 'Underline',
			'storyText.cancel' => 'Cancel',
			'storyText.galleryError' => 'Could not open the gallery',
			_ => null,
		};
	}
}
