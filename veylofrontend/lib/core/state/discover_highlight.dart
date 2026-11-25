import 'dart:async';

import 'package:flutter/foundation.dart';

/// Paylaşım sonrası Discover'da gösterilen "paylaşıldı / öne çıkar" bandı.
class DiscoverHighlight {
  DiscoverHighlight._();
  static final DiscoverHighlight instance = DiscoverHighlight._();

  static const _autoClearAfter = Duration(seconds: 30);

  /// Paylaşılan görselin yerel yolu (bant küçük resmi).
  final ValueNotifier<String?> imagePath = ValueNotifier<String?>(null);

  /// Sunucudaki gönderi (istatistik ve boost için).
  String? postId;

  Timer? _autoClear;

  bool get hasHighlight => imagePath.value != null;

  void set(String path, {String? postId}) {
    this.postId = postId;
    imagePath.value = path;
    _autoClear?.cancel();
    _autoClear = Timer(_autoClearAfter, clear);
  }

  void clear() {
    _autoClear?.cancel();
    _autoClear = null;
    postId = null;
    imagePath.value = null;
  }
}
