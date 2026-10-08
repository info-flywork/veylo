/// Profil ekranı kullanıcı özeti — backend alanlarıyla eşleşir.
class ProfileUser {
  const ProfileUser({
    required this.id,
    required this.displayName,
    required this.avatarUrl,
    required this.bio,
    required this.likeCount,
    required this.followCount,
    required this.followerCount,
    this.username,
    this.tokenBalance = 0,
    this.isSelf = false,
    this.borderId,
  });

  final String id;
  final String displayName;
  /// `@handle` — başkasının profilinde ismin altında.
  final String? username;
  /// Network URL veya `assets/...` yolu.
  final String avatarUrl;
  final String bio;
  final int likeCount;
  final int followCount;
  final int followerCount;
  final int tokenBalance;
  final bool isSelf;
  /// Dekoratif çerçeve id (`ProfileBorder.catalog`) — null = yok.
  final String? borderId;
}
