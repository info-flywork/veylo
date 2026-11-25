import { z } from 'zod';
import { reportReasonSchema } from './conversation.validator';

export const blockBody = z.object({
  userId: z.uuid(),
  type: z.enum(['BLOCK', 'RESTRICT']).default('BLOCK'),
});

export const reportBody = z.object({
  targetUserId: z.uuid(),
  context: z
    .enum(['PROFILE', 'CHAT', 'CALL', 'ROOM', 'VIBE', 'GROUP', 'POST'])
    .default('PROFILE'),
  reason: reportReasonSchema,
  details: z.string().trim().max(1000).optional(),
  alsoBlock: z.boolean().default(false),
  conversationId: z.uuid().optional(),
  contentId: z.string().trim().max(128).optional(),
});
