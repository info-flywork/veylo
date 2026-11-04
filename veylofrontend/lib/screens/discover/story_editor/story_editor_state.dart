import 'package:flutter/material.dart';
import 'package:veylo/models/discover/post.dart';
import 'package:veylo/screens/discover/story_editor/story_music_sheet.dart';
import 'package:veylo/screens/discover/story_editor/story_text_tools_sheet.dart';

/// Editör katmanları: gönderiyle sunucuda saklanır, "Düzenle"de editör aynı haliyle açılır.
/// Konumlar kaydedildiği ekranın boyutuyla birlikte tutulur; başka telefonda oranlanır.
class StoryEditorLayers {
  const StoryEditorLayers({
    required this.screen,
    required this.text,
    required this.textOffset,
    required this.textScale,
    required this.textRotation,
    required this.stickers,
    this.music,
  });

  static const _version = 1;

  final Size screen;
  final StoryTextDraft text;
  final Offset textOffset;
  final double textScale;
  final double textRotation;
  final List<({String asset, Offset center})> stickers;
  final StoryMusicTrack? music;

  Map<String, Object?> toJson() => {
    'v': _version,
    'screen': [screen.width, screen.height],
    'text': {
      'text': text.text,
      'fontId': text.fontId,
      'bold': text.bold,
      'italic': text.italic,
      'underline': text.underline,
      'uppercase': text.uppercase,
      'align': text.align.name,
      'fontSize': text.fontSize,
      'letterSpacing': text.letterSpacing,
      'lineHeight': text.lineHeight,
      'color': text.color.toARGB32(),
    },
    'textOffset': [textOffset.dx, textOffset.dy],
    'textScale': textScale,
    'textRotation': textRotation,
    'stickers': [
      for (final s in stickers)
        {'asset': s.asset, 'center': [s.center.dx, s.center.dy]},
    ],
    if (music != null)
      'music': {
        'title': music!.title,
        'artist': music!.artist,
        'durationSec': music!.durationSec,
        'durationLabel': music!.durationLabel,
        'imageUrl': music!.imageUrl,
        'audioUrl': music!.audioUrl,
        'genre': music!.genre,
        'clipStartSec': music!.clipStartSec,
        'clipEndSec': music!.clipEndSec,
      },
  };

  /// Kaydedilmiş katmanları [screen] boyutundaki editöre uyarlar. Bozuk veri → null.
  static StoryEditorLayers? fromPost(Post post, Size screen) {
    final j = post.editorState;
    final music = _musicFrom(j?['music']) ?? _musicFromPost(post.music);
    if (j == null) {
      return music == null ? null : _empty(screen, music);
    }
    try {
      final saved = j['screen'] as List;
      final sx = screen.width / (saved[0] as num).toDouble();
      final sy = screen.height / (saved[1] as num).toDouble();
      final t = Map<String, dynamic>.from(j['text'] as Map);
      final offset = j['textOffset'] as List;
      return StoryEditorLayers(
        screen: screen,
        text: StoryTextDraft(
          text: t['text'] as String? ?? '',
          fontId: t['fontId'] as String? ?? 'montserrat',
          bold: t['bold'] as bool? ?? false,
          italic: t['italic'] as bool? ?? false,
          underline: t['underline'] as bool? ?? false,
          uppercase: t['uppercase'] as bool? ?? false,
          align: TextAlign.values.asNameMap()[t['align']] ?? TextAlign.center,
          fontSize: (t['fontSize'] as num?)?.toDouble() ?? 28,
          letterSpacing: (t['letterSpacing'] as num?)?.toDouble() ?? 0,
          lineHeight: (t['lineHeight'] as num?)?.toDouble() ?? 1.2,
          color: Color((t['color'] as num?)?.toInt() ?? 0xFFFFFFFF),
        ),
        textOffset: Offset(
          (offset[0] as num).toDouble() * sx,
          (offset[1] as num).toDouble() * sy,
        ),
        // Genişliğe göre ölçeklenir: yazı başka telefonda da aynı oranda kalır.
        textScale: ((j['textScale'] as num?)?.toDouble() ?? 1) * sx,
        textRotation: (j['textRotation'] as num?)?.toDouble() ?? 0,
        stickers: [
          for (final raw in (j['stickers'] as List? ?? const []))
            (
              asset: (raw as Map)['asset'] as String,
              center: Offset(
                ((raw['center'] as List)[0] as num).toDouble() * sx,
                ((raw['center'] as List)[1] as num).toDouble() * sy,
              ),
            ),
        ],
        music: music,
      );
    } catch (_) {
      return music == null ? null : _empty(screen, music);
    }
  }

  static StoryEditorLayers _empty(Size screen, StoryMusicTrack music) =>
      StoryEditorLayers(
        screen: screen,
        text: const StoryTextDraft(),
        textOffset: const Offset(0, -80),
        textScale: 1,
        textRotation: 0,
        stickers: const [],
        music: music,
      );

  static StoryMusicTrack? _musicFrom(Object? raw) {
    if (raw is! Map) return null;
    final title = raw['title'] as String?;
    if (title == null || title.isEmpty) return null;
    return StoryMusicTrack(
      title: title,
      artist: raw['artist'] as String? ?? '',
      durationSec: (raw['durationSec'] as num?)?.toInt() ?? 0,
      durationLabel: raw['durationLabel'] as String? ?? '',
      imageUrl: raw['imageUrl'] as String?,
      audioUrl: raw['audioUrl'] as String?,
      genre: raw['genre'] as String?,
      clipStartSec: (raw['clipStartSec'] as num?)?.toInt() ?? 0,
      clipEndSec: (raw['clipEndSec'] as num?)?.toInt() ?? 0,
    );
  }

  /// Katman verisi olmayan eski gönderi: müziği gönderinin kendi alanından.
  static StoryMusicTrack? _musicFromPost(PostMusic? m) {
    if (m == null || m.title.isEmpty) return null;
    return StoryMusicTrack(
      title: m.title,
      artist: m.artist ?? '',
      durationSec: 0,
      durationLabel: '',
      imageUrl: m.coverUrl,
      audioUrl: m.audioUrl,
      clipStartSec: m.clipStartSec,
      clipEndSec: m.clipEndSec ?? 0,
    );
  }
}
