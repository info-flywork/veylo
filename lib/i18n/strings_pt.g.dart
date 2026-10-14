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
class TranslationsPt extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsPt({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.pt,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <pt>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key) ?? super[key];

	late final TranslationsPt _root = this; // ignore: unused_field

	@override 
	TranslationsPt $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsPt(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$app$pt app = _Translations$app$pt._(_root);
	@override late final _Translations$home$pt home = _Translations$home$pt._(_root);
	@override late final _Translations$chats$pt chats = _Translations$chats$pt._(_root);
	@override late final _Translations$profile$pt profile = _Translations$profile$pt._(_root);
	@override late final _Translations$nav$pt nav = _Translations$nav$pt._(_root);
	@override late final _Translations$call$pt call = _Translations$call$pt._(_root);
	@override late final _Translations$vibes$pt vibes = _Translations$vibes$pt._(_root);
	@override late final _Translations$discover$pt discover = _Translations$discover$pt._(_root);
	@override late final _Translations$common$pt common = _Translations$common$pt._(_root);
	@override late final _Translations$languages$pt languages = _Translations$languages$pt._(_root);
	@override late final _Translations$auth$pt auth = _Translations$auth$pt._(_root);
	@override late final _Translations$onboarding$pt onboarding = _Translations$onboarding$pt._(_root);
	@override late final _Translations$createProfile$pt createProfile = _Translations$createProfile$pt._(_root);
	@override late final _Translations$errors$pt errors = _Translations$errors$pt._(_root);
	@override late final _Translations$faq$pt faq = _Translations$faq$pt._(_root);
	@override late final _Translations$legal$pt legal = _Translations$legal$pt._(_root);
	@override late final _Translations$logout$pt logout = _Translations$logout$pt._(_root);
	@override late final _Translations$deleteAccount$pt deleteAccount = _Translations$deleteAccount$pt._(_root);
	@override late final _Translations$storyText$pt storyText = _Translations$storyText$pt._(_root);
}

// Path: app
class _Translations$app$pt extends Translations$app$tr {
	_Translations$app$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get name => 'Veylo';
	@override String get tagline => 'Bem-vindo';
}

// Path: home
class _Translations$home$pt extends Translations$home$tr {
	_Translations$home$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Início';
	@override String get subtitle => 'O app está sendo preparado';
	@override String get body => 'A interface multilíngue é gerenciada com slang.';
}

// Path: chats
class _Translations$chats$pt extends Translations$chats$tr {
	_Translations$chats$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Conversas';
	@override String get search => 'Buscar';
	@override String get messagesSection => 'Mensagens';
	@override String get request => 'Solicitação';
	@override String get emptyRequestTitle => 'Nenhuma notificação de\nmensagem recente';
	@override String get emptyRequestSubtitle => 'Solicitações com mais de 30 dias não são exibidas.';
	@override String get noteAdd => 'Adicionar nota';
	@override String get anonymous => 'Anônimo';
	@override String get online => 'online';
	@override String get offline => 'offline';
	@override String get connection => 'Conexão';
	@override String connectionPercent({required Object n}) => '${n}%';
	@override String get connectionProgressTitle => 'Progresso da conexão';
	@override String get milestoneInitial => 'Inicial do nome';
	@override String get milestoneInitialHint => 'Desbloqueado em 25%';
	@override String get milestoneInitialLocked => 'Desbloqueia em 25%';
	@override String get milestonePhoto => 'Prévia da foto desfocada';
	@override String get milestonePhotoHint => 'Desbloqueia em 70%';
	@override String get milestoneFull => 'Perfil completo';
	@override String get milestoneFullHint => 'Consentimento mútuo em 100%';
	@override String get sampleAnonymousMessage => 'Oi, foi um prazer te conhecer. Pode me contar um pouco sobre você?';
	@override String get strangerSampleMessage => 'Oi Jhon, foi um prazer te conhecer. Pode me contar um pouco sobre você?';
	@override String get approve => 'Aprovar';
	@override String get blockUser => 'Bloquear usuário';
	@override String get reject => 'Recusar';
	@override String get messageHint => 'Oi! Tudo bem?';
	@override String get revealTitle => 'Vocês chegaram a 100%';
	@override String get revealSubtitle => 'Revelar os perfis completos um para o outro? Os dois precisam concordar.';
	@override String revealWaiting({required Object name}) => 'Esperando ${name} aceitar';
	@override String get revealCta => 'Revelar meu perfil';
	@override String get revealNotYet => 'Ainda não';
	@override String get seen => 'Visto';
	@override String get typing => 'digitando…';
	@override String get noteYou => 'Você';
	@override String get noteSheetTitle => 'Compartilhe uma nota';
	@override String get noteSheetSubtitle => 'Sua nota fica por 24 horas';
	@override String get noteHint => 'No que você está pensando?';
	@override String get noteShare => 'Compartilhar';
	@override String get noteDelete => 'Excluir nota';
}

// Path: profile
class _Translations$profile$pt extends Translations$profile$tr {
	_Translations$profile$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get eyebrow => 'Perfil';
	@override String get title => 'Configurações';
	@override String get editProfile => 'Editar perfil';
	@override String get statLike => 'Curtidas';
	@override String get statFollow => 'Seguindo';
	@override String get statFollower => 'Seguidores';
	@override String get promoTitle => 'Receba mais mensagens!';
	@override String get promoSubtitle => 'Destaque-se e apareça no topo da lista';
	@override String get standOut => 'Destacar';
	@override String get tabPosts => 'Posts';
	@override String get tabVideo => 'Vídeo';
	@override String get tabSaved => 'Salvos';
	@override String get save => 'Salvar';
	@override String get changePhoto => 'Trocar foto';
	@override String get changeBorder => 'Trocar borda';
	@override String get interest => 'Interesses';
	@override String get name => 'Nome';
	@override String get changeName => 'Alterar nome';
	@override String get changePassword => 'Alterar senha';
	@override String get confirmPassword => 'Confirmar senha';
	@override String get email => 'E-mail';
	@override String get accountManagement => 'Gerenciar conta';
	@override String get settingsAbout => 'Sobre';
	@override String get settingsAccount => 'Configurações da conta';
	@override String get settingsSupport => 'Suporte';
	@override String get shareApp => 'Compartilhar o app';
	@override String get shareAppTitle => 'Compartilhe com amigos';
	@override String get shareAppSubtitle => 'Compartilhe o Veylo com seus amigos e descubram juntos!';
	@override String get shareAppLabel => 'Link do app';
	@override String get rateApp => 'Gostou? Avalie a gente';
	@override String get notifications => 'Notificações';
	@override String get password => 'Senha';
	@override String get deleteConversation => 'Excluir conversas';
	@override String get faqHelp => 'Perguntas frequentes e ajuda';
	@override String get restorePurchases => 'Restaurar compras';
	@override String get termsOfService => 'Termos de Serviço';
	@override String get privacyPolicy => 'Política de Privacidade';
	@override String get restorePurchasesDone => 'Compras verificadas';
	@override String get conversationsDeleted => 'Todas as conversas foram excluídas';
	@override String get logOut => 'Sair';
	@override String get deleteAccountAndData => 'Excluir conta e dados';
	@override String get passwordPlaceholder => '********';
	@override String get height => 'Altura';
	@override String get addHeight => 'Adicionar altura';
	@override String heightCm({required Object value}) => '${value} cm';
	@override String get languages => 'Idiomas';
	@override String get relationshipGoals => 'Objetivos de relacionamento';
	@override String get lookingFor => 'Procurando';
	@override String get newFriends => '👋 Novas amizades';
	@override String get goalLongTermOpenToShort => '💕 Algo sério, aberto a casual';
	@override String get goalLongTermRelationship => '💘 Relacionamento sério';
	@override String get goalNewFriends => '👋 Novas amizades';
	@override String get goalShortTermFun => '🥃 Algo casual';
	@override String get goalStillFiguringItOut => '🤔 Ainda estou descobrindo';
	@override String get basics => 'Básico';
	@override String get zodiac => 'Signo';
	@override String get zodiacValue => 'Escorpião';
	@override String get education => 'Escolaridade';
	@override String get educationValue => 'Graduação';
	@override String get educationHighSchool => 'Ensino médio';
	@override String get educationAssociates => 'Curso técnico/tecnólogo';
	@override String get educationBachelors => 'Graduação';
	@override String get educationMasters => 'Mestrado';
	@override String get educationPhd => 'Doutorado';
	@override String get voiceRecord => 'Gravação de voz';
	@override String get addVoice => 'Adicionar voz';
	@override String get lifestyle => 'Estilo de vida';
	@override String get pets => 'Pets';
	@override String get petsValue => 'Tenho gato';
	@override String get petsDontWant => 'Não quero pets';
	@override String get petsAllergic => 'Tenho alergia a pets';
	@override String get petsHaveCat => 'Tenho gato';
	@override String get petsHaveDog => 'Tenho cachorro';
	@override String get petsHaveCatsAndDogs => 'Tenho gatos e cachorros';
	@override String get petsHaveOther => 'Tenho outros pets';
	@override String get drinking => 'Bebida';
	@override String get drinkingValue => 'Em ocasiões especiais';
	@override String get drinkingNever => 'Nunca';
	@override String get drinkingSpecialOccasions => 'Em ocasiões especiais';
	@override String get drinkingSocially => 'Socialmente';
	@override String get drinkingFrequently => 'Com frequência';
	@override String get drinkingSober => 'Sóbrio';
	@override String get drinkingPreferNotToSay => 'Prefiro não dizer';
	@override String get smoking => 'Cigarro';
	@override String get smokingValue => 'Não fumante';
	@override String get smokingNonSmoker => 'Não fumante';
	@override String get smokingSocialSmoker => 'Fumo socialmente';
	@override String get smokingSmoker => 'Fumante';
	@override String get smokingTryingToQuit => 'Tentando parar';
	@override String get smokingWhenDrinking => 'Fumo quando bebo';
	@override String get smokingPreferNotToSay => 'Prefiro não dizer';
	@override String get gender => 'Gênero';
	@override String get genderFemale => 'Feminino';
	@override String get genderMale => 'Masculino';
	@override String get genderPreferNotToSay => 'Prefiro não informar';
	@override String get visible => 'Visível';
	@override String get profileVisibility => 'Visibilidade do perfil';
	@override String get language => 'Idioma';
	@override String get borderTitle => 'Borda do perfil';
	@override String get borderSubtitle => 'Adicione uma borda ao seu perfil para\nse destacar.';
	@override String get borderBuySection => 'Comprar uma borda';
	@override String get borderBuyCta => 'Comprar borda';
	@override String borderToken({required Object count}) => '${count} Tokens';
	@override String get borderAmethystWings => 'Amethyst Wings';
	@override String get borderGoldenPhoenix => 'Golden Phoenix';
	@override String get borderFrostCrown => 'Frost Crown';
	@override String get borderEmeraldWhisper => 'Emerald Whisper';
	@override String get borderRoseQuartz => 'Rose Quartz';
	@override String get borderStarlitComet => 'Starlit Comet';
	@override String get borderCrimsonRoyal => 'Crimson Royal';
	@override String get borderSapphireHalo => 'Sapphire Halo';
	@override String get follow => 'Seguir';
	@override String get following => 'Seguindo';
	@override String get followPageTitle => 'Seguir';
	@override String get followTabFollowing => 'Seguindo';
	@override String get followTabFollowers => 'Seguidores';
	@override String get followSearch => 'Buscar';
	@override String get unfollow => 'Deixar de seguir';
	@override String get followSortTitle => 'Ordenar';
	@override String get followSortRecent => 'Quem eu segui mais recentemente';
	@override String get followSortNotFollowingMe => 'Quem não me segue de volta';
	@override String get followSortNotFollowedByMe => 'Quem eu não sigo de volta';
	@override String get followSortShowResult => 'Ver resultado';
	@override String get followSortEmpty => 'Nenhum usuário corresponde a este filtro';
	@override String get shareTitle => 'Compartilhe com amigos';
	@override String get shareSubtitle => 'Tudo fica mais divertido quando você se\nconecta com seus amigos!';
	@override String get shareProfileLabel => 'Compartilhar o perfil';
	@override String get shareLinkCopied => 'Link copiado';
	@override String get restrict => 'Restringir';
	@override String get block => 'Bloquear';
	@override String get report => 'Denunciar';
	@override String blockTitle({required Object username}) => 'Bloquear ${username}?';
	@override String get blockBody => 'Isso também vai bloquear outras contas que a pessoa tenha ou venha a criar. Você pode desbloquear quando quiser.';
	@override String get blockAndReport => 'Bloquear e denunciar';
	@override String restrictTitle({required Object username}) => 'Restringir ${username}?';
	@override String get restrictBody => 'A pessoa não vai ver quando você está online nem se você leu as mensagens dela. Você pode mudar isso quando quiser.';
	@override String get restrictAndReport => 'Restringir e denunciar';
	@override String get reportTitle => 'Queremos saber o motivo';
	@override String get reportSubtitle => 'Para melhorar sua experiência, pode nos contar por que quer denunciar este usuário?';
	@override String get reportMessageLabel => 'Mensagem da denúncia';
	@override String get reportMessageHint => 'Digite sua mensagem';
	@override String get reportCancel => 'Cancelar';
	@override String get sendReport => 'Enviar denúncia';
	@override String get notSet => 'Não definido';
	@override String get reportSent => 'Obrigado, recebemos sua denúncia.';
	@override String emailVerificationSent({required Object email}) => 'Enviamos um link de confirmação para ${email}. Seu e-mail muda depois que você confirmar.';
	@override String get passwordChanged => 'Sua senha foi atualizada.';
	@override String get passwordMismatch => 'As senhas não coincidem.';
}

// Path: nav
class _Translations$nav$pt extends Translations$nav$tr {
	_Translations$nav$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get discover => 'Descobrir';
	@override String get chat => 'Chat';
	@override String get call => 'Chamada';
	@override String get vibes => 'Vibes';
	@override String get profile => 'Perfil';
}

// Path: call
class _Translations$call$pt extends Translations$call$tr {
	_Translations$call$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Estranho em 60 segundos';
	@override String get subtitle => 'Converse com um estranho aleatório por 60 segundos — totalmente anônimo. Sem perfil, sem foto, sem nome. Só uma voz e um momento.';
	@override String get findingTitle => 'Procurando um estranho...';
	@override String get findingSubtitle => 'Vocês vão conversar anonimamente por 60 segundos. Sem perfil, sem nomes.';
	@override String get callStranger => 'Ligar para estranho - 10 Tokens';
	@override String get cancel => 'Cancelar';
	@override String get female => 'Feminino';
	@override String get male => 'Masculino';
	@override String get nonBinary => 'Não binário';
	@override String get preferNotToSay => 'Prefiro não dizer';
	@override String get anonymousBadge => '🎙️ Chamada de voz anônima';
	@override String get stranger => 'Estranho';
	@override String secondsLeft({required Object n}) => '${n}s';
	@override String get timesUpTitle => 'Acabou o tempo!';
	@override String get timesUpSubtitle => 'Quer continuar conversando? Se os dois disserem sim, o chat é liberado.';
	@override String get keepTalking => 'Continuar';
	@override String get endCall => 'Encerrar';
	@override String get waitingOther => 'Esperando a outra pessoa...';
	@override String get callStrangerFree => 'Ligar para estranho';
	@override String get peerLeft => 'A outra pessoa encerrou a chamada.';
	@override String get noKeep => 'O chat não foi liberado desta vez.';
	@override String get videoWaiting => 'Esperando aceitarem a chamada de vídeo...';
	@override String get videoDeclined => 'A chamada de vídeo foi recusada.';
	@override String get micDenied => 'As chamadas precisam de acesso ao microfone. Você pode ativar nos Ajustes.';
	@override String get videoCost => 'Chamada de vídeo: 20 tokens / 15 min';
	@override String get calling => 'Chamando';
	@override String get accept => 'Aceitar';
	@override String get decline => 'Recusar';
	@override String get switchToVideo => 'Quer mudar para uma chamada de vídeo?';
}

// Path: vibes
class _Translations$vibes$pt extends Translations$vibes$tr {
	_Translations$vibes$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get search => 'Buscar';
	@override String get sendMessage => 'Enviar mensagem';
	@override String get wantsToTalk => 'Quer falar sobre isso agora';
	@override String get shareTitle => 'Compartilhar Vibe';
	@override String get replyTitle => 'Responder Vibe';
	@override String get shareHint => 'Escreva algo';
	@override String get shareAnonymous => 'Compartilhar anonimamente';
	@override String get empty => 'Nenhuma vibe nas últimas 24 horas. Compartilhe a primeira!';
	@override String get deleteTitle => 'Excluir esta vibe?';
	@override String get delete => 'Excluir';
	@override String get cancel => 'Cancelar';
}

// Path: discover
class _Translations$discover$pt extends Translations$discover$tr {
	_Translations$discover$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Descobrir';
	@override String get tabRooms => 'Salas';
	@override String get tabDiscover => 'Descobrir';
	@override String get tabAiMatch => 'AI Match';
	@override late final _Translations$discover$aiMatch$pt aiMatch = _Translations$discover$aiMatch$pt._(_root);
	@override String get searchHint => 'Buscar';
	@override String get allRooms => 'Todas as salas';
	@override String get allGroups => 'Todos os grupos';
	@override String get seeAll => 'Ver tudo';
	@override String get live => 'Ao vivo';
	@override String get join => 'Entrar';
	@override String get request => 'Solicitar';
	@override String get requested => 'Solicitado';
	@override String get private => 'Privado';
	@override String moreCount({required Object count}) => '+${count} mais';
	@override String activeCount({required Object count}) => '${count} ativos';
	@override String membersCount({required Object count}) => '${count} membros';
	@override late final _Translations$discover$privateRoom$pt privateRoom = _Translations$discover$privateRoom$pt._(_root);
	@override late final _Translations$discover$roomToken$pt roomToken = _Translations$discover$roomToken$pt._(_root);
	@override late final _Translations$discover$privateRequest$pt privateRequest = _Translations$discover$privateRequest$pt._(_root);
	@override late final _Translations$discover$roomApproved$pt roomApproved = _Translations$discover$roomApproved$pt._(_root);
	@override late final _Translations$discover$createSpace$pt createSpace = _Translations$discover$createSpace$pt._(_root);
	@override late final _Translations$discover$liveRoom$pt liveRoom = _Translations$discover$liveRoom$pt._(_root);
	@override late final _Translations$discover$groupChat$pt groupChat = _Translations$discover$groupChat$pt._(_root);
	@override late final _Translations$discover$groupInfo$pt groupInfo = _Translations$discover$groupInfo$pt._(_root);
	@override late final _Translations$discover$filters$pt filters = _Translations$discover$filters$pt._(_root);
	@override late final _Translations$discover$post$pt post = _Translations$discover$post$pt._(_root);
	@override late final _Translations$discover$story$pt story = _Translations$discover$story$pt._(_root);
	@override late final _Translations$discover$highlight$pt highlight = _Translations$discover$highlight$pt._(_root);
	@override late final _Translations$discover$stats$pt stats = _Translations$discover$stats$pt._(_root);
	@override String hostedBy({required Object name}) => 'Apresentado por ${name}';
}

// Path: common
class _Translations$common$pt extends Translations$common$tr {
	_Translations$common$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get loading => 'Carregando…';
	@override String get retry => 'Tentar de novo';
	@override String get cancel => 'Cancelar';
	@override String get save => 'Salvar';
	@override String get continueAction => 'Continuar';
	@override String get language => 'Idioma';
	@override String get or => 'OU';
}

// Path: languages
class _Translations$languages$pt extends Translations$languages$tr {
	_Translations$languages$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get tr => 'Türkçe';
	@override String get en => 'English';
}

// Path: auth
class _Translations$auth$pt extends Translations$auth$tr {
	_Translations$auth$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get createAccountTitle => 'Crie sua conta';
	@override String get createAccountSubtitle => 'Entre no Veylo e comece a se conectar.';
	@override String get welcomeBackTitle => 'Bem-vindo de volta';
	@override String get welcomeBackSubtitle => 'Entre para continuar no Veylo.';
	@override String get username => 'Nome de usuário';
	@override String get usernameHint => 'Escolha um nome de usuário';
	@override String get email => 'E-mail';
	@override String get emailHint => 'Digite seu e-mail';
	@override String get emailOrUsername => 'E-mail ou nome de usuário';
	@override String get emailOrUsernameHint => 'Digite seu e-mail ou usuário';
	@override String get password => 'Senha';
	@override String get passwordCreateHint => 'Crie uma senha';
	@override String get passwordEnterHint => 'Digite sua senha';
	@override String get signUp => 'Cadastrar';
	@override String get logIn => 'Entrar';
	@override String get forgotPassword => 'Esqueceu a senha?';
	@override String get continueWithApple => 'Continuar com Apple';
	@override String get continueWithGoogle => 'Continuar com Google';
	@override String get legalPrefix => 'Ao continuar, você concorda com nossos ';
	@override String get termsOfService => 'Termos de Serviço';
	@override String get legalMiddle => ' e reconhece nossa ';
	@override String get privacyPolicy => 'Política de Privacidade';
	@override String get legalSuffix => '.';
	@override String get passwordResetSent => 'Enviamos um link para redefinir a senha para seu e-mail.';
}

// Path: onboarding
class _Translations$onboarding$pt extends Translations$onboarding$tr {
	_Translations$onboarding$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get skip => 'Pular';
	@override String get page1Title => 'Seja você. Fique anônimo.';
	@override String get page1Subtitle => 'Conheça gente nova e comece conversas\nsem revelar quem você é.';
	@override String get page2Title => 'Escreva. Fale. Sinta a vibe.';
	@override String get page2Subtitle => 'Comece no anonimato e depois troque mensagens, ligue ou se veja cara a cara quando quiser.';
	@override String get page3Title => 'Encontre sua turma. Entre\nna conversa.';
	@override String get page3Subtitle => 'Entre em salas, conheça gente nova e\ncompartilhe o momento juntos.';
	@override String get getStarted => 'Começar';
	@override String get alreadyHaveAccount => 'Já tem uma conta Veylo? ';
	@override String get logInAction => 'Entrar';
}

// Path: createProfile
class _Translations$createProfile$pt extends Translations$createProfile$tr {
	_Translations$createProfile$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get navTitle => 'Criar perfil';
	@override String get stepUsername => '1/5 Nome de usuário';
	@override String get title => 'Crie seu perfil';
	@override String get subtitle => 'Seu nome real só é usado para verificação — ele não aparece publicamente.';
	@override String get subtitleLine1 => 'Seu nome real só é usado para verificação —';
	@override String get subtitleLine2 => 'ele não aparece publicamente.';
	@override String get fullName => 'Nome completo';
	@override String get fullNameHint => 'Sam Lee';
	@override String get username => 'Nome de usuário';
	@override String get usernameHint => 'samlee123';
	@override String get usernameTaken => 'Este nome de usuário já existe!';
	@override String get usernameAvailable => 'Nome de usuário disponível';
	@override String get mightWantToTry => 'Que tal tentar...';
	@override String get stepPhoto => '2/5 Foto de perfil';
	@override String get photoTitle => 'Envie uma foto de perfil';
	@override String get photoSubtitle => 'Outros usuários podem ver sua foto de perfil para saber que é você.';
	@override String get photoSubtitleLine1 => 'Outros usuários podem ver sua foto de perfil';
	@override String get photoSubtitleLine2 => 'para saber que é você.';
	@override String get choosePhoto => 'Escolher uma foto';
	@override String get continueWithoutPhoto => 'Continuar sem foto de perfil';
	@override String get saveAndContinue => 'Salvar e continuar';
	@override String get choosePhotoSheetTitle => 'Escolher uma foto';
	@override String get takePhoto => 'Tirar foto';
	@override String get chooseFromGallery => 'Escolher da galeria';
	@override String get stepGender => '3/5 Gênero';
	@override String get genderTitle => 'Escolha seu gênero';
	@override String get genderSubtitle => 'Se você optar por nos informar, podemos usar isso para personalizar o conteúdo para você';
	@override String get genderSubtitleLine1 => 'Se você optar por nos informar, podemos usar';
	@override String get genderSubtitleLine2 => 'isso para personalizar o conteúdo para você';
	@override String get genderFemale => 'Feminino';
	@override String get genderMale => 'Masculino';
	@override String get genderNonBinary => 'Não binário';
	@override String get genderPreferNotToSay => 'Prefiro não dizer';
	@override String get stepInterests => '4/5 Interesses';
	@override String get interestsTitle => 'Do que você curte?';
	@override String get interestsSubtitle => 'Escolha pelo menos 5 — isso ajuda a te conectar com pessoas que realmente te entendem.';
	@override late final _Translations$createProfile$interests$pt interests = _Translations$createProfile$interests$pt._(_root);
	@override String get stepChatGoal => '5/5 Objetivo do chat';
	@override String get chatGoalTitle => 'O que você procura hoje?';
	@override String get chatGoalSubtitle => 'Isso ajuda a encontrar o match certo para o seu humor agora.';
	@override String get chatGoalQuickMatch => 'Match rápido — entre direto numa\nconversa';
	@override String get chatGoalFlirtyChat => 'Paquera — conversas leves e\ndivertidas';
	@override String get chatGoalMoodMatch => 'Match de humor — combine pelo que você\nestá sentindo';
	@override String get chatGoalLateNight => 'Papo de madrugada — conversas profundas\nenquanto o mundo dorme';
	@override String get chatGoalMeetSomeoneNew => 'Conhecer alguém novo — sem objetivo, só\nexplorar';
	@override String get getStarted => 'Começar';
	@override String get preparingTitleLine1 => 'Estamos preparando';
	@override String get preparingTitleLine2 => 'perfis ideais para';
	@override String get preparingTitleLine3 => 'você.';
	@override String get preparingSubtitleLine1 => 'Com base nas suas respostas, estamos escolhendo';
	@override String get preparingSubtitleLine2 => 'os melhores matches — aguarde um momento.';
	@override String preparingPercent({required Object percent}) => '%${percent}';
	@override String get usernameInvalid => 'Use de 3 a 30 letras, números, pontos ou sublinhados.';
}

// Path: errors
class _Translations$errors$pt extends Translations$errors$tr {
	_Translations$errors$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get network => 'Não foi possível conectar ao Veylo. Verifique sua conexão e tente de novo.';
	@override String get generic => 'Algo deu errado. Tente de novo.';
	@override String get signInFailed => 'Falha ao entrar. Tente de novo.';
	@override String get sessionExpired => 'Sua sessão expirou. Entre novamente.';
	@override String get accountSuspended => 'Esta conta foi suspensa.';
	@override String get unsupportedImage => 'Escolha uma foto JPEG, PNG ou WebP.';
	@override String get fileTooLarge => 'Este arquivo é grande demais.';
	@override String get enterEmailForReset => 'Digite seu e-mail acima para redefinir a senha.';
	@override String get wrongCredentials => 'E-mail/usuário ou senha incorretos.';
	@override String get emailInUse => 'Este e-mail já está cadastrado. Tente entrar.';
	@override String get weakPassword => 'A senha precisa ter pelo menos 6 caracteres.';
	@override String get invalidEmail => 'Digite um endereço de e-mail válido.';
	@override String get tooManyAttempts => 'Muitas tentativas. Espere um pouco e tente de novo.';
	@override String get fillAllFields => 'Preencha todos os campos.';
	@override String get insufficientTokens => 'Tokens insuficientes.';
	@override String get requestNotAccepted => 'Aceite a solicitação para responder.';
	@override String get requestPendingLimit => 'Você poderá enviar mais mensagens depois que aceitarem sua solicitação.';
	@override String get blocked => 'Você não pode enviar mensagens para esta pessoa.';
	@override String get peerUnavailable => 'Esta conta não está mais disponível.';
	@override String get vibeDailyLimit => 'Você já compartilhou muitas vibes hoje. Tente mais tarde.';
	@override String get groupFull => 'Este grupo está cheio.';
	@override String get groupCreateLimit => 'Você criou grupos demais hoje. Tente mais tarde.';
	@override String get notFound => 'Isto não está mais disponível.';
	@override String get recentLogin => 'Por segurança, saia e entre de novo, depois tente outra vez.';
	@override String get socialAccount => 'Seu e-mail e senha são gerenciados pela sua conta Google ou Apple.';
	@override String get alreadyInCall => 'Você já está em uma chamada.';
	@override String get roomPrivate => 'Esta sala é privada. Peça ao anfitrião para entrar.';
	@override String get roomFull => 'Esta sala está cheia.';
}

// Path: faq
class _Translations$faq$pt extends Translations$faq$tr {
	_Translations$faq$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get q1 => 'Como o app funciona?';
	@override String get q2 => 'O que é o chat anônimo?';
	@override String get q3 => 'O que é o Progresso da conexão?';
	@override String get q4 => 'Como revelo meu perfil?';
	@override String get q5 => 'O que é o Estranho em 60 segundos?';
	@override String get q6 => 'O que são Vibes?';
	@override String get q7 => 'Como edito meu perfil?';
	@override String get q8 => 'Como gerencio as notificações?';
	@override String get q9 => 'Como restauro compras?';
	@override String get q10 => 'Posso excluir todas as conversas?';
	@override String get q11 => 'Meus dados estão seguros?';
	@override String get q12 => 'Como bloqueio ou denuncio alguém?';
	@override String get q13 => 'Como compartilho o app?';
	@override String get q14 => 'Como excluo minha conta?';
	@override String get a1 => 'No Veylo você conhece gente nova de forma anônima, conversa e revela seu perfil aos poucos conforme a conexão cresce. Passe para mensagens, voz ou cara a cara quando os dois se sentirem prontos.';
	@override String get a2 => 'No chat anônimo, sua identidade e sua foto ficam ocultas. Conforme a conexão aumenta, você desbloqueia detalhes como a inicial do nome e uma foto desfocada. Em 100%, os dois precisam concordar para revelar os perfis completos.';
	@override String get a3 => 'Conforme vocês conversam, a porcentagem de conexão cresce. Em certos marcos você desbloqueia a inicial do nome, uma foto desfocada e o perfil completo. Toque no selo Conexão para ver os detalhes.';
	@override String get a4 => 'Quando a conexão chegar a 100%, toque em Revelar meu perfil. Se a outra pessoa também aceitar, os dois perfis completos ficam visíveis.';
	@override String get a5 => 'Na aba Chamada você pode fazer um match aleatório rápido. Quando o tempo acabar, você pode continuar conversando ou encerrar a chamada.';
	@override String get a6 => 'Vibes permite descobrir pessoas por perto em um mapa ou lista e começar um chat com quem te interessar.';
	@override String get a7 => 'Abra a aba Perfil e vá em Editar perfil para atualizar nome, fotos, bio e interesses. As mudanças aparecem depois que você salva.';
	@override String get a8 => 'Abra Notificações em Configurações para ativar ou desativar alertas de mensagens, matches e outros.';
	@override String get a9 => 'Vá em Configurações → Gerenciar conta → Restaurar compras. As compras elegíveis na mesma conta da loja serão restauradas.';
	@override String get a10 => 'Sim. Use Configurações → Excluir conversas e confirme. Todos os chats serão removidos. Isso não pode ser desfeito.';
	@override String get a11 => 'Os dados da sua conta e suas mensagens ficam em sistemas protegidos. Você também pode pedir a exclusão da conta e dos dados em Gerenciar conta quando quiser.';
	@override String get a12 => 'Use o menu em um perfil ou na tela do chat para bloquear ou denunciar. As denúncias são analisadas pela nossa equipe.';
	@override String get a13 => 'Use Compartilhar o app em Configurações para copiar o link e enviar para seus amigos.';
	@override String get a14 => 'Vá em Configurações → Gerenciar conta → Excluir conta e dados. Depois de informar um motivo, confirme para enviar seu pedido de exclusão.';
}

// Path: legal
class _Translations$legal$pt extends Translations$legal$tr {
	_Translations$legal$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get termsTitle => 'Termos de Serviço';
	@override String get privacyTitle => 'Política de Privacidade';
	@override String get termsBody => 'Última atualização: 16 de março de 2026\n\nBem-vindo ao Veylo. Ao criar uma conta ou usar o app, você concorda com estes Termos de Serviço.\n\n1. O que é o Veylo\nO Veylo é um app social onde você pode conhecer pessoas, conversar anonimamente, criar conexão ao longo do tempo e, se quiser, passar para chamadas de voz ou cara a cara quando os dois lados concordarem.\n\n2. Sua conta\nVocê deve fornecer informações corretas e manter seu login seguro. Você é responsável pela atividade na sua conta. Você deve ter idade suficiente para usar o Veylo de acordo com as leis do seu país.\n\n3. Uso respeitoso\nNão assedie, ameace, aplique golpes, se passe por outras pessoas, compartilhe conteúdo ilegal nem tente burlar os recursos de segurança. Podemos remover conteúdo, limitar recursos ou suspender contas que violem estas regras.\n\n4. Chat anônimo e revelação do perfil\nChats anônimos podem ocultar seu nome e sua foto até que os marcos de conexão sejam atingidos. A revelação do perfil completo exige consentimento mútuo. Não pressione outras pessoas a revelar a identidade.\n\n5. Compras\nAlguns recursos podem ser pagos. As compras são processadas pela Apple App Store ou pelo Google Play. Restaurar compras recupera compras elegíveis na mesma conta da loja. Reembolsos seguem a política da loja.\n\n6. Conteúdo que você compartilha\nVocê mantém os direitos sobre seu conteúdo, mas concede ao Veylo uma licença para hospedá-lo e exibi-lo no app conforme necessário para operar o serviço. Não publique conteúdo que você não tenha direito de compartilhar.\n\n7. Encerramento do uso\nVocê pode parar de usar o Veylo a qualquer momento e pedir a exclusão da conta em Configurações. Também podemos encerrar ou alterar o serviço com aviso razoável quando necessário.\n\n8. Contato\nDúvidas sobre estes termos: support@veylo.app';
	@override String get privacyBody => 'Última atualização: 16 de março de 2026\n\nEsta Política de Privacidade explica como o Veylo coleta, usa e protege suas informações.\n\n1. Informações que coletamos\n• Dados da conta: e-mail, nome de exibição, fotos de perfil, bio, preferências\n• Dados de uso: chats, progresso da conexão, recursos de chamada que você usa, informações básicas do dispositivo/app\n• Compras: dados de recibo da loja necessários para liberar e restaurar recursos pagos\n\n2. Como usamos\nUsamos seus dados para operar o Veylo, personalizar os matches e a experiência de chat, manter a comunidade segura, processar compras e melhorar o produto. Não vendemos seus dados pessoais.\n\n3. Modo anônimo\nNos chats anônimos, limitamos o que os outros veem (por exemplo, nome mascarado ou foto desfocada) até que as regras de desbloqueio e o consentimento mútuo permitam mais. Nos bastidores, ainda precisamos de identificadores da conta para operar o recurso com segurança.\n\n4. Compartilhamento\nPodemos compartilhar dados com prestadores de serviço que nos ajudam com hospedagem, análise ou processamento de pagamentos — apenas quando necessário. Também podemos divulgar informações se exigido por lei ou para proteger usuários de danos.\n\n5. Retenção\nMantemos os dados enquanto sua conta estiver ativa e conforme necessário por motivos legais, de segurança e de cobrança. Depois que um pedido de exclusão é concluído, removemos ou anonimizamos os dados pessoais, exceto quando a retenção for obrigatória.\n\n6. Suas escolhas\nVocê pode editar as informações do perfil, gerenciar notificações, pedir a exclusão da conta e entrar em contato conosco sobre seus dados. As compras na loja também são gerenciadas pela Apple ou pelo Google.\n\n7. Segurança\nUsamos medidas técnicas e organizacionais razoáveis para proteger suas informações. Nenhum sistema é totalmente seguro; use uma senha forte e mantenha seu dispositivo atualizado.\n\n8. Contato\nDúvidas sobre privacidade: privacy@veylo.app';
}

// Path: logout
class _Translations$logout$pt extends Translations$logout$tr {
	_Translations$logout$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sair';
	@override String get subtitle => 'Tem certeza de que quer sair?';
	@override String get cancel => 'Cancelar';
	@override String get confirm => 'Sair';
}

// Path: deleteAccount
class _Translations$deleteAccount$pt extends Translations$deleteAccount$tr {
	_Translations$deleteAccount$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Enviar pedido de exclusão da conta';
	@override String get subtitle => 'Tem certeza de que quer excluir sua conta?';
	@override String get reasonTitle => 'Não queremos que você vá, mas entendemos.';
	@override String get reasonBefore => 'Pode nos contar por que quer sair para melhorarmos a experiência no ';
	@override String get reasonAfter => '?';
	@override String get reasonLabel => 'Por que você quer excluir sua conta';
	@override String get reasonHint => 'Digite sua mensagem';
	@override String get cancel => 'Cancelar';
	@override String get createRequest => 'Criar pedido';
	@override String get confirmTitle => 'Tem certeza de que quer enviar um pedido de exclusão?';
	@override String get confirmSubtitle => 'Se você confirmar, seu pedido de exclusão da conta será enviado';
	@override String get delete => 'Excluir';
}

// Path: storyText
class _Translations$storyText$pt extends Translations$storyText$tr {
	_Translations$storyText$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get bold => 'Negrito';
	@override String get italic => 'Itálico';
	@override String get uppercase => 'Maiúsculas';
	@override String get underline => 'Sublinhado';
	@override String get cancel => 'Cancelar';
	@override String get galleryError => 'Não foi possível abrir a galeria';
}

// Path: discover.aiMatch
class _Translations$discover$aiMatch$pt extends Translations$discover$aiMatch$tr {
	_Translations$discover$aiMatch$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get feelingTitle => 'Como você está se sentindo hoje';
	@override String get feelingSubtitle => 'A IA encontra o melhor match com base na sua escolha';
	@override String get lookingTitle => 'O que você está procurando?';
	@override String get moodSad => 'Triste';
	@override String get moodMeltie => 'Mais ou menos';
	@override String get moodBored => 'Entediado';
	@override String get moodCrying => 'Pra baixo';
	@override String get moodSmile => 'Feliz';
	@override String get lookingNewFriends => 'Novas amizades';
	@override String get lookingVenting => 'Desabafar';
	@override String get lookingFlirty => 'Paquera';
	@override String get lookingFun => 'Diversão';
	@override String get lookingCultures => 'Novas culturas';
	@override String get lookingLanguage => 'Praticar idiomas';
	@override String get statActiveUsers => 'Usuários ativos';
	@override String get statMatchRate => 'Taxa de match';
	@override String get statAvgTime => 'Tempo médio';
	@override String get statActiveValue => '843';
	@override String get statMatchValue => '87%';
	@override String get statAvgValue => '8s';
	@override String get startSmartMatch => 'Iniciar Smart Match';
	@override String get findingTitle => 'Procurando seu match';
	@override String get findingSubtitle => 'Combinando seu humor e interesses com a pessoa certa';
	@override String get findingStepMood => 'Humor analisado';
	@override String get findingStepInterests => 'Interesses combinados';
	@override String get findingStepCompatibility => 'Calculando compatibilidade...';
	@override String get findingStepContent => 'Criando conteúdo...';
	@override String findingOnline({required Object count}) => '${count} pessoas online agora';
	@override String get yourMatchTitle => 'Seu match';
	@override String get yourMatchSubtitle => 'Seu match foi feito com base nas suas respostas';
	@override String vibeMatch({required Object percent}) => '${percent}% de sintonia';
	@override String get startChatting => 'Começar a conversar';
	@override String matchNameAge({required Object name, required Object age}) => '${name}, ${age}';
	@override String get matchBio => 'Vou te fazer sentir coisas que você nem sabia que podia sentir.';
	@override String get swipePrevious => 'Anterior';
	@override String get swipeNext => 'Próximo';
	@override String get swipeFinger => 'Deslize o dedo';
	@override String get noMatch => 'Ninguém combina agora. Tente de novo daqui a pouco.';
}

// Path: discover.privateRoom
class _Translations$discover$privateRoom$pt extends Translations$discover$privateRoom$tr {
	_Translations$discover$privateRoom$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get subtitle => 'Esta é uma sala privada. Libere o acesso com tokens.';
	@override String get roomAccess => 'Acesso à sala';
	@override String get yourBalance => 'Seu saldo';
	@override String tokensAmount({required Object count}) => '${count} tokens';
	@override String joinForTokens({required Object count}) => 'Entrar por ${count} tokens';
	@override String get cancel => 'Cancelar';
}

// Path: discover.roomToken
class _Translations$discover$roomToken$pt extends Translations$discover$roomToken$tr {
	_Translations$discover$roomToken$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get subtitle => 'Libere o acesso com tokens.';
	@override String get roomAccess => 'Acesso à sala';
	@override String get yourBalance => 'Seu saldo';
	@override String tokensAmount({required Object count}) => '${count} tokens';
	@override String joinForTokens({required Object count}) => 'Entrar por ${count} tokens';
	@override String get cancel => 'Cancelar';
}

// Path: discover.privateRequest
class _Translations$discover$privateRequest$pt extends Translations$discover$privateRequest$tr {
	_Translations$discover$privateRequest$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pedir para entrar';
	@override String roomInfo({required Object name, required Object count}) => '${name} · ${count} membros';
	@override String get messageHint => 'Diga algo (opcional)...';
	@override String get sendRequest => 'Enviar pedido';
	@override String get adminReview => 'O admin da sala vai analisar seu pedido';
}

// Path: discover.roomApproved
class _Translations$discover$roomApproved$pt extends Translations$discover$roomApproved$tr {
	_Translations$discover$roomApproved$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Você entrou!';
	@override String subtitle({required Object name}) => 'Seu lugar em ${name} está reservado';
	@override String get continueLabel => 'Continuar';
}

// Path: discover.createSpace
class _Translations$discover$createSpace$pt extends Translations$discover$createSpace$tr {
	_Translations$discover$createSpace$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Criar sala ou grupo';
	@override String get subtitle => 'Alcance mais pessoas criando um grupo ou uma sala ao vivo';
	@override String get room => 'Sala';
	@override String get group => 'Grupo';
	@override String get hideAccount => 'Ocultar sua conta';
	@override String get create => 'Criar';
	@override String get cancel => 'Cancelar';
	@override String get createRoomTitle => 'Criar sala';
	@override String get createGroupTitle => 'Criar grupo';
	@override String get nameSubtitle => 'Dê um nome ao grupo que você criou';
	@override String get nameHint => 'Corujas da Noite';
	@override String createRoomFor({required Object count}) => 'Criar por ${count} tokens';
}

// Path: discover.liveRoom
class _Translations$discover$liveRoom$pt extends Translations$discover$liveRoom$tr {
	_Translations$discover$liveRoom$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get adminSuffix => '(Admin)';
	@override String get messageHint => 'Mensagem';
	@override String get quickReplyHey => 'Oi, pessoal!';
	@override String get quickReplyTopic => 'Qual é o assunto?';
	@override String get quickReplyNew => 'Sou novo aqui!';
	@override String get sampleChatName => 'Sona';
	@override String get sampleChatBody => 'O que a gente pode fazer? O que vocês têm em mente?';
	@override String get roomEnded => 'A sala foi encerrada.';
	@override String wantsToJoin({required Object name}) => '${name} quer entrar';
	@override String get approve => 'Aprovar';
}

// Path: discover.groupChat
class _Translations$discover$groupChat$pt extends Translations$discover$groupChat$tr {
	_Translations$discover$groupChat$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String usersCount({required Object count}) => '${count} usuários';
	@override String get sampleVictoria => 'Tô muito entediada. Bora fazer alguma coisa, galera?';
	@override String get sampleSona => 'O que a gente pode fazer? O que vocês têm em mente?';
	@override String get sampleOwn => 'Vamos nos encontrar no píer';
}

// Path: discover.groupInfo
class _Translations$discover$groupInfo$pt extends Translations$discover$groupInfo$tr {
	_Translations$discover$groupInfo$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get media => 'Mídia';
	@override String get gallery => 'Galeria';
	@override String get settings => 'Configurações';
	@override String get notifications => 'Notificações';
	@override String get blocked => 'Bloqueados';
	@override String get private => 'Privado';
	@override String membersCount({required Object count}) => '${count} membros';
	@override String get addPeople => 'Adicionar pessoas';
	@override String get you => 'Você';
	@override String get admin => 'Admin';
	@override String get leaveGroup => 'Sair do grupo';
	@override String get requests => 'Pedidos para entrar';
	@override String get approve => 'Aprovar';
	@override String get reject => 'Recusar';
	@override String get addPeopleEmpty => 'Siga pessoas para adicioná-las ao grupo.';
	@override String get add => 'Adicionar';
	@override String get makeAdmin => 'Tornar admin';
	@override String get removeAdmin => 'Remover admin';
	@override String get remove => 'Remover do grupo';
	@override String get leaveConfirm => 'Sair deste grupo?';
	@override String get leave => 'Sair';
	@override String get cancel => 'Cancelar';
}

// Path: discover.filters
class _Translations$discover$filters$pt extends Translations$discover$filters$tr {
	_Translations$discover$filters$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Filtros';
	@override String get ageRange => 'Faixa etária';
	@override String ageRangeValue({required Object min, required Object max}) => '${min}-${max}';
	@override String get distance => 'Distância';
	@override String distanceValue({required Object km}) => '${km} km';
	@override String get showMe => 'Mostrar';
	@override String get everyone => 'Todos';
	@override String get women => 'Mulheres';
	@override String get men => 'Homens';
	@override String get interests => 'Interesses';
	@override String get activeNow => 'Ativos agora';
	@override String get activeNowSubtitle => 'Mostrar só quem está online agora';
	@override String get showResult => 'Ver resultado';
}

// Path: discover.post
class _Translations$discover$post$pt extends Translations$discover$post$tr {
	_Translations$discover$post$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get follow => 'Seguir';
	@override String get following => 'Seguindo';
	@override String get addComment => 'Adicionar comentário...';
	@override String get commentsTitle => 'Comentários';
	@override String get sampleCaption => 'Nada como um cafezinho depois de um dia lindo. <3';
	@override String hoursAgo({required Object hours}) => '${hours}h';
	@override String minutesAgo({required Object minutes}) => '${minutes}min';
	@override String daysAgo({required Object days}) => '${days}d';
	@override String get deleteCommentTitle => 'Excluir este comentário?';
}

// Path: discover.story
class _Translations$discover$story$pt extends Translations$discover$story$tr {
	_Translations$discover$story$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get draft => 'RASCUNHO';
	@override String get story => 'STORY';
	@override String get share => 'Compartilhar';
	@override String get textPlaceholder => 'Escreva algo...';
	@override String get draftPrompt => 'Salvar como rascunho?';
	@override String get saveToDraft => 'Salvar rascunho';
	@override String get moveToTrash => 'Mover para a lixeira';
	@override String get save => 'Salvar';
	@override String get musicTitle => 'Música';
	@override String get musicEmpty => 'Nenhuma música encontrada.';
	@override String get musicError => 'Não foi possível carregar as músicas.';
	@override String get downloaded => 'Salvo na galeria';
	@override String get downloadFailed => 'Não foi possível salvar';
}

// Path: discover.highlight
class _Translations$discover$highlight$pt extends Translations$discover$highlight$tr {
	_Translations$discover$highlight$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Destaque';
	@override String get view => 'Ver';
	@override String get aiComments => 'Comentários da IA';
	@override String get remove => 'Remover destaque';
	@override String get sharedSuccess => 'Seu post foi compartilhado';
	@override String get boost => 'Impulsionar';
}

// Path: discover.stats
class _Translations$discover$stats$pt extends Translations$discover$stats$tr {
	_Translations$discover$stats$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Estatísticas';
	@override String get subtitle => 'As estatísticas do seu post\nestão abaixo.';
	@override String get viewers => 'Visualizações';
	@override String get comments => 'Comentários';
	@override String get likes => 'Curtidas';
	@override String get boostCta => 'Impulsionar por 1 dia - 100 tokens';
	@override String get boosted => 'Impulsionado! Seu post fica no topo por 24 horas.';
}

// Path: createProfile.interests
class _Translations$createProfile$interests$pt extends Translations$createProfile$interests$tr {
	_Translations$createProfile$interests$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get music => 'Música';
	@override String get movies => 'Filmes';
	@override String get tvShows => 'Séries';
	@override String get reading => 'Leitura';
	@override String get painting => 'Pintura';
	@override String get photography => 'Fotografia';
	@override String get theatre => 'Teatro';
	@override String get fitness => 'Academia';
	@override String get swimming => 'Natação';
	@override String get football => 'Futebol';
	@override String get basketball => 'Basquete';
	@override String get coffee => 'Café';
	@override String get travel => 'Viagens';
	@override String get camping => 'Camping';
	@override String get meditation => 'Meditação';
	@override String get videoGames => 'Videogames';
	@override String get boardGames => 'Jogos de tabuleiro';
	@override String get standUp => 'Stand-up';
	@override String get tech => 'Tecnologia';
	@override String get coding => 'Programação';
	@override String get ai => 'IA';
	@override String get podcast => 'Podcasts';
}

/// The flat map containing all translations for locale <pt>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsPt {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.name' => 'Veylo',
			'app.tagline' => 'Bem-vindo',
			'home.title' => 'Início',
			'home.subtitle' => 'O app está sendo preparado',
			'home.body' => 'A interface multilíngue é gerenciada com slang.',
			'chats.title' => 'Conversas',
			'chats.search' => 'Buscar',
			'chats.messagesSection' => 'Mensagens',
			'chats.request' => 'Solicitação',
			'chats.emptyRequestTitle' => 'Nenhuma notificação de\nmensagem recente',
			'chats.emptyRequestSubtitle' => 'Solicitações com mais de 30 dias não são exibidas.',
			'chats.noteAdd' => 'Adicionar nota',
			'chats.anonymous' => 'Anônimo',
			'chats.online' => 'online',
			'chats.offline' => 'offline',
			'chats.connection' => 'Conexão',
			'chats.connectionPercent' => ({required Object n}) => '${n}%',
			'chats.connectionProgressTitle' => 'Progresso da conexão',
			'chats.milestoneInitial' => 'Inicial do nome',
			'chats.milestoneInitialHint' => 'Desbloqueado em 25%',
			'chats.milestoneInitialLocked' => 'Desbloqueia em 25%',
			'chats.milestonePhoto' => 'Prévia da foto desfocada',
			'chats.milestonePhotoHint' => 'Desbloqueia em 70%',
			'chats.milestoneFull' => 'Perfil completo',
			'chats.milestoneFullHint' => 'Consentimento mútuo em 100%',
			'chats.sampleAnonymousMessage' => 'Oi, foi um prazer te conhecer. Pode me contar um pouco sobre você?',
			'chats.strangerSampleMessage' => 'Oi Jhon, foi um prazer te conhecer. Pode me contar um pouco sobre você?',
			'chats.approve' => 'Aprovar',
			'chats.blockUser' => 'Bloquear usuário',
			'chats.reject' => 'Recusar',
			'chats.messageHint' => 'Oi! Tudo bem?',
			'chats.revealTitle' => 'Vocês chegaram a 100%',
			'chats.revealSubtitle' => 'Revelar os perfis completos um para o outro? Os dois precisam concordar.',
			'chats.revealWaiting' => ({required Object name}) => 'Esperando ${name} aceitar',
			'chats.revealCta' => 'Revelar meu perfil',
			'chats.revealNotYet' => 'Ainda não',
			'chats.seen' => 'Visto',
			'chats.typing' => 'digitando…',
			'chats.noteYou' => 'Você',
			'chats.noteSheetTitle' => 'Compartilhe uma nota',
			'chats.noteSheetSubtitle' => 'Sua nota fica por 24 horas',
			'chats.noteHint' => 'No que você está pensando?',
			'chats.noteShare' => 'Compartilhar',
			'chats.noteDelete' => 'Excluir nota',
			'profile.eyebrow' => 'Perfil',
			'profile.title' => 'Configurações',
			'profile.editProfile' => 'Editar perfil',
			'profile.statLike' => 'Curtidas',
			'profile.statFollow' => 'Seguindo',
			'profile.statFollower' => 'Seguidores',
			'profile.promoTitle' => 'Receba mais mensagens!',
			'profile.promoSubtitle' => 'Destaque-se e apareça no topo da lista',
			'profile.standOut' => 'Destacar',
			'profile.tabPosts' => 'Posts',
			'profile.tabVideo' => 'Vídeo',
			'profile.tabSaved' => 'Salvos',
			'profile.save' => 'Salvar',
			'profile.changePhoto' => 'Trocar foto',
			'profile.changeBorder' => 'Trocar borda',
			'profile.interest' => 'Interesses',
			'profile.name' => 'Nome',
			'profile.changeName' => 'Alterar nome',
			'profile.changePassword' => 'Alterar senha',
			'profile.confirmPassword' => 'Confirmar senha',
			'profile.email' => 'E-mail',
			'profile.accountManagement' => 'Gerenciar conta',
			'profile.settingsAbout' => 'Sobre',
			'profile.settingsAccount' => 'Configurações da conta',
			'profile.settingsSupport' => 'Suporte',
			'profile.shareApp' => 'Compartilhar o app',
			'profile.shareAppTitle' => 'Compartilhe com amigos',
			'profile.shareAppSubtitle' => 'Compartilhe o Veylo com seus amigos e descubram juntos!',
			'profile.shareAppLabel' => 'Link do app',
			'profile.rateApp' => 'Gostou? Avalie a gente',
			'profile.notifications' => 'Notificações',
			'profile.password' => 'Senha',
			'profile.deleteConversation' => 'Excluir conversas',
			'profile.faqHelp' => 'Perguntas frequentes e ajuda',
			'profile.restorePurchases' => 'Restaurar compras',
			'profile.termsOfService' => 'Termos de Serviço',
			'profile.privacyPolicy' => 'Política de Privacidade',
			'profile.restorePurchasesDone' => 'Compras verificadas',
			'profile.conversationsDeleted' => 'Todas as conversas foram excluídas',
			'profile.logOut' => 'Sair',
			'profile.deleteAccountAndData' => 'Excluir conta e dados',
			'profile.passwordPlaceholder' => '********',
			'profile.height' => 'Altura',
			'profile.addHeight' => 'Adicionar altura',
			'profile.heightCm' => ({required Object value}) => '${value} cm',
			'profile.languages' => 'Idiomas',
			'profile.relationshipGoals' => 'Objetivos de relacionamento',
			'profile.lookingFor' => 'Procurando',
			'profile.newFriends' => '👋 Novas amizades',
			'profile.goalLongTermOpenToShort' => '💕 Algo sério, aberto a casual',
			'profile.goalLongTermRelationship' => '💘 Relacionamento sério',
			'profile.goalNewFriends' => '👋 Novas amizades',
			'profile.goalShortTermFun' => '🥃 Algo casual',
			'profile.goalStillFiguringItOut' => '🤔 Ainda estou descobrindo',
			'profile.basics' => 'Básico',
			'profile.zodiac' => 'Signo',
			'profile.zodiacValue' => 'Escorpião',
			'profile.education' => 'Escolaridade',
			'profile.educationValue' => 'Graduação',
			'profile.educationHighSchool' => 'Ensino médio',
			'profile.educationAssociates' => 'Curso técnico/tecnólogo',
			'profile.educationBachelors' => 'Graduação',
			'profile.educationMasters' => 'Mestrado',
			'profile.educationPhd' => 'Doutorado',
			'profile.voiceRecord' => 'Gravação de voz',
			'profile.addVoice' => 'Adicionar voz',
			'profile.lifestyle' => 'Estilo de vida',
			'profile.pets' => 'Pets',
			'profile.petsValue' => 'Tenho gato',
			'profile.petsDontWant' => 'Não quero pets',
			'profile.petsAllergic' => 'Tenho alergia a pets',
			'profile.petsHaveCat' => 'Tenho gato',
			'profile.petsHaveDog' => 'Tenho cachorro',
			'profile.petsHaveCatsAndDogs' => 'Tenho gatos e cachorros',
			'profile.petsHaveOther' => 'Tenho outros pets',
			'profile.drinking' => 'Bebida',
			'profile.drinkingValue' => 'Em ocasiões especiais',
			'profile.drinkingNever' => 'Nunca',
			'profile.drinkingSpecialOccasions' => 'Em ocasiões especiais',
			'profile.drinkingSocially' => 'Socialmente',
			'profile.drinkingFrequently' => 'Com frequência',
			'profile.drinkingSober' => 'Sóbrio',
			'profile.drinkingPreferNotToSay' => 'Prefiro não dizer',
			'profile.smoking' => 'Cigarro',
			'profile.smokingValue' => 'Não fumante',
			'profile.smokingNonSmoker' => 'Não fumante',
			'profile.smokingSocialSmoker' => 'Fumo socialmente',
			'profile.smokingSmoker' => 'Fumante',
			'profile.smokingTryingToQuit' => 'Tentando parar',
			'profile.smokingWhenDrinking' => 'Fumo quando bebo',
			'profile.smokingPreferNotToSay' => 'Prefiro não dizer',
			'profile.gender' => 'Gênero',
			'profile.genderFemale' => 'Feminino',
			'profile.genderMale' => 'Masculino',
			'profile.genderPreferNotToSay' => 'Prefiro não informar',
			'profile.visible' => 'Visível',
			'profile.profileVisibility' => 'Visibilidade do perfil',
			'profile.language' => 'Idioma',
			'profile.borderTitle' => 'Borda do perfil',
			'profile.borderSubtitle' => 'Adicione uma borda ao seu perfil para\nse destacar.',
			'profile.borderBuySection' => 'Comprar uma borda',
			'profile.borderBuyCta' => 'Comprar borda',
			'profile.borderToken' => ({required Object count}) => '${count} Tokens',
			'profile.borderAmethystWings' => 'Amethyst Wings',
			'profile.borderGoldenPhoenix' => 'Golden Phoenix',
			'profile.borderFrostCrown' => 'Frost Crown',
			'profile.borderEmeraldWhisper' => 'Emerald Whisper',
			'profile.borderRoseQuartz' => 'Rose Quartz',
			'profile.borderStarlitComet' => 'Starlit Comet',
			'profile.borderCrimsonRoyal' => 'Crimson Royal',
			'profile.borderSapphireHalo' => 'Sapphire Halo',
			'profile.follow' => 'Seguir',
			'profile.following' => 'Seguindo',
			'profile.followPageTitle' => 'Seguir',
			'profile.followTabFollowing' => 'Seguindo',
			'profile.followTabFollowers' => 'Seguidores',
			'profile.followSearch' => 'Buscar',
			'profile.unfollow' => 'Deixar de seguir',
			'profile.followSortTitle' => 'Ordenar',
			'profile.followSortRecent' => 'Quem eu segui mais recentemente',
			'profile.followSortNotFollowingMe' => 'Quem não me segue de volta',
			'profile.followSortNotFollowedByMe' => 'Quem eu não sigo de volta',
			'profile.followSortShowResult' => 'Ver resultado',
			'profile.followSortEmpty' => 'Nenhum usuário corresponde a este filtro',
			'profile.shareTitle' => 'Compartilhe com amigos',
			'profile.shareSubtitle' => 'Tudo fica mais divertido quando você se\nconecta com seus amigos!',
			'profile.shareProfileLabel' => 'Compartilhar o perfil',
			'profile.shareLinkCopied' => 'Link copiado',
			'profile.restrict' => 'Restringir',
			'profile.block' => 'Bloquear',
			'profile.report' => 'Denunciar',
			'profile.blockTitle' => ({required Object username}) => 'Bloquear ${username}?',
			'profile.blockBody' => 'Isso também vai bloquear outras contas que a pessoa tenha ou venha a criar. Você pode desbloquear quando quiser.',
			'profile.blockAndReport' => 'Bloquear e denunciar',
			'profile.restrictTitle' => ({required Object username}) => 'Restringir ${username}?',
			'profile.restrictBody' => 'A pessoa não vai ver quando você está online nem se você leu as mensagens dela. Você pode mudar isso quando quiser.',
			'profile.restrictAndReport' => 'Restringir e denunciar',
			'profile.reportTitle' => 'Queremos saber o motivo',
			'profile.reportSubtitle' => 'Para melhorar sua experiência, pode nos contar por que quer denunciar este usuário?',
			'profile.reportMessageLabel' => 'Mensagem da denúncia',
			'profile.reportMessageHint' => 'Digite sua mensagem',
			'profile.reportCancel' => 'Cancelar',
			'profile.sendReport' => 'Enviar denúncia',
			'profile.notSet' => 'Não definido',
			'profile.reportSent' => 'Obrigado, recebemos sua denúncia.',
			'profile.emailVerificationSent' => ({required Object email}) => 'Enviamos um link de confirmação para ${email}. Seu e-mail muda depois que você confirmar.',
			'profile.passwordChanged' => 'Sua senha foi atualizada.',
			'profile.passwordMismatch' => 'As senhas não coincidem.',
			'nav.discover' => 'Descobrir',
			'nav.chat' => 'Chat',
			'nav.call' => 'Chamada',
			'nav.vibes' => 'Vibes',
			'nav.profile' => 'Perfil',
			'call.title' => 'Estranho em 60 segundos',
			'call.subtitle' => 'Converse com um estranho aleatório por 60 segundos — totalmente anônimo. Sem perfil, sem foto, sem nome. Só uma voz e um momento.',
			'call.findingTitle' => 'Procurando um estranho...',
			'call.findingSubtitle' => 'Vocês vão conversar anonimamente por 60 segundos. Sem perfil, sem nomes.',
			'call.callStranger' => 'Ligar para estranho - 10 Tokens',
			'call.cancel' => 'Cancelar',
			'call.female' => 'Feminino',
			'call.male' => 'Masculino',
			'call.nonBinary' => 'Não binário',
			'call.preferNotToSay' => 'Prefiro não dizer',
			'call.anonymousBadge' => '🎙️ Chamada de voz anônima',
			'call.stranger' => 'Estranho',
			'call.secondsLeft' => ({required Object n}) => '${n}s',
			'call.timesUpTitle' => 'Acabou o tempo!',
			'call.timesUpSubtitle' => 'Quer continuar conversando? Se os dois disserem sim, o chat é liberado.',
			'call.keepTalking' => 'Continuar',
			'call.endCall' => 'Encerrar',
			'call.waitingOther' => 'Esperando a outra pessoa...',
			'call.callStrangerFree' => 'Ligar para estranho',
			'call.peerLeft' => 'A outra pessoa encerrou a chamada.',
			'call.noKeep' => 'O chat não foi liberado desta vez.',
			'call.videoWaiting' => 'Esperando aceitarem a chamada de vídeo...',
			'call.videoDeclined' => 'A chamada de vídeo foi recusada.',
			'call.micDenied' => 'As chamadas precisam de acesso ao microfone. Você pode ativar nos Ajustes.',
			'call.videoCost' => 'Chamada de vídeo: 20 tokens / 15 min',
			'call.calling' => 'Chamando',
			'call.accept' => 'Aceitar',
			'call.decline' => 'Recusar',
			'call.switchToVideo' => 'Quer mudar para uma chamada de vídeo?',
			'vibes.search' => 'Buscar',
			'vibes.sendMessage' => 'Enviar mensagem',
			'vibes.wantsToTalk' => 'Quer falar sobre isso agora',
			'vibes.shareTitle' => 'Compartilhar Vibe',
			'vibes.replyTitle' => 'Responder Vibe',
			'vibes.shareHint' => 'Escreva algo',
			'vibes.shareAnonymous' => 'Compartilhar anonimamente',
			'vibes.empty' => 'Nenhuma vibe nas últimas 24 horas. Compartilhe a primeira!',
			'vibes.deleteTitle' => 'Excluir esta vibe?',
			'vibes.delete' => 'Excluir',
			'vibes.cancel' => 'Cancelar',
			'discover.title' => 'Descobrir',
			'discover.tabRooms' => 'Salas',
			'discover.tabDiscover' => 'Descobrir',
			'discover.tabAiMatch' => 'AI Match',
			'discover.aiMatch.feelingTitle' => 'Como você está se sentindo hoje',
			'discover.aiMatch.feelingSubtitle' => 'A IA encontra o melhor match com base na sua escolha',
			'discover.aiMatch.lookingTitle' => 'O que você está procurando?',
			'discover.aiMatch.moodSad' => 'Triste',
			'discover.aiMatch.moodMeltie' => 'Mais ou menos',
			'discover.aiMatch.moodBored' => 'Entediado',
			'discover.aiMatch.moodCrying' => 'Pra baixo',
			'discover.aiMatch.moodSmile' => 'Feliz',
			'discover.aiMatch.lookingNewFriends' => 'Novas amizades',
			'discover.aiMatch.lookingVenting' => 'Desabafar',
			'discover.aiMatch.lookingFlirty' => 'Paquera',
			'discover.aiMatch.lookingFun' => 'Diversão',
			'discover.aiMatch.lookingCultures' => 'Novas culturas',
			'discover.aiMatch.lookingLanguage' => 'Praticar idiomas',
			'discover.aiMatch.statActiveUsers' => 'Usuários ativos',
			'discover.aiMatch.statMatchRate' => 'Taxa de match',
			'discover.aiMatch.statAvgTime' => 'Tempo médio',
			'discover.aiMatch.statActiveValue' => '843',
			'discover.aiMatch.statMatchValue' => '87%',
			'discover.aiMatch.statAvgValue' => '8s',
			'discover.aiMatch.startSmartMatch' => 'Iniciar Smart Match',
			'discover.aiMatch.findingTitle' => 'Procurando seu match',
			'discover.aiMatch.findingSubtitle' => 'Combinando seu humor e interesses com a pessoa certa',
			'discover.aiMatch.findingStepMood' => 'Humor analisado',
			'discover.aiMatch.findingStepInterests' => 'Interesses combinados',
			'discover.aiMatch.findingStepCompatibility' => 'Calculando compatibilidade...',
			'discover.aiMatch.findingStepContent' => 'Criando conteúdo...',
			'discover.aiMatch.findingOnline' => ({required Object count}) => '${count} pessoas online agora',
			'discover.aiMatch.yourMatchTitle' => 'Seu match',
			'discover.aiMatch.yourMatchSubtitle' => 'Seu match foi feito com base nas suas respostas',
			'discover.aiMatch.vibeMatch' => ({required Object percent}) => '${percent}% de sintonia',
			'discover.aiMatch.startChatting' => 'Começar a conversar',
			'discover.aiMatch.matchNameAge' => ({required Object name, required Object age}) => '${name}, ${age}',
			'discover.aiMatch.matchBio' => 'Vou te fazer sentir coisas que você nem sabia que podia sentir.',
			'discover.aiMatch.swipePrevious' => 'Anterior',
			'discover.aiMatch.swipeNext' => 'Próximo',
			'discover.aiMatch.swipeFinger' => 'Deslize o dedo',
			'discover.aiMatch.noMatch' => 'Ninguém combina agora. Tente de novo daqui a pouco.',
			'discover.searchHint' => 'Buscar',
			'discover.allRooms' => 'Todas as salas',
			'discover.allGroups' => 'Todos os grupos',
			'discover.seeAll' => 'Ver tudo',
			'discover.live' => 'Ao vivo',
			'discover.join' => 'Entrar',
			'discover.request' => 'Solicitar',
			'discover.requested' => 'Solicitado',
			'discover.private' => 'Privado',
			'discover.moreCount' => ({required Object count}) => '+${count} mais',
			'discover.activeCount' => ({required Object count}) => '${count} ativos',
			'discover.membersCount' => ({required Object count}) => '${count} membros',
			'discover.privateRoom.subtitle' => 'Esta é uma sala privada. Libere o acesso com tokens.',
			'discover.privateRoom.roomAccess' => 'Acesso à sala',
			'discover.privateRoom.yourBalance' => 'Seu saldo',
			'discover.privateRoom.tokensAmount' => ({required Object count}) => '${count} tokens',
			'discover.privateRoom.joinForTokens' => ({required Object count}) => 'Entrar por ${count} tokens',
			'discover.privateRoom.cancel' => 'Cancelar',
			'discover.roomToken.subtitle' => 'Libere o acesso com tokens.',
			'discover.roomToken.roomAccess' => 'Acesso à sala',
			'discover.roomToken.yourBalance' => 'Seu saldo',
			'discover.roomToken.tokensAmount' => ({required Object count}) => '${count} tokens',
			'discover.roomToken.joinForTokens' => ({required Object count}) => 'Entrar por ${count} tokens',
			'discover.roomToken.cancel' => 'Cancelar',
			'discover.privateRequest.title' => 'Pedir para entrar',
			'discover.privateRequest.roomInfo' => ({required Object name, required Object count}) => '${name} · ${count} membros',
			'discover.privateRequest.messageHint' => 'Diga algo (opcional)...',
			'discover.privateRequest.sendRequest' => 'Enviar pedido',
			'discover.privateRequest.adminReview' => 'O admin da sala vai analisar seu pedido',
			'discover.roomApproved.title' => 'Você entrou!',
			'discover.roomApproved.subtitle' => ({required Object name}) => 'Seu lugar em ${name} está reservado',
			'discover.roomApproved.continueLabel' => 'Continuar',
			'discover.createSpace.title' => 'Criar sala ou grupo',
			'discover.createSpace.subtitle' => 'Alcance mais pessoas criando um grupo ou uma sala ao vivo',
			'discover.createSpace.room' => 'Sala',
			'discover.createSpace.group' => 'Grupo',
			'discover.createSpace.hideAccount' => 'Ocultar sua conta',
			'discover.createSpace.create' => 'Criar',
			'discover.createSpace.cancel' => 'Cancelar',
			'discover.createSpace.createRoomTitle' => 'Criar sala',
			'discover.createSpace.createGroupTitle' => 'Criar grupo',
			'discover.createSpace.nameSubtitle' => 'Dê um nome ao grupo que você criou',
			'discover.createSpace.nameHint' => 'Corujas da Noite',
			'discover.createSpace.createRoomFor' => ({required Object count}) => 'Criar por ${count} tokens',
			'discover.liveRoom.adminSuffix' => '(Admin)',
			'discover.liveRoom.messageHint' => 'Mensagem',
			'discover.liveRoom.quickReplyHey' => 'Oi, pessoal!',
			'discover.liveRoom.quickReplyTopic' => 'Qual é o assunto?',
			'discover.liveRoom.quickReplyNew' => 'Sou novo aqui!',
			'discover.liveRoom.sampleChatName' => 'Sona',
			'discover.liveRoom.sampleChatBody' => 'O que a gente pode fazer? O que vocês têm em mente?',
			'discover.liveRoom.roomEnded' => 'A sala foi encerrada.',
			'discover.liveRoom.wantsToJoin' => ({required Object name}) => '${name} quer entrar',
			'discover.liveRoom.approve' => 'Aprovar',
			'discover.groupChat.usersCount' => ({required Object count}) => '${count} usuários',
			'discover.groupChat.sampleVictoria' => 'Tô muito entediada. Bora fazer alguma coisa, galera?',
			'discover.groupChat.sampleSona' => 'O que a gente pode fazer? O que vocês têm em mente?',
			'discover.groupChat.sampleOwn' => 'Vamos nos encontrar no píer',
			'discover.groupInfo.media' => 'Mídia',
			'discover.groupInfo.gallery' => 'Galeria',
			'discover.groupInfo.settings' => 'Configurações',
			'discover.groupInfo.notifications' => 'Notificações',
			'discover.groupInfo.blocked' => 'Bloqueados',
			'discover.groupInfo.private' => 'Privado',
			'discover.groupInfo.membersCount' => ({required Object count}) => '${count} membros',
			'discover.groupInfo.addPeople' => 'Adicionar pessoas',
			'discover.groupInfo.you' => 'Você',
			'discover.groupInfo.admin' => 'Admin',
			'discover.groupInfo.leaveGroup' => 'Sair do grupo',
			'discover.groupInfo.requests' => 'Pedidos para entrar',
			'discover.groupInfo.approve' => 'Aprovar',
			'discover.groupInfo.reject' => 'Recusar',
			'discover.groupInfo.addPeopleEmpty' => 'Siga pessoas para adicioná-las ao grupo.',
			'discover.groupInfo.add' => 'Adicionar',
			'discover.groupInfo.makeAdmin' => 'Tornar admin',
			'discover.groupInfo.removeAdmin' => 'Remover admin',
			'discover.groupInfo.remove' => 'Remover do grupo',
			'discover.groupInfo.leaveConfirm' => 'Sair deste grupo?',
			'discover.groupInfo.leave' => 'Sair',
			'discover.groupInfo.cancel' => 'Cancelar',
			'discover.filters.title' => 'Filtros',
			'discover.filters.ageRange' => 'Faixa etária',
			'discover.filters.ageRangeValue' => ({required Object min, required Object max}) => '${min}-${max}',
			'discover.filters.distance' => 'Distância',
			'discover.filters.distanceValue' => ({required Object km}) => '${km} km',
			'discover.filters.showMe' => 'Mostrar',
			'discover.filters.everyone' => 'Todos',
			'discover.filters.women' => 'Mulheres',
			'discover.filters.men' => 'Homens',
			'discover.filters.interests' => 'Interesses',
			'discover.filters.activeNow' => 'Ativos agora',
			'discover.filters.activeNowSubtitle' => 'Mostrar só quem está online agora',
			'discover.filters.showResult' => 'Ver resultado',
			'discover.post.follow' => 'Seguir',
			'discover.post.following' => 'Seguindo',
			'discover.post.addComment' => 'Adicionar comentário...',
			'discover.post.commentsTitle' => 'Comentários',
			'discover.post.sampleCaption' => 'Nada como um cafezinho depois de um dia lindo. <3',
			'discover.post.hoursAgo' => ({required Object hours}) => '${hours}h',
			'discover.post.minutesAgo' => ({required Object minutes}) => '${minutes}min',
			'discover.post.daysAgo' => ({required Object days}) => '${days}d',
			'discover.post.deleteCommentTitle' => 'Excluir este comentário?',
			'discover.story.draft' => 'RASCUNHO',
			'discover.story.story' => 'STORY',
			'discover.story.share' => 'Compartilhar',
			'discover.story.textPlaceholder' => 'Escreva algo...',
			'discover.story.draftPrompt' => 'Salvar como rascunho?',
			'discover.story.saveToDraft' => 'Salvar rascunho',
			'discover.story.moveToTrash' => 'Mover para a lixeira',
			'discover.story.save' => 'Salvar',
			'discover.story.musicTitle' => 'Música',
			'discover.story.musicEmpty' => 'Nenhuma música encontrada.',
			'discover.story.musicError' => 'Não foi possível carregar as músicas.',
			'discover.story.downloaded' => 'Salvo na galeria',
			'discover.story.downloadFailed' => 'Não foi possível salvar',
			'discover.highlight.title' => 'Destaque',
			'discover.highlight.view' => 'Ver',
			'discover.highlight.aiComments' => 'Comentários da IA',
			'discover.highlight.remove' => 'Remover destaque',
			'discover.highlight.sharedSuccess' => 'Seu post foi compartilhado',
			'discover.highlight.boost' => 'Impulsionar',
			'discover.stats.title' => 'Estatísticas',
			'discover.stats.subtitle' => 'As estatísticas do seu post\nestão abaixo.',
			'discover.stats.viewers' => 'Visualizações',
			'discover.stats.comments' => 'Comentários',
			'discover.stats.likes' => 'Curtidas',
			'discover.stats.boostCta' => 'Impulsionar por 1 dia - 100 tokens',
			'discover.stats.boosted' => 'Impulsionado! Seu post fica no topo por 24 horas.',
			'discover.hostedBy' => ({required Object name}) => 'Apresentado por ${name}',
			'common.loading' => 'Carregando…',
			'common.retry' => 'Tentar de novo',
			'common.cancel' => 'Cancelar',
			'common.save' => 'Salvar',
			'common.continueAction' => 'Continuar',
			'common.language' => 'Idioma',
			'common.or' => 'OU',
			'languages.tr' => 'Türkçe',
			'languages.en' => 'English',
			'auth.createAccountTitle' => 'Crie sua conta',
			'auth.createAccountSubtitle' => 'Entre no Veylo e comece a se conectar.',
			'auth.welcomeBackTitle' => 'Bem-vindo de volta',
			'auth.welcomeBackSubtitle' => 'Entre para continuar no Veylo.',
			'auth.username' => 'Nome de usuário',
			'auth.usernameHint' => 'Escolha um nome de usuário',
			'auth.email' => 'E-mail',
			'auth.emailHint' => 'Digite seu e-mail',
			'auth.emailOrUsername' => 'E-mail ou nome de usuário',
			'auth.emailOrUsernameHint' => 'Digite seu e-mail ou usuário',
			'auth.password' => 'Senha',
			'auth.passwordCreateHint' => 'Crie uma senha',
			'auth.passwordEnterHint' => 'Digite sua senha',
			'auth.signUp' => 'Cadastrar',
			'auth.logIn' => 'Entrar',
			'auth.forgotPassword' => 'Esqueceu a senha?',
			'auth.continueWithApple' => 'Continuar com Apple',
			'auth.continueWithGoogle' => 'Continuar com Google',
			'auth.legalPrefix' => 'Ao continuar, você concorda com nossos ',
			'auth.termsOfService' => 'Termos de Serviço',
			'auth.legalMiddle' => ' e reconhece nossa ',
			'auth.privacyPolicy' => 'Política de Privacidade',
			'auth.legalSuffix' => '.',
			'auth.passwordResetSent' => 'Enviamos um link para redefinir a senha para seu e-mail.',
			'onboarding.skip' => 'Pular',
			'onboarding.page1Title' => 'Seja você. Fique anônimo.',
			'onboarding.page1Subtitle' => 'Conheça gente nova e comece conversas\nsem revelar quem você é.',
			'onboarding.page2Title' => 'Escreva. Fale. Sinta a vibe.',
			'onboarding.page2Subtitle' => 'Comece no anonimato e depois troque mensagens, ligue ou se veja cara a cara quando quiser.',
			'onboarding.page3Title' => 'Encontre sua turma. Entre\nna conversa.',
			'onboarding.page3Subtitle' => 'Entre em salas, conheça gente nova e\ncompartilhe o momento juntos.',
			'onboarding.getStarted' => 'Começar',
			'onboarding.alreadyHaveAccount' => 'Já tem uma conta Veylo? ',
			'onboarding.logInAction' => 'Entrar',
			'createProfile.navTitle' => 'Criar perfil',
			'createProfile.stepUsername' => '1/5 Nome de usuário',
			'createProfile.title' => 'Crie seu perfil',
			'createProfile.subtitle' => 'Seu nome real só é usado para verificação — ele não aparece publicamente.',
			'createProfile.subtitleLine1' => 'Seu nome real só é usado para verificação —',
			'createProfile.subtitleLine2' => 'ele não aparece publicamente.',
			'createProfile.fullName' => 'Nome completo',
			'createProfile.fullNameHint' => 'Sam Lee',
			'createProfile.username' => 'Nome de usuário',
			'createProfile.usernameHint' => 'samlee123',
			'createProfile.usernameTaken' => 'Este nome de usuário já existe!',
			'createProfile.usernameAvailable' => 'Nome de usuário disponível',
			'createProfile.mightWantToTry' => 'Que tal tentar...',
			'createProfile.stepPhoto' => '2/5 Foto de perfil',
			'createProfile.photoTitle' => 'Envie uma foto de perfil',
			'createProfile.photoSubtitle' => 'Outros usuários podem ver sua foto de perfil para saber que é você.',
			'createProfile.photoSubtitleLine1' => 'Outros usuários podem ver sua foto de perfil',
			'createProfile.photoSubtitleLine2' => 'para saber que é você.',
			'createProfile.choosePhoto' => 'Escolher uma foto',
			'createProfile.continueWithoutPhoto' => 'Continuar sem foto de perfil',
			'createProfile.saveAndContinue' => 'Salvar e continuar',
			'createProfile.choosePhotoSheetTitle' => 'Escolher uma foto',
			'createProfile.takePhoto' => 'Tirar foto',
			'createProfile.chooseFromGallery' => 'Escolher da galeria',
			'createProfile.stepGender' => '3/5 Gênero',
			'createProfile.genderTitle' => 'Escolha seu gênero',
			'createProfile.genderSubtitle' => 'Se você optar por nos informar, podemos usar isso para personalizar o conteúdo para você',
			'createProfile.genderSubtitleLine1' => 'Se você optar por nos informar, podemos usar',
			'createProfile.genderSubtitleLine2' => 'isso para personalizar o conteúdo para você',
			'createProfile.genderFemale' => 'Feminino',
			'createProfile.genderMale' => 'Masculino',
			'createProfile.genderNonBinary' => 'Não binário',
			'createProfile.genderPreferNotToSay' => 'Prefiro não dizer',
			'createProfile.stepInterests' => '4/5 Interesses',
			'createProfile.interestsTitle' => 'Do que você curte?',
			'createProfile.interestsSubtitle' => 'Escolha pelo menos 5 — isso ajuda a te conectar com pessoas que realmente te entendem.',
			'createProfile.interests.music' => 'Música',
			'createProfile.interests.movies' => 'Filmes',
			'createProfile.interests.tvShows' => 'Séries',
			'createProfile.interests.reading' => 'Leitura',
			'createProfile.interests.painting' => 'Pintura',
			'createProfile.interests.photography' => 'Fotografia',
			'createProfile.interests.theatre' => 'Teatro',
			'createProfile.interests.fitness' => 'Academia',
			'createProfile.interests.swimming' => 'Natação',
			'createProfile.interests.football' => 'Futebol',
			'createProfile.interests.basketball' => 'Basquete',
			'createProfile.interests.coffee' => 'Café',
			'createProfile.interests.travel' => 'Viagens',
			'createProfile.interests.camping' => 'Camping',
			'createProfile.interests.meditation' => 'Meditação',
			'createProfile.interests.videoGames' => 'Videogames',
			'createProfile.interests.boardGames' => 'Jogos de tabuleiro',
			'createProfile.interests.standUp' => 'Stand-up',
			'createProfile.interests.tech' => 'Tecnologia',
			'createProfile.interests.coding' => 'Programação',
			'createProfile.interests.ai' => 'IA',
			'createProfile.interests.podcast' => 'Podcasts',
			'createProfile.stepChatGoal' => '5/5 Objetivo do chat',
			'createProfile.chatGoalTitle' => 'O que você procura hoje?',
			'createProfile.chatGoalSubtitle' => 'Isso ajuda a encontrar o match certo para o seu humor agora.',
			_ => null,
		} ?? switch (path) {
			'createProfile.chatGoalQuickMatch' => 'Match rápido — entre direto numa\nconversa',
			'createProfile.chatGoalFlirtyChat' => 'Paquera — conversas leves e\ndivertidas',
			'createProfile.chatGoalMoodMatch' => 'Match de humor — combine pelo que você\nestá sentindo',
			'createProfile.chatGoalLateNight' => 'Papo de madrugada — conversas profundas\nenquanto o mundo dorme',
			'createProfile.chatGoalMeetSomeoneNew' => 'Conhecer alguém novo — sem objetivo, só\nexplorar',
			'createProfile.getStarted' => 'Começar',
			'createProfile.preparingTitleLine1' => 'Estamos preparando',
			'createProfile.preparingTitleLine2' => 'perfis ideais para',
			'createProfile.preparingTitleLine3' => 'você.',
			'createProfile.preparingSubtitleLine1' => 'Com base nas suas respostas, estamos escolhendo',
			'createProfile.preparingSubtitleLine2' => 'os melhores matches — aguarde um momento.',
			'createProfile.preparingPercent' => ({required Object percent}) => '%${percent}',
			'createProfile.usernameInvalid' => 'Use de 3 a 30 letras, números, pontos ou sublinhados.',
			'errors.network' => 'Não foi possível conectar ao Veylo. Verifique sua conexão e tente de novo.',
			'errors.generic' => 'Algo deu errado. Tente de novo.',
			'errors.signInFailed' => 'Falha ao entrar. Tente de novo.',
			'errors.sessionExpired' => 'Sua sessão expirou. Entre novamente.',
			'errors.accountSuspended' => 'Esta conta foi suspensa.',
			'errors.unsupportedImage' => 'Escolha uma foto JPEG, PNG ou WebP.',
			'errors.fileTooLarge' => 'Este arquivo é grande demais.',
			'errors.enterEmailForReset' => 'Digite seu e-mail acima para redefinir a senha.',
			'errors.wrongCredentials' => 'E-mail/usuário ou senha incorretos.',
			'errors.emailInUse' => 'Este e-mail já está cadastrado. Tente entrar.',
			'errors.weakPassword' => 'A senha precisa ter pelo menos 6 caracteres.',
			'errors.invalidEmail' => 'Digite um endereço de e-mail válido.',
			'errors.tooManyAttempts' => 'Muitas tentativas. Espere um pouco e tente de novo.',
			'errors.fillAllFields' => 'Preencha todos os campos.',
			'errors.insufficientTokens' => 'Tokens insuficientes.',
			'errors.requestNotAccepted' => 'Aceite a solicitação para responder.',
			'errors.requestPendingLimit' => 'Você poderá enviar mais mensagens depois que aceitarem sua solicitação.',
			'errors.blocked' => 'Você não pode enviar mensagens para esta pessoa.',
			'errors.peerUnavailable' => 'Esta conta não está mais disponível.',
			'errors.vibeDailyLimit' => 'Você já compartilhou muitas vibes hoje. Tente mais tarde.',
			'errors.groupFull' => 'Este grupo está cheio.',
			'errors.groupCreateLimit' => 'Você criou grupos demais hoje. Tente mais tarde.',
			'errors.notFound' => 'Isto não está mais disponível.',
			'errors.recentLogin' => 'Por segurança, saia e entre de novo, depois tente outra vez.',
			'errors.socialAccount' => 'Seu e-mail e senha são gerenciados pela sua conta Google ou Apple.',
			'errors.alreadyInCall' => 'Você já está em uma chamada.',
			'errors.roomPrivate' => 'Esta sala é privada. Peça ao anfitrião para entrar.',
			'errors.roomFull' => 'Esta sala está cheia.',
			'faq.q1' => 'Como o app funciona?',
			'faq.q2' => 'O que é o chat anônimo?',
			'faq.q3' => 'O que é o Progresso da conexão?',
			'faq.q4' => 'Como revelo meu perfil?',
			'faq.q5' => 'O que é o Estranho em 60 segundos?',
			'faq.q6' => 'O que são Vibes?',
			'faq.q7' => 'Como edito meu perfil?',
			'faq.q8' => 'Como gerencio as notificações?',
			'faq.q9' => 'Como restauro compras?',
			'faq.q10' => 'Posso excluir todas as conversas?',
			'faq.q11' => 'Meus dados estão seguros?',
			'faq.q12' => 'Como bloqueio ou denuncio alguém?',
			'faq.q13' => 'Como compartilho o app?',
			'faq.q14' => 'Como excluo minha conta?',
			'faq.a1' => 'No Veylo você conhece gente nova de forma anônima, conversa e revela seu perfil aos poucos conforme a conexão cresce. Passe para mensagens, voz ou cara a cara quando os dois se sentirem prontos.',
			'faq.a2' => 'No chat anônimo, sua identidade e sua foto ficam ocultas. Conforme a conexão aumenta, você desbloqueia detalhes como a inicial do nome e uma foto desfocada. Em 100%, os dois precisam concordar para revelar os perfis completos.',
			'faq.a3' => 'Conforme vocês conversam, a porcentagem de conexão cresce. Em certos marcos você desbloqueia a inicial do nome, uma foto desfocada e o perfil completo. Toque no selo Conexão para ver os detalhes.',
			'faq.a4' => 'Quando a conexão chegar a 100%, toque em Revelar meu perfil. Se a outra pessoa também aceitar, os dois perfis completos ficam visíveis.',
			'faq.a5' => 'Na aba Chamada você pode fazer um match aleatório rápido. Quando o tempo acabar, você pode continuar conversando ou encerrar a chamada.',
			'faq.a6' => 'Vibes permite descobrir pessoas por perto em um mapa ou lista e começar um chat com quem te interessar.',
			'faq.a7' => 'Abra a aba Perfil e vá em Editar perfil para atualizar nome, fotos, bio e interesses. As mudanças aparecem depois que você salva.',
			'faq.a8' => 'Abra Notificações em Configurações para ativar ou desativar alertas de mensagens, matches e outros.',
			'faq.a9' => 'Vá em Configurações → Gerenciar conta → Restaurar compras. As compras elegíveis na mesma conta da loja serão restauradas.',
			'faq.a10' => 'Sim. Use Configurações → Excluir conversas e confirme. Todos os chats serão removidos. Isso não pode ser desfeito.',
			'faq.a11' => 'Os dados da sua conta e suas mensagens ficam em sistemas protegidos. Você também pode pedir a exclusão da conta e dos dados em Gerenciar conta quando quiser.',
			'faq.a12' => 'Use o menu em um perfil ou na tela do chat para bloquear ou denunciar. As denúncias são analisadas pela nossa equipe.',
			'faq.a13' => 'Use Compartilhar o app em Configurações para copiar o link e enviar para seus amigos.',
			'faq.a14' => 'Vá em Configurações → Gerenciar conta → Excluir conta e dados. Depois de informar um motivo, confirme para enviar seu pedido de exclusão.',
			'legal.termsTitle' => 'Termos de Serviço',
			'legal.privacyTitle' => 'Política de Privacidade',
			'legal.termsBody' => 'Última atualização: 16 de março de 2026\n\nBem-vindo ao Veylo. Ao criar uma conta ou usar o app, você concorda com estes Termos de Serviço.\n\n1. O que é o Veylo\nO Veylo é um app social onde você pode conhecer pessoas, conversar anonimamente, criar conexão ao longo do tempo e, se quiser, passar para chamadas de voz ou cara a cara quando os dois lados concordarem.\n\n2. Sua conta\nVocê deve fornecer informações corretas e manter seu login seguro. Você é responsável pela atividade na sua conta. Você deve ter idade suficiente para usar o Veylo de acordo com as leis do seu país.\n\n3. Uso respeitoso\nNão assedie, ameace, aplique golpes, se passe por outras pessoas, compartilhe conteúdo ilegal nem tente burlar os recursos de segurança. Podemos remover conteúdo, limitar recursos ou suspender contas que violem estas regras.\n\n4. Chat anônimo e revelação do perfil\nChats anônimos podem ocultar seu nome e sua foto até que os marcos de conexão sejam atingidos. A revelação do perfil completo exige consentimento mútuo. Não pressione outras pessoas a revelar a identidade.\n\n5. Compras\nAlguns recursos podem ser pagos. As compras são processadas pela Apple App Store ou pelo Google Play. Restaurar compras recupera compras elegíveis na mesma conta da loja. Reembolsos seguem a política da loja.\n\n6. Conteúdo que você compartilha\nVocê mantém os direitos sobre seu conteúdo, mas concede ao Veylo uma licença para hospedá-lo e exibi-lo no app conforme necessário para operar o serviço. Não publique conteúdo que você não tenha direito de compartilhar.\n\n7. Encerramento do uso\nVocê pode parar de usar o Veylo a qualquer momento e pedir a exclusão da conta em Configurações. Também podemos encerrar ou alterar o serviço com aviso razoável quando necessário.\n\n8. Contato\nDúvidas sobre estes termos: support@veylo.app',
			'legal.privacyBody' => 'Última atualização: 16 de março de 2026\n\nEsta Política de Privacidade explica como o Veylo coleta, usa e protege suas informações.\n\n1. Informações que coletamos\n• Dados da conta: e-mail, nome de exibição, fotos de perfil, bio, preferências\n• Dados de uso: chats, progresso da conexão, recursos de chamada que você usa, informações básicas do dispositivo/app\n• Compras: dados de recibo da loja necessários para liberar e restaurar recursos pagos\n\n2. Como usamos\nUsamos seus dados para operar o Veylo, personalizar os matches e a experiência de chat, manter a comunidade segura, processar compras e melhorar o produto. Não vendemos seus dados pessoais.\n\n3. Modo anônimo\nNos chats anônimos, limitamos o que os outros veem (por exemplo, nome mascarado ou foto desfocada) até que as regras de desbloqueio e o consentimento mútuo permitam mais. Nos bastidores, ainda precisamos de identificadores da conta para operar o recurso com segurança.\n\n4. Compartilhamento\nPodemos compartilhar dados com prestadores de serviço que nos ajudam com hospedagem, análise ou processamento de pagamentos — apenas quando necessário. Também podemos divulgar informações se exigido por lei ou para proteger usuários de danos.\n\n5. Retenção\nMantemos os dados enquanto sua conta estiver ativa e conforme necessário por motivos legais, de segurança e de cobrança. Depois que um pedido de exclusão é concluído, removemos ou anonimizamos os dados pessoais, exceto quando a retenção for obrigatória.\n\n6. Suas escolhas\nVocê pode editar as informações do perfil, gerenciar notificações, pedir a exclusão da conta e entrar em contato conosco sobre seus dados. As compras na loja também são gerenciadas pela Apple ou pelo Google.\n\n7. Segurança\nUsamos medidas técnicas e organizacionais razoáveis para proteger suas informações. Nenhum sistema é totalmente seguro; use uma senha forte e mantenha seu dispositivo atualizado.\n\n8. Contato\nDúvidas sobre privacidade: privacy@veylo.app',
			'logout.title' => 'Sair',
			'logout.subtitle' => 'Tem certeza de que quer sair?',
			'logout.cancel' => 'Cancelar',
			'logout.confirm' => 'Sair',
			'deleteAccount.title' => 'Enviar pedido de exclusão da conta',
			'deleteAccount.subtitle' => 'Tem certeza de que quer excluir sua conta?',
			'deleteAccount.reasonTitle' => 'Não queremos que você vá, mas entendemos.',
			'deleteAccount.reasonBefore' => 'Pode nos contar por que quer sair para melhorarmos a experiência no ',
			'deleteAccount.reasonAfter' => '?',
			'deleteAccount.reasonLabel' => 'Por que você quer excluir sua conta',
			'deleteAccount.reasonHint' => 'Digite sua mensagem',
			'deleteAccount.cancel' => 'Cancelar',
			'deleteAccount.createRequest' => 'Criar pedido',
			'deleteAccount.confirmTitle' => 'Tem certeza de que quer enviar um pedido de exclusão?',
			'deleteAccount.confirmSubtitle' => 'Se você confirmar, seu pedido de exclusão da conta será enviado',
			'deleteAccount.delete' => 'Excluir',
			'storyText.bold' => 'Negrito',
			'storyText.italic' => 'Itálico',
			'storyText.uppercase' => 'Maiúsculas',
			'storyText.underline' => 'Sublinhado',
			'storyText.cancel' => 'Cancelar',
			'storyText.galleryError' => 'Não foi possível abrir a galeria',
			_ => null,
		};
	}
}
