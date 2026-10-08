import 'package:flutter/foundation.dart';

/// Share sonrası Discover’da gösterilen highlight (geçici, local).
class DiscoverHighlight {
  DiscoverHighlight._();
  static final DiscoverHighlight instance = DiscoverHighlight._();

  final ValueNotifier<String?> imagePath = ValueNotifier<String?>(null);

  bool get hasHighlight => imagePath.value != null;

  void set(String path) => imagePath.value = path;

  void clear() => imagePath.value = null;
}
