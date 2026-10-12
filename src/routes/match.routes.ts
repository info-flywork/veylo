import { Router } from 'express';
import rateLimit from 'express-rate-limit';
import * as match from '../controllers/match.controller';
import { requireOnboarded, requireUser } from '../middlewares/auth.middleware';
import { validate } from '../middlewares/validate.middleware';
import { matchSearchBody } from '../validators/match.validator';

export const matchRoutes = Router();

matchRoutes.use(requireUser, requireOnboarded);

/** Arka arkaya arama ile kullanıcı listesinin taranmasını sınırlar. */
const searchLimit = rateLimit({ windowMs: 10 * 60 * 1000, limit: 30, standardHeaders: true, legacyHeaders: false });

matchRoutes.get('/stats', match.stats);
matchRoutes.post('/search', searchLimit, validate({ body: matchSearchBody }), match.search);
