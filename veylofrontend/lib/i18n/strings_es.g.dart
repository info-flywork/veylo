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
class TranslationsEs extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEs({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.es,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <es>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key) ?? super[key];

	late final TranslationsEs _root = this; // ignore: unused_field

	@override 
	TranslationsEs $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsEs(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$app$es app = _Translations$app$es._(_root);
	@override late final _Translations$home$es home = _Translations$home$es._(_root);
	@override late final _Translations$chats$es chats = _Translations$chats$es._(_root);
	@override late final _Translations$profile$es profile = _Translations$profile$es._(_root);
	@override late final _Translations$nav$es nav = _Translations$nav$es._(_root);
	@override late final _Translations$call$es call = _Translations$call$es._(_root);
	@override late final _Translations$vibes$es vibes = _Translations$vibes$es._(_root);
	@override late final _Translations$discover$es discover = _Translations$discover$es._(_root);
	@override late final _Translations$common$es common = _Translations$common$es._(_root);
	@override late final _Translations$languages$es languages = _Translations$languages$es._(_root);
	@override late final _Translations$auth$es auth = _Translations$auth$es._(_root);
	@override late final _Translations$onboarding$es onboarding = _Translations$onboarding$es._(_root);
	@override late final _Translations$createProfile$es createProfile = _Translations$createProfile$es._(_root);
	@override late final _Translations$errors$es errors = _Translations$errors$es._(_root);
	@override late final _Translations$faq$es faq = _Translations$faq$es._(_root);
	@override late final _Translations$legal$es legal = _Translations$legal$es._(_root);
	@override late final _Translations$logout$es logout = _Translations$logout$es._(_root);
	@override late final _Translations$deleteAccount$es deleteAccount = _Translations$deleteAccount$es._(_root);
	@override late final _Translations$storyText$es storyText = _Translations$storyText$es._(_root);
	@override late final _Translations$tokens$es tokens = _Translations$tokens$es._(_root);
}

// Path: app
class _Translations$app$es extends Translations$app$tr {
	_Translations$app$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get name => 'Veylo';
	@override String get tagline => 'Bienvenido';
}

// Path: home
class _Translations$home$es extends Translations$home$tr {
	_Translations$home$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Inicio';
	@override String get subtitle => 'La app se está preparando';
	@override String get body => 'La interfaz multilingüe se gestiona con slang.';
}

// Path: chats
class _Translations$chats$es extends Translations$chats$tr {
	_Translations$chats$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Chats';
	@override String get search => 'Buscar';
	@override String get messagesSection => 'Mensajes';
	@override String get request => 'Solicitud';
	@override String get emptyRequestTitle => 'No hay notificaciones de\nmensajes recientes';
	@override String get emptyRequestSubtitle => 'No se muestran solicitudes de hace más de 30 días.';
	@override String get noteAdd => 'Añadir nota';
	@override String get anonymous => 'Anónimo';
	@override String get online => 'en línea';
	@override String get offline => 'desconectado';
	@override String get connection => 'Conexión';
	@override String connectionPercent({required Object n}) => '${n}%';
	@override String get connectionProgressTitle => 'Progreso de conexión';
	@override String get milestoneInitial => 'Inicial del nombre';
	@override String get milestoneInitialHint => 'Se desbloqueó al 25%';
	@override String get milestoneInitialLocked => 'Se desbloquea al 25%';
	@override String get milestonePhoto => 'Vista previa de foto borrosa';
	@override String get milestonePhotoHint => 'Se desbloquea al 70%';
	@override String get milestoneFull => 'Perfil completo';
	@override String get milestoneFullHint => 'Consentimiento mutuo al 100%';
	@override String get sampleAnonymousMessage => 'Hola, fue un placer conocerte. ¿Podrías contarme un poco sobre ti?';
	@override String get strangerSampleMessage => 'Hola Jhon, fue un placer conocerte. ¿Podrías contarme un poco sobre ti?';
	@override String get approve => 'Aprobar';
	@override String get blockUser => 'Bloquear usuario';
	@override String get reject => 'Rechazar';
	@override String get messageHint => '¡Hola! ¿Cómo estás?';
	@override String get revealTitle => 'Llegaste al 100%';
	@override String get revealSubtitle => '¿Revelar sus perfiles completos el uno al otro? Ambos deben aceptar.';
	@override String revealWaiting({required Object name}) => 'Esperando a que ${name} acepte';
	@override String get revealCta => 'Revelar mi perfil';
	@override String get revealNotYet => 'Aún no';
	@override String get seen => 'Visto';
	@override String get typing => 'escribiendo…';
	@override String get noteYou => 'Tú';
	@override String get noteSheetTitle => 'Comparte una nota';
	@override String get noteSheetSubtitle => 'Tu nota dura 24 horas';
	@override String get noteHint => '¿Qué tienes en mente?';
	@override String get noteShare => 'Compartir';
	@override String get noteDelete => 'Eliminar nota';
}

// Path: profile
class _Translations$profile$es extends Translations$profile$tr {
	_Translations$profile$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get eyebrow => 'Perfil';
	@override String get title => 'Ajustes';
	@override String get editProfile => 'Editar perfil';
	@override String get statLike => 'Me gusta';
	@override String get statFollow => 'Siguiendo';
	@override String get statFollower => 'Seguidores';
	@override String get promoTitle => '¡Recibe más mensajes!';
	@override String get promoSubtitle => 'Destaca y aparece arriba en la lista';
	@override String get standOut => 'Destacar';
	@override String get tabPosts => 'Publicaciones';
	@override String get tabVideo => 'Video';
	@override String get tabSaved => 'Guardado';
	@override String get save => 'Guardar';
	@override String get changePhoto => 'Cambiar foto';
	@override String get changeBorder => 'Cambiar borde';
	@override String get interest => 'Intereses';
	@override String get name => 'Nombre';
	@override String get changeName => 'Cambiar nombre';
	@override String get changePassword => 'Cambiar contraseña';
	@override String get confirmPassword => 'Confirmar contraseña';
	@override String get email => 'Correo';
	@override String get accountManagement => 'Gestión de la cuenta';
	@override String get settingsAbout => 'Acerca de';
	@override String get settingsAccount => 'Ajustes de la cuenta';
	@override String get settingsSupport => 'Soporte';
	@override String get shareApp => 'Compartir la app';
	@override String get shareAppTitle => 'Comparte con amigos';
	@override String get shareAppSubtitle => '¡Comparte Veylo con tus amigos y descubran juntos!';
	@override String get shareAppLabel => 'Enlace de la app';
	@override String get rateApp => '¿Te gustamos? Califícanos';
	@override String get notifications => 'Notificaciones';
	@override String get password => 'Contraseña';
	@override String get deleteConversation => 'Eliminar conversaciones';
	@override String get faqHelp => 'Preguntas frecuentes y ayuda';
	@override String get restorePurchases => 'Restaurar compras';
	@override String get termsOfService => 'Términos del servicio';
	@override String get privacyPolicy => 'Política de privacidad';
	@override String get restorePurchasesDone => 'Compras verificadas';
	@override String get conversationsDeleted => 'Todas las conversaciones eliminadas';
	@override String get logOut => 'Cerrar sesión';
	@override String get deleteAccountAndData => 'Eliminar cuenta y datos';
	@override String get passwordPlaceholder => '********';
	@override String get height => 'Altura';
	@override String get addHeight => 'Añadir altura';
	@override String heightCm({required Object value}) => '${value} cm';
	@override String get languages => 'Idiomas';
	@override String get relationshipGoals => 'Objetivos de relación';
	@override String get lookingFor => 'Busco';
	@override String get newFriends => '👋 Nuevos amigos';
	@override String get goalLongTermOpenToShort => '💕 Algo serio, abierto a algo corto';
	@override String get goalLongTermRelationship => '💘 Relación seria';
	@override String get goalNewFriends => '👋 Nuevos amigos';
	@override String get goalShortTermFun => '🥃 Diversión sin compromiso';
	@override String get goalStillFiguringItOut => '🤔 Aún no lo tengo claro';
	@override String get basics => 'Lo básico';
	@override String get zodiac => 'Signo';
	@override String get zodiacValue => 'Escorpio';
	@override String get education => 'Estudios';
	@override String get educationValue => 'Licenciatura';
	@override String get educationHighSchool => 'Secundaria';
	@override String get educationAssociates => 'Técnico superior';
	@override String get educationBachelors => 'Licenciatura';
	@override String get educationMasters => 'Máster';
	@override String get educationPhd => 'Doctorado';
	@override String get voiceRecord => 'Nota de voz';
	@override String get addVoice => 'Añadir voz';
	@override String get lifestyle => 'Estilo de vida';
	@override String get pets => 'Mascotas';
	@override String get petsValue => 'Tengo un gato';
	@override String get petsDontWant => 'No quiero mascotas';
	@override String get petsAllergic => 'Soy alérgico a las mascotas';
	@override String get petsHaveCat => 'Tengo un gato';
	@override String get petsHaveDog => 'Tengo un perro';
	@override String get petsHaveCatsAndDogs => 'Tengo gatos y perros';
	@override String get petsHaveOther => 'Tengo otras mascotas';
	@override String get drinking => 'Alcohol';
	@override String get drinkingValue => 'En ocasiones especiales';
	@override String get drinkingNever => 'Nunca';
	@override String get drinkingSpecialOccasions => 'En ocasiones especiales';
	@override String get drinkingSocially => 'Socialmente';
	@override String get drinkingFrequently => 'Con frecuencia';
	@override String get drinkingSober => 'Sobrio';
	@override String get drinkingPreferNotToSay => 'Prefiero no decirlo';
	@override String get smoking => 'Tabaco';
	@override String get smokingValue => 'No fumo';
	@override String get smokingNonSmoker => 'No fumo';
	@override String get smokingSocialSmoker => 'Fumo socialmente';
	@override String get smokingSmoker => 'Fumo';
	@override String get smokingTryingToQuit => 'Intento dejarlo';
	@override String get smokingWhenDrinking => 'Fumo cuando bebo';
	@override String get smokingPreferNotToSay => 'Prefiero no decirlo';
	@override String get gender => 'Género';
	@override String get genderFemale => 'Mujer';
	@override String get genderMale => 'Hombre';
	@override String get genderPreferNotToSay => 'Prefiero no decirlo';
	@override String get visible => 'Visible';
	@override String get profileVisibility => 'Visibilidad del perfil';
	@override String get language => 'Idioma';
	@override String get borderTitle => 'Borde de perfil';
	@override String get borderSubtitle => 'Añade un borde a tu perfil para\ndestacar.';
	@override String get borderBuySection => 'Compra un borde';
	@override String get borderBuyCta => 'Comprar borde';
	@override String borderToken({required Object count}) => '${count} tokens';
	@override String get borderAmethystWings => 'Amethyst Wings';
	@override String get borderGoldenPhoenix => 'Golden Phoenix';
	@override String get borderFrostCrown => 'Frost Crown';
	@override String get borderEmeraldWhisper => 'Emerald Whisper';
	@override String get borderRoseQuartz => 'Rose Quartz';
	@override String get borderStarlitComet => 'Starlit Comet';
	@override String get borderCrimsonRoyal => 'Crimson Royal';
	@override String get borderSapphireHalo => 'Sapphire Halo';
	@override String get follow => 'Seguir';
	@override String get following => 'Siguiendo';
	@override String get followPageTitle => 'Seguir';
	@override String get followTabFollowing => 'Siguiendo';
	@override String get followTabFollowers => 'Seguidores';
	@override String get followSearch => 'Buscar';
	@override String get unfollow => 'Dejar de seguir';
	@override String get followSortTitle => 'Ordenar';
	@override String get followSortRecent => 'Seguidos más recientemente';
	@override String get followSortNotFollowingMe => 'Quienes no me siguen';
	@override String get followSortNotFollowedByMe => 'A quienes no sigo';
	@override String get followSortShowResult => 'Mostrar resultados';
	@override String get followSortEmpty => 'Ningún usuario coincide con este filtro';
	@override String get shareTitle => 'Comparte con amigos';
	@override String get shareSubtitle => '¡Todo es más divertido cuando conectas\ncon tus amigos!';
	@override String get shareProfileLabel => 'Compartir el perfil';
	@override String get shareLinkCopied => 'Enlace copiado';
	@override String get restrict => 'Restringir';
	@override String get block => 'Bloquear';
	@override String get report => 'Denunciar';
	@override String blockTitle({required Object username}) => '¿Bloquear a ${username}?';
	@override String get blockBody => 'También se bloquearán otras cuentas que tenga o cree en el futuro. Puedes desbloquearlo cuando quieras.';
	@override String get blockAndReport => 'Bloquear y denunciar';
	@override String restrictTitle({required Object username}) => '¿Restringir a ${username}?';
	@override String get restrictBody => 'No podrá ver cuándo estás en línea ni si leíste sus mensajes. Puedes cambiarlo cuando quieras.';
	@override String get restrictAndReport => 'Restringir y denunciar';
	@override String get reportTitle => 'Nos gustaría saber por qué';
	@override String get reportSubtitle => 'Para ofrecerte una mejor experiencia, ¿podrías decirnos por qué quieres denunciar a este usuario?';
	@override String get reportMessageLabel => 'Mensaje de denuncia';
	@override String get reportMessageHint => 'Escribe tu mensaje';
	@override String get reportCancel => 'Cancelar';
	@override String get sendReport => 'Enviar denuncia';
	@override String get notSet => 'Sin definir';
	@override String get reportSent => 'Gracias, recibimos tu denuncia.';
	@override String emailVerificationSent({required Object email}) => 'Enviamos un enlace de confirmación a ${email}. Tu correo cambiará cuando lo confirmes.';
	@override String get passwordChanged => 'Tu contraseña se actualizó.';
	@override String get passwordMismatch => 'Las contraseñas no coinciden.';
}

// Path: nav
class _Translations$nav$es extends Translations$nav$tr {
	_Translations$nav$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get discover => 'Descubrir';
	@override String get chat => 'Chat';
	@override String get call => 'Llamada';
	@override String get vibes => 'Vibes';
	@override String get profile => 'Perfil';
}

// Path: call
class _Translations$call$es extends Translations$call$tr {
	_Translations$call$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => '60 segundos con un extraño';
	@override String get subtitle => 'Habla con un extraño al azar durante 60 segundos, de forma totalmente anónima. Sin perfil, sin foto, sin nombre. Solo una voz y un momento.';
	@override String get findingTitle => 'Buscando a un extraño...';
	@override String get findingSubtitle => 'Hablarán de forma anónima durante 60 segundos. Sin perfiles ni nombres.';
	@override String get callStranger => 'Llamar a un extraño - 10 tokens';
	@override String get cancel => 'Cancelar';
	@override String get female => 'Mujer';
	@override String get male => 'Hombre';
	@override String get nonBinary => 'No binario';
	@override String get preferNotToSay => 'Prefiero no decirlo';
	@override String get anonymousBadge => '🎙️ Llamada de voz anónima';
	@override String get stranger => 'Extraño';
	@override String secondsLeft({required Object n}) => '${n}s';
	@override String get timesUpTitle => '¡Se acabó el tiempo!';
	@override String get timesUpSubtitle => '¿Quieres seguir hablando? Si ambos dicen que sí, se desbloquea el chat.';
	@override String get keepTalking => 'Seguir hablando';
	@override String get endCall => 'Colgar';
	@override String get waitingOther => 'Esperando a la otra persona...';
	@override String get callStrangerFree => 'Llamar a un extraño';
	@override String get peerLeft => 'La otra persona finalizó la llamada.';
	@override String get noKeep => 'Esta vez no se desbloqueó el chat.';
	@override String get videoWaiting => 'Esperando a que acepte la videollamada...';
	@override String get videoDeclined => 'Rechazó la videollamada.';
	@override String get micDenied => 'Se necesita acceso al micrófono para las llamadas. Puedes activarlo en Ajustes.';
	@override String get videoCost => 'Videollamada: 20 tokens / 15 min';
	@override String get calling => 'Llamando';
	@override String get accept => 'Aceptar';
	@override String get decline => 'Rechazar';
	@override String get switchToVideo => '¿Quieres pasar a videollamada?';
	@override String get noMatchTitle => 'No hay nadie disponible ahora';
	@override String get noMatchBody => 'No encontramos a nadie con quien hablar en este momento. Vuelve a intentarlo un poco más tarde.';
	@override String get noMatchOk => 'OK';
}

// Path: vibes
class _Translations$vibes$es extends Translations$vibes$tr {
	_Translations$vibes$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get search => 'Buscar';
	@override String get sendMessage => 'Enviar mensaje';
	@override String get wantsToTalk => 'Quiere hablar de esto ahora mismo';
	@override String get shareTitle => 'Compartir vibe';
	@override String get replyTitle => 'Responder al vibe';
	@override String get shareHint => 'Escribe algo';
	@override String get shareAnonymous => 'Compartir de forma anónima';
	@override String get empty => 'No hay vibes en las últimas 24 horas. ¡Comparte el primero!';
	@override String get deleteTitle => '¿Eliminar este vibe?';
	@override String get delete => 'Eliminar';
	@override String get cancel => 'Cancelar';
}

// Path: discover
class _Translations$discover$es extends Translations$discover$tr {
	_Translations$discover$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Descubrir';
	@override String get tabRooms => 'Salas';
	@override String get tabDiscover => 'Descubrir';
	@override String get tabAiMatch => 'AI Match';
	@override late final _Translations$discover$aiMatch$es aiMatch = _Translations$discover$aiMatch$es._(_root);
	@override String get searchHint => 'Buscar';
	@override String get allRooms => 'Todas las salas';
	@override String get allGroups => 'Todos los grupos';
	@override String get seeAll => 'Ver todo';
	@override String get live => 'En vivo';
	@override String get join => 'Unirse';
	@override String get request => 'Solicitar';
	@override String get requested => 'Solicitado';
	@override String get private => 'Privado';
	@override String moreCount({required Object count}) => '+${count} más';
	@override String activeCount({required Object count}) => '${count} activos';
	@override String membersCount({required Object count}) => '${count} miembros';
	@override late final _Translations$discover$privateRoom$es privateRoom = _Translations$discover$privateRoom$es._(_root);
	@override late final _Translations$discover$roomToken$es roomToken = _Translations$discover$roomToken$es._(_root);
	@override late final _Translations$discover$privateRequest$es privateRequest = _Translations$discover$privateRequest$es._(_root);
	@override late final _Translations$discover$roomApproved$es roomApproved = _Translations$discover$roomApproved$es._(_root);
	@override late final _Translations$discover$createSpace$es createSpace = _Translations$discover$createSpace$es._(_root);
	@override late final _Translations$discover$liveRoom$es liveRoom = _Translations$discover$liveRoom$es._(_root);
	@override late final _Translations$discover$groupChat$es groupChat = _Translations$discover$groupChat$es._(_root);
	@override late final _Translations$discover$groupInfo$es groupInfo = _Translations$discover$groupInfo$es._(_root);
	@override late final _Translations$discover$filters$es filters = _Translations$discover$filters$es._(_root);
	@override late final _Translations$discover$post$es post = _Translations$discover$post$es._(_root);
	@override late final _Translations$discover$story$es story = _Translations$discover$story$es._(_root);
	@override late final _Translations$discover$highlight$es highlight = _Translations$discover$highlight$es._(_root);
	@override late final _Translations$discover$stats$es stats = _Translations$discover$stats$es._(_root);
	@override String hostedBy({required Object name}) => 'Organizada por ${name}';
}

// Path: common
class _Translations$common$es extends Translations$common$tr {
	_Translations$common$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get loading => 'Cargando…';
	@override String get retry => 'Reintentar';
	@override String get cancel => 'Cancelar';
	@override String get save => 'Guardar';
	@override String get continueAction => 'Continuar';
	@override String get language => 'Idioma';
	@override String get or => 'O';
}

// Path: languages
class _Translations$languages$es extends Translations$languages$tr {
	_Translations$languages$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get tr => 'Türkçe';
	@override String get en => 'English';
}

// Path: auth
class _Translations$auth$es extends Translations$auth$tr {
	_Translations$auth$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get createAccountTitle => 'Crea tu cuenta';
	@override String get createAccountSubtitle => 'Únete a Veylo y empieza a conectar.';
	@override String get welcomeBackTitle => 'Hola de nuevo';
	@override String get welcomeBackSubtitle => 'Inicia sesión para continuar en Veylo.';
	@override String get username => 'Nombre de usuario';
	@override String get usernameHint => 'Elige un nombre de usuario';
	@override String get email => 'Correo';
	@override String get emailHint => 'Introduce tu correo';
	@override String get emailOrUsername => 'Correo o nombre de usuario';
	@override String get emailOrUsernameHint => 'Correo o nombre de usuario';
	@override String get password => 'Contraseña';
	@override String get passwordCreateHint => 'Crea una contraseña';
	@override String get passwordEnterHint => 'Introduce tu contraseña';
	@override String get signUp => 'Registrarse';
	@override String get logIn => 'Iniciar sesión';
	@override String get forgotPassword => '¿Olvidaste tu contraseña?';
	@override String get continueWithApple => 'Continuar con Apple';
	@override String get continueWithGoogle => 'Continuar con Google';
	@override String get legalPrefix => 'Al continuar, aceptas nuestros ';
	@override String get termsOfService => 'Términos del servicio';
	@override String get legalMiddle => ' y reconoces nuestra ';
	@override String get privacyPolicy => 'Política de privacidad';
	@override String get legalSuffix => '.';
	@override String get passwordResetSent => 'Te enviamos a tu correo un enlace para restablecer la contraseña.';
}

// Path: onboarding
class _Translations$onboarding$es extends Translations$onboarding$tr {
	_Translations$onboarding$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get skip => 'Omitir';
	@override String get page1Title => 'Sé tú. Sigue en el anonimato.';
	@override String get page1Subtitle => 'Conoce gente nueva y empieza conversaciones\nsin revelar quién eres.';
	@override String get page2Title => 'Escribe. Habla. Siente la vibra.';
	@override String get page2Subtitle => 'Empieza en anónimo y luego escribe, llama o vean sus caras cuando estés listo.';
	@override String get page3Title => 'Encuentra a tu gente. Únete\na la conversación.';
	@override String get page3Subtitle => 'Entra en salas, conoce gente nueva y\ncompartan el momento juntos.';
	@override String get getStarted => 'Empezar';
	@override String get alreadyHaveAccount => '¿Ya tienes una cuenta de Veylo? ';
	@override String get logInAction => 'Iniciar sesión';
}

// Path: createProfile
class _Translations$createProfile$es extends Translations$createProfile$tr {
	_Translations$createProfile$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get navTitle => 'Crear perfil';
	@override String get stepUsername => '1/5 Nombre de usuario';
	@override String get title => 'Crea tu perfil';
	@override String get subtitle => 'Tu nombre real solo se usa para verificación; no se mostrará públicamente.';
	@override String get subtitleLine1 => 'Tu nombre real solo se usa para verificación;';
	@override String get subtitleLine2 => 'no se mostrará públicamente.';
	@override String get fullName => 'Nombre completo';
	@override String get fullNameHint => 'Sam Lee';
	@override String get username => 'Nombre de usuario';
	@override String get usernameHint => 'samlee123';
	@override String get usernameTaken => '¡Este nombre de usuario ya existe!';
	@override String get usernameAvailable => 'Nombre de usuario disponible';
	@override String get mightWantToTry => 'Quizá quieras probar...';
	@override String get stepPhoto => '2/5 Foto de perfil';
	@override String get photoTitle => 'Sube una foto de perfil';
	@override String get photoSubtitle => 'Otros usuarios pueden ver tu foto de perfil para asegurarse de que eres tú.';
	@override String get photoSubtitleLine1 => 'Otros usuarios pueden ver tu foto de perfil';
	@override String get photoSubtitleLine2 => 'para asegurarse de que eres tú.';
	@override String get choosePhoto => 'Elige una foto';
	@override String get continueWithoutPhoto => 'Continuar sin foto de perfil';
	@override String get saveAndContinue => 'Guardar y continuar';
	@override String get choosePhotoSheetTitle => 'Elige una foto';
	@override String get takePhoto => 'Tomar una foto';
	@override String get chooseFromGallery => 'Elegir de la galería';
	@override String get stepGender => '3/5 Género';
	@override String get genderTitle => 'Elige tu género';
	@override String get genderSubtitle => 'Si decides darnos esta información, podemos usarla para personalizar tu contenido';
	@override String get genderSubtitleLine1 => 'Si decides darnos esta información, podemos';
	@override String get genderSubtitleLine2 => 'usarla para personalizar tu contenido';
	@override String get genderFemale => 'Mujer';
	@override String get genderMale => 'Hombre';
	@override String get genderNonBinary => 'No binario';
	@override String get genderPreferNotToSay => 'Prefiero no decirlo';
	@override String get stepInterests => '4/5 Intereses';
	@override String get interestsTitle => '¿Qué te gusta?';
	@override String get interestsSubtitle => 'Elige al menos 5: así te conectamos con personas que de verdad te entienden.';
	@override late final _Translations$createProfile$interests$es interests = _Translations$createProfile$interests$es._(_root);
	@override String get stepChatGoal => '5/5 Objetivo del chat';
	@override String get chatGoalTitle => '¿Qué buscas hoy?';
	@override String get chatGoalSubtitle => 'Así encontramos el match ideal para tu estado de ánimo actual.';
	@override String get chatGoalQuickMatch => 'Match rápido: entra directo a una\nconversación';
	@override String get chatGoalFlirtyChat => 'Coqueteo: conversaciones ligeras\ny divertidas';
	@override String get chatGoalMoodMatch => 'Match por ánimo: según cómo te\nsientes';
	@override String get chatGoalLateNight => 'Charla nocturna: conversaciones profundas\nmientras el mundo duerme';
	@override String get chatGoalMeetSomeoneNew => 'Conocer a alguien: sin objetivo concreto,\nsolo explorar';
	@override String get getStarted => 'Empezar';
	@override String get preparingTitleLine1 => 'Estamos preparando';
	@override String get preparingTitleLine2 => 'perfiles ideales';
	@override String get preparingTitleLine3 => 'para ti.';
	@override String get preparingSubtitleLine1 => 'Según tus respuestas, estamos eligiendo';
	@override String get preparingSubtitleLine2 => 'los mejores matches. Espera un momento.';
	@override String preparingPercent({required Object percent}) => '${percent}%';
	@override String get usernameInvalid => 'Usa de 3 a 30 letras, números, puntos o guiones bajos.';
}

// Path: errors
class _Translations$errors$es extends Translations$errors$tr {
	_Translations$errors$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get network => 'No se pudo conectar con Veylo. Revisa tu conexión e inténtalo de nuevo.';
	@override String get generic => 'Algo salió mal. Inténtalo de nuevo.';
	@override String get signInFailed => 'No se pudo iniciar sesión. Inténtalo de nuevo.';
	@override String get sessionExpired => 'Tu sesión ha terminado. Vuelve a iniciar sesión.';
	@override String get accountSuspended => 'Esta cuenta ha sido suspendida.';
	@override String get unsupportedImage => 'Elige una foto JPEG, PNG o WebP.';
	@override String get fileTooLarge => 'Este archivo es demasiado grande.';
	@override String get enterEmailForReset => 'Introduce tu correo arriba para restablecer tu contraseña.';
	@override String get wrongCredentials => 'El correo/usuario o la contraseña no son correctos.';
	@override String get emailInUse => 'Este correo ya está registrado. Prueba a iniciar sesión.';
	@override String get weakPassword => 'La contraseña debe tener al menos 6 caracteres.';
	@override String get invalidEmail => 'Introduce un correo electrónico válido.';
	@override String get tooManyAttempts => 'Demasiados intentos. Espera un poco e inténtalo de nuevo.';
	@override String get fillAllFields => 'Completa todos los campos.';
	@override String get insufficientTokens => 'No tienes suficientes tokens.';
	@override String get requestNotAccepted => 'Acepta la solicitud para responder.';
	@override String get requestPendingLimit => 'Podrás enviar más mensajes cuando acepte tu solicitud.';
	@override String get blocked => 'No puedes enviar mensajes a esta persona.';
	@override String get peerUnavailable => 'Esta cuenta ya no está disponible.';
	@override String get vibeDailyLimit => 'Hoy compartiste muchos vibes. Inténtalo más tarde.';
	@override String get groupFull => 'Este grupo está lleno.';
	@override String get groupCreateLimit => 'Hoy creaste demasiados grupos. Inténtalo más tarde.';
	@override String get notFound => 'Esto ya no está disponible.';
	@override String get recentLogin => 'Por tu seguridad, cierra sesión, vuelve a iniciarla e inténtalo otra vez.';
	@override String get socialAccount => 'Tu correo y contraseña se gestionan desde tu cuenta de Google o Apple.';
	@override String get alreadyInCall => 'Ya estás en una llamada.';
	@override String get roomPrivate => 'Esta sala es privada. Pide al anfitrión que te deje entrar.';
	@override String get roomFull => 'Esta sala está llena.';
	@override String get alreadyCheckedIn => 'Ya recogiste la recompensa de hoy.';
	@override String get purchasesUnavailable => 'Las compras no están disponibles ahora.';
}

// Path: faq
class _Translations$faq$es extends Translations$faq$tr {
	_Translations$faq$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get q1 => '¿Cómo funciona esta app?';
	@override String get q2 => '¿Qué es el chat anónimo?';
	@override String get q3 => '¿Qué es el Progreso de conexión?';
	@override String get q4 => '¿Cómo revelo mi perfil?';
	@override String get q5 => '¿Qué es 60 segundos con un extraño?';
	@override String get q6 => '¿Qué son los Vibes?';
	@override String get q7 => '¿Cómo edito mi perfil?';
	@override String get q8 => '¿Cómo gestiono las notificaciones?';
	@override String get q9 => '¿Cómo restauro mis compras?';
	@override String get q10 => '¿Puedo eliminar todas las conversaciones?';
	@override String get q11 => '¿Están seguros mis datos?';
	@override String get q12 => '¿Cómo bloqueo o denuncio a alguien?';
	@override String get q13 => '¿Cómo comparto la app?';
	@override String get q14 => '¿Cómo elimino mi cuenta?';
	@override String get a1 => 'En Veylo puedes conocer gente nueva de forma anónima, chatear y revelar tu perfil poco a poco a medida que crece la conexión. Pasen a texto, voz o cara a cara cuando ambos se sientan listos.';
	@override String get a2 => 'En el chat anónimo tu identidad y tu foto permanecen ocultas. A medida que sube la conexión, desbloqueas detalles como la inicial del nombre y una foto borrosa. Al 100%, ambos deben aceptar para revelar los perfiles completos.';
	@override String get a3 => 'Mientras chateas, tu porcentaje de conexión aumenta. En ciertos hitos desbloqueas la inicial del nombre, una foto borrosa y el perfil completo. Toca la etiqueta Conexión para ver los detalles.';
	@override String get a4 => 'Cuando la conexión llegue al 100%, toca Revelar mi perfil. Si la otra persona también acepta, ambos perfiles completos serán visibles.';
	@override String get a5 => 'Desde la pestaña Llamada puedes conseguir un match breve al azar. Cuando se acabe el tiempo, puedes seguir hablando o colgar.';
	@override String get a6 => 'Vibes te permite descubrir personas cercanas o a tu alrededor en una vista de mapa o lista y empezar un chat con quien te interese.';
	@override String get a7 => 'Abre la pestaña Perfil y ve a Editar perfil para actualizar tu nombre, fotos, biografía e intereses. Los cambios aparecen al guardar.';
	@override String get a8 => 'Abre Notificaciones en Ajustes para activar o desactivar los avisos de mensajes, matches y más.';
	@override String get a9 => 'Ve a Ajustes → Gestión de la cuenta → Restaurar compras. Se restaurarán las compras válidas de la misma cuenta de la tienda.';
	@override String get a10 => 'Sí. Usa Ajustes → Eliminar conversaciones y confirma. Se borrarán todos los chats. Esto no se puede deshacer.';
	@override String get a11 => 'Los datos de tu cuenta y tus mensajes se guardan en sistemas protegidos. También puedes solicitar la eliminación de tu cuenta y datos desde Gestión de la cuenta cuando quieras.';
	@override String get a12 => 'Usa el menú de un perfil o de un chat para bloquear o denunciar. Nuestro equipo revisa las denuncias.';
	@override String get a13 => 'Usa Compartir la app en Ajustes para copiar el enlace y enviárselo a tus amigos.';
	@override String get a14 => 'Ve a Ajustes → Gestión de la cuenta → Eliminar cuenta y datos. Tras indicar un motivo, confirma para enviar tu solicitud de eliminación.';
}

// Path: legal
class _Translations$legal$es extends Translations$legal$tr {
	_Translations$legal$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get termsTitle => 'Términos del servicio';
	@override String get privacyTitle => 'Política de privacidad';
	@override String get termsBody => 'Última actualización: 16 de marzo de 2026\n\nTe damos la bienvenida a Veylo. Al crear una cuenta o usar la app, aceptas estos Términos del servicio.\n\n1. Qué es Veylo\nVeylo es una app social donde puedes conocer gente, chatear de forma anónima, crear conexión con el tiempo y, si ambas partes están de acuerdo, pasar a llamadas de voz o cara a cara.\n\n2. Tu cuenta\nDebes proporcionar información precisa y mantener seguro tu inicio de sesión. Eres responsable de la actividad realizada con tu cuenta. Debes tener la edad suficiente para usar Veylo según las leyes de tu país.\n\n3. Uso respetuoso\nNo acoses, amenaces, estafes, suplantes a otras personas, compartas contenido ilegal ni intentes eludir las funciones de seguridad. Podemos eliminar contenido, limitar funciones o suspender cuentas que incumplan estas normas.\n\n4. Chat anónimo y revelación del perfil\nLos chats anónimos pueden ocultar tu nombre y tu foto hasta alcanzar ciertos hitos de conexión. Revelar el perfil completo requiere consentimiento mutuo. No presiones a otras personas para que revelen su identidad.\n\n5. Compras\nAlgunas funciones pueden ser de pago. Las compras se gestionan a través de Apple App Store o Google Play. Restaurar compras recupera las compras válidas de la misma cuenta de la tienda. Los reembolsos siguen la política de la tienda.\n\n6. Contenido que compartes\nConservas los derechos sobre tu contenido, pero otorgas a Veylo una licencia para alojarlo y mostrarlo en la app según sea necesario para prestar el servicio. No publiques contenido que no tengas derecho a compartir.\n\n7. Fin del uso\nPuedes dejar de usar Veylo en cualquier momento y solicitar la eliminación de tu cuenta desde Ajustes. También podemos finalizar o modificar el servicio con un aviso razonable cuando sea necesario.\n\n8. Contacto\nPreguntas sobre estos términos: support@veylo.app';
	@override String get privacyBody => 'Última actualización: 16 de marzo de 2026\n\nEsta Política de privacidad explica cómo Veylo recopila, usa y protege tu información.\n\n1. Información que recopilamos\n• Datos de la cuenta: correo, nombre visible, fotos de perfil, biografía, preferencias\n• Datos de uso: chats, progreso de conexión, funciones de llamada que usas, datos básicos del dispositivo y la app\n• Compras: datos de recibos de la tienda necesarios para desbloquear y restaurar funciones de pago\n\n2. Cómo la usamos\nUsamos tus datos para operar Veylo, personalizar los matches y la experiencia de chat, mantener segura la comunidad, procesar compras y mejorar el producto. No vendemos tus datos personales.\n\n3. Modo anónimo\nEn los chats anónimos limitamos lo que ven los demás (por ejemplo, nombre oculto o foto borrosa) hasta que las reglas de desbloqueo y el consentimiento mutuo permitan mostrar más. Internamente seguimos necesitando identificadores de cuenta para operar la función de forma segura.\n\n4. Compartir datos\nPodemos compartir datos con proveedores de servicios que nos ayudan con el alojamiento, el análisis o el procesamiento de pagos, solo en la medida necesaria. También podemos divulgar información si lo exige la ley o para proteger a los usuarios de daños.\n\n5. Conservación\nConservamos los datos mientras tu cuenta esté activa y según sea necesario por motivos legales, de seguridad y de facturación. Una vez completada una solicitud de eliminación, eliminamos o anonimizamos los datos personales, salvo cuando sea obligatorio conservarlos.\n\n6. Tus opciones\nPuedes editar la información de tu perfil, gestionar las notificaciones, solicitar la eliminación de tu cuenta y contactarnos sobre tus datos. Las compras en la tienda también se gestionan a través de Apple o Google.\n\n7. Seguridad\nAplicamos medidas técnicas y organizativas razonables para proteger tu información. Ningún sistema es totalmente seguro; usa una contraseña segura y mantén tu dispositivo actualizado.\n\n8. Contacto\nPreguntas sobre privacidad: privacy@veylo.app';
}

// Path: logout
class _Translations$logout$es extends Translations$logout$tr {
	_Translations$logout$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Cerrar sesión';
	@override String get subtitle => '¿Seguro que quieres cerrar sesión?';
	@override String get cancel => 'Cancelar';
	@override String get confirm => 'Cerrar sesión';
}

// Path: deleteAccount
class _Translations$deleteAccount$es extends Translations$deleteAccount$tr {
	_Translations$deleteAccount$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Enviar solicitud de eliminación de cuenta';
	@override String get subtitle => '¿Seguro que quieres eliminar tu cuenta?';
	@override String get reasonTitle => 'No queremos que te vayas, pero lo entendemos.';
	@override String get reasonBefore => '¿Nos cuentas por qué quieres irte para que podamos mejorar la experiencia de ';
	@override String get reasonAfter => '?';
	@override String get reasonLabel => '¿Por qué quieres eliminar tu cuenta?';
	@override String get reasonHint => 'Escribe tu mensaje';
	@override String get cancel => 'Cancelar';
	@override String get createRequest => 'Crear solicitud';
	@override String get confirmTitle => '¿Seguro que quieres enviar una solicitud de eliminación?';
	@override String get confirmSubtitle => 'Si confirmas, se enviará tu solicitud de eliminación de cuenta';
	@override String get delete => 'Eliminar';
}

// Path: storyText
class _Translations$storyText$es extends Translations$storyText$tr {
	_Translations$storyText$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get bold => 'Negrita';
	@override String get italic => 'Cursiva';
	@override String get uppercase => 'Mayúsculas';
	@override String get underline => 'Subrayado';
	@override String get cancel => 'Cancelar';
	@override String get galleryError => 'No se pudo abrir la galería';
}

// Path: tokens
class _Translations$tokens$es extends Translations$tokens$tr {
	_Translations$tokens$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get boostTitle => 'Boost';
	@override String get history => 'Historial';
	@override String get yourBalance => 'Tu saldo';
	@override String balanceTokens({required Object count}) => '${count} tokens';
	@override String get getMore => 'Consigue más tokens';
	@override String get checkinTitle => 'Check-in diario';
	@override String checkinSubtitle({required Object max}) => 'Recoge cada día seguido y gana hasta ${max} tokens al día';
	@override String day({required Object n}) => 'Día ${n}';
	@override String collectDay({required Object n}) => 'Recoger tokens del día ${n}';
	@override String collectedToday({required Object n}) => 'Vuelve mañana para el día ${n}';
	@override String get duration30m => '30 minutos';
	@override String get duration1h => '1 hora';
	@override String get duration2h => '2 horas';
	@override String visibility({required Object n}) => 'Visibilidad x${n}';
	@override String boostFor({required Object count}) => 'Boost por ${count} tokens';
	@override String boostActive({required Object time}) => 'Boost activo hasta las ${time}';
	@override String get boostDone => '¡Tu perfil tiene Boost!';
	@override String get historyEmpty => 'Aún no hay actividad de tokens';
	@override String balanceLine({required Object count}) => 'Tu saldo: ${count} tokens';
	@override String get reasonPurchase => 'Compra de tokens';
	@override String get reasonCheckin => 'Check-in diario';
	@override String get reasonWelcome => 'Bono de bienvenida';
	@override String get reasonGenderFilter => 'Llamada con filtro de género';
	@override String get reasonVideoCall => 'Videollamada';
	@override String get reasonRoomCreate => 'Crear sala';
	@override String get reasonBorder => 'Marco de perfil';
	@override String get reasonPostBoost => 'Boost de publicación';
	@override String get reasonRefund => 'Reembolso';
	@override String get reasonAdjust => 'Ajuste de saldo';
	@override String get packsTitle => 'Consigue más tokens';
	@override String get packsSubtitle => 'Elige un paquete de tokens';
	@override String packTokens({required Object count}) => '${count} tokens';
	@override String get buy => 'Comprar';
	@override String purchaseDone({required Object count}) => '${count} tokens añadidos a tu saldo';
	@override String get notEnoughTitle => 'No tienes suficientes tokens';
	@override String get notEnoughSubtitle => 'Recarga tu saldo para continuar.';
}

// Path: discover.aiMatch
class _Translations$discover$aiMatch$es extends Translations$discover$aiMatch$tr {
	_Translations$discover$aiMatch$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get feelingTitle => '¿Cómo te sientes hoy?';
	@override String get feelingSubtitle => 'La IA encuentra tu mejor match según lo que elijas';
	@override String get lookingTitle => '¿Qué estás buscando?';
	@override String get moodSad => 'Triste';
	@override String get moodMeltie => 'Meh';
	@override String get moodBored => 'Aburrido';
	@override String get moodCrying => 'Bajón';
	@override String get moodSmile => 'Feliz';
	@override String get lookingNewFriends => 'Nuevos amigos';
	@override String get lookingVenting => 'Desahogarme';
	@override String get lookingFlirty => 'Coqueteo';
	@override String get lookingFun => 'Diversión';
	@override String get lookingCultures => 'Nuevas culturas';
	@override String get lookingLanguage => 'Practicar idiomas';
	@override String get statActiveUsers => 'Usuarios activos';
	@override String get statMatchRate => 'Tasa de match';
	@override String get statAvgTime => 'Tiempo medio';
	@override String get statActiveValue => '843';
	@override String get statMatchValue => '87%';
	@override String get statAvgValue => '8s';
	@override String get startSmartMatch => 'Iniciar Smart Match';
	@override String get findingTitle => 'Buscando tu match';
	@override String get findingSubtitle => 'Conectando tu estado de ánimo e intereses con la persona ideal';
	@override String get findingStepMood => 'Estado de ánimo analizado';
	@override String get findingStepInterests => 'Intereses emparejados';
	@override String get findingStepCompatibility => 'Calculando compatibilidad...';
	@override String get findingStepContent => 'Creando contenido...';
	@override String findingOnline({required Object count}) => '${count} personas en línea ahora';
	@override String get yourMatchTitle => 'Tu match';
	@override String get yourMatchSubtitle => 'Te emparejamos según tus respuestas';
	@override String vibeMatch({required Object percent}) => '${percent}% de afinidad';
	@override String get startChatting => 'Empezar a chatear';
	@override String matchNameAge({required Object name, required Object age}) => '${name}, ${age}';
	@override String get matchBio => 'Te haré sentir cosas que no sabías que podías sentir.';
	@override String get swipePrevious => 'Anterior';
	@override String get swipeNext => 'Siguiente';
	@override String get swipeFinger => 'Desliza el dedo';
	@override String get noMatch => 'Ahora no hay nadie compatible. Inténtalo de nuevo en un rato.';
}

// Path: discover.privateRoom
class _Translations$discover$privateRoom$es extends Translations$discover$privateRoom$tr {
	_Translations$discover$privateRoom$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get subtitle => 'Esta es una sala privada. Desbloquea el acceso con tokens.';
	@override String get roomAccess => 'Acceso a la sala';
	@override String get yourBalance => 'Tu saldo';
	@override String tokensAmount({required Object count}) => '${count} tokens';
	@override String joinForTokens({required Object count}) => 'Unirse por ${count} tokens';
	@override String get cancel => 'Cancelar';
}

// Path: discover.roomToken
class _Translations$discover$roomToken$es extends Translations$discover$roomToken$tr {
	_Translations$discover$roomToken$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get subtitle => 'Desbloquea el acceso con tokens.';
	@override String get roomAccess => 'Acceso a la sala';
	@override String get yourBalance => 'Tu saldo';
	@override String tokensAmount({required Object count}) => '${count} tokens';
	@override String joinForTokens({required Object count}) => 'Unirse por ${count} tokens';
	@override String get cancel => 'Cancelar';
}

// Path: discover.privateRequest
class _Translations$discover$privateRequest$es extends Translations$discover$privateRequest$tr {
	_Translations$discover$privateRequest$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Solicitud para unirte';
	@override String roomInfo({required Object name, required Object count}) => '${name} · ${count} miembros';
	@override String get messageHint => 'Di algo (opcional)...';
	@override String get sendRequest => 'Enviar solicitud';
	@override String get adminReview => 'El admin de la sala revisará tu solicitud';
}

// Path: discover.roomApproved
class _Translations$discover$roomApproved$es extends Translations$discover$roomApproved$tr {
	_Translations$discover$roomApproved$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => '¡Ya estás dentro!';
	@override String subtitle({required Object name}) => 'Tu lugar en ${name} está reservado';
	@override String get continueLabel => 'Continuar';
}

// Path: discover.createSpace
class _Translations$discover$createSpace$es extends Translations$discover$createSpace$tr {
	_Translations$discover$createSpace$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Crear sala o grupo';
	@override String get subtitle => 'Llega a más personas creando un grupo o una sala en vivo';
	@override String get room => 'Sala';
	@override String get group => 'Grupo';
	@override String get hideAccount => 'Ocultar tu cuenta';
	@override String get create => 'Crear';
	@override String get cancel => 'Cancelar';
	@override String get createRoomTitle => 'Crear sala';
	@override String get createGroupTitle => 'Crear grupo';
	@override String get nameSubtitle => 'Ponle un nombre al grupo que creaste';
	@override String get nameHint => 'Búho nocturno';
	@override String createRoomFor({required Object count}) => 'Crear por ${count} tokens';
}

// Path: discover.liveRoom
class _Translations$discover$liveRoom$es extends Translations$discover$liveRoom$tr {
	_Translations$discover$liveRoom$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get adminSuffix => '(Admin)';
	@override String get messageHint => 'Mensaje';
	@override String get quickReplyHey => '¡Hola a todos!';
	@override String get quickReplyTopic => '¿De qué se habla?';
	@override String get quickReplyNew => '¡Soy nuevo aquí!';
	@override String get sampleChatName => 'Sona';
	@override String get sampleChatBody => '¿Qué podemos hacer? ¿Qué tienes en mente?';
	@override String get roomEnded => 'La sala ha terminado.';
	@override String wantsToJoin({required Object name}) => '${name} quiere unirse';
	@override String get approve => 'Aprobar';
}

// Path: discover.groupChat
class _Translations$discover$groupChat$es extends Translations$discover$groupChat$tr {
	_Translations$discover$groupChat$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String usersCount({required Object count}) => '${count} usuarios';
	@override String get sampleVictoria => 'Estoy muy aburrida. ¿Hacemos algo, chicos?';
	@override String get sampleSona => '¿Qué podemos hacer? ¿Qué tienes en mente?';
	@override String get sampleOwn => 'Nos vemos en el muelle';
}

// Path: discover.groupInfo
class _Translations$discover$groupInfo$es extends Translations$discover$groupInfo$tr {
	_Translations$discover$groupInfo$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get media => 'Multimedia';
	@override String get gallery => 'Galería';
	@override String get settings => 'Ajustes';
	@override String get notifications => 'Notificaciones';
	@override String get blocked => 'Bloqueados';
	@override String get private => 'Privado';
	@override String membersCount({required Object count}) => '${count} miembros';
	@override String get addPeople => 'Añadir personas';
	@override String get you => 'Tú';
	@override String get admin => 'Admin';
	@override String get leaveGroup => 'Salir del grupo';
	@override String get requests => 'Solicitudes para unirse';
	@override String get approve => 'Aprobar';
	@override String get reject => 'Rechazar';
	@override String get addPeopleEmpty => 'Sigue a personas para añadirlas al grupo.';
	@override String get add => 'Añadir';
	@override String get makeAdmin => 'Hacer admin';
	@override String get removeAdmin => 'Quitar admin';
	@override String get remove => 'Quitar del grupo';
	@override String get leaveConfirm => '¿Salir de este grupo?';
	@override String get leave => 'Salir';
	@override String get cancel => 'Cancelar';
}

// Path: discover.filters
class _Translations$discover$filters$es extends Translations$discover$filters$tr {
	_Translations$discover$filters$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Filtros';
	@override String get ageRange => 'Rango de edad';
	@override String ageRangeValue({required Object min, required Object max}) => '${min}-${max}';
	@override String get distance => 'Distancia';
	@override String distanceValue({required Object km}) => '${km} km';
	@override String get showMe => 'Mostrarme';
	@override String get everyone => 'Todos';
	@override String get women => 'Mujeres';
	@override String get men => 'Hombres';
	@override String get interests => 'Intereses';
	@override String get activeNow => 'Activos ahora';
	@override String get activeNowSubtitle => 'Mostrar solo personas en línea ahora';
	@override String get showResult => 'Mostrar resultados';
}

// Path: discover.post
class _Translations$discover$post$es extends Translations$discover$post$tr {
	_Translations$discover$post$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get follow => 'Seguir';
	@override String get following => 'Siguiendo';
	@override String get addComment => 'Añade un comentario...';
	@override String get commentsTitle => 'Comentarios';
	@override String get sampleCaption => 'No hay nada como una taza de café después de un día precioso. <3';
	@override String hoursAgo({required Object hours}) => '${hours} h';
	@override String minutesAgo({required Object minutes}) => '${minutes} min';
	@override String daysAgo({required Object days}) => '${days} d';
	@override String get deleteCommentTitle => '¿Eliminar este comentario?';
}

// Path: discover.story
class _Translations$discover$story$es extends Translations$discover$story$tr {
	_Translations$discover$story$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get draft => 'BORRADOR';
	@override String get story => 'HISTORIA';
	@override String get share => 'Compartir';
	@override String get textPlaceholder => 'Escribe algo...';
	@override String get draftPrompt => '¿Guardar como borrador?';
	@override String get saveToDraft => 'Guardar borrador';
	@override String get moveToTrash => 'Mover a la papelera';
	@override String get save => 'Guardar';
	@override String get musicTitle => 'Música';
	@override String get musicEmpty => 'No se encontró música.';
	@override String get musicError => 'No se pudo cargar la música.';
	@override String get downloaded => 'Guardado en la galería';
	@override String get downloadFailed => 'No se pudo guardar';
}

// Path: discover.highlight
class _Translations$discover$highlight$es extends Translations$discover$highlight$tr {
	_Translations$discover$highlight$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Destacado';
	@override String get view => 'Ver';
	@override String get aiComments => 'Comentarios de IA';
	@override String get remove => 'Quitar destacado';
	@override String get sharedSuccess => 'Tu publicación se compartió con éxito';
	@override String get boost => 'Impulsar';
}

// Path: discover.stats
class _Translations$discover$stats$es extends Translations$discover$stats$tr {
	_Translations$discover$stats$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Estadísticas';
	@override String get subtitle => 'Abajo verás las estadísticas\nde tu publicación.';
	@override String get viewers => 'Vistas';
	@override String get comments => 'Comentarios';
	@override String get likes => 'Me gusta';
	@override String get boostCta => 'Impulsar 1 día - 100 tokens';
	@override String get boosted => '¡Impulsada! Tu publicación estará arriba durante 24 horas.';
}

// Path: createProfile.interests
class _Translations$createProfile$interests$es extends Translations$createProfile$interests$tr {
	_Translations$createProfile$interests$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get music => 'Música';
	@override String get movies => 'Películas';
	@override String get tvShows => 'Series';
	@override String get reading => 'Lectura';
	@override String get painting => 'Pintura';
	@override String get photography => 'Fotografía';
	@override String get theatre => 'Teatro';
	@override String get fitness => 'Fitness';
	@override String get swimming => 'Natación';
	@override String get football => 'Fútbol';
	@override String get basketball => 'Baloncesto';
	@override String get coffee => 'Café';
	@override String get travel => 'Viajes';
	@override String get camping => 'Camping';
	@override String get meditation => 'Meditación';
	@override String get videoGames => 'Videojuegos';
	@override String get boardGames => 'Juegos de mesa';
	@override String get standUp => 'Stand-up';
	@override String get tech => 'Tecnología';
	@override String get coding => 'Programación';
	@override String get ai => 'IA';
	@override String get podcast => 'Pódcasts';
}

/// The flat map containing all translations for locale <es>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsEs {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.name' => 'Veylo',
			'app.tagline' => 'Bienvenido',
			'home.title' => 'Inicio',
			'home.subtitle' => 'La app se está preparando',
			'home.body' => 'La interfaz multilingüe se gestiona con slang.',
			'chats.title' => 'Chats',
			'chats.search' => 'Buscar',
			'chats.messagesSection' => 'Mensajes',
			'chats.request' => 'Solicitud',
			'chats.emptyRequestTitle' => 'No hay notificaciones de\nmensajes recientes',
			'chats.emptyRequestSubtitle' => 'No se muestran solicitudes de hace más de 30 días.',
			'chats.noteAdd' => 'Añadir nota',
			'chats.anonymous' => 'Anónimo',
			'chats.online' => 'en línea',
			'chats.offline' => 'desconectado',
			'chats.connection' => 'Conexión',
			'chats.connectionPercent' => ({required Object n}) => '${n}%',
			'chats.connectionProgressTitle' => 'Progreso de conexión',
			'chats.milestoneInitial' => 'Inicial del nombre',
			'chats.milestoneInitialHint' => 'Se desbloqueó al 25%',
			'chats.milestoneInitialLocked' => 'Se desbloquea al 25%',
			'chats.milestonePhoto' => 'Vista previa de foto borrosa',
			'chats.milestonePhotoHint' => 'Se desbloquea al 70%',
			'chats.milestoneFull' => 'Perfil completo',
			'chats.milestoneFullHint' => 'Consentimiento mutuo al 100%',
			'chats.sampleAnonymousMessage' => 'Hola, fue un placer conocerte. ¿Podrías contarme un poco sobre ti?',
			'chats.strangerSampleMessage' => 'Hola Jhon, fue un placer conocerte. ¿Podrías contarme un poco sobre ti?',
			'chats.approve' => 'Aprobar',
			'chats.blockUser' => 'Bloquear usuario',
			'chats.reject' => 'Rechazar',
			'chats.messageHint' => '¡Hola! ¿Cómo estás?',
			'chats.revealTitle' => 'Llegaste al 100%',
			'chats.revealSubtitle' => '¿Revelar sus perfiles completos el uno al otro? Ambos deben aceptar.',
			'chats.revealWaiting' => ({required Object name}) => 'Esperando a que ${name} acepte',
			'chats.revealCta' => 'Revelar mi perfil',
			'chats.revealNotYet' => 'Aún no',
			'chats.seen' => 'Visto',
			'chats.typing' => 'escribiendo…',
			'chats.noteYou' => 'Tú',
			'chats.noteSheetTitle' => 'Comparte una nota',
			'chats.noteSheetSubtitle' => 'Tu nota dura 24 horas',
			'chats.noteHint' => '¿Qué tienes en mente?',
			'chats.noteShare' => 'Compartir',
			'chats.noteDelete' => 'Eliminar nota',
			'profile.eyebrow' => 'Perfil',
			'profile.title' => 'Ajustes',
			'profile.editProfile' => 'Editar perfil',
			'profile.statLike' => 'Me gusta',
			'profile.statFollow' => 'Siguiendo',
			'profile.statFollower' => 'Seguidores',
			'profile.promoTitle' => '¡Recibe más mensajes!',
			'profile.promoSubtitle' => 'Destaca y aparece arriba en la lista',
			'profile.standOut' => 'Destacar',
			'profile.tabPosts' => 'Publicaciones',
			'profile.tabVideo' => 'Video',
			'profile.tabSaved' => 'Guardado',
			'profile.save' => 'Guardar',
			'profile.changePhoto' => 'Cambiar foto',
			'profile.changeBorder' => 'Cambiar borde',
			'profile.interest' => 'Intereses',
			'profile.name' => 'Nombre',
			'profile.changeName' => 'Cambiar nombre',
			'profile.changePassword' => 'Cambiar contraseña',
			'profile.confirmPassword' => 'Confirmar contraseña',
			'profile.email' => 'Correo',
			'profile.accountManagement' => 'Gestión de la cuenta',
			'profile.settingsAbout' => 'Acerca de',
			'profile.settingsAccount' => 'Ajustes de la cuenta',
			'profile.settingsSupport' => 'Soporte',
			'profile.shareApp' => 'Compartir la app',
			'profile.shareAppTitle' => 'Comparte con amigos',
			'profile.shareAppSubtitle' => '¡Comparte Veylo con tus amigos y descubran juntos!',
			'profile.shareAppLabel' => 'Enlace de la app',
			'profile.rateApp' => '¿Te gustamos? Califícanos',
			'profile.notifications' => 'Notificaciones',
			'profile.password' => 'Contraseña',
			'profile.deleteConversation' => 'Eliminar conversaciones',
			'profile.faqHelp' => 'Preguntas frecuentes y ayuda',
			'profile.restorePurchases' => 'Restaurar compras',
			'profile.termsOfService' => 'Términos del servicio',
			'profile.privacyPolicy' => 'Política de privacidad',
			'profile.restorePurchasesDone' => 'Compras verificadas',
			'profile.conversationsDeleted' => 'Todas las conversaciones eliminadas',
			'profile.logOut' => 'Cerrar sesión',
			'profile.deleteAccountAndData' => 'Eliminar cuenta y datos',
			'profile.passwordPlaceholder' => '********',
			'profile.height' => 'Altura',
			'profile.addHeight' => 'Añadir altura',
			'profile.heightCm' => ({required Object value}) => '${value} cm',
			'profile.languages' => 'Idiomas',
			'profile.relationshipGoals' => 'Objetivos de relación',
			'profile.lookingFor' => 'Busco',
			'profile.newFriends' => '👋 Nuevos amigos',
			'profile.goalLongTermOpenToShort' => '💕 Algo serio, abierto a algo corto',
			'profile.goalLongTermRelationship' => '💘 Relación seria',
			'profile.goalNewFriends' => '👋 Nuevos amigos',
			'profile.goalShortTermFun' => '🥃 Diversión sin compromiso',
			'profile.goalStillFiguringItOut' => '🤔 Aún no lo tengo claro',
			'profile.basics' => 'Lo básico',
			'profile.zodiac' => 'Signo',
			'profile.zodiacValue' => 'Escorpio',
			'profile.education' => 'Estudios',
			'profile.educationValue' => 'Licenciatura',
			'profile.educationHighSchool' => 'Secundaria',
			'profile.educationAssociates' => 'Técnico superior',
			'profile.educationBachelors' => 'Licenciatura',
			'profile.educationMasters' => 'Máster',
			'profile.educationPhd' => 'Doctorado',
			'profile.voiceRecord' => 'Nota de voz',
			'profile.addVoice' => 'Añadir voz',
			'profile.lifestyle' => 'Estilo de vida',
			'profile.pets' => 'Mascotas',
			'profile.petsValue' => 'Tengo un gato',
			'profile.petsDontWant' => 'No quiero mascotas',
			'profile.petsAllergic' => 'Soy alérgico a las mascotas',
			'profile.petsHaveCat' => 'Tengo un gato',
			'profile.petsHaveDog' => 'Tengo un perro',
			'profile.petsHaveCatsAndDogs' => 'Tengo gatos y perros',
			'profile.petsHaveOther' => 'Tengo otras mascotas',
			'profile.drinking' => 'Alcohol',
			'profile.drinkingValue' => 'En ocasiones especiales',
			'profile.drinkingNever' => 'Nunca',
			'profile.drinkingSpecialOccasions' => 'En ocasiones especiales',
			'profile.drinkingSocially' => 'Socialmente',
			'profile.drinkingFrequently' => 'Con frecuencia',
			'profile.drinkingSober' => 'Sobrio',
			'profile.drinkingPreferNotToSay' => 'Prefiero no decirlo',
			'profile.smoking' => 'Tabaco',
			'profile.smokingValue' => 'No fumo',
			'profile.smokingNonSmoker' => 'No fumo',
			'profile.smokingSocialSmoker' => 'Fumo socialmente',
			'profile.smokingSmoker' => 'Fumo',
			'profile.smokingTryingToQuit' => 'Intento dejarlo',
			'profile.smokingWhenDrinking' => 'Fumo cuando bebo',
			'profile.smokingPreferNotToSay' => 'Prefiero no decirlo',
			'profile.gender' => 'Género',
			'profile.genderFemale' => 'Mujer',
			'profile.genderMale' => 'Hombre',
			'profile.genderPreferNotToSay' => 'Prefiero no decirlo',
			'profile.visible' => 'Visible',
			'profile.profileVisibility' => 'Visibilidad del perfil',
			'profile.language' => 'Idioma',
			'profile.borderTitle' => 'Borde de perfil',
			'profile.borderSubtitle' => 'Añade un borde a tu perfil para\ndestacar.',
			'profile.borderBuySection' => 'Compra un borde',
			'profile.borderBuyCta' => 'Comprar borde',
			'profile.borderToken' => ({required Object count}) => '${count} tokens',
			'profile.borderAmethystWings' => 'Amethyst Wings',
			'profile.borderGoldenPhoenix' => 'Golden Phoenix',
			'profile.borderFrostCrown' => 'Frost Crown',
			'profile.borderEmeraldWhisper' => 'Emerald Whisper',
			'profile.borderRoseQuartz' => 'Rose Quartz',
			'profile.borderStarlitComet' => 'Starlit Comet',
			'profile.borderCrimsonRoyal' => 'Crimson Royal',
			'profile.borderSapphireHalo' => 'Sapphire Halo',
			'profile.follow' => 'Seguir',
			'profile.following' => 'Siguiendo',
			'profile.followPageTitle' => 'Seguir',
			'profile.followTabFollowing' => 'Siguiendo',
			'profile.followTabFollowers' => 'Seguidores',
			'profile.followSearch' => 'Buscar',
			'profile.unfollow' => 'Dejar de seguir',
			'profile.followSortTitle' => 'Ordenar',
			'profile.followSortRecent' => 'Seguidos más recientemente',
			'profile.followSortNotFollowingMe' => 'Quienes no me siguen',
			'profile.followSortNotFollowedByMe' => 'A quienes no sigo',
			'profile.followSortShowResult' => 'Mostrar resultados',
			'profile.followSortEmpty' => 'Ningún usuario coincide con este filtro',
			'profile.shareTitle' => 'Comparte con amigos',
			'profile.shareSubtitle' => '¡Todo es más divertido cuando conectas\ncon tus amigos!',
			'profile.shareProfileLabel' => 'Compartir el perfil',
			'profile.shareLinkCopied' => 'Enlace copiado',
			'profile.restrict' => 'Restringir',
			'profile.block' => 'Bloquear',
			'profile.report' => 'Denunciar',
			'profile.blockTitle' => ({required Object username}) => '¿Bloquear a ${username}?',
			'profile.blockBody' => 'También se bloquearán otras cuentas que tenga o cree en el futuro. Puedes desbloquearlo cuando quieras.',
			'profile.blockAndReport' => 'Bloquear y denunciar',
			'profile.restrictTitle' => ({required Object username}) => '¿Restringir a ${username}?',
			'profile.restrictBody' => 'No podrá ver cuándo estás en línea ni si leíste sus mensajes. Puedes cambiarlo cuando quieras.',
			'profile.restrictAndReport' => 'Restringir y denunciar',
			'profile.reportTitle' => 'Nos gustaría saber por qué',
			'profile.reportSubtitle' => 'Para ofrecerte una mejor experiencia, ¿podrías decirnos por qué quieres denunciar a este usuario?',
			'profile.reportMessageLabel' => 'Mensaje de denuncia',
			'profile.reportMessageHint' => 'Escribe tu mensaje',
			'profile.reportCancel' => 'Cancelar',
			'profile.sendReport' => 'Enviar denuncia',
			'profile.notSet' => 'Sin definir',
			'profile.reportSent' => 'Gracias, recibimos tu denuncia.',
			'profile.emailVerificationSent' => ({required Object email}) => 'Enviamos un enlace de confirmación a ${email}. Tu correo cambiará cuando lo confirmes.',
			'profile.passwordChanged' => 'Tu contraseña se actualizó.',
			'profile.passwordMismatch' => 'Las contraseñas no coinciden.',
			'nav.discover' => 'Descubrir',
			'nav.chat' => 'Chat',
			'nav.call' => 'Llamada',
			'nav.vibes' => 'Vibes',
			'nav.profile' => 'Perfil',
			'call.title' => '60 segundos con un extraño',
			'call.subtitle' => 'Habla con un extraño al azar durante 60 segundos, de forma totalmente anónima. Sin perfil, sin foto, sin nombre. Solo una voz y un momento.',
			'call.findingTitle' => 'Buscando a un extraño...',
			'call.findingSubtitle' => 'Hablarán de forma anónima durante 60 segundos. Sin perfiles ni nombres.',
			'call.callStranger' => 'Llamar a un extraño - 10 tokens',
			'call.cancel' => 'Cancelar',
			'call.female' => 'Mujer',
			'call.male' => 'Hombre',
			'call.nonBinary' => 'No binario',
			'call.preferNotToSay' => 'Prefiero no decirlo',
			'call.anonymousBadge' => '🎙️ Llamada de voz anónima',
			'call.stranger' => 'Extraño',
			'call.secondsLeft' => ({required Object n}) => '${n}s',
			'call.timesUpTitle' => '¡Se acabó el tiempo!',
			'call.timesUpSubtitle' => '¿Quieres seguir hablando? Si ambos dicen que sí, se desbloquea el chat.',
			'call.keepTalking' => 'Seguir hablando',
			'call.endCall' => 'Colgar',
			'call.waitingOther' => 'Esperando a la otra persona...',
			'call.callStrangerFree' => 'Llamar a un extraño',
			'call.peerLeft' => 'La otra persona finalizó la llamada.',
			'call.noKeep' => 'Esta vez no se desbloqueó el chat.',
			'call.videoWaiting' => 'Esperando a que acepte la videollamada...',
			'call.videoDeclined' => 'Rechazó la videollamada.',
			'call.micDenied' => 'Se necesita acceso al micrófono para las llamadas. Puedes activarlo en Ajustes.',
			'call.videoCost' => 'Videollamada: 20 tokens / 15 min',
			'call.calling' => 'Llamando',
			'call.accept' => 'Aceptar',
			'call.decline' => 'Rechazar',
			'call.switchToVideo' => '¿Quieres pasar a videollamada?',
			'call.noMatchTitle' => 'No hay nadie disponible ahora',
			'call.noMatchBody' => 'No encontramos a nadie con quien hablar en este momento. Vuelve a intentarlo un poco más tarde.',
			'call.noMatchOk' => 'OK',
			'vibes.search' => 'Buscar',
			'vibes.sendMessage' => 'Enviar mensaje',
			'vibes.wantsToTalk' => 'Quiere hablar de esto ahora mismo',
			'vibes.shareTitle' => 'Compartir vibe',
			'vibes.replyTitle' => 'Responder al vibe',
			'vibes.shareHint' => 'Escribe algo',
			'vibes.shareAnonymous' => 'Compartir de forma anónima',
			'vibes.empty' => 'No hay vibes en las últimas 24 horas. ¡Comparte el primero!',
			'vibes.deleteTitle' => '¿Eliminar este vibe?',
			'vibes.delete' => 'Eliminar',
			'vibes.cancel' => 'Cancelar',
			'discover.title' => 'Descubrir',
			'discover.tabRooms' => 'Salas',
			'discover.tabDiscover' => 'Descubrir',
			'discover.tabAiMatch' => 'AI Match',
			'discover.aiMatch.feelingTitle' => '¿Cómo te sientes hoy?',
			'discover.aiMatch.feelingSubtitle' => 'La IA encuentra tu mejor match según lo que elijas',
			'discover.aiMatch.lookingTitle' => '¿Qué estás buscando?',
			'discover.aiMatch.moodSad' => 'Triste',
			'discover.aiMatch.moodMeltie' => 'Meh',
			'discover.aiMatch.moodBored' => 'Aburrido',
			'discover.aiMatch.moodCrying' => 'Bajón',
			'discover.aiMatch.moodSmile' => 'Feliz',
			'discover.aiMatch.lookingNewFriends' => 'Nuevos amigos',
			'discover.aiMatch.lookingVenting' => 'Desahogarme',
			'discover.aiMatch.lookingFlirty' => 'Coqueteo',
			'discover.aiMatch.lookingFun' => 'Diversión',
			'discover.aiMatch.lookingCultures' => 'Nuevas culturas',
			'discover.aiMatch.lookingLanguage' => 'Practicar idiomas',
			'discover.aiMatch.statActiveUsers' => 'Usuarios activos',
			'discover.aiMatch.statMatchRate' => 'Tasa de match',
			'discover.aiMatch.statAvgTime' => 'Tiempo medio',
			'discover.aiMatch.statActiveValue' => '843',
			'discover.aiMatch.statMatchValue' => '87%',
			'discover.aiMatch.statAvgValue' => '8s',
			'discover.aiMatch.startSmartMatch' => 'Iniciar Smart Match',
			'discover.aiMatch.findingTitle' => 'Buscando tu match',
			'discover.aiMatch.findingSubtitle' => 'Conectando tu estado de ánimo e intereses con la persona ideal',
			'discover.aiMatch.findingStepMood' => 'Estado de ánimo analizado',
			'discover.aiMatch.findingStepInterests' => 'Intereses emparejados',
			'discover.aiMatch.findingStepCompatibility' => 'Calculando compatibilidad...',
			'discover.aiMatch.findingStepContent' => 'Creando contenido...',
			'discover.aiMatch.findingOnline' => ({required Object count}) => '${count} personas en línea ahora',
			'discover.aiMatch.yourMatchTitle' => 'Tu match',
			'discover.aiMatch.yourMatchSubtitle' => 'Te emparejamos según tus respuestas',
			'discover.aiMatch.vibeMatch' => ({required Object percent}) => '${percent}% de afinidad',
			'discover.aiMatch.startChatting' => 'Empezar a chatear',
			'discover.aiMatch.matchNameAge' => ({required Object name, required Object age}) => '${name}, ${age}',
			'discover.aiMatch.matchBio' => 'Te haré sentir cosas que no sabías que podías sentir.',
			'discover.aiMatch.swipePrevious' => 'Anterior',
			'discover.aiMatch.swipeNext' => 'Siguiente',
			'discover.aiMatch.swipeFinger' => 'Desliza el dedo',
			'discover.aiMatch.noMatch' => 'Ahora no hay nadie compatible. Inténtalo de nuevo en un rato.',
			'discover.searchHint' => 'Buscar',
			'discover.allRooms' => 'Todas las salas',
			'discover.allGroups' => 'Todos los grupos',
			'discover.seeAll' => 'Ver todo',
			'discover.live' => 'En vivo',
			'discover.join' => 'Unirse',
			'discover.request' => 'Solicitar',
			'discover.requested' => 'Solicitado',
			'discover.private' => 'Privado',
			'discover.moreCount' => ({required Object count}) => '+${count} más',
			'discover.activeCount' => ({required Object count}) => '${count} activos',
			'discover.membersCount' => ({required Object count}) => '${count} miembros',
			'discover.privateRoom.subtitle' => 'Esta es una sala privada. Desbloquea el acceso con tokens.',
			'discover.privateRoom.roomAccess' => 'Acceso a la sala',
			'discover.privateRoom.yourBalance' => 'Tu saldo',
			'discover.privateRoom.tokensAmount' => ({required Object count}) => '${count} tokens',
			'discover.privateRoom.joinForTokens' => ({required Object count}) => 'Unirse por ${count} tokens',
			'discover.privateRoom.cancel' => 'Cancelar',
			'discover.roomToken.subtitle' => 'Desbloquea el acceso con tokens.',
			'discover.roomToken.roomAccess' => 'Acceso a la sala',
			'discover.roomToken.yourBalance' => 'Tu saldo',
			'discover.roomToken.tokensAmount' => ({required Object count}) => '${count} tokens',
			'discover.roomToken.joinForTokens' => ({required Object count}) => 'Unirse por ${count} tokens',
			'discover.roomToken.cancel' => 'Cancelar',
			'discover.privateRequest.title' => 'Solicitud para unirte',
			'discover.privateRequest.roomInfo' => ({required Object name, required Object count}) => '${name} · ${count} miembros',
			'discover.privateRequest.messageHint' => 'Di algo (opcional)...',
			'discover.privateRequest.sendRequest' => 'Enviar solicitud',
			'discover.privateRequest.adminReview' => 'El admin de la sala revisará tu solicitud',
			'discover.roomApproved.title' => '¡Ya estás dentro!',
			'discover.roomApproved.subtitle' => ({required Object name}) => 'Tu lugar en ${name} está reservado',
			'discover.roomApproved.continueLabel' => 'Continuar',
			'discover.createSpace.title' => 'Crear sala o grupo',
			'discover.createSpace.subtitle' => 'Llega a más personas creando un grupo o una sala en vivo',
			'discover.createSpace.room' => 'Sala',
			'discover.createSpace.group' => 'Grupo',
			'discover.createSpace.hideAccount' => 'Ocultar tu cuenta',
			'discover.createSpace.create' => 'Crear',
			'discover.createSpace.cancel' => 'Cancelar',
			'discover.createSpace.createRoomTitle' => 'Crear sala',
			'discover.createSpace.createGroupTitle' => 'Crear grupo',
			'discover.createSpace.nameSubtitle' => 'Ponle un nombre al grupo que creaste',
			'discover.createSpace.nameHint' => 'Búho nocturno',
			'discover.createSpace.createRoomFor' => ({required Object count}) => 'Crear por ${count} tokens',
			'discover.liveRoom.adminSuffix' => '(Admin)',
			'discover.liveRoom.messageHint' => 'Mensaje',
			'discover.liveRoom.quickReplyHey' => '¡Hola a todos!',
			'discover.liveRoom.quickReplyTopic' => '¿De qué se habla?',
			'discover.liveRoom.quickReplyNew' => '¡Soy nuevo aquí!',
			'discover.liveRoom.sampleChatName' => 'Sona',
			'discover.liveRoom.sampleChatBody' => '¿Qué podemos hacer? ¿Qué tienes en mente?',
			'discover.liveRoom.roomEnded' => 'La sala ha terminado.',
			'discover.liveRoom.wantsToJoin' => ({required Object name}) => '${name} quiere unirse',
			'discover.liveRoom.approve' => 'Aprobar',
			'discover.groupChat.usersCount' => ({required Object count}) => '${count} usuarios',
			'discover.groupChat.sampleVictoria' => 'Estoy muy aburrida. ¿Hacemos algo, chicos?',
			'discover.groupChat.sampleSona' => '¿Qué podemos hacer? ¿Qué tienes en mente?',
			'discover.groupChat.sampleOwn' => 'Nos vemos en el muelle',
			'discover.groupInfo.media' => 'Multimedia',
			'discover.groupInfo.gallery' => 'Galería',
			'discover.groupInfo.settings' => 'Ajustes',
			'discover.groupInfo.notifications' => 'Notificaciones',
			'discover.groupInfo.blocked' => 'Bloqueados',
			'discover.groupInfo.private' => 'Privado',
			'discover.groupInfo.membersCount' => ({required Object count}) => '${count} miembros',
			'discover.groupInfo.addPeople' => 'Añadir personas',
			'discover.groupInfo.you' => 'Tú',
			'discover.groupInfo.admin' => 'Admin',
			'discover.groupInfo.leaveGroup' => 'Salir del grupo',
			'discover.groupInfo.requests' => 'Solicitudes para unirse',
			'discover.groupInfo.approve' => 'Aprobar',
			'discover.groupInfo.reject' => 'Rechazar',
			'discover.groupInfo.addPeopleEmpty' => 'Sigue a personas para añadirlas al grupo.',
			'discover.groupInfo.add' => 'Añadir',
			'discover.groupInfo.makeAdmin' => 'Hacer admin',
			'discover.groupInfo.removeAdmin' => 'Quitar admin',
			'discover.groupInfo.remove' => 'Quitar del grupo',
			'discover.groupInfo.leaveConfirm' => '¿Salir de este grupo?',
			'discover.groupInfo.leave' => 'Salir',
			'discover.groupInfo.cancel' => 'Cancelar',
			'discover.filters.title' => 'Filtros',
			'discover.filters.ageRange' => 'Rango de edad',
			'discover.filters.ageRangeValue' => ({required Object min, required Object max}) => '${min}-${max}',
			'discover.filters.distance' => 'Distancia',
			'discover.filters.distanceValue' => ({required Object km}) => '${km} km',
			'discover.filters.showMe' => 'Mostrarme',
			'discover.filters.everyone' => 'Todos',
			'discover.filters.women' => 'Mujeres',
			'discover.filters.men' => 'Hombres',
			'discover.filters.interests' => 'Intereses',
			'discover.filters.activeNow' => 'Activos ahora',
			'discover.filters.activeNowSubtitle' => 'Mostrar solo personas en línea ahora',
			'discover.filters.showResult' => 'Mostrar resultados',
			'discover.post.follow' => 'Seguir',
			'discover.post.following' => 'Siguiendo',
			'discover.post.addComment' => 'Añade un comentario...',
			'discover.post.commentsTitle' => 'Comentarios',
			'discover.post.sampleCaption' => 'No hay nada como una taza de café después de un día precioso. <3',
			'discover.post.hoursAgo' => ({required Object hours}) => '${hours} h',
			'discover.post.minutesAgo' => ({required Object minutes}) => '${minutes} min',
			'discover.post.daysAgo' => ({required Object days}) => '${days} d',
			'discover.post.deleteCommentTitle' => '¿Eliminar este comentario?',
			'discover.story.draft' => 'BORRADOR',
			'discover.story.story' => 'HISTORIA',
			'discover.story.share' => 'Compartir',
			'discover.story.textPlaceholder' => 'Escribe algo...',
			'discover.story.draftPrompt' => '¿Guardar como borrador?',
			'discover.story.saveToDraft' => 'Guardar borrador',
			'discover.story.moveToTrash' => 'Mover a la papelera',
			'discover.story.save' => 'Guardar',
			'discover.story.musicTitle' => 'Música',
			'discover.story.musicEmpty' => 'No se encontró música.',
			'discover.story.musicError' => 'No se pudo cargar la música.',
			'discover.story.downloaded' => 'Guardado en la galería',
			'discover.story.downloadFailed' => 'No se pudo guardar',
			'discover.highlight.title' => 'Destacado',
			'discover.highlight.view' => 'Ver',
			'discover.highlight.aiComments' => 'Comentarios de IA',
			'discover.highlight.remove' => 'Quitar destacado',
			'discover.highlight.sharedSuccess' => 'Tu publicación se compartió con éxito',
			'discover.highlight.boost' => 'Impulsar',
			'discover.stats.title' => 'Estadísticas',
			'discover.stats.subtitle' => 'Abajo verás las estadísticas\nde tu publicación.',
			'discover.stats.viewers' => 'Vistas',
			'discover.stats.comments' => 'Comentarios',
			'discover.stats.likes' => 'Me gusta',
			'discover.stats.boostCta' => 'Impulsar 1 día - 100 tokens',
			'discover.stats.boosted' => '¡Impulsada! Tu publicación estará arriba durante 24 horas.',
			'discover.hostedBy' => ({required Object name}) => 'Organizada por ${name}',
			'common.loading' => 'Cargando…',
			'common.retry' => 'Reintentar',
			'common.cancel' => 'Cancelar',
			'common.save' => 'Guardar',
			'common.continueAction' => 'Continuar',
			'common.language' => 'Idioma',
			'common.or' => 'O',
			'languages.tr' => 'Türkçe',
			'languages.en' => 'English',
			'auth.createAccountTitle' => 'Crea tu cuenta',
			'auth.createAccountSubtitle' => 'Únete a Veylo y empieza a conectar.',
			'auth.welcomeBackTitle' => 'Hola de nuevo',
			'auth.welcomeBackSubtitle' => 'Inicia sesión para continuar en Veylo.',
			'auth.username' => 'Nombre de usuario',
			'auth.usernameHint' => 'Elige un nombre de usuario',
			'auth.email' => 'Correo',
			'auth.emailHint' => 'Introduce tu correo',
			'auth.emailOrUsername' => 'Correo o nombre de usuario',
			'auth.emailOrUsernameHint' => 'Correo o nombre de usuario',
			'auth.password' => 'Contraseña',
			'auth.passwordCreateHint' => 'Crea una contraseña',
			'auth.passwordEnterHint' => 'Introduce tu contraseña',
			'auth.signUp' => 'Registrarse',
			'auth.logIn' => 'Iniciar sesión',
			'auth.forgotPassword' => '¿Olvidaste tu contraseña?',
			'auth.continueWithApple' => 'Continuar con Apple',
			'auth.continueWithGoogle' => 'Continuar con Google',
			'auth.legalPrefix' => 'Al continuar, aceptas nuestros ',
			'auth.termsOfService' => 'Términos del servicio',
			'auth.legalMiddle' => ' y reconoces nuestra ',
			'auth.privacyPolicy' => 'Política de privacidad',
			'auth.legalSuffix' => '.',
			'auth.passwordResetSent' => 'Te enviamos a tu correo un enlace para restablecer la contraseña.',
			'onboarding.skip' => 'Omitir',
			'onboarding.page1Title' => 'Sé tú. Sigue en el anonimato.',
			'onboarding.page1Subtitle' => 'Conoce gente nueva y empieza conversaciones\nsin revelar quién eres.',
			'onboarding.page2Title' => 'Escribe. Habla. Siente la vibra.',
			'onboarding.page2Subtitle' => 'Empieza en anónimo y luego escribe, llama o vean sus caras cuando estés listo.',
			'onboarding.page3Title' => 'Encuentra a tu gente. Únete\na la conversación.',
			'onboarding.page3Subtitle' => 'Entra en salas, conoce gente nueva y\ncompartan el momento juntos.',
			'onboarding.getStarted' => 'Empezar',
			'onboarding.alreadyHaveAccount' => '¿Ya tienes una cuenta de Veylo? ',
			'onboarding.logInAction' => 'Iniciar sesión',
			'createProfile.navTitle' => 'Crear perfil',
			'createProfile.stepUsername' => '1/5 Nombre de usuario',
			'createProfile.title' => 'Crea tu perfil',
			'createProfile.subtitle' => 'Tu nombre real solo se usa para verificación; no se mostrará públicamente.',
			'createProfile.subtitleLine1' => 'Tu nombre real solo se usa para verificación;',
			'createProfile.subtitleLine2' => 'no se mostrará públicamente.',
			'createProfile.fullName' => 'Nombre completo',
			'createProfile.fullNameHint' => 'Sam Lee',
			'createProfile.username' => 'Nombre de usuario',
			'createProfile.usernameHint' => 'samlee123',
			'createProfile.usernameTaken' => '¡Este nombre de usuario ya existe!',
			'createProfile.usernameAvailable' => 'Nombre de usuario disponible',
			'createProfile.mightWantToTry' => 'Quizá quieras probar...',
			'createProfile.stepPhoto' => '2/5 Foto de perfil',
			'createProfile.photoTitle' => 'Sube una foto de perfil',
			'createProfile.photoSubtitle' => 'Otros usuarios pueden ver tu foto de perfil para asegurarse de que eres tú.',
			'createProfile.photoSubtitleLine1' => 'Otros usuarios pueden ver tu foto de perfil',
			'createProfile.photoSubtitleLine2' => 'para asegurarse de que eres tú.',
			'createProfile.choosePhoto' => 'Elige una foto',
			'createProfile.continueWithoutPhoto' => 'Continuar sin foto de perfil',
			'createProfile.saveAndContinue' => 'Guardar y continuar',
			'createProfile.choosePhotoSheetTitle' => 'Elige una foto',
			'createProfile.takePhoto' => 'Tomar una foto',
			'createProfile.chooseFromGallery' => 'Elegir de la galería',
			'createProfile.stepGender' => '3/5 Género',
			'createProfile.genderTitle' => 'Elige tu género',
			'createProfile.genderSubtitle' => 'Si decides darnos esta información, podemos usarla para personalizar tu contenido',
			'createProfile.genderSubtitleLine1' => 'Si decides darnos esta información, podemos',
			'createProfile.genderSubtitleLine2' => 'usarla para personalizar tu contenido',
			'createProfile.genderFemale' => 'Mujer',
			'createProfile.genderMale' => 'Hombre',
			'createProfile.genderNonBinary' => 'No binario',
			'createProfile.genderPreferNotToSay' => 'Prefiero no decirlo',
			'createProfile.stepInterests' => '4/5 Intereses',
			'createProfile.interestsTitle' => '¿Qué te gusta?',
			'createProfile.interestsSubtitle' => 'Elige al menos 5: así te conectamos con personas que de verdad te entienden.',
			'createProfile.interests.music' => 'Música',
			'createProfile.interests.movies' => 'Películas',
			'createProfile.interests.tvShows' => 'Series',
			'createProfile.interests.reading' => 'Lectura',
			'createProfile.interests.painting' => 'Pintura',
			'createProfile.interests.photography' => 'Fotografía',
			'createProfile.interests.theatre' => 'Teatro',
			'createProfile.interests.fitness' => 'Fitness',
			'createProfile.interests.swimming' => 'Natación',
			'createProfile.interests.football' => 'Fútbol',
			'createProfile.interests.basketball' => 'Baloncesto',
			'createProfile.interests.coffee' => 'Café',
			'createProfile.interests.travel' => 'Viajes',
			'createProfile.interests.camping' => 'Camping',
			'createProfile.interests.meditation' => 'Meditación',
			'createProfile.interests.videoGames' => 'Videojuegos',
			'createProfile.interests.boardGames' => 'Juegos de mesa',
			'createProfile.interests.standUp' => 'Stand-up',
			'createProfile.interests.tech' => 'Tecnología',
			'createProfile.interests.coding' => 'Programación',
			'createProfile.interests.ai' => 'IA',
			'createProfile.interests.podcast' => 'Pódcasts',
			_ => null,
		} ?? switch (path) {
			'createProfile.stepChatGoal' => '5/5 Objetivo del chat',
			'createProfile.chatGoalTitle' => '¿Qué buscas hoy?',
			'createProfile.chatGoalSubtitle' => 'Así encontramos el match ideal para tu estado de ánimo actual.',
			'createProfile.chatGoalQuickMatch' => 'Match rápido: entra directo a una\nconversación',
			'createProfile.chatGoalFlirtyChat' => 'Coqueteo: conversaciones ligeras\ny divertidas',
			'createProfile.chatGoalMoodMatch' => 'Match por ánimo: según cómo te\nsientes',
			'createProfile.chatGoalLateNight' => 'Charla nocturna: conversaciones profundas\nmientras el mundo duerme',
			'createProfile.chatGoalMeetSomeoneNew' => 'Conocer a alguien: sin objetivo concreto,\nsolo explorar',
			'createProfile.getStarted' => 'Empezar',
			'createProfile.preparingTitleLine1' => 'Estamos preparando',
			'createProfile.preparingTitleLine2' => 'perfiles ideales',
			'createProfile.preparingTitleLine3' => 'para ti.',
			'createProfile.preparingSubtitleLine1' => 'Según tus respuestas, estamos eligiendo',
			'createProfile.preparingSubtitleLine2' => 'los mejores matches. Espera un momento.',
			'createProfile.preparingPercent' => ({required Object percent}) => '${percent}%',
			'createProfile.usernameInvalid' => 'Usa de 3 a 30 letras, números, puntos o guiones bajos.',
			'errors.network' => 'No se pudo conectar con Veylo. Revisa tu conexión e inténtalo de nuevo.',
			'errors.generic' => 'Algo salió mal. Inténtalo de nuevo.',
			'errors.signInFailed' => 'No se pudo iniciar sesión. Inténtalo de nuevo.',
			'errors.sessionExpired' => 'Tu sesión ha terminado. Vuelve a iniciar sesión.',
			'errors.accountSuspended' => 'Esta cuenta ha sido suspendida.',
			'errors.unsupportedImage' => 'Elige una foto JPEG, PNG o WebP.',
			'errors.fileTooLarge' => 'Este archivo es demasiado grande.',
			'errors.enterEmailForReset' => 'Introduce tu correo arriba para restablecer tu contraseña.',
			'errors.wrongCredentials' => 'El correo/usuario o la contraseña no son correctos.',
			'errors.emailInUse' => 'Este correo ya está registrado. Prueba a iniciar sesión.',
			'errors.weakPassword' => 'La contraseña debe tener al menos 6 caracteres.',
			'errors.invalidEmail' => 'Introduce un correo electrónico válido.',
			'errors.tooManyAttempts' => 'Demasiados intentos. Espera un poco e inténtalo de nuevo.',
			'errors.fillAllFields' => 'Completa todos los campos.',
			'errors.insufficientTokens' => 'No tienes suficientes tokens.',
			'errors.requestNotAccepted' => 'Acepta la solicitud para responder.',
			'errors.requestPendingLimit' => 'Podrás enviar más mensajes cuando acepte tu solicitud.',
			'errors.blocked' => 'No puedes enviar mensajes a esta persona.',
			'errors.peerUnavailable' => 'Esta cuenta ya no está disponible.',
			'errors.vibeDailyLimit' => 'Hoy compartiste muchos vibes. Inténtalo más tarde.',
			'errors.groupFull' => 'Este grupo está lleno.',
			'errors.groupCreateLimit' => 'Hoy creaste demasiados grupos. Inténtalo más tarde.',
			'errors.notFound' => 'Esto ya no está disponible.',
			'errors.recentLogin' => 'Por tu seguridad, cierra sesión, vuelve a iniciarla e inténtalo otra vez.',
			'errors.socialAccount' => 'Tu correo y contraseña se gestionan desde tu cuenta de Google o Apple.',
			'errors.alreadyInCall' => 'Ya estás en una llamada.',
			'errors.roomPrivate' => 'Esta sala es privada. Pide al anfitrión que te deje entrar.',
			'errors.roomFull' => 'Esta sala está llena.',
			'errors.alreadyCheckedIn' => 'Ya recogiste la recompensa de hoy.',
			'errors.purchasesUnavailable' => 'Las compras no están disponibles ahora.',
			'faq.q1' => '¿Cómo funciona esta app?',
			'faq.q2' => '¿Qué es el chat anónimo?',
			'faq.q3' => '¿Qué es el Progreso de conexión?',
			'faq.q4' => '¿Cómo revelo mi perfil?',
			'faq.q5' => '¿Qué es 60 segundos con un extraño?',
			'faq.q6' => '¿Qué son los Vibes?',
			'faq.q7' => '¿Cómo edito mi perfil?',
			'faq.q8' => '¿Cómo gestiono las notificaciones?',
			'faq.q9' => '¿Cómo restauro mis compras?',
			'faq.q10' => '¿Puedo eliminar todas las conversaciones?',
			'faq.q11' => '¿Están seguros mis datos?',
			'faq.q12' => '¿Cómo bloqueo o denuncio a alguien?',
			'faq.q13' => '¿Cómo comparto la app?',
			'faq.q14' => '¿Cómo elimino mi cuenta?',
			'faq.a1' => 'En Veylo puedes conocer gente nueva de forma anónima, chatear y revelar tu perfil poco a poco a medida que crece la conexión. Pasen a texto, voz o cara a cara cuando ambos se sientan listos.',
			'faq.a2' => 'En el chat anónimo tu identidad y tu foto permanecen ocultas. A medida que sube la conexión, desbloqueas detalles como la inicial del nombre y una foto borrosa. Al 100%, ambos deben aceptar para revelar los perfiles completos.',
			'faq.a3' => 'Mientras chateas, tu porcentaje de conexión aumenta. En ciertos hitos desbloqueas la inicial del nombre, una foto borrosa y el perfil completo. Toca la etiqueta Conexión para ver los detalles.',
			'faq.a4' => 'Cuando la conexión llegue al 100%, toca Revelar mi perfil. Si la otra persona también acepta, ambos perfiles completos serán visibles.',
			'faq.a5' => 'Desde la pestaña Llamada puedes conseguir un match breve al azar. Cuando se acabe el tiempo, puedes seguir hablando o colgar.',
			'faq.a6' => 'Vibes te permite descubrir personas cercanas o a tu alrededor en una vista de mapa o lista y empezar un chat con quien te interese.',
			'faq.a7' => 'Abre la pestaña Perfil y ve a Editar perfil para actualizar tu nombre, fotos, biografía e intereses. Los cambios aparecen al guardar.',
			'faq.a8' => 'Abre Notificaciones en Ajustes para activar o desactivar los avisos de mensajes, matches y más.',
			'faq.a9' => 'Ve a Ajustes → Gestión de la cuenta → Restaurar compras. Se restaurarán las compras válidas de la misma cuenta de la tienda.',
			'faq.a10' => 'Sí. Usa Ajustes → Eliminar conversaciones y confirma. Se borrarán todos los chats. Esto no se puede deshacer.',
			'faq.a11' => 'Los datos de tu cuenta y tus mensajes se guardan en sistemas protegidos. También puedes solicitar la eliminación de tu cuenta y datos desde Gestión de la cuenta cuando quieras.',
			'faq.a12' => 'Usa el menú de un perfil o de un chat para bloquear o denunciar. Nuestro equipo revisa las denuncias.',
			'faq.a13' => 'Usa Compartir la app en Ajustes para copiar el enlace y enviárselo a tus amigos.',
			'faq.a14' => 'Ve a Ajustes → Gestión de la cuenta → Eliminar cuenta y datos. Tras indicar un motivo, confirma para enviar tu solicitud de eliminación.',
			'legal.termsTitle' => 'Términos del servicio',
			'legal.privacyTitle' => 'Política de privacidad',
			'legal.termsBody' => 'Última actualización: 16 de marzo de 2026\n\nTe damos la bienvenida a Veylo. Al crear una cuenta o usar la app, aceptas estos Términos del servicio.\n\n1. Qué es Veylo\nVeylo es una app social donde puedes conocer gente, chatear de forma anónima, crear conexión con el tiempo y, si ambas partes están de acuerdo, pasar a llamadas de voz o cara a cara.\n\n2. Tu cuenta\nDebes proporcionar información precisa y mantener seguro tu inicio de sesión. Eres responsable de la actividad realizada con tu cuenta. Debes tener la edad suficiente para usar Veylo según las leyes de tu país.\n\n3. Uso respetuoso\nNo acoses, amenaces, estafes, suplantes a otras personas, compartas contenido ilegal ni intentes eludir las funciones de seguridad. Podemos eliminar contenido, limitar funciones o suspender cuentas que incumplan estas normas.\n\n4. Chat anónimo y revelación del perfil\nLos chats anónimos pueden ocultar tu nombre y tu foto hasta alcanzar ciertos hitos de conexión. Revelar el perfil completo requiere consentimiento mutuo. No presiones a otras personas para que revelen su identidad.\n\n5. Compras\nAlgunas funciones pueden ser de pago. Las compras se gestionan a través de Apple App Store o Google Play. Restaurar compras recupera las compras válidas de la misma cuenta de la tienda. Los reembolsos siguen la política de la tienda.\n\n6. Contenido que compartes\nConservas los derechos sobre tu contenido, pero otorgas a Veylo una licencia para alojarlo y mostrarlo en la app según sea necesario para prestar el servicio. No publiques contenido que no tengas derecho a compartir.\n\n7. Fin del uso\nPuedes dejar de usar Veylo en cualquier momento y solicitar la eliminación de tu cuenta desde Ajustes. También podemos finalizar o modificar el servicio con un aviso razonable cuando sea necesario.\n\n8. Contacto\nPreguntas sobre estos términos: support@veylo.app',
			'legal.privacyBody' => 'Última actualización: 16 de marzo de 2026\n\nEsta Política de privacidad explica cómo Veylo recopila, usa y protege tu información.\n\n1. Información que recopilamos\n• Datos de la cuenta: correo, nombre visible, fotos de perfil, biografía, preferencias\n• Datos de uso: chats, progreso de conexión, funciones de llamada que usas, datos básicos del dispositivo y la app\n• Compras: datos de recibos de la tienda necesarios para desbloquear y restaurar funciones de pago\n\n2. Cómo la usamos\nUsamos tus datos para operar Veylo, personalizar los matches y la experiencia de chat, mantener segura la comunidad, procesar compras y mejorar el producto. No vendemos tus datos personales.\n\n3. Modo anónimo\nEn los chats anónimos limitamos lo que ven los demás (por ejemplo, nombre oculto o foto borrosa) hasta que las reglas de desbloqueo y el consentimiento mutuo permitan mostrar más. Internamente seguimos necesitando identificadores de cuenta para operar la función de forma segura.\n\n4. Compartir datos\nPodemos compartir datos con proveedores de servicios que nos ayudan con el alojamiento, el análisis o el procesamiento de pagos, solo en la medida necesaria. También podemos divulgar información si lo exige la ley o para proteger a los usuarios de daños.\n\n5. Conservación\nConservamos los datos mientras tu cuenta esté activa y según sea necesario por motivos legales, de seguridad y de facturación. Una vez completada una solicitud de eliminación, eliminamos o anonimizamos los datos personales, salvo cuando sea obligatorio conservarlos.\n\n6. Tus opciones\nPuedes editar la información de tu perfil, gestionar las notificaciones, solicitar la eliminación de tu cuenta y contactarnos sobre tus datos. Las compras en la tienda también se gestionan a través de Apple o Google.\n\n7. Seguridad\nAplicamos medidas técnicas y organizativas razonables para proteger tu información. Ningún sistema es totalmente seguro; usa una contraseña segura y mantén tu dispositivo actualizado.\n\n8. Contacto\nPreguntas sobre privacidad: privacy@veylo.app',
			'logout.title' => 'Cerrar sesión',
			'logout.subtitle' => '¿Seguro que quieres cerrar sesión?',
			'logout.cancel' => 'Cancelar',
			'logout.confirm' => 'Cerrar sesión',
			'deleteAccount.title' => 'Enviar solicitud de eliminación de cuenta',
			'deleteAccount.subtitle' => '¿Seguro que quieres eliminar tu cuenta?',
			'deleteAccount.reasonTitle' => 'No queremos que te vayas, pero lo entendemos.',
			'deleteAccount.reasonBefore' => '¿Nos cuentas por qué quieres irte para que podamos mejorar la experiencia de ',
			'deleteAccount.reasonAfter' => '?',
			'deleteAccount.reasonLabel' => '¿Por qué quieres eliminar tu cuenta?',
			'deleteAccount.reasonHint' => 'Escribe tu mensaje',
			'deleteAccount.cancel' => 'Cancelar',
			'deleteAccount.createRequest' => 'Crear solicitud',
			'deleteAccount.confirmTitle' => '¿Seguro que quieres enviar una solicitud de eliminación?',
			'deleteAccount.confirmSubtitle' => 'Si confirmas, se enviará tu solicitud de eliminación de cuenta',
			'deleteAccount.delete' => 'Eliminar',
			'storyText.bold' => 'Negrita',
			'storyText.italic' => 'Cursiva',
			'storyText.uppercase' => 'Mayúsculas',
			'storyText.underline' => 'Subrayado',
			'storyText.cancel' => 'Cancelar',
			'storyText.galleryError' => 'No se pudo abrir la galería',
			'tokens.boostTitle' => 'Boost',
			'tokens.history' => 'Historial',
			'tokens.yourBalance' => 'Tu saldo',
			'tokens.balanceTokens' => ({required Object count}) => '${count} tokens',
			'tokens.getMore' => 'Consigue más tokens',
			'tokens.checkinTitle' => 'Check-in diario',
			'tokens.checkinSubtitle' => ({required Object max}) => 'Recoge cada día seguido y gana hasta ${max} tokens al día',
			'tokens.day' => ({required Object n}) => 'Día ${n}',
			'tokens.collectDay' => ({required Object n}) => 'Recoger tokens del día ${n}',
			'tokens.collectedToday' => ({required Object n}) => 'Vuelve mañana para el día ${n}',
			'tokens.duration30m' => '30 minutos',
			'tokens.duration1h' => '1 hora',
			'tokens.duration2h' => '2 horas',
			'tokens.visibility' => ({required Object n}) => 'Visibilidad x${n}',
			'tokens.boostFor' => ({required Object count}) => 'Boost por ${count} tokens',
			'tokens.boostActive' => ({required Object time}) => 'Boost activo hasta las ${time}',
			'tokens.boostDone' => '¡Tu perfil tiene Boost!',
			'tokens.historyEmpty' => 'Aún no hay actividad de tokens',
			'tokens.balanceLine' => ({required Object count}) => 'Tu saldo: ${count} tokens',
			'tokens.reasonPurchase' => 'Compra de tokens',
			'tokens.reasonCheckin' => 'Check-in diario',
			'tokens.reasonWelcome' => 'Bono de bienvenida',
			'tokens.reasonGenderFilter' => 'Llamada con filtro de género',
			'tokens.reasonVideoCall' => 'Videollamada',
			'tokens.reasonRoomCreate' => 'Crear sala',
			'tokens.reasonBorder' => 'Marco de perfil',
			'tokens.reasonPostBoost' => 'Boost de publicación',
			'tokens.reasonRefund' => 'Reembolso',
			'tokens.reasonAdjust' => 'Ajuste de saldo',
			'tokens.packsTitle' => 'Consigue más tokens',
			'tokens.packsSubtitle' => 'Elige un paquete de tokens',
			'tokens.packTokens' => ({required Object count}) => '${count} tokens',
			'tokens.buy' => 'Comprar',
			'tokens.purchaseDone' => ({required Object count}) => '${count} tokens añadidos a tu saldo',
			'tokens.notEnoughTitle' => 'No tienes suficientes tokens',
			'tokens.notEnoughSubtitle' => 'Recarga tu saldo para continuar.',
			_ => null,
		};
	}
}
