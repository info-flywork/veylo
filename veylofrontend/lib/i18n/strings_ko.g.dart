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
class TranslationsKo extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsKo({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ko,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ko>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key) ?? super[key];

	late final TranslationsKo _root = this; // ignore: unused_field

	@override 
	TranslationsKo $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsKo(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$app$ko app = _Translations$app$ko._(_root);
	@override late final _Translations$home$ko home = _Translations$home$ko._(_root);
	@override late final _Translations$chats$ko chats = _Translations$chats$ko._(_root);
	@override late final _Translations$profile$ko profile = _Translations$profile$ko._(_root);
	@override late final _Translations$nav$ko nav = _Translations$nav$ko._(_root);
	@override late final _Translations$call$ko call = _Translations$call$ko._(_root);
	@override late final _Translations$vibes$ko vibes = _Translations$vibes$ko._(_root);
	@override late final _Translations$discover$ko discover = _Translations$discover$ko._(_root);
	@override late final _Translations$common$ko common = _Translations$common$ko._(_root);
	@override late final _Translations$languages$ko languages = _Translations$languages$ko._(_root);
	@override late final _Translations$auth$ko auth = _Translations$auth$ko._(_root);
	@override late final _Translations$onboarding$ko onboarding = _Translations$onboarding$ko._(_root);
	@override late final _Translations$createProfile$ko createProfile = _Translations$createProfile$ko._(_root);
	@override late final _Translations$errors$ko errors = _Translations$errors$ko._(_root);
	@override late final _Translations$faq$ko faq = _Translations$faq$ko._(_root);
	@override late final _Translations$legal$ko legal = _Translations$legal$ko._(_root);
	@override late final _Translations$logout$ko logout = _Translations$logout$ko._(_root);
	@override late final _Translations$deleteAccount$ko deleteAccount = _Translations$deleteAccount$ko._(_root);
	@override late final _Translations$storyText$ko storyText = _Translations$storyText$ko._(_root);
	@override late final _Translations$tokens$ko tokens = _Translations$tokens$ko._(_root);
}

// Path: app
class _Translations$app$ko extends Translations$app$tr {
	_Translations$app$ko._(TranslationsKo root) : this._root = root, super.internal(root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get name => 'Veylo';
	@override String get tagline => '환영해요';
}

// Path: home
class _Translations$home$ko extends Translations$home$tr {
	_Translations$home$ko._(TranslationsKo root) : this._root = root, super.internal(root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '홈';
	@override String get subtitle => '앱을 준비하고 있어요';
	@override String get body => '다국어 UI는 slang으로 관리돼요.';
}

// Path: chats
class _Translations$chats$ko extends Translations$chats$tr {
	_Translations$chats$ko._(TranslationsKo root) : this._root = root, super.internal(root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '채팅';
	@override String get search => '검색';
	@override String get messagesSection => '메시지';
	@override String get request => '요청';
	@override String get emptyRequestTitle => '최근 메시지\n알림이 없어요';
	@override String get emptyRequestSubtitle => '30일이 지난 요청은 표시되지 않아요.';
	@override String get noteAdd => '노트 추가';
	@override String get anonymous => '익명';
	@override String get online => '온라인';
	@override String get offline => '오프라인';
	@override String get connection => '연결';
	@override String connectionPercent({required Object n}) => '${n}%';
	@override String get connectionProgressTitle => '연결 진행도';
	@override String get milestoneInitial => '이름 첫 글자';
	@override String get milestoneInitialHint => '25%에서 공개됨';
	@override String get milestoneInitialLocked => '25%에서 공개돼요';
	@override String get milestonePhoto => '흐린 사진 미리보기';
	@override String get milestonePhotoHint => '70%에서 공개돼요';
	@override String get milestoneFull => '전체 프로필 보기';
	@override String get milestoneFullHint => '100%에서 서로 동의 시';
	@override String get sampleAnonymousMessage => '안녕하세요, 만나서 반가워요. 자기소개 조금 해주실래요?';
	@override String get strangerSampleMessage => '안녕하세요 Jhon, 만나서 반가워요. 자기소개 조금 해주실래요?';
	@override String get approve => '수락';
	@override String get blockUser => '사용자 차단';
	@override String get reject => '거절';
	@override String get messageHint => '안녕! 잘 지내?';
	@override String get revealTitle => '100%에 도달했어요';
	@override String get revealSubtitle => '서로 전체 프로필을 공개할까요? 두 사람 모두 동의해야 해요.';
	@override String revealWaiting({required Object name}) => '${name}님의 수락을 기다리는 중';
	@override String get revealCta => '내 프로필 공개';
	@override String get revealNotYet => '아직이요';
	@override String get seen => '읽음';
	@override String get typing => '입력 중…';
	@override String get noteYou => '나';
	@override String get noteSheetTitle => '노트 공유';
	@override String get noteSheetSubtitle => '노트는 24시간 동안 유지돼요';
	@override String get noteHint => '무슨 생각 하고 있어요?';
	@override String get noteShare => '공유';
	@override String get noteDelete => '노트 삭제';
}

// Path: profile
class _Translations$profile$ko extends Translations$profile$tr {
	_Translations$profile$ko._(TranslationsKo root) : this._root = root, super.internal(root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get eyebrow => '프로필';
	@override String get title => '설정';
	@override String get editProfile => '프로필 편집';
	@override String get statLike => '좋아요';
	@override String get statFollow => '팔로우';
	@override String get statFollower => '팔로워';
	@override String get promoTitle => '더 많은 메시지를 받아보세요!';
	@override String get promoSubtitle => '눈에 띄고, 목록 상단에 노출돼요';
	@override String get standOut => '돋보이기';
	@override String get tabPosts => '게시물';
	@override String get tabVideo => '동영상';
	@override String get tabSaved => '저장됨';
	@override String get save => '저장';
	@override String get changePhoto => '사진 변경';
	@override String get changeBorder => '테두리 변경';
	@override String get interest => '관심사';
	@override String get name => '이름';
	@override String get changeName => '이름 변경';
	@override String get changePassword => '비밀번호 변경';
	@override String get confirmPassword => '비밀번호 확인';
	@override String get email => '이메일';
	@override String get accountManagement => '계정 관리';
	@override String get settingsAbout => '정보';
	@override String get settingsAccount => '계정 설정';
	@override String get settingsSupport => '지원';
	@override String get shareApp => '앱 공유하기';
	@override String get shareAppTitle => '친구와 공유하기';
	@override String get shareAppSubtitle => '친구에게 Veylo를 공유하고 함께 발견해요!';
	@override String get shareAppLabel => '앱 링크';
	@override String get rateApp => '마음에 드셨나요? 평가해 주세요';
	@override String get notifications => '알림';
	@override String get password => '비밀번호';
	@override String get deleteConversation => '대화 삭제';
	@override String get faqHelp => 'FAQ 및 도움말';
	@override String get restorePurchases => '구매 복원';
	@override String get termsOfService => '서비스 약관';
	@override String get privacyPolicy => '개인정보 처리방침';
	@override String get restorePurchasesDone => '구매 내역을 확인했어요';
	@override String get conversationsDeleted => '모든 대화가 삭제됐어요';
	@override String get logOut => '로그아웃';
	@override String get deleteAccountAndData => '계정 및 데이터 삭제';
	@override String get passwordPlaceholder => '********';
	@override String get height => '키';
	@override String get addHeight => '키 추가';
	@override String heightCm({required Object value}) => '${value} cm';
	@override String get languages => '언어';
	@override String get relationshipGoals => '관계 목표';
	@override String get lookingFor => '찾는 관계';
	@override String get newFriends => '👋 새 친구';
	@override String get goalLongTermOpenToShort => '💕 장기적, 단기도 괜찮아요';
	@override String get goalLongTermRelationship => '💘 장기적인 관계';
	@override String get goalNewFriends => '👋 새 친구';
	@override String get goalShortTermFun => '🥃 가벼운 만남';
	@override String get goalStillFiguringItOut => '🤔 아직 생각 중';
	@override String get basics => '기본 정보';
	@override String get zodiac => '별자리';
	@override String get zodiacValue => '전갈자리';
	@override String get education => '학력';
	@override String get educationValue => '학사';
	@override String get educationHighSchool => '고등학교';
	@override String get educationAssociates => '전문학사';
	@override String get educationBachelors => '학사';
	@override String get educationMasters => '석사';
	@override String get educationPhd => '박사';
	@override String get voiceRecord => '음성 녹음';
	@override String get addVoice => '음성 추가';
	@override String get lifestyle => '라이프스타일';
	@override String get pets => '반려동물';
	@override String get petsValue => '고양이를 키워요';
	@override String get petsDontWant => '반려동물은 원하지 않아요';
	@override String get petsAllergic => '반려동물 알레르기가 있어요';
	@override String get petsHaveCat => '고양이를 키워요';
	@override String get petsHaveDog => '강아지를 키워요';
	@override String get petsHaveCatsAndDogs => '고양이와 강아지를 키워요';
	@override String get petsHaveOther => '다른 반려동물을 키워요';
	@override String get drinking => '음주';
	@override String get drinkingValue => '특별한 날에만';
	@override String get drinkingNever => '안 마셔요';
	@override String get drinkingSpecialOccasions => '특별한 날에만';
	@override String get drinkingSocially => '모임에서만';
	@override String get drinkingFrequently => '자주';
	@override String get drinkingSober => '금주 중';
	@override String get drinkingPreferNotToSay => '밝히고 싶지 않아요';
	@override String get smoking => '흡연';
	@override String get smokingValue => '비흡연';
	@override String get smokingNonSmoker => '비흡연';
	@override String get smokingSocialSmoker => '가끔 흡연';
	@override String get smokingSmoker => '흡연';
	@override String get smokingTryingToQuit => '금연 중';
	@override String get smokingWhenDrinking => '술 마실 때만 흡연';
	@override String get smokingPreferNotToSay => '밝히고 싶지 않아요';
	@override String get gender => '성별';
	@override String get genderFemale => '여성';
	@override String get genderMale => '남성';
	@override String get genderPreferNotToSay => '밝히고 싶지 않아요';
	@override String get visible => '공개';
	@override String get profileVisibility => '프로필 공개 설정';
	@override String get language => '언어';
	@override String get borderTitle => '프로필 테두리';
	@override String get borderSubtitle => '프로필에 테두리를 추가해서\n돋보여 보세요.';
	@override String get borderBuySection => '테두리 구매';
	@override String get borderBuyCta => '테두리 구매';
	@override String borderToken({required Object count}) => '${count} 토큰';
	@override String get borderAmethystWings => 'Amethyst Wings';
	@override String get borderGoldenPhoenix => 'Golden Phoenix';
	@override String get borderFrostCrown => 'Frost Crown';
	@override String get borderEmeraldWhisper => 'Emerald Whisper';
	@override String get borderRoseQuartz => 'Rose Quartz';
	@override String get borderStarlitComet => 'Starlit Comet';
	@override String get borderCrimsonRoyal => 'Crimson Royal';
	@override String get borderSapphireHalo => 'Sapphire Halo';
	@override String get follow => '팔로우';
	@override String get following => '팔로잉';
	@override String get followPageTitle => '팔로우';
	@override String get followTabFollowing => '팔로잉';
	@override String get followTabFollowers => '팔로워';
	@override String get followSearch => '검색';
	@override String get unfollow => '언팔로우';
	@override String get followSortTitle => '정렬';
	@override String get followSortRecent => '최근에 팔로우한 사람';
	@override String get followSortNotFollowingMe => '나를 맞팔하지 않은 사람';
	@override String get followSortNotFollowedByMe => '내가 맞팔하지 않은 사람';
	@override String get followSortShowResult => '결과 보기';
	@override String get followSortEmpty => '이 필터에 맞는 사용자가 없어요';
	@override String get shareTitle => '친구와 공유하기';
	@override String get shareSubtitle => '친구와 연결하면\n모든 게 더 즐거워요!';
	@override String get shareProfileLabel => '프로필 공유';
	@override String get shareLinkCopied => '링크가 복사됐어요';
	@override String get restrict => '제한';
	@override String get block => '차단';
	@override String get report => '신고';
	@override String blockTitle({required Object username}) => '${username}님을 차단할까요?';
	@override String get blockBody => '이 사용자가 가지고 있거나 앞으로 만들 다른 계정도 함께 차단돼요. 언제든지 차단을 해제할 수 있어요.';
	@override String get blockAndReport => '차단 및 신고';
	@override String restrictTitle({required Object username}) => '${username}님을 제한할까요?';
	@override String get restrictBody => '상대방은 내가 온라인인지, 메시지를 읽었는지 알 수 없어요. 언제든지 변경할 수 있어요.';
	@override String get restrictAndReport => '제한 및 신고';
	@override String get reportTitle => '이유를 알려주세요';
	@override String get reportSubtitle => '더 나은 경험을 위해, 이 사용자를 신고하려는 이유를 알려주시겠어요?';
	@override String get reportMessageLabel => '신고 내용';
	@override String get reportMessageHint => '메시지를 입력하세요';
	@override String get reportCancel => '취소';
	@override String get sendReport => '신고하기';
	@override String get notSet => '설정 안 됨';
	@override String get reportSent => '감사합니다. 신고가 접수됐어요.';
	@override String emailVerificationSent({required Object email}) => '${email}(으)로 확인 링크를 보냈어요. 확인 후 이메일이 변경돼요.';
	@override String get passwordChanged => '비밀번호가 변경됐어요.';
	@override String get passwordMismatch => '비밀번호가 일치하지 않아요.';
}

// Path: nav
class _Translations$nav$ko extends Translations$nav$tr {
	_Translations$nav$ko._(TranslationsKo root) : this._root = root, super.internal(root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get discover => '탐색';
	@override String get chat => '채팅';
	@override String get call => '통화';
	@override String get vibes => 'Vibes';
	@override String get profile => '프로필';
}

// Path: call
class _Translations$call$ko extends Translations$call$tr {
	_Translations$call$ko._(TranslationsKo root) : this._root = root, super.internal(root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '60초 낯선 사람';
	@override String get subtitle => '무작위 낯선 사람과 60초 동안 대화해요 — 완전히 익명으로. 프로필도, 사진도, 이름도 없어요. 오직 목소리와 한순간뿐.';
	@override String get findingTitle => '낯선 사람을 찾는 중...';
	@override String get findingSubtitle => '60초 동안 익명으로 대화해요. 프로필도, 이름도 없어요.';
	@override String get callStranger => '낯선 사람에게 전화 - 10 토큰';
	@override String get cancel => '취소';
	@override String get female => '여성';
	@override String get male => '남성';
	@override String get nonBinary => '논바이너리';
	@override String get preferNotToSay => '밝히고 싶지 않아요';
	@override String get anonymousBadge => '🎙️ 익명 음성 통화';
	@override String get stranger => '낯선 사람';
	@override String secondsLeft({required Object n}) => '${n}초';
	@override String get timesUpTitle => '시간 종료!';
	@override String get timesUpSubtitle => '계속 대화할래요? 둘 다 동의하면 채팅이 열려요.';
	@override String get keepTalking => '계속 대화하기';
	@override String get endCall => '통화 종료';
	@override String get waitingOther => '상대방을 기다리는 중...';
	@override String get callStrangerFree => '낯선 사람에게 전화';
	@override String get peerLeft => '상대방이 통화를 종료했어요.';
	@override String get noKeep => '이번에는 채팅이 열리지 않았어요.';
	@override String get videoWaiting => '상대방이 영상 통화를 수락하길 기다리는 중...';
	@override String get videoDeclined => '상대방이 영상 통화를 거절했어요.';
	@override String get micDenied => '통화하려면 마이크 권한이 필요해요. 설정에서 켤 수 있어요.';
	@override String get videoCost => '영상 통화: 15분당 20 토큰';
	@override String get calling => '전화 거는 중';
	@override String get accept => '수락';
	@override String get decline => '거절';
	@override String get switchToVideo => '영상 통화로 전환할까요?';
	@override String get noMatchTitle => '지금은 대화할 수 있는 사람이 없어요';
	@override String get noMatchBody => '지금은 대화 상대를 찾지 못했어요. 잠시 후에 다시 시도해 주세요.';
	@override String get noMatchOk => '확인';
}

// Path: vibes
class _Translations$vibes$ko extends Translations$vibes$tr {
	_Translations$vibes$ko._(TranslationsKo root) : this._root = root, super.internal(root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get search => '검색';
	@override String get sendMessage => '메시지 보내기';
	@override String get wantsToTalk => '지금 바로 이 얘기를 하고 싶어해요';
	@override String get shareTitle => 'Vibe 공유';
	@override String get replyTitle => 'Vibe에 답장';
	@override String get shareHint => '무언가 적어보세요';
	@override String get shareAnonymous => '익명으로 공유';
	@override String get empty => '최근 24시간 동안 Vibe가 없어요. 첫 Vibe를 공유해 보세요!';
	@override String get deleteTitle => '이 Vibe를 삭제할까요?';
	@override String get delete => '삭제';
	@override String get cancel => '취소';
}

// Path: discover
class _Translations$discover$ko extends Translations$discover$tr {
	_Translations$discover$ko._(TranslationsKo root) : this._root = root, super.internal(root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '탐색';
	@override String get tabRooms => '룸';
	@override String get tabDiscover => '탐색';
	@override String get tabAiMatch => 'AI Match';
	@override late final _Translations$discover$aiMatch$ko aiMatch = _Translations$discover$aiMatch$ko._(_root);
	@override String get searchHint => '검색';
	@override String get allRooms => '전체 룸';
	@override String get allGroups => '전체 그룹';
	@override String get seeAll => '모두 보기';
	@override String get live => '라이브';
	@override String get join => '참여';
	@override String get request => '요청';
	@override String get requested => '요청됨';
	@override String get private => '비공개';
	@override String moreCount({required Object count}) => '+${count}명 더';
	@override String activeCount({required Object count}) => '${count}명 활동 중';
	@override String membersCount({required Object count}) => '멤버 ${count}명';
	@override late final _Translations$discover$privateRoom$ko privateRoom = _Translations$discover$privateRoom$ko._(_root);
	@override late final _Translations$discover$roomToken$ko roomToken = _Translations$discover$roomToken$ko._(_root);
	@override late final _Translations$discover$privateRequest$ko privateRequest = _Translations$discover$privateRequest$ko._(_root);
	@override late final _Translations$discover$roomApproved$ko roomApproved = _Translations$discover$roomApproved$ko._(_root);
	@override late final _Translations$discover$createSpace$ko createSpace = _Translations$discover$createSpace$ko._(_root);
	@override late final _Translations$discover$liveRoom$ko liveRoom = _Translations$discover$liveRoom$ko._(_root);
	@override late final _Translations$discover$groupChat$ko groupChat = _Translations$discover$groupChat$ko._(_root);
	@override late final _Translations$discover$groupInfo$ko groupInfo = _Translations$discover$groupInfo$ko._(_root);
	@override late final _Translations$discover$filters$ko filters = _Translations$discover$filters$ko._(_root);
	@override late final _Translations$discover$post$ko post = _Translations$discover$post$ko._(_root);
	@override late final _Translations$discover$story$ko story = _Translations$discover$story$ko._(_root);
	@override late final _Translations$discover$highlight$ko highlight = _Translations$discover$highlight$ko._(_root);
	@override late final _Translations$discover$stats$ko stats = _Translations$discover$stats$ko._(_root);
	@override String hostedBy({required Object name}) => '호스트: ${name}';
}

// Path: common
class _Translations$common$ko extends Translations$common$tr {
	_Translations$common$ko._(TranslationsKo root) : this._root = root, super.internal(root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get loading => '불러오는 중…';
	@override String get retry => '다시 시도';
	@override String get cancel => '취소';
	@override String get save => '저장';
	@override String get continueAction => '계속';
	@override String get language => '언어';
	@override String get or => '또는';
}

// Path: languages
class _Translations$languages$ko extends Translations$languages$tr {
	_Translations$languages$ko._(TranslationsKo root) : this._root = root, super.internal(root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get tr => 'Türkçe';
	@override String get en => 'English';
}

// Path: auth
class _Translations$auth$ko extends Translations$auth$tr {
	_Translations$auth$ko._(TranslationsKo root) : this._root = root, super.internal(root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get createAccountTitle => '계정 만들기';
	@override String get createAccountSubtitle => 'Veylo에 가입하고 새로운 인연을 시작하세요.';
	@override String get welcomeBackTitle => '다시 오신 걸 환영해요';
	@override String get welcomeBackSubtitle => '로그인하고 Veylo를 계속 이용하세요.';
	@override String get username => '사용자 이름';
	@override String get usernameHint => '사용자 이름을 정하세요';
	@override String get email => '이메일';
	@override String get emailHint => '이메일을 입력하세요';
	@override String get emailOrUsername => '이메일 또는 사용자 이름';
	@override String get emailOrUsernameHint => '이메일 또는 사용자 이름 입력';
	@override String get password => '비밀번호';
	@override String get passwordCreateHint => '비밀번호를 만드세요';
	@override String get passwordEnterHint => '비밀번호를 입력하세요';
	@override String get signUp => '가입하기';
	@override String get logIn => '로그인';
	@override String get forgotPassword => '비밀번호를 잊으셨나요?';
	@override String get continueWithApple => 'Apple로 계속하기';
	@override String get continueWithGoogle => 'Google로 계속하기';
	@override String get legalPrefix => '계속하면 ';
	@override String get termsOfService => '서비스 약관';
	@override String get legalMiddle => '에 동의하고 ';
	@override String get privacyPolicy => '개인정보 처리방침';
	@override String get legalSuffix => '을 확인한 것으로 간주돼요.';
	@override String get passwordResetSent => '이메일로 비밀번호 재설정 링크를 보냈어요.';
}

// Path: onboarding
class _Translations$onboarding$ko extends Translations$onboarding$tr {
	_Translations$onboarding$ko._(TranslationsKo root) : this._root = root, super.internal(root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get skip => '건너뛰기';
	@override String get page1Title => '있는 그대로, 익명으로.';
	@override String get page1Subtitle => '정체를 밝히지 않고 새로운 사람을 만나\n대화를 시작해 보세요.';
	@override String get page2Title => '문자. 통화. 분위기를 느껴봐요.';
	@override String get page2Subtitle => '익명으로 시작하고, 준비되면 문자, 통화, 영상으로 만나요.';
	@override String get page3Title => '나와 맞는 사람을 찾고\n대화에 참여하세요.';
	@override String get page3Subtitle => '룸에 들어가 새로운 사람을 만나고\n순간을 함께 나눠요.';
	@override String get getStarted => '시작하기';
	@override String get alreadyHaveAccount => '이미 Veylo 계정이 있나요? ';
	@override String get logInAction => '로그인';
}

// Path: createProfile
class _Translations$createProfile$ko extends Translations$createProfile$tr {
	_Translations$createProfile$ko._(TranslationsKo root) : this._root = root, super.internal(root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get navTitle => '프로필 만들기';
	@override String get stepUsername => '1/5 사용자 이름';
	@override String get title => '프로필을 만들어요';
	@override String get subtitle => '실명은 본인 확인에만 사용되며 공개되지 않아요.';
	@override String get subtitleLine1 => '실명은 본인 확인에만 사용되며';
	@override String get subtitleLine2 => '공개되지 않아요.';
	@override String get fullName => '실명';
	@override String get fullNameHint => 'Sam Lee';
	@override String get username => '사용자 이름';
	@override String get usernameHint => 'samlee123';
	@override String get usernameTaken => '이미 사용 중인 사용자 이름이에요!';
	@override String get usernameAvailable => '사용 가능한 이름이에요';
	@override String get mightWantToTry => '이런 이름은 어때요...';
	@override String get stepPhoto => '2/5 프로필 사진';
	@override String get photoTitle => '프로필 사진 올리기';
	@override String get photoSubtitle => '다른 사용자가 본인임을 확인할 수 있도록 프로필 사진이 표시돼요.';
	@override String get photoSubtitleLine1 => '다른 사용자가 본인임을 확인할 수 있도록';
	@override String get photoSubtitleLine2 => '프로필 사진이 표시돼요.';
	@override String get choosePhoto => '사진 선택';
	@override String get continueWithoutPhoto => '프로필 사진 없이 계속하기';
	@override String get saveAndContinue => '저장 후 계속';
	@override String get choosePhotoSheetTitle => '사진 선택';
	@override String get takePhoto => '사진 찍기';
	@override String get chooseFromGallery => '앨범에서 선택';
	@override String get stepGender => '3/5 성별';
	@override String get genderTitle => '성별을 선택하세요';
	@override String get genderSubtitle => '이 정보를 제공하시면 맞춤 콘텐츠를 보여드리는 데 사용할 수 있어요';
	@override String get genderSubtitleLine1 => '이 정보를 제공하시면 맞춤 콘텐츠를';
	@override String get genderSubtitleLine2 => '보여드리는 데 사용할 수 있어요';
	@override String get genderFemale => '여성';
	@override String get genderMale => '남성';
	@override String get genderNonBinary => '논바이너리';
	@override String get genderPreferNotToSay => '밝히고 싶지 않아요';
	@override String get stepInterests => '4/5 관심사';
	@override String get interestsTitle => '무엇을 좋아하세요?';
	@override String get interestsSubtitle => '5개 이상 골라주세요 — 나를 잘 이해하는 사람과 매칭하는 데 도움이 돼요.';
	@override late final _Translations$createProfile$interests$ko interests = _Translations$createProfile$interests$ko._(_root);
	@override String get stepChatGoal => '5/5 대화 목적';
	@override String get chatGoalTitle => '오늘은 무엇을 찾고 있나요?';
	@override String get chatGoalSubtitle => '지금 기분에 딱 맞는 상대를 찾는 데 도움이 돼요.';
	@override String get chatGoalQuickMatch => '빠른 매칭 — 바로 대화에\n뛰어들기';
	@override String get chatGoalFlirtyChat => '설레는 대화 — 가볍고 장난스러운\n대화';
	@override String get chatGoalMoodMatch => '기분 매칭 — 지금 기분에 맞는\n상대와 매칭';
	@override String get chatGoalLateNight => '심야 토크 — 모두가 잠든 밤의\n깊은 대화';
	@override String get chatGoalMeetSomeoneNew => '새로운 만남 — 특별한 목적 없이\n둘러보기';
	@override String get getStarted => '시작하기';
	@override String get preparingTitleLine1 => '나에게 딱 맞는';
	@override String get preparingTitleLine2 => '프로필을 준비하고';
	@override String get preparingTitleLine3 => '있어요.';
	@override String get preparingSubtitleLine1 => '답변을 바탕으로 최고의 상대를';
	@override String get preparingSubtitleLine2 => '고르고 있어요. 잠시만 기다려 주세요.';
	@override String preparingPercent({required Object percent}) => '${percent}%';
	@override String get usernameInvalid => '영문, 숫자, 마침표, 밑줄로 3–30자를 입력하세요.';
}

// Path: errors
class _Translations$errors$ko extends Translations$errors$tr {
	_Translations$errors$ko._(TranslationsKo root) : this._root = root, super.internal(root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get network => 'Veylo에 연결할 수 없어요. 네트워크를 확인하고 다시 시도해 주세요.';
	@override String get generic => '문제가 발생했어요. 다시 시도해 주세요.';
	@override String get signInFailed => '로그인에 실패했어요. 다시 시도해 주세요.';
	@override String get sessionExpired => '세션이 만료됐어요. 다시 로그인해 주세요.';
	@override String get accountSuspended => '이 계정은 정지됐어요.';
	@override String get unsupportedImage => 'JPEG, PNG 또는 WebP 사진을 선택해 주세요.';
	@override String get fileTooLarge => '파일이 너무 커요.';
	@override String get enterEmailForReset => '비밀번호를 재설정하려면 위에 이메일을 입력하세요.';
	@override String get wrongCredentials => '이메일/사용자 이름 또는 비밀번호가 올바르지 않아요.';
	@override String get emailInUse => '이미 가입된 이메일이에요. 로그인해 보세요.';
	@override String get weakPassword => '비밀번호는 6자 이상이어야 해요.';
	@override String get invalidEmail => '올바른 이메일 주소를 입력해 주세요.';
	@override String get tooManyAttempts => '시도 횟수가 너무 많아요. 잠시 후 다시 시도해 주세요.';
	@override String get fillAllFields => '모든 항목을 입력해 주세요.';
	@override String get insufficientTokens => '토큰이 부족해요.';
	@override String get requestNotAccepted => '답장하려면 요청을 수락하세요.';
	@override String get requestPendingLimit => '상대방이 요청을 수락하면 메시지를 더 보낼 수 있어요.';
	@override String get blocked => '이 사람에게 메시지를 보낼 수 없어요.';
	@override String get peerUnavailable => '더 이상 이용할 수 없는 계정이에요.';
	@override String get vibeDailyLimit => '오늘 Vibe를 많이 공유했어요. 나중에 다시 시도해 주세요.';
	@override String get groupFull => '그룹 인원이 가득 찼어요.';
	@override String get groupCreateLimit => '오늘 그룹을 너무 많이 만들었어요. 나중에 다시 시도해 주세요.';
	@override String get notFound => '더 이상 이용할 수 없어요.';
	@override String get recentLogin => '보안을 위해 로그아웃 후 다시 로그인한 다음 한 번 더 시도해 주세요.';
	@override String get socialAccount => '이메일과 비밀번호는 Google 또는 Apple 계정에서 관리돼요.';
	@override String get alreadyInCall => '이미 통화 중이에요.';
	@override String get roomPrivate => '비공개 룸이에요. 호스트에게 참여를 요청하세요.';
	@override String get roomFull => '룸 인원이 가득 찼어요.';
	@override String get alreadyCheckedIn => '오늘 보상은 이미 받았어요.';
	@override String get purchasesUnavailable => '지금은 구매할 수 없어요.';
}

// Path: faq
class _Translations$faq$ko extends Translations$faq$tr {
	_Translations$faq$ko._(TranslationsKo root) : this._root = root, super.internal(root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get q1 => '이 앱은 어떻게 작동하나요?';
	@override String get q2 => '익명 채팅이란 무엇인가요?';
	@override String get q3 => '연결 진행도란 무엇인가요?';
	@override String get q4 => '내 프로필은 어떻게 공개하나요?';
	@override String get q5 => '60초 낯선 사람이란 무엇인가요?';
	@override String get q6 => 'Vibes란 무엇인가요?';
	@override String get q7 => '프로필은 어떻게 편집하나요?';
	@override String get q8 => '알림은 어떻게 관리하나요?';
	@override String get q9 => '구매는 어떻게 복원하나요?';
	@override String get q10 => '모든 대화를 삭제할 수 있나요?';
	@override String get q11 => '내 데이터는 안전한가요?';
	@override String get q12 => '다른 사람을 차단하거나 신고하려면 어떻게 하나요?';
	@override String get q13 => '앱은 어떻게 공유하나요?';
	@override String get q14 => '계정은 어떻게 삭제하나요?';
	@override String get a1 => 'Veylo에서는 익명으로 새로운 사람을 만나 대화하고, 연결이 깊어질수록 프로필을 조금씩 공개할 수 있어요. 둘 다 준비되면 언제든 문자, 음성, 영상으로 전환하세요.';
	@override String get a2 => '익명 채팅에서는 신원과 사진이 숨겨져요. 연결이 높아질수록 이름 첫 글자와 흐린 사진 같은 정보가 공개돼요. 100%가 되면 두 사람 모두 동의해야 전체 프로필이 공개돼요.';
	@override String get a3 => '대화할수록 연결 비율이 올라가요. 특정 단계마다 이름 첫 글자, 흐린 사진, 전체 프로필이 공개돼요. 연결 배지를 탭하면 자세히 볼 수 있어요.';
	@override String get a4 => '연결이 100%가 되면 내 프로필 공개를 탭하세요. 상대방도 수락하면 두 사람의 전체 프로필이 공개돼요.';
	@override String get a5 => '통화 탭에서 짧은 무작위 매칭을 할 수 있어요. 시간이 끝나면 대화를 이어가거나 통화를 종료할 수 있어요.';
	@override String get a6 => 'Vibes에서는 지도/목록 화면으로 근처나 주변 사람들을 발견하고, 관심 있는 사람과 채팅을 시작할 수 있어요.';
	@override String get a7 => '프로필 탭에서 프로필 편집으로 이동해 이름, 사진, 소개, 관심사를 수정하세요. 저장하면 변경 사항이 반영돼요.';
	@override String get a8 => '설정의 알림에서 메시지, 매칭 등 알림을 켜거나 끌 수 있어요.';
	@override String get a9 => '설정 → 계정 관리 → 구매 복원으로 이동하세요. 같은 스토어 계정의 유효한 구매가 복원돼요.';
	@override String get a10 => '네. 설정 → 대화 삭제를 누르고 확인하세요. 모든 채팅이 삭제되며 되돌릴 수 없어요.';
	@override String get a11 => '계정 정보와 메시지는 보호된 시스템에 저장돼요. 계정 관리에서 언제든지 계정 및 데이터 삭제를 요청할 수도 있어요.';
	@override String get a12 => '프로필이나 채팅 화면의 메뉴에서 차단하거나 신고할 수 있어요. 신고는 저희 팀이 검토해요.';
	@override String get a13 => '설정의 앱 공유하기에서 링크를 복사해 친구에게 보내세요.';
	@override String get a14 => '설정 → 계정 관리 → 계정 및 데이터 삭제로 이동하세요. 이유를 작성한 뒤 확인하면 삭제 요청이 제출돼요.';
}

// Path: legal
class _Translations$legal$ko extends Translations$legal$tr {
	_Translations$legal$ko._(TranslationsKo root) : this._root = root, super.internal(root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get termsTitle => '서비스 약관';
	@override String get privacyTitle => '개인정보 처리방침';
	@override String get termsBody => '최종 업데이트: 2026년 3월 16일\n\nVeylo에 오신 것을 환영합니다. 계정을 만들거나 앱을 이용하면 본 서비스 약관에 동의하는 것으로 간주됩니다.\n\n1. Veylo란\nVeylo는 사람들을 만나고, 익명으로 대화하고, 시간을 두고 연결을 쌓으며, 양측이 동의하면 선택적으로 음성 또는 영상 통화로 전환할 수 있는 소셜 앱입니다.\n\n2. 계정\n정확한 정보를 제공하고 로그인 정보를 안전하게 관리해야 합니다. 계정에서 발생하는 활동에 대한 책임은 본인에게 있습니다. 거주 국가의 법률에 따라 Veylo를 이용할 수 있는 연령이어야 합니다.\n\n3. 존중하는 이용\n괴롭힘, 협박, 사기, 타인 사칭, 불법 콘텐츠 공유 또는 안전 기능 우회 시도를 해서는 안 됩니다. 이 규칙을 위반하는 경우 콘텐츠를 삭제하거나, 기능을 제한하거나, 계정을 정지할 수 있습니다.\n\n4. 익명 채팅 및 프로필 공개\n익명 채팅에서는 연결 단계에 도달할 때까지 이름과 사진이 숨겨질 수 있습니다. 전체 프로필 공개에는 상호 동의가 필요합니다. 다른 사람에게 신원 공개를 강요해서는 안 됩니다.\n\n5. 구매\n일부 기능은 유료일 수 있습니다. 구매는 Apple App Store 또는 Google Play를 통해 처리됩니다. 구매 복원은 동일한 스토어 계정의 유효한 구매 내역을 복구합니다. 환불은 각 스토어의 정책을 따릅니다.\n\n6. 공유하는 콘텐츠\n콘텐츠에 대한 권리는 본인에게 있지만, 서비스 운영에 필요한 범위에서 앱 내에 콘텐츠를 호스팅하고 표시할 수 있는 라이선스를 Veylo에 부여합니다. 공유할 권리가 없는 콘텐츠는 게시하지 마세요.\n\n7. 이용 종료\n언제든지 Veylo 이용을 중단하고 설정에서 계정 삭제를 요청할 수 있습니다. 필요한 경우 합리적인 사전 고지를 통해 서비스를 종료하거나 변경할 수도 있습니다.\n\n8. 문의\n본 약관에 관한 문의: support@veylo.app';
	@override String get privacyBody => '최종 업데이트: 2026년 3월 16일\n\n본 개인정보 처리방침은 Veylo가 귀하의 정보를 수집, 이용 및 보호하는 방법을 설명합니다.\n\n1. 수집하는 정보\n• 계정 데이터: 이메일, 표시 이름, 프로필 사진, 소개, 선호 설정\n• 이용 데이터: 채팅, 연결 진행도, 이용한 통화 기능, 기기/앱 기본 정보\n• 구매: 유료 기능을 잠금 해제하고 복원하는 데 필요한 스토어 영수증 데이터\n\n2. 이용 방법\n귀하의 데이터는 Veylo 운영, 매칭 및 채팅 경험의 개인화, 커뮤니티 안전 유지, 구매 처리, 제품 개선에 사용됩니다. 당사는 귀하의 개인정보를 판매하지 않습니다.\n\n3. 익명 모드\n익명 채팅에서는 공개 규칙과 상호 동의에 따라 더 많은 정보가 허용될 때까지 다른 사람이 볼 수 있는 정보(예: 가려진 이름 또는 흐린 사진)를 제한합니다. 다만 기능을 안전하게 운영하기 위해 내부적으로는 계정 식별자가 필요합니다.\n\n4. 공유\n호스팅, 분석 또는 결제 처리를 돕는 서비스 제공업체와 필요한 범위 내에서만 데이터를 공유할 수 있습니다. 또한 법률에 따라 요구되거나 사용자를 위험으로부터 보호하기 위해 정보를 공개할 수 있습니다.\n\n5. 보관\n계정이 활성 상태인 동안, 그리고 법적, 안전 및 결제 관련 사유로 필요한 기간 동안 데이터를 보관합니다. 삭제 요청이 완료되면 보관이 법적으로 요구되는 경우를 제외하고 개인정보를 삭제하거나 익명화합니다.\n\n6. 귀하의 선택\n프로필 정보 수정, 알림 관리, 계정 삭제 요청, 데이터 관련 문의를 할 수 있습니다. 스토어 구매는 Apple 또는 Google을 통해서도 관리됩니다.\n\n7. 보안\n귀하의 정보를 보호하기 위해 합리적인 기술적·관리적 조치를 취하고 있습니다. 완벽하게 안전한 시스템은 없으므로 강력한 비밀번호를 사용하고 기기를 최신 상태로 유지해 주세요.\n\n8. 문의\n개인정보 관련 문의: privacy@veylo.app';
}

// Path: logout
class _Translations$logout$ko extends Translations$logout$tr {
	_Translations$logout$ko._(TranslationsKo root) : this._root = root, super.internal(root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '로그아웃';
	@override String get subtitle => '정말 로그아웃할까요?';
	@override String get cancel => '취소';
	@override String get confirm => '로그아웃';
}

// Path: deleteAccount
class _Translations$deleteAccount$ko extends Translations$deleteAccount$tr {
	_Translations$deleteAccount$ko._(TranslationsKo root) : this._root = root, super.internal(root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '계정 삭제 요청하기';
	@override String get subtitle => '정말 계정을 삭제할까요?';
	@override String get reasonTitle => '떠나지 않길 바라지만, 이해해요.';
	@override String get reasonBefore => '';
	@override String get reasonAfter => ' 경험을 개선할 수 있도록 떠나시려는 이유를 알려주시겠어요?';
	@override String get reasonLabel => '계정을 삭제하려는 이유';
	@override String get reasonHint => '메시지를 입력하세요';
	@override String get cancel => '취소';
	@override String get createRequest => '요청하기';
	@override String get confirmTitle => '정말 삭제 요청을 제출할까요?';
	@override String get confirmSubtitle => '확인하면 계정 삭제 요청이 제출돼요';
	@override String get delete => '삭제';
}

// Path: storyText
class _Translations$storyText$ko extends Translations$storyText$tr {
	_Translations$storyText$ko._(TranslationsKo root) : this._root = root, super.internal(root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get bold => '굵게';
	@override String get italic => '기울임';
	@override String get uppercase => '대문자';
	@override String get underline => '밑줄';
	@override String get cancel => '취소';
	@override String get galleryError => '갤러리를 열 수 없어요';
}

// Path: tokens
class _Translations$tokens$ko extends Translations$tokens$tr {
	_Translations$tokens$ko._(TranslationsKo root) : this._root = root, super.internal(root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get boostTitle => 'Boost';
	@override String get history => '내역';
	@override String get yourBalance => '내 잔액';
	@override String balanceTokens({required Object count}) => '${count} 토큰';
	@override String get getMore => '토큰 더 받기';
	@override String get checkinTitle => '출석 체크';
	@override String checkinSubtitle({required Object max}) => '매일 연속으로 받고 하루 최대 ${max} 토큰을 받아요';
	@override String day({required Object n}) => '${n}일차';
	@override String collectDay({required Object n}) => '${n}일차 토큰 받기';
	@override String collectedToday({required Object n}) => '내일 다시 와서 ${n}일차를 받아요';
	@override String get duration30m => '30분';
	@override String get duration1h => '1시간';
	@override String get duration2h => '2시간';
	@override String visibility({required Object n}) => '노출 ${n}배';
	@override String boostFor({required Object count}) => '${count} 토큰으로 Boost';
	@override String boostActive({required Object time}) => '${time}까지 Boost 중';
	@override String get boostDone => '프로필이 Boost됐어요!';
	@override String get historyEmpty => '아직 토큰 내역이 없어요';
	@override String balanceLine({required Object count}) => '내 잔액 ${count} 토큰';
	@override String get reasonPurchase => '토큰 구매';
	@override String get reasonCheckin => '출석 체크';
	@override String get reasonWelcome => '가입 환영 보너스';
	@override String get reasonGenderFilter => '성별 필터 통화';
	@override String get reasonVideoCall => '영상 통화';
	@override String get reasonRoomCreate => '룸 만들기';
	@override String get reasonBorder => '프로필 테두리';
	@override String get reasonPostBoost => '게시물 Boost';
	@override String get reasonRefund => '환불';
	@override String get reasonAdjust => '잔액 조정';
	@override String get packsTitle => '토큰 더 받기';
	@override String get packsSubtitle => '토큰 패키지를 선택하세요';
	@override String packTokens({required Object count}) => '${count} 토큰';
	@override String get buy => '구매';
	@override String purchaseDone({required Object count}) => '잔액에 ${count} 토큰이 추가됐어요';
	@override String get notEnoughTitle => '토큰이 부족해요';
	@override String get notEnoughSubtitle => '계속하려면 잔액을 충전하세요.';
}

// Path: discover.aiMatch
class _Translations$discover$aiMatch$ko extends Translations$discover$aiMatch$tr {
	_Translations$discover$aiMatch$ko._(TranslationsKo root) : this._root = root, super.internal(root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get feelingTitle => '오늘 기분이 어때요?';
	@override String get feelingSubtitle => '선택에 따라 AI가 최고의 상대를 찾아줘요';
	@override String get lookingTitle => '무엇을 찾고 있나요?';
	@override String get moodSad => '슬퍼요';
	@override String get moodMeltie => '그저 그래요';
	@override String get moodBored => '심심해요';
	@override String get moodCrying => '우울해요';
	@override String get moodSmile => '행복해요';
	@override String get lookingNewFriends => '새 친구';
	@override String get lookingVenting => '하소연';
	@override String get lookingFlirty => '설레는 대화';
	@override String get lookingFun => '재미';
	@override String get lookingCultures => '새로운 문화';
	@override String get lookingLanguage => '언어 연습';
	@override String get statActiveUsers => '활성 사용자';
	@override String get statMatchRate => '매칭률';
	@override String get statAvgTime => '평균 시간';
	@override String get statActiveValue => '843';
	@override String get statMatchValue => '87%';
	@override String get statAvgValue => '8초';
	@override String get startSmartMatch => '스마트 매칭 시작';
	@override String get findingTitle => '상대를 찾는 중';
	@override String get findingSubtitle => '기분과 관심사에 맞는 사람을 찾고 있어요';
	@override String get findingStepMood => '기분 분석 완료';
	@override String get findingStepInterests => '관심사 매칭 완료';
	@override String get findingStepCompatibility => '궁합 계산 중...';
	@override String get findingStepContent => '콘텐츠 생성 중...';
	@override String findingOnline({required Object count}) => '지금 ${count}명이 온라인이에요';
	@override String get yourMatchTitle => '나의 매칭';
	@override String get yourMatchSubtitle => '답변을 바탕으로 매칭됐어요';
	@override String vibeMatch({required Object percent}) => 'Vibe 일치도 ${percent}%';
	@override String get startChatting => '채팅 시작';
	@override String matchNameAge({required Object name, required Object age}) => '${name}, ${age}';
	@override String get matchBio => '몰랐던 감정까지 느끼게 해줄게요.';
	@override String get swipePrevious => '이전';
	@override String get swipeNext => '다음';
	@override String get swipeFinger => '손가락으로 스와이프';
	@override String get noMatch => '지금은 맞는 상대가 없어요. 잠시 후 다시 시도해 주세요.';
}

// Path: discover.privateRoom
class _Translations$discover$privateRoom$ko extends Translations$discover$privateRoom$tr {
	_Translations$discover$privateRoom$ko._(TranslationsKo root) : this._root = root, super.internal(root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get subtitle => '비공개 룸이에요. 토큰으로 입장할 수 있어요.';
	@override String get roomAccess => '룸 입장';
	@override String get yourBalance => '내 잔액';
	@override String tokensAmount({required Object count}) => '${count} 토큰';
	@override String joinForTokens({required Object count}) => '${count} 토큰으로 참여';
	@override String get cancel => '취소';
}

// Path: discover.roomToken
class _Translations$discover$roomToken$ko extends Translations$discover$roomToken$tr {
	_Translations$discover$roomToken$ko._(TranslationsKo root) : this._root = root, super.internal(root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get subtitle => '토큰으로 입장할 수 있어요.';
	@override String get roomAccess => '룸 입장';
	@override String get yourBalance => '내 잔액';
	@override String tokensAmount({required Object count}) => '${count} 토큰';
	@override String joinForTokens({required Object count}) => '${count} 토큰으로 참여';
	@override String get cancel => '취소';
}

// Path: discover.privateRequest
class _Translations$discover$privateRequest$ko extends Translations$discover$privateRequest$tr {
	_Translations$discover$privateRequest$ko._(TranslationsKo root) : this._root = root, super.internal(root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '참여 요청';
	@override String roomInfo({required Object name, required Object count}) => '${name} · 멤버 ${count}명';
	@override String get messageHint => '한마디 남겨보세요 (선택)...';
	@override String get sendRequest => '요청 보내기';
	@override String get adminReview => '룸 관리자가 요청을 검토할 거예요';
}

// Path: discover.roomApproved
class _Translations$discover$roomApproved$ko extends Translations$discover$roomApproved$tr {
	_Translations$discover$roomApproved$ko._(TranslationsKo root) : this._root = root, super.internal(root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '입장 완료!';
	@override String subtitle({required Object name}) => '${name}에 자리가 마련됐어요';
	@override String get continueLabel => '계속';
}

// Path: discover.createSpace
class _Translations$discover$createSpace$ko extends Translations$discover$createSpace$tr {
	_Translations$discover$createSpace$ko._(TranslationsKo root) : this._root = root, super.internal(root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '룸 또는 그룹 만들기';
	@override String get subtitle => '그룹이나 라이브 룸을 만들어 더 많은 사람을 만나보세요';
	@override String get room => '룸';
	@override String get group => '그룹';
	@override String get hideAccount => '내 계정 숨기기';
	@override String get create => '만들기';
	@override String get cancel => '취소';
	@override String get createRoomTitle => '룸 만들기';
	@override String get createGroupTitle => '그룹 만들기';
	@override String get nameSubtitle => '만든 그룹의 이름을 정해주세요';
	@override String get nameHint => '올빼미족';
	@override String createRoomFor({required Object count}) => '${count} 토큰으로 만들기';
}

// Path: discover.liveRoom
class _Translations$discover$liveRoom$ko extends Translations$discover$liveRoom$tr {
	_Translations$discover$liveRoom$ko._(TranslationsKo root) : this._root = root, super.internal(root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get adminSuffix => '(관리자)';
	@override String get messageHint => '메시지';
	@override String get quickReplyHey => '안녕하세요, 여러분!';
	@override String get quickReplyTopic => '주제가 뭐예요?';
	@override String get quickReplyNew => '저 처음 왔어요!';
	@override String get sampleChatName => 'Sona';
	@override String get sampleChatBody => '뭐 할까요? 생각해 둔 거 있어요?';
	@override String get roomEnded => '룸이 종료됐어요.';
	@override String wantsToJoin({required Object name}) => '${name}님이 참여를 원해요';
	@override String get approve => '수락';
}

// Path: discover.groupChat
class _Translations$discover$groupChat$ko extends Translations$discover$groupChat$tr {
	_Translations$discover$groupChat$ko._(TranslationsKo root) : this._root = root, super.internal(root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String usersCount({required Object count}) => '사용자 ${count}명';
	@override String get sampleVictoria => '너무 심심해요. 우리 뭐라도 할까요?';
	@override String get sampleSona => '뭐 할까요? 생각해 둔 거 있어요?';
	@override String get sampleOwn => '부두에서 만나요';
}

// Path: discover.groupInfo
class _Translations$discover$groupInfo$ko extends Translations$discover$groupInfo$tr {
	_Translations$discover$groupInfo$ko._(TranslationsKo root) : this._root = root, super.internal(root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get media => '미디어';
	@override String get gallery => '갤러리';
	@override String get settings => '설정';
	@override String get notifications => '알림';
	@override String get blocked => '차단됨';
	@override String get private => '비공개';
	@override String membersCount({required Object count}) => '멤버 ${count}명';
	@override String get addPeople => '사람 추가';
	@override String get you => '나';
	@override String get admin => '관리자';
	@override String get leaveGroup => '그룹 나가기';
	@override String get requests => '참여 요청';
	@override String get approve => '수락';
	@override String get reject => '거절';
	@override String get addPeopleEmpty => '그룹에 추가하려면 먼저 팔로우하세요.';
	@override String get add => '추가';
	@override String get makeAdmin => '관리자로 지정';
	@override String get removeAdmin => '관리자 해제';
	@override String get remove => '그룹에서 내보내기';
	@override String get leaveConfirm => '이 그룹에서 나갈까요?';
	@override String get leave => '나가기';
	@override String get cancel => '취소';
}

// Path: discover.filters
class _Translations$discover$filters$ko extends Translations$discover$filters$tr {
	_Translations$discover$filters$ko._(TranslationsKo root) : this._root = root, super.internal(root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '필터';
	@override String get ageRange => '나이 범위';
	@override String ageRangeValue({required Object min, required Object max}) => '${min}-${max}';
	@override String get distance => '거리';
	@override String distanceValue({required Object km}) => '${km} km';
	@override String get showMe => '표시 대상';
	@override String get everyone => '모두';
	@override String get women => '여성';
	@override String get men => '남성';
	@override String get interests => '관심사';
	@override String get activeNow => '지금 활동 중';
	@override String get activeNowSubtitle => '지금 온라인인 사람만 보기';
	@override String get showResult => '결과 보기';
}

// Path: discover.post
class _Translations$discover$post$ko extends Translations$discover$post$tr {
	_Translations$discover$post$ko._(TranslationsKo root) : this._root = root, super.internal(root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get follow => '팔로우';
	@override String get following => '팔로잉';
	@override String get addComment => '댓글 달기...';
	@override String get commentsTitle => '댓글';
	@override String get sampleCaption => '멋진 하루 끝에 마시는 커피 한 잔만 한 게 없죠. <3';
	@override String hoursAgo({required Object hours}) => '${hours}시간';
	@override String minutesAgo({required Object minutes}) => '${minutes}분';
	@override String daysAgo({required Object days}) => '${days}일';
	@override String get deleteCommentTitle => '이 댓글을 삭제할까요?';
}

// Path: discover.story
class _Translations$discover$story$ko extends Translations$discover$story$tr {
	_Translations$discover$story$ko._(TranslationsKo root) : this._root = root, super.internal(root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get draft => '임시저장';
	@override String get story => '스토리';
	@override String get share => '공유';
	@override String get textPlaceholder => '텍스트 입력...';
	@override String get draftPrompt => '임시저장할까요?';
	@override String get saveToDraft => '임시저장';
	@override String get moveToTrash => '휴지통으로 이동';
	@override String get save => '저장';
	@override String get musicTitle => '음악';
	@override String get musicEmpty => '음악을 찾을 수 없어요.';
	@override String get musicError => '음악을 불러올 수 없어요.';
	@override String get downloaded => '갤러리에 저장됐어요';
	@override String get downloadFailed => '저장할 수 없어요';
}

// Path: discover.highlight
class _Translations$discover$highlight$ko extends Translations$discover$highlight$tr {
	_Translations$discover$highlight$ko._(TranslationsKo root) : this._root = root, super.internal(root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '하이라이트';
	@override String get view => '보기';
	@override String get aiComments => 'AI 댓글';
	@override String get remove => '하이라이트 삭제';
	@override String get sharedSuccess => '게시물이 공유됐어요';
	@override String get boost => '부스트';
}

// Path: discover.stats
class _Translations$discover$stats$ko extends Translations$discover$stats$tr {
	_Translations$discover$stats$ko._(TranslationsKo root) : this._root = root, super.internal(root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '통계';
	@override String get subtitle => '게시물 관련 통계는\n아래에 있어요.';
	@override String get viewers => '조회자';
	@override String get comments => '댓글';
	@override String get likes => '좋아요';
	@override String get boostCta => '1일 부스트 - 100 토큰';
	@override String get boosted => '부스트 완료! 24시간 동안 게시물이 상단에 노출돼요.';
}

// Path: createProfile.interests
class _Translations$createProfile$interests$ko extends Translations$createProfile$interests$tr {
	_Translations$createProfile$interests$ko._(TranslationsKo root) : this._root = root, super.internal(root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get music => '음악';
	@override String get movies => '영화';
	@override String get tvShows => 'TV 프로그램';
	@override String get reading => '독서';
	@override String get painting => '그림';
	@override String get photography => '사진';
	@override String get theatre => '연극';
	@override String get fitness => '피트니스';
	@override String get swimming => '수영';
	@override String get football => '축구';
	@override String get basketball => '농구';
	@override String get coffee => '커피';
	@override String get travel => '여행';
	@override String get camping => '캠핑';
	@override String get meditation => '명상';
	@override String get videoGames => '비디오 게임';
	@override String get boardGames => '보드게임';
	@override String get standUp => '스탠드업 코미디';
	@override String get tech => '테크';
	@override String get coding => '코딩';
	@override String get ai => 'AI';
	@override String get podcast => '팟캐스트';
}

/// The flat map containing all translations for locale <ko>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsKo {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.name' => 'Veylo',
			'app.tagline' => '환영해요',
			'home.title' => '홈',
			'home.subtitle' => '앱을 준비하고 있어요',
			'home.body' => '다국어 UI는 slang으로 관리돼요.',
			'chats.title' => '채팅',
			'chats.search' => '검색',
			'chats.messagesSection' => '메시지',
			'chats.request' => '요청',
			'chats.emptyRequestTitle' => '최근 메시지\n알림이 없어요',
			'chats.emptyRequestSubtitle' => '30일이 지난 요청은 표시되지 않아요.',
			'chats.noteAdd' => '노트 추가',
			'chats.anonymous' => '익명',
			'chats.online' => '온라인',
			'chats.offline' => '오프라인',
			'chats.connection' => '연결',
			'chats.connectionPercent' => ({required Object n}) => '${n}%',
			'chats.connectionProgressTitle' => '연결 진행도',
			'chats.milestoneInitial' => '이름 첫 글자',
			'chats.milestoneInitialHint' => '25%에서 공개됨',
			'chats.milestoneInitialLocked' => '25%에서 공개돼요',
			'chats.milestonePhoto' => '흐린 사진 미리보기',
			'chats.milestonePhotoHint' => '70%에서 공개돼요',
			'chats.milestoneFull' => '전체 프로필 보기',
			'chats.milestoneFullHint' => '100%에서 서로 동의 시',
			'chats.sampleAnonymousMessage' => '안녕하세요, 만나서 반가워요. 자기소개 조금 해주실래요?',
			'chats.strangerSampleMessage' => '안녕하세요 Jhon, 만나서 반가워요. 자기소개 조금 해주실래요?',
			'chats.approve' => '수락',
			'chats.blockUser' => '사용자 차단',
			'chats.reject' => '거절',
			'chats.messageHint' => '안녕! 잘 지내?',
			'chats.revealTitle' => '100%에 도달했어요',
			'chats.revealSubtitle' => '서로 전체 프로필을 공개할까요? 두 사람 모두 동의해야 해요.',
			'chats.revealWaiting' => ({required Object name}) => '${name}님의 수락을 기다리는 중',
			'chats.revealCta' => '내 프로필 공개',
			'chats.revealNotYet' => '아직이요',
			'chats.seen' => '읽음',
			'chats.typing' => '입력 중…',
			'chats.noteYou' => '나',
			'chats.noteSheetTitle' => '노트 공유',
			'chats.noteSheetSubtitle' => '노트는 24시간 동안 유지돼요',
			'chats.noteHint' => '무슨 생각 하고 있어요?',
			'chats.noteShare' => '공유',
			'chats.noteDelete' => '노트 삭제',
			'profile.eyebrow' => '프로필',
			'profile.title' => '설정',
			'profile.editProfile' => '프로필 편집',
			'profile.statLike' => '좋아요',
			'profile.statFollow' => '팔로우',
			'profile.statFollower' => '팔로워',
			'profile.promoTitle' => '더 많은 메시지를 받아보세요!',
			'profile.promoSubtitle' => '눈에 띄고, 목록 상단에 노출돼요',
			'profile.standOut' => '돋보이기',
			'profile.tabPosts' => '게시물',
			'profile.tabVideo' => '동영상',
			'profile.tabSaved' => '저장됨',
			'profile.save' => '저장',
			'profile.changePhoto' => '사진 변경',
			'profile.changeBorder' => '테두리 변경',
			'profile.interest' => '관심사',
			'profile.name' => '이름',
			'profile.changeName' => '이름 변경',
			'profile.changePassword' => '비밀번호 변경',
			'profile.confirmPassword' => '비밀번호 확인',
			'profile.email' => '이메일',
			'profile.accountManagement' => '계정 관리',
			'profile.settingsAbout' => '정보',
			'profile.settingsAccount' => '계정 설정',
			'profile.settingsSupport' => '지원',
			'profile.shareApp' => '앱 공유하기',
			'profile.shareAppTitle' => '친구와 공유하기',
			'profile.shareAppSubtitle' => '친구에게 Veylo를 공유하고 함께 발견해요!',
			'profile.shareAppLabel' => '앱 링크',
			'profile.rateApp' => '마음에 드셨나요? 평가해 주세요',
			'profile.notifications' => '알림',
			'profile.password' => '비밀번호',
			'profile.deleteConversation' => '대화 삭제',
			'profile.faqHelp' => 'FAQ 및 도움말',
			'profile.restorePurchases' => '구매 복원',
			'profile.termsOfService' => '서비스 약관',
			'profile.privacyPolicy' => '개인정보 처리방침',
			'profile.restorePurchasesDone' => '구매 내역을 확인했어요',
			'profile.conversationsDeleted' => '모든 대화가 삭제됐어요',
			'profile.logOut' => '로그아웃',
			'profile.deleteAccountAndData' => '계정 및 데이터 삭제',
			'profile.passwordPlaceholder' => '********',
			'profile.height' => '키',
			'profile.addHeight' => '키 추가',
			'profile.heightCm' => ({required Object value}) => '${value} cm',
			'profile.languages' => '언어',
			'profile.relationshipGoals' => '관계 목표',
			'profile.lookingFor' => '찾는 관계',
			'profile.newFriends' => '👋 새 친구',
			'profile.goalLongTermOpenToShort' => '💕 장기적, 단기도 괜찮아요',
			'profile.goalLongTermRelationship' => '💘 장기적인 관계',
			'profile.goalNewFriends' => '👋 새 친구',
			'profile.goalShortTermFun' => '🥃 가벼운 만남',
			'profile.goalStillFiguringItOut' => '🤔 아직 생각 중',
			'profile.basics' => '기본 정보',
			'profile.zodiac' => '별자리',
			'profile.zodiacValue' => '전갈자리',
			'profile.education' => '학력',
			'profile.educationValue' => '학사',
			'profile.educationHighSchool' => '고등학교',
			'profile.educationAssociates' => '전문학사',
			'profile.educationBachelors' => '학사',
			'profile.educationMasters' => '석사',
			'profile.educationPhd' => '박사',
			'profile.voiceRecord' => '음성 녹음',
			'profile.addVoice' => '음성 추가',
			'profile.lifestyle' => '라이프스타일',
			'profile.pets' => '반려동물',
			'profile.petsValue' => '고양이를 키워요',
			'profile.petsDontWant' => '반려동물은 원하지 않아요',
			'profile.petsAllergic' => '반려동물 알레르기가 있어요',
			'profile.petsHaveCat' => '고양이를 키워요',
			'profile.petsHaveDog' => '강아지를 키워요',
			'profile.petsHaveCatsAndDogs' => '고양이와 강아지를 키워요',
			'profile.petsHaveOther' => '다른 반려동물을 키워요',
			'profile.drinking' => '음주',
			'profile.drinkingValue' => '특별한 날에만',
			'profile.drinkingNever' => '안 마셔요',
			'profile.drinkingSpecialOccasions' => '특별한 날에만',
			'profile.drinkingSocially' => '모임에서만',
			'profile.drinkingFrequently' => '자주',
			'profile.drinkingSober' => '금주 중',
			'profile.drinkingPreferNotToSay' => '밝히고 싶지 않아요',
			'profile.smoking' => '흡연',
			'profile.smokingValue' => '비흡연',
			'profile.smokingNonSmoker' => '비흡연',
			'profile.smokingSocialSmoker' => '가끔 흡연',
			'profile.smokingSmoker' => '흡연',
			'profile.smokingTryingToQuit' => '금연 중',
			'profile.smokingWhenDrinking' => '술 마실 때만 흡연',
			'profile.smokingPreferNotToSay' => '밝히고 싶지 않아요',
			'profile.gender' => '성별',
			'profile.genderFemale' => '여성',
			'profile.genderMale' => '남성',
			'profile.genderPreferNotToSay' => '밝히고 싶지 않아요',
			'profile.visible' => '공개',
			'profile.profileVisibility' => '프로필 공개 설정',
			'profile.language' => '언어',
			'profile.borderTitle' => '프로필 테두리',
			'profile.borderSubtitle' => '프로필에 테두리를 추가해서\n돋보여 보세요.',
			'profile.borderBuySection' => '테두리 구매',
			'profile.borderBuyCta' => '테두리 구매',
			'profile.borderToken' => ({required Object count}) => '${count} 토큰',
			'profile.borderAmethystWings' => 'Amethyst Wings',
			'profile.borderGoldenPhoenix' => 'Golden Phoenix',
			'profile.borderFrostCrown' => 'Frost Crown',
			'profile.borderEmeraldWhisper' => 'Emerald Whisper',
			'profile.borderRoseQuartz' => 'Rose Quartz',
			'profile.borderStarlitComet' => 'Starlit Comet',
			'profile.borderCrimsonRoyal' => 'Crimson Royal',
			'profile.borderSapphireHalo' => 'Sapphire Halo',
			'profile.follow' => '팔로우',
			'profile.following' => '팔로잉',
			'profile.followPageTitle' => '팔로우',
			'profile.followTabFollowing' => '팔로잉',
			'profile.followTabFollowers' => '팔로워',
			'profile.followSearch' => '검색',
			'profile.unfollow' => '언팔로우',
			'profile.followSortTitle' => '정렬',
			'profile.followSortRecent' => '최근에 팔로우한 사람',
			'profile.followSortNotFollowingMe' => '나를 맞팔하지 않은 사람',
			'profile.followSortNotFollowedByMe' => '내가 맞팔하지 않은 사람',
			'profile.followSortShowResult' => '결과 보기',
			'profile.followSortEmpty' => '이 필터에 맞는 사용자가 없어요',
			'profile.shareTitle' => '친구와 공유하기',
			'profile.shareSubtitle' => '친구와 연결하면\n모든 게 더 즐거워요!',
			'profile.shareProfileLabel' => '프로필 공유',
			'profile.shareLinkCopied' => '링크가 복사됐어요',
			'profile.restrict' => '제한',
			'profile.block' => '차단',
			'profile.report' => '신고',
			'profile.blockTitle' => ({required Object username}) => '${username}님을 차단할까요?',
			'profile.blockBody' => '이 사용자가 가지고 있거나 앞으로 만들 다른 계정도 함께 차단돼요. 언제든지 차단을 해제할 수 있어요.',
			'profile.blockAndReport' => '차단 및 신고',
			'profile.restrictTitle' => ({required Object username}) => '${username}님을 제한할까요?',
			'profile.restrictBody' => '상대방은 내가 온라인인지, 메시지를 읽었는지 알 수 없어요. 언제든지 변경할 수 있어요.',
			'profile.restrictAndReport' => '제한 및 신고',
			'profile.reportTitle' => '이유를 알려주세요',
			'profile.reportSubtitle' => '더 나은 경험을 위해, 이 사용자를 신고하려는 이유를 알려주시겠어요?',
			'profile.reportMessageLabel' => '신고 내용',
			'profile.reportMessageHint' => '메시지를 입력하세요',
			'profile.reportCancel' => '취소',
			'profile.sendReport' => '신고하기',
			'profile.notSet' => '설정 안 됨',
			'profile.reportSent' => '감사합니다. 신고가 접수됐어요.',
			'profile.emailVerificationSent' => ({required Object email}) => '${email}(으)로 확인 링크를 보냈어요. 확인 후 이메일이 변경돼요.',
			'profile.passwordChanged' => '비밀번호가 변경됐어요.',
			'profile.passwordMismatch' => '비밀번호가 일치하지 않아요.',
			'nav.discover' => '탐색',
			'nav.chat' => '채팅',
			'nav.call' => '통화',
			'nav.vibes' => 'Vibes',
			'nav.profile' => '프로필',
			'call.title' => '60초 낯선 사람',
			'call.subtitle' => '무작위 낯선 사람과 60초 동안 대화해요 — 완전히 익명으로. 프로필도, 사진도, 이름도 없어요. 오직 목소리와 한순간뿐.',
			'call.findingTitle' => '낯선 사람을 찾는 중...',
			'call.findingSubtitle' => '60초 동안 익명으로 대화해요. 프로필도, 이름도 없어요.',
			'call.callStranger' => '낯선 사람에게 전화 - 10 토큰',
			'call.cancel' => '취소',
			'call.female' => '여성',
			'call.male' => '남성',
			'call.nonBinary' => '논바이너리',
			'call.preferNotToSay' => '밝히고 싶지 않아요',
			'call.anonymousBadge' => '🎙️ 익명 음성 통화',
			'call.stranger' => '낯선 사람',
			'call.secondsLeft' => ({required Object n}) => '${n}초',
			'call.timesUpTitle' => '시간 종료!',
			'call.timesUpSubtitle' => '계속 대화할래요? 둘 다 동의하면 채팅이 열려요.',
			'call.keepTalking' => '계속 대화하기',
			'call.endCall' => '통화 종료',
			'call.waitingOther' => '상대방을 기다리는 중...',
			'call.callStrangerFree' => '낯선 사람에게 전화',
			'call.peerLeft' => '상대방이 통화를 종료했어요.',
			'call.noKeep' => '이번에는 채팅이 열리지 않았어요.',
			'call.videoWaiting' => '상대방이 영상 통화를 수락하길 기다리는 중...',
			'call.videoDeclined' => '상대방이 영상 통화를 거절했어요.',
			'call.micDenied' => '통화하려면 마이크 권한이 필요해요. 설정에서 켤 수 있어요.',
			'call.videoCost' => '영상 통화: 15분당 20 토큰',
			'call.calling' => '전화 거는 중',
			'call.accept' => '수락',
			'call.decline' => '거절',
			'call.switchToVideo' => '영상 통화로 전환할까요?',
			'call.noMatchTitle' => '지금은 대화할 수 있는 사람이 없어요',
			'call.noMatchBody' => '지금은 대화 상대를 찾지 못했어요. 잠시 후에 다시 시도해 주세요.',
			'call.noMatchOk' => '확인',
			'vibes.search' => '검색',
			'vibes.sendMessage' => '메시지 보내기',
			'vibes.wantsToTalk' => '지금 바로 이 얘기를 하고 싶어해요',
			'vibes.shareTitle' => 'Vibe 공유',
			'vibes.replyTitle' => 'Vibe에 답장',
			'vibes.shareHint' => '무언가 적어보세요',
			'vibes.shareAnonymous' => '익명으로 공유',
			'vibes.empty' => '최근 24시간 동안 Vibe가 없어요. 첫 Vibe를 공유해 보세요!',
			'vibes.deleteTitle' => '이 Vibe를 삭제할까요?',
			'vibes.delete' => '삭제',
			'vibes.cancel' => '취소',
			'discover.title' => '탐색',
			'discover.tabRooms' => '룸',
			'discover.tabDiscover' => '탐색',
			'discover.tabAiMatch' => 'AI Match',
			'discover.aiMatch.feelingTitle' => '오늘 기분이 어때요?',
			'discover.aiMatch.feelingSubtitle' => '선택에 따라 AI가 최고의 상대를 찾아줘요',
			'discover.aiMatch.lookingTitle' => '무엇을 찾고 있나요?',
			'discover.aiMatch.moodSad' => '슬퍼요',
			'discover.aiMatch.moodMeltie' => '그저 그래요',
			'discover.aiMatch.moodBored' => '심심해요',
			'discover.aiMatch.moodCrying' => '우울해요',
			'discover.aiMatch.moodSmile' => '행복해요',
			'discover.aiMatch.lookingNewFriends' => '새 친구',
			'discover.aiMatch.lookingVenting' => '하소연',
			'discover.aiMatch.lookingFlirty' => '설레는 대화',
			'discover.aiMatch.lookingFun' => '재미',
			'discover.aiMatch.lookingCultures' => '새로운 문화',
			'discover.aiMatch.lookingLanguage' => '언어 연습',
			'discover.aiMatch.statActiveUsers' => '활성 사용자',
			'discover.aiMatch.statMatchRate' => '매칭률',
			'discover.aiMatch.statAvgTime' => '평균 시간',
			'discover.aiMatch.statActiveValue' => '843',
			'discover.aiMatch.statMatchValue' => '87%',
			'discover.aiMatch.statAvgValue' => '8초',
			'discover.aiMatch.startSmartMatch' => '스마트 매칭 시작',
			'discover.aiMatch.findingTitle' => '상대를 찾는 중',
			'discover.aiMatch.findingSubtitle' => '기분과 관심사에 맞는 사람을 찾고 있어요',
			'discover.aiMatch.findingStepMood' => '기분 분석 완료',
			'discover.aiMatch.findingStepInterests' => '관심사 매칭 완료',
			'discover.aiMatch.findingStepCompatibility' => '궁합 계산 중...',
			'discover.aiMatch.findingStepContent' => '콘텐츠 생성 중...',
			'discover.aiMatch.findingOnline' => ({required Object count}) => '지금 ${count}명이 온라인이에요',
			'discover.aiMatch.yourMatchTitle' => '나의 매칭',
			'discover.aiMatch.yourMatchSubtitle' => '답변을 바탕으로 매칭됐어요',
			'discover.aiMatch.vibeMatch' => ({required Object percent}) => 'Vibe 일치도 ${percent}%',
			'discover.aiMatch.startChatting' => '채팅 시작',
			'discover.aiMatch.matchNameAge' => ({required Object name, required Object age}) => '${name}, ${age}',
			'discover.aiMatch.matchBio' => '몰랐던 감정까지 느끼게 해줄게요.',
			'discover.aiMatch.swipePrevious' => '이전',
			'discover.aiMatch.swipeNext' => '다음',
			'discover.aiMatch.swipeFinger' => '손가락으로 스와이프',
			'discover.aiMatch.noMatch' => '지금은 맞는 상대가 없어요. 잠시 후 다시 시도해 주세요.',
			'discover.searchHint' => '검색',
			'discover.allRooms' => '전체 룸',
			'discover.allGroups' => '전체 그룹',
			'discover.seeAll' => '모두 보기',
			'discover.live' => '라이브',
			'discover.join' => '참여',
			'discover.request' => '요청',
			'discover.requested' => '요청됨',
			'discover.private' => '비공개',
			'discover.moreCount' => ({required Object count}) => '+${count}명 더',
			'discover.activeCount' => ({required Object count}) => '${count}명 활동 중',
			'discover.membersCount' => ({required Object count}) => '멤버 ${count}명',
			'discover.privateRoom.subtitle' => '비공개 룸이에요. 토큰으로 입장할 수 있어요.',
			'discover.privateRoom.roomAccess' => '룸 입장',
			'discover.privateRoom.yourBalance' => '내 잔액',
			'discover.privateRoom.tokensAmount' => ({required Object count}) => '${count} 토큰',
			'discover.privateRoom.joinForTokens' => ({required Object count}) => '${count} 토큰으로 참여',
			'discover.privateRoom.cancel' => '취소',
			'discover.roomToken.subtitle' => '토큰으로 입장할 수 있어요.',
			'discover.roomToken.roomAccess' => '룸 입장',
			'discover.roomToken.yourBalance' => '내 잔액',
			'discover.roomToken.tokensAmount' => ({required Object count}) => '${count} 토큰',
			'discover.roomToken.joinForTokens' => ({required Object count}) => '${count} 토큰으로 참여',
			'discover.roomToken.cancel' => '취소',
			'discover.privateRequest.title' => '참여 요청',
			'discover.privateRequest.roomInfo' => ({required Object name, required Object count}) => '${name} · 멤버 ${count}명',
			'discover.privateRequest.messageHint' => '한마디 남겨보세요 (선택)...',
			'discover.privateRequest.sendRequest' => '요청 보내기',
			'discover.privateRequest.adminReview' => '룸 관리자가 요청을 검토할 거예요',
			'discover.roomApproved.title' => '입장 완료!',
			'discover.roomApproved.subtitle' => ({required Object name}) => '${name}에 자리가 마련됐어요',
			'discover.roomApproved.continueLabel' => '계속',
			'discover.createSpace.title' => '룸 또는 그룹 만들기',
			'discover.createSpace.subtitle' => '그룹이나 라이브 룸을 만들어 더 많은 사람을 만나보세요',
			'discover.createSpace.room' => '룸',
			'discover.createSpace.group' => '그룹',
			'discover.createSpace.hideAccount' => '내 계정 숨기기',
			'discover.createSpace.create' => '만들기',
			'discover.createSpace.cancel' => '취소',
			'discover.createSpace.createRoomTitle' => '룸 만들기',
			'discover.createSpace.createGroupTitle' => '그룹 만들기',
			'discover.createSpace.nameSubtitle' => '만든 그룹의 이름을 정해주세요',
			'discover.createSpace.nameHint' => '올빼미족',
			'discover.createSpace.createRoomFor' => ({required Object count}) => '${count} 토큰으로 만들기',
			'discover.liveRoom.adminSuffix' => '(관리자)',
			'discover.liveRoom.messageHint' => '메시지',
			'discover.liveRoom.quickReplyHey' => '안녕하세요, 여러분!',
			'discover.liveRoom.quickReplyTopic' => '주제가 뭐예요?',
			'discover.liveRoom.quickReplyNew' => '저 처음 왔어요!',
			'discover.liveRoom.sampleChatName' => 'Sona',
			'discover.liveRoom.sampleChatBody' => '뭐 할까요? 생각해 둔 거 있어요?',
			'discover.liveRoom.roomEnded' => '룸이 종료됐어요.',
			'discover.liveRoom.wantsToJoin' => ({required Object name}) => '${name}님이 참여를 원해요',
			'discover.liveRoom.approve' => '수락',
			'discover.groupChat.usersCount' => ({required Object count}) => '사용자 ${count}명',
			'discover.groupChat.sampleVictoria' => '너무 심심해요. 우리 뭐라도 할까요?',
			'discover.groupChat.sampleSona' => '뭐 할까요? 생각해 둔 거 있어요?',
			'discover.groupChat.sampleOwn' => '부두에서 만나요',
			'discover.groupInfo.media' => '미디어',
			'discover.groupInfo.gallery' => '갤러리',
			'discover.groupInfo.settings' => '설정',
			'discover.groupInfo.notifications' => '알림',
			'discover.groupInfo.blocked' => '차단됨',
			'discover.groupInfo.private' => '비공개',
			'discover.groupInfo.membersCount' => ({required Object count}) => '멤버 ${count}명',
			'discover.groupInfo.addPeople' => '사람 추가',
			'discover.groupInfo.you' => '나',
			'discover.groupInfo.admin' => '관리자',
			'discover.groupInfo.leaveGroup' => '그룹 나가기',
			'discover.groupInfo.requests' => '참여 요청',
			'discover.groupInfo.approve' => '수락',
			'discover.groupInfo.reject' => '거절',
			'discover.groupInfo.addPeopleEmpty' => '그룹에 추가하려면 먼저 팔로우하세요.',
			'discover.groupInfo.add' => '추가',
			'discover.groupInfo.makeAdmin' => '관리자로 지정',
			'discover.groupInfo.removeAdmin' => '관리자 해제',
			'discover.groupInfo.remove' => '그룹에서 내보내기',
			'discover.groupInfo.leaveConfirm' => '이 그룹에서 나갈까요?',
			'discover.groupInfo.leave' => '나가기',
			'discover.groupInfo.cancel' => '취소',
			'discover.filters.title' => '필터',
			'discover.filters.ageRange' => '나이 범위',
			'discover.filters.ageRangeValue' => ({required Object min, required Object max}) => '${min}-${max}',
			'discover.filters.distance' => '거리',
			'discover.filters.distanceValue' => ({required Object km}) => '${km} km',
			'discover.filters.showMe' => '표시 대상',
			'discover.filters.everyone' => '모두',
			'discover.filters.women' => '여성',
			'discover.filters.men' => '남성',
			'discover.filters.interests' => '관심사',
			'discover.filters.activeNow' => '지금 활동 중',
			'discover.filters.activeNowSubtitle' => '지금 온라인인 사람만 보기',
			'discover.filters.showResult' => '결과 보기',
			'discover.post.follow' => '팔로우',
			'discover.post.following' => '팔로잉',
			'discover.post.addComment' => '댓글 달기...',
			'discover.post.commentsTitle' => '댓글',
			'discover.post.sampleCaption' => '멋진 하루 끝에 마시는 커피 한 잔만 한 게 없죠. <3',
			'discover.post.hoursAgo' => ({required Object hours}) => '${hours}시간',
			'discover.post.minutesAgo' => ({required Object minutes}) => '${minutes}분',
			'discover.post.daysAgo' => ({required Object days}) => '${days}일',
			'discover.post.deleteCommentTitle' => '이 댓글을 삭제할까요?',
			'discover.story.draft' => '임시저장',
			'discover.story.story' => '스토리',
			'discover.story.share' => '공유',
			'discover.story.textPlaceholder' => '텍스트 입력...',
			'discover.story.draftPrompt' => '임시저장할까요?',
			'discover.story.saveToDraft' => '임시저장',
			'discover.story.moveToTrash' => '휴지통으로 이동',
			'discover.story.save' => '저장',
			'discover.story.musicTitle' => '음악',
			'discover.story.musicEmpty' => '음악을 찾을 수 없어요.',
			'discover.story.musicError' => '음악을 불러올 수 없어요.',
			'discover.story.downloaded' => '갤러리에 저장됐어요',
			'discover.story.downloadFailed' => '저장할 수 없어요',
			'discover.highlight.title' => '하이라이트',
			'discover.highlight.view' => '보기',
			'discover.highlight.aiComments' => 'AI 댓글',
			'discover.highlight.remove' => '하이라이트 삭제',
			'discover.highlight.sharedSuccess' => '게시물이 공유됐어요',
			'discover.highlight.boost' => '부스트',
			'discover.stats.title' => '통계',
			'discover.stats.subtitle' => '게시물 관련 통계는\n아래에 있어요.',
			'discover.stats.viewers' => '조회자',
			'discover.stats.comments' => '댓글',
			'discover.stats.likes' => '좋아요',
			'discover.stats.boostCta' => '1일 부스트 - 100 토큰',
			'discover.stats.boosted' => '부스트 완료! 24시간 동안 게시물이 상단에 노출돼요.',
			'discover.hostedBy' => ({required Object name}) => '호스트: ${name}',
			'common.loading' => '불러오는 중…',
			'common.retry' => '다시 시도',
			'common.cancel' => '취소',
			'common.save' => '저장',
			'common.continueAction' => '계속',
			'common.language' => '언어',
			'common.or' => '또는',
			'languages.tr' => 'Türkçe',
			'languages.en' => 'English',
			'auth.createAccountTitle' => '계정 만들기',
			'auth.createAccountSubtitle' => 'Veylo에 가입하고 새로운 인연을 시작하세요.',
			'auth.welcomeBackTitle' => '다시 오신 걸 환영해요',
			'auth.welcomeBackSubtitle' => '로그인하고 Veylo를 계속 이용하세요.',
			'auth.username' => '사용자 이름',
			'auth.usernameHint' => '사용자 이름을 정하세요',
			'auth.email' => '이메일',
			'auth.emailHint' => '이메일을 입력하세요',
			'auth.emailOrUsername' => '이메일 또는 사용자 이름',
			'auth.emailOrUsernameHint' => '이메일 또는 사용자 이름 입력',
			'auth.password' => '비밀번호',
			'auth.passwordCreateHint' => '비밀번호를 만드세요',
			'auth.passwordEnterHint' => '비밀번호를 입력하세요',
			'auth.signUp' => '가입하기',
			'auth.logIn' => '로그인',
			'auth.forgotPassword' => '비밀번호를 잊으셨나요?',
			'auth.continueWithApple' => 'Apple로 계속하기',
			'auth.continueWithGoogle' => 'Google로 계속하기',
			'auth.legalPrefix' => '계속하면 ',
			'auth.termsOfService' => '서비스 약관',
			'auth.legalMiddle' => '에 동의하고 ',
			'auth.privacyPolicy' => '개인정보 처리방침',
			'auth.legalSuffix' => '을 확인한 것으로 간주돼요.',
			'auth.passwordResetSent' => '이메일로 비밀번호 재설정 링크를 보냈어요.',
			'onboarding.skip' => '건너뛰기',
			'onboarding.page1Title' => '있는 그대로, 익명으로.',
			'onboarding.page1Subtitle' => '정체를 밝히지 않고 새로운 사람을 만나\n대화를 시작해 보세요.',
			'onboarding.page2Title' => '문자. 통화. 분위기를 느껴봐요.',
			'onboarding.page2Subtitle' => '익명으로 시작하고, 준비되면 문자, 통화, 영상으로 만나요.',
			'onboarding.page3Title' => '나와 맞는 사람을 찾고\n대화에 참여하세요.',
			'onboarding.page3Subtitle' => '룸에 들어가 새로운 사람을 만나고\n순간을 함께 나눠요.',
			'onboarding.getStarted' => '시작하기',
			'onboarding.alreadyHaveAccount' => '이미 Veylo 계정이 있나요? ',
			'onboarding.logInAction' => '로그인',
			'createProfile.navTitle' => '프로필 만들기',
			'createProfile.stepUsername' => '1/5 사용자 이름',
			'createProfile.title' => '프로필을 만들어요',
			'createProfile.subtitle' => '실명은 본인 확인에만 사용되며 공개되지 않아요.',
			'createProfile.subtitleLine1' => '실명은 본인 확인에만 사용되며',
			'createProfile.subtitleLine2' => '공개되지 않아요.',
			'createProfile.fullName' => '실명',
			'createProfile.fullNameHint' => 'Sam Lee',
			'createProfile.username' => '사용자 이름',
			'createProfile.usernameHint' => 'samlee123',
			'createProfile.usernameTaken' => '이미 사용 중인 사용자 이름이에요!',
			'createProfile.usernameAvailable' => '사용 가능한 이름이에요',
			'createProfile.mightWantToTry' => '이런 이름은 어때요...',
			'createProfile.stepPhoto' => '2/5 프로필 사진',
			'createProfile.photoTitle' => '프로필 사진 올리기',
			'createProfile.photoSubtitle' => '다른 사용자가 본인임을 확인할 수 있도록 프로필 사진이 표시돼요.',
			'createProfile.photoSubtitleLine1' => '다른 사용자가 본인임을 확인할 수 있도록',
			'createProfile.photoSubtitleLine2' => '프로필 사진이 표시돼요.',
			'createProfile.choosePhoto' => '사진 선택',
			'createProfile.continueWithoutPhoto' => '프로필 사진 없이 계속하기',
			'createProfile.saveAndContinue' => '저장 후 계속',
			'createProfile.choosePhotoSheetTitle' => '사진 선택',
			'createProfile.takePhoto' => '사진 찍기',
			'createProfile.chooseFromGallery' => '앨범에서 선택',
			'createProfile.stepGender' => '3/5 성별',
			'createProfile.genderTitle' => '성별을 선택하세요',
			'createProfile.genderSubtitle' => '이 정보를 제공하시면 맞춤 콘텐츠를 보여드리는 데 사용할 수 있어요',
			'createProfile.genderSubtitleLine1' => '이 정보를 제공하시면 맞춤 콘텐츠를',
			'createProfile.genderSubtitleLine2' => '보여드리는 데 사용할 수 있어요',
			'createProfile.genderFemale' => '여성',
			'createProfile.genderMale' => '남성',
			'createProfile.genderNonBinary' => '논바이너리',
			'createProfile.genderPreferNotToSay' => '밝히고 싶지 않아요',
			'createProfile.stepInterests' => '4/5 관심사',
			'createProfile.interestsTitle' => '무엇을 좋아하세요?',
			'createProfile.interestsSubtitle' => '5개 이상 골라주세요 — 나를 잘 이해하는 사람과 매칭하는 데 도움이 돼요.',
			'createProfile.interests.music' => '음악',
			'createProfile.interests.movies' => '영화',
			'createProfile.interests.tvShows' => 'TV 프로그램',
			'createProfile.interests.reading' => '독서',
			'createProfile.interests.painting' => '그림',
			'createProfile.interests.photography' => '사진',
			'createProfile.interests.theatre' => '연극',
			'createProfile.interests.fitness' => '피트니스',
			'createProfile.interests.swimming' => '수영',
			'createProfile.interests.football' => '축구',
			'createProfile.interests.basketball' => '농구',
			'createProfile.interests.coffee' => '커피',
			'createProfile.interests.travel' => '여행',
			'createProfile.interests.camping' => '캠핑',
			'createProfile.interests.meditation' => '명상',
			'createProfile.interests.videoGames' => '비디오 게임',
			'createProfile.interests.boardGames' => '보드게임',
			'createProfile.interests.standUp' => '스탠드업 코미디',
			'createProfile.interests.tech' => '테크',
			'createProfile.interests.coding' => '코딩',
			'createProfile.interests.ai' => 'AI',
			'createProfile.interests.podcast' => '팟캐스트',
			_ => null,
		} ?? switch (path) {
			'createProfile.stepChatGoal' => '5/5 대화 목적',
			'createProfile.chatGoalTitle' => '오늘은 무엇을 찾고 있나요?',
			'createProfile.chatGoalSubtitle' => '지금 기분에 딱 맞는 상대를 찾는 데 도움이 돼요.',
			'createProfile.chatGoalQuickMatch' => '빠른 매칭 — 바로 대화에\n뛰어들기',
			'createProfile.chatGoalFlirtyChat' => '설레는 대화 — 가볍고 장난스러운\n대화',
			'createProfile.chatGoalMoodMatch' => '기분 매칭 — 지금 기분에 맞는\n상대와 매칭',
			'createProfile.chatGoalLateNight' => '심야 토크 — 모두가 잠든 밤의\n깊은 대화',
			'createProfile.chatGoalMeetSomeoneNew' => '새로운 만남 — 특별한 목적 없이\n둘러보기',
			'createProfile.getStarted' => '시작하기',
			'createProfile.preparingTitleLine1' => '나에게 딱 맞는',
			'createProfile.preparingTitleLine2' => '프로필을 준비하고',
			'createProfile.preparingTitleLine3' => '있어요.',
			'createProfile.preparingSubtitleLine1' => '답변을 바탕으로 최고의 상대를',
			'createProfile.preparingSubtitleLine2' => '고르고 있어요. 잠시만 기다려 주세요.',
			'createProfile.preparingPercent' => ({required Object percent}) => '${percent}%',
			'createProfile.usernameInvalid' => '영문, 숫자, 마침표, 밑줄로 3–30자를 입력하세요.',
			'errors.network' => 'Veylo에 연결할 수 없어요. 네트워크를 확인하고 다시 시도해 주세요.',
			'errors.generic' => '문제가 발생했어요. 다시 시도해 주세요.',
			'errors.signInFailed' => '로그인에 실패했어요. 다시 시도해 주세요.',
			'errors.sessionExpired' => '세션이 만료됐어요. 다시 로그인해 주세요.',
			'errors.accountSuspended' => '이 계정은 정지됐어요.',
			'errors.unsupportedImage' => 'JPEG, PNG 또는 WebP 사진을 선택해 주세요.',
			'errors.fileTooLarge' => '파일이 너무 커요.',
			'errors.enterEmailForReset' => '비밀번호를 재설정하려면 위에 이메일을 입력하세요.',
			'errors.wrongCredentials' => '이메일/사용자 이름 또는 비밀번호가 올바르지 않아요.',
			'errors.emailInUse' => '이미 가입된 이메일이에요. 로그인해 보세요.',
			'errors.weakPassword' => '비밀번호는 6자 이상이어야 해요.',
			'errors.invalidEmail' => '올바른 이메일 주소를 입력해 주세요.',
			'errors.tooManyAttempts' => '시도 횟수가 너무 많아요. 잠시 후 다시 시도해 주세요.',
			'errors.fillAllFields' => '모든 항목을 입력해 주세요.',
			'errors.insufficientTokens' => '토큰이 부족해요.',
			'errors.requestNotAccepted' => '답장하려면 요청을 수락하세요.',
			'errors.requestPendingLimit' => '상대방이 요청을 수락하면 메시지를 더 보낼 수 있어요.',
			'errors.blocked' => '이 사람에게 메시지를 보낼 수 없어요.',
			'errors.peerUnavailable' => '더 이상 이용할 수 없는 계정이에요.',
			'errors.vibeDailyLimit' => '오늘 Vibe를 많이 공유했어요. 나중에 다시 시도해 주세요.',
			'errors.groupFull' => '그룹 인원이 가득 찼어요.',
			'errors.groupCreateLimit' => '오늘 그룹을 너무 많이 만들었어요. 나중에 다시 시도해 주세요.',
			'errors.notFound' => '더 이상 이용할 수 없어요.',
			'errors.recentLogin' => '보안을 위해 로그아웃 후 다시 로그인한 다음 한 번 더 시도해 주세요.',
			'errors.socialAccount' => '이메일과 비밀번호는 Google 또는 Apple 계정에서 관리돼요.',
			'errors.alreadyInCall' => '이미 통화 중이에요.',
			'errors.roomPrivate' => '비공개 룸이에요. 호스트에게 참여를 요청하세요.',
			'errors.roomFull' => '룸 인원이 가득 찼어요.',
			'errors.alreadyCheckedIn' => '오늘 보상은 이미 받았어요.',
			'errors.purchasesUnavailable' => '지금은 구매할 수 없어요.',
			'faq.q1' => '이 앱은 어떻게 작동하나요?',
			'faq.q2' => '익명 채팅이란 무엇인가요?',
			'faq.q3' => '연결 진행도란 무엇인가요?',
			'faq.q4' => '내 프로필은 어떻게 공개하나요?',
			'faq.q5' => '60초 낯선 사람이란 무엇인가요?',
			'faq.q6' => 'Vibes란 무엇인가요?',
			'faq.q7' => '프로필은 어떻게 편집하나요?',
			'faq.q8' => '알림은 어떻게 관리하나요?',
			'faq.q9' => '구매는 어떻게 복원하나요?',
			'faq.q10' => '모든 대화를 삭제할 수 있나요?',
			'faq.q11' => '내 데이터는 안전한가요?',
			'faq.q12' => '다른 사람을 차단하거나 신고하려면 어떻게 하나요?',
			'faq.q13' => '앱은 어떻게 공유하나요?',
			'faq.q14' => '계정은 어떻게 삭제하나요?',
			'faq.a1' => 'Veylo에서는 익명으로 새로운 사람을 만나 대화하고, 연결이 깊어질수록 프로필을 조금씩 공개할 수 있어요. 둘 다 준비되면 언제든 문자, 음성, 영상으로 전환하세요.',
			'faq.a2' => '익명 채팅에서는 신원과 사진이 숨겨져요. 연결이 높아질수록 이름 첫 글자와 흐린 사진 같은 정보가 공개돼요. 100%가 되면 두 사람 모두 동의해야 전체 프로필이 공개돼요.',
			'faq.a3' => '대화할수록 연결 비율이 올라가요. 특정 단계마다 이름 첫 글자, 흐린 사진, 전체 프로필이 공개돼요. 연결 배지를 탭하면 자세히 볼 수 있어요.',
			'faq.a4' => '연결이 100%가 되면 내 프로필 공개를 탭하세요. 상대방도 수락하면 두 사람의 전체 프로필이 공개돼요.',
			'faq.a5' => '통화 탭에서 짧은 무작위 매칭을 할 수 있어요. 시간이 끝나면 대화를 이어가거나 통화를 종료할 수 있어요.',
			'faq.a6' => 'Vibes에서는 지도/목록 화면으로 근처나 주변 사람들을 발견하고, 관심 있는 사람과 채팅을 시작할 수 있어요.',
			'faq.a7' => '프로필 탭에서 프로필 편집으로 이동해 이름, 사진, 소개, 관심사를 수정하세요. 저장하면 변경 사항이 반영돼요.',
			'faq.a8' => '설정의 알림에서 메시지, 매칭 등 알림을 켜거나 끌 수 있어요.',
			'faq.a9' => '설정 → 계정 관리 → 구매 복원으로 이동하세요. 같은 스토어 계정의 유효한 구매가 복원돼요.',
			'faq.a10' => '네. 설정 → 대화 삭제를 누르고 확인하세요. 모든 채팅이 삭제되며 되돌릴 수 없어요.',
			'faq.a11' => '계정 정보와 메시지는 보호된 시스템에 저장돼요. 계정 관리에서 언제든지 계정 및 데이터 삭제를 요청할 수도 있어요.',
			'faq.a12' => '프로필이나 채팅 화면의 메뉴에서 차단하거나 신고할 수 있어요. 신고는 저희 팀이 검토해요.',
			'faq.a13' => '설정의 앱 공유하기에서 링크를 복사해 친구에게 보내세요.',
			'faq.a14' => '설정 → 계정 관리 → 계정 및 데이터 삭제로 이동하세요. 이유를 작성한 뒤 확인하면 삭제 요청이 제출돼요.',
			'legal.termsTitle' => '서비스 약관',
			'legal.privacyTitle' => '개인정보 처리방침',
			'legal.termsBody' => '최종 업데이트: 2026년 3월 16일\n\nVeylo에 오신 것을 환영합니다. 계정을 만들거나 앱을 이용하면 본 서비스 약관에 동의하는 것으로 간주됩니다.\n\n1. Veylo란\nVeylo는 사람들을 만나고, 익명으로 대화하고, 시간을 두고 연결을 쌓으며, 양측이 동의하면 선택적으로 음성 또는 영상 통화로 전환할 수 있는 소셜 앱입니다.\n\n2. 계정\n정확한 정보를 제공하고 로그인 정보를 안전하게 관리해야 합니다. 계정에서 발생하는 활동에 대한 책임은 본인에게 있습니다. 거주 국가의 법률에 따라 Veylo를 이용할 수 있는 연령이어야 합니다.\n\n3. 존중하는 이용\n괴롭힘, 협박, 사기, 타인 사칭, 불법 콘텐츠 공유 또는 안전 기능 우회 시도를 해서는 안 됩니다. 이 규칙을 위반하는 경우 콘텐츠를 삭제하거나, 기능을 제한하거나, 계정을 정지할 수 있습니다.\n\n4. 익명 채팅 및 프로필 공개\n익명 채팅에서는 연결 단계에 도달할 때까지 이름과 사진이 숨겨질 수 있습니다. 전체 프로필 공개에는 상호 동의가 필요합니다. 다른 사람에게 신원 공개를 강요해서는 안 됩니다.\n\n5. 구매\n일부 기능은 유료일 수 있습니다. 구매는 Apple App Store 또는 Google Play를 통해 처리됩니다. 구매 복원은 동일한 스토어 계정의 유효한 구매 내역을 복구합니다. 환불은 각 스토어의 정책을 따릅니다.\n\n6. 공유하는 콘텐츠\n콘텐츠에 대한 권리는 본인에게 있지만, 서비스 운영에 필요한 범위에서 앱 내에 콘텐츠를 호스팅하고 표시할 수 있는 라이선스를 Veylo에 부여합니다. 공유할 권리가 없는 콘텐츠는 게시하지 마세요.\n\n7. 이용 종료\n언제든지 Veylo 이용을 중단하고 설정에서 계정 삭제를 요청할 수 있습니다. 필요한 경우 합리적인 사전 고지를 통해 서비스를 종료하거나 변경할 수도 있습니다.\n\n8. 문의\n본 약관에 관한 문의: support@veylo.app',
			'legal.privacyBody' => '최종 업데이트: 2026년 3월 16일\n\n본 개인정보 처리방침은 Veylo가 귀하의 정보를 수집, 이용 및 보호하는 방법을 설명합니다.\n\n1. 수집하는 정보\n• 계정 데이터: 이메일, 표시 이름, 프로필 사진, 소개, 선호 설정\n• 이용 데이터: 채팅, 연결 진행도, 이용한 통화 기능, 기기/앱 기본 정보\n• 구매: 유료 기능을 잠금 해제하고 복원하는 데 필요한 스토어 영수증 데이터\n\n2. 이용 방법\n귀하의 데이터는 Veylo 운영, 매칭 및 채팅 경험의 개인화, 커뮤니티 안전 유지, 구매 처리, 제품 개선에 사용됩니다. 당사는 귀하의 개인정보를 판매하지 않습니다.\n\n3. 익명 모드\n익명 채팅에서는 공개 규칙과 상호 동의에 따라 더 많은 정보가 허용될 때까지 다른 사람이 볼 수 있는 정보(예: 가려진 이름 또는 흐린 사진)를 제한합니다. 다만 기능을 안전하게 운영하기 위해 내부적으로는 계정 식별자가 필요합니다.\n\n4. 공유\n호스팅, 분석 또는 결제 처리를 돕는 서비스 제공업체와 필요한 범위 내에서만 데이터를 공유할 수 있습니다. 또한 법률에 따라 요구되거나 사용자를 위험으로부터 보호하기 위해 정보를 공개할 수 있습니다.\n\n5. 보관\n계정이 활성 상태인 동안, 그리고 법적, 안전 및 결제 관련 사유로 필요한 기간 동안 데이터를 보관합니다. 삭제 요청이 완료되면 보관이 법적으로 요구되는 경우를 제외하고 개인정보를 삭제하거나 익명화합니다.\n\n6. 귀하의 선택\n프로필 정보 수정, 알림 관리, 계정 삭제 요청, 데이터 관련 문의를 할 수 있습니다. 스토어 구매는 Apple 또는 Google을 통해서도 관리됩니다.\n\n7. 보안\n귀하의 정보를 보호하기 위해 합리적인 기술적·관리적 조치를 취하고 있습니다. 완벽하게 안전한 시스템은 없으므로 강력한 비밀번호를 사용하고 기기를 최신 상태로 유지해 주세요.\n\n8. 문의\n개인정보 관련 문의: privacy@veylo.app',
			'logout.title' => '로그아웃',
			'logout.subtitle' => '정말 로그아웃할까요?',
			'logout.cancel' => '취소',
			'logout.confirm' => '로그아웃',
			'deleteAccount.title' => '계정 삭제 요청하기',
			'deleteAccount.subtitle' => '정말 계정을 삭제할까요?',
			'deleteAccount.reasonTitle' => '떠나지 않길 바라지만, 이해해요.',
			'deleteAccount.reasonBefore' => '',
			'deleteAccount.reasonAfter' => ' 경험을 개선할 수 있도록 떠나시려는 이유를 알려주시겠어요?',
			'deleteAccount.reasonLabel' => '계정을 삭제하려는 이유',
			'deleteAccount.reasonHint' => '메시지를 입력하세요',
			'deleteAccount.cancel' => '취소',
			'deleteAccount.createRequest' => '요청하기',
			'deleteAccount.confirmTitle' => '정말 삭제 요청을 제출할까요?',
			'deleteAccount.confirmSubtitle' => '확인하면 계정 삭제 요청이 제출돼요',
			'deleteAccount.delete' => '삭제',
			'storyText.bold' => '굵게',
			'storyText.italic' => '기울임',
			'storyText.uppercase' => '대문자',
			'storyText.underline' => '밑줄',
			'storyText.cancel' => '취소',
			'storyText.galleryError' => '갤러리를 열 수 없어요',
			'tokens.boostTitle' => 'Boost',
			'tokens.history' => '내역',
			'tokens.yourBalance' => '내 잔액',
			'tokens.balanceTokens' => ({required Object count}) => '${count} 토큰',
			'tokens.getMore' => '토큰 더 받기',
			'tokens.checkinTitle' => '출석 체크',
			'tokens.checkinSubtitle' => ({required Object max}) => '매일 연속으로 받고 하루 최대 ${max} 토큰을 받아요',
			'tokens.day' => ({required Object n}) => '${n}일차',
			'tokens.collectDay' => ({required Object n}) => '${n}일차 토큰 받기',
			'tokens.collectedToday' => ({required Object n}) => '내일 다시 와서 ${n}일차를 받아요',
			'tokens.duration30m' => '30분',
			'tokens.duration1h' => '1시간',
			'tokens.duration2h' => '2시간',
			'tokens.visibility' => ({required Object n}) => '노출 ${n}배',
			'tokens.boostFor' => ({required Object count}) => '${count} 토큰으로 Boost',
			'tokens.boostActive' => ({required Object time}) => '${time}까지 Boost 중',
			'tokens.boostDone' => '프로필이 Boost됐어요!',
			'tokens.historyEmpty' => '아직 토큰 내역이 없어요',
			'tokens.balanceLine' => ({required Object count}) => '내 잔액 ${count} 토큰',
			'tokens.reasonPurchase' => '토큰 구매',
			'tokens.reasonCheckin' => '출석 체크',
			'tokens.reasonWelcome' => '가입 환영 보너스',
			'tokens.reasonGenderFilter' => '성별 필터 통화',
			'tokens.reasonVideoCall' => '영상 통화',
			'tokens.reasonRoomCreate' => '룸 만들기',
			'tokens.reasonBorder' => '프로필 테두리',
			'tokens.reasonPostBoost' => '게시물 Boost',
			'tokens.reasonRefund' => '환불',
			'tokens.reasonAdjust' => '잔액 조정',
			'tokens.packsTitle' => '토큰 더 받기',
			'tokens.packsSubtitle' => '토큰 패키지를 선택하세요',
			'tokens.packTokens' => ({required Object count}) => '${count} 토큰',
			'tokens.buy' => '구매',
			'tokens.purchaseDone' => ({required Object count}) => '잔액에 ${count} 토큰이 추가됐어요',
			'tokens.notEnoughTitle' => '토큰이 부족해요',
			'tokens.notEnoughSubtitle' => '계속하려면 잔액을 충전하세요.',
			_ => null,
		};
	}
}
