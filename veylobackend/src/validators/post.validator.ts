import { z } from 'zod';
import { ENUMS, POST } from '../config/constants';
import { reportReasonSchema } from './conversation.validator';

export const postIdParams = z.object({ postId: z.uuid() });
export const commentIdParams = z.object({ commentId: z.uuid() });
export const userPostsParams = z.object({ userId: z.uuid() });
export const cursorQuery = z.object({ cursor: z.string().max(64).optional() });

const csv = (values: readonly string[]) =>
  z
    .string()
    .optional()
    .transform((v) => (v ? v.split(',').map((x) => x.trim()).filter(Boolean) : undefined))
    .pipe(z.array(z.enum(values as [string, ...string[]])).max(30).optional());

export const feedQuery = z.object({
  cursor: z.uuid().optional(),
  q: z.string().trim().max(60).optional(),
  gender: z.enum(['women', 'men', 'everyone']).optional(),
  interests: csv(ENUMS.interests),
  onlineOnly: z
    .enum(['true', 'false'])
    .optional()
    .transform((v) => v === 'true'),
});

const music = z.object({
  title: z.string().trim().min(1).max(120),
  artist: z.string().trim().max(120).optional(),
  coverUrl: z.url().max(512).optional(),
  audioUrl: z.url().max(512).optional(),
  clipStartSec: z.number().min(0).max(3600).optional(),
  clipEndSec: z.number().min(0).max(3600).optional(),
});

export const createPostBody = z.object({
  mediaId: z.uuid(),
  thumbId: z.uuid(),
  caption: z.string().trim().max(POST.captionMaxLength).optional(),
  music: music.optional(),
  draft: z.boolean().default(false),
});

export const updatePostBody = z
  .object({
    caption: z.string().trim().max(POST.captionMaxLength).nullable().optional(),
    publish: z.boolean().optional(),
  })
  .refine((b) => b.caption !== undefined || b.publish, { message: 'Değişecek alan yok' });

export const commentBody = z.object({ body: z.string().trim().min(1).max(POST.commentMaxLength) });

export const reportPostBody = z.object({
  reason: reportReasonSchema,
  details: z.string().trim().max(1000).optional(),
});
