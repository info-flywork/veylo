import type { Server } from 'socket.io';

/**
 * Servislerin Socket.IO'ya doğrudan bağımlı olmaması için küçük bir köprü.
 * Her kullanıcı bağlanınca `user:<id>` odasına girer; olaylar oraya gönderilir.
 */
let io: Server | null = null;

export function setIo(server: Server) {
  io = server;
}

export const userRoom = (userId: string) => `user:${userId}`;

export function emitToUser(userId: string, event: string, payload: unknown) {
  io?.to(userRoom(userId)).emit(event, payload);
}
