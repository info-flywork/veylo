import { Router } from 'express';
import rateLimit from 'express-rate-limit';
import * as auth from '../controllers/auth.controller';
import { AppError } from '../errors/AppError';
import { authenticate } from '../middlewares/auth.middleware';
import { validate } from '../middlewares/validate.middleware';
import { usernameLoginBody } from '../validators/auth.validator';

export const authRoutes = Router();

/** Şifre denemesi sınırı (IP başına). */
const loginLimit = rateLimit({
  windowMs: 15 * 60_000,
  limit: 10,
  standardHeaders: 'draft-8',
  legacyHeaders: false,
  handler: (_req, _res, next) => next(new AppError(429, 'TOO_MANY_ATTEMPTS')),
});

authRoutes.post('/session', authenticate, auth.createSession);
authRoutes.post('/username-login', loginLimit, validate({ body: usernameLoginBody }), auth.usernameLogin);
