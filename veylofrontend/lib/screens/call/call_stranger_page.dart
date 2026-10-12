import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/animated_profile_ripple.dart';
import 'package:veylo/core/widgets/app_primary_button.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';

enum _StrangerGender { female, male, nonBinary, preferNotToSay }

enum _CallPhase {
  setup,
  finding,
  inCall,
  timesUp,
  /// Keep Talking → önce gelen arama (Decline/Accept)
  namedCallRinging,
  /// Accept sonrası aktif sesli arama (kontroller)
  namedCall,
  videoIncoming,
  videoActive,
}

/// Navbar Call — 60 Second Stranger (setup → finding → call → time's up).
class CallStrangerPage extends StatefulWidget {
  const CallStrangerPage({super.key});

  static Future<void> open(BuildContext context) {
    return Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => const CallStrangerPage(),
      ),
    );
  }

  @override
  State<CallStrangerPage> createState() => _CallStrangerPageState();
}

class _CallStrangerPageState extends State<CallStrangerPage> {
  static const _contentWidth = 398.0;
  static const _callSeconds = 60;

  _StrangerGender? _gender = _StrangerGender.male;
  _CallPhase _phase = _CallPhase.setup;
  int _secondsLeft = _callSeconds;
  bool _speakerOn = true;
  bool _micOn = true;
  bool _waitingOther = false;

  Timer? _findTimer;
  Timer? _callTimer;
  Timer? _videoTimer;
  int _videoSeconds = 0;

  @override
  void dispose() {
    _findTimer?.cancel();
    _callTimer?.cancel();
    _videoTimer?.cancel();
    super.dispose();
  }

  void _startFinding() {
    if (_gender == null) return;
    _findTimer?.cancel();
    _callTimer?.cancel();
    setState(() {
      _phase = _CallPhase.finding;
      _waitingOther = false;
    });
    _findTimer = Timer(const Duration(seconds: 3), _startInCall);
  }

  void _cancelFinding() {
    _findTimer?.cancel();
    setState(() => _phase = _CallPhase.setup);
  }

  void _startInCall() {
    _findTimer?.cancel();
    _callTimer?.cancel();
    setState(() {
      _phase = _CallPhase.inCall;
      _secondsLeft = _callSeconds;
    });
    _callTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_secondsLeft <= 1) {
        timer.cancel();
        setState(() {
          _secondsLeft = 0;
          _phase = _CallPhase.timesUp;
        });
        return;
      }
      setState(() => _secondsLeft -= 1);
    });
  }

  void _endCall() {
    _findTimer?.cancel();
    _callTimer?.cancel();
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  Future<void> _onVideoCallSheet() async {
    final accepted = await showVideoCallSheet(context);
    if (accepted == true && mounted) {
      setState(() => _phase = _CallPhase.videoIncoming);
    }
  }

  void _startVideoCall() {
    _videoTimer?.cancel();
    setState(() {
      _phase = _CallPhase.videoActive;
      _videoSeconds = 0;
    });
    _videoTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() => _videoSeconds += 1);
    });
  }

  void _onBack() {
    switch (_phase) {
      case _CallPhase.finding:
        _cancelFinding();
      case _CallPhase.inCall:
      case _CallPhase.timesUp:
      case _CallPhase.namedCallRinging:
      case _CallPhase.namedCall:
      case _CallPhase.videoIncoming:
      case _CallPhase.videoActive:
        _endCall();
      case _CallPhase.setup:
        Navigator.of(context).pop();
    }
  }

  bool get _isSetupPhase =>
      _phase == _CallPhase.setup || _phase == _CallPhase.finding;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).call;
    final top = MediaQuery.viewPaddingOf(context).top;
    final bottom = MediaQuery.viewPaddingOf(context).bottom;
    final screenW = MediaQuery.sizeOf(context).width;
    final hPad = ((screenW - _contentWidth) / 2).clamp(16.0, 40.0);

    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(
            child: _SetupBackdrop(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: top + 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: _onBack,
                    padding: EdgeInsets.zero,
                    constraints:
                        const BoxConstraints(minWidth: 44, minHeight: 44),
                    icon: SvgPicture.asset(
                      AppAssets.backButton,
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
              ),
              if (_isSetupPhase) ...[
                // Figma: tam genişlik 430×282 — kenardan kesilmeden
                SizedBox(
                  width: screenW,
                  height: screenW * 267 / 512,
                  child: _StrangerMap(
                    finding: _phase == _CallPhase.finding,
                    avatarSize: 50,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(hPad, 8, hPad, 16 + bottom),
                    child: _SetupFindingBody(
                      finding: _phase == _CallPhase.finding,
                      gender: _gender,
                      onGender: (g) => setState(() => _gender = g),
                      onPrimary: _phase == _CallPhase.finding
                          ? _cancelFinding
                          : _startFinding,
                      t: t,
                    ),
                  ),
                ),
              ] else
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(hPad, 0, hPad, 16 + bottom),
                    child: switch (_phase) {
                      _CallPhase.inCall => _InCallBody(
                          secondsLeft: _secondsLeft,
                          speakerOn: _speakerOn,
                          micOn: _micOn,
                          onToggleSpeaker: () =>
                              setState(() => _speakerOn = !_speakerOn),
                          onToggleMic: () => setState(() => _micOn = !_micOn),
                          onEnd: _endCall,
                          t: t,
                        ),
                      _CallPhase.timesUp => _TimesUpBody(
                          waitingOther: _waitingOther,
                          onKeepTalking: () => setState(
                            () => _phase = _CallPhase.namedCallRinging,
                          ),
                          onEnd: _endCall,
                          t: t,
                        ),
                      // Keep Talking: önce arama ekranı (Decline / Accept)
                      _CallPhase.namedCallRinging => _VideoIncomingBody(
                          gender: _gender,
                          onDecline: _endCall,
                          onAccept: () => setState(
                            () => _phase = _CallPhase.namedCall,
                          ),
                        ),
                      // Accept sonrası: aktif konuşma kontrolleri
                      _CallPhase.namedCall => _NamedCallBody(
                          gender: _gender,
                          speakerOn: _speakerOn,
                          micOn: _micOn,
                          onToggleSpeaker: () =>
                              setState(() => _speakerOn = !_speakerOn),
                          onToggleMic: () => setState(() => _micOn = !_micOn),
                          onCamera: _onVideoCallSheet,
                          onEnd: _endCall,
                        ),
                      _CallPhase.videoIncoming => _VideoIncomingBody(
                          gender: _gender,
                          onDecline: _endCall,
                          onAccept: _startVideoCall,
                        ),
                      _CallPhase.videoActive => _VideoActiveBody(
                          gender: _gender,
                          seconds: _videoSeconds,
                          camOn: _speakerOn,
                          micOn: _micOn,
                          onToggleCam: () =>
                              setState(() => _speakerOn = !_speakerOn),
                          onToggleMic: () => setState(() => _micOn = !_micOn),
                          onEnd: _endCall,
                        ),
                      _ => const SizedBox.shrink(),
                    },
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}


/// Keep Talking sonrası kimlik açılan görüntülü arama ekranı (Victoria / Calling).
class _NamedCallBody extends StatelessWidget {
  const _NamedCallBody({
    required this.gender,
    required this.speakerOn,
    required this.micOn,
    required this.onToggleSpeaker,
    required this.onToggleMic,
    required this.onCamera,
    required this.onEnd,
  });

  final _StrangerGender? gender;
  final bool speakerOn;
  final bool micOn;
  final VoidCallback onToggleSpeaker;
  final VoidCallback onToggleMic;
  final VoidCallback onCamera;
  final VoidCallback onEnd;

  /// Figma: #000000 @ 20%
  static const _lightBg = Color(0x33000000);
  static const _iconGray = Color(0xFF8E8E93);

  Widget _lightIcon(String asset, {bool dim = false}) {
    return SvgPicture.asset(
      asset,
      width: 26,
      height: 26,
      colorFilter: ColorFilter.mode(
        _iconGray.withValues(alpha: dim ? 0.45 : 1),
        BlendMode.srcIn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tr = LocaleSettings.currentLocale == AppLocale.tr;
    final photo = gender == _StrangerGender.female
        ? AppAssets.callFemalePerson
        : AppAssets.callMalePerson;

    return Column(
      children: [
        Text(
          'Victoria',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: AppFonts.poppins,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 24 / 16,
            letterSpacing: -0.32,
            color: AppColors.black.withValues(alpha: 0.65),
          ),
        ),
        Text(
          tr ? 'Aranıyor' : 'Calling',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: AppFonts.poppins,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            height: 24 / 20,
            letterSpacing: -0.4,
            color: AppColors.black,
          ),
        ),
        const Spacer(flex: 2),
        ClipOval(
          child: Image.asset(
            photo,
            width: 220,
            height: 220,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
          ),
        ),
        const Spacer(flex: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _CallControlButton(
              onTap: onCamera,
              background: _lightBg,
              child: _lightIcon(AppAssets.iconCameraVoiceCall),
            ),
            const SizedBox(width: 10),
            _CallControlButton(
              onTap: onToggleSpeaker,
              background: _lightBg,
              child: _lightIcon(AppAssets.iconSpeaker, dim: !speakerOn),
            ),
            const SizedBox(width: 10),
            _CallControlButton(
              onTap: onToggleMic,
              background: _lightBg,
              child: _lightIcon(AppAssets.iconVoiceCallMicrophone, dim: !micOn),
            ),
            const SizedBox(width: 10),
            _CallControlButton(
              onTap: onEnd,
              background: const Color(0xFFF44336),
              child: SvgPicture.asset(
                AppAssets.iconClosedPhone,
                width: 26,
                height: 26,
                colorFilter: const ColorFilter.mode(
                  AppColors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

/// "Görüntülü aramaya geç?" bottom sheet.
Future<bool?> showVideoCallSheet(BuildContext context) {
  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const _VideoCallSheet(),
  );
}

class _VideoCallSheet extends StatelessWidget {
  const _VideoCallSheet();

  @override
  Widget build(BuildContext context) {
    final tr = LocaleSettings.currentLocale == AppLocale.tr;
    final bottom = MediaQuery.paddingOf(context).bottom;
    final title = tr
        ? 'Görüntülü aramaya geçmek ister misin?'
        : 'Would you like to switch to a video call?';
    final accept = tr ? 'Kabul et' : 'Accept';

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 44),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            padding: EdgeInsets.fromLTRB(20, 64, 20, 20 + bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: AppFonts.poppins,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                    letterSpacing: -0.4,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(true),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: double.infinity,
                    height: 54,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9999),
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xFF7B2FFF), Color(0xFF998FED)],
                      ),
                    ),
                    child: Text(
                      accept,
                      style: const TextStyle(
                        fontFamily: AppFonts.poppins,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.32,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              width: 88,
              height: 88,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.10),
                    blurRadius: 18,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Image.asset(
                AppAssets.iconVideoCallCamera,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
          Positioned(
            top: 60,
            right: 18,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              behavior: HitTestBehavior.opaque,
              child: SvgPicture.asset(
                AppAssets.iconCloseButton,
                width: 28,
                height: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String _fmtClock(int s) {
  final m = (s ~/ 60).toString().padLeft(2, '0');
  final sec = (s % 60).toString().padLeft(2, '0');
  return '$m:$sec';
}

/// Gelen görüntülü arama ekranı — Decline (kırmızı) / Accept (yeşil).
class _VideoIncomingBody extends StatelessWidget {
  const _VideoIncomingBody({
    required this.gender,
    required this.onDecline,
    required this.onAccept,
  });

  final _StrangerGender? gender;
  final VoidCallback onDecline;
  final VoidCallback onAccept;

  @override
  Widget build(BuildContext context) {
    final tr = LocaleSettings.currentLocale == AppLocale.tr;
    final photo = gender == _StrangerGender.female
        ? AppAssets.callFemalePerson
        : AppAssets.callMalePerson;

    return Column(
      children: [
        Text(
          'Victoria',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: AppFonts.poppins,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 24 / 16,
            letterSpacing: -0.32,
            color: AppColors.black.withValues(alpha: 0.65),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppAssets.iconCameraVoiceCall,
              width: 22,
              height: 22,
              colorFilter: const ColorFilter.mode(
                AppColors.black,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              tr ? 'Aranıyor' : 'Calling',
              style: const TextStyle(
                fontFamily: AppFonts.poppins,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                height: 24 / 20,
                letterSpacing: -0.4,
                color: AppColors.black,
              ),
            ),
          ],
        ),
        const Spacer(flex: 2),
        ClipOval(
          child: Image.asset(
            photo,
            width: 220,
            height: 220,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
          ),
        ),
        const Spacer(flex: 3),
        Row(
          children: [
            Expanded(
              child: _VideoAnswerAction(
                asset: AppAssets.iconDeclineCall,
                background: const Color(0xFFFC4F41),
                label: tr ? 'Reddet' : 'Decline',
                onTap: onDecline,
              ),
            ),
            Expanded(
              child: _VideoAnswerAction(
                asset: AppAssets.iconAcceptCall,
                background: const Color(0xFF4CD964),
                label: tr ? 'Kabul et' : 'Accept',
                onTap: onAccept,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _VideoAnswerAction extends StatelessWidget {
  const _VideoAnswerAction({
    required this.asset,
    required this.background,
    required this.label,
    required this.onTap,
  });

  final String asset;
  final Color background;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 70,
            height: 70,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: background,
            ),
            child: SvgPicture.asset(
              asset,
              width: 30,
              height: 30,
              colorFilter: const ColorFilter.mode(
                AppColors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontFamily: AppFonts.poppins,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 1,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}

/// Aktif görüntülü arama — iki video karesi + kontroller.
class _VideoActiveBody extends StatelessWidget {
  const _VideoActiveBody({
    required this.gender,
    required this.seconds,
    required this.camOn,
    required this.micOn,
    required this.onToggleCam,
    required this.onToggleMic,
    required this.onEnd,
  });

  final _StrangerGender? gender;
  final int seconds;
  final bool camOn;
  final bool micOn;
  final VoidCallback onToggleCam;
  final VoidCallback onToggleMic;
  final VoidCallback onEnd;

  Widget _videoFrame(String photo, {Widget? overlay}) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.white.withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(photo, fit: BoxFit.cover, filterQuality: FilterQuality.high),
          if (overlay != null) overlay,
        ],
      ),
    );
  }

  Widget _ctrl(String asset, VoidCallback onTap,
      {Color background = const Color(0x40FFFFFF), bool dim = false}) {
    return _CallControlButton(
      onTap: onTap,
      background: background,
      child: SvgPicture.asset(
        asset,
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(
          AppColors.white.withValues(alpha: dim ? 0.45 : 1),
          BlendMode.srcIn,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strangerPhoto = gender == _StrangerGender.female
        ? AppAssets.facetofaceCallfemale
        : AppAssets.callFemalePerson;

    final controls = Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        color: AppColors.black.withValues(alpha: 0.5),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _ctrl(AppAssets.iconRevertCamera, () {}),
            const SizedBox(width: 12),
            _ctrl(AppAssets.iconCameraVoiceCall, onToggleCam, dim: !camOn),
            const SizedBox(width: 12),
            _ctrl(AppAssets.iconVoiceCallMicrophone, onToggleMic, dim: !micOn),
            const SizedBox(width: 12),
            _ctrl(
              AppAssets.iconClosedPhone,
              onEnd,
              background: const Color(0xFFFC4F41),
            ),
          ],
        ),
      ),
    );

    return Column(
      children: [
        Text(
          'Victoria',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: AppFonts.poppins,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 24 / 16,
            letterSpacing: -0.32,
            color: AppColors.black.withValues(alpha: 0.65),
          ),
        ),
        Text(
          _fmtClock(seconds),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: AppFonts.poppins,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            height: 24 / 20,
            letterSpacing: -0.4,
            color: AppColors.black,
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: Column(
            children: [
              Expanded(child: _videoFrame(strangerPhoto)),
              const SizedBox(height: 12),
              Expanded(
                child: _videoFrame(
                  AppAssets.callFemalePerson,
                  overlay: controls,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _SetupBackdrop extends StatelessWidget {
  const _SetupBackdrop();

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: AppColors.white,
      child: SizedBox.expand(
        child: Image(
          image: AssetImage(AppAssets.callStrangerBg),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
    );
  }
}

class _StrangerMap extends StatelessWidget {
  const _StrangerMap({required this.finding, required this.avatarSize});

  final bool finding;
  final double avatarSize;

  // Harita (512x267) uzerindeki avatar merkezleri — (w, h) orani.
  static const _positions = <Offset>[
    Offset(0.16, 0.34),
    Offset(0.29, 0.70),
    Offset(0.47, 0.26),
    Offset(0.55, 0.60),
    Offset(0.80, 0.40),
  ];

  // Sol alt (index 1) belirgin; diğerleri soft
  static const _intensities = <double>[0.55, 1.0, 0.5, 0.55, 0.75];

  Widget _avatar() {
    return ClipOval(
      child: Image.asset(
        AppAssets.strangerAvatar,
        width: avatarSize,
        height: avatarSize,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final w = c.maxWidth;
        final h = c.maxHeight;
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: Image.asset(
                AppAssets.callStrangerMapPlain,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                filterQuality: FilterQuality.high,
              ),
            ),
            for (var i = 0; i < _positions.length; i++)
              Positioned(
                left: _positions[i].dx * w - avatarSize / 2,
                top: _positions[i].dy * h - avatarSize / 2,
                child: finding
                    ? PreparingProfileRipple(
                        avatarSize: avatarSize,
                        phase: i / _positions.length,
                        intensity: _intensities[i],
                        ringCount: _intensities[i] >= 0.9 ? 4 : 3,
                        child: _avatar(),
                      )
                    : _avatar(),
              ),
          ],
        );
      },
    );
  }
}

class _SetupFindingBody extends StatelessWidget {
  const _SetupFindingBody({
    required this.finding,
    required this.gender,
    required this.onGender,
    required this.onPrimary,
    required this.t,
  });

  final bool finding;
  final _StrangerGender? gender;
  final ValueChanged<_StrangerGender> onGender;
  final VoidCallback onPrimary;
  final Translations$call$tr t;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppText(
          finding ? t.findingTitle : t.title,
          style: AppTextStyles.callStrangerTitle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        AppText(
          finding ? t.findingSubtitle : t.subtitle,
          style: AppTextStyles.callStrangerSubtitle,
          textAlign: TextAlign.center,
        ),
        if (!finding) ...[
          const SizedBox(height: 20),
          _GenderGrid(
            selected: gender,
            onSelected: onGender,
            female: t.female,
            male: t.male,
            nonBinary: t.nonBinary,
            preferNotToSay: t.preferNotToSay,
          ),
        ],
        const Spacer(),
        _DarkCta(
          label: finding ? t.cancel : t.callStranger,
          onPressed: onPrimary,
        ),
      ],
    );
  }
}

class _InCallBody extends StatelessWidget {
  const _InCallBody({
    required this.secondsLeft,
    required this.speakerOn,
    required this.micOn,
    required this.onToggleSpeaker,
    required this.onToggleMic,
    required this.onEnd,
    required this.t,
  });

  final int secondsLeft;
  final bool speakerOn;
  final bool micOn;
  final VoidCallback onToggleSpeaker;
  final VoidCallback onToggleMic;
  final VoidCallback onEnd;
  final Translations$call$tr t;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(flex: 2),
        Transform.translate(
          offset: const Offset(0, -50),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const _AnonymousBadge(),
              const SizedBox(height: 16),
              const _StrangerAvatar(),
              const SizedBox(height: 16),
              AppText(
                t.stranger,
                style: AppTextStyles.callInCallName,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              AppText(
                t.secondsLeft(n: secondsLeft),
                style: AppTextStyles.callInCallTimer,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const Spacer(flex: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _CallControlButton(
              onTap: onToggleSpeaker,
              background: const Color(0x33000000),
              child: SvgPicture.asset(
                AppAssets.iconSpeaker,
                width: 26,
                height: 26,
                colorFilter: ColorFilter.mode(
                  AppColors.white.withValues(alpha: speakerOn ? 1 : 0.45),
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(width: 10),
            _CallControlButton(
              onTap: onEnd,
              background: const Color(0xFFF44336),
              child: SvgPicture.asset(
                AppAssets.iconClosedPhone,
                width: 26,
                height: 26,
                colorFilter: const ColorFilter.mode(
                  AppColors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(width: 10),
            _CallControlButton(
              onTap: onToggleMic,
              background: const Color(0x33000000),
              child: SvgPicture.asset(
                AppAssets.iconVoiceCallMicrophone,
                width: 26,
                height: 26,
                colorFilter: ColorFilter.mode(
                  AppColors.white.withValues(alpha: micOn ? 1 : 0.45),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _TimesUpBody extends StatelessWidget {
  const _TimesUpBody({
    required this.waitingOther,
    required this.onKeepTalking,
    required this.onEnd,
    required this.t,
  });

  final bool waitingOther;
  final VoidCallback onKeepTalking;
  final VoidCallback onEnd;
  final Translations$call$tr t;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(flex: 2),
        Image.asset(
          AppAssets.clock,
          width: 140,
          height: 140,
          filterQuality: FilterQuality.high,
        ),
        const SizedBox(height: 20),
        AppText(
          t.timesUpTitle,
          style: AppTextStyles.callStrangerTitle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: AppText(
            t.timesUpSubtitle,
            style: AppTextStyles.callStrangerSubtitle,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 28),
        AppPrimaryButton(
          label: t.keepTalking,
          onPressed: waitingOther ? null : onKeepTalking,
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: onEnd,
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: AppText(
              t.endCall,
              style: AppTextStyles.callEndCall,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(height: 20),
        AppText(
          t.waitingOther,
          style: AppTextStyles.callWaiting,
          textAlign: TextAlign.center,
        ),
        const Spacer(flex: 3),
      ],
    );
  }
}

class _AnonymousBadge extends StatelessWidget {
  const _AnonymousBadge();

  @override
  Widget build(BuildContext context) {
    final label = Translations.of(context).call.anonymousBadge;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0x1A7B2FFF),
        borderRadius: BorderRadius.circular(999),
      ),
      child: AppText(
        label,
        style: AppTextStyles.callAnonymousBadge,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _StrangerAvatar extends StatelessWidget {
  const _StrangerAvatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 214,
      height: 214,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.white.withValues(alpha: 0.4),
        border: Border.all(
          color: AppColors.white.withValues(alpha: 0.4),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.selectionBorder.withValues(alpha: 0.18),
            blurRadius: 40,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Container(
        width: 186,
        height: 186,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.selectionBorder.withValues(alpha: 0.4),
        ),
        alignment: Alignment.center,
        child: const Icon(
          Icons.person_rounded,
          size: 96,
          color: AppColors.selectionBorder,
        ),
      ),
    );
  }
}

class _CallControlButton extends StatelessWidget {
  const _CallControlButton({
    required this.onTap,
    required this.background,
    required this.child,
  });

  final VoidCallback onTap;
  final Color background;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 56,
          height: 56,
          child: Center(child: child),
        ),
      ),
    );
  }
}

class _GenderGrid extends StatelessWidget {
  const _GenderGrid({
    required this.selected,
    required this.onSelected,
    required this.female,
    required this.male,
    required this.nonBinary,
    required this.preferNotToSay,
  });

  final _StrangerGender? selected;
  final ValueChanged<_StrangerGender> onSelected;
  final String female;
  final String male;
  final String nonBinary;
  final String preferNotToSay;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _GenderChip(
                label: female,
                selected: selected == _StrangerGender.female,
                onTap: () => onSelected(_StrangerGender.female),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _GenderChip(
                label: male,
                selected: selected == _StrangerGender.male,
                onTap: () => onSelected(_StrangerGender.male),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _GenderChip(
                label: nonBinary,
                selected: selected == _StrangerGender.nonBinary,
                onTap: () => onSelected(_StrangerGender.nonBinary),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _GenderChip(
                label: preferNotToSay,
                selected: selected == _StrangerGender.preferNotToSay,
                onTap: () => onSelected(_StrangerGender.preferNotToSay),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _GenderChip extends StatelessWidget {
  const _GenderChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  static const _fill = Color(0x1A998FED);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Ink(
          height: 52,
          decoration: BoxDecoration(
            color: _fill,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: selected ? AppColors.selectionBorder : Colors.transparent,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: AppText(
                label,
                style: selected
                    ? AppTextStyles.callGenderSelected
                    : AppTextStyles.callGenderIdle,
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DarkCta extends StatelessWidget {
  const _DarkCta({
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.editSheetButton,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(999),
        child: SizedBox(
          width: double.infinity,
          height: 54,
          child: Center(
            child: AppText(label, style: AppTextStyles.callStrangerCta),
          ),
        ),
      ),
    );
  }
}
