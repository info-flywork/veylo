/// Küfür / müstehcenlik / taciz kelime filtresi (TR + EN).
/// App Store Guideline 1.2 — gönderi ve mesaj öncesi istemci kontrolü.
abstract final class ContentFilter {
  static const _blocked = <String>[
    'amk',
    'aq',
    'orospu',
    'siktir',
    'sikeyim',
    'sikerim',
    'sikik',
    'amina',
    'amına',
    'gotun',
    'götün',
    'götü',
    'pic',
    'piç',
    'yarrak',
    'yarak',
    'dassak',
    'daşşak',
    'porno',
    'porn',
    'sex',
    'seks',
    'nude',
    'ciplak',
    'çıplak',
    'sakso',
    'kahpe',
    'gavat',
    'ibne',
    'fuck',
    'fucker',
    'fucking',
    'shit',
    'bitch',
    'asshole',
    'dick',
    'cock',
    'pussy',
    'cunt',
    'slut',
    'whore',
    'nigger',
    'nigga',
    'faggot',
    'retard',
    'rape',
    'onlyfans',
    'nsfw',
  ];

  static final _pattern = RegExp(
    '(?:^|[^\\p{L}\\p{N}])(${_blocked.map(RegExp.escape).join('|')})(?:\$|[^\\p{L}\\p{N}])',
    caseSensitive: false,
    unicode: true,
  );

  static bool isObjectionable(String? text) {
    if (text == null || text.trim().isEmpty) return false;
    final normalized = text.toLowerCase().replaceAll(RegExp(r'[\u200B-\u200D\uFEFF]'), '');
    return _pattern.hasMatch(' $normalized ');
  }
}
