import { Router } from 'express';
import * as safety from '../controllers/safety.controller';
import { requireOnboarded, requireUser } from '../middlewares/auth.middleware';
import { validate } from '../middlewares/validate.middleware';
import { blockBody, reportBody } from '../validators/safety.validator';
import { userIdParams } from '../validators/user.validator';

export const safetyRoutes = Router();

safetyRoutes.use(requireUser, requireOnboarded);

safetyRoutes.get('/blocks', safety.listBlocks);
safetyRoutes.post('/blocks', validate({ body: blockBody }), safety.block);
safetyRoutes.delete('/blocks/:userId', validate({ params: userIdParams }), safety.unblock);
safetyRoutes.post('/reports', validate({ body: reportBody }), safety.report);
