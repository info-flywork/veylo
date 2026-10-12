import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/data/local/local_profile_store.dart';
import 'package:veylo/data/mock/profile_mock_repository.dart';
import 'package:veylo/data/remote/session_store.dart';
import 'package:veylo/data/remote/user_repository.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/models/profile/profile_border.dart';
import 'package:veylo/models/profile/profile_user.dart';
import 'package:veylo/screens/profile/change_name_sheet.dart';
import 'package:veylo/screens/profile/drinking_sheet.dart';
import 'package:veylo/screens/profile/education_sheet.dart';
import 'package:veylo/screens/profile/gender_sheet.dart';
import 'package:veylo/screens/profile/height_picker_sheet.dart';
import 'package:veylo/screens/profile/language_sheet.dart';
import 'package:veylo/screens/profile/pets_sheet.dart';
import 'package:veylo/screens/profile/profile_border_sheet.dart';
import 'package:veylo/screens/profile/relationship_goals_sheet.dart';
import 'package:veylo/screens/profile/smoking_sheet.dart';
import 'package:veylo/screens/profile/widgets/profile_framed_avatar.dart';
import 'package:veylo/screens/profile/zodiac_sheet.dart';

const _kContentWidth = 398.0;
const _kAvatarSize = 90.0;
const _kCameraBadge = 35.0;
const _kInterestMax = 160;

/// Figma Edit Profile — foto, border, interest ve alan satırları.
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({
    super.key,
    this.user,
    this.onSave,
    this.onChangePhoto,
    this.onChangeBorder,
    this.onNameTap,
    this.onHeightTap,
    this.onLanguageTap,
  });

  final ProfileUser? user;
  final VoidCallback? onSave;
  final VoidCallback? onChangePhoto;
  final VoidCallback? onChangeBorder;
  final VoidCallback? onNameTap;
  final VoidCallback? onHeightTap;
  final VoidCallback? onLanguageTap;

  static Future<void> open(BuildContext context, {ProfileUser? user}) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => EditProfilePage(user: user),
      ),
    );
  }

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final TextEditingController _interestCtrl;
  late String _displayName;
  // Boş = kullanıcı henüz seçmedi ("Not set").
  ProfileGender? _gender;
  /// Onboarding'de seçilen NON_BINARY bu ekranın listesinde yok; dokunulmazsa korunur.
  String? _apiGender;
  RelationshipGoal? _relationshipGoal;
  ZodiacSign? _zodiac;
  EducationLevel? _education;
  PetsPreference? _pets;
  DrinkingPreference? _drinking;
  SmokingPreference? _smoking;
  bool _profileVisible = true;
  int? _heightCm;
  bool _saving = false;
  bool _uploadingPhoto = false;

  ProfileUser get _baseProfile =>
      widget.user ?? ProfileMockRepository.currentUser();

  ProfileUser get _profile =>
      LocalProfileStore.instance.apply(_baseProfile);

  @override
  void initState() {
    super.initState();
    final profile = LocalProfileStore.instance.apply(_baseProfile);
    _interestCtrl = TextEditingController(text: profile.bio);
    _displayName = profile.displayName;
    final me = SessionStore.instance.me;
    if (me != null) {
      _apiGender = me.gender;
      _gender = switch (me.gender) {
        'FEMALE' => ProfileGender.female,
        'MALE' => ProfileGender.male,
        'PREFER_NOT_TO_SAY' => ProfileGender.preferNotToSay,
        _ => null,
      };
      _relationshipGoal = RelationshipGoal.values.asNameMap()[me.relationshipGoal];
      _zodiac = ZodiacSign.values.asNameMap()[me.zodiac];
      _education = EducationLevel.values.asNameMap()[me.education];
      _pets = PetsPreference.values.asNameMap()[me.pets];
      _drinking = DrinkingPreference.values.asNameMap()[me.drinking];
      _smoking = SmokingPreference.values.asNameMap()[me.smoking];
      _heightCm = me.heightCm;
      _profileVisible = me.profileVisible;
    }
  }

  Future<void> _openBorderSheet() async {
    if (widget.onChangeBorder != null) {
      widget.onChangeBorder!();
      return;
    }
    await showProfileBorderSheet(
      context,
      avatarUrl: _profile.avatarUrl,
      initialBorderId: SessionStore.instance.me?.borderId,
    );
    if (mounted) setState(() {});
  }

  /// Değişiklikleri backend'e kaydeder (PATCH /users/me).
  Future<void> _save() async {
    if (_saving) return;
    setState(() => _saving = true);
    final bio = _interestCtrl.text.trim();
    try {
      await UserRepository.instance.updateProfile({
        if (_displayName.trim().isNotEmpty) 'displayName': _displayName.trim(),
        'bio': bio.isEmpty ? null : bio,
        'heightCm': _heightCm,
        'relationshipGoal': _relationshipGoal?.name,
        'zodiac': _zodiac?.name,
        'education': _education?.name,
        'pets': _pets?.name,
        'drinking': _drinking?.name,
        'smoking': _smoking?.name,
        'profileVisible': _profileVisible,
        if (_gender != null)
          'gender': switch (_gender!) {
            ProfileGender.female => 'FEMALE',
            ProfileGender.male => 'MALE',
            ProfileGender.preferNotToSay => 'PREFER_NOT_TO_SAY',
          },
      });
      // Eski yerel düzenlemeler sunucudaki değerin üstüne yazılmasın.
      await LocalProfileStore.instance.clear();
      if (!mounted) return;
      if (widget.onSave != null) {
        widget.onSave!();
      } else {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  /// Galeriden fotoğraf seçip yükler; profil fotoğrafı hemen değişir.
  Future<void> _changePhoto() async {
    if (widget.onChangePhoto != null) {
      widget.onChangePhoto!();
      return;
    }
    if (_uploadingPhoto) return;
    final file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 85,
    );
    if (file == null || !mounted) return;
    setState(() => _uploadingPhoto = true);
    try {
      await UserRepository.instance.uploadAvatar(file.path);
    } catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    } finally {
      if (mounted) setState(() => _uploadingPhoto = false);
    }
  }

  Future<void> _openChangeNameSheet() async {
    if (widget.onNameTap != null) {
      widget.onNameTap!();
      return;
    }
    final result = await showChangeNameSheet(
      context,
      initialName: _displayName,
    );
    if (result != null && mounted) {
      setState(() => _displayName = result);
    }
  }

  Future<void> _openGenderSheet() async {
    final result = await showGenderSheet(
      context,
      initial: _gender ?? ProfileGender.female,
    );
    if (result != null && mounted) {
      setState(() {
        _gender = result;
        _apiGender = null;
      });
    }
  }

  Future<void> _openRelationshipGoalsSheet() async {
    final result = await showRelationshipGoalsSheet(
      context,
      initial: _relationshipGoal ?? RelationshipGoal.newFriends,
    );
    if (result != null && mounted) {
      setState(() => _relationshipGoal = result);
    }
  }

  Future<void> _openZodiacSheet() async {
    final result = await showZodiacSheet(
      context,
      initial: _zodiac ?? ZodiacSign.aries,
    );
    if (result != null && mounted) {
      setState(() => _zodiac = result);
    }
  }

  Future<void> _openEducationSheet() async {
    final result = await showEducationSheet(
      context,
      initial: _education ?? EducationLevel.highSchool,
    );
    if (result != null && mounted) {
      setState(() => _education = result);
    }
  }

  Future<void> _openPetsSheet() async {
    final result = await showPetsSheet(
      context,
      initial: _pets ?? PetsPreference.dontWant,
    );
    if (result != null && mounted) {
      setState(() => _pets = result);
    }
  }

  Future<void> _openDrinkingSheet() async {
    final result = await showDrinkingSheet(
      context,
      initial: _drinking ?? DrinkingPreference.never,
    );
    if (result != null && mounted) {
      setState(() => _drinking = result);
    }
  }

  Future<void> _openSmokingSheet() async {
    final result = await showSmokingSheet(
      context,
      initial: _smoking ?? SmokingPreference.nonSmoker,
    );
    if (result != null && mounted) {
      setState(() => _smoking = result);
    }
  }

  Future<void> _openLanguageSheet() async {
    if (widget.onLanguageTap != null) {
      widget.onLanguageTap!();
      return;
    }
    final result = await showLanguageSheet(context);
    if (result != null && mounted) {
      setState(() {});
    }
  }

  Future<void> _openHeightPicker() async {
    if (widget.onHeightTap != null) {
      widget.onHeightTap!();
      return;
    }
    final result = await showHeightPickerSheet(
      context,
      initialCm: _heightCm,
    );
    if (result != null && mounted) {
      setState(() => _heightCm = result);
    }
  }

  String _genderLabel(Translations$profile$tr t) {
    final value = _gender;
    if (value == null) {
      return _apiGender == 'NON_BINARY'
          ? Translations.of(context).createProfile.genderNonBinary
          : t.notSet;
    }
    return switch (value) {
      ProfileGender.female => t.genderFemale,
      ProfileGender.male => t.genderMale,
      ProfileGender.preferNotToSay => t.genderPreferNotToSay,
    };
  }

  String _relationshipGoalLabel(Translations$profile$tr t) {
    final value = _relationshipGoal;
    if (value == null) return t.notSet;
    return switch (value) {
      RelationshipGoal.longTermOpenToShort => t.goalLongTermOpenToShort,
      RelationshipGoal.longTermRelationship => t.goalLongTermRelationship,
      RelationshipGoal.newFriends => t.goalNewFriends,
      RelationshipGoal.shortTermFun => t.goalShortTermFun,
      RelationshipGoal.stillFiguringItOut => t.goalStillFiguringItOut,
    };
  }

  String _educationLabel(Translations$profile$tr t) {
    final value = _education;
    if (value == null) return t.notSet;
    return switch (value) {
      EducationLevel.highSchool => t.educationHighSchool,
      EducationLevel.associates => t.educationAssociates,
      EducationLevel.bachelors => t.educationBachelors,
      EducationLevel.masters => t.educationMasters,
      EducationLevel.phd => t.educationPhd,
    };
  }

  String _petsLabel(Translations$profile$tr t) {
    final value = _pets;
    if (value == null) return t.notSet;
    return switch (value) {
      PetsPreference.dontWant => t.petsDontWant,
      PetsPreference.allergic => t.petsAllergic,
      PetsPreference.haveCat => t.petsHaveCat,
      PetsPreference.haveDog => t.petsHaveDog,
      PetsPreference.haveCatsAndDogs => t.petsHaveCatsAndDogs,
      PetsPreference.haveOther => t.petsHaveOther,
    };
  }

  String _drinkingLabel(Translations$profile$tr t) {
    final value = _drinking;
    if (value == null) return t.notSet;
    return switch (value) {
      DrinkingPreference.never => t.drinkingNever,
      DrinkingPreference.specialOccasions => t.drinkingSpecialOccasions,
      DrinkingPreference.socially => t.drinkingSocially,
      DrinkingPreference.frequently => t.drinkingFrequently,
      DrinkingPreference.sober => t.drinkingSober,
      DrinkingPreference.preferNotToSay => t.drinkingPreferNotToSay,
    };
  }

  String _smokingLabel(Translations$profile$tr t) {
    final value = _smoking;
    if (value == null) return t.notSet;
    return switch (value) {
      SmokingPreference.nonSmoker => t.smokingNonSmoker,
      SmokingPreference.socialSmoker => t.smokingSocialSmoker,
      SmokingPreference.smoker => t.smokingSmoker,
      SmokingPreference.tryingToQuit => t.smokingTryingToQuit,
      SmokingPreference.smokerWhenDrinking => t.smokingWhenDrinking,
      SmokingPreference.preferNotToSay => t.smokingPreferNotToSay,
    };
  }

  @override
  void dispose() {
    _interestCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).profile;
    final top = MediaQuery.viewPaddingOf(context).top;
    final bottom = MediaQuery.viewPaddingOf(context).bottom;
    final screenW = MediaQuery.sizeOf(context).width;
    final hPad = ((screenW - _kContentWidth) / 2).clamp(16.0, 40.0);
    final langLabel = AppLanguage.fromCode(
      LocaleSettings.currentLocale.languageCode,
    ).label;

    return ListenableBuilder(
      listenable: Listenable.merge([
        LocalProfileStore.instance,
        SessionStore.instance,
      ]),
      builder: (context, _) {
        final profile = _profile;
        final borderAsset = ProfileBorder.assetFor(profile.borderId);

        return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: top),
          _EditProfileHeader(
            eyebrow: t.eyebrow,
            title: t.editProfile,
            onBack: () => Navigator.of(context).pop(),
            saveLabel: _saving ? Translations.of(context).common.loading : t.save,
            onSave: _save,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(hPad, 24, hPad, bottom + 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppText(t.changePhoto, style: AppTextStyles.editProfileSection),
                  const SizedBox(height: 12),
                  _ChangePhotoRow(
                    avatarUrl: profile.avatarUrl,
                    borderAsset: borderAsset,
                    onChangePhoto: _uploadingPhoto ? null : _changePhoto,
                    onChangeBorder: _openBorderSheet,
                  ),
                  const SizedBox(height: 24),
                  AppText(t.interest, style: AppTextStyles.editProfileSection),
                  const SizedBox(height: 8),
                  _InterestField(
                    controller: _interestCtrl,
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 24),
                  AppText(t.name, style: AppTextStyles.editProfileSection),
                  const SizedBox(height: 8),
                  _ProfileFieldRow(
                    iconAsset: AppAssets.iconEpName,
                    label: _displayName,
                    onTap: _openChangeNameSheet,
                  ),
                  const SizedBox(height: 24),
                  AppText(t.height, style: AppTextStyles.editProfileSection),
                  const SizedBox(height: 8),
                  _ProfileFieldRow(
                    iconAsset: AppAssets.iconEpHeight,
                    label: _heightCm != null
                        ? t.heightCm(value: _heightCm!)
                        : t.addHeight,
                    onTap: _openHeightPicker,
                  ),
                  const SizedBox(height: 24),
                  AppText(t.languages, style: AppTextStyles.editProfileSection),
                  const SizedBox(height: 8),
                  _ProfileFieldRow(
                    iconAsset: AppAssets.iconEpTranslation,
                    label: langLabel,
                    onTap: _openLanguageSheet,
                  ),
                  const SizedBox(height: 24),
                  AppText(
                    t.relationshipGoals,
                    style: AppTextStyles.editProfileSection,
                  ),
                  const SizedBox(height: 8),
                  _ProfileFieldRow(
                    iconAsset: AppAssets.iconEpEye,
                    label: t.lookingFor,
                    value: _relationshipGoalLabel(t),
                    onTap: _openRelationshipGoalsSheet,
                  ),
                  const SizedBox(height: 24),
                  AppText(t.basics, style: AppTextStyles.editProfileSection),
                  const SizedBox(height: 8),
                  _ProfileFieldRow(
                    iconAsset: AppAssets.iconEpZodiac,
                    label: t.zodiac,
                    value: _zodiac?.label ?? t.notSet,
                    onTap: _openZodiacSheet,
                  ),
                  const SizedBox(height: 10),
                  _ProfileFieldRow(
                    iconAsset: AppAssets.iconEpEducation,
                    label: t.education,
                    value: _educationLabel(t),
                    onTap: _openEducationSheet,
                  ),
                  const SizedBox(height: 24),
                  AppText(
                    t.voiceRecord,
                    style: AppTextStyles.editProfileSection,
                  ),
                  const SizedBox(height: 8),
                  _ProfileFieldRow(
                    iconAsset: AppAssets.iconEpAddVoice,
                    label: t.addVoice,
                  ),
                  const SizedBox(height: 24),
                  AppText(t.lifestyle, style: AppTextStyles.editProfileSection),
                  const SizedBox(height: 8),
                  _ProfileFieldRow(
                    iconAsset: AppAssets.iconEpPets,
                    label: t.pets,
                    value: _petsLabel(t),
                    onTap: _openPetsSheet,
                  ),
                  const SizedBox(height: 10),
                  _ProfileFieldRow(
                    iconAsset: AppAssets.iconEpDrinking,
                    label: t.drinking,
                    value: _drinkingLabel(t),
                    onTap: _openDrinkingSheet,
                  ),
                  const SizedBox(height: 10),
                  _ProfileFieldRow(
                    iconAsset: AppAssets.iconEpSmoking,
                    label: t.smoking,
                    value: _smokingLabel(t),
                    onTap: _openSmokingSheet,
                  ),
                  const SizedBox(height: 24),
                  AppText(t.gender, style: AppTextStyles.editProfileSection),
                  const SizedBox(height: 8),
                  _ProfileFieldRow(
                    iconAsset: AppAssets.iconEpFemale,
                    label: _genderLabel(t),
                    onTap: _openGenderSheet,
                  ),
                  const SizedBox(height: 24),
                  AppText(t.visible, style: AppTextStyles.editProfileSection),
                  const SizedBox(height: 8),
                  _VisibilityRow(
                    label: t.profileVisibility,
                    value: _profileVisible,
                    onChanged: (v) => setState(() => _profileVisible = v),
                  ),
                ],
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

class _EditProfileHeader extends StatelessWidget {
  const _EditProfileHeader({
    required this.eyebrow,
    required this.title,
    required this.saveLabel,
    required this.onBack,
    required this.onSave,
  });

  final String eyebrow;
  final String title;
  final String saveLabel;
  final VoidCallback onBack;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 10, 16, 10),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(color: Color(0x26000000), width: 1),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
            icon: SvgPicture.asset(
              AppAssets.backButton,
              width: 24,
              height: 24,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(eyebrow, style: AppTextStyles.profileEyebrow),
                const SizedBox(height: 2),
                AppText(
                  title,
                  style: AppTextStyles.profileTitle,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          _SaveButton(label: saveLabel, onPressed: onSave),
        ],
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.selectionBorder,
      borderRadius: BorderRadius.circular(9999),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(9999),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  size: 16,
                  color: AppColors.selectionBorder,
                ),
              ),
              const SizedBox(width: 10),
              AppText(label, style: AppTextStyles.editProfileSave),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChangePhotoRow extends StatelessWidget {
  const _ChangePhotoRow({
    required this.avatarUrl,
    this.borderAsset,
    this.onChangePhoto,
    this.onChangeBorder,
  });

  final String avatarUrl;
  final String? borderAsset;
  final VoidCallback? onChangePhoto;
  final VoidCallback? onChangeBorder;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _AvatarWithCamera(
          avatarUrl: avatarUrl,
          borderAsset: borderAsset,
          onTap: onChangePhoto,
        ),
        const SizedBox(width: 32),
        _ChangeBorderButton(onTap: onChangeBorder),
      ],
    );
  }
}

class _AvatarWithCamera extends StatelessWidget {
  const _AvatarWithCamera({
    required this.avatarUrl,
    this.borderAsset,
    this.onTap,
  });

  final String avatarUrl;
  final String? borderAsset;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _kAvatarSize + 4,
      height: _kAvatarSize + 4,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: ProfileFramedAvatar(
              avatarUrl: avatarUrl,
              size: _kAvatarSize,
              borderAsset: borderAsset,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                width: _kCameraBadge,
                height: _kCameraBadge,
                decoration: BoxDecoration(
                  color: AppColors.selectionBorder,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white, width: 2),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.iconProfilePhotoCamera,
                    width: 17,
                    height: 17,
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

class _ChangeBorderButton extends StatelessWidget {
  const _ChangeBorderButton({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Image.asset(
        AppAssets.iconChangeBorder,
        width: _kAvatarSize,
        height: _kAvatarSize,
        fit: BoxFit.contain,
      ),
    );
  }
}

class _InterestField extends StatelessWidget {
  const _InterestField({
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final count = controller.text.characters.length;

    return Container(
      height: 125,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0x0D998FED),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0x3383A0B4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              maxLength: _kInterestMax,
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              style: AppTextStyles.editProfileInterest,
              cursorColor: AppColors.selectionBorder,
              decoration: const InputDecoration(
                border: InputBorder.none,
                isCollapsed: true,
                counterText: '',
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: AppText(
              '$count/$_kInterestMax',
              style: AppTextStyles.editProfileCounter,
            ),
          ),
        ],
      ),
    );
  }
}

class _VisibilityRow extends StatelessWidget {
  const _VisibilityRow({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  static const _fill = Color(0x0D998FED);
  static const _border = Color(0x3383A0B4);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: _fill,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _border),
      ),
      child: Row(
        children: [
          Expanded(
            child: AppText(
              label,
              style: AppTextStyles.editProfileField,
              maxLines: 1,
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeTrackColor: const Color(0xFF34C759),
          ),
        ],
      ),
    );
  }
}

class _ProfileFieldRow extends StatelessWidget {
  const _ProfileFieldRow({
    required this.iconAsset,
    required this.label,
    this.value,
    this.onTap,
  });

  final String iconAsset;
  final String label;
  final String? value;
  final VoidCallback? onTap;

  static const _fill = Color(0x0D998FED); // #998FED @ 5%
  static const _border = Color(0x3383A0B4); // #83A0B4 @ 20%

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          height: 50,
          decoration: BoxDecoration(
            color: _fill,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _border),
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              SvgPicture.asset(
                iconAsset,
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: AppText(
                  label,
                  style: AppTextStyles.editProfileField,
                  maxLines: 1,
                ),
              ),
              if (value != null) ...[
                const SizedBox(width: 8),
                AppText(
                  value!,
                  style: AppTextStyles.editProfileFieldValue,
                  maxLines: 1,
                ),
                const SizedBox(width: 8),
              ],
              SvgPicture.asset(
                AppAssets.iconEpRightArrow,
                width: 20,
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
