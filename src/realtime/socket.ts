import type { Server as HttpServer } from 'node:http';
import { Server } from 'socket.io';
import { env } from '../config/env';
import { AppError } from '../errors/AppError';
import { logger } from '../lib/logger';
import { prisma } from '../lib/prisma';
import { authService } from '../services/auth.service';
import { setIo, userRoom, emitToUser } from './emitter';
import { callService } from '../services/call.service';
import { roomService } from '../services/room.service';
import { registerCallHandlers } from './handlers/call.handler';
import { registerChatHandlers } from './handlers/chat.handler';
import { registerRoomHandlers } from './handlers/room.handler';
import { presence } from './presence.store';

/**
 * Bağlantı: io(URL, { auth: { token: <Firebase ID token> } })
 * Token süresi dolarsa (1 saat) istemci yeni token ile yeniden bağlanır.
 */
export function initSocket(httpServer: HttpServer) {
  const io = new Server(httpServer, {
    cors: { origin: env.corsOrigins.length ? env.corsOrigins : true },
    pingInterval: 25_000,
    pingTimeout: 20_000,
    connectionStateRecovery: { maxDisconnectionDuration: 2 * 60 * 1000 },
  });
  setIo(io);

  io.use(async (socket, next) => {
    try {
      const identity = await authService.verifyToken(socket.handshake.auth?.token);
      const found = await prisma.user.findUnique({ where: { firebaseUid: identity.uid } });
      if (!found) throw AppError.unauthorized('USER_NOT_REGISTERED');
      const user = await authService.ensureNotSuspended(found);
      if (user.status !== 'ACTIVE') throw AppError.forbidden('ACCOUNT_NOT_ACTIVE');
      if (!user.onboardingCompleted) throw AppError.forbidden('ONBOARDING_REQUIRED');
      socket.data.userId = user.id;
      next();
    } catch (err) {
      const code = err instanceof AppError ? err.code : 'UNAUTHORIZED';
      next(Object.assign(new Error(code), { data: { code } }));
    }
  });

  io.on('connection', (socket) => {
    const userId: string = socket.data.userId;
    socket.join(userRoom(userId));
    if (presence.add(userId, socket.id)) void broadcastPresence(userId, true);

    registerChatHandlers(socket);
    registerCallHandlers(socket);
    registerRoomHandlers(socket);
    callService.onConnect(userId);

    socket.on('disconnect', () => {
      if (presence.remove(userId, socket.id)) {
        callService.onDisconnect(userId);
        roomService.onDisconnect(userId);
        void prisma.user.update({ where: { id: userId }, data: { lastSeenAt: new Date() } }).catch(() => undefined);
        void broadcastPresence(userId, false);
      }
    });
  });

  logger.info('Socket.IO hazır');
  return io;
}

/**
 * Çevrimiçi/çevrimdışı bilgisini birebir sohbetlerdeki karşı taraflara iletir.
 * Kullanıcı id'si değil sohbet id'si gönderilir (anonim sohbetlerde kimlik sızmasın).
 * Kısıtladığım kişiler bu bilgiyi almaz.
 */
async function broadcastPresence(userId: string, isOnline: boolean) {
  try {
    const memberships = await prisma.conversationMember.findMany({
      where: { userId, hidden: false, conversation: { type: { in: ['DIRECT', 'ANONYMOUS'] } } },
      select: { conversationId: true, conversation: { select: { members: { select: { userId: true } } } } },
      orderBy: { conversation: { lastMessageAt: 'desc' } },
      take: 200,
    });
    const restricted = new Set(
      (
        await prisma.block.findMany({ where: { blockerId: userId }, select: { blockedId: true } })
      ).map((b) => b.blockedId),
    );
    for (const m of memberships) {
      const peer = m.conversation.members.find((x) => x.userId !== userId);
      if (!peer || restricted.has(peer.userId)) continue;
      emitToUser(peer.userId, 'presence:update', { conversationId: m.conversationId, isOnline });
    }
  } catch (err) {
    logger.warn({ err }, 'Presence yayını başarısız');
  }
}
