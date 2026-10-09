/**
 * Test girişiyle (AUTH_DEV_BYPASS, "dev:" token) açılmış kullanıcıları ve Bunny'deki dosyalarını siler.
 * Firebase ile açılmış gerçek hesaplara dokunmaz.
 *   npx tsx scripts/cleanup-dev-users.ts          → sadece listeler
 *   npx tsx scripts/cleanup-dev-users.ts --yes    → siler
 */
import 'dotenv/config';
import { prisma } from '../src/lib/prisma';
import { storage } from '../src/lib/storage';

async function main() {
  const users = await prisma.user.findMany({
    where: { authProvider: 'DEV', firebaseUid: { startsWith: 'dev_' } },
    select: { id: true, username: true, media: { select: { path: true } } },
  });
  const files = users.flatMap((u) => u.media.map((m) => m.path));
  console.log(`${users.length} test kullanıcısı, ${files.length} dosya (${storage.name})`);
  if (!process.argv.includes('--yes')) {
    console.log('Silmek için: --yes');
    return;
  }
  for (const path of files) await storage.delete(path).catch(() => undefined);
  // İlişkili kayıtlar (mesaj, üyelik, takip, token defteri...) cascade ile silinir.
  const { count } = await prisma.user.deleteMany({ where: { id: { in: users.map((u) => u.id) } } });
  // Üyesi kalmamış sohbetler
  const orphan = await prisma.conversation.deleteMany({ where: { members: { none: {} } } });
  console.log(`Silindi: ${count} kullanıcı, ${files.length} dosya, ${orphan.count} boş sohbet`);
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(() => prisma.$disconnect());
