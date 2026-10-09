import { Router } from 'express';
import * as media from '../controllers/media.controller';
import { requireOnboarded, requireUser } from '../middlewares/auth.middleware';
import { singleFile, uploadRateLimit } from '../middlewares/upload.middleware';
import { validate } from '../middlewares/validate.middleware';
import { chatMediaQuery } from '../validators/media.validator';

/**
 * Tüm yüklemeler multipart/form-data, dosya alanı adı: `file`.
 * Dosyalar Node'da kontrol edilip işlenir, sonra Bunny Storage'a yazılır.
 */
export const mediaRoutes = Router();

mediaRoutes.use(requireUser);

// Profil fotoğrafı onboarding sırasında (profil bitmeden) da yüklenebilir.
mediaRoutes.put('/avatar', uploadRateLimit, singleFile, media.uploadAvatar);
mediaRoutes.delete('/avatar', media.removeAvatar);

mediaRoutes.put('/voice-intro', requireOnboarded, uploadRateLimit, singleFile, media.uploadVoiceIntro);
mediaRoutes.delete('/voice-intro', requireOnboarded, media.removeVoiceIntro);

// Sohbet: önce yükle (?kind=image|voice), dönen mediaId ile mesaj gönder.
mediaRoutes.post(
  '/chat',
  requireOnboarded,
  uploadRateLimit,
  validate({ query: chatMediaQuery }),
  singleFile,
  media.uploadChatMedia,
);
