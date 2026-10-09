import { z } from 'zod';
import { ENUMS } from '../config/constants';

export const usernameSchema = z
  .string()
  .trim()
  .toLowerCase()
  .min(3)
  .max(30)
  .regex(/^[a-z0-9._]+$/, 'Sadece harf, rakam, nokta ve alt çizgi');

const genderSchema = z.enum(['FEMALE', 'MALE', 'NON_BINARY', 'PREFER_NOT_TO_SAY']);
export const userIdParams = z.object({ userId: z.uuid() });

export const usernameAvailableQuery = z.object({ username: usernameSchema });

/**
 * Profil oluşturma adımlarının sonunda tek seferde gönderilir.
 * Fotoğraf ayrıca PUT /media/avatar ile yüklenir (URL kabul edilmez).
 */
export const onboardingBody = z.object({
  fullName: z.string().trim().min(2).max(100),
  username: usernameSchema,
  gender: genderSchema,
  interests: z.array(z.enum(ENUMS.interests)).min(5).max(22),
  chatGoal: z.enum(ENUMS.chatGoals),
});

export const updateProfileBody = z
  .object({
    displayName: z.string().trim().min(1).max(50),
    username: usernameSchema,
    bio: z.string().trim().max(160).nullable(),
    gender: genderSchema.nullable(),
    interests: z.array(z.enum(ENUMS.interests)).max(22),
    chatGoal: z.enum(ENUMS.chatGoals).nullable(),
    heightCm: z.number().int().min(140).max(220).nullable(),
    languages: z.array(z.enum(ENUMS.languages)).max(12),
    relationshipGoal: z.enum(ENUMS.relationshipGoals).nullable(),
    zodiac: z.enum(ENUMS.zodiac).nullable(),
    education: z.enum(ENUMS.education).nullable(),
    pets: z.enum(ENUMS.pets).nullable(),
    drinking: z.enum(ENUMS.drinking).nullable(),
    smoking: z.enum(ENUMS.smoking).nullable(),
    borderId: z.string().max(32).nullable(),
    profileVisible: z.boolean(),
  })
  .partial()
  .refine((v) => Object.keys(v).length > 0, 'En az bir alan gönderilmeli');

export const deviceBody = z.object({
  token: z.string().min(10).max(255),
  platform: z.enum(['ios', 'android']),
  locale: z.enum(ENUMS.languages).optional(),
});

export const deletionRequestBody = z.object({
  reason: z.string().trim().max(1000).optional(),
});

export const listQuery = z.object({
  cursor: z.string().optional(),
  limit: z.coerce.number().int().min(1).max(50).default(30),
});
