import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/i18n/strings.g.dart';

/// Vibes akışındaki tek kart (`GET /vibes`).
class VibePost {
  const VibePost({
    required this.id,
    required this.name,
    required this.body,
    required this.likeCount,
    required this.createdAt,
    this.avatarUrl,
    this.authorId,
    this.username,
    this.blurred = false,
    this.likedByMe = false,
    this.isMine = false,
    this.isAi = false,
  });

  final String id;
  final String name;
  final String body;
  final int likeCount;
  final DateTime createdAt;

  /// Anonim vibe'da sunucunun bulanık önizlemesi (yoksa null).
  final String? avatarUrl;

  /// Anonim vibe'da null: yazarın kimliği istemciye gelmez.
  final String? authorId;
  final String? username;
  final bool blurred;
  final bool likedByMe;
  final bool isMine;

  /// Yazar Veylo'nun AI karakteri ("AI" rozeti).
  final bool isAi;

  /// Avatar widget'ları için: fotoğraf yoksa varsayılan görsel.
  String get avatarAsset => (avatarUrl == null || avatarUrl!.isEmpty)
      ? AppAssets.strangerAvatar
      : avatarUrl!;

  /// Kartta gösterilen tarih, seçilen dile göre.
  String get dateLabel {
    const months = {
      'tr': ['Oca', 'Şub', 'Mar', 'Nis', 'May', 'Haz', 'Tem', 'Ağu', 'Eyl', 'Eki', 'Kas', 'Ara'],
      'de': ['Jan', 'Feb', 'Mär', 'Apr', 'Mai', 'Jun', 'Jul', 'Aug', 'Sep', 'Okt', 'Nov', 'Dez'],
      'it': ['gen', 'feb', 'mar', 'apr', 'mag', 'giu', 'lug', 'ago', 'set', 'ott', 'nov', 'dic'],
      'fr': ['janv.', 'févr.', 'mars', 'avr.', 'mai', 'juin', 'juil.', 'août', 'sept.', 'oct.', 'nov.', 'déc.'],
      'es': ['ene', 'feb', 'mar', 'abr', 'may', 'jun', 'jul', 'ago', 'sept', 'oct', 'nov', 'dic'],
      'pt': ['jan', 'fev', 'mar', 'abr', 'mai', 'jun', 'jul', 'ago', 'set', 'out', 'nov', 'dez'],
      'ru': ['янв', 'фев', 'мар', 'апр', 'май', 'июн', 'июл', 'авг', 'сен', 'окт', 'ноя', 'дек'],
      'hi': ['जन', 'फर', 'मार', 'अप्रै', 'मई', 'जून', 'जुल', 'अग', 'सित', 'अक्टू', 'नव', 'दिस'],
      'en': ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
    };
    final d = createdAt;
    final code = LocaleSettings.currentLocale.languageCode;
    if (code == 'ja' || code == 'zh') return '${d.year}年${d.month}月${d.day}日';
    if (code == 'ko') return '${d.year}년 ${d.month}월 ${d.day}일';
    final names = months[code] ?? months['en']!;
    return '${d.day} ${names[d.month - 1]} ${d.year}';
  }

  factory VibePost.fromJson(Map<String, dynamic> j) {
    final author = j['author'] as Map<String, dynamic>? ?? const {};
    return VibePost(
      id: j['id'] as String,
      name: author['displayName'] as String? ?? '',
      body: j['body'] as String? ?? '',
      likeCount: (j['likeCount'] as num?)?.toInt() ?? 0,
      createdAt:
          DateTime.tryParse(j['createdAt'] as String? ?? '')?.toLocal() ??
          DateTime.now(),
      avatarUrl: author['avatarUrl'] as String?,
      authorId: author['id'] as String?,
      username: author['username'] as String?,
      blurred: author['avatarBlurred'] as bool? ?? false,
      likedByMe: j['likedByMe'] as bool? ?? false,
      isMine: j['isMine'] as bool? ?? false,
      isAi: author['isAi'] as bool? ?? false,
    );
  }

  VibePost copyWith({int? likeCount, bool? likedByMe}) => VibePost(
    id: id,
    name: name,
    body: body,
    likeCount: likeCount ?? this.likeCount,
    createdAt: createdAt,
    avatarUrl: avatarUrl,
    authorId: authorId,
    username: username,
    blurred: blurred,
    likedByMe: likedByMe ?? this.likedByMe,
    isMine: isMine,
    isAi: isAi,
  );
}
