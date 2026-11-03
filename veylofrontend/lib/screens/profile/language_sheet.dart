import 'package:flutter/material.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/data/remote/push_service.dart';
import 'package:veylo/data/remote/vibe_store.dart';
import 'package:veylo/i18n/strings.g.dart';

/// Zovi tarzı dil seçim sheet'i. Bayraklar assets/flags altında.
enum AppLanguage {
  english('en', AppAssets.flagEnglish, 'English'),
  german('de', AppAssets.flagGerman, 'Deutsch'),
  italian('it', AppAssets.flagItalian, 'Italiano'),
  french('fr', AppAssets.flagFrench, 'Français'),
  turkish('tr', AppAssets.flagTurkish, 'Türkçe'),
  japanese('ja', AppAssets.flagJapanese, '日本語'),
  spanish('es', AppAssets.flagSpanish, 'Español'),
  russian('ru', AppAssets.flagRussian, 'Русский'),
  korean('ko', AppAssets.flagKorean, '한국어'),
  hindi('hi', AppAssets.flagHindi, 'हिन्दी'),
  portuguese('pt', AppAssets.flagPortuguese, 'Português'),
  chinese('zh', AppAssets.flagChinese, '中文');

  const AppLanguage(this.code, this.flagAsset, this.label);

  final String code;
  final String flagAsset;
  final String label;

  static AppLanguage fromCode(String code) {
    return AppLanguage.values.firstWhere(
      (language) => language.code == code,
      orElse: () => AppLanguage.turkish,
    );
  }
}

Future<AppLanguage?> showLanguageSheet(BuildContext context) {
  final current = AppLanguage.fromCode(
    LocaleSettings.currentLocale.languageCode,
  );
  return showModalBottomSheet<AppLanguage>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => _LanguageSheet(initial: current),
  );
}

/// Edit Profile > Languages — konuştuğu diller (çoklu seçim). Dil kodlarını döner;
/// boş liste = "Not set". Uygulama dili ayrıca [showLanguageSheet] ile seçilir.
Future<List<String>?> showSpokenLanguagesSheet(
  BuildContext context, {
  List<String> initial = const [],
}) {
  return showModalBottomSheet<List<String>>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => _SpokenLanguagesSheet(initial: initial.toSet()),
  );
}

class _SpokenLanguagesSheet extends StatefulWidget {
  const _SpokenLanguagesSheet({required this.initial});

  final Set<String> initial;

  @override
  State<_SpokenLanguagesSheet> createState() => _SpokenLanguagesSheetState();
}

class _SpokenLanguagesSheetState extends State<_SpokenLanguagesSheet> {
  late final Set<String> _selected = {...widget.initial};

  void _toggle(AppLanguage language) {
    setState(() {
      if (!_selected.remove(language.code)) _selected.add(language.code);
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Column(
                  children: [
                    Container(
                      width: 46,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.sheetHandle,
                        borderRadius: BorderRadius.circular(9999),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        t.profile.languages,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: AppFonts.poppins,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          height: 1,
                          letterSpacing: 24 * -0.02,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  itemCount: AppLanguage.values.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final language = AppLanguage.values[index];
                    return _LanguageRow(
                      language: language,
                      selected: _selected.contains(language.code),
                      showCheck: true,
                      onTap: () => _toggle(language),
                    );
                  },
                ),
              ),
              SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  child: _BlackSaveButton(
                    label: t.common.save,
                    onPressed: () => Navigator.of(context).pop([
                      // Sabit sıra (sunucu ve satır etiketi tutarlı olsun).
                      for (final l in AppLanguage.values)
                        if (_selected.contains(l.code)) l.code,
                    ]),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LanguageSheet extends StatefulWidget {
  const _LanguageSheet({required this.initial});

  final AppLanguage initial;

  @override
  State<_LanguageSheet> createState() => _LanguageSheetState();
}

class _LanguageSheetState extends State<_LanguageSheet> {
  late AppLanguage _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initial;
  }

  void _apply() {
    // slang yalnızca desteklediği locale'e geçer, diğerlerinde base'e düşer.
    LocaleSettings.setLocaleRaw(_selected.code);
    PushService.instance.setLanguage(_selected.code);
    VibeStore.instance.refresh();
    Navigator.of(context).pop(_selected);
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).common;

    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Column(
                  children: [
                    Container(
                      width: 46,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.sheetHandle,
                        borderRadius: BorderRadius.circular(9999),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        t.language,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: AppFonts.poppins,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          height: 1,
                          letterSpacing: 24 * -0.02,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  itemCount: AppLanguage.values.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final language = AppLanguage.values[index];
                    return _LanguageRow(
                      language: language,
                      selected: language == _selected,
                      onTap: () => setState(() => _selected = language),
                    );
                  },
                ),
              ),
              SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  child: _BlackSaveButton(
                    label: t.save,
                    onPressed: _apply,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LanguageRow extends StatelessWidget {
  const _LanguageRow({
    required this.language,
    required this.selected,
    required this.onTap,
    this.showCheck = false,
  });

  final AppLanguage language;
  final bool selected;
  final VoidCallback onTap;

  /// Çoklu seçimde seçili satırın sonunda onay işareti.
  final bool showCheck;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            ClipOval(
              child: SvgPicture.asset(
                language.flagAsset,
                width: 37,
                height: 37,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                language.label,
                style: TextStyle(
                  fontFamily: AppFonts.poppins,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                  letterSpacing: -0.16,
                  color: selected ? AppColors.brandPurple : AppColors.black,
                ),
              ),
            ),
            if (showCheck && selected)
              const Icon(
                Icons.check_rounded,
                size: 22,
                color: AppColors.brandPurple,
              ),
          ],
        ),
      ),
    );
  }
}

/// Profil düzenleme pencereleriyle aynı siyah Kaydet (Figma: #1A1714, 54, tam yuvarlak).
class _BlackSaveButton extends StatelessWidget {
  const _BlackSaveButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: Material(
        color: AppColors.editSheetButton,
        borderRadius: BorderRadius.circular(999),
        child: InkWell(
          borderRadius: BorderRadius.circular(999),
          onTap: onPressed,
          child: Center(
            child: AppText(label, style: AppTextStyles.editSheetSave),
          ),
        ),
      ),
    );
  }
}
