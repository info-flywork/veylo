import cors from 'cors';
import express from 'express';
import rateLimit from 'express-rate-limit';
import helmet from 'helmet';
import { pinoHttp } from 'pino-http';
import { env } from './config/env';
import { logger } from './lib/logger';
import { storage } from './lib/storage';
import { LocalStorage } from './lib/storage/local.storage';
import { errorHandler, notFoundHandler } from './middlewares/error.middleware';
import { apiRoutes } from './routes';

export function createApp() {
  const app = express();

  // Nginx arkasında gerçek IP'yi almak için (rate limit doğru çalışsın).
  app.set('trust proxy', 1);

  app.use(helmet());
  app.use(cors({ origin: env.corsOrigins.length ? env.corsOrigins : false }));
  app.use(express.json({ limit: '1mb' }));
  app.use(
    pinoHttp({
      logger,
      autoLogging: { ignore: (req) => req.url === '/api/v1/health' },
    }),
  );
  app.use(
    '/api',
    rateLimit({ windowMs: 60_000, limit: 300, standardHeaders: 'draft-8', legacyHeaders: false }),
  );

  app.use('/api/v1', apiRoutes);

  // Bunny ayarlı değilken (geliştirme) yüklenen dosyaları buradan servis et.
  if (storage instanceof LocalStorage) {
    app.use('/uploads', express.static(storage.root, { maxAge: '1h', immutable: true }));
  }

  app.use(notFoundHandler);
  app.use(errorHandler);
  return app;
}
