import type { User } from '@prisma/client';

/** Listelerde (takipçi, sohbet karşı tarafı) kullanılan kısa kullanıcı. */
export function serializeUserSummary(u: User) {
  return {
    id: u.id,
    username: u.username,
    displayName: u.displayName ?? u.username,
    avatarUrl: u.avatarUrl,
    borderId: u.borderId,
  };
}

/** Başkasının profili. fullName, email, token bakiyesi gibi alanlar asla dönmez. */
export function serializePublicProfile(
  u: User,
  extra: { followerCount: number; followingCount: number; iFollow: boolean; followsMe: boolean },
) {
  const visible = u.profileVisible;
  return {
    ...serializeUserSummary(u),
    bio: u.bio,
    profileVisible: visible,
    // Profil gizliyse sadece temel bilgiler.
    details: visible
      ? {
          gender: u.gender,
          interests: u.interests,
          heightCm: u.heightCm,
          languages: u.languages,
          relationshipGoal: u.relationshipGoal,
          zodiac: u.zodiac,
          education: u.education,
          pets: u.pets,
          drinking: u.drinking,
          smoking: u.smoking,
          voiceIntroUrl: u.voiceIntroUrl,
        }
      : null,
    stats: { likeCount: 0, followerCount: extra.followerCount, followingCount: extra.followingCount },
    iFollow: extra.iFollow,
    followsMe: extra.followsMe,
  };
}

/** Kullanıcının kendi profili: her şey. */
export function serializeMe(u: User, extra: { followerCount: number; followingCount: number }) {
  return {
    id: u.id,
    email: u.email,
    authProvider: u.authProvider,
    fullName: u.fullName,
    username: u.username,
    displayName: u.displayName ?? u.username,
    avatarUrl: u.avatarUrl,
    bio: u.bio,
    gender: u.gender,
    interests: u.interests,
    chatGoal: u.chatGoal,
    heightCm: u.heightCm,
    languages: u.languages,
    relationshipGoal: u.relationshipGoal,
    zodiac: u.zodiac,
    education: u.education,
    pets: u.pets,
    drinking: u.drinking,
    smoking: u.smoking,
    voiceIntroUrl: u.voiceIntroUrl,
    borderId: u.borderId,
    profileVisible: u.profileVisible,
    onboardingCompleted: u.onboardingCompleted,
    tokenBalance: u.tokenBalance,
    status: u.status,
    stats: { likeCount: 0, followerCount: extra.followerCount, followingCount: extra.followingCount },
    createdAt: u.createdAt,
  };
}
