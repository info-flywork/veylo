import { randomUUID } from 'node:crypto';
import type { MediaKind, User } from '@prisma/client';
import sharp from 'sharp';
import { MEDIA, POST } from '../config/constants';
import { AppError } from '../errors/AppError';
import { logger } from '../lib/logger';
import { prisma } from '../lib/prisma';
import { storage } from '../lib/storage';
import { sniffAudio } from '../utils/file-sniff';
import { userService } from './user.service';

interface Prepared {
  data: Buffer;
  contentType: string;
  ext: string;
  width?: number;
  height?: number;
}

const FOLDERS: Record<MediaKind, string> = {
  AVATAR: 'avatars',
  AVATAR_BLUR: 'previews',
  VOICE_INTRO: 'voice-intros',
  CHAT_IMAGE: 'chat/images',
  CHAT_VOICE: 'chat/voice',
  POST_IMAGE: 'posts',
  POST_THUMB: 'posts/thumbs',
};

/** Rastgele yol: kullanıcı id'si içermez, tahmin edilemez (anonim önizleme orijinalden türetilemez). */
function newPath(kind: MediaKind, ext: string) {
  const d = new Date();
  const month = `${d.getUTCFullYear()}/${String(d.getUTCMonth() + 1).padStart(2, '0')}`;
  return `${FOLDERS[kind]}/${month}/${randomUUID()}.${ext}`;
}

// ───────────────────────────── işleme ─────────────────────────────

const SUPPORTED_IMAGES = new Set(['jpeg', 'png', 'webp', 'gif', 'heif', 'avif']);

/**
 * Görseli doğrular ve yeniden kodlar: EXIF yönünü uygular, GPS dahil tüm metadata'yı siler,
 * küçültür, WebP'ye çevirir. Bozuk veya görsel olmayan dosya 415 döner.
 */
async function prepareImage(input: Buffer, maxPx: number): Promise<Prepared> {
  try {
    const img = sharp(input, { limitInputPixels: 40_000_000, failOn: 'error' });
    const meta = await img.metadata();
    if (!meta.format || !SUPPORTED_IMAGES.has(meta.format)) throw new Error(`format ${meta.format}`);

    const { data, info } = await img
      .rotate()
      .resize({ width: maxPx, height: maxPx, fit: 'inside', withoutEnlargement: true })
      .webp({ quality: MEDIA.webpQuality })
      .toBuffer({ resolveWithObject: true });
    return { data, contentType: 'image/webp', ext: 'webp', width: info.width, height: info.height };
  } catch (err) {
    logger.debug({ err }, 'Görsel işlenemedi');
    throw new AppError(415, 'UNSUPPORTED_IMAGE', 'JPEG, PNG veya WebP gönderilmeli');
  }
}

/** Anonim sohbet önizlemesi: küçük ve ağır bulanık; orijinal geri elde edilemez. */
async function prepareBlur(input: Buffer): Promise<Prepared> {
  const { data, info } = await sharp(input)
    .rotate()
    .resize(MEDIA.blurPx, MEDIA.blurPx, { fit: 'cover' })
    .blur(MEDIA.blurSigma)
    .webp({ quality: 60 })
    .toBuffer({ resolveWithObject: true });
  return { data, contentType: 'image/webp', ext: 'webp', width: info.width, height: info.height };
}

function prepareAudio(input: Buffer): Prepared {
  if (input.length > MEDIA.maxAudioBytes) throw new AppError(413, 'FILE_TOO_LARGE');
  const type = sniffAudio(input);
  if (!type) throw new AppError(415, 'UNSUPPORTED_AUDIO', 'M4A, AAC, MP3, OGG veya WAV gönderilmeli');
  return { data: input, ...type };
}

// ───────────────────────────── depolama ─────────────────────────────

/** Dosyayı depolamaya yazar ve media satırını oluşturur. */
async function store(ownerId: string, kind: MediaKind, file: Prepared) {
  const path = newPath(kind, file.ext);
  await storage.put(path, file.data, file.contentType);
  try {
    return await prisma.media.create({
      data: {
        ownerId,
        kind,
        path,
        url: storage.publicUrl(path),
        contentType: file.contentType,
        size: file.data.length,
        width: file.width,
        height: file.height,
      },
    });
  } catch (err) {
    await storage.delete(path).catch(() => undefined);
    throw err;
  }
}

/** Kullanıcının belirli türdeki eski dosyalarını siler (yenisi hariç). Hata yutulur, loglanır. */
async function purge(ownerId: string, kinds: MediaKind[], keepIds: string[] = []) {
  const old = await prisma.media.findMany({
    where: { ownerId, kind: { in: kinds }, id: { notIn: keepIds } },
  });
  for (const m of old) {
    try {
      await storage.delete(m.path);
      await prisma.media.delete({ where: { id: m.id } });
    } catch (err) {
      logger.warn({ err, path: m.path }, 'Eski medya silinemedi');
    }
  }
}

// ───────────────────────────── profil ─────────────────────────────

async function uploadAvatar(user: User, input: Buffer) {
  // Önce doğrulama: geçersiz dosyada önizleme üretimi 500 hatası vermesin.
  const image = await prepareImage(input, MEDIA.avatarMaxPx);
  const blur = await prepareBlur(input);
  const avatar = await store(user.id, 'AVATAR', image);
  const preview = await store(user.id, 'AVATAR_BLUR', blur);

  const updated = await prisma.user.update({
    where: { id: user.id },
    data: { avatarUrl: avatar.url, avatarBlurUrl: preview.url },
  });
  await purge(user.id, ['AVATAR', 'AVATAR_BLUR'], [avatar.id, preview.id]);
  return userService.getMe(updated);
}

async function removeAvatar(user: User) {
  const updated = await prisma.user.update({
    where: { id: user.id },
    data: { avatarUrl: null, avatarBlurUrl: null },
  });
  await purge(user.id, ['AVATAR', 'AVATAR_BLUR']);
  return userService.getMe(updated);
}

async function uploadVoiceIntro(user: User, input: Buffer) {
  const media = await store(user.id, 'VOICE_INTRO', prepareAudio(input));
  const updated = await prisma.user.update({ where: { id: user.id }, data: { voiceIntroUrl: media.url } });
  await purge(user.id, ['VOICE_INTRO'], [media.id]);
  return userService.getMe(updated);
}

async function removeVoiceIntro(user: User) {
  const updated = await prisma.user.update({ where: { id: user.id }, data: { voiceIntroUrl: null } });
  await purge(user.id, ['VOICE_INTRO']);
  return userService.getMe(updated);
}

// ───────────────────────────── sohbet ─────────────────────────────

/** Önce dosya yüklenir, dönen mediaId ile mesaj gönderilir. */
async function uploadChatMedia(userId: string, kind: 'image' | 'voice', input: Buffer) {
  const media =
    kind === 'image'
      ? await store(userId, 'CHAT_IMAGE', await prepareImage(input, MEDIA.chatImageMaxPx))
      : await store(userId, 'CHAT_VOICE', prepareAudio(input));
  return {
    mediaId: media.id,
    url: media.url,
    contentType: media.contentType,
    size: media.size,
    width: media.width,
    height: media.height,
  };
}

// ───────────────────────────── gönderi ─────────────────────────────

/** Gönderi görseli: tam boy + ızgara için küçük önizleme. Dönen mediaId ile gönderi oluşturulur. */
async function uploadPostImage(userId: string, input: Buffer) {
  const full = await prepareImage(input, POST.imageMaxPx);
  const thumb = await prepareImage(input, POST.thumbPx);
  const media = await store(userId, 'POST_IMAGE', full);
  const thumbMedia = await store(userId, 'POST_THUMB', thumb);
  return {
    mediaId: media.id,
    thumbId: thumbMedia.id,
    url: media.url,
    thumbUrl: thumbMedia.url,
    width: media.width,
    height: media.height,
  };
}

/** Gönderi oluştururken: medya bu kullanıcıya ait ve doğru türde mi? */
async function resolveForPost(userId: string, mediaId: string, thumbId: string) {
  const [media, thumb] = await Promise.all([
    prisma.media.findUnique({ where: { id: mediaId } }),
    prisma.media.findUnique({ where: { id: thumbId } }),
  ]);
  if (!media || media.ownerId !== userId || media.kind !== 'POST_IMAGE' || !thumb || thumb.ownerId !== userId || thumb.kind !== 'POST_THUMB') {
    throw AppError.badRequest('INVALID_MEDIA', 'Medya bulunamadı veya gönderi görseli değil');
  }
  return { media, thumb };
}

/** Mesajdaki mediaId gönderene ait ve mesaj türüyle uyumlu mu? */
async function resolveForMessage(userId: string, mediaId: string, type: 'IMAGE' | 'VOICE') {
  const media = await prisma.media.findUnique({ where: { id: mediaId } });
  const expected: MediaKind = type === 'IMAGE' ? 'CHAT_IMAGE' : 'CHAT_VOICE';
  if (!media || media.ownerId !== userId || media.kind !== expected) {
    throw AppError.badRequest('INVALID_MEDIA', 'Medya bulunamadı veya bu mesaj türüyle uyumsuz');
  }
  return media;
}

export const mediaService = {
  uploadAvatar,
  removeAvatar,
  uploadVoiceIntro,
  removeVoiceIntro,
  uploadChatMedia,
  resolveForMessage,
  uploadPostImage,
  resolveForPost,
};
