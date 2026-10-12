import { Prisma } from '@prisma/client';
import type { Socket } from 'socket.io';
import { ZodError, type ZodType } from 'zod';
import { AppError } from '../../errors/AppError';
import { logger } from '../../lib/logger';

type Ack = (res: { ok: true; data?: unknown } | { ok: false; error: { code: string; message: string } }) => void;

/** Olay işleyicisini sarar: doğrulama + hataları ack ile istemciye döndürme. */
export function on<T>(socket: Socket, event: string, schema: ZodType<T>, fn: (data: T) => Promise<unknown> | unknown) {
  socket.on(event, async (payload: unknown, ack?: Ack) => {
    const reply: Ack = typeof ack === 'function' ? ack : () => undefined;
    try {
      const data = await fn(schema.parse(payload ?? {}));
      reply({ ok: true, data });
    } catch (err) {
      if (err instanceof AppError) return reply({ ok: false, error: { code: err.code, message: err.message } });
      if (err instanceof Prisma.PrismaClientKnownRequestError && err.code === 'P2028') {
        return reply({ ok: false, error: { code: 'BUSY_RETRY', message: 'Yoğunluk, tekrar dene' } });
      }
      if (err instanceof ZodError) {
        return reply({ ok: false, error: { code: 'VALIDATION_ERROR', message: err.issues[0]?.message ?? 'invalid' } });
      }
      logger.error({ err, event }, 'Socket olayı hata verdi');
      reply({ ok: false, error: { code: 'INTERNAL', message: 'Sunucu hatası' } });
    }
  });
}
