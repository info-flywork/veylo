import 'package:flutter/material.dart';
import 'package:veylo/data/mock/profile_mock_repository.dart';
import 'package:veylo/data/remote/safety_repository.dart';
import 'package:veylo/data/remote/session_store.dart';
import 'package:veylo/models/profile/profile_user.dart';
import 'package:veylo/screens/profile/profile_page.dart';

/// Avatar / isim tıklanınca profil açar.
Future<void> openUserProfile(
  BuildContext context, {
  String? userId,
  String? displayName,
  String? avatarUrl,
  String? username,
}) {
  // Gerçek kullanıcı: profil ekranı sunucudan yükler; açılırken eldeki bilgiyle başlar.
  if (SafetyRepository.isRealUser(userId) &&
      userId != SessionStore.instance.me?.id) {
    return ProfilePage.open(
      context,
      user: ProfileUser(
        id: userId!,
        displayName: displayName ?? username ?? '',
        username: username,
        avatarUrl: avatarUrl ?? '',
        bio: '',
        likeCount: 0,
        followCount: 0,
        followerCount: 0,
      ),
    );
  }
  final user = ProfileMockRepository.resolve(
    id: userId,
    displayName: displayName,
    avatarUrl: avatarUrl,
    username: username,
  );
  return ProfilePage.open(context, user: user);
}
