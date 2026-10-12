import { Prisma } from '@prisma/client';
import type { NextFunction, Request, Response } from 'express';
import { ZodError } from 'zod';
import { AppError } from '../errors/AppError';
import { logger } from '../lib/logger';

export function notFoundHandler(_req: Request, _res: Response, next: NextFunction) {
  next(AppError.notFound('ROUTE_NOT_FOUND'));
}

export function errorHandler(err: unknown, req: Request, res: Response, _next: NextFunction) {
  if (err instanceof AppError) {
    return res.status(err.status).json({ error: { code: err.code, message: err.message } });
  }
  if (err instanceof ZodError) {
    return res.status(400).json({
      error: {
        code: 'VALIDATION_ERROR',
        message: 'Geçersiz istek',
        details: err.issues.map((i) => ({ path: i.path.join('.'), message: i.message })),
      },
    });
  }
  // Yoğunlukta işlem zaman aşımı: veri yazılmadı, istemci aynı istekle tekrar denemeli.
  if (err instanceof Prisma.PrismaClientKnownRequestError && err.code === 'P2028') {
    return res.status(503).json({ error: { code: 'BUSY_RETRY', message: 'Yoğunluk, tekrar dene' } });
  }
  if (err instanceof Prisma.PrismaClientKnownRequestError && err.code === 'P2002') {
    return res.status(409).json({ error: { code: 'ALREADY_EXISTS', message: 'Kayıt zaten var' } });
  }
  if (err instanceof SyntaxError && 'body' in err) {
    return res.status(400).json({ error: { code: 'INVALID_JSON', message: 'Geçersiz JSON' } });
  }

  logger.error({ err, path: req.path }, 'Beklenmeyen hata');
  return res.status(500).json({ error: { code: 'INTERNAL', message: 'Sunucu hatası' } });
}
