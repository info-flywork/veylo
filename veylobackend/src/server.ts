import http from 'node:http';
import { createApp } from './app';
import { env } from './config/env';
import { getFirebaseApp } from './lib/firebase';
import { logger } from './lib/logger';
import { prisma } from './lib/prisma';
import { startPersonas } from './personas';
import { initSocket } from './realtime/socket';

async function main() {
  await prisma.$connect();
  if (!getFirebaseApp()) {
    logger.warn(
      env.AUTH_DEV_BYPASS
        ? 'Firebase ayarlı değil: sadece "dev:<uid>" token ile giriş yapılabilir'
        : 'Firebase ayarlı değil: giriş yapılamaz!',
    );
  }

  const server = http.createServer(createApp());
  const io = initSocket(server);
  startPersonas();

  server.listen(env.PORT, () => logger.info(`Veylo API http://localhost:${env.PORT}/api/v1 (${env.NODE_ENV})`));

  // pm2 restart/stop'ta bağlantıları düzgün kapat.
  const shutdown = async (signal: string) => {
    logger.info(`${signal} alındı, kapanıyor...`);
    io.close();
    server.close();
    await prisma.$disconnect();
    process.exit(0);
  };
  process.on('SIGINT', () => void shutdown('SIGINT'));
  process.on('SIGTERM', () => void shutdown('SIGTERM'));
}

main().catch((err) => {
  logger.fatal({ err }, 'Sunucu başlatılamadı');
  process.exit(1);
});
