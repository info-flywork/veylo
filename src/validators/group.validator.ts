import { z } from 'zod';
import { GROUP } from '../config/constants';

export const groupIdParams = z.object({ conversationId: z.uuid() });

export const groupMemberParams = groupIdParams.extend({ memberId: z.string().length(24) });

export const groupRequestParams = groupIdParams.extend({ requestId: z.uuid() });

export const discoverGroupsQuery = z.object({
  q: z.string().trim().max(GROUP.titleMaxLength).optional(),
});

const title = z.string().trim().min(1).max(GROUP.titleMaxLength);

export const createGroupBody = z.object({
  title,
  /** "Hesabımı gizle": kurucu grupta anonim görünür. */
  anonymous: z.boolean().default(false),
  isPrivate: z.boolean().default(false),
});

export const updateGroupBody = z
  .object({ title: title.optional(), isPrivate: z.boolean().optional() })
  .refine((b) => b.title !== undefined || b.isPrivate !== undefined, { message: 'Değişecek alan yok' });

export const joinGroupBody = z.object({ anonymous: z.boolean().default(false) });

export const joinRequestBody = z.object({
  message: z.string().trim().max(GROUP.requestMessageMaxLength).optional(),
  anonymous: z.boolean().default(false),
});

export const decideRequestBody = z.object({ approve: z.boolean() });

export const addMembersBody = z.object({ userIds: z.array(z.uuid()).min(1).max(50) });

export const setRoleBody = z.object({ role: z.enum(['ADMIN', 'MEMBER']) });
