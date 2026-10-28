import type { Socket } from 'socket.io';
import { AppError } from '../../errors/AppError';
import { conversationService } from '../../services/conversation.service';
import {
  conversationIdParams,
  markReadBody,
  messagesQuery,
  sendMessageBody,
  unlockRequestBody,
} from '../../validators/conversation.validator';
import { emitToUser } from '../emitter';
import { WindowLimiter } from '../rate-limiter';
import { on } from './socket-utils';

const sendLimiter = new WindowLimiter(20, 5_000);
const typingLimiter = new WindowLimiter(1, 1_000);

const sendSchema = sendMessageBody.and(conversationIdParams);
const readSchema = markReadBody.and(conversationIdParams);
const syncSchema = messagesQuery.and(conversationIdParams);

export function registerChatHandlers(socket: Socket) {
  const userId: string = socket.data.userId;

  /** message:send { conversationId, clientMsgId, type, body?, mediaUrl? } → ack { message } */
  on(socket, 'message:send', sendSchema, async ({ conversationId, ...input }) => {
    if (!sendLimiter.allow(socket.id)) throw new AppError(429, 'RATE_LIMITED', 'Çok hızlı mesaj gönderiyorsun');
    const { message } = await conversationService.send(userId, conversationId, input);
    return message;
  });

  /** connection:request { conversationId, milestone } → sohbete sistem satırı düşer. */
  on(socket, 'connection:request', unlockRequestBody, ({ conversationId, milestone }) =>
    conversationService.requestUnlock(userId, conversationId, milestone),
  );

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
