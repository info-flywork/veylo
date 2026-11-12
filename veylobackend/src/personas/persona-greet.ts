import { randomUUID } from 'node:crypto';
import { logger } from '../lib/logger';
import { prisma } from '../lib/prisma';
import { conversationService } from '../services/conversation.service';
import { pairKey } from '../utils/mask';
import { personaByUsername, type PersonaDef } from './catalog';
import { complete } from './openai';
import { greetSystemPrompt } from './prompts';

/** Ara sıra gerçek bir kullanıcıya kısa bir merhaba. */
const TICK_MS = 25 * 60 * 1000;
const CHANCE = 0.3;
const QUIET_CHANCE = CHANCE / 3;
const GREET_TEMPERATURE = 0.75;

function quietHour() {
  const hour = (new Date().getUTCHours() + 3) % 24;
  return hour >= 2 && hour < 8;
}

async function tick() {
  if (Math.random() > (quietHour() ? QUIET_CHANCE : CHANCE)) return;

  const personas = await prisma.user.findMany({
    where: { isPersona: true, status: 'ACTIVE' },
    select: { id: true, displayName: true, username: true },
  });
  const row = personas[Math.floor(Math.random() * personas.length)];
  if (!row) return;
  const def = personaByUsername(row.username);
  if (!def) return;

  const since = new Date(Date.now() - 3 * 24 * 60 * 60 * 1000);
  const people = await prisma.user.findMany({
    where: { isPersona: false, status: 'ACTIVE', onboardingCompleted: true, lastSeenAt: { gte: since } },
    select: { id: true },
    orderBy: { lastSeenAt: 'desc' },
    take: 40,
  });
  const dayAgo = new Date(Date.now() - 20 * 60 * 60 * 1000);
  for (const person of people.sort(() => Math.random() - 0.5)) {
    const alreadyToday = await prisma.message.findFirst({
      where: {
        createdAt: { gte: dayAgo },
        sender: { isPersona: true },
        conversation: { type: 'DIRECT', members: { some: { userId: person.id } } },
      },
      select: { id: true },
    });
    if (alreadyToday) continue;
    const existing = await prisma.conversation.findUnique({
      where: { type_pairKey: { type: 'DIRECT', pairKey: pairKey(row.id, person.id) } },
      select: { id: true },
    });
    if (existing) continue;

    const line = await helloLine(def);
    const conversation = await conversationService.createDirect(row.id, person.id);
    await conversationService.send(row.id, conversation.id, {
      clientMsgId: randomUUID(),
      type: 'TEXT',
      body: line,
    });
    logger.info({ persona: def.displayName, userId: person.id }, 'AI karakter merhaba dedi');
    return;
  }
}

async function helloLine(def: PersonaDef) {
  const raw = await complete(
    [
      { role: 'system', content: greetSystemPrompt(def) },
      { role: 'user', content: 'Merhaba de.' },
    ],
    { maxTokens: 40, temperature: GREET_TEMPERATURE },
  );
  const text = raw?.trim().replace(/^["“”']+|["“”']+$/g, '').split('\n')[0]?.trim();
  if (text && text.length >= 2 && text.length <= 120) return text;
  return def.voiceExamples[Math.floor(Math.random() * def.voiceExamples.length)]
    ?? 'selam, nasılsın?';
}

export function startPersonaGreets() {
  const run = () => void tick().catch((err) => logger.warn({ err }, 'AI karakter merhabası başarısız'));
  setTimeout(run, 90_000);
  setInterval(run, TICK_MS).unref();
}
