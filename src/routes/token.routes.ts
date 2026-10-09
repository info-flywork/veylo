import { Router } from 'express';
import * as tokens from '../controllers/token.controller';
import { requireOnboarded, requireUser } from '../middlewares/auth.middleware';
import { validate } from '../middlewares/validate.middleware';
import { borderParams } from '../validators/token.validator';
import { listQuery } from '../validators/user.validator';

export const tokenRoutes = Router();

tokenRoutes.use(requireUser);

tokenRoutes.get('/balance', tokens.balance);
tokenRoutes.get('/history', validate({ query: listQuery }), tokens.history);
tokenRoutes.get('/products', tokens.products);

export const storeRoutes = Router();

storeRoutes.use(requireUser, requireOnboarded);

storeRoutes.get('/borders', tokens.listBorders);
storeRoutes.post('/borders/:borderId/purchase', validate({ params: borderParams }), tokens.purchaseBorder);
