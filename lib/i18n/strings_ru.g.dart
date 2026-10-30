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
class TranslationsRu extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsRu({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ru,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ru>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key) ?? super[key];

	late final TranslationsRu _root = this; // ignore: unused_field

	@override 
	TranslationsRu $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsRu(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$app$ru app = _Translations$app$ru._(_root);
	@override late final _Translations$home$ru home = _Translations$home$ru._(_root);
	@override late final _Translations$chats$ru chats = _Translations$chats$ru._(_root);
	@override late final _Translations$profile$ru profile = _Translations$profile$ru._(_root);
	@override late final _Translations$nav$ru nav = _Translations$nav$ru._(_root);
	@override late final _Translations$call$ru call = _Translations$call$ru._(_root);
	@override late final _Translations$vibes$ru vibes = _Translations$vibes$ru._(_root);
	@override late final _Translations$discover$ru discover = _Translations$discover$ru._(_root);
	@override late final _Translations$common$ru common = _Translations$common$ru._(_root);
	@override late final _Translations$languages$ru languages = _Translations$languages$ru._(_root);
	@override late final _Translations$auth$ru auth = _Translations$auth$ru._(_root);
	@override late final _Translations$onboarding$ru onboarding = _Translations$onboarding$ru._(_root);
	@override late final _Translations$createProfile$ru createProfile = _Translations$createProfile$ru._(_root);
	@override late final _Translations$errors$ru errors = _Translations$errors$ru._(_root);
	@override late final _Translations$faq$ru faq = _Translations$faq$ru._(_root);
	@override late final _Translations$legal$ru legal = _Translations$legal$ru._(_root);
	@override late final _Translations$logout$ru logout = _Translations$logout$ru._(_root);
	@override late final _Translations$deleteAccount$ru deleteAccount = _Translations$deleteAccount$ru._(_root);
	@override late final _Translations$storyText$ru storyText = _Translations$storyText$ru._(_root);
}

// Path: app
class _Translations$app$ru extends Translations$app$tr {
	_Translations$app$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Veylo';
	@override String get tagline => 'Добро пожаловать';
}

// Path: home
class _Translations$home$ru extends Translations$home$tr {
	_Translations$home$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Главная';
	@override String get subtitle => 'Приложение готовится';
	@override String get body => 'Многоязычный интерфейс работает на slang.';
}

// Path: chats
class _Translations$chats$ru extends Translations$chats$tr {
	_Translations$chats$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Чаты';
	@override String get search => 'Поиск';
	@override String get messagesSection => 'Сообщения';
	@override String get request => 'Запросы';
	@override String get emptyRequestTitle => 'Новых запросов\nна переписку нет';
	@override String get emptyRequestSubtitle => 'Запросы старше 30 дней не показываются.';
	@override String get noteAdd => 'Заметка';
	@override String get anonymous => 'Аноним';
	@override String get online => 'в сети';
	@override String get offline => 'не в сети';
	@override String get connection => 'Связь';
	@override String connectionPercent({required Object n}) => '${n}%';
	@override String get connectionProgressTitle => 'Прогресс связи';
	@override String get milestoneInitial => 'Первая буква имени';
	@override String get milestoneInitialHint => 'Открыто на 25%';
	@override String get milestoneInitialLocked => 'Откроется на 25%';
	@override String get milestonePhoto => 'Размытое фото';
	@override String get milestonePhotoHint => 'Откроется на 70%';
	@override String get milestoneFull => 'Полный профиль';
	@override String get milestoneFullHint => 'По взаимному согласию на 100%';
	@override String get sampleAnonymousMessage => 'Привет, рад(а) знакомству! Расскажешь немного о себе?';
	@override String get strangerSampleMessage => 'Привет, Jhon, рад(а) знакомству! Расскажешь немного о себе?';
	@override String get approve => 'Принять';
	@override String get blockUser => 'Заблокировать';
	@override String get reject => 'Отклонить';
	@override String get messageHint => 'Привет! Как дела?';
	@override String get revealTitle => 'Вы достигли 100%';
	@override String get revealSubtitle => 'Открыть друг другу полные профили? Нужно согласие обоих.';
	@override String revealWaiting({required Object name}) => 'Ждём согласия ${name}';
	@override String get revealCta => 'Раскрыть мой профиль';
	@override String get revealNotYet => 'Пока нет';
	@override String get seen => 'Просмотрено';
	@override String get typing => 'печатает…';
	@override String get noteYou => 'Ты';
	@override String get noteSheetTitle => 'Поделиться заметкой';
	@override String get noteSheetSubtitle => 'Заметка видна 24 часа';
	@override String get noteHint => 'О чём думаешь?';
	@override String get noteShare => 'Поделиться';
	@override String get noteDelete => 'Удалить заметку';
}

// Path: profile
class _Translations$profile$ru extends Translations$profile$tr {
	_Translations$profile$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get eyebrow => 'Профиль';
	@override String get title => 'Настройки';
	@override String get editProfile => 'Изменить профиль';
	@override String get statLike => 'Лайки';
	@override String get statFollow => 'Подписки';
	@override String get statFollower => 'Подписчики';
	@override String get promoTitle => 'Больше сообщений!';
	@override String get promoSubtitle => 'Выделись и будь в начале списка';
	@override String get standOut => 'Выделиться';
	@override String get tabPosts => 'Посты';
	@override String get tabVideo => 'Видео';
	@override String get tabSaved => 'Сохранённое';
	@override String get save => 'Сохранить';
	@override String get changePhoto => 'Сменить фото';
	@override String get changeBorder => 'Сменить рамку';
	@override String get interest => 'Интересы';
	@override String get name => 'Имя';
	@override String get changeName => 'Сменить имя';
	@override String get changePassword => 'Сменить пароль';
	@override String get confirmPassword => 'Повтори пароль';
	@override String get email => 'Эл. почта';
	@override String get accountManagement => 'Управление аккаунтом';
	@override String get settingsAbout => 'О приложении';
	@override String get settingsAccount => 'Настройки аккаунта';
	@override String get settingsSupport => 'Поддержка';
	@override String get shareApp => 'Поделиться приложением';
	@override String get shareAppTitle => 'Поделись с друзьями';
	@override String get shareAppSubtitle => 'Поделись Veylo с друзьями и открывайте новое вместе!';
	@override String get shareAppLabel => 'Ссылка на приложение';
	@override String get rateApp => 'Нравится? Оцени нас';
	@override String get notifications => 'Уведомления';
	@override String get password => 'Пароль';
	@override String get deleteConversation => 'Удалить чаты';
	@override String get faqHelp => 'FAQ и помощь';
	@override String get restorePurchases => 'Восстановить покупки';
	@override String get termsOfService => 'Условия использования';
	@override String get privacyPolicy => 'Политика конфиденциальности';
	@override String get restorePurchasesDone => 'Покупки проверены';
	@override String get conversationsDeleted => 'Все чаты удалены';
	@override String get logOut => 'Выйти';
	@override String get deleteAccountAndData => 'Удалить аккаунт и данные';
	@override String get passwordPlaceholder => '********';
	@override String get height => 'Рост';
	@override String get addHeight => 'Указать рост';
	@override String heightCm({required Object value}) => '${value} см';
	@override String get languages => 'Языки';
	@override String get relationshipGoals => 'Цели отношений';
	@override String get lookingFor => 'Ищу';
	@override String get newFriends => '👋 Новых друзей';
	@override String get goalLongTermOpenToShort => '💕 Долгие, но открыт(а) к коротким';
	@override String get goalLongTermRelationship => '💘 Долгие отношения';
	@override String get goalNewFriends => '👋 Новые друзья';
	@override String get goalShortTermFun => '🥃 Что-то несерьёзное';
	@override String get goalStillFiguringItOut => '🤔 Пока не определился(ась)';
	@override String get basics => 'Основное';
	@override String get zodiac => 'Знак зодиака';
	@override String get zodiacValue => 'Скорпион';
	@override String get education => 'Образование';
	@override String get educationValue => 'Бакалавр';
	@override String get educationHighSchool => 'Среднее';
	@override String get educationAssociates => 'Среднее специальное';
	@override String get educationBachelors => 'Бакалавриат';
	@override String get educationMasters => 'Магистратура';
	@override String get educationPhd => 'Кандидат / доктор наук';
	@override String get voiceRecord => 'Голосовая запись';
	@override String get addVoice => 'Добавить голос';
	@override String get lifestyle => 'Образ жизни';
	@override String get pets => 'Питомцы';
	@override String get petsValue => 'Есть кошка';
	@override String get petsDontWant => 'Не хочу питомцев';
	@override String get petsAllergic => 'Аллергия на животных';
	@override String get petsHaveCat => 'Есть кошка';
	@override String get petsHaveDog => 'Есть собака';
	@override String get petsHaveCatsAndDogs => 'Есть кошки и собаки';
	@override String get petsHaveOther => 'Есть другие питомцы';
	@override String get drinking => 'Алкоголь';
	@override String get drinkingValue => 'По особым случаям';
	@override String get drinkingNever => 'Никогда';
	@override String get drinkingSpecialOccasions => 'По особым случаям';
	@override String get drinkingSocially => 'В компании';
	@override String get drinkingFrequently => 'Часто';
	@override String get drinkingSober => 'Не пью';
	@override String get drinkingPreferNotToSay => 'Не скажу';
	@override String get smoking => 'Курение';
	@override String get smokingValue => 'Не курю';
	@override String get smokingNonSmoker => 'Не курю';
	@override String get smokingSocialSmoker => 'Курю в компании';
	@override String get smokingSmoker => 'Курю';
	@override String get smokingTryingToQuit => 'Пытаюсь бросить';
	@override String get smokingWhenDrinking => 'Курю, когда выпиваю';
	@override String get smokingPreferNotToSay => 'Не скажу';
	@override String get gender => 'Пол';
	@override String get genderFemale => 'Женский';
	@override String get genderMale => 'Мужской';
	@override String get genderPreferNotToSay => 'Не хочу указывать';
	@override String get visible => 'Виден';
	@override String get profileVisibility => 'Видимость профиля';
	@override String get language => 'Язык';
	@override String get borderTitle => 'Рамка профиля';
	@override String get borderSubtitle => 'Добавь рамку к профилю,\nчтобы выделиться.';
	@override String get borderBuySection => 'Купить рамку';
	@override String get borderBuyCta => 'Купить рамку';
	@override String borderToken({required Object count}) => 'Токены: ${count}';
	@override String get borderAmethystWings => 'Amethyst Wings';
	@override String get borderGoldenPhoenix => 'Golden Phoenix';
	@override String get borderFrostCrown => 'Frost Crown';
	@override String get borderEmeraldWhisper => 'Emerald Whisper';
	@override String get borderRoseQuartz => 'Rose Quartz';
	@override String get borderStarlitComet => 'Starlit Comet';
	@override String get borderCrimsonRoyal => 'Crimson Royal';
	@override String get borderSapphireHalo => 'Sapphire Halo';
	@override String get follow => 'Подписаться';
	@override String get following => 'Подписки';
	@override String get followPageTitle => 'Подписки';
	@override String get followTabFollowing => 'Подписки';
	@override String get followTabFollowers => 'Подписчики';
	@override String get followSearch => 'Поиск';
	@override String get unfollow => 'Отписаться';
	@override String get followSortTitle => 'Сортировка';
	@override String get followSortRecent => 'Недавние подписки';
	@override String get followSortNotFollowingMe => 'Не подписаны на меня в ответ';
	@override String get followSortNotFollowedByMe => 'Я не подписан(а) в ответ';
	@override String get followSortShowResult => 'Показать';
	@override String get followSortEmpty => 'Под этот фильтр никто не подходит';
	@override String get shareTitle => 'Поделись с друзьями';
	@override String get shareSubtitle => 'С друзьями всё\nвеселее!';
	@override String get shareProfileLabel => 'Поделиться профилем';
	@override String get shareLinkCopied => 'Ссылка скопирована';
	@override String get restrict => 'Ограничить';
	@override String get block => 'Заблокировать';
	@override String get report => 'Пожаловаться';
	@override String blockTitle({required Object username}) => 'Заблокировать ${username}?';
	@override String get blockBody => 'Также будут заблокированы другие их аккаунты, включая будущие. Разблокировать можно в любой момент.';
	@override String get blockAndReport => 'Заблокировать и пожаловаться';
	@override String restrictTitle({required Object username}) => 'Ограничить ${username}?';
	@override String get restrictBody => 'Они не увидят, когда ты в сети и прочитал(а) ли ты их сообщения. Это можно изменить в любой момент.';
	@override String get restrictAndReport => 'Ограничить и пожаловаться';
	@override String get reportTitle => 'Расскажи, что случилось';
	@override String get reportSubtitle => 'Чтобы мы стали лучше, расскажи, почему хочешь пожаловаться на этого пользователя?';
	@override String get reportMessageLabel => 'Текст жалобы';
	@override String get reportMessageHint => 'Напиши сообщение';
	@override String get reportCancel => 'Отмена';
	@override String get sendReport => 'Отправить';
	@override String get notSet => 'Не указано';
	@override String get reportSent => 'Спасибо, жалоба получена.';
	@override String emailVerificationSent({required Object email}) => 'Мы отправили ссылку для подтверждения на ${email}. Почта изменится после подтверждения.';
	@override String get passwordChanged => 'Пароль обновлён.';
	@override String get passwordMismatch => 'Пароли не совпадают.';
}

// Path: nav
class _Translations$nav$ru extends Translations$nav$tr {
	_Translations$nav$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get discover => 'Обзор';
	@override String get chat => 'Чат';
	@override String get call => 'Звонок';
	@override String get vibes => 'Vibes';
	@override String get profile => 'Профиль';
}

// Path: call
class _Translations$call$ru extends Translations$call$tr {
	_Translations$call$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Незнакомец на 60 секунд';
	@override String get subtitle => 'Поговори 60 секунд со случайным незнакомцем — полностью анонимно. Без профиля, фото и имени. Только голос и момент.';
	@override String get findingTitle => 'Ищем собеседника...';
	@override String get findingSubtitle => 'Вы поговорите анонимно 60 секунд. Без профилей и имён.';
	@override String get callStranger => 'Позвонить — 10 токенов';
	@override String get cancel => 'Отмена';
	@override String get female => 'Женщина';
	@override String get male => 'Мужчина';
	@override String get nonBinary => 'Небинарный';
	@override String get preferNotToSay => 'Не скажу';
	@override String get anonymousBadge => '🎙️ Анонимный звонок';
	@override String get stranger => 'Незнакомец';
	@override String secondsLeft({required Object n}) => '${n} с';
	@override String get timesUpTitle => 'Время вышло!';
	@override String get timesUpSubtitle => 'Хотите продолжить? Если оба согласны, откроется чат.';
	@override String get keepTalking => 'Продолжить';
	@override String get endCall => 'Завершить';
	@override String get waitingOther => 'Ждём собеседника...';
	@override String get callStrangerFree => 'Позвонить';
	@override String get peerLeft => 'Собеседник завершил звонок.';
	@override String get noKeep => 'В этот раз чат не открылся.';
	@override String get videoWaiting => 'Ждём, когда примут видеозвонок...';
	@override String get videoDeclined => 'Видеозвонок отклонён.';
	@override String get micDenied => 'Для звонков нужен доступ к микрофону. Включи его в настройках.';
	@override String get videoCost => 'Видеозвонок: 20 токенов / 15 мин';
	@override String get calling => 'Вызов';
	@override String get accept => 'Принять';
	@override String get decline => 'Отклонить';
	@override String get switchToVideo => 'Перейти на видеозвонок?';
	@override String get noMatchTitle => 'Сейчас никого нет';
	@override String get noMatchBody => 'Сейчас не удалось найти собеседника. Попробуй ещё раз чуть позже.';
	@override String get noMatchOk => 'ОК';
}

// Path: vibes
class _Translations$vibes$ru extends Translations$vibes$tr {
	_Translations$vibes$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get search => 'Поиск';
	@override String get sendMessage => 'Написать';
	@override String get wantsToTalk => 'Хочет обсудить это прямо сейчас';
	@override String get shareTitle => 'Поделиться Vibe';
	@override String get replyTitle => 'Ответить на Vibe';
	@override String get shareHint => 'Напиши что-нибудь';
	@override String get shareAnonymous => 'Анонимно';
	@override String get empty => 'За 24 часа Vibes нет. Поделись первым!';
	@override String get deleteTitle => 'Удалить этот Vibe?';
	@override String get delete => 'Удалить';
	@override String get cancel => 'Отмена';
}

// Path: discover
class _Translations$discover$ru extends Translations$discover$tr {
	_Translations$discover$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Обзор';
	@override String get tabRooms => 'Комнаты';
	@override String get tabDiscover => 'Обзор';
	@override String get tabAiMatch => 'AI Match';
	@override late final _Translations$discover$aiMatch$ru aiMatch = _Translations$discover$aiMatch$ru._(_root);
	@override String get searchHint => 'Поиск';
	@override String get allRooms => 'Все комнаты';
	@override String get allGroups => 'Все группы';
	@override String get seeAll => 'Все';
	@override String get live => 'Эфир';
	@override String get join => 'Войти';
	@override String get request => 'Запросить';
	@override String get requested => 'Запрошено';
	@override String get private => 'Закрытая';
	@override String moreCount({required Object count}) => '+${count}';
	@override String activeCount({required Object count}) => 'Активны: ${count}';
	@override String membersCount({required Object count}) => 'Участники: ${count}';
	@override late final _Translations$discover$privateRoom$ru privateRoom = _Translations$discover$privateRoom$ru._(_root);
	@override late final _Translations$discover$roomToken$ru roomToken = _Translations$discover$roomToken$ru._(_root);
	@override late final _Translations$discover$privateRequest$ru privateRequest = _Translations$discover$privateRequest$ru._(_root);
	@override late final _Translations$discover$roomApproved$ru roomApproved = _Translations$discover$roomApproved$ru._(_root);
	@override late final _Translations$discover$createSpace$ru createSpace = _Translations$discover$createSpace$ru._(_root);
	@override late final _Translations$discover$liveRoom$ru liveRoom = _Translations$discover$liveRoom$ru._(_root);
	@override late final _Translations$discover$groupChat$ru groupChat = _Translations$discover$groupChat$ru._(_root);
	@override late final _Translations$discover$groupInfo$ru groupInfo = _Translations$discover$groupInfo$ru._(_root);
	@override late final _Translations$discover$filters$ru filters = _Translations$discover$filters$ru._(_root);
	@override late final _Translations$discover$post$ru post = _Translations$discover$post$ru._(_root);
	@override late final _Translations$discover$story$ru story = _Translations$discover$story$ru._(_root);
	@override late final _Translations$discover$highlight$ru highlight = _Translations$discover$highlight$ru._(_root);
	@override late final _Translations$discover$stats$ru stats = _Translations$discover$stats$ru._(_root);
	@override String hostedBy({required Object name}) => 'Ведущий: ${name}';
}

// Path: common
class _Translations$common$ru extends Translations$common$tr {
	_Translations$common$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get loading => 'Загрузка…';
	@override String get retry => 'Повторить';
	@override String get cancel => 'Отмена';
	@override String get save => 'Сохранить';
	@override String get continueAction => 'Продолжить';
	@override String get language => 'Язык';
	@override String get or => 'ИЛИ';
}

// Path: languages
class _Translations$languages$ru extends Translations$languages$tr {
	_Translations$languages$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get tr => 'Türkçe';
	@override String get en => 'English';
}

// Path: auth
class _Translations$auth$ru extends Translations$auth$tr {
	_Translations$auth$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get createAccountTitle => 'Создай аккаунт';
	@override String get createAccountSubtitle => 'Присоединяйся к Veylo и знакомься.';
	@override String get welcomeBackTitle => 'С возвращением';
	@override String get welcomeBackSubtitle => 'Войди, чтобы продолжить в Veylo.';
	@override String get username => 'Имя пользователя';
	@override String get usernameHint => 'Придумай имя пользователя';
	@override String get email => 'Эл. почта';
	@override String get emailHint => 'Введи эл. почту';
	@override String get emailOrUsername => 'Почта или имя пользователя';
	@override String get emailOrUsernameHint => 'Почта или имя пользователя';
	@override String get password => 'Пароль';
	@override String get passwordCreateHint => 'Придумай пароль';
	@override String get passwordEnterHint => 'Введи пароль';
	@override String get signUp => 'Регистрация';
	@override String get logIn => 'Войти';
	@override String get forgotPassword => 'Забыли пароль?';
	@override String get continueWithApple => 'Продолжить с Apple';
	@override String get continueWithGoogle => 'Продолжить с Google';
	@override String get legalPrefix => 'Продолжая, ты принимаешь ';
	@override String get termsOfService => 'Условия использования';
	@override String get legalMiddle => ' и подтверждаешь, что ознакомлен(а) с ';
	@override String get privacyPolicy => 'Политикой конфиденциальности';
	@override String get legalSuffix => '.';
	@override String get passwordResetSent => 'Мы отправили ссылку для сброса пароля на твою почту.';
}

// Path: onboarding
class _Translations$onboarding$ru extends Translations$onboarding$tr {
	_Translations$onboarding$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get skip => 'Пропустить';
	@override String get page1Title => 'Будь собой. Оставайся анонимным.';
	@override String get page1Subtitle => 'Знакомься и общайся,\nне раскрывая, кто ты.';
	@override String get page2Title => 'Пиши. Говори. Лови вайб.';
	@override String get page2Subtitle => 'Начни анонимно, а когда будешь готов(а) — переписка, звонок или встреча.';
	@override String get page3Title => 'Найди своих. Присоединяйся\nк разговору.';
	@override String get page3Subtitle => 'Заходи в комнаты, знакомься и\nпроживай моменты вместе.';
	@override String get getStarted => 'Начать';
	@override String get alreadyHaveAccount => 'Уже есть аккаунт Veylo? ';
	@override String get logInAction => 'Войти';
}

// Path: createProfile
class _Translations$createProfile$ru extends Translations$createProfile$tr {
	_Translations$createProfile$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get navTitle => 'Создание профиля';
	@override String get stepUsername => '1/5 Имя пользователя';
	@override String get title => 'Создай профиль';
	@override String get subtitle => 'Настоящее имя нужно только для проверки — его никто не увидит.';
	@override String get subtitleLine1 => 'Настоящее имя нужно только для проверки —';
	@override String get subtitleLine2 => 'его никто не увидит.';
	@override String get fullName => 'Полное имя';
	@override String get fullNameHint => 'Sam Lee';
	@override String get username => 'Имя пользователя';
	@override String get usernameHint => 'samlee123';
	@override String get usernameTaken => 'Это имя уже занято!';
	@override String get usernameAvailable => 'Имя свободно';
	@override String get mightWantToTry => 'Попробуй...';
	@override String get stepPhoto => '2/5 Фото профиля';
	@override String get photoTitle => 'Загрузи фото профиля';
	@override String get photoSubtitle => 'Другие увидят твоё фото и убедятся, что это ты.';
	@override String get photoSubtitleLine1 => 'Другие увидят твоё фото и убедятся,';
	@override String get photoSubtitleLine2 => 'что это ты.';
	@override String get choosePhoto => 'Выбрать фото';
	@override String get continueWithoutPhoto => 'Продолжить без фото';
	@override String get saveAndContinue => 'Сохранить и продолжить';
	@override String get choosePhotoSheetTitle => 'Выбери фото';
	@override String get takePhoto => 'Сделать фото';
	@override String get chooseFromGallery => 'Выбрать из галереи';
	@override String get stepGender => '3/5 Пол';
	@override String get genderTitle => 'Укажи пол';
	@override String get genderSubtitle => 'Если ты укажешь эти данные, мы сможем подбирать контент под тебя';
	@override String get genderSubtitleLine1 => 'Если ты укажешь эти данные, мы сможем';
	@override String get genderSubtitleLine2 => 'подбирать контент под тебя';
	@override String get genderFemale => 'Женский';
	@override String get genderMale => 'Мужской';
	@override String get genderNonBinary => 'Небинарный';
	@override String get genderPreferNotToSay => 'Не скажу';
	@override String get stepInterests => '4/5 Интересы';
	@override String get interestsTitle => 'Что тебе нравится?';
	@override String get interestsSubtitle => 'Выбери хотя бы 5 — так мы найдём людей, которые тебя поймут.';
	@override late final _Translations$createProfile$interests$ru interests = _Translations$createProfile$interests$ru._(_root);
	@override String get stepChatGoal => '5/5 Цель общения';
	@override String get chatGoalTitle => 'Что ищешь сегодня?';
	@override String get chatGoalSubtitle => 'Так мы подберём собеседника под твоё настроение.';
	@override String get chatGoalQuickMatch => 'Быстрый подбор — сразу\nв разговор';
	@override String get chatGoalFlirtyChat => 'Флирт — лёгкое, игривое\nобщение';
	@override String get chatGoalMoodMatch => 'По настроению — подбор по тому,\nкак ты себя чувствуешь';
	@override String get chatGoalLateNight => 'Ночные разговоры — душевно, пока мир\nспит';
	@override String get chatGoalMeetSomeoneNew => 'Новые знакомства — без цели, просто\nисследуй';
	@override String get getStarted => 'Начать';
	@override String get preparingTitleLine1 => 'Мы подбираем';
	@override String get preparingTitleLine2 => 'подходящие профили';
	@override String get preparingTitleLine3 => 'для тебя.';
	@override String get preparingSubtitleLine1 => 'Выбираем лучших по твоим ответам —';
	@override String get preparingSubtitleLine2 => 'подожди немного.';
	@override String preparingPercent({required Object percent}) => '${percent}%';
	@override String get usernameInvalid => '3–30 символов: буквы, цифры, точки или подчёркивания.';
}

// Path: errors
class _Translations$errors$ru extends Translations$errors$tr {
	_Translations$errors$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get network => 'Нет связи с Veylo. Проверь подключение и попробуй снова.';
	@override String get generic => 'Что-то пошло не так. Попробуй снова.';
	@override String get signInFailed => 'Не удалось войти. Попробуй снова.';
	@override String get sessionExpired => 'Сессия истекла. Войди снова.';
	@override String get accountSuspended => 'Этот аккаунт заблокирован.';
	@override String get unsupportedImage => 'Выбери фото в формате JPEG, PNG или WebP.';
	@override String get fileTooLarge => 'Файл слишком большой.';
	@override String get enterEmailForReset => 'Введи почту выше, чтобы сбросить пароль.';
	@override String get wrongCredentials => 'Неверная почта/имя пользователя или пароль.';
	@override String get emailInUse => 'Эта почта уже зарегистрирована. Попробуй войти.';
	@override String get weakPassword => 'Пароль должен быть не короче 6 символов.';
	@override String get invalidEmail => 'Введи корректный адрес почты.';
	@override String get tooManyAttempts => 'Слишком много попыток. Подожди немного.';
	@override String get fillAllFields => 'Заполни все поля.';
	@override String get insufficientTokens => 'Недостаточно токенов.';
	@override String get requestNotAccepted => 'Прими запрос, чтобы ответить.';
	@override String get requestPendingLimit => 'Ты сможешь писать дальше, когда запрос примут.';
	@override String get blocked => 'Ты не можешь написать этому человеку.';
	@override String get peerUnavailable => 'Этот аккаунт больше недоступен.';
	@override String get vibeDailyLimit => 'Сегодня ты уже поделился(ась) многими Vibes. Попробуй позже.';
	@override String get groupFull => 'Группа заполнена.';
	@override String get groupCreateLimit => 'Сегодня ты создал(а) слишком много групп. Попробуй позже.';
	@override String get notFound => 'Это больше недоступно.';
	@override String get recentLogin => 'В целях безопасности выйди и войди снова, затем повтори.';
	@override String get socialAccount => 'Почта и пароль управляются твоим аккаунтом Google или Apple.';
	@override String get alreadyInCall => 'Ты уже в звонке.';
	@override String get roomPrivate => 'Комната закрытая. Попроси ведущего впустить тебя.';
	@override String get roomFull => 'Комната заполнена.';
}

// Path: faq
class _Translations$faq$ru extends Translations$faq$tr {
	_Translations$faq$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get q1 => 'Как работает приложение?';
	@override String get q2 => 'Что такое анонимный чат?';
	@override String get q3 => 'Что такое прогресс связи?';
	@override String get q4 => 'Как раскрыть свой профиль?';
	@override String get q5 => 'Что такое «Незнакомец на 60 секунд»?';
	@override String get q6 => 'Что такое Vibes?';
	@override String get q7 => 'Как изменить профиль?';
	@override String get q8 => 'Как настроить уведомления?';
	@override String get q9 => 'Как восстановить покупки?';
	@override String get q10 => 'Можно удалить все чаты?';
	@override String get q11 => 'Мои данные в безопасности?';
	@override String get q12 => 'Как заблокировать или пожаловаться?';
	@override String get q13 => 'Как поделиться приложением?';
	@override String get q14 => 'Как удалить аккаунт?';
	@override String get a1 => 'В Veylo можно анонимно знакомиться, общаться и постепенно раскрывать профиль по мере роста связи. Переходите к переписке, голосу или встрече, когда оба будете готовы.';
	@override String get a2 => 'В анонимном чате твоё имя и фото скрыты. С ростом связи открываются детали: первая буква имени и размытое фото. На 100% для раскрытия полных профилей нужно согласие обоих.';
	@override String get a3 => 'Пока вы общаетесь, процент связи растёт. На определённых этапах открываются первая буква имени, размытое фото и полный профиль. Нажми на значок «Связь», чтобы узнать подробнее.';
	@override String get a4 => 'Когда связь достигнет 100%, нажми «Раскрыть мой профиль». Если собеседник тоже согласится, оба полных профиля станут видны.';
	@override String get a5 => 'Во вкладке «Звонок» можно получить короткий случайный подбор. Когда время выйдет, можно продолжить разговор или завершить звонок.';
	@override String get a6 => 'Vibes помогает находить людей рядом на карте или в списке и начинать чат с теми, кто тебе интересен.';
	@override String get a7 => 'Открой вкладку «Профиль» и перейди в «Изменить профиль», чтобы обновить имя, фото, описание и интересы. Изменения появятся после сохранения.';
	@override String get a8 => 'Открой «Уведомления» в настройках, чтобы включить или выключить оповещения о сообщениях, совпадениях и другом.';
	@override String get a9 => 'Перейди в «Настройки → Управление аккаунтом → Восстановить покупки». Доступные покупки в том же аккаунте магазина будут восстановлены.';
	@override String get a10 => 'Да. Открой «Настройки → Удалить чаты» и подтверди. Все чаты будут удалены. Это нельзя отменить.';
	@override String get a11 => 'Данные аккаунта и сообщения хранятся в защищённых системах. Удалить аккаунт и данные можно в любой момент в разделе «Управление аккаунтом».';
	@override String get a12 => 'Используй меню в профиле или в чате, чтобы заблокировать или пожаловаться. Жалобы проверяет наша команда.';
	@override String get a13 => 'Нажми «Поделиться приложением» в настройках, чтобы скопировать ссылку и отправить друзьям.';
	@override String get a14 => 'Перейди в «Настройки → Управление аккаунтом → Удалить аккаунт и данные». Укажи причину и подтверди, чтобы отправить запрос на удаление.';
}

// Path: legal
class _Translations$legal$ru extends Translations$legal$tr {
	_Translations$legal$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get termsTitle => 'Условия использования';
	@override String get privacyTitle => 'Политика конфиденциальности';
	@override String get termsBody => 'Последнее обновление: 16 марта 2026 г.\n\nДобро пожаловать в Veylo. Создавая аккаунт или пользуясь приложением, ты принимаешь настоящие Условия использования.\n\n1. Что такое Veylo\nVeylo — социальное приложение, где можно знакомиться, общаться анонимно, постепенно сближаться и, если обе стороны согласны, переходить к голосовым или видеозвонкам.\n\n2. Твой аккаунт\nТы обязан(а) указывать достоверные данные и обеспечивать безопасность входа в аккаунт. Ты несёшь ответственность за действия в своём аккаунте. Ты должен(на) достичь возраста, с которого законы твоей страны разрешают пользоваться Veylo.\n\n3. Уважительное поведение\nЗапрещается преследовать, угрожать, мошенничать, выдавать себя за других, распространять незаконный контент или пытаться обойти функции безопасности. Мы можем удалять контент, ограничивать функции или блокировать аккаунты, нарушающие эти правила.\n\n4. Анонимный чат и раскрытие профиля\nВ анонимных чатах имя и фото могут быть скрыты до достижения этапов связи. Полное раскрытие профиля требует взаимного согласия. Не принуждай других раскрывать свою личность.\n\n5. Покупки\nНекоторые функции могут быть платными. Покупки обрабатываются Apple App Store или Google Play. Функция «Восстановить покупки» восстанавливает доступные покупки в том же аккаунте магазина. Возвраты осуществляются согласно правилам магазина.\n\n6. Твой контент\nТы сохраняешь права на свой контент, но предоставляешь Veylo лицензию на его размещение и показ в приложении в объёме, необходимом для работы сервиса. Не публикуй контент, на распространение которого у тебя нет прав.\n\n7. Прекращение использования\nТы можешь в любой момент перестать пользоваться Veylo и запросить удаление аккаунта в настройках. Мы также можем прекратить или изменить работу сервиса, уведомив об этом в разумный срок, когда это требуется.\n\n8. Контакты\nВопросы об этих условиях: support@veylo.app';
	@override String get privacyBody => 'Последнее обновление: 16 марта 2026 г.\n\nНастоящая Политика конфиденциальности объясняет, как Veylo собирает, использует и защищает твою информацию.\n\n1. Какие данные мы собираем\n• Данные аккаунта: эл. почта, отображаемое имя, фото профиля, описание, предпочтения\n• Данные об использовании: чаты, прогресс связи, используемые функции звонков, базовые данные об устройстве и приложении\n• Покупки: данные чеков магазина, необходимые для открытия и восстановления платных функций\n\n2. Как мы их используем\nМы используем твои данные для работы Veylo, персонализации подбора и общения, обеспечения безопасности сообщества, обработки покупок и улучшения продукта. Мы не продаём твои персональные данные.\n\n3. Анонимный режим\nВ анонимных чатах мы ограничиваем то, что видят другие (например, скрытое имя или размытое фото), пока правила открытия и взаимное согласие не позволят большего. При этом для безопасной работы функции нам по-прежнему нужны идентификаторы аккаунта.\n\n4. Передача данных\nМы можем передавать данные поставщикам услуг, которые помогают нам с хостингом, аналитикой или обработкой платежей, — только в необходимом объёме. Мы также можем раскрыть информацию, если этого требует закон или это нужно для защиты пользователей от вреда.\n\n5. Хранение\nМы храним данные, пока твой аккаунт активен, а также в объёме, необходимом по юридическим причинам, соображениям безопасности и для расчётов. После выполнения запроса на удаление мы удаляем или обезличиваем персональные данные, кроме случаев, когда их хранение обязательно.\n\n6. Твой выбор\nТы можешь изменять данные профиля, настраивать уведомления, запрашивать удаление аккаунта и обращаться к нам по вопросам своих данных. Покупками в магазине также можно управлять через Apple или Google.\n\n7. Безопасность\nМы применяем разумные технические и организационные меры для защиты твоей информации. Ни одна система не защищена идеально, поэтому используй надёжный пароль и обновляй устройство.\n\n8. Контакты\nВопросы о конфиденциальности: privacy@veylo.app';
}

// Path: logout
class _Translations$logout$ru extends Translations$logout$tr {
	_Translations$logout$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Выход';
	@override String get subtitle => 'Точно хочешь выйти?';
	@override String get cancel => 'Отмена';
	@override String get confirm => 'Выйти';
}

// Path: deleteAccount
class _Translations$deleteAccount$ru extends Translations$deleteAccount$tr {
	_Translations$deleteAccount$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Запрос на удаление аккаунта';
	@override String get subtitle => 'Точно хочешь удалить аккаунт?';
	@override String get reasonTitle => 'Нам жаль, что ты уходишь, но мы понимаем.';
	@override String get reasonBefore => 'Расскажи, почему уходишь, — это поможет сделать ';
	@override String get reasonAfter => ' лучше.';
	@override String get reasonLabel => 'Почему хочешь удалить аккаунт?';
	@override String get reasonHint => 'Напиши сообщение';
	@override String get cancel => 'Отмена';
	@override String get createRequest => 'Отправить запрос';
	@override String get confirmTitle => 'Точно отправить запрос на удаление?';
	@override String get confirmSubtitle => 'После подтверждения запрос на удаление аккаунта будет отправлен';
	@override String get delete => 'Удалить';
}

// Path: storyText
class _Translations$storyText$ru extends Translations$storyText$tr {
	_Translations$storyText$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get bold => 'Жирный';
	@override String get italic => 'Курсив';
	@override String get uppercase => 'Заглавные';
	@override String get underline => 'Подчёркнутый';
	@override String get cancel => 'Отмена';
	@override String get galleryError => 'Не удалось открыть галерею';
}

// Path: discover.aiMatch
class _Translations$discover$aiMatch$ru extends Translations$discover$aiMatch$tr {
	_Translations$discover$aiMatch$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get feelingTitle => 'Как ты сегодня?';
	@override String get feelingSubtitle => 'ИИ подберёт лучшую пару по твоему выбору';
	@override String get lookingTitle => 'Что ищешь?';
	@override String get moodSad => 'Грустно';
	@override String get moodMeltie => 'Так себе';
	@override String get moodBored => 'Скучно';
	@override String get moodCrying => 'Подавлен';
	@override String get moodSmile => 'Счастлив';
	@override String get lookingNewFriends => 'Новые друзья';
	@override String get lookingVenting => 'Выговориться';
	@override String get lookingFlirty => 'Флирт';
	@override String get lookingFun => 'Веселье';
	@override String get lookingCultures => 'Новые культуры';
	@override String get lookingLanguage => 'Практика языка';
	@override String get statActiveUsers => 'Активные';
	@override String get statMatchRate => 'Совпадения';
	@override String get statAvgTime => 'Ср. время';
	@override String get statActiveValue => '843';
	@override String get statMatchValue => '87%';
	@override String get statAvgValue => '8 с';
	@override String get startSmartMatch => 'Начать подбор';
	@override String get findingTitle => 'Ищем тебе пару';
	@override String get findingSubtitle => 'Подбираем человека под твоё настроение и интересы';
	@override String get findingStepMood => 'Настроение проанализировано';
	@override String get findingStepInterests => 'Интересы совпали';
	@override String get findingStepCompatibility => 'Считаем совместимость...';
	@override String get findingStepContent => 'Готовим контент...';
	@override String findingOnline({required Object count}) => 'Сейчас в сети: ${count}';
	@override String get yourMatchTitle => 'Твоя пара';
	@override String get yourMatchSubtitle => 'Пара подобрана по твоим ответам';
	@override String vibeMatch({required Object percent}) => 'Совпадение вайба: ${percent}%';
	@override String get startChatting => 'Начать чат';
	@override String matchNameAge({required Object name, required Object age}) => '${name}, ${age}';
	@override String get matchBio => 'Я заставлю тебя чувствовать то, о чём ты и не подозревал(а).';
	@override String get swipePrevious => 'Назад';
	@override String get swipeNext => 'Далее';
	@override String get swipeFinger => 'Проведи пальцем';
	@override String get noMatch => 'Сейчас никто не подходит. Попробуй чуть позже.';
}

// Path: discover.privateRoom
class _Translations$discover$privateRoom$ru extends Translations$discover$privateRoom$tr {
	_Translations$discover$privateRoom$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get subtitle => 'Это закрытая комната. Открой доступ за токены.';
	@override String get roomAccess => 'Доступ в комнату';
	@override String get yourBalance => 'Твой баланс';
	@override String tokensAmount({required Object count}) => 'Токены: ${count}';
	@override String joinForTokens({required Object count}) => 'Войти за ${count} ток.';
	@override String get cancel => 'Отмена';
}

// Path: discover.roomToken
class _Translations$discover$roomToken$ru extends Translations$discover$roomToken$tr {
	_Translations$discover$roomToken$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get subtitle => 'Открой доступ за токены.';
	@override String get roomAccess => 'Доступ в комнату';
	@override String get yourBalance => 'Твой баланс';
	@override String tokensAmount({required Object count}) => 'Токены: ${count}';
	@override String joinForTokens({required Object count}) => 'Войти за ${count} ток.';
	@override String get cancel => 'Отмена';
}

// Path: discover.privateRequest
class _Translations$discover$privateRequest$ru extends Translations$discover$privateRequest$tr {
	_Translations$discover$privateRequest$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Запрос на вход';
	@override String roomInfo({required Object name, required Object count}) => '${name} · участники: ${count}';
	@override String get messageHint => 'Напиши что-нибудь (необязательно)...';
	@override String get sendRequest => 'Отправить запрос';
	@override String get adminReview => 'Админ комнаты рассмотрит твой запрос';
}

// Path: discover.roomApproved
class _Translations$discover$roomApproved$ru extends Translations$discover$roomApproved$tr {
	_Translations$discover$roomApproved$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ты внутри!';
	@override String subtitle({required Object name}) => 'Место в ${name} за тобой';
	@override String get continueLabel => 'Продолжить';
}

// Path: discover.createSpace
class _Translations$discover$createSpace$ru extends Translations$discover$createSpace$tr {
	_Translations$discover$createSpace$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Создать комнату или группу';
	@override String get subtitle => 'Создай группу или живую комнату и найди больше людей';
	@override String get room => 'Комната';
	@override String get group => 'Группа';
	@override String get hideAccount => 'Скрыть аккаунт';
	@override String get create => 'Создать';
	@override String get cancel => 'Отмена';
	@override String get createRoomTitle => 'Создать комнату';
	@override String get createGroupTitle => 'Создать группу';
	@override String get nameSubtitle => 'Придумай название для группы';
	@override String get nameHint => 'Ночные совы';
	@override String createRoomFor({required Object count}) => 'Создать за ${count} ток.';
}

// Path: discover.liveRoom
class _Translations$discover$liveRoom$ru extends Translations$discover$liveRoom$tr {
	_Translations$discover$liveRoom$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get adminSuffix => '(Админ)';
	@override String get messageHint => 'Сообщение';
	@override String get quickReplyHey => 'Всем привет!';
	@override String get quickReplyTopic => 'Какая тема?';
	@override String get quickReplyNew => 'Я тут новенький!';
	@override String get sampleChatName => 'Sona';
	@override String get sampleChatBody => 'Чем займёмся? Есть идеи?';
	@override String get roomEnded => 'Комната завершена.';
	@override String wantsToJoin({required Object name}) => '${name} хочет войти';
	@override String get approve => 'Принять';
}

// Path: discover.groupChat
class _Translations$discover$groupChat$ru extends Translations$discover$groupChat$tr {
	_Translations$discover$groupChat$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String usersCount({required Object count}) => 'Участники: ${count}';
	@override String get sampleVictoria => 'Мне ужасно скучно. Может, чем-нибудь займёмся?';
	@override String get sampleSona => 'Чем займёмся? Есть идеи?';
	@override String get sampleOwn => 'Давайте встретимся на пирсе';
}

// Path: discover.groupInfo
class _Translations$discover$groupInfo$ru extends Translations$discover$groupInfo$tr {
	_Translations$discover$groupInfo$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get media => 'Медиа';
	@override String get gallery => 'Галерея';
	@override String get settings => 'Настройки';
	@override String get notifications => 'Уведомления';
	@override String get blocked => 'Заблокированные';
	@override String get private => 'Закрытая';
	@override String membersCount({required Object count}) => 'Участники: ${count}';
	@override String get addPeople => 'Добавить людей';
	@override String get you => 'Ты';
	@override String get admin => 'Админ';
	@override String get leaveGroup => 'Покинуть группу';
	@override String get requests => 'Запросы на вход';
	@override String get approve => 'Принять';
	@override String get reject => 'Отклонить';
	@override String get addPeopleEmpty => 'Подпишись на людей, чтобы добавить их в группу.';
	@override String get add => 'Добавить';
	@override String get makeAdmin => 'Сделать админом';
	@override String get removeAdmin => 'Снять админа';
	@override String get remove => 'Удалить из группы';
	@override String get leaveConfirm => 'Покинуть группу?';
	@override String get leave => 'Покинуть';
	@override String get cancel => 'Отмена';
}

// Path: discover.filters
class _Translations$discover$filters$ru extends Translations$discover$filters$tr {
	_Translations$discover$filters$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Фильтры';
	@override String get ageRange => 'Возраст';
	@override String ageRangeValue({required Object min, required Object max}) => '${min}-${max}';
	@override String get distance => 'Расстояние';
	@override String distanceValue({required Object km}) => '${km} км';
	@override String get showMe => 'Показывать';
	@override String get everyone => 'Всех';
	@override String get women => 'Женщин';
	@override String get men => 'Мужчин';
	@override String get interests => 'Интересы';
	@override String get activeNow => 'Сейчас в сети';
	@override String get activeNowSubtitle => 'Показывать только тех, кто в сети';
	@override String get showResult => 'Показать';
}

// Path: discover.post
class _Translations$discover$post$ru extends Translations$discover$post$tr {
	_Translations$discover$post$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get follow => 'Подписаться';
	@override String get following => 'Подписки';
	@override String get addComment => 'Комментарий...';
	@override String get commentsTitle => 'Комментарии';
	@override String get sampleCaption => 'Нет ничего лучше чашки кофе после прекрасного дня. <3';
	@override String hoursAgo({required Object hours}) => '${hours} ч';
	@override String minutesAgo({required Object minutes}) => '${minutes} мин';
	@override String daysAgo({required Object days}) => '${days} д';
	@override String get deleteCommentTitle => 'Удалить комментарий?';
}

// Path: discover.story
class _Translations$discover$story$ru extends Translations$discover$story$tr {
	_Translations$discover$story$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get draft => 'ЧЕРНОВИК';
	@override String get story => 'ИСТОРИЯ';
	@override String get share => 'Опубликовать';
	@override String get textPlaceholder => 'Напиши что-нибудь...';
	@override String get draftPrompt => 'Сохранить черновик?';
	@override String get saveToDraft => 'В черновики';
	@override String get moveToTrash => 'В корзину';
	@override String get save => 'Сохранить';
	@override String get musicTitle => 'Музыка';
	@override String get musicEmpty => 'Музыка не найдена.';
	@override String get musicError => 'Не удалось загрузить музыку.';
	@override String get downloaded => 'Сохранено в галерею';
	@override String get downloadFailed => 'Не удалось сохранить';
}

// Path: discover.highlight
class _Translations$discover$highlight$ru extends Translations$discover$highlight$tr {
	_Translations$discover$highlight$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Актуальное';
	@override String get view => 'Смотреть';
	@override String get aiComments => 'Комментарии ИИ';
	@override String get remove => 'Убрать из актуального';
	@override String get sharedSuccess => 'Пост опубликован';
	@override String get boost => 'Продвинуть';
}

// Path: discover.stats
class _Translations$discover$stats$ru extends Translations$discover$stats$tr {
	_Translations$discover$stats$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Статистика';
	@override String get subtitle => 'Статистика твоего поста\nниже.';
	@override String get viewers => 'Просмотры';
	@override String get comments => 'Комментарии';
	@override String get likes => 'Лайки';
	@override String get boostCta => 'Продвинуть на 1 день — 100 токенов';
	@override String get boosted => 'Готово! Пост в топе на 24 часа.';
}

// Path: createProfile.interests
class _Translations$createProfile$interests$ru extends Translations$createProfile$interests$tr {
	_Translations$createProfile$interests$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get music => 'Музыка';
	@override String get movies => 'Кино';
	@override String get tvShows => 'Сериалы';
	@override String get reading => 'Чтение';
	@override String get painting => 'Живопись';
	@override String get photography => 'Фотография';
	@override String get theatre => 'Театр';
	@override String get fitness => 'Фитнес';
	@override String get swimming => 'Плавание';
	@override String get football => 'Футбол';
	@override String get basketball => 'Баскетбол';
	@override String get coffee => 'Кофе';
	@override String get travel => 'Путешествия';
	@override String get camping => 'Кемпинг';
	@override String get meditation => 'Медитация';
	@override String get videoGames => 'Видеоигры';
	@override String get boardGames => 'Настолки';
	@override String get standUp => 'Стендап';
	@override String get tech => 'Технологии';
	@override String get coding => 'Программирование';
	@override String get ai => 'ИИ';
	@override String get podcast => 'Подкасты';
}

/// The flat map containing all translations for locale <ru>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsRu {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.name' => 'Veylo',
			'app.tagline' => 'Добро пожаловать',
			'home.title' => 'Главная',
			'home.subtitle' => 'Приложение готовится',
			'home.body' => 'Многоязычный интерфейс работает на slang.',
			'chats.title' => 'Чаты',
			'chats.search' => 'Поиск',
			'chats.messagesSection' => 'Сообщения',
			'chats.request' => 'Запросы',
			'chats.emptyRequestTitle' => 'Новых запросов\nна переписку нет',
			'chats.emptyRequestSubtitle' => 'Запросы старше 30 дней не показываются.',
			'chats.noteAdd' => 'Заметка',
			'chats.anonymous' => 'Аноним',
			'chats.online' => 'в сети',
			'chats.offline' => 'не в сети',
			'chats.connection' => 'Связь',
			'chats.connectionPercent' => ({required Object n}) => '${n}%',
			'chats.connectionProgressTitle' => 'Прогресс связи',
			'chats.milestoneInitial' => 'Первая буква имени',
			'chats.milestoneInitialHint' => 'Открыто на 25%',
			'chats.milestoneInitialLocked' => 'Откроется на 25%',
			'chats.milestonePhoto' => 'Размытое фото',
			'chats.milestonePhotoHint' => 'Откроется на 70%',
			'chats.milestoneFull' => 'Полный профиль',
			'chats.milestoneFullHint' => 'По взаимному согласию на 100%',
			'chats.sampleAnonymousMessage' => 'Привет, рад(а) знакомству! Расскажешь немного о себе?',
			'chats.strangerSampleMessage' => 'Привет, Jhon, рад(а) знакомству! Расскажешь немного о себе?',
			'chats.approve' => 'Принять',
			'chats.blockUser' => 'Заблокировать',
			'chats.reject' => 'Отклонить',
			'chats.messageHint' => 'Привет! Как дела?',
			'chats.revealTitle' => 'Вы достигли 100%',
			'chats.revealSubtitle' => 'Открыть друг другу полные профили? Нужно согласие обоих.',
			'chats.revealWaiting' => ({required Object name}) => 'Ждём согласия ${name}',
			'chats.revealCta' => 'Раскрыть мой профиль',
			'chats.revealNotYet' => 'Пока нет',
			'chats.seen' => 'Просмотрено',
			'chats.typing' => 'печатает…',
			'chats.noteYou' => 'Ты',
			'chats.noteSheetTitle' => 'Поделиться заметкой',
			'chats.noteSheetSubtitle' => 'Заметка видна 24 часа',
			'chats.noteHint' => 'О чём думаешь?',
			'chats.noteShare' => 'Поделиться',
			'chats.noteDelete' => 'Удалить заметку',
			'profile.eyebrow' => 'Профиль',
			'profile.title' => 'Настройки',
			'profile.editProfile' => 'Изменить профиль',
			'profile.statLike' => 'Лайки',
			'profile.statFollow' => 'Подписки',
			'profile.statFollower' => 'Подписчики',
			'profile.promoTitle' => 'Больше сообщений!',
			'profile.promoSubtitle' => 'Выделись и будь в начале списка',
			'profile.standOut' => 'Выделиться',
			'profile.tabPosts' => 'Посты',
			'profile.tabVideo' => 'Видео',
			'profile.tabSaved' => 'Сохранённое',
			'profile.save' => 'Сохранить',
			'profile.changePhoto' => 'Сменить фото',
			'profile.changeBorder' => 'Сменить рамку',
			'profile.interest' => 'Интересы',
			'profile.name' => 'Имя',
			'profile.changeName' => 'Сменить имя',
			'profile.changePassword' => 'Сменить пароль',
			'profile.confirmPassword' => 'Повтори пароль',
			'profile.email' => 'Эл. почта',
			'profile.accountManagement' => 'Управление аккаунтом',
			'profile.settingsAbout' => 'О приложении',
			'profile.settingsAccount' => 'Настройки аккаунта',
			'profile.settingsSupport' => 'Поддержка',
			'profile.shareApp' => 'Поделиться приложением',
			'profile.shareAppTitle' => 'Поделись с друзьями',
			'profile.shareAppSubtitle' => 'Поделись Veylo с друзьями и открывайте новое вместе!',
			'profile.shareAppLabel' => 'Ссылка на приложение',
			'profile.rateApp' => 'Нравится? Оцени нас',
			'profile.notifications' => 'Уведомления',
			'profile.password' => 'Пароль',
			'profile.deleteConversation' => 'Удалить чаты',
			'profile.faqHelp' => 'FAQ и помощь',
			'profile.restorePurchases' => 'Восстановить покупки',
			'profile.termsOfService' => 'Условия использования',
			'profile.privacyPolicy' => 'Политика конфиденциальности',
			'profile.restorePurchasesDone' => 'Покупки проверены',
			'profile.conversationsDeleted' => 'Все чаты удалены',
			'profile.logOut' => 'Выйти',
			'profile.deleteAccountAndData' => 'Удалить аккаунт и данные',
			'profile.passwordPlaceholder' => '********',
			'profile.height' => 'Рост',
			'profile.addHeight' => 'Указать рост',
			'profile.heightCm' => ({required Object value}) => '${value} см',
			'profile.languages' => 'Языки',
			'profile.relationshipGoals' => 'Цели отношений',
			'profile.lookingFor' => 'Ищу',
			'profile.newFriends' => '👋 Новых друзей',
			'profile.goalLongTermOpenToShort' => '💕 Долгие, но открыт(а) к коротким',
			'profile.goalLongTermRelationship' => '💘 Долгие отношения',
			'profile.goalNewFriends' => '👋 Новые друзья',
			'profile.goalShortTermFun' => '🥃 Что-то несерьёзное',
			'profile.goalStillFiguringItOut' => '🤔 Пока не определился(ась)',
			'profile.basics' => 'Основное',
			'profile.zodiac' => 'Знак зодиака',
			'profile.zodiacValue' => 'Скорпион',
			'profile.education' => 'Образование',
			'profile.educationValue' => 'Бакалавр',
			'profile.educationHighSchool' => 'Среднее',
			'profile.educationAssociates' => 'Среднее специальное',
			'profile.educationBachelors' => 'Бакалавриат',
			'profile.educationMasters' => 'Магистратура',
			'profile.educationPhd' => 'Кандидат / доктор наук',
			'profile.voiceRecord' => 'Голосовая запись',
			'profile.addVoice' => 'Добавить голос',
			'profile.lifestyle' => 'Образ жизни',
			'profile.pets' => 'Питомцы',
			'profile.petsValue' => 'Есть кошка',
			'profile.petsDontWant' => 'Не хочу питомцев',
			'profile.petsAllergic' => 'Аллергия на животных',
			'profile.petsHaveCat' => 'Есть кошка',
			'profile.petsHaveDog' => 'Есть собака',
			'profile.petsHaveCatsAndDogs' => 'Есть кошки и собаки',
			'profile.petsHaveOther' => 'Есть другие питомцы',
			'profile.drinking' => 'Алкоголь',
			'profile.drinkingValue' => 'По особым случаям',
			'profile.drinkingNever' => 'Никогда',
			'profile.drinkingSpecialOccasions' => 'По особым случаям',
			'profile.drinkingSocially' => 'В компании',
			'profile.drinkingFrequently' => 'Часто',
			'profile.drinkingSober' => 'Не пью',
			'profile.drinkingPreferNotToSay' => 'Не скажу',
			'profile.smoking' => 'Курение',
			'profile.smokingValue' => 'Не курю',
			'profile.smokingNonSmoker' => 'Не курю',
			'profile.smokingSocialSmoker' => 'Курю в компании',
			'profile.smokingSmoker' => 'Курю',
			'profile.smokingTryingToQuit' => 'Пытаюсь бросить',
			'profile.smokingWhenDrinking' => 'Курю, когда выпиваю',
			'profile.smokingPreferNotToSay' => 'Не скажу',
			'profile.gender' => 'Пол',
			'profile.genderFemale' => 'Женский',
			'profile.genderMale' => 'Мужской',
			'profile.genderPreferNotToSay' => 'Не хочу указывать',
			'profile.visible' => 'Виден',
			'profile.profileVisibility' => 'Видимость профиля',
			'profile.language' => 'Язык',
			'profile.borderTitle' => 'Рамка профиля',
			'profile.borderSubtitle' => 'Добавь рамку к профилю,\nчтобы выделиться.',
			'profile.borderBuySection' => 'Купить рамку',
			'profile.borderBuyCta' => 'Купить рамку',
			'profile.borderToken' => ({required Object count}) => 'Токены: ${count}',
			'profile.borderAmethystWings' => 'Amethyst Wings',
			'profile.borderGoldenPhoenix' => 'Golden Phoenix',
			'profile.borderFrostCrown' => 'Frost Crown',
			'profile.borderEmeraldWhisper' => 'Emerald Whisper',
			'profile.borderRoseQuartz' => 'Rose Quartz',
			'profile.borderStarlitComet' => 'Starlit Comet',
			'profile.borderCrimsonRoyal' => 'Crimson Royal',
			'profile.borderSapphireHalo' => 'Sapphire Halo',
			'profile.follow' => 'Подписаться',
			'profile.following' => 'Подписки',
			'profile.followPageTitle' => 'Подписки',
			'profile.followTabFollowing' => 'Подписки',
			'profile.followTabFollowers' => 'Подписчики',
			'profile.followSearch' => 'Поиск',
			'profile.unfollow' => 'Отписаться',
			'profile.followSortTitle' => 'Сортировка',
			'profile.followSortRecent' => 'Недавние подписки',
			'profile.followSortNotFollowingMe' => 'Не подписаны на меня в ответ',
			'profile.followSortNotFollowedByMe' => 'Я не подписан(а) в ответ',
			'profile.followSortShowResult' => 'Показать',
			'profile.followSortEmpty' => 'Под этот фильтр никто не подходит',
			'profile.shareTitle' => 'Поделись с друзьями',
			'profile.shareSubtitle' => 'С друзьями всё\nвеселее!',
			'profile.shareProfileLabel' => 'Поделиться профилем',
			'profile.shareLinkCopied' => 'Ссылка скопирована',
			'profile.restrict' => 'Ограничить',
			'profile.block' => 'Заблокировать',
			'profile.report' => 'Пожаловаться',
			'profile.blockTitle' => ({required Object username}) => 'Заблокировать ${username}?',
			'profile.blockBody' => 'Также будут заблокированы другие их аккаунты, включая будущие. Разблокировать можно в любой момент.',
			'profile.blockAndReport' => 'Заблокировать и пожаловаться',
			'profile.restrictTitle' => ({required Object username}) => 'Ограничить ${username}?',
			'profile.restrictBody' => 'Они не увидят, когда ты в сети и прочитал(а) ли ты их сообщения. Это можно изменить в любой момент.',
			'profile.restrictAndReport' => 'Ограничить и пожаловаться',
			'profile.reportTitle' => 'Расскажи, что случилось',
			'profile.reportSubtitle' => 'Чтобы мы стали лучше, расскажи, почему хочешь пожаловаться на этого пользователя?',
			'profile.reportMessageLabel' => 'Текст жалобы',
			'profile.reportMessageHint' => 'Напиши сообщение',
			'profile.reportCancel' => 'Отмена',
			'profile.sendReport' => 'Отправить',
			'profile.notSet' => 'Не указано',
			'profile.reportSent' => 'Спасибо, жалоба получена.',
			'profile.emailVerificationSent' => ({required Object email}) => 'Мы отправили ссылку для подтверждения на ${email}. Почта изменится после подтверждения.',
			'profile.passwordChanged' => 'Пароль обновлён.',
			'profile.passwordMismatch' => 'Пароли не совпадают.',
			'nav.discover' => 'Обзор',
			'nav.chat' => 'Чат',
			'nav.call' => 'Звонок',
			'nav.vibes' => 'Vibes',
			'nav.profile' => 'Профиль',
			'call.title' => 'Незнакомец на 60 секунд',
			'call.subtitle' => 'Поговори 60 секунд со случайным незнакомцем — полностью анонимно. Без профиля, фото и имени. Только голос и момент.',
			'call.findingTitle' => 'Ищем собеседника...',
			'call.findingSubtitle' => 'Вы поговорите анонимно 60 секунд. Без профилей и имён.',
			'call.callStranger' => 'Позвонить — 10 токенов',
			'call.cancel' => 'Отмена',
			'call.female' => 'Женщина',
			'call.male' => 'Мужчина',
			'call.nonBinary' => 'Небинарный',
			'call.preferNotToSay' => 'Не скажу',
			'call.anonymousBadge' => '🎙️ Анонимный звонок',
			'call.stranger' => 'Незнакомец',
			'call.secondsLeft' => ({required Object n}) => '${n} с',
			'call.timesUpTitle' => 'Время вышло!',
			'call.timesUpSubtitle' => 'Хотите продолжить? Если оба согласны, откроется чат.',
			'call.keepTalking' => 'Продолжить',
			'call.endCall' => 'Завершить',
			'call.waitingOther' => 'Ждём собеседника...',
			'call.callStrangerFree' => 'Позвонить',
			'call.peerLeft' => 'Собеседник завершил звонок.',
			'call.noKeep' => 'В этот раз чат не открылся.',
			'call.videoWaiting' => 'Ждём, когда примут видеозвонок...',
			'call.videoDeclined' => 'Видеозвонок отклонён.',
			'call.micDenied' => 'Для звонков нужен доступ к микрофону. Включи его в настройках.',
			'call.videoCost' => 'Видеозвонок: 20 токенов / 15 мин',
			'call.calling' => 'Вызов',
			'call.accept' => 'Принять',
			'call.decline' => 'Отклонить',
			'call.switchToVideo' => 'Перейти на видеозвонок?',
			'call.noMatchTitle' => 'Сейчас никого нет',
			'call.noMatchBody' => 'Сейчас не удалось найти собеседника. Попробуй ещё раз чуть позже.',
			'call.noMatchOk' => 'ОК',
			'vibes.search' => 'Поиск',
			'vibes.sendMessage' => 'Написать',
			'vibes.wantsToTalk' => 'Хочет обсудить это прямо сейчас',
			'vibes.shareTitle' => 'Поделиться Vibe',
			'vibes.replyTitle' => 'Ответить на Vibe',
			'vibes.shareHint' => 'Напиши что-нибудь',
			'vibes.shareAnonymous' => 'Анонимно',
			'vibes.empty' => 'За 24 часа Vibes нет. Поделись первым!',
			'vibes.deleteTitle' => 'Удалить этот Vibe?',
			'vibes.delete' => 'Удалить',
			'vibes.cancel' => 'Отмена',
			'discover.title' => 'Обзор',
			'discover.tabRooms' => 'Комнаты',
			'discover.tabDiscover' => 'Обзор',
			'discover.tabAiMatch' => 'AI Match',
			'discover.aiMatch.feelingTitle' => 'Как ты сегодня?',
			'discover.aiMatch.feelingSubtitle' => 'ИИ подберёт лучшую пару по твоему выбору',
			'discover.aiMatch.lookingTitle' => 'Что ищешь?',
			'discover.aiMatch.moodSad' => 'Грустно',
			'discover.aiMatch.moodMeltie' => 'Так себе',
			'discover.aiMatch.moodBored' => 'Скучно',
			'discover.aiMatch.moodCrying' => 'Подавлен',
			'discover.aiMatch.moodSmile' => 'Счастлив',
			'discover.aiMatch.lookingNewFriends' => 'Новые друзья',
			'discover.aiMatch.lookingVenting' => 'Выговориться',
			'discover.aiMatch.lookingFlirty' => 'Флирт',
			'discover.aiMatch.lookingFun' => 'Веселье',
			'discover.aiMatch.lookingCultures' => 'Новые культуры',
			'discover.aiMatch.lookingLanguage' => 'Практика языка',
			'discover.aiMatch.statActiveUsers' => 'Активные',
			'discover.aiMatch.statMatchRate' => 'Совпадения',
			'discover.aiMatch.statAvgTime' => 'Ср. время',
			'discover.aiMatch.statActiveValue' => '843',
			'discover.aiMatch.statMatchValue' => '87%',
			'discover.aiMatch.statAvgValue' => '8 с',
			'discover.aiMatch.startSmartMatch' => 'Начать подбор',
			'discover.aiMatch.findingTitle' => 'Ищем тебе пару',
			'discover.aiMatch.findingSubtitle' => 'Подбираем человека под твоё настроение и интересы',
			'discover.aiMatch.findingStepMood' => 'Настроение проанализировано',
			'discover.aiMatch.findingStepInterests' => 'Интересы совпали',
			'discover.aiMatch.findingStepCompatibility' => 'Считаем совместимость...',
			'discover.aiMatch.findingStepContent' => 'Готовим контент...',
			'discover.aiMatch.findingOnline' => ({required Object count}) => 'Сейчас в сети: ${count}',
			'discover.aiMatch.yourMatchTitle' => 'Твоя пара',
			'discover.aiMatch.yourMatchSubtitle' => 'Пара подобрана по твоим ответам',
			'discover.aiMatch.vibeMatch' => ({required Object percent}) => 'Совпадение вайба: ${percent}%',
			'discover.aiMatch.startChatting' => 'Начать чат',
			'discover.aiMatch.matchNameAge' => ({required Object name, required Object age}) => '${name}, ${age}',
			'discover.aiMatch.matchBio' => 'Я заставлю тебя чувствовать то, о чём ты и не подозревал(а).',
			'discover.aiMatch.swipePrevious' => 'Назад',
			'discover.aiMatch.swipeNext' => 'Далее',
			'discover.aiMatch.swipeFinger' => 'Проведи пальцем',
			'discover.aiMatch.noMatch' => 'Сейчас никто не подходит. Попробуй чуть позже.',
			'discover.searchHint' => 'Поиск',
			'discover.allRooms' => 'Все комнаты',
			'discover.allGroups' => 'Все группы',
			'discover.seeAll' => 'Все',
			'discover.live' => 'Эфир',
			'discover.join' => 'Войти',
			'discover.request' => 'Запросить',
			'discover.requested' => 'Запрошено',
			'discover.private' => 'Закрытая',
			'discover.moreCount' => ({required Object count}) => '+${count}',
			'discover.activeCount' => ({required Object count}) => 'Активны: ${count}',
			'discover.membersCount' => ({required Object count}) => 'Участники: ${count}',
			'discover.privateRoom.subtitle' => 'Это закрытая комната. Открой доступ за токены.',
			'discover.privateRoom.roomAccess' => 'Доступ в комнату',
			'discover.privateRoom.yourBalance' => 'Твой баланс',
			'discover.privateRoom.tokensAmount' => ({required Object count}) => 'Токены: ${count}',
			'discover.privateRoom.joinForTokens' => ({required Object count}) => 'Войти за ${count} ток.',
			'discover.privateRoom.cancel' => 'Отмена',
			'discover.roomToken.subtitle' => 'Открой доступ за токены.',
			'discover.roomToken.roomAccess' => 'Доступ в комнату',
			'discover.roomToken.yourBalance' => 'Твой баланс',
			'discover.roomToken.tokensAmount' => ({required Object count}) => 'Токены: ${count}',
			'discover.roomToken.joinForTokens' => ({required Object count}) => 'Войти за ${count} ток.',
			'discover.roomToken.cancel' => 'Отмена',
			'discover.privateRequest.title' => 'Запрос на вход',
			'discover.privateRequest.roomInfo' => ({required Object name, required Object count}) => '${name} · участники: ${count}',
			'discover.privateRequest.messageHint' => 'Напиши что-нибудь (необязательно)...',
			'discover.privateRequest.sendRequest' => 'Отправить запрос',
			'discover.privateRequest.adminReview' => 'Админ комнаты рассмотрит твой запрос',
			'discover.roomApproved.title' => 'Ты внутри!',
			'discover.roomApproved.subtitle' => ({required Object name}) => 'Место в ${name} за тобой',
			'discover.roomApproved.continueLabel' => 'Продолжить',
			'discover.createSpace.title' => 'Создать комнату или группу',
			'discover.createSpace.subtitle' => 'Создай группу или живую комнату и найди больше людей',
			'discover.createSpace.room' => 'Комната',
			'discover.createSpace.group' => 'Группа',
			'discover.createSpace.hideAccount' => 'Скрыть аккаунт',
			'discover.createSpace.create' => 'Создать',
			'discover.createSpace.cancel' => 'Отмена',
			'discover.createSpace.createRoomTitle' => 'Создать комнату',
			'discover.createSpace.createGroupTitle' => 'Создать группу',
			'discover.createSpace.nameSubtitle' => 'Придумай название для группы',
			'discover.createSpace.nameHint' => 'Ночные совы',
			'discover.createSpace.createRoomFor' => ({required Object count}) => 'Создать за ${count} ток.',
			'discover.liveRoom.adminSuffix' => '(Админ)',
			'discover.liveRoom.messageHint' => 'Сообщение',
			'discover.liveRoom.quickReplyHey' => 'Всем привет!',
			'discover.liveRoom.quickReplyTopic' => 'Какая тема?',
			'discover.liveRoom.quickReplyNew' => 'Я тут новенький!',
			'discover.liveRoom.sampleChatName' => 'Sona',
			'discover.liveRoom.sampleChatBody' => 'Чем займёмся? Есть идеи?',
			'discover.liveRoom.roomEnded' => 'Комната завершена.',
			'discover.liveRoom.wantsToJoin' => ({required Object name}) => '${name} хочет войти',
			'discover.liveRoom.approve' => 'Принять',
			'discover.groupChat.usersCount' => ({required Object count}) => 'Участники: ${count}',
			'discover.groupChat.sampleVictoria' => 'Мне ужасно скучно. Может, чем-нибудь займёмся?',
			'discover.groupChat.sampleSona' => 'Чем займёмся? Есть идеи?',
			'discover.groupChat.sampleOwn' => 'Давайте встретимся на пирсе',
			'discover.groupInfo.media' => 'Медиа',
			'discover.groupInfo.gallery' => 'Галерея',
			'discover.groupInfo.settings' => 'Настройки',
			'discover.groupInfo.notifications' => 'Уведомления',
			'discover.groupInfo.blocked' => 'Заблокированные',
			'discover.groupInfo.private' => 'Закрытая',
			'discover.groupInfo.membersCount' => ({required Object count}) => 'Участники: ${count}',
			'discover.groupInfo.addPeople' => 'Добавить людей',
			'discover.groupInfo.you' => 'Ты',
			'discover.groupInfo.admin' => 'Админ',
			'discover.groupInfo.leaveGroup' => 'Покинуть группу',
			'discover.groupInfo.requests' => 'Запросы на вход',
			'discover.groupInfo.approve' => 'Принять',
			'discover.groupInfo.reject' => 'Отклонить',
			'discover.groupInfo.addPeopleEmpty' => 'Подпишись на людей, чтобы добавить их в группу.',
			'discover.groupInfo.add' => 'Добавить',
			'discover.groupInfo.makeAdmin' => 'Сделать админом',
			'discover.groupInfo.removeAdmin' => 'Снять админа',
			'discover.groupInfo.remove' => 'Удалить из группы',
			'discover.groupInfo.leaveConfirm' => 'Покинуть группу?',
			'discover.groupInfo.leave' => 'Покинуть',
			'discover.groupInfo.cancel' => 'Отмена',
			'discover.filters.title' => 'Фильтры',
			'discover.filters.ageRange' => 'Возраст',
			'discover.filters.ageRangeValue' => ({required Object min, required Object max}) => '${min}-${max}',
			'discover.filters.distance' => 'Расстояние',
			'discover.filters.distanceValue' => ({required Object km}) => '${km} км',
			'discover.filters.showMe' => 'Показывать',
			'discover.filters.everyone' => 'Всех',
			'discover.filters.women' => 'Женщин',
			'discover.filters.men' => 'Мужчин',
			'discover.filters.interests' => 'Интересы',
			'discover.filters.activeNow' => 'Сейчас в сети',
			'discover.filters.activeNowSubtitle' => 'Показывать только тех, кто в сети',
			'discover.filters.showResult' => 'Показать',
			'discover.post.follow' => 'Подписаться',
			'discover.post.following' => 'Подписки',
			'discover.post.addComment' => 'Комментарий...',
			'discover.post.commentsTitle' => 'Комментарии',
			'discover.post.sampleCaption' => 'Нет ничего лучше чашки кофе после прекрасного дня. <3',
			'discover.post.hoursAgo' => ({required Object hours}) => '${hours} ч',
			'discover.post.minutesAgo' => ({required Object minutes}) => '${minutes} мин',
			'discover.post.daysAgo' => ({required Object days}) => '${days} д',
			'discover.post.deleteCommentTitle' => 'Удалить комментарий?',
			'discover.story.draft' => 'ЧЕРНОВИК',
			'discover.story.story' => 'ИСТОРИЯ',
			'discover.story.share' => 'Опубликовать',
			'discover.story.textPlaceholder' => 'Напиши что-нибудь...',
			'discover.story.draftPrompt' => 'Сохранить черновик?',
			'discover.story.saveToDraft' => 'В черновики',
			'discover.story.moveToTrash' => 'В корзину',
			'discover.story.save' => 'Сохранить',
			'discover.story.musicTitle' => 'Музыка',
			'discover.story.musicEmpty' => 'Музыка не найдена.',
			'discover.story.musicError' => 'Не удалось загрузить музыку.',
			'discover.story.downloaded' => 'Сохранено в галерею',
			'discover.story.downloadFailed' => 'Не удалось сохранить',
			'discover.highlight.title' => 'Актуальное',
			'discover.highlight.view' => 'Смотреть',
			'discover.highlight.aiComments' => 'Комментарии ИИ',
			'discover.highlight.remove' => 'Убрать из актуального',
			'discover.highlight.sharedSuccess' => 'Пост опубликован',
			'discover.highlight.boost' => 'Продвинуть',
			'discover.stats.title' => 'Статистика',
			'discover.stats.subtitle' => 'Статистика твоего поста\nниже.',
			'discover.stats.viewers' => 'Просмотры',
			'discover.stats.comments' => 'Комментарии',
			'discover.stats.likes' => 'Лайки',
			'discover.stats.boostCta' => 'Продвинуть на 1 день — 100 токенов',
			'discover.stats.boosted' => 'Готово! Пост в топе на 24 часа.',
			'discover.hostedBy' => ({required Object name}) => 'Ведущий: ${name}',
			'common.loading' => 'Загрузка…',
			'common.retry' => 'Повторить',
			'common.cancel' => 'Отмена',
			'common.save' => 'Сохранить',
			'common.continueAction' => 'Продолжить',
			'common.language' => 'Язык',
			'common.or' => 'ИЛИ',
			'languages.tr' => 'Türkçe',
			'languages.en' => 'English',
			'auth.createAccountTitle' => 'Создай аккаунт',
			'auth.createAccountSubtitle' => 'Присоединяйся к Veylo и знакомься.',
			'auth.welcomeBackTitle' => 'С возвращением',
			'auth.welcomeBackSubtitle' => 'Войди, чтобы продолжить в Veylo.',
			'auth.username' => 'Имя пользователя',
			'auth.usernameHint' => 'Придумай имя пользователя',
			'auth.email' => 'Эл. почта',
			'auth.emailHint' => 'Введи эл. почту',
			'auth.emailOrUsername' => 'Почта или имя пользователя',
			'auth.emailOrUsernameHint' => 'Почта или имя пользователя',
			'auth.password' => 'Пароль',
			'auth.passwordCreateHint' => 'Придумай пароль',
			'auth.passwordEnterHint' => 'Введи пароль',
			'auth.signUp' => 'Регистрация',
			'auth.logIn' => 'Войти',
			'auth.forgotPassword' => 'Забыли пароль?',
			'auth.continueWithApple' => 'Продолжить с Apple',
			'auth.continueWithGoogle' => 'Продолжить с Google',
			'auth.legalPrefix' => 'Продолжая, ты принимаешь ',
			'auth.termsOfService' => 'Условия использования',
			'auth.legalMiddle' => ' и подтверждаешь, что ознакомлен(а) с ',
			'auth.privacyPolicy' => 'Политикой конфиденциальности',
			'auth.legalSuffix' => '.',
			'auth.passwordResetSent' => 'Мы отправили ссылку для сброса пароля на твою почту.',
			'onboarding.skip' => 'Пропустить',
			'onboarding.page1Title' => 'Будь собой. Оставайся анонимным.',
			'onboarding.page1Subtitle' => 'Знакомься и общайся,\nне раскрывая, кто ты.',
			'onboarding.page2Title' => 'Пиши. Говори. Лови вайб.',
			'onboarding.page2Subtitle' => 'Начни анонимно, а когда будешь готов(а) — переписка, звонок или встреча.',
			'onboarding.page3Title' => 'Найди своих. Присоединяйся\nк разговору.',
			'onboarding.page3Subtitle' => 'Заходи в комнаты, знакомься и\nпроживай моменты вместе.',
			'onboarding.getStarted' => 'Начать',
			'onboarding.alreadyHaveAccount' => 'Уже есть аккаунт Veylo? ',
			'onboarding.logInAction' => 'Войти',
			'createProfile.navTitle' => 'Создание профиля',
			'createProfile.stepUsername' => '1/5 Имя пользователя',
			'createProfile.title' => 'Создай профиль',
			'createProfile.subtitle' => 'Настоящее имя нужно только для проверки — его никто не увидит.',
			'createProfile.subtitleLine1' => 'Настоящее имя нужно только для проверки —',
			'createProfile.subtitleLine2' => 'его никто не увидит.',
			'createProfile.fullName' => 'Полное имя',
			'createProfile.fullNameHint' => 'Sam Lee',
			'createProfile.username' => 'Имя пользователя',
			'createProfile.usernameHint' => 'samlee123',
			'createProfile.usernameTaken' => 'Это имя уже занято!',
			'createProfile.usernameAvailable' => 'Имя свободно',
			'createProfile.mightWantToTry' => 'Попробуй...',
			'createProfile.stepPhoto' => '2/5 Фото профиля',
			'createProfile.photoTitle' => 'Загрузи фото профиля',
			'createProfile.photoSubtitle' => 'Другие увидят твоё фото и убедятся, что это ты.',
			'createProfile.photoSubtitleLine1' => 'Другие увидят твоё фото и убедятся,',
			'createProfile.photoSubtitleLine2' => 'что это ты.',
			'createProfile.choosePhoto' => 'Выбрать фото',
			'createProfile.continueWithoutPhoto' => 'Продолжить без фото',
			'createProfile.saveAndContinue' => 'Сохранить и продолжить',
			'createProfile.choosePhotoSheetTitle' => 'Выбери фото',
			'createProfile.takePhoto' => 'Сделать фото',
			'createProfile.chooseFromGallery' => 'Выбрать из галереи',
			'createProfile.stepGender' => '3/5 Пол',
			'createProfile.genderTitle' => 'Укажи пол',
			'createProfile.genderSubtitle' => 'Если ты укажешь эти данные, мы сможем подбирать контент под тебя',
			'createProfile.genderSubtitleLine1' => 'Если ты укажешь эти данные, мы сможем',
			'createProfile.genderSubtitleLine2' => 'подбирать контент под тебя',
			'createProfile.genderFemale' => 'Женский',
			'createProfile.genderMale' => 'Мужской',
			'createProfile.genderNonBinary' => 'Небинарный',
			'createProfile.genderPreferNotToSay' => 'Не скажу',
			'createProfile.stepInterests' => '4/5 Интересы',
			'createProfile.interestsTitle' => 'Что тебе нравится?',
			'createProfile.interestsSubtitle' => 'Выбери хотя бы 5 — так мы найдём людей, которые тебя поймут.',
			'createProfile.interests.music' => 'Музыка',
			'createProfile.interests.movies' => 'Кино',
			'createProfile.interests.tvShows' => 'Сериалы',
			'createProfile.interests.reading' => 'Чтение',
			'createProfile.interests.painting' => 'Живопись',
			'createProfile.interests.photography' => 'Фотография',
			'createProfile.interests.theatre' => 'Театр',
			'createProfile.interests.fitness' => 'Фитнес',
			'createProfile.interests.swimming' => 'Плавание',
			'createProfile.interests.football' => 'Футбол',
			'createProfile.interests.basketball' => 'Баскетбол',
			'createProfile.interests.coffee' => 'Кофе',
			'createProfile.interests.travel' => 'Путешествия',
			'createProfile.interests.camping' => 'Кемпинг',
			'createProfile.interests.meditation' => 'Медитация',
			'createProfile.interests.videoGames' => 'Видеоигры',
			'createProfile.interests.boardGames' => 'Настолки',
			'createProfile.interests.standUp' => 'Стендап',
			'createProfile.interests.tech' => 'Технологии',
			'createProfile.interests.coding' => 'Программирование',
			'createProfile.interests.ai' => 'ИИ',
			'createProfile.interests.podcast' => 'Подкасты',
			_ => null,
		} ?? switch (path) {
			'createProfile.stepChatGoal' => '5/5 Цель общения',
			'createProfile.chatGoalTitle' => 'Что ищешь сегодня?',
			'createProfile.chatGoalSubtitle' => 'Так мы подберём собеседника под твоё настроение.',
			'createProfile.chatGoalQuickMatch' => 'Быстрый подбор — сразу\nв разговор',
			'createProfile.chatGoalFlirtyChat' => 'Флирт — лёгкое, игривое\nобщение',
			'createProfile.chatGoalMoodMatch' => 'По настроению — подбор по тому,\nкак ты себя чувствуешь',
			'createProfile.chatGoalLateNight' => 'Ночные разговоры — душевно, пока мир\nспит',
			'createProfile.chatGoalMeetSomeoneNew' => 'Новые знакомства — без цели, просто\nисследуй',
			'createProfile.getStarted' => 'Начать',
			'createProfile.preparingTitleLine1' => 'Мы подбираем',
			'createProfile.preparingTitleLine2' => 'подходящие профили',
			'createProfile.preparingTitleLine3' => 'для тебя.',
			'createProfile.preparingSubtitleLine1' => 'Выбираем лучших по твоим ответам —',
			'createProfile.preparingSubtitleLine2' => 'подожди немного.',
			'createProfile.preparingPercent' => ({required Object percent}) => '${percent}%',
			'createProfile.usernameInvalid' => '3–30 символов: буквы, цифры, точки или подчёркивания.',
			'errors.network' => 'Нет связи с Veylo. Проверь подключение и попробуй снова.',
			'errors.generic' => 'Что-то пошло не так. Попробуй снова.',
			'errors.signInFailed' => 'Не удалось войти. Попробуй снова.',
			'errors.sessionExpired' => 'Сессия истекла. Войди снова.',
			'errors.accountSuspended' => 'Этот аккаунт заблокирован.',
			'errors.unsupportedImage' => 'Выбери фото в формате JPEG, PNG или WebP.',
			'errors.fileTooLarge' => 'Файл слишком большой.',
			'errors.enterEmailForReset' => 'Введи почту выше, чтобы сбросить пароль.',
			'errors.wrongCredentials' => 'Неверная почта/имя пользователя или пароль.',
			'errors.emailInUse' => 'Эта почта уже зарегистрирована. Попробуй войти.',
			'errors.weakPassword' => 'Пароль должен быть не короче 6 символов.',
			'errors.invalidEmail' => 'Введи корректный адрес почты.',
			'errors.tooManyAttempts' => 'Слишком много попыток. Подожди немного.',
			'errors.fillAllFields' => 'Заполни все поля.',
			'errors.insufficientTokens' => 'Недостаточно токенов.',
			'errors.requestNotAccepted' => 'Прими запрос, чтобы ответить.',
			'errors.requestPendingLimit' => 'Ты сможешь писать дальше, когда запрос примут.',
			'errors.blocked' => 'Ты не можешь написать этому человеку.',
			'errors.peerUnavailable' => 'Этот аккаунт больше недоступен.',
			'errors.vibeDailyLimit' => 'Сегодня ты уже поделился(ась) многими Vibes. Попробуй позже.',
			'errors.groupFull' => 'Группа заполнена.',
			'errors.groupCreateLimit' => 'Сегодня ты создал(а) слишком много групп. Попробуй позже.',
			'errors.notFound' => 'Это больше недоступно.',
			'errors.recentLogin' => 'В целях безопасности выйди и войди снова, затем повтори.',
			'errors.socialAccount' => 'Почта и пароль управляются твоим аккаунтом Google или Apple.',
			'errors.alreadyInCall' => 'Ты уже в звонке.',
			'errors.roomPrivate' => 'Комната закрытая. Попроси ведущего впустить тебя.',
			'errors.roomFull' => 'Комната заполнена.',
			'faq.q1' => 'Как работает приложение?',
			'faq.q2' => 'Что такое анонимный чат?',
			'faq.q3' => 'Что такое прогресс связи?',
			'faq.q4' => 'Как раскрыть свой профиль?',
			'faq.q5' => 'Что такое «Незнакомец на 60 секунд»?',
			'faq.q6' => 'Что такое Vibes?',
			'faq.q7' => 'Как изменить профиль?',
			'faq.q8' => 'Как настроить уведомления?',
			'faq.q9' => 'Как восстановить покупки?',
			'faq.q10' => 'Можно удалить все чаты?',
			'faq.q11' => 'Мои данные в безопасности?',
			'faq.q12' => 'Как заблокировать или пожаловаться?',
			'faq.q13' => 'Как поделиться приложением?',
			'faq.q14' => 'Как удалить аккаунт?',
			'faq.a1' => 'В Veylo можно анонимно знакомиться, общаться и постепенно раскрывать профиль по мере роста связи. Переходите к переписке, голосу или встрече, когда оба будете готовы.',
			'faq.a2' => 'В анонимном чате твоё имя и фото скрыты. С ростом связи открываются детали: первая буква имени и размытое фото. На 100% для раскрытия полных профилей нужно согласие обоих.',
			'faq.a3' => 'Пока вы общаетесь, процент связи растёт. На определённых этапах открываются первая буква имени, размытое фото и полный профиль. Нажми на значок «Связь», чтобы узнать подробнее.',
			'faq.a4' => 'Когда связь достигнет 100%, нажми «Раскрыть мой профиль». Если собеседник тоже согласится, оба полных профиля станут видны.',
			'faq.a5' => 'Во вкладке «Звонок» можно получить короткий случайный подбор. Когда время выйдет, можно продолжить разговор или завершить звонок.',
			'faq.a6' => 'Vibes помогает находить людей рядом на карте или в списке и начинать чат с теми, кто тебе интересен.',
			'faq.a7' => 'Открой вкладку «Профиль» и перейди в «Изменить профиль», чтобы обновить имя, фото, описание и интересы. Изменения появятся после сохранения.',
			'faq.a8' => 'Открой «Уведомления» в настройках, чтобы включить или выключить оповещения о сообщениях, совпадениях и другом.',
			'faq.a9' => 'Перейди в «Настройки → Управление аккаунтом → Восстановить покупки». Доступные покупки в том же аккаунте магазина будут восстановлены.',
			'faq.a10' => 'Да. Открой «Настройки → Удалить чаты» и подтверди. Все чаты будут удалены. Это нельзя отменить.',
			'faq.a11' => 'Данные аккаунта и сообщения хранятся в защищённых системах. Удалить аккаунт и данные можно в любой момент в разделе «Управление аккаунтом».',
			'faq.a12' => 'Используй меню в профиле или в чате, чтобы заблокировать или пожаловаться. Жалобы проверяет наша команда.',
			'faq.a13' => 'Нажми «Поделиться приложением» в настройках, чтобы скопировать ссылку и отправить друзьям.',
			'faq.a14' => 'Перейди в «Настройки → Управление аккаунтом → Удалить аккаунт и данные». Укажи причину и подтверди, чтобы отправить запрос на удаление.',
			'legal.termsTitle' => 'Условия использования',
			'legal.privacyTitle' => 'Политика конфиденциальности',
			'legal.termsBody' => 'Последнее обновление: 16 марта 2026 г.\n\nДобро пожаловать в Veylo. Создавая аккаунт или пользуясь приложением, ты принимаешь настоящие Условия использования.\n\n1. Что такое Veylo\nVeylo — социальное приложение, где можно знакомиться, общаться анонимно, постепенно сближаться и, если обе стороны согласны, переходить к голосовым или видеозвонкам.\n\n2. Твой аккаунт\nТы обязан(а) указывать достоверные данные и обеспечивать безопасность входа в аккаунт. Ты несёшь ответственность за действия в своём аккаунте. Ты должен(на) достичь возраста, с которого законы твоей страны разрешают пользоваться Veylo.\n\n3. Уважительное поведение\nЗапрещается преследовать, угрожать, мошенничать, выдавать себя за других, распространять незаконный контент или пытаться обойти функции безопасности. Мы можем удалять контент, ограничивать функции или блокировать аккаунты, нарушающие эти правила.\n\n4. Анонимный чат и раскрытие профиля\nВ анонимных чатах имя и фото могут быть скрыты до достижения этапов связи. Полное раскрытие профиля требует взаимного согласия. Не принуждай других раскрывать свою личность.\n\n5. Покупки\nНекоторые функции могут быть платными. Покупки обрабатываются Apple App Store или Google Play. Функция «Восстановить покупки» восстанавливает доступные покупки в том же аккаунте магазина. Возвраты осуществляются согласно правилам магазина.\n\n6. Твой контент\nТы сохраняешь права на свой контент, но предоставляешь Veylo лицензию на его размещение и показ в приложении в объёме, необходимом для работы сервиса. Не публикуй контент, на распространение которого у тебя нет прав.\n\n7. Прекращение использования\nТы можешь в любой момент перестать пользоваться Veylo и запросить удаление аккаунта в настройках. Мы также можем прекратить или изменить работу сервиса, уведомив об этом в разумный срок, когда это требуется.\n\n8. Контакты\nВопросы об этих условиях: support@veylo.app',
			'legal.privacyBody' => 'Последнее обновление: 16 марта 2026 г.\n\nНастоящая Политика конфиденциальности объясняет, как Veylo собирает, использует и защищает твою информацию.\n\n1. Какие данные мы собираем\n• Данные аккаунта: эл. почта, отображаемое имя, фото профиля, описание, предпочтения\n• Данные об использовании: чаты, прогресс связи, используемые функции звонков, базовые данные об устройстве и приложении\n• Покупки: данные чеков магазина, необходимые для открытия и восстановления платных функций\n\n2. Как мы их используем\nМы используем твои данные для работы Veylo, персонализации подбора и общения, обеспечения безопасности сообщества, обработки покупок и улучшения продукта. Мы не продаём твои персональные данные.\n\n3. Анонимный режим\nВ анонимных чатах мы ограничиваем то, что видят другие (например, скрытое имя или размытое фото), пока правила открытия и взаимное согласие не позволят большего. При этом для безопасной работы функции нам по-прежнему нужны идентификаторы аккаунта.\n\n4. Передача данных\nМы можем передавать данные поставщикам услуг, которые помогают нам с хостингом, аналитикой или обработкой платежей, — только в необходимом объёме. Мы также можем раскрыть информацию, если этого требует закон или это нужно для защиты пользователей от вреда.\n\n5. Хранение\nМы храним данные, пока твой аккаунт активен, а также в объёме, необходимом по юридическим причинам, соображениям безопасности и для расчётов. После выполнения запроса на удаление мы удаляем или обезличиваем персональные данные, кроме случаев, когда их хранение обязательно.\n\n6. Твой выбор\nТы можешь изменять данные профиля, настраивать уведомления, запрашивать удаление аккаунта и обращаться к нам по вопросам своих данных. Покупками в магазине также можно управлять через Apple или Google.\n\n7. Безопасность\nМы применяем разумные технические и организационные меры для защиты твоей информации. Ни одна система не защищена идеально, поэтому используй надёжный пароль и обновляй устройство.\n\n8. Контакты\nВопросы о конфиденциальности: privacy@veylo.app',
			'logout.title' => 'Выход',
			'logout.subtitle' => 'Точно хочешь выйти?',
			'logout.cancel' => 'Отмена',
			'logout.confirm' => 'Выйти',
			'deleteAccount.title' => 'Запрос на удаление аккаунта',
			'deleteAccount.subtitle' => 'Точно хочешь удалить аккаунт?',
			'deleteAccount.reasonTitle' => 'Нам жаль, что ты уходишь, но мы понимаем.',
			'deleteAccount.reasonBefore' => 'Расскажи, почему уходишь, — это поможет сделать ',
			'deleteAccount.reasonAfter' => ' лучше.',
			'deleteAccount.reasonLabel' => 'Почему хочешь удалить аккаунт?',
			'deleteAccount.reasonHint' => 'Напиши сообщение',
			'deleteAccount.cancel' => 'Отмена',
			'deleteAccount.createRequest' => 'Отправить запрос',
			'deleteAccount.confirmTitle' => 'Точно отправить запрос на удаление?',
			'deleteAccount.confirmSubtitle' => 'После подтверждения запрос на удаление аккаунта будет отправлен',
			'deleteAccount.delete' => 'Удалить',
			'storyText.bold' => 'Жирный',
			'storyText.italic' => 'Курсив',
			'storyText.uppercase' => 'Заглавные',
			'storyText.underline' => 'Подчёркнутый',
			'storyText.cancel' => 'Отмена',
			'storyText.galleryError' => 'Не удалось открыть галерею',
			_ => null,
		};
	}
}
