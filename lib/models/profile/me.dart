/// Giriş yapan kullanıcı (`GET /users/me`).
class Me {
  const Me({
    required this.id,
    required this.onboardingCompleted,
    required this.tokenBalance,
    this.username,
    this.displayName,
    this.fullName,
    this.email,
    this.avatarUrl,
    this.bio,
    this.borderId,
    this.gender,
    this.heightCm,
    this.relationshipGoal,
    this.zodiac,
    this.education,
    this.pets,
    this.drinking,
    this.smoking,
    this.voiceIntroUrl,
    this.profileVisible = true,
    this.likeCount = 0,
    this.followerCount = 0,
    this.followingCount = 0,
  });

  final String id;
  final bool onboardingCompleted;
  final int tokenBalance;
  final String? username;
  final String? displayName;
  final String? fullName;
  final String? email;
  final String? avatarUrl;
  final String? bio;
  final String? borderId;

  /// FEMALE | MALE | NON_BINARY | PREFER_NOT_TO_SAY
  final String? gender;
  final int? heightCm;
  final String? relationshipGoal;
  final String? zodiac;
  final String? education;
  final String? pets;
  final String? drinking;
  final String? smoking;
  final String? voiceIntroUrl;
  final bool profileVisible;
  final int likeCount;
  final int followerCount;
  final int followingCount;

  factory Me.fromJson(Map<String, dynamic> j) {
    final stats = (j['stats'] as Map?) ?? const {};
    return Me(
      id: j['id'] as String,
      onboardingCompleted: j['onboardingCompleted'] as bool? ?? false,
      tokenBalance: (j['tokenBalance'] as num?)?.toInt() ?? 0,
      username: j['username'] as String?,
      displayName: j['displayName'] as String?,
      fullName: j['fullName'] as String?,
      email: j['email'] as String?,
      avatarUrl: j['avatarUrl'] as String?,
      bio: j['bio'] as String?,
      borderId: j['borderId'] as String?,
      gender: j['gender'] as String?,
      heightCm: (j['heightCm'] as num?)?.toInt(),
      relationshipGoal: j['relationshipGoal'] as String?,
      zodiac: j['zodiac'] as String?,
      education: j['education'] as String?,
      pets: j['pets'] as String?,
      drinking: j['drinking'] as String?,
      smoking: j['smoking'] as String?,
      voiceIntroUrl: j['voiceIntroUrl'] as String?,
      profileVisible: j['profileVisible'] as bool? ?? true,
      likeCount: (stats['likeCount'] as num?)?.toInt() ?? 0,
      followerCount: (stats['followerCount'] as num?)?.toInt() ?? 0,
      followingCount: (stats['followingCount'] as num?)?.toInt() ?? 0,
    );
  }

  Me copyWith({
    int? tokenBalance,
    int? followerCount,
    int? followingCount,
  }) => Me(
    id: id,
    onboardingCompleted: onboardingCompleted,
    tokenBalance: tokenBalance ?? this.tokenBalance,
    username: username,
    displayName: displayName,
    fullName: fullName,
    email: email,
    avatarUrl: avatarUrl,
    bio: bio,
    borderId: borderId,
    gender: gender,
    heightCm: heightCm,
    relationshipGoal: relationshipGoal,
    zodiac: zodiac,
    education: education,
    pets: pets,
    drinking: drinking,
    smoking: smoking,
    voiceIntroUrl: voiceIntroUrl,
    profileVisible: profileVisible,
    likeCount: likeCount,
    followerCount: followerCount ?? this.followerCount,
    followingCount: followingCount ?? this.followingCount,
  );
}
