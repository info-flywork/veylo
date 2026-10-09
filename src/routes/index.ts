import { Router } from 'express';
import { prisma } from '../lib/prisma';
import { presence } from '../realtime/presence.store';
import { authRoutes } from './auth.routes';
import { conversationRoutes } from './conversation.routes';
import { mediaRoutes } from './media.routes';
import { safetyRoutes } from './safety.routes';
import { storeRoutes, tokenRoutes } from './token.routes';
import { userRoutes } from './user.routes';
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
apiRoutes.use('/safety', safetyRoutes);
apiRoutes.use('/tokens', tokenRoutes);
apiRoutes.use('/store', storeRoutes);
apiRoutes.use('/webhooks', webhookRoutes);
