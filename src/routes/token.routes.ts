import { Router } from 'express';
import * as tokens from '../controllers/token.controller';
import { requireOnboarded, requireUser } from '../middlewares/auth.middleware';
import { validate } from '../middlewares/validate.middleware';
import { boostBody, borderParams, testPurchaseBody } from '../validators/token.validator';
import { listQuery } from '../validators/user.validator';

export const tokenRoutes = Router();

tokenRoutes.use(requireUser);

tokenRoutes.get('/balance', tokens.balance);
tokenRoutes.get('/history', validate({ query: listQuery }), tokens.history);
tokenRoutes.get('/products', tokens.products);
tokenRoutes.get('/boost', requireOnboarded, tokens.boostStatus);
tokenRoutes.post('/checkin', requireOnboarded, tokens.checkin);
tokenRoutes.post('/boost', requireOnboarded, validate({ body: boostBody }), tokens.boost);
/** RevenueCat bağlanana kadar ödemesiz satın alma (STORE_TEST_PURCHASES=true iken). */
tokenRoutes.post('/test-purchase', requireOnboarded, validate({ body: testPurchaseBody }), tokens.testPurchase);

export const storeRoutes = Router();

storeRoutes.use(requireUser, requireOnboarded);

storeRoutes.get('/borders', tokens.listBorders);
storeRoutes.post('/borders/:borderId/purchase', validate({ params: borderParams }), tokens.purchaseBorder);
