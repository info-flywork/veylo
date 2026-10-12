import { Router } from 'express';
import * as vibe from '../controllers/vibe.controller';
import { requireOnboarded, requireUser } from '../middlewares/auth.middleware';
import { validate } from '../middlewares/validate.middleware';
import { createVibeBody, feedQuery, replyVibeBody, reportVibeBody, vibeIdParams } from '../validators/vibe.validator';

export const vibeRoutes = Router();

vibeRoutes.use(requireUser, requireOnboarded);

const byId = validate({ params: vibeIdParams });

vibeRoutes.get('/', validate({ query: feedQuery }), vibe.feed);
vibeRoutes.post('/', validate({ body: createVibeBody }), vibe.create);
vibeRoutes.delete('/:vibeId', byId, vibe.remove);
vibeRoutes.post('/:vibeId/like', byId, vibe.like);
vibeRoutes.delete('/:vibeId/like', byId, vibe.unlike);
vibeRoutes.post('/:vibeId/reply', validate({ params: vibeIdParams, body: replyVibeBody }), vibe.reply);
vibeRoutes.post('/:vibeId/report', validate({ params: vibeIdParams, body: reportVibeBody }), vibe.report);
