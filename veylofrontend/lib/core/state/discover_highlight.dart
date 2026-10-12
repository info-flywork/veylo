import 'package:flutter/foundation.dart';

/// Paylaşım sonrası Discover'da gösterilen "paylaşıldı / öne çıkar" bandı.
class DiscoverHighlight {
  DiscoverHighlight._();
  static final DiscoverHighlight instance = DiscoverHighlight._();

  /// Paylaşılan görselin yerel yolu (bant küçük resmi).
  final ValueNotifier<String?> imagePath = ValueNotifier<String?>(null);

  /// Sunucudaki gönderi (istatistik ve boost için).
  String? postId;

  bool get hasHighlight => imagePath.value != null;

  void set(String path, {String? postId}) {
    this.postId = postId;
    imagePath.value = path;
  }

  void clear() {
    postId = null;
    imagePath.value = null;
  }
}
