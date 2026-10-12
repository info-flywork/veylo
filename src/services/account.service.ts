import { firebaseAuth } from '../lib/firebase';
import { logger } from '../lib/logger';
import { prisma } from '../lib/prisma';
import { storage } from '../lib/storage';
import { disconnectUser, emitToUser } from '../realtime/emitter';
import { groupService } from './group.service';

/**
 * Hesabı ve tüm verilerini kalıcı siler:
 * birebir/anonim sohbetler (karşı tarafta da kalkar), grup üyelikleri (sahiplik devredilir),
 * depodaki dosyalar, Firebase hesabı ve veritabanındaki her şey (ilişkiler cascade).
 * Tekrar çalıştırılabilir: yarıda kalırsa bir sonraki çalışmada kaldığı yerden tamamlar.
 */
async function purgeUser(userId: string, actor = 'system', note?: string) {
  const user = await prisma.user.findUnique({ where: { id: userId } });
  if (!user) return { purged: false };
  disconnectUser(userId);

  const memberships = await prisma.conversationMember.findMany({
    where: { userId },
    include: { conversation: { select: { id: true, type: true } }, },
  });
  for (const m of memberships) {
    const c = m.conversation;
    try {
      if (c.type === 'GROUP') {
        await groupService.leave(userId, c.id);
        continue;
      }
      const peers = await prisma.conversationMember.findMany({
        where: { conversationId: c.id, userId: { not: userId } },
        select: { userId: true },
      });
      await prisma.conversation.delete({ where: { id: c.id } });
      for (const p of peers) emitToUser(p.userId, 'conversation:removed', { conversationId: c.id });
    } catch (err) {
      logger.warn({ err, conversationId: c.id }, 'Silinen hesabın sohbeti temizlenemedi');
    }
  }

  // Depodaki dosyalar: biri silinemezse kayıt kalır, iş bir sonraki turda yeniden dener.
  const media = await prisma.media.findMany({ where: { ownerId: userId }, select: { id: true, path: true } });
  let failed = 0;
  for (const m of media) {
    try {
      await storage.delete(m.path);
      await prisma.media.delete({ where: { id: m.id } });
    } catch (err) {
      failed++;
      logger.warn({ err, path: m.path }, 'Silinen hesabın dosyası silinemedi');
    }
  }
  if (failed) throw new Error(`${failed} dosya silinemedi`);

  if (user.authProvider !== 'PERSONA' && !user.firebaseUid.startsWith('dev_')) {
    const auth = firebaseAuth();
    if (!auth) throw new Error('Firebase yapılandırılmamış; Firebase hesabı silinemez');
    await auth.deleteUser(user.firebaseUid).catch((err: { code?: string }) => {
      if (err.code !== 'auth/user-not-found') throw err;
    });
  }

  await prisma.$transaction([
    prisma.adminAction.create({
      data: { actor, action: 'ACCOUNT_PURGED', targetUserId: userId, targetLabel: user.username ?? user.id, note },
    }),
    prisma.user.delete({ where: { id: userId } }),
  ]);
  logger.info({ userId }, 'Hesap kalıcı olarak silindi');
  return { purged: true };
}

export const accountService = { purgeUser };
