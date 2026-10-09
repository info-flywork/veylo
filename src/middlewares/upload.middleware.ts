import type { NextFunction, Request, Response } from 'express';
import rateLimit from 'express-rate-limit';
import multer from 'multer';
import { MEDIA } from '../config/constants';
import { AppError } from '../errors/AppError';

const parser = multer({
  storage: multer.memoryStorage(),
  limits: { fileSize: MEDIA.maxUploadBytes, files: 1, fields: 5 },
}).single('file');

/** multipart/form-data içindeki tek `file` alanını belleğe alır. */
export function singleFile(req: Request, res: Response, next: NextFunction) {
  parser(req, res, (err: unknown) => {
    if (err instanceof multer.MulterError) {
      if (err.code === 'LIMIT_FILE_SIZE') return next(new AppError(413, 'FILE_TOO_LARGE'));
      return next(AppError.badRequest('INVALID_UPLOAD', err.message));
    }
    if (err) return next(err);
    if (!req.file) return next(AppError.badRequest('FILE_REQUIRED', '`file` alanı gerekli'));
    next();
  });
}

/** Kullanıcı başına yükleme sınırı (kötüye kullanım ve depolama maliyeti için). */
export const uploadRateLimit = rateLimit({
  windowMs: 10 * 60_000,
  limit: MEDIA.uploadsPer10Min,
  keyGenerator: (req) => req.user?.id ?? 'anon',
  standardHeaders: 'draft-8',
  legacyHeaders: false,
  handler: (_req, _res, next) => next(new AppError(429, 'UPLOAD_RATE_LIMITED')),
});
