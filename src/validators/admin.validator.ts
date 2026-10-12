import { z } from 'zod';

const limit = z.coerce.number().int().min(1).max(100).default(30);
/** Bir önceki sayfanın son kaydının id'si. */
const cursor = z.uuid().optional();

export const adminReportsQuery = z.object({
  status: z.enum(['OPEN', 'REVIEWING', 'ACTIONED', 'DISMISSED', 'ALL']).default('OPEN'),
  context: z.enum(['PROFILE', 'CHAT', 'CALL', 'ROOM', 'VIBE', 'GROUP', 'POST']).optional(),
  targetUserId: z.uuid().optional(),
  limit,
  cursor,
});

export const reportIdParams = z.object({ reportId: z.uuid() });
export const adminUserIdParams = z.object({ userId: z.uuid() });
export const deletionIdParams = z.object({ requestId: z.uuid() });

/** null = süresiz. */
const suspendDays = z.number().int().min(1).max(3650).nullable();

export const resolveReportBody = z.object({
  /** DISMISS: işlem yok. ACTION: aşağıdakilerden en az biri uygulanır (ya da sadece uyarı olarak kapatılır). */
  decision: z.enum(['DISMISS', 'ACTION']),
  /** Şikayet edilen vibe/gönderiyi kaldır. */
  removeContent: z.boolean().default(false),
  /** Verilirse hesap askıya alınır. */
  suspendDays: suspendDays.optional(),
  note: z.string().trim().max(1000).optional(),
});

export const reportStatusBody = z.object({ status: z.enum(['OPEN', 'REVIEWING']) });

export const suspendBody = z.object({
  days: suspendDays,
  reason: z.string().trim().min(1).max(500),
});

export const adminUsersQuery = z.object({
  /** Kullanıcı adı, görünen ad, e-posta parçası ya da tam id. */
  q: z.string().trim().min(1).max(100).optional(),
  status: z.enum(['ACTIVE', 'SUSPENDED', 'DELETION_REQUESTED']).optional(),
  limit,
  cursor,
});

export const deletionQuery = z.object({
  status: z.enum(['PENDING', 'CANCELLED', 'ALL']).default('PENDING'),
  limit,
  cursor,
});

export const actionsQuery = z.object({
  targetUserId: z.uuid().optional(),
  limit,
  cursor,
});

export const noteBody = z.object({ note: z.string().trim().max(1000).optional() }).default({});
