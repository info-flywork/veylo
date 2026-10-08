import 'package:flutter/material.dart';
import 'package:veylo/data/mock/profile_mock_repository.dart';
import 'package:veylo/screens/profile/profile_page.dart';

/// Avatar / isim tıklanınca profil açar.
Future<void> openUserProfile(
  BuildContext context, {
  String? userId,
  String? displayName,
  String? avatarUrl,
  String? username,
}) {
  final user = ProfileMockRepository.resolve(
    id: userId,
    displayName: displayName,
    avatarUrl: avatarUrl,
    username: username,
  );
  return ProfilePage.open(context, user: user);
}
