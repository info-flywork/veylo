import { Router } from 'express';
import { prisma } from '../lib/prisma';
import { presence } from '../realtime/presence.store';
import { authRoutes } from './auth.routes';
import { conversationRoutes } from './conversation.routes';
import { groupRoutes } from './group.routes';
import { matchRoutes } from './match.routes';
import { mediaRoutes } from './media.routes';
import { noteRoutes } from './note.routes';
import { postRoutes } from './post.routes';
import { roomRoutes } from './room.routes';
import { safetyRoutes } from './safety.routes';
import { storeRoutes, tokenRoutes } from './token.routes';
import { userRoutes } from './user.routes';
import { vibeRoutes } from './vibe.routes';
import { webhookRoutes } from './webhook.routes';

export const apiRoutes = Router();

apiRoutes.get('/health', async (_req, res) => {
  await prisma.$queryRaw`SELECT 1`;
  res.json({ ok: true, online: presence.onlineCount, uptime: Math.round(process.uptime()) });
});

apiRoutes.use('/auth', authRoutes);
apiRoutes.use('/users', userRoutes);
apiRoutes.use('/media', mediaRoutes);
apiRoutes.use('/conversations', conversationRoutes);
apiRoutes.use('/groups', groupRoutes);
apiRoutes.use('/vibes', vibeRoutes);
apiRoutes.use('/notes', noteRoutes);
apiRoutes.use('/posts', postRoutes);
apiRoutes.use('/match', matchRoutes);
apiRoutes.use('/rooms', roomRoutes);
apiRoutes.use('/safety', safetyRoutes);
apiRoutes.use('/tokens', tokenRoutes);
apiRoutes.use('/store', storeRoutes);
apiRoutes.use('/webhooks', webhookRoutes);
