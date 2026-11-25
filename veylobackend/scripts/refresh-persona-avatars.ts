/**
 * Natalie / Lara avatar dosyalarını yeniden yükler.
 *   npx tsx scripts/refresh-persona-avatars.ts
 */
import fs from 'node:fs';
import path from 'node:path';
import 'dotenv/config';
import { prisma } from '../src/lib/prisma';
import { mediaService } from '../src/services/media.service';

const PHOTOS = path.resolve(__dirname, '../../veylofrontend/assets/images/fakePeople');

const TARGETS = [
  { slug: 'natalie', photo: 'fake01.png' },
  { slug: 'clara', photo: 'fake05.png' },
  { slug: 'lara', photo: 'fake08.png' },
];

async function main() {
  for (const t of TARGETS) {
    const user = await prisma.user.findUnique({
      where: { firebaseUid: `persona_${t.slug}` },
    });
    if (!user) {
      console.log('missing', t.slug);
      continue;
    }
    const buf = fs.readFileSync(path.join(PHOTOS, t.photo));
    await mediaService.uploadAvatar(user, buf);
    console.log('updated', t.slug);
  }
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(() => prisma.$disconnect());
