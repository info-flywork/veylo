import { Prisma } from '@prisma/client';
import type { Socket } from 'socket.io';
import { ZodError, type ZodType } from 'zod';
import { AppError } from '../../errors/AppError';
import { logger } from '../../lib/logger';
import { conversationService } from '../../services/conversation.service';
import {
  conversationIdParams,
  markReadBody,
  messagesQuery,
  sendMessageBody,
} from '../../validators/conversation.validator';
import { emitToUser } from '../emitter';
import { WindowLimiter } from '../rate-limiter';

type Ack = (res: { ok: true; data?: unknown } | { ok: false; error: { code: string; message: string } }) => void;

const sendLimiter = new WindowLimiter(20, 5_000);
const typingLimiter = new WindowLimiter(1, 1_000);

const sendSchema = sendMessageBody.and(conversationIdParams);
const readSchema = markReadBody.and(conversationIdParams);
const syncSchema = messagesQuery.and(conversationIdParams);

/** Olay işleyicisini sarar: doğrulama + hataları ack ile istemciye döndürme. */
function on<T>(socket: Socket, event: string, schema: ZodType<T>, fn: (data: T) => Promise<unknown>) {
  socket.on(event, async (payload: unknown, ack?: Ack) => {
    const reply: Ack = typeof ack === 'function' ? ack : () => undefined;
    try {
      const data = await fn(schema.parse(payload));
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

export function registerChatHandlers(socket: Socket) {
  const userId: string = socket.data.userId;

  /** message:send { conversationId, clientMsgId, type, body?, mediaUrl? } → ack { message } */
  on(socket, 'message:send', sendSchema, async ({ conversationId, ...input }) => {
    if (!sendLimiter.allow(socket.id)) throw new AppError(429, 'RATE_LIMITED', 'Çok hızlı mesaj gönderiyorsun');
    const { message } = await conversationService.send(userId, conversationId, input);
    return message;
  });

  /** message:read { conversationId, seq } */
  on(socket, 'message:read', readSchema, ({ conversationId, seq }) =>
    conversationService.markRead(userId, conversationId, seq),
  );

  /** conversation:sync { conversationId, afterSeq } → yeniden bağlanınca kaçırılan mesajlar. */
  on(socket, 'conversation:sync', syncSchema, ({ conversationId, ...q }) =>
    conversationService.messages(userId, conversationId, q),
  );

  /** typing { conversationId } → karşı tarafa sadece sohbet id'si gider (anonimlik). */
  on(socket, 'typing', conversationIdParams, async ({ conversationId }) => {
    if (!typingLimiter.allow(`${socket.id}:${conversationId}`)) return;
    const recipients = await conversationService.recipientsFor(userId, conversationId);
    recipients.forEach((id) => emitToUser(id, 'typing', { conversationId }));
  });

  socket.on('disconnect', () => {
    sendLimiter.forget(socket.id);
  });
}
