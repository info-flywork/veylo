import { Router } from 'express';
import * as webhooks from '../controllers/webhook.controller';

export const webhookRoutes = Router();

webhookRoutes.post('/revenuecat', webhooks.revenueCat);
