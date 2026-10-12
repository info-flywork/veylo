/**
 * Uygulamanın kendi karakterleri (persona): tasarımdaki kişiler, gruplar ve vibe'lar.
 * Her persona `isPersona=true` ile işaretlidir; gerçek kullanıcılardan her zaman ayırt edilebilir.
 * Tekrar çalıştırılabilir: var olanı atlar, eksikleri tamamlar.
 *   npx tsx scripts/seed-personas.ts
 *   npx tsx scripts/seed-personas.ts --refresh-vibes   → persona vibe'larını yeniden (taze tarihle) paylaşır
 */
import { randomUUID } from 'node:crypto';
import fs from 'node:fs';
import path from 'node:path';
import 'dotenv/config';
import type { User } from '@prisma/client';
import { prisma } from '../src/lib/prisma';
import { PERSONAS, type PersonaDef } from '../src/personas/catalog';
import { conversationService } from '../src/services/conversation.service';
import { mediaService } from '../src/services/media.service';
import { postService } from '../src/services/post.service';

const PHOTOS = path.resolve(__dirname, '../../veylofrontend/assets/images/fakePeople');

const GROUPS: { title: string; isPrivate: boolean; owner: string; members: string[]; messages?: [string, string][] }[] = [
  {
    title: 'Nighttime Chats',
    isPrivate: false,
    owner: 'natalie',
    members: ['lyra', 'adnan', 'sophie', 'clara', 'lara'],
    messages: [
      ['clara', "I'm really bored. Should we do something, guys?"],
      ['sophie', 'What can we do? What do you have in mind?'],
    ],
  },
  { title: 'Movies & TV Shows', isPrivate: true, owner: 'sam', members: ['kyrie', 'lara', 'adnan', 'natalie'] },
  { title: 'Music', isPrivate: false, owner: 'lyra', members: ['clara', 'sophie', 'lara', 'kyrie'] },
  { title: 'Late Night Circle', isPrivate: true, owner: 'adnan', members: ['natalie', 'sam', 'lyra', 'sophie'] },
];

const VIBES: { by: string; body: string; anonymous: boolean }[] = [
  { by: 'natalie', body: '“Eski sevgiliyi unutamamak”', anonymous: false },
  { by: 'clara', body: '"sadece arkadaşız" diyip aslında öyle olmamak', anonymous: false },
  { by: 'lyra', body: "gece 3'te uyuyamayanlar kulübü", anonymous: true },
  { by: 'sophie', body: 'kafamda kurduğum senaryolar', anonymous: true },
  { by: 'sam', body: 'bir gün her şeyi bırakıp sahilde kafe açacağım', anonymous: true },
  { by: 'lara', body: 'gece düşünceleri gündüz mantıksız gelir mi?', anonymous: true },
];

/** Discover gönderileri: her karakterin kendi fotoğrafı. */
const POST_CAPTIONS: Record<string, string> = {
  natalie: 'Kahve ve gece sohbetleri ☕️',
  lyra: 'bugün biraz şiir, biraz yağmur',
  adnan: 'Gece sürüşü 🌃',
  sophie: 'Bir sonraki durak neresi? ✈️',
  clara: 'Paris on my mind',
  sam: 'Kim kutu oyunu oynuyor? 🎲',
  kyrie: 'City lights > everything',
  lara: 'Yeni playlist, yeni kitap 📚',
};

/** Sohbetler ekranındaki notlar (tasarımdaki örnekler). */
const NOTES: { by: string; text: string }[] = [
  { by: 'lyra', text: 'Can’t Sleep' },
  { by: 'clara', text: 'Need Advice' },
  { by: 'lara', text: 'Overthinking' },
  { by: 'sophie', text: 'Looking For A Friend' },
  { by: 'natalie', text: 'Need A Friend' },
  { by: 'kyrie', text: 'New playlist 🎧' },
];
const PERSONA_NOTE_DAYS = 30;

/** Persona vibe'larının yayında kalma süresi (AI paylaşımı gelene kadar boş görünmesin). */
const PERSONA_VIBE_DAYS = 7;

async function upsertPersona(p: PersonaDef): Promise<User> {
  const firebaseUid = `persona_${p.slug}`;
  let user = await prisma.user.findUnique({ where: { firebaseUid } });
  if (!user) {
    user = await prisma.user.create({
      data: {
        firebaseUid,
        authProvider: 'PERSONA',
        isPersona: true,
        username: p.username,
        displayName: p.displayName,
        fullName: p.displayName,
        gender: p.gender,
        bio: p.bio,
        interests: p.interests,
        chatGoal: 'meetSomeoneNew',
        languages: ['en', 'tr'],
        onboardingCompleted: true,
      },
    });
    console.log(`+ persona ${p.username}`);
  }
  if (!user.avatarUrl) {
    await mediaService.uploadAvatar(user, fs.readFileSync(path.join(PHOTOS, p.photo)));
    user = await prisma.user.findUniqueOrThrow({ where: { id: user.id } });
    console.log(`  foto yüklendi: ${p.username}`);
  }
  return user;
}

async function main() {
  const bySlug = new Map<string, User>();
  for (const p of PERSONAS) bySlug.set(p.slug, await upsertPersona(p));
  const id = (slug: string) => bySlug.get(slug)!.id;

  for (const g of GROUPS) {
    const exists = await prisma.conversation.findFirst({
      where: { type: 'GROUP', title: g.title, initiatorId: id(g.owner) },
    });
    if (exists) continue;
    const created = await prisma.conversation.create({
      data: {
        type: 'GROUP',
        title: g.title,
        isPrivate: g.isPrivate,
        initiatorId: id(g.owner),
        members: {
          create: [
            { userId: id(g.owner), role: 'OWNER' },
            ...g.members.map((m) => ({ userId: id(m) })),
          ],
        },
      },
    });
    for (const [by, body] of g.messages ?? []) {
      await conversationService.send(id(by), created.id, { clientMsgId: randomUUID(), type: 'TEXT', body });
    }
    console.log(`+ grup ${g.title}`);
  }

  const personaIds = [...bySlug.values()].map((u) => u.id);
  const refresh = process.argv.includes('--refresh-vibes');
  const active = await prisma.vibe.count({
    where: { authorId: { in: personaIds }, deletedAt: null, expiresAt: { gt: new Date() } },
  });
  if (refresh || active === 0) {
    await prisma.vibe.updateMany({
      where: { authorId: { in: personaIds }, deletedAt: null },
      data: { deletedAt: new Date() },
    });
    const now = Date.now();
    for (const [i, v] of VIBES.entries()) {
      // Birkaç saat arayla paylaşılmış gibi sıralansın.
      const createdAt = new Date(now - i * 47 * 60 * 1000);
      await prisma.vibe.create({
        data: {
          authorId: id(v.by),
          body: v.body,
          anonymous: v.anonymous,
          createdAt,
          expiresAt: new Date(createdAt.getTime() + PERSONA_VIBE_DAYS * 24 * 60 * 60 * 1000),
        },
      });
    }
    console.log(`+ ${VIBES.length} vibe`);
  }
  for (const p of PERSONAS) {
    const user = bySlug.get(p.slug)!;
    const has = await prisma.post.count({ where: { authorId: user.id, deletedAt: null } });
    if (has) continue;
    const upload = await mediaService.uploadPostImage(user.id, fs.readFileSync(path.join(PHOTOS, p.photo)));
    await postService.create(user.id, {
      mediaId: upload.mediaId,
      thumbId: upload.thumbId,
      caption: POST_CAPTIONS[p.slug],
      draft: false,
    });
    console.log(`+ gönderi ${p.username}`);
  }

  for (const n of NOTES) {
    const expiresAt = new Date(Date.now() + PERSONA_NOTE_DAYS * 24 * 60 * 60 * 1000);
    await prisma.note.upsert({
      where: { userId: id(n.by) },
      create: { userId: id(n.by), text: n.text, expiresAt },
      update: { text: n.text, expiresAt },
    });
  }
  console.log(`+ ${NOTES.length} not`);
  console.log('Persona seed tamam.');
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(() => prisma.$disconnect());
