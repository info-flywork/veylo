import { Router } from 'express';
import rateLimit from 'express-rate-limit';
import * as admin from '../controllers/admin.controller';
import { requireAdmin } from '../middlewares/admin.middleware';
import { validate } from '../middlewares/validate.middleware';
import {
  actionsQuery,
  adminReportsQuery,
  adminUserIdParams,
  adminUsersQuery,
  deletionIdParams,
  deletionQuery,
  noteBody,
  reportIdParams,
  reportStatusBody,
  resolveReportBody,
  suspendBody,
} from '../validators/admin.validator';

/**
 * Yönetim paneli API'si (panel ayrı bir uygulama). Kimlik: `x-admin-key`, işlemi yapan: `x-admin-actor`.
 * Tüm değişiklikler admin_actions tablosuna kaydedilir.
 */
export const adminRoutes = Router();

// Anahtar denemelerini yavaşlat (başarılı istekler sayılmaz).
adminRoutes.use(
  rateLimit({ windowMs: 15 * 60_000, limit: 20, skipSuccessfulRequests: true, standardHeaders: 'draft-8', legacyHeaders: false }),
);
adminRoutes.use(requireAdmin);

adminRoutes.get('/stats', admin.stats);

adminRoutes.get('/reports', validate({ query: adminReportsQuery }), admin.listReports);
adminRoutes.get('/reports/:reportId', validate({ params: reportIdParams }), admin.getReport);
adminRoutes.patch('/reports/:reportId', validate({ params: reportIdParams, body: reportStatusBody }), admin.setReportStatus);
adminRoutes.post(
  '/reports/:reportId/resolve',
  validate({ params: reportIdParams, body: resolveReportBody }),
  admin.resolveReport,
);

adminRoutes.get('/users', validate({ query: adminUsersQuery }), admin.listUsers);
adminRoutes.get('/users/:userId', validate({ params: adminUserIdParams }), admin.getUser);
adminRoutes.post('/users/:userId/suspend', validate({ params: adminUserIdParams, body: suspendBody }), admin.suspend);
adminRoutes.post('/users/:userId/unsuspend', validate({ params: adminUserIdParams, body: noteBody }), admin.unsuspend);

adminRoutes.get('/deletion-requests', validate({ query: deletionQuery }), admin.listDeletionRequests);
adminRoutes.post(
  '/deletion-requests/:requestId/purge',
  validate({ params: deletionIdParams, body: noteBody }),
  admin.purgeNow,
);

adminRoutes.get('/actions', validate({ query: actionsQuery }), admin.listActions);
