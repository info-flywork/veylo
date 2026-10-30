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
class TranslationsJa extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsJa({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ja,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ja>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key) ?? super[key];

	late final TranslationsJa _root = this; // ignore: unused_field

	@override 
	TranslationsJa $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsJa(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$app$ja app = _Translations$app$ja._(_root);
	@override late final _Translations$home$ja home = _Translations$home$ja._(_root);
	@override late final _Translations$chats$ja chats = _Translations$chats$ja._(_root);
	@override late final _Translations$profile$ja profile = _Translations$profile$ja._(_root);
	@override late final _Translations$nav$ja nav = _Translations$nav$ja._(_root);
	@override late final _Translations$call$ja call = _Translations$call$ja._(_root);
	@override late final _Translations$vibes$ja vibes = _Translations$vibes$ja._(_root);
	@override late final _Translations$discover$ja discover = _Translations$discover$ja._(_root);
	@override late final _Translations$common$ja common = _Translations$common$ja._(_root);
	@override late final _Translations$languages$ja languages = _Translations$languages$ja._(_root);
	@override late final _Translations$auth$ja auth = _Translations$auth$ja._(_root);
	@override late final _Translations$onboarding$ja onboarding = _Translations$onboarding$ja._(_root);
	@override late final _Translations$createProfile$ja createProfile = _Translations$createProfile$ja._(_root);
	@override late final _Translations$errors$ja errors = _Translations$errors$ja._(_root);
	@override late final _Translations$faq$ja faq = _Translations$faq$ja._(_root);
	@override late final _Translations$legal$ja legal = _Translations$legal$ja._(_root);
	@override late final _Translations$logout$ja logout = _Translations$logout$ja._(_root);
	@override late final _Translations$deleteAccount$ja deleteAccount = _Translations$deleteAccount$ja._(_root);
	@override late final _Translations$storyText$ja storyText = _Translations$storyText$ja._(_root);
	@override late final _Translations$tokens$ja tokens = _Translations$tokens$ja._(_root);
}

// Path: app
class _Translations$app$ja extends Translations$app$tr {
	_Translations$app$ja._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get name => 'Veylo';
	@override String get tagline => 'ようこそ';
}

// Path: home
class _Translations$home$ja extends Translations$home$tr {
	_Translations$home$ja._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'ホーム';
	@override String get subtitle => 'アプリを準備中です';
	@override String get body => '多言語UIはslangで管理されています。';
}

// Path: chats
class _Translations$chats$ja extends Translations$chats$tr {
	_Translations$chats$ja._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'チャット';
	@override String get search => '検索';
	@override String get messagesSection => 'メッセージ';
	@override String get request => 'リクエスト';
	@override String get emptyRequestTitle => '最近のメッセージ\n通知はありません';
	@override String get emptyRequestSubtitle => '30日以上前のリクエストは表示されません。';
	@override String get noteAdd => 'ノートを追加';
	@override String get anonymous => '匿名';
	@override String get online => 'オンライン';
	@override String get offline => 'オフライン';
	@override String get connection => 'つながり';
	@override String connectionPercent({required Object n}) => '${n}%';
	@override String get connectionProgressTitle => 'つながり度';
	@override String get milestoneInitial => '名前のイニシャル';
	@override String get milestoneInitialHint => '25%で解除済み';
	@override String get milestoneInitialLocked => '25%で解除';
	@override String get milestonePhoto => 'ぼかし写真のプレビュー';
	@override String get milestonePhotoHint => '70%で解除';
	@override String get milestoneFull => 'プロフィール全体を表示';
	@override String get milestoneFullHint => '100%でお互いの同意が必要';
	@override String get sampleAnonymousMessage => 'こんにちは、お話しできてうれしいです。あなたのことを少し教えてもらえますか？';
	@override String get strangerSampleMessage => 'こんにちは、Jhonさん。お話しできてうれしいです。あなたのことを少し教えてもらえますか？';
	@override String get approve => '承認';
	@override String get blockUser => 'ユーザーをブロック';
	@override String get reject => '拒否';
	@override String get messageHint => 'やあ！元気？';
	@override String get revealTitle => '100%に到達しました';
	@override String get revealSubtitle => 'お互いのプロフィールを公開しますか？両方の同意が必要です。';
	@override String revealWaiting({required Object name}) => '${name}さんの承認を待っています';
	@override String get revealCta => 'プロフィールを公開';
	@override String get revealNotYet => 'まだしない';
	@override String get seen => '既読';
	@override String get typing => '入力中…';
	@override String get noteYou => 'あなた';
	@override String get noteSheetTitle => 'ノートをシェア';
	@override String get noteSheetSubtitle => 'ノートは24時間表示されます';
	@override String get noteHint => '今なにしてる？';
	@override String get noteShare => 'シェア';
	@override String get noteDelete => 'ノートを削除';
}

// Path: profile
class _Translations$profile$ja extends Translations$profile$tr {
	_Translations$profile$ja._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get eyebrow => 'プロフィール';
	@override String get title => '設定';
	@override String get editProfile => 'プロフィールを編集';
	@override String get statLike => 'いいね';
	@override String get statFollow => 'フォロー';
	@override String get statFollower => 'フォロワー';
	@override String get promoTitle => 'もっとメッセージをもらおう！';
	@override String get promoSubtitle => '目立って、リストの上位に表示されよう';
	@override String get standOut => '目立つ';
	@override String get tabPosts => '投稿';
	@override String get tabVideo => '動画';
	@override String get tabSaved => '保存済み';
	@override String get save => '保存';
	@override String get changePhoto => '写真を変更';
	@override String get changeBorder => 'フレームを変更';
	@override String get interest => '興味';
	@override String get name => '名前';
	@override String get changeName => '名前を変更';
	@override String get changePassword => 'パスワードを変更';
	@override String get confirmPassword => 'パスワードを確認';
	@override String get email => 'メールアドレス';
	@override String get accountManagement => 'アカウント管理';
	@override String get settingsAbout => 'このアプリについて';
	@override String get settingsAccount => 'アカウント設定';
	@override String get settingsSupport => 'サポート';
	@override String get shareApp => 'アプリをシェア';
	@override String get shareAppTitle => '友達にシェア';
	@override String get shareAppSubtitle => 'Veyloを友達にシェアして、一緒に楽しもう！';
	@override String get shareAppLabel => 'アプリのリンク';
	@override String get rateApp => '気に入った？評価してね';
	@override String get notifications => '通知';
	@override String get password => 'パスワード';
	@override String get deleteConversation => '会話を削除';
	@override String get faqHelp => 'よくある質問とヘルプ';
	@override String get restorePurchases => '購入を復元';
	@override String get termsOfService => '利用規約';
	@override String get privacyPolicy => 'プライバシーポリシー';
	@override String get restorePurchasesDone => '購入履歴を確認しました';
	@override String get conversationsDeleted => 'すべての会話を削除しました';
	@override String get logOut => 'ログアウト';
	@override String get deleteAccountAndData => 'アカウントとデータを削除';
	@override String get passwordPlaceholder => '********';
	@override String get height => '身長';
	@override String get addHeight => '身長を追加';
	@override String heightCm({required Object value}) => '${value} cm';
	@override String get languages => '言語';
	@override String get relationshipGoals => '求める関係';
	@override String get lookingFor => '探しているもの';
	@override String get newFriends => '👋 新しい友達';
	@override String get goalLongTermOpenToShort => '💕 長期希望、短期もOK';
	@override String get goalLongTermRelationship => '💘 長期的な関係';
	@override String get goalNewFriends => '👋 新しい友達';
	@override String get goalShortTermFun => '🥃 気軽に楽しく';
	@override String get goalStillFiguringItOut => '🤔 まだ考え中';
	@override String get basics => '基本情報';
	@override String get zodiac => '星座';
	@override String get zodiacValue => 'さそり座';
	@override String get education => '学歴';
	@override String get educationValue => '学士';
	@override String get educationHighSchool => '高校';
	@override String get educationAssociates => '短大・専門';
	@override String get educationBachelors => '学士';
	@override String get educationMasters => '修士';
	@override String get educationPhd => '博士';
	@override String get voiceRecord => 'ボイス録音';
	@override String get addVoice => 'ボイスを追加';
	@override String get lifestyle => 'ライフスタイル';
	@override String get pets => 'ペット';
	@override String get petsValue => '猫を飼っています';
	@override String get petsDontWant => 'ペットは欲しくない';
	@override String get petsAllergic => 'ペットアレルギーです';
	@override String get petsHaveCat => '猫を飼っています';
	@override String get petsHaveDog => '犬を飼っています';
	@override String get petsHaveCatsAndDogs => '猫と犬を飼っています';
	@override String get petsHaveOther => '他のペットを飼っています';
	@override String get drinking => 'お酒';
	@override String get drinkingValue => '特別な時だけ';
	@override String get drinkingNever => '飲まない';
	@override String get drinkingSpecialOccasions => '特別な時だけ';
	@override String get drinkingSocially => '付き合い程度';
	@override String get drinkingFrequently => 'よく飲む';
	@override String get drinkingSober => '禁酒中';
	@override String get drinkingPreferNotToSay => '答えたくない';
	@override String get smoking => 'タバコ';
	@override String get smokingValue => '吸わない';
	@override String get smokingNonSmoker => '吸わない';
	@override String get smokingSocialSmoker => '付き合い程度';
	@override String get smokingSmoker => '吸う';
	@override String get smokingTryingToQuit => '禁煙中';
	@override String get smokingWhenDrinking => '飲む時だけ吸う';
	@override String get smokingPreferNotToSay => '答えたくない';
	@override String get gender => '性別';
	@override String get genderFemale => '女性';
	@override String get genderMale => '男性';
	@override String get genderPreferNotToSay => '答えたくない';
	@override String get visible => '表示';
	@override String get profileVisibility => 'プロフィールの公開範囲';
	@override String get language => '言語';
	@override String get borderTitle => 'プロフィールフレーム';
	@override String get borderSubtitle => 'プロフィールにフレームを付けて\nもっと目立とう。';
	@override String get borderBuySection => 'フレームを購入';
	@override String get borderBuyCta => 'フレームを購入';
	@override String borderToken({required Object count}) => '${count} トークン';
	@override String get borderAmethystWings => 'Amethyst Wings';
	@override String get borderGoldenPhoenix => 'Golden Phoenix';
	@override String get borderFrostCrown => 'Frost Crown';
	@override String get borderEmeraldWhisper => 'Emerald Whisper';
	@override String get borderRoseQuartz => 'Rose Quartz';
	@override String get borderStarlitComet => 'Starlit Comet';
	@override String get borderCrimsonRoyal => 'Crimson Royal';
	@override String get borderSapphireHalo => 'Sapphire Halo';
	@override String get follow => 'フォロー';
	@override String get following => 'フォロー中';
	@override String get followPageTitle => 'フォロー';
	@override String get followTabFollowing => 'フォロー中';
	@override String get followTabFollowers => 'フォロワー';
	@override String get followSearch => '検索';
	@override String get unfollow => 'フォロー解除';
	@override String get followSortTitle => '並び替え';
	@override String get followSortRecent => '最近フォローした人';
	@override String get followSortNotFollowingMe => 'フォローバックしていない人';
	@override String get followSortNotFollowedByMe => '自分がフォローバックしていない人';
	@override String get followSortShowResult => '結果を表示';
	@override String get followSortEmpty => '条件に合うユーザーはいません';
	@override String get shareTitle => '友達にシェア';
	@override String get shareSubtitle => '友達とつながれば\nもっと楽しくなる！';
	@override String get shareProfileLabel => 'プロフィールをシェア';
	@override String get shareLinkCopied => 'リンクをコピーしました';
	@override String get restrict => '制限';
	@override String get block => 'ブロック';
	@override String get report => '報告';
	@override String blockTitle({required Object username}) => '${username}さんをブロックしますか？';
	@override String get blockBody => '相手が持っている、または今後作成する他のアカウントもブロックされます。ブロックはいつでも解除できます。';
	@override String get blockAndReport => 'ブロックして報告';
	@override String restrictTitle({required Object username}) => '${username}さんを制限しますか？';
	@override String get restrictBody => '相手はあなたがオンラインかどうかや、メッセージを読んだかどうかを確認できなくなります。設定はいつでも変更できます。';
	@override String get restrictAndReport => '制限して報告';
	@override String get reportTitle => '理由を教えてください';
	@override String get reportSubtitle => 'より良い体験を提供するため、このユーザーを報告する理由を教えてもらえますか？';
	@override String get reportMessageLabel => '報告内容';
	@override String get reportMessageHint => 'メッセージを入力';
	@override String get reportCancel => 'キャンセル';
	@override String get sendReport => '報告を送信';
	@override String get notSet => '未設定';
	@override String get reportSent => 'ありがとうございます。報告を受け付けました。';
	@override String emailVerificationSent({required Object email}) => '${email} に確認リンクを送信しました。確認後にメールアドレスが変更されます。';
	@override String get passwordChanged => 'パスワードを更新しました。';
	@override String get passwordMismatch => 'パスワードが一致しません。';
}

// Path: nav
class _Translations$nav$ja extends Translations$nav$tr {
	_Translations$nav$ja._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get discover => '発見';
	@override String get chat => 'チャット';
	@override String get call => '通話';
	@override String get vibes => 'Vibes';
	@override String get profile => 'プロフィール';
}

// Path: call
class _Translations$call$ja extends Translations$call$tr {
	_Translations$call$ja._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => '60秒ストレンジャー';
	@override String get subtitle => '知らない誰かと60秒間おしゃべり。完全匿名で、プロフィールも写真も名前もなし。声とその瞬間だけ。';
	@override String get findingTitle => '相手を探しています...';
	@override String get findingSubtitle => '60秒間、匿名で話せます。プロフィールも名前もなし。';
	@override String get callStranger => '通話する - 10トークン';
	@override String get cancel => 'キャンセル';
	@override String get female => '女性';
	@override String get male => '男性';
	@override String get nonBinary => 'ノンバイナリー';
	@override String get preferNotToSay => '答えたくない';
	@override String get anonymousBadge => '🎙️ 匿名音声通話';
	@override String get stranger => 'ストレンジャー';
	@override String secondsLeft({required Object n}) => '${n}秒';
	@override String get timesUpTitle => '時間切れ！';
	@override String get timesUpSubtitle => 'もっと話したい？お互いがOKならチャットが解放されます。';
	@override String get keepTalking => '話し続ける';
	@override String get endCall => '通話を終了';
	@override String get waitingOther => '相手の返事を待っています...';
	@override String get callStrangerFree => '通話する';
	@override String get peerLeft => '相手が通話を終了しました。';
	@override String get noKeep => '今回はチャットが解放されませんでした。';
	@override String get videoWaiting => '相手がビデオ通話を承認するのを待っています...';
	@override String get videoDeclined => '相手がビデオ通話を拒否しました。';
	@override String get micDenied => '通話にはマイクへのアクセスが必要です。設定から有効にできます。';
	@override String get videoCost => 'ビデオ通話：15分 / 20トークン';
	@override String get calling => '発信中';
	@override String get accept => '応答';
	@override String get decline => '拒否';
	@override String get switchToVideo => 'ビデオ通話に切り替えますか？';
	@override String get noMatchTitle => '今は話せる人がいません';
	@override String get noMatchBody => '現在、話せる相手が見つかりませんでした。少し時間をおいてもう一度お試しください。';
	@override String get noMatchOk => 'OK';
}

// Path: vibes
class _Translations$vibes$ja extends Translations$vibes$tr {
	_Translations$vibes$ja._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get search => '検索';
	@override String get sendMessage => 'メッセージを送る';
	@override String get wantsToTalk => '今このことについて話したい';
	@override String get shareTitle => 'Vibeをシェア';
	@override String get replyTitle => 'Vibeに返信';
	@override String get shareHint => '何か書いてみよう';
	@override String get shareAnonymous => '匿名でシェア';
	@override String get empty => '過去24時間のVibesはありません。最初の投稿をしよう！';
	@override String get deleteTitle => 'このVibeを削除しますか？';
	@override String get delete => '削除';
	@override String get cancel => 'キャンセル';
}

// Path: discover
class _Translations$discover$ja extends Translations$discover$tr {
	_Translations$discover$ja._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => '発見';
	@override String get tabRooms => 'ルーム';
	@override String get tabDiscover => '発見';
	@override String get tabAiMatch => 'AI Match';
	@override late final _Translations$discover$aiMatch$ja aiMatch = _Translations$discover$aiMatch$ja._(_root);
	@override String get searchHint => '検索';
	@override String get allRooms => 'すべてのルーム';
	@override String get allGroups => 'すべてのグループ';
	@override String get seeAll => 'すべて見る';
	@override String get live => 'ライブ';
	@override String get join => '参加';
	@override String get request => 'リクエスト';
	@override String get requested => 'リクエスト済み';
	@override String get private => '非公開';
	@override String moreCount({required Object count}) => '+${count}人';
	@override String activeCount({required Object count}) => '${count}人がアクティブ';
	@override String membersCount({required Object count}) => 'メンバー${count}人';
	@override late final _Translations$discover$privateRoom$ja privateRoom = _Translations$discover$privateRoom$ja._(_root);
	@override late final _Translations$discover$roomToken$ja roomToken = _Translations$discover$roomToken$ja._(_root);
	@override late final _Translations$discover$privateRequest$ja privateRequest = _Translations$discover$privateRequest$ja._(_root);
	@override late final _Translations$discover$roomApproved$ja roomApproved = _Translations$discover$roomApproved$ja._(_root);
	@override late final _Translations$discover$createSpace$ja createSpace = _Translations$discover$createSpace$ja._(_root);
	@override late final _Translations$discover$liveRoom$ja liveRoom = _Translations$discover$liveRoom$ja._(_root);
	@override late final _Translations$discover$groupChat$ja groupChat = _Translations$discover$groupChat$ja._(_root);
	@override late final _Translations$discover$groupInfo$ja groupInfo = _Translations$discover$groupInfo$ja._(_root);
	@override late final _Translations$discover$filters$ja filters = _Translations$discover$filters$ja._(_root);
	@override late final _Translations$discover$post$ja post = _Translations$discover$post$ja._(_root);
	@override late final _Translations$discover$story$ja story = _Translations$discover$story$ja._(_root);
	@override late final _Translations$discover$highlight$ja highlight = _Translations$discover$highlight$ja._(_root);
	@override late final _Translations$discover$stats$ja stats = _Translations$discover$stats$ja._(_root);
	@override String hostedBy({required Object name}) => 'ホスト：${name}';
}

// Path: common
class _Translations$common$ja extends Translations$common$tr {
	_Translations$common$ja._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get loading => '読み込み中…';
	@override String get retry => '再試行';
	@override String get cancel => 'キャンセル';
	@override String get save => '保存';
	@override String get continueAction => '続ける';
	@override String get language => '言語';
	@override String get or => 'または';
}

// Path: languages
class _Translations$languages$ja extends Translations$languages$tr {
	_Translations$languages$ja._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get tr => 'Türkçe';
	@override String get en => 'English';
}

// Path: auth
class _Translations$auth$ja extends Translations$auth$tr {
	_Translations$auth$ja._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get createAccountTitle => 'アカウントを作成';
	@override String get createAccountSubtitle => 'Veyloに参加して、つながりを始めよう。';
	@override String get welcomeBackTitle => 'おかえりなさい';
	@override String get welcomeBackSubtitle => 'ログインしてVeyloを続けよう。';
	@override String get username => 'ユーザー名';
	@override String get usernameHint => 'ユーザー名を決める';
	@override String get email => 'メールアドレス';
	@override String get emailHint => 'メールアドレスを入力';
	@override String get emailOrUsername => 'メールアドレスまたはユーザー名';
	@override String get emailOrUsernameHint => 'メールアドレスまたはユーザー名を入力';
	@override String get password => 'パスワード';
	@override String get passwordCreateHint => 'パスワードを作成';
	@override String get passwordEnterHint => 'パスワードを入力';
	@override String get signUp => '新規登録';
	@override String get logIn => 'ログイン';
	@override String get forgotPassword => 'パスワードをお忘れですか？';
	@override String get continueWithApple => 'Appleで続ける';
	@override String get continueWithGoogle => 'Googleで続ける';
	@override String get legalPrefix => '続けることで、';
	@override String get termsOfService => '利用規約';
	@override String get legalMiddle => 'に同意し、';
	@override String get privacyPolicy => 'プライバシーポリシー';
	@override String get legalSuffix => 'を確認したものとみなされます。';
	@override String get passwordResetSent => 'パスワード再設定用のリンクをメールで送信しました。';
}

// Path: onboarding
class _Translations$onboarding$ja extends Translations$onboarding$tr {
	_Translations$onboarding$ja._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get skip => 'スキップ';
	@override String get page1Title => 'ありのままで、匿名のままで。';
	@override String get page1Subtitle => '正体を明かさずに\n新しい人と出会って話そう。';
	@override String get page2Title => 'メッセージも通話も、ノリで。';
	@override String get page2Subtitle => 'まずは匿名で。準備ができたら、メッセージ、通話、そして直接会うことも。';
	@override String get page3Title => '仲間を見つけて、\n会話に参加しよう。';
	@override String get page3Subtitle => 'ルームに参加して、新しい人と出会い、\nその瞬間を一緒に楽しもう。';
	@override String get getStarted => 'はじめる';
	@override String get alreadyHaveAccount => 'Veyloアカウントをお持ちの方は ';
	@override String get logInAction => 'ログイン';
}

// Path: createProfile
class _Translations$createProfile$ja extends Translations$createProfile$tr {
	_Translations$createProfile$ja._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get navTitle => 'プロフィール作成';
	@override String get stepUsername => '1/5 ユーザー名';
	@override String get title => 'プロフィールを作成';
	@override String get subtitle => '本名は本人確認にのみ使用され、公開されることはありません。';
	@override String get subtitleLine1 => '本名は本人確認にのみ使用され、';
	@override String get subtitleLine2 => '公開されることはありません。';
	@override String get fullName => '氏名';
	@override String get fullNameHint => 'Sam Lee';
	@override String get username => 'ユーザー名';
	@override String get usernameHint => 'samlee123';
	@override String get usernameTaken => 'このユーザー名は既に使われています！';
	@override String get usernameAvailable => 'このユーザー名は使用できます';
	@override String get mightWantToTry => 'こちらはいかが？';
	@override String get stepPhoto => '2/5 プロフィール写真';
	@override String get photoTitle => 'プロフィール写真をアップロード';
	@override String get photoSubtitle => '他のユーザーがあなた本人だと確認できるよう、プロフィール写真が表示されます。';
	@override String get photoSubtitleLine1 => '他のユーザーがあなた本人だと確認できるよう、';
	@override String get photoSubtitleLine2 => 'プロフィール写真が表示されます。';
	@override String get choosePhoto => '写真を選ぶ';
	@override String get continueWithoutPhoto => '写真なしで続ける';
	@override String get saveAndContinue => '保存して続ける';
	@override String get choosePhotoSheetTitle => '写真を選ぶ';
	@override String get takePhoto => '写真を撮る';
	@override String get chooseFromGallery => 'ライブラリから選ぶ';
	@override String get stepGender => '3/5 性別';
	@override String get genderTitle => '性別を選択';
	@override String get genderSubtitle => 'この情報を提供いただいた場合、あなたに合ったコンテンツの表示に使用することがあります';
	@override String get genderSubtitleLine1 => 'この情報を提供いただいた場合、あなたに合った';
	@override String get genderSubtitleLine2 => 'コンテンツの表示に使用することがあります';
	@override String get genderFemale => '女性';
	@override String get genderMale => '男性';
	@override String get genderNonBinary => 'ノンバイナリー';
	@override String get genderPreferNotToSay => '答えたくない';
	@override String get stepInterests => '4/5 興味';
	@override String get interestsTitle => '何が好き？';
	@override String get interestsSubtitle => '5つ以上選んでね。あなたを本当に分かってくれる人とマッチしやすくなります。';
	@override late final _Translations$createProfile$interests$ja interests = _Translations$createProfile$interests$ja._(_root);
	@override String get stepChatGoal => '5/5 チャットの目的';
	@override String get chatGoalTitle => '今日は何を探してる？';
	@override String get chatGoalSubtitle => '今の気分にぴったりの相手を見つけるのに役立ちます。';
	@override String get chatGoalQuickMatch => 'クイックマッチ — すぐに\n会話を始める';
	@override String get chatGoalFlirtyChat => 'ドキドキトーク — 軽くて楽しい\n会話';
	@override String get chatGoalMoodMatch => '気分マッチ — 今の気持ちで\nマッチング';
	@override String get chatGoalLateNight => '深夜トーク — みんなが寝静まった頃に\nじっくり話す';
	@override String get chatGoalMeetSomeoneNew => '新しい出会い — 目的なしで\n気軽に探す';
	@override String get getStarted => 'はじめる';
	@override String get preparingTitleLine1 => 'あなたにぴったりの';
	@override String get preparingTitleLine2 => 'プロフィールを';
	@override String get preparingTitleLine3 => '準備しています。';
	@override String get preparingSubtitleLine1 => 'あなたの回答をもとに';
	@override String get preparingSubtitleLine2 => '最適な相手を選んでいます。少々お待ちください。';
	@override String preparingPercent({required Object percent}) => '${percent}%';
	@override String get usernameInvalid => '3〜30文字の英数字、ピリオド、アンダースコアを使用してください。';
}

// Path: errors
class _Translations$errors$ja extends Translations$errors$tr {
	_Translations$errors$ja._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get network => 'Veyloに接続できません。接続を確認して、もう一度お試しください。';
	@override String get generic => 'エラーが発生しました。もう一度お試しください。';
	@override String get signInFailed => 'ログインに失敗しました。もう一度お試しください。';
	@override String get sessionExpired => 'セッションが終了しました。もう一度ログインしてください。';
	@override String get accountSuspended => 'このアカウントは停止されています。';
	@override String get unsupportedImage => 'JPEG、PNG、WebPの写真を選んでください。';
	@override String get fileTooLarge => 'ファイルサイズが大きすぎます。';
	@override String get enterEmailForReset => 'パスワードを再設定するには、上にメールアドレスを入力してください。';
	@override String get wrongCredentials => 'メールアドレス/ユーザー名またはパスワードが正しくありません。';
	@override String get emailInUse => 'このメールアドレスは既に登録されています。ログインしてみてください。';
	@override String get weakPassword => 'パスワードは6文字以上にしてください。';
	@override String get invalidEmail => '有効なメールアドレスを入力してください。';
	@override String get tooManyAttempts => '試行回数が多すぎます。少し待ってからお試しください。';
	@override String get fillAllFields => 'すべての項目を入力してください。';
	@override String get insufficientTokens => 'トークンが足りません。';
	@override String get requestNotAccepted => '返信するにはリクエストを承認してください。';
	@override String get requestPendingLimit => '相手がリクエストを承認すると、さらにメッセージを送れます。';
	@override String get blocked => 'この人にはメッセージを送れません。';
	@override String get peerUnavailable => 'このアカウントは利用できなくなりました。';
	@override String get vibeDailyLimit => '今日はたくさんVibesをシェアしました。また後で試してね。';
	@override String get groupFull => 'このグループは満員です。';
	@override String get groupCreateLimit => '今日はグループを作りすぎました。また後で試してね。';
	@override String get notFound => 'このコンテンツは利用できなくなりました。';
	@override String get recentLogin => 'セキュリティのため、一度ログアウトして再ログインしてから、もう一度お試しください。';
	@override String get socialAccount => 'メールアドレスとパスワードはGoogleまたはAppleアカウントで管理されています。';
	@override String get alreadyInCall => '既に通話中です。';
	@override String get roomPrivate => 'このルームは非公開です。ホストに参加をリクエストしてください。';
	@override String get roomFull => 'このルームは満員です。';
	@override String get alreadyCheckedIn => '今日の報酬はすでに受け取り済みです。';
	@override String get purchasesUnavailable => '現在、購入はご利用いただけません。';
}

// Path: faq
class _Translations$faq$ja extends Translations$faq$tr {
	_Translations$faq$ja._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get q1 => 'このアプリはどう使うの？';
	@override String get q2 => '匿名チャットとは？';
	@override String get q3 => 'つながり度とは？';
	@override String get q4 => 'プロフィールを公開するには？';
	@override String get q5 => '60秒ストレンジャーとは？';
	@override String get q6 => 'Vibesとは？';
	@override String get q7 => 'プロフィールを編集するには？';
	@override String get q8 => '通知を管理するには？';
	@override String get q9 => '購入を復元するには？';
	@override String get q10 => 'すべての会話を削除できますか？';
	@override String get q11 => 'データは安全ですか？';
	@override String get q12 => 'ブロックや報告をするには？';
	@override String get q13 => 'アプリをシェアするには？';
	@override String get q14 => 'アカウントを削除するには？';
	@override String get a1 => 'Veyloでは匿名で新しい人と出会い、チャットして、つながりが深まるにつれて少しずつプロフィールを公開できます。お互いの準備ができたら、メッセージ、音声、直接会うことにも切り替えられます。';
	@override String get a2 => '匿名チャットでは、あなたの正体と写真は非公開のままです。つながりが深まると、名前のイニシャルやぼかし写真などが解放されます。100%になると、お互いが同意すればプロフィール全体が公開されます。';
	@override String get a3 => 'チャットするほど、つながりのパーセンテージが上がります。一定の段階で名前のイニシャル、ぼかし写真、プロフィール全体が解放されます。「つながり」をタップすると詳細を確認できます。';
	@override String get a4 => 'つながりが100%になったら「プロフィールを公開」をタップします。相手も承認すると、お互いのプロフィール全体が表示されます。';
	@override String get a5 => '「通話」タブから、ランダムな相手と短時間マッチできます。時間切れになったら、話し続けるか通話を終了するかを選べます。';
	@override String get a6 => 'Vibesでは、近くや周りにいる人をマップ/リスト表示で見つけて、気になる人とチャットを始められます。';
	@override String get a7 => '「プロフィール」タブを開き、「プロフィールを編集」から名前、写真、自己紹介、興味を更新できます。変更は保存後に反映されます。';
	@override String get a8 => '「設定」の「通知」から、メッセージやマッチなどの通知をオン/オフできます。';
	@override String get a9 => '設定 → アカウント管理 → 購入を復元 へ進んでください。同じストアアカウントで購入した対象アイテムが復元されます。';
	@override String get a10 => 'はい。設定 → 会話を削除 から確認してください。すべてのチャットが削除されます。この操作は取り消せません。';
	@override String get a11 => 'アカウント情報とメッセージは保護されたシステムに保存されています。また、「アカウント管理」からいつでもアカウントとデータの削除をリクエストできます。';
	@override String get a12 => 'プロフィールやチャット画面のメニューからブロックや報告ができます。報告はチームが確認します。';
	@override String get a13 => '「設定」の「アプリをシェア」からリンクをコピーして、友達に送ってください。';
	@override String get a14 => '設定 → アカウント管理 → アカウントとデータを削除 へ進んでください。理由を入力したあと、確認すると削除リクエストが送信されます。';
}

// Path: legal
class _Translations$legal$ja extends Translations$legal$tr {
	_Translations$legal$ja._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get termsTitle => '利用規約';
	@override String get privacyTitle => 'プライバシーポリシー';
	@override String get termsBody => '最終更新日：2026年3月16日\n\nVeyloへようこそ。アカウントを作成するか本アプリを利用することにより、あなたは本利用規約に同意したものとみなされます。\n\n1. Veyloについて\nVeyloは、人と出会い、匿名でチャットし、時間をかけてつながりを築き、双方が同意した場合には音声通話やビデオ通話に移行することもできるソーシャルアプリです。\n\n2. アカウント\nあなたは正確な情報を提供し、ログイン情報を安全に管理しなければなりません。あなたのアカウントで行われた行為については、あなたが責任を負います。お住まいの国の法律に基づき、Veyloを利用できる年齢に達している必要があります。\n\n3. 礼儀ある利用\n嫌がらせ、脅迫、詐欺、なりすまし、違法なコンテンツの共有、安全機能の回避を試みることは禁止されています。これらのルールに違反した場合、当社はコンテンツの削除、機能の制限、またはアカウントの停止を行うことがあります。\n\n4. 匿名チャットとプロフィール公開\n匿名チャットでは、つながりの段階に到達するまで、あなたの名前と写真が非表示になる場合があります。プロフィール全体の公開には双方の同意が必要です。他のユーザーに正体を明かすよう強要しないでください。\n\n5. 購入\n一部の機能は有料の場合があります。購入はApple App StoreまたはGoogle Playを通じて処理されます。「購入を復元」により、同じストアアカウントで購入した対象アイテムを復元できます。返金は各ストアのポリシーに従います。\n\n6. あなたが共有するコンテンツ\nあなたのコンテンツに関する権利はあなたに帰属しますが、サービスの運営に必要な範囲で、アプリ内でコンテンツをホストおよび表示するためのライセンスをVeyloに付与するものとします。共有する権利を持たないコンテンツは投稿しないでください。\n\n7. 利用の終了\nあなたはいつでもVeyloの利用を停止し、「設定」からアカウントの削除をリクエストできます。また、当社は必要に応じて、合理的な通知のうえでサービスを終了または変更することがあります。\n\n8. お問い合わせ\n本規約に関するご質問：support@veylo.app';
	@override String get privacyBody => '最終更新日：2026年3月16日\n\n本プライバシーポリシーは、Veyloがあなたの情報をどのように収集、利用、保護するかを説明するものです。\n\n1. 収集する情報\n• アカウントデータ：メールアドレス、表示名、プロフィール写真、自己紹介、設定\n• 利用データ：チャット、つながり度、利用した通話機能、端末およびアプリの基本情報\n• 購入情報：有料機能の解放および復元に必要なストアのレシートデータ\n\n2. 情報の利用方法\n当社は、Veyloの運営、マッチングおよびチャット体験のパーソナライズ、コミュニティの安全の確保、購入の処理、製品の改善のためにあなたのデータを利用します。当社があなたの個人データを販売することはありません。\n\n3. 匿名モード\n匿名チャットでは、解放ルールと双方の同意によってより多くの情報が許可されるまで、他のユーザーに表示される内容（例：伏せ字の名前やぼかした写真）を制限します。ただし、機能を安全に運営するため、システム内部ではアカウント識別子を引き続き必要とします。\n\n4. 共有\n当社は、ホスティング、分析、決済処理を支援するサービスプロバイダーと、必要な範囲に限りデータを共有することがあります。また、法律で求められる場合や、ユーザーを危害から守るために情報を開示することがあります。\n\n5. 保存期間\n当社は、アカウントが有効な間、および法令、安全、請求上の理由で必要な期間、データを保持します。削除リクエストの処理が完了した後は、保持が義務付けられている場合を除き、個人データを削除または匿名化します。\n\n6. あなたの選択\nあなたは、プロフィール情報の編集、通知の管理、アカウント削除のリクエスト、およびご自身のデータに関するお問い合わせを行うことができます。ストアでの購入はAppleまたはGoogleを通じても管理されます。\n\n7. セキュリティ\n当社は、あなたの情報を保護するために合理的な技術的および組織的措置を講じています。完全に安全なシステムは存在しないため、強力なパスワードを使用し、端末を最新の状態に保ってください。\n\n8. お問い合わせ\nプライバシーに関するご質問：privacy@veylo.app';
}

// Path: logout
class _Translations$logout$ja extends Translations$logout$tr {
	_Translations$logout$ja._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'ログアウト';
	@override String get subtitle => '本当にログアウトしますか？';
	@override String get cancel => 'キャンセル';
	@override String get confirm => 'ログアウト';
}

// Path: deleteAccount
class _Translations$deleteAccount$ja extends Translations$deleteAccount$tr {
	_Translations$deleteAccount$ja._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'アカウント削除をリクエスト';
	@override String get subtitle => '本当にアカウントを削除しますか？';
	@override String get reasonTitle => 'いなくなるのは寂しいけど、理解しています。';
	@override String get reasonBefore => '';
	@override String get reasonAfter => 'をより良くするために、退会したい理由を教えてもらえますか？';
	@override String get reasonLabel => 'アカウントを削除したい理由';
	@override String get reasonHint => 'メッセージを入力';
	@override String get cancel => 'キャンセル';
	@override String get createRequest => 'リクエストを作成';
	@override String get confirmTitle => '本当に削除リクエストを送信しますか？';
	@override String get confirmSubtitle => '確認すると、アカウント削除リクエストが送信されます';
	@override String get delete => '削除';
}

// Path: storyText
class _Translations$storyText$ja extends Translations$storyText$tr {
	_Translations$storyText$ja._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get bold => '太字';
	@override String get italic => '斜体';
	@override String get uppercase => '大文字';
	@override String get underline => '下線';
	@override String get cancel => 'キャンセル';
	@override String get galleryError => 'ギャラリーを開けませんでした';
}

// Path: tokens
class _Translations$tokens$ja extends Translations$tokens$tr {
	_Translations$tokens$ja._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get boostTitle => 'Boost';
	@override String get history => '履歴';
	@override String get yourBalance => '残高';
	@override String balanceTokens({required Object count}) => '${count} トークン';
	@override String get getMore => 'トークンを追加';
	@override String get checkinTitle => 'デイリーチェックイン';
	@override String checkinSubtitle({required Object max}) => '毎日続けて受け取ると、1日最大${max}トークン獲得';
	@override String day({required Object n}) => '${n}日目';
	@override String collectDay({required Object n}) => '${n}日目のトークンを受け取る';
	@override String collectedToday({required Object n}) => '明日また来て${n}日目を受け取ろう';
	@override String get duration30m => '30分';
	@override String get duration1h => '1時間';
	@override String get duration2h => '2時間';
	@override String visibility({required Object n}) => '表示回数${n}倍';
	@override String boostFor({required Object count}) => '${count}トークンでBoost';
	@override String boostActive({required Object time}) => '${time}までBoost中';
	@override String get boostDone => 'プロフィールをBoostしました！';
	@override String get historyEmpty => 'トークンの履歴はまだありません';
	@override String balanceLine({required Object count}) => '残高 ${count} トークン';
	@override String get reasonPurchase => 'トークン購入';
	@override String get reasonCheckin => 'デイリーチェックイン';
	@override String get reasonWelcome => 'ウェルカムボーナス';
	@override String get reasonGenderFilter => '性別フィルター通話';
	@override String get reasonVideoCall => 'ビデオ通話';
	@override String get reasonRoomCreate => 'ルーム作成';
	@override String get reasonBorder => 'プロフィール枠';
	@override String get reasonPostBoost => '投稿Boost';
	@override String get reasonRefund => '返金';
	@override String get reasonAdjust => '残高調整';
	@override String get packsTitle => 'トークンを追加';
	@override String get packsSubtitle => 'トークンパックを選択';
	@override String packTokens({required Object count}) => '${count} トークン';
	@override String get buy => '購入';
	@override String purchaseDone({required Object count}) => '${count}トークンが残高に追加されました';
	@override String get notEnoughTitle => 'トークンが足りません';
	@override String get notEnoughSubtitle => '続けるには残高をチャージしてください。';
}

// Path: discover.aiMatch
class _Translations$discover$aiMatch$ja extends Translations$discover$aiMatch$tr {
	_Translations$discover$aiMatch$ja._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get feelingTitle => '今日の気分は？';
	@override String get feelingSubtitle => '選んだ気分をもとにAIがぴったりの相手を探します';
	@override String get lookingTitle => '何を探していますか？';
	@override String get moodSad => '悲しい';
	@override String get moodMeltie => '微妙';
	@override String get moodBored => '退屈';
	@override String get moodCrying => '落ち込み';
	@override String get moodSmile => 'ハッピー';
	@override String get lookingNewFriends => '新しい友達';
	@override String get lookingVenting => '愚痴を聞いて';
	@override String get lookingFlirty => 'ドキドキトーク';
	@override String get lookingFun => '楽しいこと';
	@override String get lookingCultures => '新しい文化';
	@override String get lookingLanguage => '語学練習';
	@override String get statActiveUsers => 'アクティブユーザー';
	@override String get statMatchRate => 'マッチ率';
	@override String get statAvgTime => '平均時間';
	@override String get statActiveValue => '843';
	@override String get statMatchValue => '87%';
	@override String get statAvgValue => '8秒';
	@override String get startSmartMatch => 'スマートマッチ開始';
	@override String get findingTitle => '相手を探しています';
	@override String get findingSubtitle => 'あなたの気分と興味にぴったりの相手をマッチング中';
	@override String get findingStepMood => '気分を分析しました';
	@override String get findingStepInterests => '興味をマッチングしました';
	@override String get findingStepCompatibility => '相性を計算中...';
	@override String get findingStepContent => 'コンテンツを作成中...';
	@override String findingOnline({required Object count}) => '現在${count}人がオンライン';
	@override String get yourMatchTitle => 'あなたのマッチ';
	@override String get yourMatchSubtitle => 'あなたの回答をもとにマッチしました';
	@override String vibeMatch({required Object percent}) => '相性 ${percent}%';
	@override String get startChatting => 'チャットを始める';
	@override String matchNameAge({required Object name, required Object age}) => '${name}、${age}';
	@override String get matchBio => '知らなかった気持ちを感じさせてあげる。';
	@override String get swipePrevious => '前へ';
	@override String get swipeNext => '次へ';
	@override String get swipeFinger => 'スワイプしてね';
	@override String get noMatch => '今はマッチする人がいません。しばらくしてからもう一度お試しください。';
}

// Path: discover.privateRoom
class _Translations$discover$privateRoom$ja extends Translations$discover$privateRoom$tr {
	_Translations$discover$privateRoom$ja._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get subtitle => '非公開ルームです。トークンで参加できます。';
	@override String get roomAccess => 'ルーム参加料';
	@override String get yourBalance => '残高';
	@override String tokensAmount({required Object count}) => '${count} トークン';
	@override String joinForTokens({required Object count}) => '${count}トークンで参加';
	@override String get cancel => 'キャンセル';
}

// Path: discover.roomToken
class _Translations$discover$roomToken$ja extends Translations$discover$roomToken$tr {
	_Translations$discover$roomToken$ja._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get subtitle => 'トークンで参加できます。';
	@override String get roomAccess => 'ルーム参加料';
	@override String get yourBalance => '残高';
	@override String tokensAmount({required Object count}) => '${count} トークン';
	@override String joinForTokens({required Object count}) => '${count}トークンで参加';
	@override String get cancel => 'キャンセル';
}

// Path: discover.privateRequest
class _Translations$discover$privateRequest$ja extends Translations$discover$privateRequest$tr {
	_Translations$discover$privateRequest$ja._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => '参加リクエスト';
	@override String roomInfo({required Object name, required Object count}) => '${name} · メンバー${count}人';
	@override String get messageHint => 'ひとこと（任意）...';
	@override String get sendRequest => 'リクエストを送信';
	@override String get adminReview => 'ルームの管理者がリクエストを確認します';
}

// Path: discover.roomApproved
class _Translations$discover$roomApproved$ja extends Translations$discover$roomApproved$tr {
	_Translations$discover$roomApproved$ja._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => '参加できました！';
	@override String subtitle({required Object name}) => '${name}の席が確保されました';
	@override String get continueLabel => '続ける';
}

// Path: discover.createSpace
class _Translations$discover$createSpace$ja extends Translations$discover$createSpace$tr {
	_Translations$discover$createSpace$ja._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'ルーム・グループを作成';
	@override String get subtitle => 'グループやライブルームを作って、もっと多くの人とつながろう';
	@override String get room => 'ルーム';
	@override String get group => 'グループ';
	@override String get hideAccount => 'アカウントを非表示';
	@override String get create => '作成';
	@override String get cancel => 'キャンセル';
	@override String get createRoomTitle => 'ルームを作成';
	@override String get createGroupTitle => 'グループを作成';
	@override String get nameSubtitle => 'グループに名前を付けよう';
	@override String get nameHint => '夜ふかし部';
	@override String createRoomFor({required Object count}) => '${count}トークンで作成';
}

// Path: discover.liveRoom
class _Translations$discover$liveRoom$ja extends Translations$discover$liveRoom$tr {
	_Translations$discover$liveRoom$ja._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get adminSuffix => '（管理者）';
	@override String get messageHint => 'メッセージ';
	@override String get quickReplyHey => 'みんな、こんにちは！';
	@override String get quickReplyTopic => '何の話をしてるの？';
	@override String get quickReplyNew => '初めて来ました！';
	@override String get sampleChatName => 'Sona';
	@override String get sampleChatBody => '何する？何かアイデアある？';
	@override String get roomEnded => 'ルームは終了しました。';
	@override String wantsToJoin({required Object name}) => '${name}さんが参加を希望しています';
	@override String get approve => '承認';
}

// Path: discover.groupChat
class _Translations$discover$groupChat$ja extends Translations$discover$groupChat$tr {
	_Translations$discover$groupChat$ja._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String usersCount({required Object count}) => '${count}人のユーザー';
	@override String get sampleVictoria => 'すごく退屈。みんなで何かしない？';
	@override String get sampleSona => '何する？何かアイデアある？';
	@override String get sampleOwn => '桟橋で会おうよ';
}

// Path: discover.groupInfo
class _Translations$discover$groupInfo$ja extends Translations$discover$groupInfo$tr {
	_Translations$discover$groupInfo$ja._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get media => 'メディア';
	@override String get gallery => 'ギャラリー';
	@override String get settings => '設定';
	@override String get notifications => '通知';
	@override String get blocked => 'ブロック中';
	@override String get private => '非公開';
	@override String membersCount({required Object count}) => 'メンバー${count}人';
	@override String get addPeople => 'メンバーを追加';
	@override String get you => 'あなた';
	@override String get admin => '管理者';
	@override String get leaveGroup => 'グループを退出';
	@override String get requests => '参加リクエスト';
	@override String get approve => '承認';
	@override String get reject => '拒否';
	@override String get addPeopleEmpty => 'フォローした人をグループに追加できます。';
	@override String get add => '追加';
	@override String get makeAdmin => '管理者にする';
	@override String get removeAdmin => '管理者から外す';
	@override String get remove => 'グループから削除';
	@override String get leaveConfirm => 'このグループを退出しますか？';
	@override String get leave => '退出';
	@override String get cancel => 'キャンセル';
}

// Path: discover.filters
class _Translations$discover$filters$ja extends Translations$discover$filters$tr {
	_Translations$discover$filters$ja._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'フィルター';
	@override String get ageRange => '年齢';
	@override String ageRangeValue({required Object min, required Object max}) => '${min}-${max}';
	@override String get distance => '距離';
	@override String distanceValue({required Object km}) => '${km} km';
	@override String get showMe => '表示する相手';
	@override String get everyone => '全員';
	@override String get women => '女性';
	@override String get men => '男性';
	@override String get interests => '興味';
	@override String get activeNow => 'オンライン中';
	@override String get activeNowSubtitle => '今オンラインの人だけを表示';
	@override String get showResult => '結果を表示';
}

// Path: discover.post
class _Translations$discover$post$ja extends Translations$discover$post$tr {
	_Translations$discover$post$ja._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get follow => 'フォロー';
	@override String get following => 'フォロー中';
	@override String get addComment => 'コメントを追加...';
	@override String get commentsTitle => 'コメント';
	@override String get sampleCaption => '素敵な一日のあとに飲むコーヒーは格別。<3';
	@override String hoursAgo({required Object hours}) => '${hours}時間';
	@override String minutesAgo({required Object minutes}) => '${minutes}分';
	@override String daysAgo({required Object days}) => '${days}日';
	@override String get deleteCommentTitle => 'このコメントを削除しますか？';
}

// Path: discover.story
class _Translations$discover$story$ja extends Translations$discover$story$tr {
	_Translations$discover$story$ja._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get draft => '下書き';
	@override String get story => 'ストーリー';
	@override String get share => 'シェア';
	@override String get textPlaceholder => 'テキストを入力...';
	@override String get draftPrompt => '下書きに保存しますか？';
	@override String get saveToDraft => '下書きに保存';
	@override String get moveToTrash => 'ゴミ箱に移動';
	@override String get save => '保存';
	@override String get musicTitle => 'ミュージック';
	@override String get musicEmpty => '曲が見つかりません。';
	@override String get musicError => '曲を読み込めませんでした。';
	@override String get downloaded => 'ギャラリーに保存しました';
	@override String get downloadFailed => '保存できませんでした';
}

// Path: discover.highlight
class _Translations$discover$highlight$ja extends Translations$discover$highlight$tr {
	_Translations$discover$highlight$ja._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'ハイライト';
	@override String get view => '表示';
	@override String get aiComments => 'AIコメント';
	@override String get remove => 'ハイライトを削除';
	@override String get sharedSuccess => '投稿をシェアしました';
	@override String get boost => 'ブースト';
}

// Path: discover.stats
class _Translations$discover$stats$ja extends Translations$discover$stats$tr {
	_Translations$discover$stats$ja._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => '統計';
	@override String get subtitle => '投稿の統計は\n以下のとおりです。';
	@override String get viewers => '閲覧者';
	@override String get comments => 'コメント';
	@override String get likes => 'いいね';
	@override String get boostCta => '1日ブースト - 100トークン';
	@override String get boosted => 'ブースト完了！投稿が24時間トップに表示されます。';
}

// Path: createProfile.interests
class _Translations$createProfile$interests$ja extends Translations$createProfile$interests$tr {
	_Translations$createProfile$interests$ja._(TranslationsJa root) : this._root = root, super.internal(root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get music => '音楽';
	@override String get movies => '映画';
	@override String get tvShows => 'ドラマ・TV';
	@override String get reading => '読書';
	@override String get painting => '絵画';
	@override String get photography => '写真';
	@override String get theatre => '演劇';
	@override String get fitness => 'フィットネス';
	@override String get swimming => '水泳';
	@override String get football => 'サッカー';
	@override String get basketball => 'バスケ';
	@override String get coffee => 'コーヒー';
	@override String get travel => '旅行';
	@override String get camping => 'キャンプ';
	@override String get meditation => '瞑想';
	@override String get videoGames => 'ゲーム';
	@override String get boardGames => 'ボードゲーム';
	@override String get standUp => 'お笑い';
	@override String get tech => 'テクノロジー';
	@override String get coding => 'プログラミング';
	@override String get ai => 'AI';
	@override String get podcast => 'ポッドキャスト';
}

/// The flat map containing all translations for locale <ja>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsJa {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.name' => 'Veylo',
			'app.tagline' => 'ようこそ',
			'home.title' => 'ホーム',
			'home.subtitle' => 'アプリを準備中です',
			'home.body' => '多言語UIはslangで管理されています。',
			'chats.title' => 'チャット',
			'chats.search' => '検索',
			'chats.messagesSection' => 'メッセージ',
			'chats.request' => 'リクエスト',
			'chats.emptyRequestTitle' => '最近のメッセージ\n通知はありません',
			'chats.emptyRequestSubtitle' => '30日以上前のリクエストは表示されません。',
			'chats.noteAdd' => 'ノートを追加',
			'chats.anonymous' => '匿名',
			'chats.online' => 'オンライン',
			'chats.offline' => 'オフライン',
			'chats.connection' => 'つながり',
			'chats.connectionPercent' => ({required Object n}) => '${n}%',
			'chats.connectionProgressTitle' => 'つながり度',
			'chats.milestoneInitial' => '名前のイニシャル',
			'chats.milestoneInitialHint' => '25%で解除済み',
			'chats.milestoneInitialLocked' => '25%で解除',
			'chats.milestonePhoto' => 'ぼかし写真のプレビュー',
			'chats.milestonePhotoHint' => '70%で解除',
			'chats.milestoneFull' => 'プロフィール全体を表示',
			'chats.milestoneFullHint' => '100%でお互いの同意が必要',
			'chats.sampleAnonymousMessage' => 'こんにちは、お話しできてうれしいです。あなたのことを少し教えてもらえますか？',
			'chats.strangerSampleMessage' => 'こんにちは、Jhonさん。お話しできてうれしいです。あなたのことを少し教えてもらえますか？',
			'chats.approve' => '承認',
			'chats.blockUser' => 'ユーザーをブロック',
			'chats.reject' => '拒否',
			'chats.messageHint' => 'やあ！元気？',
			'chats.revealTitle' => '100%に到達しました',
			'chats.revealSubtitle' => 'お互いのプロフィールを公開しますか？両方の同意が必要です。',
			'chats.revealWaiting' => ({required Object name}) => '${name}さんの承認を待っています',
			'chats.revealCta' => 'プロフィールを公開',
			'chats.revealNotYet' => 'まだしない',
			'chats.seen' => '既読',
			'chats.typing' => '入力中…',
			'chats.noteYou' => 'あなた',
			'chats.noteSheetTitle' => 'ノートをシェア',
			'chats.noteSheetSubtitle' => 'ノートは24時間表示されます',
			'chats.noteHint' => '今なにしてる？',
			'chats.noteShare' => 'シェア',
			'chats.noteDelete' => 'ノートを削除',
			'profile.eyebrow' => 'プロフィール',
			'profile.title' => '設定',
			'profile.editProfile' => 'プロフィールを編集',
			'profile.statLike' => 'いいね',
			'profile.statFollow' => 'フォロー',
			'profile.statFollower' => 'フォロワー',
			'profile.promoTitle' => 'もっとメッセージをもらおう！',
			'profile.promoSubtitle' => '目立って、リストの上位に表示されよう',
			'profile.standOut' => '目立つ',
			'profile.tabPosts' => '投稿',
			'profile.tabVideo' => '動画',
			'profile.tabSaved' => '保存済み',
			'profile.save' => '保存',
			'profile.changePhoto' => '写真を変更',
			'profile.changeBorder' => 'フレームを変更',
			'profile.interest' => '興味',
			'profile.name' => '名前',
			'profile.changeName' => '名前を変更',
			'profile.changePassword' => 'パスワードを変更',
			'profile.confirmPassword' => 'パスワードを確認',
			'profile.email' => 'メールアドレス',
			'profile.accountManagement' => 'アカウント管理',
			'profile.settingsAbout' => 'このアプリについて',
			'profile.settingsAccount' => 'アカウント設定',
			'profile.settingsSupport' => 'サポート',
			'profile.shareApp' => 'アプリをシェア',
			'profile.shareAppTitle' => '友達にシェア',
			'profile.shareAppSubtitle' => 'Veyloを友達にシェアして、一緒に楽しもう！',
			'profile.shareAppLabel' => 'アプリのリンク',
			'profile.rateApp' => '気に入った？評価してね',
			'profile.notifications' => '通知',
			'profile.password' => 'パスワード',
			'profile.deleteConversation' => '会話を削除',
			'profile.faqHelp' => 'よくある質問とヘルプ',
			'profile.restorePurchases' => '購入を復元',
			'profile.termsOfService' => '利用規約',
			'profile.privacyPolicy' => 'プライバシーポリシー',
			'profile.restorePurchasesDone' => '購入履歴を確認しました',
			'profile.conversationsDeleted' => 'すべての会話を削除しました',
			'profile.logOut' => 'ログアウト',
			'profile.deleteAccountAndData' => 'アカウントとデータを削除',
			'profile.passwordPlaceholder' => '********',
			'profile.height' => '身長',
			'profile.addHeight' => '身長を追加',
			'profile.heightCm' => ({required Object value}) => '${value} cm',
			'profile.languages' => '言語',
			'profile.relationshipGoals' => '求める関係',
			'profile.lookingFor' => '探しているもの',
			'profile.newFriends' => '👋 新しい友達',
			'profile.goalLongTermOpenToShort' => '💕 長期希望、短期もOK',
			'profile.goalLongTermRelationship' => '💘 長期的な関係',
			'profile.goalNewFriends' => '👋 新しい友達',
			'profile.goalShortTermFun' => '🥃 気軽に楽しく',
			'profile.goalStillFiguringItOut' => '🤔 まだ考え中',
			'profile.basics' => '基本情報',
			'profile.zodiac' => '星座',
			'profile.zodiacValue' => 'さそり座',
			'profile.education' => '学歴',
			'profile.educationValue' => '学士',
			'profile.educationHighSchool' => '高校',
			'profile.educationAssociates' => '短大・専門',
			'profile.educationBachelors' => '学士',
			'profile.educationMasters' => '修士',
			'profile.educationPhd' => '博士',
			'profile.voiceRecord' => 'ボイス録音',
			'profile.addVoice' => 'ボイスを追加',
			'profile.lifestyle' => 'ライフスタイル',
			'profile.pets' => 'ペット',
			'profile.petsValue' => '猫を飼っています',
			'profile.petsDontWant' => 'ペットは欲しくない',
			'profile.petsAllergic' => 'ペットアレルギーです',
			'profile.petsHaveCat' => '猫を飼っています',
			'profile.petsHaveDog' => '犬を飼っています',
			'profile.petsHaveCatsAndDogs' => '猫と犬を飼っています',
			'profile.petsHaveOther' => '他のペットを飼っています',
			'profile.drinking' => 'お酒',
			'profile.drinkingValue' => '特別な時だけ',
			'profile.drinkingNever' => '飲まない',
			'profile.drinkingSpecialOccasions' => '特別な時だけ',
			'profile.drinkingSocially' => '付き合い程度',
			'profile.drinkingFrequently' => 'よく飲む',
			'profile.drinkingSober' => '禁酒中',
			'profile.drinkingPreferNotToSay' => '答えたくない',
			'profile.smoking' => 'タバコ',
			'profile.smokingValue' => '吸わない',
			'profile.smokingNonSmoker' => '吸わない',
			'profile.smokingSocialSmoker' => '付き合い程度',
			'profile.smokingSmoker' => '吸う',
			'profile.smokingTryingToQuit' => '禁煙中',
			'profile.smokingWhenDrinking' => '飲む時だけ吸う',
			'profile.smokingPreferNotToSay' => '答えたくない',
			'profile.gender' => '性別',
			'profile.genderFemale' => '女性',
			'profile.genderMale' => '男性',
			'profile.genderPreferNotToSay' => '答えたくない',
			'profile.visible' => '表示',
			'profile.profileVisibility' => 'プロフィールの公開範囲',
			'profile.language' => '言語',
			'profile.borderTitle' => 'プロフィールフレーム',
			'profile.borderSubtitle' => 'プロフィールにフレームを付けて\nもっと目立とう。',
			'profile.borderBuySection' => 'フレームを購入',
			'profile.borderBuyCta' => 'フレームを購入',
			'profile.borderToken' => ({required Object count}) => '${count} トークン',
			'profile.borderAmethystWings' => 'Amethyst Wings',
			'profile.borderGoldenPhoenix' => 'Golden Phoenix',
			'profile.borderFrostCrown' => 'Frost Crown',
			'profile.borderEmeraldWhisper' => 'Emerald Whisper',
			'profile.borderRoseQuartz' => 'Rose Quartz',
			'profile.borderStarlitComet' => 'Starlit Comet',
			'profile.borderCrimsonRoyal' => 'Crimson Royal',
			'profile.borderSapphireHalo' => 'Sapphire Halo',
			'profile.follow' => 'フォロー',
			'profile.following' => 'フォロー中',
			'profile.followPageTitle' => 'フォロー',
			'profile.followTabFollowing' => 'フォロー中',
			'profile.followTabFollowers' => 'フォロワー',
			'profile.followSearch' => '検索',
			'profile.unfollow' => 'フォロー解除',
			'profile.followSortTitle' => '並び替え',
			'profile.followSortRecent' => '最近フォローした人',
			'profile.followSortNotFollowingMe' => 'フォローバックしていない人',
			'profile.followSortNotFollowedByMe' => '自分がフォローバックしていない人',
			'profile.followSortShowResult' => '結果を表示',
			'profile.followSortEmpty' => '条件に合うユーザーはいません',
			'profile.shareTitle' => '友達にシェア',
			'profile.shareSubtitle' => '友達とつながれば\nもっと楽しくなる！',
			'profile.shareProfileLabel' => 'プロフィールをシェア',
			'profile.shareLinkCopied' => 'リンクをコピーしました',
			'profile.restrict' => '制限',
			'profile.block' => 'ブロック',
			'profile.report' => '報告',
			'profile.blockTitle' => ({required Object username}) => '${username}さんをブロックしますか？',
			'profile.blockBody' => '相手が持っている、または今後作成する他のアカウントもブロックされます。ブロックはいつでも解除できます。',
			'profile.blockAndReport' => 'ブロックして報告',
			'profile.restrictTitle' => ({required Object username}) => '${username}さんを制限しますか？',
			'profile.restrictBody' => '相手はあなたがオンラインかどうかや、メッセージを読んだかどうかを確認できなくなります。設定はいつでも変更できます。',
			'profile.restrictAndReport' => '制限して報告',
			'profile.reportTitle' => '理由を教えてください',
			'profile.reportSubtitle' => 'より良い体験を提供するため、このユーザーを報告する理由を教えてもらえますか？',
			'profile.reportMessageLabel' => '報告内容',
			'profile.reportMessageHint' => 'メッセージを入力',
			'profile.reportCancel' => 'キャンセル',
			'profile.sendReport' => '報告を送信',
			'profile.notSet' => '未設定',
			'profile.reportSent' => 'ありがとうございます。報告を受け付けました。',
			'profile.emailVerificationSent' => ({required Object email}) => '${email} に確認リンクを送信しました。確認後にメールアドレスが変更されます。',
			'profile.passwordChanged' => 'パスワードを更新しました。',
			'profile.passwordMismatch' => 'パスワードが一致しません。',
			'nav.discover' => '発見',
			'nav.chat' => 'チャット',
			'nav.call' => '通話',
			'nav.vibes' => 'Vibes',
			'nav.profile' => 'プロフィール',
			'call.title' => '60秒ストレンジャー',
			'call.subtitle' => '知らない誰かと60秒間おしゃべり。完全匿名で、プロフィールも写真も名前もなし。声とその瞬間だけ。',
			'call.findingTitle' => '相手を探しています...',
			'call.findingSubtitle' => '60秒間、匿名で話せます。プロフィールも名前もなし。',
			'call.callStranger' => '通話する - 10トークン',
			'call.cancel' => 'キャンセル',
			'call.female' => '女性',
			'call.male' => '男性',
			'call.nonBinary' => 'ノンバイナリー',
			'call.preferNotToSay' => '答えたくない',
			'call.anonymousBadge' => '🎙️ 匿名音声通話',
			'call.stranger' => 'ストレンジャー',
			'call.secondsLeft' => ({required Object n}) => '${n}秒',
			'call.timesUpTitle' => '時間切れ！',
			'call.timesUpSubtitle' => 'もっと話したい？お互いがOKならチャットが解放されます。',
			'call.keepTalking' => '話し続ける',
			'call.endCall' => '通話を終了',
			'call.waitingOther' => '相手の返事を待っています...',
			'call.callStrangerFree' => '通話する',
			'call.peerLeft' => '相手が通話を終了しました。',
			'call.noKeep' => '今回はチャットが解放されませんでした。',
			'call.videoWaiting' => '相手がビデオ通話を承認するのを待っています...',
			'call.videoDeclined' => '相手がビデオ通話を拒否しました。',
			'call.micDenied' => '通話にはマイクへのアクセスが必要です。設定から有効にできます。',
			'call.videoCost' => 'ビデオ通話：15分 / 20トークン',
			'call.calling' => '発信中',
			'call.accept' => '応答',
			'call.decline' => '拒否',
			'call.switchToVideo' => 'ビデオ通話に切り替えますか？',
			'call.noMatchTitle' => '今は話せる人がいません',
			'call.noMatchBody' => '現在、話せる相手が見つかりませんでした。少し時間をおいてもう一度お試しください。',
			'call.noMatchOk' => 'OK',
			'vibes.search' => '検索',
			'vibes.sendMessage' => 'メッセージを送る',
			'vibes.wantsToTalk' => '今このことについて話したい',
			'vibes.shareTitle' => 'Vibeをシェア',
			'vibes.replyTitle' => 'Vibeに返信',
			'vibes.shareHint' => '何か書いてみよう',
			'vibes.shareAnonymous' => '匿名でシェア',
			'vibes.empty' => '過去24時間のVibesはありません。最初の投稿をしよう！',
			'vibes.deleteTitle' => 'このVibeを削除しますか？',
			'vibes.delete' => '削除',
			'vibes.cancel' => 'キャンセル',
			'discover.title' => '発見',
			'discover.tabRooms' => 'ルーム',
			'discover.tabDiscover' => '発見',
			'discover.tabAiMatch' => 'AI Match',
			'discover.aiMatch.feelingTitle' => '今日の気分は？',
			'discover.aiMatch.feelingSubtitle' => '選んだ気分をもとにAIがぴったりの相手を探します',
			'discover.aiMatch.lookingTitle' => '何を探していますか？',
			'discover.aiMatch.moodSad' => '悲しい',
			'discover.aiMatch.moodMeltie' => '微妙',
			'discover.aiMatch.moodBored' => '退屈',
			'discover.aiMatch.moodCrying' => '落ち込み',
			'discover.aiMatch.moodSmile' => 'ハッピー',
			'discover.aiMatch.lookingNewFriends' => '新しい友達',
			'discover.aiMatch.lookingVenting' => '愚痴を聞いて',
			'discover.aiMatch.lookingFlirty' => 'ドキドキトーク',
			'discover.aiMatch.lookingFun' => '楽しいこと',
			'discover.aiMatch.lookingCultures' => '新しい文化',
			'discover.aiMatch.lookingLanguage' => '語学練習',
			'discover.aiMatch.statActiveUsers' => 'アクティブユーザー',
			'discover.aiMatch.statMatchRate' => 'マッチ率',
			'discover.aiMatch.statAvgTime' => '平均時間',
			'discover.aiMatch.statActiveValue' => '843',
			'discover.aiMatch.statMatchValue' => '87%',
			'discover.aiMatch.statAvgValue' => '8秒',
			'discover.aiMatch.startSmartMatch' => 'スマートマッチ開始',
			'discover.aiMatch.findingTitle' => '相手を探しています',
			'discover.aiMatch.findingSubtitle' => 'あなたの気分と興味にぴったりの相手をマッチング中',
			'discover.aiMatch.findingStepMood' => '気分を分析しました',
			'discover.aiMatch.findingStepInterests' => '興味をマッチングしました',
			'discover.aiMatch.findingStepCompatibility' => '相性を計算中...',
			'discover.aiMatch.findingStepContent' => 'コンテンツを作成中...',
			'discover.aiMatch.findingOnline' => ({required Object count}) => '現在${count}人がオンライン',
			'discover.aiMatch.yourMatchTitle' => 'あなたのマッチ',
			'discover.aiMatch.yourMatchSubtitle' => 'あなたの回答をもとにマッチしました',
			'discover.aiMatch.vibeMatch' => ({required Object percent}) => '相性 ${percent}%',
			'discover.aiMatch.startChatting' => 'チャットを始める',
			'discover.aiMatch.matchNameAge' => ({required Object name, required Object age}) => '${name}、${age}',
			'discover.aiMatch.matchBio' => '知らなかった気持ちを感じさせてあげる。',
			'discover.aiMatch.swipePrevious' => '前へ',
			'discover.aiMatch.swipeNext' => '次へ',
			'discover.aiMatch.swipeFinger' => 'スワイプしてね',
			'discover.aiMatch.noMatch' => '今はマッチする人がいません。しばらくしてからもう一度お試しください。',
			'discover.searchHint' => '検索',
			'discover.allRooms' => 'すべてのルーム',
			'discover.allGroups' => 'すべてのグループ',
			'discover.seeAll' => 'すべて見る',
			'discover.live' => 'ライブ',
			'discover.join' => '参加',
			'discover.request' => 'リクエスト',
			'discover.requested' => 'リクエスト済み',
			'discover.private' => '非公開',
			'discover.moreCount' => ({required Object count}) => '+${count}人',
			'discover.activeCount' => ({required Object count}) => '${count}人がアクティブ',
			'discover.membersCount' => ({required Object count}) => 'メンバー${count}人',
			'discover.privateRoom.subtitle' => '非公開ルームです。トークンで参加できます。',
			'discover.privateRoom.roomAccess' => 'ルーム参加料',
			'discover.privateRoom.yourBalance' => '残高',
			'discover.privateRoom.tokensAmount' => ({required Object count}) => '${count} トークン',
			'discover.privateRoom.joinForTokens' => ({required Object count}) => '${count}トークンで参加',
			'discover.privateRoom.cancel' => 'キャンセル',
			'discover.roomToken.subtitle' => 'トークンで参加できます。',
			'discover.roomToken.roomAccess' => 'ルーム参加料',
			'discover.roomToken.yourBalance' => '残高',
			'discover.roomToken.tokensAmount' => ({required Object count}) => '${count} トークン',
			'discover.roomToken.joinForTokens' => ({required Object count}) => '${count}トークンで参加',
			'discover.roomToken.cancel' => 'キャンセル',
			'discover.privateRequest.title' => '参加リクエスト',
			'discover.privateRequest.roomInfo' => ({required Object name, required Object count}) => '${name} · メンバー${count}人',
			'discover.privateRequest.messageHint' => 'ひとこと（任意）...',
			'discover.privateRequest.sendRequest' => 'リクエストを送信',
			'discover.privateRequest.adminReview' => 'ルームの管理者がリクエストを確認します',
			'discover.roomApproved.title' => '参加できました！',
			'discover.roomApproved.subtitle' => ({required Object name}) => '${name}の席が確保されました',
			'discover.roomApproved.continueLabel' => '続ける',
			'discover.createSpace.title' => 'ルーム・グループを作成',
			'discover.createSpace.subtitle' => 'グループやライブルームを作って、もっと多くの人とつながろう',
			'discover.createSpace.room' => 'ルーム',
			'discover.createSpace.group' => 'グループ',
			'discover.createSpace.hideAccount' => 'アカウントを非表示',
			'discover.createSpace.create' => '作成',
			'discover.createSpace.cancel' => 'キャンセル',
			'discover.createSpace.createRoomTitle' => 'ルームを作成',
			'discover.createSpace.createGroupTitle' => 'グループを作成',
			'discover.createSpace.nameSubtitle' => 'グループに名前を付けよう',
			'discover.createSpace.nameHint' => '夜ふかし部',
			'discover.createSpace.createRoomFor' => ({required Object count}) => '${count}トークンで作成',
			'discover.liveRoom.adminSuffix' => '（管理者）',
			'discover.liveRoom.messageHint' => 'メッセージ',
			'discover.liveRoom.quickReplyHey' => 'みんな、こんにちは！',
			'discover.liveRoom.quickReplyTopic' => '何の話をしてるの？',
			'discover.liveRoom.quickReplyNew' => '初めて来ました！',
			'discover.liveRoom.sampleChatName' => 'Sona',
			'discover.liveRoom.sampleChatBody' => '何する？何かアイデアある？',
			'discover.liveRoom.roomEnded' => 'ルームは終了しました。',
			'discover.liveRoom.wantsToJoin' => ({required Object name}) => '${name}さんが参加を希望しています',
			'discover.liveRoom.approve' => '承認',
			'discover.groupChat.usersCount' => ({required Object count}) => '${count}人のユーザー',
			'discover.groupChat.sampleVictoria' => 'すごく退屈。みんなで何かしない？',
			'discover.groupChat.sampleSona' => '何する？何かアイデアある？',
			'discover.groupChat.sampleOwn' => '桟橋で会おうよ',
			'discover.groupInfo.media' => 'メディア',
			'discover.groupInfo.gallery' => 'ギャラリー',
			'discover.groupInfo.settings' => '設定',
			'discover.groupInfo.notifications' => '通知',
			'discover.groupInfo.blocked' => 'ブロック中',
			'discover.groupInfo.private' => '非公開',
			'discover.groupInfo.membersCount' => ({required Object count}) => 'メンバー${count}人',
			'discover.groupInfo.addPeople' => 'メンバーを追加',
			'discover.groupInfo.you' => 'あなた',
			'discover.groupInfo.admin' => '管理者',
			'discover.groupInfo.leaveGroup' => 'グループを退出',
			'discover.groupInfo.requests' => '参加リクエスト',
			'discover.groupInfo.approve' => '承認',
			'discover.groupInfo.reject' => '拒否',
			'discover.groupInfo.addPeopleEmpty' => 'フォローした人をグループに追加できます。',
			'discover.groupInfo.add' => '追加',
			'discover.groupInfo.makeAdmin' => '管理者にする',
			'discover.groupInfo.removeAdmin' => '管理者から外す',
			'discover.groupInfo.remove' => 'グループから削除',
			'discover.groupInfo.leaveConfirm' => 'このグループを退出しますか？',
			'discover.groupInfo.leave' => '退出',
			'discover.groupInfo.cancel' => 'キャンセル',
			'discover.filters.title' => 'フィルター',
			'discover.filters.ageRange' => '年齢',
			'discover.filters.ageRangeValue' => ({required Object min, required Object max}) => '${min}-${max}',
			'discover.filters.distance' => '距離',
			'discover.filters.distanceValue' => ({required Object km}) => '${km} km',
			'discover.filters.showMe' => '表示する相手',
			'discover.filters.everyone' => '全員',
			'discover.filters.women' => '女性',
			'discover.filters.men' => '男性',
			'discover.filters.interests' => '興味',
			'discover.filters.activeNow' => 'オンライン中',
			'discover.filters.activeNowSubtitle' => '今オンラインの人だけを表示',
			'discover.filters.showResult' => '結果を表示',
			'discover.post.follow' => 'フォロー',
			'discover.post.following' => 'フォロー中',
			'discover.post.addComment' => 'コメントを追加...',
			'discover.post.commentsTitle' => 'コメント',
			'discover.post.sampleCaption' => '素敵な一日のあとに飲むコーヒーは格別。<3',
			'discover.post.hoursAgo' => ({required Object hours}) => '${hours}時間',
			'discover.post.minutesAgo' => ({required Object minutes}) => '${minutes}分',
			'discover.post.daysAgo' => ({required Object days}) => '${days}日',
			'discover.post.deleteCommentTitle' => 'このコメントを削除しますか？',
			'discover.story.draft' => '下書き',
			'discover.story.story' => 'ストーリー',
			'discover.story.share' => 'シェア',
			'discover.story.textPlaceholder' => 'テキストを入力...',
			'discover.story.draftPrompt' => '下書きに保存しますか？',
			'discover.story.saveToDraft' => '下書きに保存',
			'discover.story.moveToTrash' => 'ゴミ箱に移動',
			'discover.story.save' => '保存',
			'discover.story.musicTitle' => 'ミュージック',
			'discover.story.musicEmpty' => '曲が見つかりません。',
			'discover.story.musicError' => '曲を読み込めませんでした。',
			'discover.story.downloaded' => 'ギャラリーに保存しました',
			'discover.story.downloadFailed' => '保存できませんでした',
			'discover.highlight.title' => 'ハイライト',
			'discover.highlight.view' => '表示',
			'discover.highlight.aiComments' => 'AIコメント',
			'discover.highlight.remove' => 'ハイライトを削除',
			'discover.highlight.sharedSuccess' => '投稿をシェアしました',
			'discover.highlight.boost' => 'ブースト',
			'discover.stats.title' => '統計',
			'discover.stats.subtitle' => '投稿の統計は\n以下のとおりです。',
			'discover.stats.viewers' => '閲覧者',
			'discover.stats.comments' => 'コメント',
			'discover.stats.likes' => 'いいね',
			'discover.stats.boostCta' => '1日ブースト - 100トークン',
			'discover.stats.boosted' => 'ブースト完了！投稿が24時間トップに表示されます。',
			'discover.hostedBy' => ({required Object name}) => 'ホスト：${name}',
			'common.loading' => '読み込み中…',
			'common.retry' => '再試行',
			'common.cancel' => 'キャンセル',
			'common.save' => '保存',
			'common.continueAction' => '続ける',
			'common.language' => '言語',
			'common.or' => 'または',
			'languages.tr' => 'Türkçe',
			'languages.en' => 'English',
			'auth.createAccountTitle' => 'アカウントを作成',
			'auth.createAccountSubtitle' => 'Veyloに参加して、つながりを始めよう。',
			'auth.welcomeBackTitle' => 'おかえりなさい',
			'auth.welcomeBackSubtitle' => 'ログインしてVeyloを続けよう。',
			'auth.username' => 'ユーザー名',
			'auth.usernameHint' => 'ユーザー名を決める',
			'auth.email' => 'メールアドレス',
			'auth.emailHint' => 'メールアドレスを入力',
			'auth.emailOrUsername' => 'メールアドレスまたはユーザー名',
			'auth.emailOrUsernameHint' => 'メールアドレスまたはユーザー名を入力',
			'auth.password' => 'パスワード',
			'auth.passwordCreateHint' => 'パスワードを作成',
			'auth.passwordEnterHint' => 'パスワードを入力',
			'auth.signUp' => '新規登録',
			'auth.logIn' => 'ログイン',
			'auth.forgotPassword' => 'パスワードをお忘れですか？',
			'auth.continueWithApple' => 'Appleで続ける',
			'auth.continueWithGoogle' => 'Googleで続ける',
			'auth.legalPrefix' => '続けることで、',
			'auth.termsOfService' => '利用規約',
			'auth.legalMiddle' => 'に同意し、',
			'auth.privacyPolicy' => 'プライバシーポリシー',
			'auth.legalSuffix' => 'を確認したものとみなされます。',
			'auth.passwordResetSent' => 'パスワード再設定用のリンクをメールで送信しました。',
			'onboarding.skip' => 'スキップ',
			'onboarding.page1Title' => 'ありのままで、匿名のままで。',
			'onboarding.page1Subtitle' => '正体を明かさずに\n新しい人と出会って話そう。',
			'onboarding.page2Title' => 'メッセージも通話も、ノリで。',
			'onboarding.page2Subtitle' => 'まずは匿名で。準備ができたら、メッセージ、通話、そして直接会うことも。',
			'onboarding.page3Title' => '仲間を見つけて、\n会話に参加しよう。',
			'onboarding.page3Subtitle' => 'ルームに参加して、新しい人と出会い、\nその瞬間を一緒に楽しもう。',
			'onboarding.getStarted' => 'はじめる',
			'onboarding.alreadyHaveAccount' => 'Veyloアカウントをお持ちの方は ',
			'onboarding.logInAction' => 'ログイン',
			'createProfile.navTitle' => 'プロフィール作成',
			'createProfile.stepUsername' => '1/5 ユーザー名',
			'createProfile.title' => 'プロフィールを作成',
			'createProfile.subtitle' => '本名は本人確認にのみ使用され、公開されることはありません。',
			'createProfile.subtitleLine1' => '本名は本人確認にのみ使用され、',
			'createProfile.subtitleLine2' => '公開されることはありません。',
			'createProfile.fullName' => '氏名',
			'createProfile.fullNameHint' => 'Sam Lee',
			'createProfile.username' => 'ユーザー名',
			'createProfile.usernameHint' => 'samlee123',
			'createProfile.usernameTaken' => 'このユーザー名は既に使われています！',
			'createProfile.usernameAvailable' => 'このユーザー名は使用できます',
			'createProfile.mightWantToTry' => 'こちらはいかが？',
			'createProfile.stepPhoto' => '2/5 プロフィール写真',
			'createProfile.photoTitle' => 'プロフィール写真をアップロード',
			'createProfile.photoSubtitle' => '他のユーザーがあなた本人だと確認できるよう、プロフィール写真が表示されます。',
			'createProfile.photoSubtitleLine1' => '他のユーザーがあなた本人だと確認できるよう、',
			'createProfile.photoSubtitleLine2' => 'プロフィール写真が表示されます。',
			'createProfile.choosePhoto' => '写真を選ぶ',
			'createProfile.continueWithoutPhoto' => '写真なしで続ける',
			'createProfile.saveAndContinue' => '保存して続ける',
			'createProfile.choosePhotoSheetTitle' => '写真を選ぶ',
			'createProfile.takePhoto' => '写真を撮る',
			'createProfile.chooseFromGallery' => 'ライブラリから選ぶ',
			'createProfile.stepGender' => '3/5 性別',
			'createProfile.genderTitle' => '性別を選択',
			'createProfile.genderSubtitle' => 'この情報を提供いただいた場合、あなたに合ったコンテンツの表示に使用することがあります',
			'createProfile.genderSubtitleLine1' => 'この情報を提供いただいた場合、あなたに合った',
			'createProfile.genderSubtitleLine2' => 'コンテンツの表示に使用することがあります',
			'createProfile.genderFemale' => '女性',
			'createProfile.genderMale' => '男性',
			'createProfile.genderNonBinary' => 'ノンバイナリー',
			'createProfile.genderPreferNotToSay' => '答えたくない',
			'createProfile.stepInterests' => '4/5 興味',
			'createProfile.interestsTitle' => '何が好き？',
			'createProfile.interestsSubtitle' => '5つ以上選んでね。あなたを本当に分かってくれる人とマッチしやすくなります。',
			'createProfile.interests.music' => '音楽',
			'createProfile.interests.movies' => '映画',
			'createProfile.interests.tvShows' => 'ドラマ・TV',
			'createProfile.interests.reading' => '読書',
			'createProfile.interests.painting' => '絵画',
			'createProfile.interests.photography' => '写真',
			'createProfile.interests.theatre' => '演劇',
			'createProfile.interests.fitness' => 'フィットネス',
			'createProfile.interests.swimming' => '水泳',
			'createProfile.interests.football' => 'サッカー',
			'createProfile.interests.basketball' => 'バスケ',
			'createProfile.interests.coffee' => 'コーヒー',
			'createProfile.interests.travel' => '旅行',
			'createProfile.interests.camping' => 'キャンプ',
			'createProfile.interests.meditation' => '瞑想',
			'createProfile.interests.videoGames' => 'ゲーム',
			'createProfile.interests.boardGames' => 'ボードゲーム',
			'createProfile.interests.standUp' => 'お笑い',
			'createProfile.interests.tech' => 'テクノロジー',
			'createProfile.interests.coding' => 'プログラミング',
			'createProfile.interests.ai' => 'AI',
			'createProfile.interests.podcast' => 'ポッドキャスト',
			_ => null,
		} ?? switch (path) {
			'createProfile.stepChatGoal' => '5/5 チャットの目的',
			'createProfile.chatGoalTitle' => '今日は何を探してる？',
			'createProfile.chatGoalSubtitle' => '今の気分にぴったりの相手を見つけるのに役立ちます。',
			'createProfile.chatGoalQuickMatch' => 'クイックマッチ — すぐに\n会話を始める',
			'createProfile.chatGoalFlirtyChat' => 'ドキドキトーク — 軽くて楽しい\n会話',
			'createProfile.chatGoalMoodMatch' => '気分マッチ — 今の気持ちで\nマッチング',
			'createProfile.chatGoalLateNight' => '深夜トーク — みんなが寝静まった頃に\nじっくり話す',
			'createProfile.chatGoalMeetSomeoneNew' => '新しい出会い — 目的なしで\n気軽に探す',
			'createProfile.getStarted' => 'はじめる',
			'createProfile.preparingTitleLine1' => 'あなたにぴったりの',
			'createProfile.preparingTitleLine2' => 'プロフィールを',
			'createProfile.preparingTitleLine3' => '準備しています。',
			'createProfile.preparingSubtitleLine1' => 'あなたの回答をもとに',
			'createProfile.preparingSubtitleLine2' => '最適な相手を選んでいます。少々お待ちください。',
			'createProfile.preparingPercent' => ({required Object percent}) => '${percent}%',
			'createProfile.usernameInvalid' => '3〜30文字の英数字、ピリオド、アンダースコアを使用してください。',
			'errors.network' => 'Veyloに接続できません。接続を確認して、もう一度お試しください。',
			'errors.generic' => 'エラーが発生しました。もう一度お試しください。',
			'errors.signInFailed' => 'ログインに失敗しました。もう一度お試しください。',
			'errors.sessionExpired' => 'セッションが終了しました。もう一度ログインしてください。',
			'errors.accountSuspended' => 'このアカウントは停止されています。',
			'errors.unsupportedImage' => 'JPEG、PNG、WebPの写真を選んでください。',
			'errors.fileTooLarge' => 'ファイルサイズが大きすぎます。',
			'errors.enterEmailForReset' => 'パスワードを再設定するには、上にメールアドレスを入力してください。',
			'errors.wrongCredentials' => 'メールアドレス/ユーザー名またはパスワードが正しくありません。',
			'errors.emailInUse' => 'このメールアドレスは既に登録されています。ログインしてみてください。',
			'errors.weakPassword' => 'パスワードは6文字以上にしてください。',
			'errors.invalidEmail' => '有効なメールアドレスを入力してください。',
			'errors.tooManyAttempts' => '試行回数が多すぎます。少し待ってからお試しください。',
			'errors.fillAllFields' => 'すべての項目を入力してください。',
			'errors.insufficientTokens' => 'トークンが足りません。',
			'errors.requestNotAccepted' => '返信するにはリクエストを承認してください。',
			'errors.requestPendingLimit' => '相手がリクエストを承認すると、さらにメッセージを送れます。',
			'errors.blocked' => 'この人にはメッセージを送れません。',
			'errors.peerUnavailable' => 'このアカウントは利用できなくなりました。',
			'errors.vibeDailyLimit' => '今日はたくさんVibesをシェアしました。また後で試してね。',
			'errors.groupFull' => 'このグループは満員です。',
			'errors.groupCreateLimit' => '今日はグループを作りすぎました。また後で試してね。',
			'errors.notFound' => 'このコンテンツは利用できなくなりました。',
			'errors.recentLogin' => 'セキュリティのため、一度ログアウトして再ログインしてから、もう一度お試しください。',
			'errors.socialAccount' => 'メールアドレスとパスワードはGoogleまたはAppleアカウントで管理されています。',
			'errors.alreadyInCall' => '既に通話中です。',
			'errors.roomPrivate' => 'このルームは非公開です。ホストに参加をリクエストしてください。',
			'errors.roomFull' => 'このルームは満員です。',
			'errors.alreadyCheckedIn' => '今日の報酬はすでに受け取り済みです。',
			'errors.purchasesUnavailable' => '現在、購入はご利用いただけません。',
			'faq.q1' => 'このアプリはどう使うの？',
			'faq.q2' => '匿名チャットとは？',
			'faq.q3' => 'つながり度とは？',
			'faq.q4' => 'プロフィールを公開するには？',
			'faq.q5' => '60秒ストレンジャーとは？',
			'faq.q6' => 'Vibesとは？',
			'faq.q7' => 'プロフィールを編集するには？',
			'faq.q8' => '通知を管理するには？',
			'faq.q9' => '購入を復元するには？',
			'faq.q10' => 'すべての会話を削除できますか？',
			'faq.q11' => 'データは安全ですか？',
			'faq.q12' => 'ブロックや報告をするには？',
			'faq.q13' => 'アプリをシェアするには？',
			'faq.q14' => 'アカウントを削除するには？',
			'faq.a1' => 'Veyloでは匿名で新しい人と出会い、チャットして、つながりが深まるにつれて少しずつプロフィールを公開できます。お互いの準備ができたら、メッセージ、音声、直接会うことにも切り替えられます。',
			'faq.a2' => '匿名チャットでは、あなたの正体と写真は非公開のままです。つながりが深まると、名前のイニシャルやぼかし写真などが解放されます。100%になると、お互いが同意すればプロフィール全体が公開されます。',
			'faq.a3' => 'チャットするほど、つながりのパーセンテージが上がります。一定の段階で名前のイニシャル、ぼかし写真、プロフィール全体が解放されます。「つながり」をタップすると詳細を確認できます。',
			'faq.a4' => 'つながりが100%になったら「プロフィールを公開」をタップします。相手も承認すると、お互いのプロフィール全体が表示されます。',
			'faq.a5' => '「通話」タブから、ランダムな相手と短時間マッチできます。時間切れになったら、話し続けるか通話を終了するかを選べます。',
			'faq.a6' => 'Vibesでは、近くや周りにいる人をマップ/リスト表示で見つけて、気になる人とチャットを始められます。',
			'faq.a7' => '「プロフィール」タブを開き、「プロフィールを編集」から名前、写真、自己紹介、興味を更新できます。変更は保存後に反映されます。',
			'faq.a8' => '「設定」の「通知」から、メッセージやマッチなどの通知をオン/オフできます。',
			'faq.a9' => '設定 → アカウント管理 → 購入を復元 へ進んでください。同じストアアカウントで購入した対象アイテムが復元されます。',
			'faq.a10' => 'はい。設定 → 会話を削除 から確認してください。すべてのチャットが削除されます。この操作は取り消せません。',
			'faq.a11' => 'アカウント情報とメッセージは保護されたシステムに保存されています。また、「アカウント管理」からいつでもアカウントとデータの削除をリクエストできます。',
			'faq.a12' => 'プロフィールやチャット画面のメニューからブロックや報告ができます。報告はチームが確認します。',
			'faq.a13' => '「設定」の「アプリをシェア」からリンクをコピーして、友達に送ってください。',
			'faq.a14' => '設定 → アカウント管理 → アカウントとデータを削除 へ進んでください。理由を入力したあと、確認すると削除リクエストが送信されます。',
			'legal.termsTitle' => '利用規約',
			'legal.privacyTitle' => 'プライバシーポリシー',
			'legal.termsBody' => '最終更新日：2026年3月16日\n\nVeyloへようこそ。アカウントを作成するか本アプリを利用することにより、あなたは本利用規約に同意したものとみなされます。\n\n1. Veyloについて\nVeyloは、人と出会い、匿名でチャットし、時間をかけてつながりを築き、双方が同意した場合には音声通話やビデオ通話に移行することもできるソーシャルアプリです。\n\n2. アカウント\nあなたは正確な情報を提供し、ログイン情報を安全に管理しなければなりません。あなたのアカウントで行われた行為については、あなたが責任を負います。お住まいの国の法律に基づき、Veyloを利用できる年齢に達している必要があります。\n\n3. 礼儀ある利用\n嫌がらせ、脅迫、詐欺、なりすまし、違法なコンテンツの共有、安全機能の回避を試みることは禁止されています。これらのルールに違反した場合、当社はコンテンツの削除、機能の制限、またはアカウントの停止を行うことがあります。\n\n4. 匿名チャットとプロフィール公開\n匿名チャットでは、つながりの段階に到達するまで、あなたの名前と写真が非表示になる場合があります。プロフィール全体の公開には双方の同意が必要です。他のユーザーに正体を明かすよう強要しないでください。\n\n5. 購入\n一部の機能は有料の場合があります。購入はApple App StoreまたはGoogle Playを通じて処理されます。「購入を復元」により、同じストアアカウントで購入した対象アイテムを復元できます。返金は各ストアのポリシーに従います。\n\n6. あなたが共有するコンテンツ\nあなたのコンテンツに関する権利はあなたに帰属しますが、サービスの運営に必要な範囲で、アプリ内でコンテンツをホストおよび表示するためのライセンスをVeyloに付与するものとします。共有する権利を持たないコンテンツは投稿しないでください。\n\n7. 利用の終了\nあなたはいつでもVeyloの利用を停止し、「設定」からアカウントの削除をリクエストできます。また、当社は必要に応じて、合理的な通知のうえでサービスを終了または変更することがあります。\n\n8. お問い合わせ\n本規約に関するご質問：support@veylo.app',
			'legal.privacyBody' => '最終更新日：2026年3月16日\n\n本プライバシーポリシーは、Veyloがあなたの情報をどのように収集、利用、保護するかを説明するものです。\n\n1. 収集する情報\n• アカウントデータ：メールアドレス、表示名、プロフィール写真、自己紹介、設定\n• 利用データ：チャット、つながり度、利用した通話機能、端末およびアプリの基本情報\n• 購入情報：有料機能の解放および復元に必要なストアのレシートデータ\n\n2. 情報の利用方法\n当社は、Veyloの運営、マッチングおよびチャット体験のパーソナライズ、コミュニティの安全の確保、購入の処理、製品の改善のためにあなたのデータを利用します。当社があなたの個人データを販売することはありません。\n\n3. 匿名モード\n匿名チャットでは、解放ルールと双方の同意によってより多くの情報が許可されるまで、他のユーザーに表示される内容（例：伏せ字の名前やぼかした写真）を制限します。ただし、機能を安全に運営するため、システム内部ではアカウント識別子を引き続き必要とします。\n\n4. 共有\n当社は、ホスティング、分析、決済処理を支援するサービスプロバイダーと、必要な範囲に限りデータを共有することがあります。また、法律で求められる場合や、ユーザーを危害から守るために情報を開示することがあります。\n\n5. 保存期間\n当社は、アカウントが有効な間、および法令、安全、請求上の理由で必要な期間、データを保持します。削除リクエストの処理が完了した後は、保持が義務付けられている場合を除き、個人データを削除または匿名化します。\n\n6. あなたの選択\nあなたは、プロフィール情報の編集、通知の管理、アカウント削除のリクエスト、およびご自身のデータに関するお問い合わせを行うことができます。ストアでの購入はAppleまたはGoogleを通じても管理されます。\n\n7. セキュリティ\n当社は、あなたの情報を保護するために合理的な技術的および組織的措置を講じています。完全に安全なシステムは存在しないため、強力なパスワードを使用し、端末を最新の状態に保ってください。\n\n8. お問い合わせ\nプライバシーに関するご質問：privacy@veylo.app',
			'logout.title' => 'ログアウト',
			'logout.subtitle' => '本当にログアウトしますか？',
			'logout.cancel' => 'キャンセル',
			'logout.confirm' => 'ログアウト',
			'deleteAccount.title' => 'アカウント削除をリクエスト',
			'deleteAccount.subtitle' => '本当にアカウントを削除しますか？',
			'deleteAccount.reasonTitle' => 'いなくなるのは寂しいけど、理解しています。',
			'deleteAccount.reasonBefore' => '',
			'deleteAccount.reasonAfter' => 'をより良くするために、退会したい理由を教えてもらえますか？',
			'deleteAccount.reasonLabel' => 'アカウントを削除したい理由',
			'deleteAccount.reasonHint' => 'メッセージを入力',
			'deleteAccount.cancel' => 'キャンセル',
			'deleteAccount.createRequest' => 'リクエストを作成',
			'deleteAccount.confirmTitle' => '本当に削除リクエストを送信しますか？',
			'deleteAccount.confirmSubtitle' => '確認すると、アカウント削除リクエストが送信されます',
			'deleteAccount.delete' => '削除',
			'storyText.bold' => '太字',
			'storyText.italic' => '斜体',
			'storyText.uppercase' => '大文字',
			'storyText.underline' => '下線',
			'storyText.cancel' => 'キャンセル',
			'storyText.galleryError' => 'ギャラリーを開けませんでした',
			'tokens.boostTitle' => 'Boost',
			'tokens.history' => '履歴',
			'tokens.yourBalance' => '残高',
			'tokens.balanceTokens' => ({required Object count}) => '${count} トークン',
			'tokens.getMore' => 'トークンを追加',
			'tokens.checkinTitle' => 'デイリーチェックイン',
			'tokens.checkinSubtitle' => ({required Object max}) => '毎日続けて受け取ると、1日最大${max}トークン獲得',
			'tokens.day' => ({required Object n}) => '${n}日目',
			'tokens.collectDay' => ({required Object n}) => '${n}日目のトークンを受け取る',
			'tokens.collectedToday' => ({required Object n}) => '明日また来て${n}日目を受け取ろう',
			'tokens.duration30m' => '30分',
			'tokens.duration1h' => '1時間',
			'tokens.duration2h' => '2時間',
			'tokens.visibility' => ({required Object n}) => '表示回数${n}倍',
			'tokens.boostFor' => ({required Object count}) => '${count}トークンでBoost',
			'tokens.boostActive' => ({required Object time}) => '${time}までBoost中',
			'tokens.boostDone' => 'プロフィールをBoostしました！',
			'tokens.historyEmpty' => 'トークンの履歴はまだありません',
			'tokens.balanceLine' => ({required Object count}) => '残高 ${count} トークン',
			'tokens.reasonPurchase' => 'トークン購入',
			'tokens.reasonCheckin' => 'デイリーチェックイン',
			'tokens.reasonWelcome' => 'ウェルカムボーナス',
			'tokens.reasonGenderFilter' => '性別フィルター通話',
			'tokens.reasonVideoCall' => 'ビデオ通話',
			'tokens.reasonRoomCreate' => 'ルーム作成',
			'tokens.reasonBorder' => 'プロフィール枠',
			'tokens.reasonPostBoost' => '投稿Boost',
			'tokens.reasonRefund' => '返金',
			'tokens.reasonAdjust' => '残高調整',
			'tokens.packsTitle' => 'トークンを追加',
			'tokens.packsSubtitle' => 'トークンパックを選択',
			'tokens.packTokens' => ({required Object count}) => '${count} トークン',
			'tokens.buy' => '購入',
			'tokens.purchaseDone' => ({required Object count}) => '${count}トークンが残高に追加されました',
			'tokens.notEnoughTitle' => 'トークンが足りません',
			'tokens.notEnoughSubtitle' => '続けるには残高をチャージしてください。',
			_ => null,
		};
	}
}
