import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';

class _RoomMember {
  const _RoomMember({
    required this.name,
    required this.avatar,
    this.micOff = true,
    this.blurred = false,
    this.hiddenName = false,
  });

  final String name;
  final String avatar;
  final bool micOff;
  final bool blurred;
  final bool hiddenName;
}

class _ChatMessage {
  const _ChatMessage({
    required this.name,
    required this.body,
    required this.avatar,
  });

  final String name;
  final String body;
  final String avatar;
}

/// Odaya girince açılan canlı oda ekranı (mic off overlay + chat).
class RoomLivePage extends StatelessWidget {
  const RoomLivePage({
    super.key,
    required this.roomTitle,
    this.adminName = 'Alex',
    this.adminAvatar = AppAssets.fakePerson01,
  });

  final String roomTitle;
  final String adminName;
  final String adminAvatar;

  static Future<void> open(
    BuildContext context, {
    required String roomTitle,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => RoomLivePage(roomTitle: roomTitle),
      ),
    );
  }

  static const _members = <_RoomMember>[
    // Row 1
    _RoomMember(
      name: 'Sona',
      avatar: AppAssets.fakePerson03,
      micOff: false,
    ),
    _RoomMember(
      name: 'Victoria',
      avatar: AppAssets.fakePerson05,
      micOff: true,
    ),
    _RoomMember(
      name: 'Lyra',
      avatar: AppAssets.fakePerson06,
      micOff: true,
    ),
    _RoomMember(
      name: 'hidden',
      avatar: AppAssets.fakePerson07,
      micOff: true,
      blurred: true,
      hiddenName: true,
    ),
    // Row 2
    _RoomMember(
      name: 'Clara',
      avatar: AppAssets.fakePerson02,
      micOff: false,
    ),
    _RoomMember(
      name: 'hidden',
      avatar: AppAssets.fakePerson04,
      micOff: true,
      blurred: true,
      hiddenName: true,
    ),
    _RoomMember(
      name: 'hidden',
      avatar: AppAssets.fakePerson08,
      micOff: true,
      blurred: true,
      hiddenName: true,
    ),
    _RoomMember(
      name: 'hidden',
      avatar: AppAssets.fakePerson01,
      micOff: true,
      blurred: true,
      hiddenName: true,
    ),
    // Row 3 (centered)
    _RoomMember(
      name: 'hidden',
      avatar: AppAssets.fakePerson03,
      micOff: true,
      blurred: true,
      hiddenName: true,
    ),
    _RoomMember(
      name: 'hidden',
      avatar: AppAssets.fakePerson05,
      micOff: true,
      blurred: true,
      hiddenName: true,
    ),
    _RoomMember(
      name: 'hidden',
      avatar: AppAssets.fakePerson07,
      micOff: true,
      blurred: true,
      hiddenName: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).discover.liveRoom;
    final top = MediaQuery.paddingOf(context).top;
    final bottom = MediaQuery.paddingOf(context).bottom;

    final quickReplies = [
      t.quickReplyHey,
      t.quickReplyTopic,
      t.quickReplyNew,
    ];

    final messages = [
      _ChatMessage(
        name: t.sampleChatName,
        body: t.sampleChatBody,
        avatar: AppAssets.fakePerson03,
      ),
      _ChatMessage(
        name: t.sampleChatName,
        body: t.sampleChatBody,
        avatar: AppAssets.fakePerson03,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ColoredBox(
            color: AppColors.white,
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, top + 8, 16, 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        behavior: HitTestBehavior.opaque,
                        child: const Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 18,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        child: AppText(
                          roomTitle,
                          style: AppTextStyles.liveRoomTitle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _AdminAvatar(avatar: adminAvatar, size: 72),
                  const SizedBox(height: 8),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: adminName,
                          style: AppTextStyles.liveRoomMemberName,
                        ),
                        TextSpan(
                          text: ' ${t.adminSuffix}',
                          style: AppTextStyles.liveRoomAdminSuffix,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 1,
            color: AppColors.black.withValues(alpha: 0.10),
          ),
          Expanded(
            child: ColoredBox(
              color: AppColors.white,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Peach left + purple right — centers meet mid-screen (~50/50)
                  const Positioned(
                    left: -142 - _BlurOrb.pad,
                    top: 20 - _BlurOrb.pad,
                    child: _BlurOrb(
                      size: 404,
                      color: Color(0x80FFD2B4),
                    ),
                  ),
                  const Positioned(
                    right: -142 - _BlurOrb.pad,
                    top: 20 - _BlurOrb.pad,
                    child: _BlurOrb(
                      size: 404,
                      color: Color(0x807C6CD6),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            const columns = 4;
                            const spacing = 4.0;
                            final tileWidth =
                                (constraints.maxWidth -
                                    spacing * (columns - 1)) /
                                columns;
                            return Wrap(
                              alignment: WrapAlignment.center,
                              spacing: spacing,
                              runSpacing: 12,
                              children: [
                                for (final member in _members)
                                  SizedBox(
                                    width: tileWidth,
                                    child: _MemberTile(member: member),
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                          itemCount: messages.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            return _ChatBubble(message: messages[index]);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: quickReplies.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(width: 8),
                          itemBuilder: (context, index) {
                            return _QuickReplyChip(label: quickReplies[index]);
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          16,
                          10,
                          16,
                          bottom > 0 ? bottom : 8,
                        ),
                        child: _MessageInput(hint: t.messageHint),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BlurOrb extends StatelessWidget {
  const _BlurOrb({required this.size, required this.color});

  final double size;
  final Color color;

  /// Figma layer blur 150 ≈ Flutter sigma ~75
  static const double _sigma = 75;

  /// Extra space so blur isn't clipped; must be subtracted from Positioned offsets
  static const double pad = _sigma * 2;

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: _sigma, sigmaY: _sigma),
      child: Padding(
        padding: const EdgeInsets.all(pad),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
      ),
    );
  }
}

class _AdminAvatar extends StatelessWidget {
  const _AdminAvatar({required this.avatar, required this.size});

  final String avatar;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.selectionBorder, width: 2),
      ),
      child: ClipOval(
        child: Image.asset(avatar, fit: BoxFit.cover),
      ),
    );
  }
}

class _MemberTile extends StatelessWidget {
  const _MemberTile({required this.member});

  final _RoomMember member;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 68,
          height: 68,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipOval(
                child: SizedBox(
                  width: 68,
                  height: 68,
                  child: member.blurred
                      ? ImageFiltered(
                          imageFilter:
                              ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                          child: Image.asset(
                            member.avatar,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.asset(member.avatar, fit: BoxFit.cover),
                ),
              ),
              if (member.micOff) ...[
                Container(
                  width: 68,
                  height: 68,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white.withValues(alpha: 0.28),
                  ),
                ),
                SvgPicture.asset(
                  AppAssets.iconMicrophoneOff,
                  width: 24,
                  height: 24,
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 6),
        AppText(
          member.hiddenName ? '******' : member.name,
          style: AppTextStyles.liveRoomMemberName,
          textAlign: TextAlign.center,
          maxLines: 1,
        ),
      ],
    );
  }
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({required this.message});

  final _ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipOval(
          child: Image.asset(
            message.avatar,
            width: 30,
            height: 30,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.brandPurpleMuted.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${message.name}: ',
                    style: AppTextStyles.liveRoomChatName,
                  ),
                  TextSpan(
                    text: message.body,
                    style: AppTextStyles.liveRoomChatBody,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _QuickReplyChip extends StatelessWidget {
  const _QuickReplyChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.brandPurpleMuted.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: AppText(label, style: AppTextStyles.liveRoomQuickReply),
    );
  }
}

class _MessageInput extends StatelessWidget {
  const _MessageInput({required this.hint});

  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.sheetMuted,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: AppTextStyles.liveRoomMessageHint,
              cursorColor: AppColors.selectionBorder,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: hint,
                hintStyle: AppTextStyles.liveRoomMessageHint,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          const SizedBox(width: 8),
          SvgPicture.asset(
            AppAssets.iconSticker,
            width: 28,
            height: 28,
          ),
          const SizedBox(width: 8),
          SvgPicture.asset(
            AppAssets.iconMicrophone,
            width: 28,
            height: 28,
          ),
        ],
      ),
    );
  }
}
