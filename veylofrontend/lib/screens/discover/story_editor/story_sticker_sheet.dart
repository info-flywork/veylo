import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:veylo/core/config/app_config.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/screens/chat/chat_sticker_pack.dart';

/// Çıkartma / GIF seçici. Asset yolu veya GIF URL döner.
Future<String?> showStoryStickerSheet(
  BuildContext context, {
  bool dark = true,
}) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: dark ? const Color(0xFF1C1C1E) : AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => _StoryStickerSheet(dark: dark),
  );
}

class _StoryStickerSheet extends StatefulWidget {
  const _StoryStickerSheet({required this.dark});

  final bool dark;

  @override
  State<_StoryStickerSheet> createState() => _StoryStickerSheetState();
}

class _StoryStickerSheetState extends State<_StoryStickerSheet>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;
  final _search = TextEditingController();
  final _gifs = <_GifItem>[];
  bool _gifLoading = false;
  String? _gifError;
  Timer? _debounce;

  bool get _dark => widget.dark;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 2, vsync: this);
    _tabs.addListener(() {
      if (_tabs.index == 0 && _gifs.isEmpty && !_gifLoading) {
        _loadGifs();
      }
    });
    _loadGifs();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _tabs.dispose();
    _search.dispose();
    super.dispose();
  }

  Future<void> _loadGifs([String query = '']) async {
    setState(() {
      _gifLoading = true;
      _gifError = null;
    });
    try {
      final q = query.trim();
      final path = q.isEmpty ? '/gifs/trending' : '/gifs/search';
      final res = await Dio().get<Map<String, dynamic>>(
        '${AppConfig.gifApiBaseUrl}$path',
        queryParameters: {
          'limit': 30,
          if (q.isNotEmpty) 'q': q,
        },
        options: Options(receiveTimeout: const Duration(seconds: 12)),
      );
      final data = res.data ?? const <String, dynamic>{};
      final results = data['data'] as List? ?? const [];
      final items = <_GifItem>[];
      for (final raw in results) {
        final map = raw as Map<String, dynamic>;
        final url = map['url'] as String?;
        if (url == null || url.isEmpty) continue;
        final preview = map['preview_url'] as String? ?? url;
        final animated = map['animated_preview'];
        final animatedUrl = animated is Map
            ? animated['url'] as String?
            : null;
        items.add(
          _GifItem(
            url: url,
            previewUrl: animatedUrl ?? preview,
          ),
        );
      }
      if (!mounted) return;
      setState(() {
        _gifs
          ..clear()
          ..addAll(items);
        _gifLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _gifLoading = false;
        _gifError = e.toString();
      });
    }
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      _loadGifs(value);
    });
  }

  Color get _muted =>
      _dark ? AppColors.white.withValues(alpha: 0.55) : AppColors.navInactive;

  Color get _fg => _dark ? AppColors.white : AppColors.black;

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;
    final height = MediaQuery.sizeOf(context).height * 0.55;
    final stickers = [for (final list in chatStickerPack.values) ...list];

    return SizedBox(
      height: height + bottom,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 10, 16, bottom),
        child: Column(
          children: [
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: _dark
                    ? AppColors.white.withValues(alpha: 0.25)
                    : AppColors.progressTrack,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            const SizedBox(height: 12),
            TabBar(
              controller: _tabs,
              labelColor: _fg,
              unselectedLabelColor: _muted,
              indicatorColor: AppColors.brandPurple,
              indicatorSize: TabBarIndicatorSize.label,
              dividerColor: Colors.transparent,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
              tabs: const [
                Tab(text: 'GIF'),
                Tab(text: 'Sticker'),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: TabBarView(
                controller: _tabs,
                children: [
                  _GifTab(
                    dark: _dark,
                    loading: _gifLoading,
                    error: _gifError,
                    gifs: _gifs,
                    search: _search,
                    onSearchChanged: _onSearchChanged,
                    onRetry: () => _loadGifs(_search.text),
                    muted: _muted,
                    fg: _fg,
                  ),
                  GridView.builder(
                    padding: const EdgeInsets.only(bottom: 16, top: 4),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: stickers.length,
                    itemBuilder: (context, index) {
                      final asset = stickers[index];
                      return GestureDetector(
                        onTap: () => Navigator.of(context).pop(asset),
                        behavior: HitTestBehavior.opaque,
                        child: Image.asset(asset, fit: BoxFit.contain),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GifItem {
  const _GifItem({required this.url, required this.previewUrl});

  final String url;
  final String previewUrl;
}

class _GifTab extends StatelessWidget {
  const _GifTab({
    required this.dark,
    required this.loading,
    required this.error,
    required this.gifs,
    required this.search,
    required this.onSearchChanged,
    required this.onRetry,
    required this.muted,
    required this.fg,
  });

  final bool dark;
  final bool loading;
  final String? error;
  final List<_GifItem> gifs;
  final TextEditingController search;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onRetry;
  final Color muted;
  final Color fg;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: search,
          onChanged: onSearchChanged,
          style: TextStyle(color: fg, fontSize: 14),
          cursorColor: AppColors.brandPurple,
          decoration: InputDecoration(
            hintText: 'GIF ara',
            hintStyle: TextStyle(color: muted),
            prefixIcon: Icon(Icons.search_rounded, color: muted, size: 20),
            filled: true,
            fillColor: dark
                ? AppColors.white.withValues(alpha: 0.08)
                : AppColors.sheetMuted,
            contentPadding: const EdgeInsets.symmetric(vertical: 0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: loading && gifs.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : error != null && gifs.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'GIF’ler yüklenemedi',
                            style: TextStyle(color: muted),
                          ),
                          TextButton(
                            onPressed: onRetry,
                            child: const Text('Tekrar dene'),
                          ),
                        ],
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.only(bottom: 16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                      ),
                      itemCount: gifs.length,
                      itemBuilder: (context, index) {
                        final item = gifs[index];
                        return GestureDetector(
                          onTap: () => Navigator.of(context).pop(item.url),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: ColoredBox(
                              color: dark
                                  ? AppColors.white.withValues(alpha: 0.06)
                                  : AppColors.sheetMuted,
                              child: CachedNetworkImage(
                                imageUrl: item.previewUrl,
                                fit: BoxFit.cover,
                                placeholder: (_, _) => Center(
                                  child: SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: muted,
                                    ),
                                  ),
                                ),
                                errorWidget: (_, _, _) => Icon(
                                  Icons.broken_image_outlined,
                                  color: muted,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
        ),
      ],
    );
  }
}
