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
class TranslationsZh extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsZh({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.zh,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <zh>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key) ?? super[key];

	late final TranslationsZh _root = this; // ignore: unused_field

	@override 
	TranslationsZh $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsZh(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$app$zh app = _Translations$app$zh._(_root);
	@override late final _Translations$home$zh home = _Translations$home$zh._(_root);
	@override late final _Translations$chats$zh chats = _Translations$chats$zh._(_root);
	@override late final _Translations$profile$zh profile = _Translations$profile$zh._(_root);
	@override late final _Translations$nav$zh nav = _Translations$nav$zh._(_root);
	@override late final _Translations$call$zh call = _Translations$call$zh._(_root);
	@override late final _Translations$vibes$zh vibes = _Translations$vibes$zh._(_root);
	@override late final _Translations$discover$zh discover = _Translations$discover$zh._(_root);
	@override late final _Translations$common$zh common = _Translations$common$zh._(_root);
	@override late final _Translations$languages$zh languages = _Translations$languages$zh._(_root);
	@override late final _Translations$auth$zh auth = _Translations$auth$zh._(_root);
	@override late final _Translations$onboarding$zh onboarding = _Translations$onboarding$zh._(_root);
	@override late final _Translations$createProfile$zh createProfile = _Translations$createProfile$zh._(_root);
	@override late final _Translations$errors$zh errors = _Translations$errors$zh._(_root);
	@override late final _Translations$faq$zh faq = _Translations$faq$zh._(_root);
	@override late final _Translations$legal$zh legal = _Translations$legal$zh._(_root);
	@override late final _Translations$logout$zh logout = _Translations$logout$zh._(_root);
	@override late final _Translations$deleteAccount$zh deleteAccount = _Translations$deleteAccount$zh._(_root);
	@override late final _Translations$storyText$zh storyText = _Translations$storyText$zh._(_root);
}

// Path: app
class _Translations$app$zh extends Translations$app$tr {
	_Translations$app$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get name => 'Veylo';
	@override String get tagline => '欢迎';
}

// Path: home
class _Translations$home$zh extends Translations$home$tr {
	_Translations$home$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '首页';
	@override String get subtitle => '应用准备中';
	@override String get body => '多语言界面由 slang 管理。';
}

// Path: chats
class _Translations$chats$zh extends Translations$chats$tr {
	_Translations$chats$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '聊天';
	@override String get search => '搜索';
	@override String get messagesSection => '消息';
	@override String get request => '请求';
	@override String get emptyRequestTitle => '暂无新的消息\n通知';
	@override String get emptyRequestSubtitle => '超过 30 天的请求不会显示。';
	@override String get noteAdd => '添加便签';
	@override String get anonymous => '匿名';
	@override String get online => '在线';
	@override String get offline => '离线';
	@override String get connection => '亲密度';
	@override String connectionPercent({required Object n}) => '${n}%';
	@override String get connectionProgressTitle => '亲密度进度';
	@override String get milestoneInitial => '名字首字母';
	@override String get milestoneInitialHint => '25% 时已解锁';
	@override String get milestoneInitialLocked => '25% 时解锁';
	@override String get milestonePhoto => '模糊照片预览';
	@override String get milestonePhotoHint => '70% 时解锁';
	@override String get milestoneFull => '查看完整资料';
	@override String get milestoneFullHint => '100% 时双方同意';
	@override String get sampleAnonymousMessage => '你好，很高兴认识你。能简单介绍一下你自己吗？';
	@override String get strangerSampleMessage => '你好 Jhon，很高兴认识你。能简单介绍一下你自己吗？';
	@override String get approve => '同意';
	@override String get blockUser => '拉黑用户';
	@override String get reject => '拒绝';
	@override String get messageHint => '嗨！最近好吗？';
	@override String get revealTitle => '已达到 100%';
	@override String get revealSubtitle => '要向彼此公开完整资料吗？需要双方都同意。';
	@override String revealWaiting({required Object name}) => '等待 ${name} 同意';
	@override String get revealCta => '公开我的资料';
	@override String get revealNotYet => '暂不';
	@override String get seen => '已读';
	@override String get typing => '正在输入…';
	@override String get noteYou => '你';
	@override String get noteSheetTitle => '分享便签';
	@override String get noteSheetSubtitle => '便签将保留 24 小时';
	@override String get noteHint => '在想什么？';
	@override String get noteShare => '分享';
	@override String get noteDelete => '删除便签';
}

// Path: profile
class _Translations$profile$zh extends Translations$profile$tr {
	_Translations$profile$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get eyebrow => '个人资料';
	@override String get title => '设置';
	@override String get editProfile => '编辑资料';
	@override String get statLike => '获赞';
	@override String get statFollow => '关注';
	@override String get statFollower => '粉丝';
	@override String get promoTitle => '收获更多消息！';
	@override String get promoSubtitle => '脱颖而出，排在列表顶部';
	@override String get standOut => '脱颖而出';
	@override String get tabPosts => '帖子';
	@override String get tabVideo => '视频';
	@override String get tabSaved => '收藏';
	@override String get save => '保存';
	@override String get changePhoto => '更换照片';
	@override String get changeBorder => '更换头像框';
	@override String get interest => '兴趣';
	@override String get name => '姓名';
	@override String get changeName => '修改姓名';
	@override String get changePassword => '修改密码';
	@override String get confirmPassword => '确认密码';
	@override String get email => '邮箱';
	@override String get accountManagement => '账号管理';
	@override String get settingsAbout => '关于';
	@override String get settingsAccount => '账号设置';
	@override String get settingsSupport => '支持';
	@override String get shareApp => '分享应用';
	@override String get shareAppTitle => '分享给好友';
	@override String get shareAppSubtitle => '把 Veylo 分享给好友，一起探索吧！';
	@override String get shareAppLabel => '应用链接';
	@override String get rateApp => '喜欢我们吗？给个评分吧';
	@override String get notifications => '通知';
	@override String get password => '密码';
	@override String get deleteConversation => '删除对话';
	@override String get faqHelp => '常见问题与帮助';
	@override String get restorePurchases => '恢复购买';
	@override String get termsOfService => '服务条款';
	@override String get privacyPolicy => '隐私政策';
	@override String get restorePurchasesDone => '已检查购买记录';
	@override String get conversationsDeleted => '已删除所有对话';
	@override String get logOut => '退出登录';
	@override String get deleteAccountAndData => '删除账号和数据';
	@override String get passwordPlaceholder => '********';
	@override String get height => '身高';
	@override String get addHeight => '添加身高';
	@override String heightCm({required Object value}) => '${value} 厘米';
	@override String get languages => '语言';
	@override String get relationshipGoals => '交友目标';
	@override String get lookingFor => '想找';
	@override String get newFriends => '👋 新朋友';
	@override String get goalLongTermOpenToShort => '💕 长期为主，短期也可';
	@override String get goalLongTermRelationship => '💘 长期恋爱';
	@override String get goalNewFriends => '👋 新朋友';
	@override String get goalShortTermFun => '🥃 短期玩乐';
	@override String get goalStillFiguringItOut => '🤔 还没想好';
	@override String get basics => '基本信息';
	@override String get zodiac => '星座';
	@override String get zodiacValue => '天蝎座';
	@override String get education => '学历';
	@override String get educationValue => '本科';
	@override String get educationHighSchool => '高中';
	@override String get educationAssociates => '大专';
	@override String get educationBachelors => '本科';
	@override String get educationMasters => '硕士';
	@override String get educationPhd => '博士';
	@override String get voiceRecord => '语音介绍';
	@override String get addVoice => '添加语音';
	@override String get lifestyle => '生活方式';
	@override String get pets => '宠物';
	@override String get petsValue => '我养了猫';
	@override String get petsDontWant => '不想养宠物';
	@override String get petsAllergic => '我对宠物过敏';
	@override String get petsHaveCat => '我养了猫';
	@override String get petsHaveDog => '我养了狗';
	@override String get petsHaveCatsAndDogs => '猫狗都养';
	@override String get petsHaveOther => '养了其他宠物';
	@override String get drinking => '饮酒';
	@override String get drinkingValue => '特殊场合喝';
	@override String get drinkingNever => '从不';
	@override String get drinkingSpecialOccasions => '特殊场合喝';
	@override String get drinkingSocially => '社交时喝';
	@override String get drinkingFrequently => '经常喝';
	@override String get drinkingSober => '已戒酒';
	@override String get drinkingPreferNotToSay => '不愿透露';
	@override String get smoking => '吸烟';
	@override String get smokingValue => '不吸烟';
	@override String get smokingNonSmoker => '不吸烟';
	@override String get smokingSocialSmoker => '社交时吸';
	@override String get smokingSmoker => '吸烟';
	@override String get smokingTryingToQuit => '正在戒烟';
	@override String get smokingWhenDrinking => '喝酒时吸';
	@override String get smokingPreferNotToSay => '不愿透露';
	@override String get gender => '性别';
	@override String get genderFemale => '女';
	@override String get genderMale => '男';
	@override String get genderPreferNotToSay => '不愿透露';
	@override String get visible => '可见';
	@override String get profileVisibility => '资料可见性';
	@override String get language => '语言';
	@override String get borderTitle => '头像框';
	@override String get borderSubtitle => '给你的头像加个框，\n让自己更出众。';
	@override String get borderBuySection => '购买头像框';
	@override String get borderBuyCta => '购买头像框';
	@override String borderToken({required Object count}) => '${count} 代币';
	@override String get borderAmethystWings => 'Amethyst Wings';
	@override String get borderGoldenPhoenix => 'Golden Phoenix';
	@override String get borderFrostCrown => 'Frost Crown';
	@override String get borderEmeraldWhisper => 'Emerald Whisper';
	@override String get borderRoseQuartz => 'Rose Quartz';
	@override String get borderStarlitComet => 'Starlit Comet';
	@override String get borderCrimsonRoyal => 'Crimson Royal';
	@override String get borderSapphireHalo => 'Sapphire Halo';
	@override String get follow => '关注';
	@override String get following => '已关注';
	@override String get followPageTitle => '关注';
	@override String get followTabFollowing => '关注';
	@override String get followTabFollowers => '粉丝';
	@override String get followSearch => '搜索';
	@override String get unfollow => '取消关注';
	@override String get followSortTitle => '排序';
	@override String get followSortRecent => '最近关注的人';
	@override String get followSortNotFollowingMe => '没有回关我的人';
	@override String get followSortNotFollowedByMe => '我没有回关的人';
	@override String get followSortShowResult => '查看结果';
	@override String get followSortEmpty => '没有符合筛选条件的用户';
	@override String get shareTitle => '分享给好友';
	@override String get shareSubtitle => '和好友一起，\n一切都更有趣！';
	@override String get shareProfileLabel => '分享资料';
	@override String get shareLinkCopied => '链接已复制';
	@override String get restrict => '限制';
	@override String get block => '拉黑';
	@override String get report => '举报';
	@override String blockTitle({required Object username}) => '拉黑 ${username}？';
	@override String get blockBody => '这也会拉黑对方现有或将来创建的其他账号。你可以随时解除拉黑。';
	@override String get blockAndReport => '拉黑并举报';
	@override String restrictTitle({required Object username}) => '限制 ${username}？';
	@override String get restrictBody => '对方将无法看到你是否在线，或你是否已读其消息。你可以随时更改。';
	@override String get restrictAndReport => '限制并举报';
	@override String get reportTitle => '请告诉我们原因';
	@override String get reportSubtitle => '为了给你更好的体验，能告诉我们你为什么要举报该用户吗？';
	@override String get reportMessageLabel => '举报说明';
	@override String get reportMessageHint => '输入你的内容';
	@override String get reportCancel => '取消';
	@override String get sendReport => '提交举报';
	@override String get notSet => '未设置';
	@override String get reportSent => '谢谢，我们已收到你的举报。';
	@override String emailVerificationSent({required Object email}) => '我们已向 ${email} 发送确认链接。确认后邮箱才会更改。';
	@override String get passwordChanged => '密码已更新。';
	@override String get passwordMismatch => '两次输入的密码不一致。';
}

// Path: nav
class _Translations$nav$zh extends Translations$nav$tr {
	_Translations$nav$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get discover => '发现';
	@override String get chat => '聊天';
	@override String get call => '通话';
	@override String get vibes => 'Vibes';
	@override String get profile => '我的';
}

// Path: call
class _Translations$call$zh extends Translations$call$tr {
	_Translations$call$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '60秒陌生人';
	@override String get subtitle => '和随机陌生人聊 60 秒——完全匿名。没有资料，没有照片，没有名字。只有声音和这一刻。';
	@override String get findingTitle => '正在寻找陌生人...';
	@override String get findingSubtitle => '你们将匿名聊 60 秒。没有资料，没有名字。';
	@override String get callStranger => '呼叫陌生人 - 10 代币';
	@override String get cancel => '取消';
	@override String get female => '女';
	@override String get male => '男';
	@override String get nonBinary => '非二元';
	@override String get preferNotToSay => '不愿透露';
	@override String get anonymousBadge => '🎙️ 匿名语音通话';
	@override String get stranger => '陌生人';
	@override String secondsLeft({required Object n}) => '${n}秒';
	@override String get timesUpTitle => '时间到！';
	@override String get timesUpSubtitle => '还想继续聊吗？双方都同意即可解锁聊天。';
	@override String get keepTalking => '继续聊';
	@override String get endCall => '结束通话';
	@override String get waitingOther => '等待对方...';
	@override String get callStrangerFree => '呼叫陌生人';
	@override String get peerLeft => '对方已结束通话。';
	@override String get noKeep => '这次未能解锁聊天。';
	@override String get videoWaiting => '等待对方接受视频通话...';
	@override String get videoDeclined => '对方拒绝了视频通话。';
	@override String get micDenied => '通话需要麦克风权限，可在系统设置中开启。';
	@override String get videoCost => '视频通话：20 代币 / 15 分钟';
	@override String get calling => '呼叫中';
	@override String get accept => '接受';
	@override String get decline => '拒绝';
	@override String get switchToVideo => '要切换到视频通话吗？';
}

// Path: vibes
class _Translations$vibes$zh extends Translations$vibes$tr {
	_Translations$vibes$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get search => '搜索';
	@override String get sendMessage => '发消息';
	@override String get wantsToTalk => '现在就想聊这个';
	@override String get shareTitle => '分享 Vibe';
	@override String get replyTitle => '回复 Vibe';
	@override String get shareHint => '写点什么';
	@override String get shareAnonymous => '匿名分享';
	@override String get empty => '过去 24 小时没有 Vibes。来发第一条吧！';
	@override String get deleteTitle => '删除这条 Vibe？';
	@override String get delete => '删除';
	@override String get cancel => '取消';
}

// Path: discover
class _Translations$discover$zh extends Translations$discover$tr {
	_Translations$discover$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '发现';
	@override String get tabRooms => '房间';
	@override String get tabDiscover => '发现';
	@override String get tabAiMatch => 'AI Match';
	@override late final _Translations$discover$aiMatch$zh aiMatch = _Translations$discover$aiMatch$zh._(_root);
	@override String get searchHint => '搜索';
	@override String get allRooms => '全部房间';
	@override String get allGroups => '全部群组';
	@override String get seeAll => '查看全部';
	@override String get live => '直播中';
	@override String get join => '加入';
	@override String get request => '申请';
	@override String get requested => '已申请';
	@override String get private => '私密';
	@override String moreCount({required Object count}) => '+${count} 更多';
	@override String activeCount({required Object count}) => '${count} 人活跃';
	@override String membersCount({required Object count}) => '${count} 位成员';
	@override late final _Translations$discover$privateRoom$zh privateRoom = _Translations$discover$privateRoom$zh._(_root);
	@override late final _Translations$discover$roomToken$zh roomToken = _Translations$discover$roomToken$zh._(_root);
	@override late final _Translations$discover$privateRequest$zh privateRequest = _Translations$discover$privateRequest$zh._(_root);
	@override late final _Translations$discover$roomApproved$zh roomApproved = _Translations$discover$roomApproved$zh._(_root);
	@override late final _Translations$discover$createSpace$zh createSpace = _Translations$discover$createSpace$zh._(_root);
	@override late final _Translations$discover$liveRoom$zh liveRoom = _Translations$discover$liveRoom$zh._(_root);
	@override late final _Translations$discover$groupChat$zh groupChat = _Translations$discover$groupChat$zh._(_root);
	@override late final _Translations$discover$groupInfo$zh groupInfo = _Translations$discover$groupInfo$zh._(_root);
	@override late final _Translations$discover$filters$zh filters = _Translations$discover$filters$zh._(_root);
	@override late final _Translations$discover$post$zh post = _Translations$discover$post$zh._(_root);
	@override late final _Translations$discover$story$zh story = _Translations$discover$story$zh._(_root);
	@override late final _Translations$discover$highlight$zh highlight = _Translations$discover$highlight$zh._(_root);
	@override late final _Translations$discover$stats$zh stats = _Translations$discover$stats$zh._(_root);
	@override String hostedBy({required Object name}) => '主持人：${name}';
}

// Path: common
class _Translations$common$zh extends Translations$common$tr {
	_Translations$common$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get loading => '加载中…';
	@override String get retry => '重试';
	@override String get cancel => '取消';
	@override String get save => '保存';
	@override String get continueAction => '继续';
	@override String get language => '语言';
	@override String get or => '或';
}

// Path: languages
class _Translations$languages$zh extends Translations$languages$tr {
	_Translations$languages$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get tr => 'Türkçe';
	@override String get en => 'English';
}

// Path: auth
class _Translations$auth$zh extends Translations$auth$tr {
	_Translations$auth$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get createAccountTitle => '创建账号';
	@override String get createAccountSubtitle => '加入 Veylo，开始结识新朋友。';
	@override String get welcomeBackTitle => '欢迎回来';
	@override String get welcomeBackSubtitle => '登录以继续使用 Veylo。';
	@override String get username => '用户名';
	@override String get usernameHint => '选择一个用户名';
	@override String get email => '邮箱';
	@override String get emailHint => '输入你的邮箱';
	@override String get emailOrUsername => '邮箱或用户名';
	@override String get emailOrUsernameHint => '输入邮箱或用户名';
	@override String get password => '密码';
	@override String get passwordCreateHint => '设置密码';
	@override String get passwordEnterHint => '输入你的密码';
	@override String get signUp => '注册';
	@override String get logIn => '登录';
	@override String get forgotPassword => '忘记密码？';
	@override String get continueWithApple => '通过 Apple 继续';
	@override String get continueWithGoogle => '通过 Google 继续';
	@override String get legalPrefix => '继续即表示你同意我们的';
	@override String get termsOfService => '服务条款';
	@override String get legalMiddle => '并知悉我们的';
	@override String get privacyPolicy => '隐私政策';
	@override String get legalSuffix => '。';
	@override String get passwordResetSent => '我们已向你的邮箱发送密码重置链接。';
}

// Path: onboarding
class _Translations$onboarding$zh extends Translations$onboarding$tr {
	_Translations$onboarding$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get skip => '跳过';
	@override String get page1Title => '做自己，保持匿名。';
	@override String get page1Subtitle => '结识新朋友、开启对话，\n无需透露你是谁。';
	@override String get page2Title => '打字、聊天，感受 Vibe。';
	@override String get page2Subtitle => '从匿名开始，准备好后再发消息、通话或见面。';
	@override String get page3Title => '找到同频的人，\n加入对话。';
	@override String get page3Subtitle => '进入房间，结识新朋友，\n一起分享此刻。';
	@override String get getStarted => '开始使用';
	@override String get alreadyHaveAccount => '已有 Veylo 账号？';
	@override String get logInAction => '登录';
}

// Path: createProfile
class _Translations$createProfile$zh extends Translations$createProfile$tr {
	_Translations$createProfile$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get navTitle => '创建资料';
	@override String get stepUsername => '1/5 用户名';
	@override String get title => '创建你的资料';
	@override String get subtitle => '你的真实姓名仅用于验证——不会公开显示。';
	@override String get subtitleLine1 => '你的真实姓名仅用于验证——';
	@override String get subtitleLine2 => '不会公开显示。';
	@override String get fullName => '姓名';
	@override String get fullNameHint => 'Sam Lee';
	@override String get username => '用户名';
	@override String get usernameHint => 'samlee123';
	@override String get usernameTaken => '该用户名已存在！';
	@override String get usernameAvailable => '用户名可用';
	@override String get mightWantToTry => '试试这些...';
	@override String get stepPhoto => '2/5 头像';
	@override String get photoTitle => '上传头像';
	@override String get photoSubtitle => '其他用户可以通过你的头像确认是你本人。';
	@override String get photoSubtitleLine1 => '其他用户可以通过你的头像';
	@override String get photoSubtitleLine2 => '确认是你本人。';
	@override String get choosePhoto => '选择照片';
	@override String get continueWithoutPhoto => '不上传头像，继续';
	@override String get saveAndContinue => '保存并继续';
	@override String get choosePhotoSheetTitle => '选择照片';
	@override String get takePhoto => '拍照';
	@override String get chooseFromGallery => '从相册选择';
	@override String get stepGender => '3/5 性别';
	@override String get genderTitle => '选择你的性别';
	@override String get genderSubtitle => '如果你选择提供此信息，我们可能会用它为你提供个性化内容';
	@override String get genderSubtitleLine1 => '如果你选择提供此信息，';
	@override String get genderSubtitleLine2 => '我们可能会用它为你提供个性化内容';
	@override String get genderFemale => '女';
	@override String get genderMale => '男';
	@override String get genderNonBinary => '非二元';
	@override String get genderPreferNotToSay => '不愿透露';
	@override String get stepInterests => '4/5 兴趣';
	@override String get interestsTitle => '你喜欢什么？';
	@override String get interestsSubtitle => '至少选 5 个——帮你匹配真正懂你的人。';
	@override late final _Translations$createProfile$interests$zh interests = _Translations$createProfile$interests$zh._(_root);
	@override String get stepChatGoal => '5/5 聊天目标';
	@override String get chatGoalTitle => '你今天想找什么？';
	@override String get chatGoalSubtitle => '这能帮我们根据你此刻的心情找到合适的人。';
	@override String get chatGoalQuickMatch => '快速匹配——直接\n开聊';
	@override String get chatGoalFlirtyChat => '暧昧聊天——轻松、俏皮的\n对话';
	@override String get chatGoalMoodMatch => '心情匹配——根据你此刻的\n感受匹配';
	@override String get chatGoalLateNight => '深夜畅聊——夜深人静时的\n走心对话';
	@override String get chatGoalMeetSomeoneNew => '认识新朋友——没有特定目标，\n随便看看';
	@override String get getStarted => '开始使用';
	@override String get preparingTitleLine1 => '我们正在为你';
	@override String get preparingTitleLine2 => '准备合适的';
	@override String get preparingTitleLine3 => '人选。';
	@override String get preparingSubtitleLine1 => '我们正根据你的回答';
	@override String get preparingSubtitleLine2 => '挑选最佳匹配，请稍候。';
	@override String preparingPercent({required Object percent}) => '${percent}%';
	@override String get usernameInvalid => '请使用 3–30 位字母、数字、点或下划线。';
}

// Path: errors
class _Translations$errors$zh extends Translations$errors$tr {
	_Translations$errors$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get network => '无法连接 Veylo。请检查网络后重试。';
	@override String get generic => '出错了，请重试。';
	@override String get signInFailed => '登录失败，请重试。';
	@override String get sessionExpired => '登录已过期，请重新登录。';
	@override String get accountSuspended => '该账号已被停用。';
	@override String get unsupportedImage => '请选择 JPEG、PNG 或 WebP 格式的照片。';
	@override String get fileTooLarge => '文件过大。';
	@override String get enterEmailForReset => '请在上方输入邮箱以重置密码。';
	@override String get wrongCredentials => '邮箱/用户名或密码错误。';
	@override String get emailInUse => '该邮箱已注册，请尝试登录。';
	@override String get weakPassword => '密码至少需要 6 个字符。';
	@override String get invalidEmail => '请输入有效的邮箱地址。';
	@override String get tooManyAttempts => '尝试次数过多，请稍后再试。';
	@override String get fillAllFields => '请填写所有字段。';
	@override String get insufficientTokens => '代币不足。';
	@override String get requestNotAccepted => '接受请求后才能回复。';
	@override String get requestPendingLimit => '对方接受你的请求后，你才能发送更多消息。';
	@override String get blocked => '你无法给此人发消息。';
	@override String get peerUnavailable => '该账号已不可用。';
	@override String get vibeDailyLimit => '你今天已分享了很多 Vibes，请稍后再试。';
	@override String get groupFull => '该群组已满。';
	@override String get groupCreateLimit => '你今天创建的群组过多，请稍后再试。';
	@override String get notFound => '该内容已不可用。';
	@override String get recentLogin => '为了你的安全，请退出后重新登录，然后再试一次。';
	@override String get socialAccount => '你的邮箱和密码由你的 Google 或 Apple 账号管理。';
	@override String get alreadyInCall => '你已在通话中。';
	@override String get roomPrivate => '这是私密房间，请联系房主申请加入。';
	@override String get roomFull => '该房间已满。';
}

// Path: faq
class _Translations$faq$zh extends Translations$faq$tr {
	_Translations$faq$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get q1 => '这个应用怎么用？';
	@override String get q2 => '什么是匿名聊天？';
	@override String get q3 => '什么是亲密度进度？';
	@override String get q4 => '如何公开我的资料？';
	@override String get q5 => '什么是60秒陌生人？';
	@override String get q6 => '什么是 Vibes？';
	@override String get q7 => '如何编辑我的资料？';
	@override String get q8 => '如何管理通知？';
	@override String get q9 => '如何恢复购买？';
	@override String get q10 => '可以删除所有对话吗？';
	@override String get q11 => '我的数据安全吗？';
	@override String get q12 => '如何拉黑或举报他人？';
	@override String get q13 => '如何分享应用？';
	@override String get q14 => '如何删除我的账号？';
	@override String get a1 => '在 Veylo 上，你可以匿名结识新朋友、聊天，并随着亲密度提升逐步公开你的资料。双方都准备好后，可随时切换到文字、语音或面对面交流。';
	@override String get a2 => '匿名聊天中，你的身份和照片都会被隐藏。随着亲密度提升，你可以解锁名字首字母和模糊照片等信息。达到 100% 时，需双方都同意才能公开完整资料。';
	@override String get a3 => '聊得越多，亲密度百分比越高。达到特定里程碑后，你可以解锁名字首字母、模糊照片和完整资料。点击“亲密度”标签即可查看详情。';
	@override String get a4 => '亲密度达到 100% 时，点击“公开我的资料”。如果对方也同意，双方的完整资料都会显示。';
	@override String get a5 => '在“通话”页，你可以快速随机匹配一位陌生人。时间到后，你可以选择继续聊或结束通话。';
	@override String get a6 => '通过 Vibes，你可以在地图/列表视图中发现附近或身边的人，并和感兴趣的人开始聊天。';
	@override String get a7 => '打开“我的”页面，进入“编辑资料”即可更新姓名、照片、简介和兴趣。保存后更改即会生效。';
	@override String get a8 => '在“设置”中打开“通知”，即可开启或关闭消息、匹配及其他提醒。';
	@override String get a9 => '前往“设置 → 账号管理 → 恢复购买”。同一商店账号下符合条件的购买将被恢复。';
	@override String get a10 => '可以。前往“设置 → 删除对话”并确认，所有聊天都将被删除。此操作无法撤销。';
	@override String get a11 => '你的账号信息和消息存储在受保护的系统中。你也可以随时在“账号管理”中申请删除账号和数据。';
	@override String get a12 => '在资料页或聊天页的菜单中即可拉黑或举报。我们的团队会审核举报内容。';
	@override String get a13 => '在“设置”中使用“分享应用”复制链接，发送给好友即可。';
	@override String get a14 => '前往“设置 → 账号管理 → 删除账号和数据”。填写原因后，确认即可提交删除申请。';
}

// Path: legal
class _Translations$legal$zh extends Translations$legal$tr {
	_Translations$legal$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get termsTitle => '服务条款';
	@override String get privacyTitle => '隐私政策';
	@override String get termsBody => '最后更新：2026年3月16日\n\n欢迎使用 Veylo。创建账号或使用本应用，即表示你同意本服务条款。\n\n1. Veylo 是什么\nVeylo 是一款社交应用，你可以在这里结识他人、匿名聊天、随时间建立联系，并在双方同意时选择进行语音或面对面通话。\n\n2. 你的账号\n你必须提供准确的信息并妥善保管登录凭据。你需对账号下的所有活动负责。你必须达到所在国家法律规定的可使用 Veylo 的年龄。\n\n3. 文明使用\n请勿骚扰、威胁、诈骗、冒充他人、分享违法内容或试图绕过安全功能。对于违反这些规则的行为，我们可能会删除内容、限制功能或停用账号。\n\n4. 匿名聊天与资料公开\n在达到亲密度里程碑之前，匿名聊天可能会隐藏你的姓名和照片。公开完整资料需要双方同意。请勿强迫他人公开身份。\n\n5. 购买\n部分功能可能需要付费。购买由 Apple App Store 或 Google Play 处理。“恢复购买”可恢复同一商店账号下符合条件的购买。退款遵循相应商店的政策。\n\n6. 你分享的内容\n你保留对自己内容的权利，但授予 Veylo 一项许可，以便在运营服务所需范围内于应用中托管和展示这些内容。请勿发布你无权分享的内容。\n\n7. 终止使用\n你可以随时停止使用 Veylo，并在“设置”中申请删除账号。在必要时，我们也可能在合理通知后终止或变更服务。\n\n8. 联系我们\n有关本条款的问题：support@veylo.app';
	@override String get privacyBody => '最后更新：2026年3月16日\n\n本隐私政策说明 Veylo 如何收集、使用和保护你的信息。\n\n1. 我们收集的信息\n• 账号数据：邮箱、显示名称、头像照片、个人简介、偏好设置\n• 使用数据：聊天内容、亲密度进度、你使用的通话功能、设备/应用基本信息\n• 购买信息：解锁和恢复付费功能所需的商店收据数据\n\n2. 我们如何使用\n我们使用你的数据来运营 Veylo、个性化匹配和聊天体验、维护社区安全、处理购买并改进产品。我们不会出售你的个人数据。\n\n3. 匿名模式\n在匿名聊天中，我们会限制他人可见的信息（例如隐藏姓名或模糊照片），直到解锁规则和双方同意允许展示更多内容。在后台，我们仍需使用账号标识符来安全地运行该功能。\n\n4. 信息共享\n我们可能会与帮助我们托管、分析或处理付款的服务提供商共享数据——仅限必要范围。在法律要求或为保护用户免受伤害时，我们也可能披露信息。\n\n5. 数据保留\n在你的账号有效期间，以及出于法律、安全和账务原因需要时，我们会保留数据。删除申请完成后，除法律要求保留的情况外，我们会删除个人数据或对其进行匿名化处理。\n\n6. 你的选择\n你可以编辑资料信息、管理通知、申请删除账号，并就你的数据与我们联系。商店购买也可通过 Apple 或 Google 进行管理。\n\n7. 安全\n我们采取合理的技术和组织措施来保护你的信息。没有任何系统是绝对安全的；请使用强密码并保持设备更新。\n\n8. 联系我们\n隐私相关问题：privacy@veylo.app';
}

// Path: logout
class _Translations$logout$zh extends Translations$logout$tr {
	_Translations$logout$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '退出登录';
	@override String get subtitle => '确定要退出登录吗？';
	@override String get cancel => '取消';
	@override String get confirm => '退出登录';
}

// Path: deleteAccount
class _Translations$deleteAccount$zh extends Translations$deleteAccount$tr {
	_Translations$deleteAccount$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '提交账号删除申请';
	@override String get subtitle => '确定要删除你的账号吗？';
	@override String get reasonTitle => '我们舍不得你走，但我们理解。';
	@override String get reasonBefore => '能告诉我们你离开的原因吗？这将帮助我们改进 ';
	@override String get reasonAfter => ' 的体验。';
	@override String get reasonLabel => '你为什么要删除账号';
	@override String get reasonHint => '输入你的内容';
	@override String get cancel => '取消';
	@override String get createRequest => '提交申请';
	@override String get confirmTitle => '确定要提交删除申请吗？';
	@override String get confirmSubtitle => '确认后，你的账号删除申请将被提交';
	@override String get delete => '删除';
}

// Path: storyText
class _Translations$storyText$zh extends Translations$storyText$tr {
	_Translations$storyText$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get bold => '粗体';
	@override String get italic => '斜体';
	@override String get uppercase => '大写';
	@override String get underline => '下划线';
	@override String get cancel => '取消';
	@override String get galleryError => '无法打开相册';
}

// Path: discover.aiMatch
class _Translations$discover$aiMatch$zh extends Translations$discover$aiMatch$tr {
	_Translations$discover$aiMatch$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get feelingTitle => '你今天心情如何';
	@override String get feelingSubtitle => 'AI 会根据你的选择找到最佳匹配';
	@override String get lookingTitle => '你想找什么？';
	@override String get moodSad => '难过';
	@override String get moodMeltie => '一般';
	@override String get moodBored => '无聊';
	@override String get moodCrying => '低落';
	@override String get moodSmile => '开心';
	@override String get lookingNewFriends => '新朋友';
	@override String get lookingVenting => '倾诉';
	@override String get lookingFlirty => '暧昧聊天';
	@override String get lookingFun => '找乐子';
	@override String get lookingCultures => '新文化';
	@override String get lookingLanguage => '语言练习';
	@override String get statActiveUsers => '活跃用户';
	@override String get statMatchRate => '匹配率';
	@override String get statAvgTime => '平均用时';
	@override String get statActiveValue => '843';
	@override String get statMatchValue => '87%';
	@override String get statAvgValue => '8秒';
	@override String get startSmartMatch => '开始智能匹配';
	@override String get findingTitle => '正在寻找你的匹配';
	@override String get findingSubtitle => '根据你的心情和兴趣匹配合适的人';
	@override String get findingStepMood => '心情已分析';
	@override String get findingStepInterests => '兴趣已匹配';
	@override String get findingStepCompatibility => '正在计算契合度...';
	@override String get findingStepContent => '正在生成内容...';
	@override String findingOnline({required Object count}) => '当前 ${count} 人在线';
	@override String get yourMatchTitle => '你的匹配';
	@override String get yourMatchSubtitle => '已根据你的回答为你匹配';
	@override String vibeMatch({required Object percent}) => '${percent}% 契合';
	@override String get startChatting => '开始聊天';
	@override String matchNameAge({required Object name, required Object age}) => '${name}，${age}';
	@override String get matchBio => '我会让你体会到从未有过的感觉。';
	@override String get swipePrevious => '上一个';
	@override String get swipeNext => '下一个';
	@override String get swipeFinger => '滑动手指';
	@override String get noMatch => '暂时没有匹配的人，稍后再试吧。';
}

// Path: discover.privateRoom
class _Translations$discover$privateRoom$zh extends Translations$discover$privateRoom$tr {
	_Translations$discover$privateRoom$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get subtitle => '这是私密房间，使用代币解锁进入。';
	@override String get roomAccess => '房间门票';
	@override String get yourBalance => '你的余额';
	@override String tokensAmount({required Object count}) => '${count} 代币';
	@override String joinForTokens({required Object count}) => '花 ${count} 代币加入';
	@override String get cancel => '取消';
}

// Path: discover.roomToken
class _Translations$discover$roomToken$zh extends Translations$discover$roomToken$tr {
	_Translations$discover$roomToken$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get subtitle => '使用代币解锁进入。';
	@override String get roomAccess => '房间门票';
	@override String get yourBalance => '你的余额';
	@override String tokensAmount({required Object count}) => '${count} 代币';
	@override String joinForTokens({required Object count}) => '花 ${count} 代币加入';
	@override String get cancel => '取消';
}

// Path: discover.privateRequest
class _Translations$discover$privateRequest$zh extends Translations$discover$privateRequest$tr {
	_Translations$discover$privateRequest$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '申请加入';
	@override String roomInfo({required Object name, required Object count}) => '${name} · ${count} 位成员';
	@override String get messageHint => '说点什么（可选）...';
	@override String get sendRequest => '发送申请';
	@override String get adminReview => '房间管理员将审核你的申请';
}

// Path: discover.roomApproved
class _Translations$discover$roomApproved$zh extends Translations$discover$roomApproved$tr {
	_Translations$discover$roomApproved$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '你已加入！';
	@override String subtitle({required Object name}) => '已为你在 ${name} 预留位置';
	@override String get continueLabel => '继续';
}

// Path: discover.createSpace
class _Translations$discover$createSpace$zh extends Translations$discover$createSpace$tr {
	_Translations$discover$createSpace$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '创建房间或群组';
	@override String get subtitle => '创建群组或直播房间，认识更多人';
	@override String get room => '房间';
	@override String get group => '群组';
	@override String get hideAccount => '隐藏你的账号';
	@override String get create => '创建';
	@override String get cancel => '取消';
	@override String get createRoomTitle => '创建房间';
	@override String get createGroupTitle => '创建群组';
	@override String get nameSubtitle => '给你创建的群组起个名字';
	@override String get nameHint => '夜猫子';
	@override String createRoomFor({required Object count}) => '花 ${count} 代币创建';
}

// Path: discover.liveRoom
class _Translations$discover$liveRoom$zh extends Translations$discover$liveRoom$tr {
	_Translations$discover$liveRoom$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get adminSuffix => '（管理员）';
	@override String get messageHint => '发消息';
	@override String get quickReplyHey => '大家好！';
	@override String get quickReplyTopic => '聊什么话题？';
	@override String get quickReplyNew => '我是新来的！';
	@override String get sampleChatName => 'Sona';
	@override String get sampleChatBody => '我们能做点什么？你有什么想法？';
	@override String get roomEnded => '房间已结束。';
	@override String wantsToJoin({required Object name}) => '${name} 想要加入';
	@override String get approve => '同意';
}

// Path: discover.groupChat
class _Translations$discover$groupChat$zh extends Translations$discover$groupChat$tr {
	_Translations$discover$groupChat$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String usersCount({required Object count}) => '${count} 位用户';
	@override String get sampleVictoria => '好无聊啊，大家要不要一起做点什么？';
	@override String get sampleSona => '我们能做点什么？你有什么想法？';
	@override String get sampleOwn => '我们在码头见吧';
}

// Path: discover.groupInfo
class _Translations$discover$groupInfo$zh extends Translations$discover$groupInfo$tr {
	_Translations$discover$groupInfo$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get media => '媒体';
	@override String get gallery => '相册';
	@override String get settings => '设置';
	@override String get notifications => '通知';
	@override String get blocked => '已屏蔽';
	@override String get private => '私密';
	@override String membersCount({required Object count}) => '${count} 位成员';
	@override String get addPeople => '添加成员';
	@override String get you => '你';
	@override String get admin => '管理员';
	@override String get leaveGroup => '退出群组';
	@override String get requests => '加入申请';
	@override String get approve => '同意';
	@override String get reject => '拒绝';
	@override String get addPeopleEmpty => '关注他人后即可将其加入群组。';
	@override String get add => '添加';
	@override String get makeAdmin => '设为管理员';
	@override String get removeAdmin => '取消管理员';
	@override String get remove => '移出群组';
	@override String get leaveConfirm => '确定退出该群组？';
	@override String get leave => '退出';
	@override String get cancel => '取消';
}

// Path: discover.filters
class _Translations$discover$filters$zh extends Translations$discover$filters$tr {
	_Translations$discover$filters$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '筛选';
	@override String get ageRange => '年龄范围';
	@override String ageRangeValue({required Object min, required Object max}) => '${min}-${max}';
	@override String get distance => '距离';
	@override String distanceValue({required Object km}) => '${km} 公里';
	@override String get showMe => '显示';
	@override String get everyone => '所有人';
	@override String get women => '女性';
	@override String get men => '男性';
	@override String get interests => '兴趣';
	@override String get activeNow => '当前活跃';
	@override String get activeNowSubtitle => '只显示当前在线的人';
	@override String get showResult => '查看结果';
}

// Path: discover.post
class _Translations$discover$post$zh extends Translations$discover$post$tr {
	_Translations$discover$post$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get follow => '关注';
	@override String get following => '已关注';
	@override String get addComment => '添加评论...';
	@override String get commentsTitle => '评论';
	@override String get sampleCaption => '美好的一天过后来杯咖啡，真是再惬意不过了。<3';
	@override String hoursAgo({required Object hours}) => '${hours}小时';
	@override String minutesAgo({required Object minutes}) => '${minutes}分钟';
	@override String daysAgo({required Object days}) => '${days}天';
	@override String get deleteCommentTitle => '删除这条评论？';
}

// Path: discover.story
class _Translations$discover$story$zh extends Translations$discover$story$tr {
	_Translations$discover$story$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get draft => '草稿';
	@override String get story => '快拍';
	@override String get share => '分享';
	@override String get textPlaceholder => '写点什么...';
	@override String get draftPrompt => '保存为草稿？';
	@override String get saveToDraft => '存为草稿';
	@override String get moveToTrash => '移到废纸篓';
	@override String get save => '保存';
	@override String get musicTitle => '音乐';
	@override String get musicEmpty => '未找到音乐。';
	@override String get musicError => '无法加载音乐。';
	@override String get downloaded => '已保存到相册';
	@override String get downloadFailed => '保存失败';
}

// Path: discover.highlight
class _Translations$discover$highlight$zh extends Translations$discover$highlight$tr {
	_Translations$discover$highlight$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '精选';
	@override String get view => '查看';
	@override String get aiComments => 'AI 评论';
	@override String get remove => '移除精选';
	@override String get sharedSuccess => '你的帖子已成功分享';
	@override String get boost => '推广';
}

// Path: discover.stats
class _Translations$discover$stats$zh extends Translations$discover$stats$tr {
	_Translations$discover$stats$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '数据统计';
	@override String get subtitle => '以下是你帖子的\n相关数据。';
	@override String get viewers => '浏览';
	@override String get comments => '评论';
	@override String get likes => '点赞';
	@override String get boostCta => '推广 1 天 - 100 代币';
	@override String get boosted => '推广成功！你的帖子将置顶 24 小时。';
}

// Path: createProfile.interests
class _Translations$createProfile$interests$zh extends Translations$createProfile$interests$tr {
	_Translations$createProfile$interests$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get music => '音乐';
	@override String get movies => '电影';
	@override String get tvShows => '电视剧';
	@override String get reading => '阅读';
	@override String get painting => '绘画';
	@override String get photography => '摄影';
	@override String get theatre => '戏剧';
	@override String get fitness => '健身';
	@override String get swimming => '游泳';
	@override String get football => '足球';
	@override String get basketball => '篮球';
	@override String get coffee => '咖啡';
	@override String get travel => '旅行';
	@override String get camping => '露营';
	@override String get meditation => '冥想';
	@override String get videoGames => '电子游戏';
	@override String get boardGames => '桌游';
	@override String get standUp => '脱口秀';
	@override String get tech => '科技';
	@override String get coding => '编程';
	@override String get ai => 'AI';
	@override String get podcast => '播客';
}

/// The flat map containing all translations for locale <zh>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsZh {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.name' => 'Veylo',
			'app.tagline' => '欢迎',
			'home.title' => '首页',
			'home.subtitle' => '应用准备中',
			'home.body' => '多语言界面由 slang 管理。',
			'chats.title' => '聊天',
			'chats.search' => '搜索',
			'chats.messagesSection' => '消息',
			'chats.request' => '请求',
			'chats.emptyRequestTitle' => '暂无新的消息\n通知',
			'chats.emptyRequestSubtitle' => '超过 30 天的请求不会显示。',
			'chats.noteAdd' => '添加便签',
			'chats.anonymous' => '匿名',
			'chats.online' => '在线',
			'chats.offline' => '离线',
			'chats.connection' => '亲密度',
			'chats.connectionPercent' => ({required Object n}) => '${n}%',
			'chats.connectionProgressTitle' => '亲密度进度',
			'chats.milestoneInitial' => '名字首字母',
			'chats.milestoneInitialHint' => '25% 时已解锁',
			'chats.milestoneInitialLocked' => '25% 时解锁',
			'chats.milestonePhoto' => '模糊照片预览',
			'chats.milestonePhotoHint' => '70% 时解锁',
			'chats.milestoneFull' => '查看完整资料',
			'chats.milestoneFullHint' => '100% 时双方同意',
			'chats.sampleAnonymousMessage' => '你好，很高兴认识你。能简单介绍一下你自己吗？',
			'chats.strangerSampleMessage' => '你好 Jhon，很高兴认识你。能简单介绍一下你自己吗？',
			'chats.approve' => '同意',
			'chats.blockUser' => '拉黑用户',
			'chats.reject' => '拒绝',
			'chats.messageHint' => '嗨！最近好吗？',
			'chats.revealTitle' => '已达到 100%',
			'chats.revealSubtitle' => '要向彼此公开完整资料吗？需要双方都同意。',
			'chats.revealWaiting' => ({required Object name}) => '等待 ${name} 同意',
			'chats.revealCta' => '公开我的资料',
			'chats.revealNotYet' => '暂不',
			'chats.seen' => '已读',
			'chats.typing' => '正在输入…',
			'chats.noteYou' => '你',
			'chats.noteSheetTitle' => '分享便签',
			'chats.noteSheetSubtitle' => '便签将保留 24 小时',
			'chats.noteHint' => '在想什么？',
			'chats.noteShare' => '分享',
			'chats.noteDelete' => '删除便签',
			'profile.eyebrow' => '个人资料',
			'profile.title' => '设置',
			'profile.editProfile' => '编辑资料',
			'profile.statLike' => '获赞',
			'profile.statFollow' => '关注',
			'profile.statFollower' => '粉丝',
			'profile.promoTitle' => '收获更多消息！',
			'profile.promoSubtitle' => '脱颖而出，排在列表顶部',
			'profile.standOut' => '脱颖而出',
			'profile.tabPosts' => '帖子',
			'profile.tabVideo' => '视频',
			'profile.tabSaved' => '收藏',
			'profile.save' => '保存',
			'profile.changePhoto' => '更换照片',
			'profile.changeBorder' => '更换头像框',
			'profile.interest' => '兴趣',
			'profile.name' => '姓名',
			'profile.changeName' => '修改姓名',
			'profile.changePassword' => '修改密码',
			'profile.confirmPassword' => '确认密码',
			'profile.email' => '邮箱',
			'profile.accountManagement' => '账号管理',
			'profile.settingsAbout' => '关于',
			'profile.settingsAccount' => '账号设置',
			'profile.settingsSupport' => '支持',
			'profile.shareApp' => '分享应用',
			'profile.shareAppTitle' => '分享给好友',
			'profile.shareAppSubtitle' => '把 Veylo 分享给好友，一起探索吧！',
			'profile.shareAppLabel' => '应用链接',
			'profile.rateApp' => '喜欢我们吗？给个评分吧',
			'profile.notifications' => '通知',
			'profile.password' => '密码',
			'profile.deleteConversation' => '删除对话',
			'profile.faqHelp' => '常见问题与帮助',
			'profile.restorePurchases' => '恢复购买',
			'profile.termsOfService' => '服务条款',
			'profile.privacyPolicy' => '隐私政策',
			'profile.restorePurchasesDone' => '已检查购买记录',
			'profile.conversationsDeleted' => '已删除所有对话',
			'profile.logOut' => '退出登录',
			'profile.deleteAccountAndData' => '删除账号和数据',
			'profile.passwordPlaceholder' => '********',
			'profile.height' => '身高',
			'profile.addHeight' => '添加身高',
			'profile.heightCm' => ({required Object value}) => '${value} 厘米',
			'profile.languages' => '语言',
			'profile.relationshipGoals' => '交友目标',
			'profile.lookingFor' => '想找',
			'profile.newFriends' => '👋 新朋友',
			'profile.goalLongTermOpenToShort' => '💕 长期为主，短期也可',
			'profile.goalLongTermRelationship' => '💘 长期恋爱',
			'profile.goalNewFriends' => '👋 新朋友',
			'profile.goalShortTermFun' => '🥃 短期玩乐',
			'profile.goalStillFiguringItOut' => '🤔 还没想好',
			'profile.basics' => '基本信息',
			'profile.zodiac' => '星座',
			'profile.zodiacValue' => '天蝎座',
			'profile.education' => '学历',
			'profile.educationValue' => '本科',
			'profile.educationHighSchool' => '高中',
			'profile.educationAssociates' => '大专',
			'profile.educationBachelors' => '本科',
			'profile.educationMasters' => '硕士',
			'profile.educationPhd' => '博士',
			'profile.voiceRecord' => '语音介绍',
			'profile.addVoice' => '添加语音',
			'profile.lifestyle' => '生活方式',
			'profile.pets' => '宠物',
			'profile.petsValue' => '我养了猫',
			'profile.petsDontWant' => '不想养宠物',
			'profile.petsAllergic' => '我对宠物过敏',
			'profile.petsHaveCat' => '我养了猫',
			'profile.petsHaveDog' => '我养了狗',
			'profile.petsHaveCatsAndDogs' => '猫狗都养',
			'profile.petsHaveOther' => '养了其他宠物',
			'profile.drinking' => '饮酒',
			'profile.drinkingValue' => '特殊场合喝',
			'profile.drinkingNever' => '从不',
			'profile.drinkingSpecialOccasions' => '特殊场合喝',
			'profile.drinkingSocially' => '社交时喝',
			'profile.drinkingFrequently' => '经常喝',
			'profile.drinkingSober' => '已戒酒',
			'profile.drinkingPreferNotToSay' => '不愿透露',
			'profile.smoking' => '吸烟',
			'profile.smokingValue' => '不吸烟',
			'profile.smokingNonSmoker' => '不吸烟',
			'profile.smokingSocialSmoker' => '社交时吸',
			'profile.smokingSmoker' => '吸烟',
			'profile.smokingTryingToQuit' => '正在戒烟',
			'profile.smokingWhenDrinking' => '喝酒时吸',
			'profile.smokingPreferNotToSay' => '不愿透露',
			'profile.gender' => '性别',
			'profile.genderFemale' => '女',
			'profile.genderMale' => '男',
			'profile.genderPreferNotToSay' => '不愿透露',
			'profile.visible' => '可见',
			'profile.profileVisibility' => '资料可见性',
			'profile.language' => '语言',
			'profile.borderTitle' => '头像框',
			'profile.borderSubtitle' => '给你的头像加个框，\n让自己更出众。',
			'profile.borderBuySection' => '购买头像框',
			'profile.borderBuyCta' => '购买头像框',
			'profile.borderToken' => ({required Object count}) => '${count} 代币',
			'profile.borderAmethystWings' => 'Amethyst Wings',
			'profile.borderGoldenPhoenix' => 'Golden Phoenix',
			'profile.borderFrostCrown' => 'Frost Crown',
			'profile.borderEmeraldWhisper' => 'Emerald Whisper',
			'profile.borderRoseQuartz' => 'Rose Quartz',
			'profile.borderStarlitComet' => 'Starlit Comet',
			'profile.borderCrimsonRoyal' => 'Crimson Royal',
			'profile.borderSapphireHalo' => 'Sapphire Halo',
			'profile.follow' => '关注',
			'profile.following' => '已关注',
			'profile.followPageTitle' => '关注',
			'profile.followTabFollowing' => '关注',
			'profile.followTabFollowers' => '粉丝',
			'profile.followSearch' => '搜索',
			'profile.unfollow' => '取消关注',
			'profile.followSortTitle' => '排序',
			'profile.followSortRecent' => '最近关注的人',
			'profile.followSortNotFollowingMe' => '没有回关我的人',
			'profile.followSortNotFollowedByMe' => '我没有回关的人',
			'profile.followSortShowResult' => '查看结果',
			'profile.followSortEmpty' => '没有符合筛选条件的用户',
			'profile.shareTitle' => '分享给好友',
			'profile.shareSubtitle' => '和好友一起，\n一切都更有趣！',
			'profile.shareProfileLabel' => '分享资料',
			'profile.shareLinkCopied' => '链接已复制',
			'profile.restrict' => '限制',
			'profile.block' => '拉黑',
			'profile.report' => '举报',
			'profile.blockTitle' => ({required Object username}) => '拉黑 ${username}？',
			'profile.blockBody' => '这也会拉黑对方现有或将来创建的其他账号。你可以随时解除拉黑。',
			'profile.blockAndReport' => '拉黑并举报',
			'profile.restrictTitle' => ({required Object username}) => '限制 ${username}？',
			'profile.restrictBody' => '对方将无法看到你是否在线，或你是否已读其消息。你可以随时更改。',
			'profile.restrictAndReport' => '限制并举报',
			'profile.reportTitle' => '请告诉我们原因',
			'profile.reportSubtitle' => '为了给你更好的体验，能告诉我们你为什么要举报该用户吗？',
			'profile.reportMessageLabel' => '举报说明',
			'profile.reportMessageHint' => '输入你的内容',
			'profile.reportCancel' => '取消',
			'profile.sendReport' => '提交举报',
			'profile.notSet' => '未设置',
			'profile.reportSent' => '谢谢，我们已收到你的举报。',
			'profile.emailVerificationSent' => ({required Object email}) => '我们已向 ${email} 发送确认链接。确认后邮箱才会更改。',
			'profile.passwordChanged' => '密码已更新。',
			'profile.passwordMismatch' => '两次输入的密码不一致。',
			'nav.discover' => '发现',
			'nav.chat' => '聊天',
			'nav.call' => '通话',
			'nav.vibes' => 'Vibes',
			'nav.profile' => '我的',
			'call.title' => '60秒陌生人',
			'call.subtitle' => '和随机陌生人聊 60 秒——完全匿名。没有资料，没有照片，没有名字。只有声音和这一刻。',
			'call.findingTitle' => '正在寻找陌生人...',
			'call.findingSubtitle' => '你们将匿名聊 60 秒。没有资料，没有名字。',
			'call.callStranger' => '呼叫陌生人 - 10 代币',
			'call.cancel' => '取消',
			'call.female' => '女',
			'call.male' => '男',
			'call.nonBinary' => '非二元',
			'call.preferNotToSay' => '不愿透露',
			'call.anonymousBadge' => '🎙️ 匿名语音通话',
			'call.stranger' => '陌生人',
			'call.secondsLeft' => ({required Object n}) => '${n}秒',
			'call.timesUpTitle' => '时间到！',
			'call.timesUpSubtitle' => '还想继续聊吗？双方都同意即可解锁聊天。',
			'call.keepTalking' => '继续聊',
			'call.endCall' => '结束通话',
			'call.waitingOther' => '等待对方...',
			'call.callStrangerFree' => '呼叫陌生人',
			'call.peerLeft' => '对方已结束通话。',
			'call.noKeep' => '这次未能解锁聊天。',
			'call.videoWaiting' => '等待对方接受视频通话...',
			'call.videoDeclined' => '对方拒绝了视频通话。',
			'call.micDenied' => '通话需要麦克风权限，可在系统设置中开启。',
			'call.videoCost' => '视频通话：20 代币 / 15 分钟',
			'call.calling' => '呼叫中',
			'call.accept' => '接受',
			'call.decline' => '拒绝',
			'call.switchToVideo' => '要切换到视频通话吗？',
			'vibes.search' => '搜索',
			'vibes.sendMessage' => '发消息',
			'vibes.wantsToTalk' => '现在就想聊这个',
			'vibes.shareTitle' => '分享 Vibe',
			'vibes.replyTitle' => '回复 Vibe',
			'vibes.shareHint' => '写点什么',
			'vibes.shareAnonymous' => '匿名分享',
			'vibes.empty' => '过去 24 小时没有 Vibes。来发第一条吧！',
			'vibes.deleteTitle' => '删除这条 Vibe？',
			'vibes.delete' => '删除',
			'vibes.cancel' => '取消',
			'discover.title' => '发现',
			'discover.tabRooms' => '房间',
			'discover.tabDiscover' => '发现',
			'discover.tabAiMatch' => 'AI Match',
			'discover.aiMatch.feelingTitle' => '你今天心情如何',
			'discover.aiMatch.feelingSubtitle' => 'AI 会根据你的选择找到最佳匹配',
			'discover.aiMatch.lookingTitle' => '你想找什么？',
			'discover.aiMatch.moodSad' => '难过',
			'discover.aiMatch.moodMeltie' => '一般',
			'discover.aiMatch.moodBored' => '无聊',
			'discover.aiMatch.moodCrying' => '低落',
			'discover.aiMatch.moodSmile' => '开心',
			'discover.aiMatch.lookingNewFriends' => '新朋友',
			'discover.aiMatch.lookingVenting' => '倾诉',
			'discover.aiMatch.lookingFlirty' => '暧昧聊天',
			'discover.aiMatch.lookingFun' => '找乐子',
			'discover.aiMatch.lookingCultures' => '新文化',
			'discover.aiMatch.lookingLanguage' => '语言练习',
			'discover.aiMatch.statActiveUsers' => '活跃用户',
			'discover.aiMatch.statMatchRate' => '匹配率',
			'discover.aiMatch.statAvgTime' => '平均用时',
			'discover.aiMatch.statActiveValue' => '843',
			'discover.aiMatch.statMatchValue' => '87%',
			'discover.aiMatch.statAvgValue' => '8秒',
			'discover.aiMatch.startSmartMatch' => '开始智能匹配',
			'discover.aiMatch.findingTitle' => '正在寻找你的匹配',
			'discover.aiMatch.findingSubtitle' => '根据你的心情和兴趣匹配合适的人',
			'discover.aiMatch.findingStepMood' => '心情已分析',
			'discover.aiMatch.findingStepInterests' => '兴趣已匹配',
			'discover.aiMatch.findingStepCompatibility' => '正在计算契合度...',
			'discover.aiMatch.findingStepContent' => '正在生成内容...',
			'discover.aiMatch.findingOnline' => ({required Object count}) => '当前 ${count} 人在线',
			'discover.aiMatch.yourMatchTitle' => '你的匹配',
			'discover.aiMatch.yourMatchSubtitle' => '已根据你的回答为你匹配',
			'discover.aiMatch.vibeMatch' => ({required Object percent}) => '${percent}% 契合',
			'discover.aiMatch.startChatting' => '开始聊天',
			'discover.aiMatch.matchNameAge' => ({required Object name, required Object age}) => '${name}，${age}',
			'discover.aiMatch.matchBio' => '我会让你体会到从未有过的感觉。',
			'discover.aiMatch.swipePrevious' => '上一个',
			'discover.aiMatch.swipeNext' => '下一个',
			'discover.aiMatch.swipeFinger' => '滑动手指',
			'discover.aiMatch.noMatch' => '暂时没有匹配的人，稍后再试吧。',
			'discover.searchHint' => '搜索',
			'discover.allRooms' => '全部房间',
			'discover.allGroups' => '全部群组',
			'discover.seeAll' => '查看全部',
			'discover.live' => '直播中',
			'discover.join' => '加入',
			'discover.request' => '申请',
			'discover.requested' => '已申请',
			'discover.private' => '私密',
			'discover.moreCount' => ({required Object count}) => '+${count} 更多',
			'discover.activeCount' => ({required Object count}) => '${count} 人活跃',
			'discover.membersCount' => ({required Object count}) => '${count} 位成员',
			'discover.privateRoom.subtitle' => '这是私密房间，使用代币解锁进入。',
			'discover.privateRoom.roomAccess' => '房间门票',
			'discover.privateRoom.yourBalance' => '你的余额',
			'discover.privateRoom.tokensAmount' => ({required Object count}) => '${count} 代币',
			'discover.privateRoom.joinForTokens' => ({required Object count}) => '花 ${count} 代币加入',
			'discover.privateRoom.cancel' => '取消',
			'discover.roomToken.subtitle' => '使用代币解锁进入。',
			'discover.roomToken.roomAccess' => '房间门票',
			'discover.roomToken.yourBalance' => '你的余额',
			'discover.roomToken.tokensAmount' => ({required Object count}) => '${count} 代币',
			'discover.roomToken.joinForTokens' => ({required Object count}) => '花 ${count} 代币加入',
			'discover.roomToken.cancel' => '取消',
			'discover.privateRequest.title' => '申请加入',
			'discover.privateRequest.roomInfo' => ({required Object name, required Object count}) => '${name} · ${count} 位成员',
			'discover.privateRequest.messageHint' => '说点什么（可选）...',
			'discover.privateRequest.sendRequest' => '发送申请',
			'discover.privateRequest.adminReview' => '房间管理员将审核你的申请',
			'discover.roomApproved.title' => '你已加入！',
			'discover.roomApproved.subtitle' => ({required Object name}) => '已为你在 ${name} 预留位置',
			'discover.roomApproved.continueLabel' => '继续',
			'discover.createSpace.title' => '创建房间或群组',
			'discover.createSpace.subtitle' => '创建群组或直播房间，认识更多人',
			'discover.createSpace.room' => '房间',
			'discover.createSpace.group' => '群组',
			'discover.createSpace.hideAccount' => '隐藏你的账号',
			'discover.createSpace.create' => '创建',
			'discover.createSpace.cancel' => '取消',
			'discover.createSpace.createRoomTitle' => '创建房间',
			'discover.createSpace.createGroupTitle' => '创建群组',
			'discover.createSpace.nameSubtitle' => '给你创建的群组起个名字',
			'discover.createSpace.nameHint' => '夜猫子',
			'discover.createSpace.createRoomFor' => ({required Object count}) => '花 ${count} 代币创建',
			'discover.liveRoom.adminSuffix' => '（管理员）',
			'discover.liveRoom.messageHint' => '发消息',
			'discover.liveRoom.quickReplyHey' => '大家好！',
			'discover.liveRoom.quickReplyTopic' => '聊什么话题？',
			'discover.liveRoom.quickReplyNew' => '我是新来的！',
			'discover.liveRoom.sampleChatName' => 'Sona',
			'discover.liveRoom.sampleChatBody' => '我们能做点什么？你有什么想法？',
			'discover.liveRoom.roomEnded' => '房间已结束。',
			'discover.liveRoom.wantsToJoin' => ({required Object name}) => '${name} 想要加入',
			'discover.liveRoom.approve' => '同意',
			'discover.groupChat.usersCount' => ({required Object count}) => '${count} 位用户',
			'discover.groupChat.sampleVictoria' => '好无聊啊，大家要不要一起做点什么？',
			'discover.groupChat.sampleSona' => '我们能做点什么？你有什么想法？',
			'discover.groupChat.sampleOwn' => '我们在码头见吧',
			'discover.groupInfo.media' => '媒体',
			'discover.groupInfo.gallery' => '相册',
			'discover.groupInfo.settings' => '设置',
			'discover.groupInfo.notifications' => '通知',
			'discover.groupInfo.blocked' => '已屏蔽',
			'discover.groupInfo.private' => '私密',
			'discover.groupInfo.membersCount' => ({required Object count}) => '${count} 位成员',
			'discover.groupInfo.addPeople' => '添加成员',
			'discover.groupInfo.you' => '你',
			'discover.groupInfo.admin' => '管理员',
			'discover.groupInfo.leaveGroup' => '退出群组',
			'discover.groupInfo.requests' => '加入申请',
			'discover.groupInfo.approve' => '同意',
			'discover.groupInfo.reject' => '拒绝',
			'discover.groupInfo.addPeopleEmpty' => '关注他人后即可将其加入群组。',
			'discover.groupInfo.add' => '添加',
			'discover.groupInfo.makeAdmin' => '设为管理员',
			'discover.groupInfo.removeAdmin' => '取消管理员',
			'discover.groupInfo.remove' => '移出群组',
			'discover.groupInfo.leaveConfirm' => '确定退出该群组？',
			'discover.groupInfo.leave' => '退出',
			'discover.groupInfo.cancel' => '取消',
			'discover.filters.title' => '筛选',
			'discover.filters.ageRange' => '年龄范围',
			'discover.filters.ageRangeValue' => ({required Object min, required Object max}) => '${min}-${max}',
			'discover.filters.distance' => '距离',
			'discover.filters.distanceValue' => ({required Object km}) => '${km} 公里',
			'discover.filters.showMe' => '显示',
			'discover.filters.everyone' => '所有人',
			'discover.filters.women' => '女性',
			'discover.filters.men' => '男性',
			'discover.filters.interests' => '兴趣',
			'discover.filters.activeNow' => '当前活跃',
			'discover.filters.activeNowSubtitle' => '只显示当前在线的人',
			'discover.filters.showResult' => '查看结果',
			'discover.post.follow' => '关注',
			'discover.post.following' => '已关注',
			'discover.post.addComment' => '添加评论...',
			'discover.post.commentsTitle' => '评论',
			'discover.post.sampleCaption' => '美好的一天过后来杯咖啡，真是再惬意不过了。<3',
			'discover.post.hoursAgo' => ({required Object hours}) => '${hours}小时',
			'discover.post.minutesAgo' => ({required Object minutes}) => '${minutes}分钟',
			'discover.post.daysAgo' => ({required Object days}) => '${days}天',
			'discover.post.deleteCommentTitle' => '删除这条评论？',
			'discover.story.draft' => '草稿',
			'discover.story.story' => '快拍',
			'discover.story.share' => '分享',
			'discover.story.textPlaceholder' => '写点什么...',
			'discover.story.draftPrompt' => '保存为草稿？',
			'discover.story.saveToDraft' => '存为草稿',
			'discover.story.moveToTrash' => '移到废纸篓',
			'discover.story.save' => '保存',
			'discover.story.musicTitle' => '音乐',
			'discover.story.musicEmpty' => '未找到音乐。',
			'discover.story.musicError' => '无法加载音乐。',
			'discover.story.downloaded' => '已保存到相册',
			'discover.story.downloadFailed' => '保存失败',
			'discover.highlight.title' => '精选',
			'discover.highlight.view' => '查看',
			'discover.highlight.aiComments' => 'AI 评论',
			'discover.highlight.remove' => '移除精选',
			'discover.highlight.sharedSuccess' => '你的帖子已成功分享',
			'discover.highlight.boost' => '推广',
			'discover.stats.title' => '数据统计',
			'discover.stats.subtitle' => '以下是你帖子的\n相关数据。',
			'discover.stats.viewers' => '浏览',
			'discover.stats.comments' => '评论',
			'discover.stats.likes' => '点赞',
			'discover.stats.boostCta' => '推广 1 天 - 100 代币',
			'discover.stats.boosted' => '推广成功！你的帖子将置顶 24 小时。',
			'discover.hostedBy' => ({required Object name}) => '主持人：${name}',
			'common.loading' => '加载中…',
			'common.retry' => '重试',
			'common.cancel' => '取消',
			'common.save' => '保存',
			'common.continueAction' => '继续',
			'common.language' => '语言',
			'common.or' => '或',
			'languages.tr' => 'Türkçe',
			'languages.en' => 'English',
			'auth.createAccountTitle' => '创建账号',
			'auth.createAccountSubtitle' => '加入 Veylo，开始结识新朋友。',
			'auth.welcomeBackTitle' => '欢迎回来',
			'auth.welcomeBackSubtitle' => '登录以继续使用 Veylo。',
			'auth.username' => '用户名',
			'auth.usernameHint' => '选择一个用户名',
			'auth.email' => '邮箱',
			'auth.emailHint' => '输入你的邮箱',
			'auth.emailOrUsername' => '邮箱或用户名',
			'auth.emailOrUsernameHint' => '输入邮箱或用户名',
			'auth.password' => '密码',
			'auth.passwordCreateHint' => '设置密码',
			'auth.passwordEnterHint' => '输入你的密码',
			'auth.signUp' => '注册',
			'auth.logIn' => '登录',
			'auth.forgotPassword' => '忘记密码？',
			'auth.continueWithApple' => '通过 Apple 继续',
			'auth.continueWithGoogle' => '通过 Google 继续',
			'auth.legalPrefix' => '继续即表示你同意我们的',
			'auth.termsOfService' => '服务条款',
			'auth.legalMiddle' => '并知悉我们的',
			'auth.privacyPolicy' => '隐私政策',
			'auth.legalSuffix' => '。',
			'auth.passwordResetSent' => '我们已向你的邮箱发送密码重置链接。',
			'onboarding.skip' => '跳过',
			'onboarding.page1Title' => '做自己，保持匿名。',
			'onboarding.page1Subtitle' => '结识新朋友、开启对话，\n无需透露你是谁。',
			'onboarding.page2Title' => '打字、聊天，感受 Vibe。',
			'onboarding.page2Subtitle' => '从匿名开始，准备好后再发消息、通话或见面。',
			'onboarding.page3Title' => '找到同频的人，\n加入对话。',
			'onboarding.page3Subtitle' => '进入房间，结识新朋友，\n一起分享此刻。',
			'onboarding.getStarted' => '开始使用',
			'onboarding.alreadyHaveAccount' => '已有 Veylo 账号？',
			'onboarding.logInAction' => '登录',
			'createProfile.navTitle' => '创建资料',
			'createProfile.stepUsername' => '1/5 用户名',
			'createProfile.title' => '创建你的资料',
			'createProfile.subtitle' => '你的真实姓名仅用于验证——不会公开显示。',
			'createProfile.subtitleLine1' => '你的真实姓名仅用于验证——',
			'createProfile.subtitleLine2' => '不会公开显示。',
			'createProfile.fullName' => '姓名',
			'createProfile.fullNameHint' => 'Sam Lee',
			'createProfile.username' => '用户名',
			'createProfile.usernameHint' => 'samlee123',
			'createProfile.usernameTaken' => '该用户名已存在！',
			'createProfile.usernameAvailable' => '用户名可用',
			'createProfile.mightWantToTry' => '试试这些...',
			'createProfile.stepPhoto' => '2/5 头像',
			'createProfile.photoTitle' => '上传头像',
			'createProfile.photoSubtitle' => '其他用户可以通过你的头像确认是你本人。',
			'createProfile.photoSubtitleLine1' => '其他用户可以通过你的头像',
			'createProfile.photoSubtitleLine2' => '确认是你本人。',
			'createProfile.choosePhoto' => '选择照片',
			'createProfile.continueWithoutPhoto' => '不上传头像，继续',
			'createProfile.saveAndContinue' => '保存并继续',
			'createProfile.choosePhotoSheetTitle' => '选择照片',
			'createProfile.takePhoto' => '拍照',
			'createProfile.chooseFromGallery' => '从相册选择',
			'createProfile.stepGender' => '3/5 性别',
			'createProfile.genderTitle' => '选择你的性别',
			'createProfile.genderSubtitle' => '如果你选择提供此信息，我们可能会用它为你提供个性化内容',
			'createProfile.genderSubtitleLine1' => '如果你选择提供此信息，',
			'createProfile.genderSubtitleLine2' => '我们可能会用它为你提供个性化内容',
			'createProfile.genderFemale' => '女',
			'createProfile.genderMale' => '男',
			'createProfile.genderNonBinary' => '非二元',
			'createProfile.genderPreferNotToSay' => '不愿透露',
			'createProfile.stepInterests' => '4/5 兴趣',
			'createProfile.interestsTitle' => '你喜欢什么？',
			'createProfile.interestsSubtitle' => '至少选 5 个——帮你匹配真正懂你的人。',
			'createProfile.interests.music' => '音乐',
			'createProfile.interests.movies' => '电影',
			'createProfile.interests.tvShows' => '电视剧',
			'createProfile.interests.reading' => '阅读',
			'createProfile.interests.painting' => '绘画',
			'createProfile.interests.photography' => '摄影',
			'createProfile.interests.theatre' => '戏剧',
			'createProfile.interests.fitness' => '健身',
			'createProfile.interests.swimming' => '游泳',
			'createProfile.interests.football' => '足球',
			'createProfile.interests.basketball' => '篮球',
			'createProfile.interests.coffee' => '咖啡',
			'createProfile.interests.travel' => '旅行',
			'createProfile.interests.camping' => '露营',
			'createProfile.interests.meditation' => '冥想',
			'createProfile.interests.videoGames' => '电子游戏',
			'createProfile.interests.boardGames' => '桌游',
			'createProfile.interests.standUp' => '脱口秀',
			'createProfile.interests.tech' => '科技',
			'createProfile.interests.coding' => '编程',
			'createProfile.interests.ai' => 'AI',
			'createProfile.interests.podcast' => '播客',
			'createProfile.stepChatGoal' => '5/5 聊天目标',
			'createProfile.chatGoalTitle' => '你今天想找什么？',
			'createProfile.chatGoalSubtitle' => '这能帮我们根据你此刻的心情找到合适的人。',
			_ => null,
		} ?? switch (path) {
			'createProfile.chatGoalQuickMatch' => '快速匹配——直接\n开聊',
			'createProfile.chatGoalFlirtyChat' => '暧昧聊天——轻松、俏皮的\n对话',
			'createProfile.chatGoalMoodMatch' => '心情匹配——根据你此刻的\n感受匹配',
			'createProfile.chatGoalLateNight' => '深夜畅聊——夜深人静时的\n走心对话',
			'createProfile.chatGoalMeetSomeoneNew' => '认识新朋友——没有特定目标，\n随便看看',
			'createProfile.getStarted' => '开始使用',
			'createProfile.preparingTitleLine1' => '我们正在为你',
			'createProfile.preparingTitleLine2' => '准备合适的',
			'createProfile.preparingTitleLine3' => '人选。',
			'createProfile.preparingSubtitleLine1' => '我们正根据你的回答',
			'createProfile.preparingSubtitleLine2' => '挑选最佳匹配，请稍候。',
			'createProfile.preparingPercent' => ({required Object percent}) => '${percent}%',
			'createProfile.usernameInvalid' => '请使用 3–30 位字母、数字、点或下划线。',
			'errors.network' => '无法连接 Veylo。请检查网络后重试。',
			'errors.generic' => '出错了，请重试。',
			'errors.signInFailed' => '登录失败，请重试。',
			'errors.sessionExpired' => '登录已过期，请重新登录。',
			'errors.accountSuspended' => '该账号已被停用。',
			'errors.unsupportedImage' => '请选择 JPEG、PNG 或 WebP 格式的照片。',
			'errors.fileTooLarge' => '文件过大。',
			'errors.enterEmailForReset' => '请在上方输入邮箱以重置密码。',
			'errors.wrongCredentials' => '邮箱/用户名或密码错误。',
			'errors.emailInUse' => '该邮箱已注册，请尝试登录。',
			'errors.weakPassword' => '密码至少需要 6 个字符。',
			'errors.invalidEmail' => '请输入有效的邮箱地址。',
			'errors.tooManyAttempts' => '尝试次数过多，请稍后再试。',
			'errors.fillAllFields' => '请填写所有字段。',
			'errors.insufficientTokens' => '代币不足。',
			'errors.requestNotAccepted' => '接受请求后才能回复。',
			'errors.requestPendingLimit' => '对方接受你的请求后，你才能发送更多消息。',
			'errors.blocked' => '你无法给此人发消息。',
			'errors.peerUnavailable' => '该账号已不可用。',
			'errors.vibeDailyLimit' => '你今天已分享了很多 Vibes，请稍后再试。',
			'errors.groupFull' => '该群组已满。',
			'errors.groupCreateLimit' => '你今天创建的群组过多，请稍后再试。',
			'errors.notFound' => '该内容已不可用。',
			'errors.recentLogin' => '为了你的安全，请退出后重新登录，然后再试一次。',
			'errors.socialAccount' => '你的邮箱和密码由你的 Google 或 Apple 账号管理。',
			'errors.alreadyInCall' => '你已在通话中。',
			'errors.roomPrivate' => '这是私密房间，请联系房主申请加入。',
			'errors.roomFull' => '该房间已满。',
			'faq.q1' => '这个应用怎么用？',
			'faq.q2' => '什么是匿名聊天？',
			'faq.q3' => '什么是亲密度进度？',
			'faq.q4' => '如何公开我的资料？',
			'faq.q5' => '什么是60秒陌生人？',
			'faq.q6' => '什么是 Vibes？',
			'faq.q7' => '如何编辑我的资料？',
			'faq.q8' => '如何管理通知？',
			'faq.q9' => '如何恢复购买？',
			'faq.q10' => '可以删除所有对话吗？',
			'faq.q11' => '我的数据安全吗？',
			'faq.q12' => '如何拉黑或举报他人？',
			'faq.q13' => '如何分享应用？',
			'faq.q14' => '如何删除我的账号？',
			'faq.a1' => '在 Veylo 上，你可以匿名结识新朋友、聊天，并随着亲密度提升逐步公开你的资料。双方都准备好后，可随时切换到文字、语音或面对面交流。',
			'faq.a2' => '匿名聊天中，你的身份和照片都会被隐藏。随着亲密度提升，你可以解锁名字首字母和模糊照片等信息。达到 100% 时，需双方都同意才能公开完整资料。',
			'faq.a3' => '聊得越多，亲密度百分比越高。达到特定里程碑后，你可以解锁名字首字母、模糊照片和完整资料。点击“亲密度”标签即可查看详情。',
			'faq.a4' => '亲密度达到 100% 时，点击“公开我的资料”。如果对方也同意，双方的完整资料都会显示。',
			'faq.a5' => '在“通话”页，你可以快速随机匹配一位陌生人。时间到后，你可以选择继续聊或结束通话。',
			'faq.a6' => '通过 Vibes，你可以在地图/列表视图中发现附近或身边的人，并和感兴趣的人开始聊天。',
			'faq.a7' => '打开“我的”页面，进入“编辑资料”即可更新姓名、照片、简介和兴趣。保存后更改即会生效。',
			'faq.a8' => '在“设置”中打开“通知”，即可开启或关闭消息、匹配及其他提醒。',
			'faq.a9' => '前往“设置 → 账号管理 → 恢复购买”。同一商店账号下符合条件的购买将被恢复。',
			'faq.a10' => '可以。前往“设置 → 删除对话”并确认，所有聊天都将被删除。此操作无法撤销。',
			'faq.a11' => '你的账号信息和消息存储在受保护的系统中。你也可以随时在“账号管理”中申请删除账号和数据。',
			'faq.a12' => '在资料页或聊天页的菜单中即可拉黑或举报。我们的团队会审核举报内容。',
			'faq.a13' => '在“设置”中使用“分享应用”复制链接，发送给好友即可。',
			'faq.a14' => '前往“设置 → 账号管理 → 删除账号和数据”。填写原因后，确认即可提交删除申请。',
			'legal.termsTitle' => '服务条款',
			'legal.privacyTitle' => '隐私政策',
			'legal.termsBody' => '最后更新：2026年3月16日\n\n欢迎使用 Veylo。创建账号或使用本应用，即表示你同意本服务条款。\n\n1. Veylo 是什么\nVeylo 是一款社交应用，你可以在这里结识他人、匿名聊天、随时间建立联系，并在双方同意时选择进行语音或面对面通话。\n\n2. 你的账号\n你必须提供准确的信息并妥善保管登录凭据。你需对账号下的所有活动负责。你必须达到所在国家法律规定的可使用 Veylo 的年龄。\n\n3. 文明使用\n请勿骚扰、威胁、诈骗、冒充他人、分享违法内容或试图绕过安全功能。对于违反这些规则的行为，我们可能会删除内容、限制功能或停用账号。\n\n4. 匿名聊天与资料公开\n在达到亲密度里程碑之前，匿名聊天可能会隐藏你的姓名和照片。公开完整资料需要双方同意。请勿强迫他人公开身份。\n\n5. 购买\n部分功能可能需要付费。购买由 Apple App Store 或 Google Play 处理。“恢复购买”可恢复同一商店账号下符合条件的购买。退款遵循相应商店的政策。\n\n6. 你分享的内容\n你保留对自己内容的权利，但授予 Veylo 一项许可，以便在运营服务所需范围内于应用中托管和展示这些内容。请勿发布你无权分享的内容。\n\n7. 终止使用\n你可以随时停止使用 Veylo，并在“设置”中申请删除账号。在必要时，我们也可能在合理通知后终止或变更服务。\n\n8. 联系我们\n有关本条款的问题：support@veylo.app',
			'legal.privacyBody' => '最后更新：2026年3月16日\n\n本隐私政策说明 Veylo 如何收集、使用和保护你的信息。\n\n1. 我们收集的信息\n• 账号数据：邮箱、显示名称、头像照片、个人简介、偏好设置\n• 使用数据：聊天内容、亲密度进度、你使用的通话功能、设备/应用基本信息\n• 购买信息：解锁和恢复付费功能所需的商店收据数据\n\n2. 我们如何使用\n我们使用你的数据来运营 Veylo、个性化匹配和聊天体验、维护社区安全、处理购买并改进产品。我们不会出售你的个人数据。\n\n3. 匿名模式\n在匿名聊天中，我们会限制他人可见的信息（例如隐藏姓名或模糊照片），直到解锁规则和双方同意允许展示更多内容。在后台，我们仍需使用账号标识符来安全地运行该功能。\n\n4. 信息共享\n我们可能会与帮助我们托管、分析或处理付款的服务提供商共享数据——仅限必要范围。在法律要求或为保护用户免受伤害时，我们也可能披露信息。\n\n5. 数据保留\n在你的账号有效期间，以及出于法律、安全和账务原因需要时，我们会保留数据。删除申请完成后，除法律要求保留的情况外，我们会删除个人数据或对其进行匿名化处理。\n\n6. 你的选择\n你可以编辑资料信息、管理通知、申请删除账号，并就你的数据与我们联系。商店购买也可通过 Apple 或 Google 进行管理。\n\n7. 安全\n我们采取合理的技术和组织措施来保护你的信息。没有任何系统是绝对安全的；请使用强密码并保持设备更新。\n\n8. 联系我们\n隐私相关问题：privacy@veylo.app',
			'logout.title' => '退出登录',
			'logout.subtitle' => '确定要退出登录吗？',
			'logout.cancel' => '取消',
			'logout.confirm' => '退出登录',
			'deleteAccount.title' => '提交账号删除申请',
			'deleteAccount.subtitle' => '确定要删除你的账号吗？',
			'deleteAccount.reasonTitle' => '我们舍不得你走，但我们理解。',
			'deleteAccount.reasonBefore' => '能告诉我们你离开的原因吗？这将帮助我们改进 ',
			'deleteAccount.reasonAfter' => ' 的体验。',
			'deleteAccount.reasonLabel' => '你为什么要删除账号',
			'deleteAccount.reasonHint' => '输入你的内容',
			'deleteAccount.cancel' => '取消',
			'deleteAccount.createRequest' => '提交申请',
			'deleteAccount.confirmTitle' => '确定要提交删除申请吗？',
			'deleteAccount.confirmSubtitle' => '确认后，你的账号删除申请将被提交',
			'deleteAccount.delete' => '删除',
			'storyText.bold' => '粗体',
			'storyText.italic' => '斜体',
			'storyText.uppercase' => '大写',
			'storyText.underline' => '下划线',
			'storyText.cancel' => '取消',
			'storyText.galleryError' => '无法打开相册',
			_ => null,
		};
	}
}
