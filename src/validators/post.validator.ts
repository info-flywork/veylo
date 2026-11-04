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
  // Jamendo signed URL'leri 512'yi aşabiliyor.
  coverUrl: z.url().max(2048).optional(),
  audioUrl: z.url().max(2048).optional(),
  clipStartSec: z.number().min(0).max(3600).optional(),
  clipEndSec: z.number().min(0).max(3600).optional(),
});

// İstemcinin editör katmanları; içeriğe karışmayız, sadece boyutu sınırlarız.
const editorState = z
  .record(z.string(), z.unknown())
  .refine((v) => JSON.stringify(v).length <= POST.editorStateMaxBytes, { message: 'Editör verisi çok büyük' });

export const createPostBody = z.object({
  mediaId: z.uuid(),
  thumbId: z.uuid(),
  /** Yazısız orijinal (POST /media/post ile yüklenir). */
  sourceId: z.uuid().optional(),
  editorState: editorState.optional(),
  caption: z.string().trim().max(POST.captionMaxLength).optional(),
  music: music.optional(),
  draft: z.boolean().default(false),
});

export const updatePostBody = z
  .object({
    caption: z.string().trim().max(POST.captionMaxLength).nullable().optional(),
    publish: z.boolean().optional(),
    /** Editörde yeniden işlenen görsel; ikisi birlikte gelir. */
    mediaId: z.uuid().optional(),
    thumbId: z.uuid().optional(),
    music: music.nullable().optional(),
    editorState: editorState.nullable().optional(),
  })
  .refine((b) => Boolean(b.mediaId) === Boolean(b.thumbId), { message: 'mediaId ve thumbId birlikte gönderilmeli' })
  .refine(
    (b) =>
      b.caption !== undefined || b.publish || b.mediaId || b.music !== undefined || b.editorState !== undefined,
    { message: 'Değişecek alan yok' },
  );

export const commentBody = z.object({ body: z.string().trim().min(1).max(POST.commentMaxLength) });

export const reportPostBody = z.object({
  reason: reportReasonSchema,
  details: z.string().trim().max(1000).optional(),
});
