import type { Socket } from 'socket.io';
import { AppError } from '../../errors/AppError';
import { roomService } from '../../services/room.service';
import { roomIdParams, roomJoinEvent, roomMessageEvent, roomMicEvent } from '../../validators/room.validator';
import { WindowLimiter } from '../rate-limiter';
import { on } from './socket-utils';

const messageLimiter = new WindowLimiter(10, 10_000);

/** Canlı oda: gir/çık, mikrofon, oda sohbeti. Diğer katılımcılar `room:*` olaylarını alır. */
export function registerRoomHandlers(socket: Socket) {
  const userId: string = socket.data.userId;

  on(socket, 'room:join', roomJoinEvent, ({ roomId, anonymous }) => roomService.join(userId, roomId, anonymous));
  on(socket, 'room:leave', roomIdParams, ({ roomId }) => roomService.leave(userId, roomId));
  on(socket, 'room:mic', roomMicEvent, ({ roomId, on: mic }) => roomService.setMic(userId, roomId, mic));
  on(socket, 'room:message', roomMessageEvent, ({ roomId, body }) => {
    if (!messageLimiter.allow(`${userId}:${roomId}`)) throw new AppError(429, 'RATE_LIMITED', 'Çok hızlı');
    return roomService.sendMessage(userId, roomId, body);
  });
}
