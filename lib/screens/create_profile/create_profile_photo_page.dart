import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_primary_button.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/create_profile/create_profile_draft.dart';
import 'package:veylo/screens/create_profile/create_profile_gender_page.dart';
import 'package:veylo/screens/create_profile/create_profile_nav.dart';
import 'package:veylo/screens/create_profile/create_profile_shell.dart';

/// Create Profile — 2/5 Profile Photo.
class CreateProfilePhotoPage extends StatefulWidget {
  const CreateProfilePhotoPage({super.key});

  @override
  State<CreateProfilePhotoPage> createState() => _CreateProfilePhotoPageState();
}

class _CreateProfilePhotoPageState extends State<CreateProfilePhotoPage> {
  static const _avatarSize = 186.0;
  static const _iconPad = 20.0;

  final _picker = ImagePicker();
  XFile? _photo;

  Future<void> _pick(ImageSource source) async {
    Navigator.of(context).pop();
    final file = await _picker.pickImage(
      source: source,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 85,
    );
    if (!mounted || file == null) return;
    setState(() => _photo = file);
  }

  void _showChooser() {
    final cp = Translations.of(context).createProfile;
    var selectedIndex = 0; // Figma: Take a photo varsayılan seçili

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenHorizontal,
                  AppSpacing.sm,
                  AppSpacing.screenHorizontal,
                  AppSpacing.lg,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 36,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.progressTrack,
                        borderRadius:
                            BorderRadius.circular(AppBorders.radiusPill),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    AppText(
                      cp.choosePhotoSheetTitle,
                      style: AppTextStyles.bottomSheetTitle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    _PhotoSheetOption(
                      iconAsset: AppAssets.cameraIcon,
                      label: cp.takePhoto,
                      selected: selectedIndex == 0,
                      onTap: () {
                        setSheetState(() => selectedIndex = 0);
                        _pick(ImageSource.camera);
                      },
                    ),
                    const SizedBox(height: 10),
                    _PhotoSheetOption(
                      iconAsset: AppAssets.imageIcon,
                      label: cp.chooseFromGallery,
                      selected: selectedIndex == 1,
                      onTap: () {
                        setSheetState(() => selectedIndex = 1);
                        _pick(ImageSource.gallery);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _goGender() {
    CreateProfileDraft.instance.photoPath = _photo?.path;
    Navigator.of(context).push(
      createProfileRoute(const CreateProfileGenderPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cp = Translations.of(context).createProfile;
    final hasPhoto = _photo != null;

    return CreateProfileShell(
      navTitle: cp.navTitle,
      step: 2,
      stepLabel: cp.stepPhoto,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Figma: tek satır, Poppins Bold 36
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              cp.photoTitle,
              maxLines: 1,
              softWrap: false,
              style: AppTextStyles.createProfileTitle,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          // Figma: "... to make" / "sure it's you."
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  cp.photoSubtitleLine1,
                  maxLines: 1,
                  softWrap: false,
                  style: AppTextStyles.authSubtitle,
                ),
              ),
              Text(
                cp.photoSubtitleLine2,
                maxLines: 1,
                style: AppTextStyles.authSubtitle,
              ),
            ],
          ),
          const SizedBox(height: 60),
          Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: _showChooser,
                  child: Container(
                    width: _avatarSize,
                    height: _avatarSize,
                    padding: hasPhoto ? EdgeInsets.zero : const EdgeInsets.all(_iconPad),
                    decoration: const BoxDecoration(
                      color: AppColors.inputFill,
                      shape: BoxShape.circle,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: hasPhoto
                        ? Image.file(
                            File(_photo!.path),
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            AppAssets.radiusIcon,
                            fit: BoxFit.contain,
                          ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                GestureDetector(
                  onTap: _showChooser,
                  child: AppText(
                    cp.choosePhoto,
                    style: AppTextStyles.choosePhotoLink,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      footer: AppPrimaryButton(
        label: hasPhoto ? cp.saveAndContinue : cp.continueWithoutPhoto,
        onPressed: _goGender,
      ),
    );
  }
}

class _PhotoSheetOption extends StatelessWidget {
  const _PhotoSheetOption({
    required this.iconAsset,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String iconAsset;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // Seçili: satır #F4F4F9, icon beyaz
    // Değil: satır beyaz, icon #F4F4F9
    final rowColor = selected ? AppColors.sheetMuted : AppColors.white;
    final iconColor = selected ? AppColors.white : AppColors.sheetMuted;

    return Material(
      color: rowColor,
      borderRadius: BorderRadius.circular(AppBorders.inputRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppBorders.inputRadius),
        child: SizedBox(
          height: 68,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: iconColor,
                    borderRadius: BorderRadius.circular(AppBorders.inputRadius),
                  ),
                  child: SvgPicture.asset(
                    iconAsset,
                    width: 28,
                    height: 28,
                  ),
                ),
                const SizedBox(width: 10),
                AppText(label, style: AppTextStyles.bottomSheetOption),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
