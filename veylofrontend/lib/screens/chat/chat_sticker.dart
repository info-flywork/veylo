import 'package:flutter/material.dart';
import 'package:veylo/screens/chat/chat_sticker_pack.dart';

/// Sohbette çıkartma: metin olarak `sticker:<asset>` gider, balonda görsel çizilir.
abstract final class ChatSticker {
  static const prefix = 'sticker:';

  static final Set<String> _assets = {
    for (final list in chatStickerPack.values) ...list,
  };

  static String encode(String asset) => '$prefix$asset';

  /// Paketteki bir dosya ise yolu, değilse null.
  static String? assetOf(String? body) {
    if (body == null || !body.startsWith(prefix)) return null;
    final path = body.substring(prefix.length);
    return _assets.contains(path) ? path : null;
  }
}

class ChatStickerImage extends StatelessWidget {
  const ChatStickerImage({super.key, required this.asset});

  final String asset;

  @override
  Widget build(BuildContext context) {
    return Image.asset(asset, width: 112, height: 112, fit: BoxFit.contain);
  }
}
