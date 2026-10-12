import { z } from 'zod';
import { CHAT, VIBE } from '../config/constants';
import { reportReasonSchema } from './conversation.validator';

export const vibeIdParams = z.object({ vibeId: z.uuid() });

export const feedQuery = z.object({
  cursor: z.uuid().optional(),
  q: z.string().trim().max(100).optional(),
  limit: z.coerce.number().int().min(1).max(50).default(VIBE.pageSize),
});

export const createVibeBody = z.object({
  body: z.string().trim().min(1).max(VIBE.maxLength),
  anonymous: z.boolean().default(true),
});

export const replyVibeBody = z.object({
  body: z.string().trim().min(1).max(CHAT.maxMessageLength),
  clientMsgId: z.string().min(8).max(64),
});

export const reportVibeBody = z.object({
  reason: reportReasonSchema,
  details: z.string().trim().max(1000).optional(),
});
