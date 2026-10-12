import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:veylo/screens/chat/widgets/chat_note_card.dart';
import 'package:veylo/screens/profile/profile_navigation.dart';

/// Kullanıcı avatarı — tıklanınca profil açar.
/// [enabled] false ise (anonim / blur) navigasyon yok.
class ProfileTappableAvatar extends StatelessWidget {
  const ProfileTappableAvatar({
    super.key,
    required this.avatarUrl,
    required this.size,
    this.userId,
    this.displayName,
    this.username,
    this.enabled = true,
    this.blurred = false,
    this.fit = BoxFit.cover,
  });

  final String avatarUrl;
  final double size;
  final String? userId;
  final String? displayName;
  final String? username;
  final bool enabled;
  final bool blurred;
  final BoxFit fit;

  void _open(BuildContext context) {
    if (!enabled) return;
    openUserProfile(
      context,
      userId: userId,
      displayName: displayName,
      avatarUrl: avatarUrl,
      username: username,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget image = ChatAvatarImage(url: avatarUrl, size: size, fit: fit);
    if (blurred) {
      image = ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
        child: image,
      );
    }

    return GestureDetector(
      onTap: enabled ? () => _open(context) : null,
      behavior: HitTestBehavior.opaque,
      child: ClipOval(
        child: SizedBox(width: size, height: size, child: image),
      ),
    );
  }
}
