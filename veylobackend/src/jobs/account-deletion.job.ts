import { logger } from '../lib/logger';
import { prisma } from '../lib/prisma';
import { accountService } from '../services/account.service';

const TICK_MS = 60 * 60 * 1000;
const BATCH = 20;

/** Süresi dolan silme isteklerini işler. Kullanıcının kendisi silindiğinde istek de cascade ile gider. */
export async function processDueDeletions() {
  const due = await prisma.accountDeletionRequest.findMany({
    where: { status: 'PENDING', purgeAt: { lte: new Date() } },
    orderBy: { purgeAt: 'asc' },
    take: BATCH,
  });
  let done = 0;
  for (const r of due) {
    try {
      await accountService.purgeUser(r.userId);
      done++;
    } catch (err) {
      logger.error({ err, userId: r.userId }, 'Hesap silme başarısız, bir sonraki turda tekrar denenecek');
    }
  }
  return { due: due.length, done };
}

/** Saatte bir çalışır (tek pm2 instance varsayımı). */
export function startAccountDeletionJob() {
  const run = () =>
    processDueDeletions()
      .then((r) => r.due && logger.info(r, 'Hesap silme turu'))
      .catch((err) => logger.error({ err }, 'Hesap silme turu çalışmadı'));
  setTimeout(run, 30_000).unref();
  setInterval(run, TICK_MS).unref();
}
