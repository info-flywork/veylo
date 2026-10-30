import { z } from 'zod';
import { CHAT } from '../config/constants';

export const conversationIdParams = z.object({ conversationId: z.uuid() });

export const listConversationsQuery = z.object({
  box: z.enum(['inbox', 'requests']).default('inbox'),
});

export const createDirectBody = z.object({ userId: z.uuid() });

export const createAnonymousBody = z.object({
  userId: z.uuid(),
  /** Vibes'tan başladıysa paylaşımın metni. */
  contextQuote: z.string().trim().max(160).optional(),
});

export const sendMessageBody = z
  .object({
    clientMsgId: z.string().min(8).max(64),
    type: z.enum(['TEXT', 'IMAGE', 'VOICE']).default('TEXT'),
    body: z.string().trim().max(CHAT.maxMessageLength).optional(),
    /** POST /media/chat ile yüklenen dosyanın id'si. */
    mediaId: z.uuid().optional(),
  })
  .refine((m) => (m.type === 'TEXT' ? Boolean(m.body) : Boolean(m.mediaId)), {
    message: 'TEXT için body, IMAGE/VOICE için mediaId zorunlu',
  });

export const messagesQuery = z.object({
  /** Bu seq'ten öncekiler (yukarı kaydırma). */
  beforeSeq: z.coerce.number().int().positive().optional(),
  /** Bu seq'ten sonrakiler (bağlantı kopunca eksikleri tamamlama). */
  afterSeq: z.coerce.number().int().min(0).optional(),
  limit: z.coerce.number().int().min(1).max(100).default(CHAT.pageSize),
});

export const markReadBody = z.object({ seq: z.number().int().min(0) });

/** Anonim sohbette bir bağlantı adımını erkenden istemek. */
export const unlockRequestBody = conversationIdParams.extend({
  milestone: z.enum(['initial', 'photo', 'full']),
});

/** İsim isteğine karşı tarafın cevabı. */
export const unlockResponseBody = conversationIdParams.extend({
  messageId: z.uuid(),
  decision: z.enum(['approve', 'reject']),
});

export const settingsBody = z
  .object({ pinned: z.boolean(), muted: z.boolean() })
  .partial()
  .refine((v) => Object.keys(v).length > 0, 'En az bir alan gönderilmeli');

export const reportReasonSchema = z.enum([
  'HARASSMENT', 'HATE_SPEECH', 'NUDITY', 'UNDERAGE', 'SPAM', 'SCAM', 'VIOLENCE', 'IMPERSONATION', 'OTHER',
]);

export const reportPeerBody = z.object({
  reason: reportReasonSchema,
  details: z.string().trim().max(1000).optional(),
  alsoBlock: z.boolean().default(false),
});
