import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/data/remote/discover_store.dart';
import 'package:veylo/data/remote/post_repository.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/models/discover/post.dart';

/// Kamera → TASLAK: kayıtlı taslaklar galeri gibi; dokununca önizle, paylaş/sil.
class StoryDraftsPage extends StatefulWidget {
  const StoryDraftsPage({super.key});

  static Future<void> open(BuildContext context) {
    return Navigator.of(context).push<void>(
      MaterialPageRoute<void>(builder: (_) => const StoryDraftsPage()),
    );
  }

  @override
  State<StoryDraftsPage> createState() => _StoryDraftsPageState();
}

class _StoryDraftsPageState extends State<StoryDraftsPage> {
  List<Post>? _drafts;
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final items = await PostRepository.instance.drafts();
      if (mounted) setState(() => _drafts = items);
    } catch (_) {
      if (mounted) setState(() => _failed = true);
    }
  }

  Future<void> _open(Post draft) async {
    final gone = await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(builder: (_) => _DraftPreviewPage(draft: draft)),
    );
    // Paylaşıldı ya da silindi: listeden çıkar.
    if (gone == true && mounted) {
      setState(() => _drafts = [
        for (final d in _drafts ?? const <Post>[])
          if (d.id != draft.id) d,
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).discover.story;
    final top = MediaQuery.paddingOf(context).top;
    final bottom = MediaQuery.paddingOf(context).bottom;
    final drafts = _drafts;

    Widget body;
    if (drafts == null && !_failed) {
      body = const Center(
        child: CircularProgressIndicator(color: AppColors.white),
      );
    } else if (drafts == null || drafts.isEmpty) {
      body = Center(
        child: AppText(
          _failed ? t.draftsError : t.draftsEmpty,
          style: AppTextStyles.storyModeIdle,
        ),
      );
    } else {
      body = GridView.builder(
        padding: EdgeInsets.fromLTRB(2, 0, 2, bottom + 2),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          childAspectRatio: 9 / 16,
        ),
        itemCount: drafts.length,
        itemBuilder: (context, i) {
          final d = drafts[i];
          final url = d.thumbUrl.isNotEmpty ? d.thumbUrl : d.mediaUrl;
          return GestureDetector(
            onTap: () => _open(d),
            child: ColoredBox(
              color: AppColors.white.withValues(alpha: 0.08),
              child: url.isEmpty
                  ? null
                  : Image(
                      image: CachedNetworkImageProvider(url),
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => const SizedBox.shrink(),
                    ),
            ),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: top + 10),
          SizedBox(
            height: 44,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 16,
                  child: _CloseButton(
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ),
                AppText(t.drafts, style: AppTextStyles.storyModeActive),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(child: body),
        ],
      ),
    );
  }
}

/// Tek taslak tam ekran; alt çubukta sil + paylaş (editörle aynı yapı).
class _DraftPreviewPage extends StatefulWidget {
  const _DraftPreviewPage({required this.draft});

  final Post draft;

  @override
  State<_DraftPreviewPage> createState() => _DraftPreviewPageState();
}

class _DraftPreviewPageState extends State<_DraftPreviewPage> {
  bool _busy = false;

  Future<void> _run(Future<void> Function() action, [String? doneText]) async {
    if (_busy) return;
    setState(() => _busy = true);
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    try {
      await action();
      navigator.pop(true);
      if (doneText != null) {
        messenger.showSnackBar(
          SnackBar(content: Text(doneText), behavior: SnackBarBehavior.floating),
        );
      }
    } catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _share() {
    final t = Translations.of(context).discover.story;
    return _run(() async {
      await PostRepository.instance.publish(widget.draft.id);
      DiscoverStore.instance.refresh();
    }, t.published);
  }

  Future<void> _delete() async {
    final tr = Translations.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(tr.discover.story.deleteDraftPrompt),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(tr.vibes.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(tr.discover.story.delete),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    await _run(() => PostRepository.instance.delete(widget.draft.id));
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).discover.story;
    final top = MediaQuery.paddingOf(context).top;
    final bottom = MediaQuery.paddingOf(context).bottom;
    final d = widget.draft;

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image(
            image: CachedNetworkImageProvider(d.mediaUrl),
            fit: BoxFit.cover,
            frameBuilder: (_, child, frame, sync) =>
                frame == null && !sync && d.thumbUrl.isNotEmpty
                    ? Image(
                        image: CachedNetworkImageProvider(d.thumbUrl),
                        fit: BoxFit.cover,
                      )
                    : child,
            errorBuilder: (_, _, _) => const SizedBox.shrink(),
          ),
          Positioned(
            top: top + 10,
            left: 16,
            child: _CloseButton(
              onTap: () => Navigator.of(context).pop(),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + bottom),
                  color: AppColors.black.withValues(alpha: 0.70),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: _busy ? null : _delete,
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.black.withValues(alpha: 0.50),
                          ),
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            AppAssets.iconTrash,
                            width: 24,
                            height: 24,
                            colorFilter: const ColorFilter.mode(
                              AppColors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          height: 52,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(999),
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  AppColors.brandPurpleSoft,
                                  AppColors.brandPurpleDeep,
                                ],
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: _busy ? null : _share,
                                  borderRadius: BorderRadius.circular(999),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(999),
                                      gradient: const LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          AppColors.brandPurple,
                                          AppColors.brandPurpleLight,
                                        ],
                                      ),
                                      border: Border.all(
                                        width: 0.6,
                                        color: AppColors.white
                                            .withValues(alpha: 0.33),
                                      ),
                                    ),
                                    child: _busy
                                        ? const Center(
                                            child: SizedBox(
                                              width: 22,
                                              height: 22,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: AppColors.white,
                                              ),
                                            ),
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                AppAssets.iconStorySend,
                                                width: 22,
                                                height: 22,
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                  AppColors.white,
                                                  BlendMode.srcIn,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              AppText(
                                                t.share,
                                                style: AppTextStyles.storyShare,
                                              ),
                                            ],
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SvgPicture.asset(
        AppAssets.iconStoryClose,
        width: 32,
        height: 32,
        colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
      ),
    );
  }
}
