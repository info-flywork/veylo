import { randomUUID } from 'node:crypto';
import type { Message } from '@prisma/client';
import { chatEvents } from '../events/chat.events';
import { logger } from '../lib/logger';
import { prisma } from '../lib/prisma';
import { emitToUser } from '../realtime/emitter';
import type { ConversationFull } from '../serializers/conversation.serializer';
import { conversationService } from '../services/conversation.service';
import { personaByUsername, type PersonaDef } from './catalog';
import { personaLimits } from './limits';
import { complete, openAiEnabled, type ChatTurn } from './openai';
import { chatSystemPrompt, type ChatKind } from './prompts';

const TR_REPLIES = [
  'aynı şeyi düşünüyordum',
  'anlat bakalım, dinliyorum',
  'bence de, devam et',
  'bunu daha önce de düşündüm',
  'valla evet',
  'biraz açar mısın',
  'ben de öyle hissediyorum',
  'haha tam olarak',
  'sonra ne oldu',
  'buna katılırım',
];
const EN_REPLIES = [
  'same honestly',
  'wait, say more',
  'i feel that',
  'okay and then',
  'yeah i get that',
  'haha true',
  'keep going',
  'that’s fair',
];
const HISTORY = 14;
/** Grupta gerçek biri susunca cevap bu sürenin içinde gelsin. */
const GROUP_DELAY_MIN = 45_000;
const GROUP_DELAY_MAX = 58_000;
/** Birebir sohbette cevap 1, 2 ya da 3 dakika sonra. */
const DIRECT_DELAYS = [60_000, 120_000, 180_000];

type Member = ConversationFull['members'][number];

/** Sohbet başına bekleyen cevap: yeni mesaj gelirse zamanlayıcı baştan başlar (birleşik cevap). */
const pending = new Map<string, NodeJS.Timeout>();
const replying = new Set<string>();

const rand = (min: number, max: number) => min + Math.random() * (max - min);
const sleep = (ms: number) => new Promise((r) => setTimeout(r, ms));

function personaMembers(c: ConversationFull) {
  return c.members
    .filter((m) => m.user.isPersona && m.user.status === 'ACTIVE')
    .map((m) => ({ member: m, def: personaByUsername(m.user.username) }))
    .filter((x): x is { member: Member; def: PersonaDef } => Boolean(x.def));
}

/** Mesaj karakterin adını/kullanıcı adını anıyor mu. */
function mentions(text: string, def: PersonaDef) {
  const t = text.toLocaleLowerCase('tr');
  const first = def.displayName.split(' ')[0]!.toLocaleLowerCase('tr');
  return t.includes(first) || t.includes(def.username.toLocaleLowerCase('tr'));
}

const TR_WORDS = new Set([
  'abi', 'abla', 'akşam', 'aksam', 'aynen', 'ben', 'bence', 'bir', 'biz', 'bu', 'bugün', 'bugun',
  'burada', 'çok', 'cok', 'çünkü', 'cunku', 'değil', 'degil', 'evet', 'eyvallah', 'gece', 'güzel',
  'guzel', 'hadi', 'hayır', 'hayir', 'için', 'icin', 'işte', 'iste', 'kanka', 'lütfen', 'lutfen',
  'merhaba', 'naber', 'nasıl', 'nasil', 'nasılsın', 'nasilsin', 'orada', 'sağol', 'sagol', 'selam',
  'sen', 'sence', 'şimdi', 'simdi', 'siz', 'sonra', 'şu', 'su', 'tamam', 'teşekkür', 'tesekkur',
  'valla', 'var', 'yok', 'yarın', 'yarin',
]);

function looksTurkish(text: string) {
  if (/[çğıöşüıÇĞİÖŞÜ]/.test(text)) return true;
  const words = text.toLocaleLowerCase('tr').split(/[^\p{L}]+/u).filter(Boolean);
  const hits = words.filter((w) => TR_WORDS.has(w)).length;
  return hits >= 2 || (hits >= 1 && words.length <= 4);
}

type ReplyLanguage = 'tr' | 'en' | 'other';

function replyLanguage(text: string): ReplyLanguage {
  const sample = text.trim();
  if (!sample) return 'other';
  if (looksTurkish(sample)) return 'tr';
  if (/[а-яё]/i.test(sample) || /[ぁ-んァ-ン가-힣\u4e00-\u9fff]/.test(sample)) return 'other';
  return 'en';
}

function fallbackReply(sample: string) {
  const pool = replyLanguage(sample) === 'tr' ? TR_REPLIES : EN_REPLIES;
  return pool[Math.floor(Math.random() * pool.length)]!;
}

function delayFor(kind: string) {
  if (kind === 'GROUP') return rand(GROUP_DELAY_MIN, GROUP_DELAY_MAX);
  const base = DIRECT_DELAYS[Math.floor(Math.random() * DIRECT_DELAYS.length)]!;
  return base + rand(-8_000, 8_000);
}

function schedule(
  conversationId: string,
  persona: { member: Member; def: PersonaDef },
  userId: string,
  delay: number,
) {
  const key = `${conversationId}:${persona.member.userId}`;
  clearTimeout(pending.get(key));
  pending.set(
    key,
    setTimeout(() => {
      pending.delete(key);
      void reply(conversationId, persona, userId).catch((err) => logger.warn({ err }, 'AI karakter cevabı başarısız'));
    }, delay),
  );
}

function onMessage({ conversation: c, message, senderId }: { conversation: ConversationFull; message: Message; senderId: string }) {
  const sender = c.members.find((m) => m.userId === senderId);
  if (!sender || sender.user.isPersona) return; // karakterler birbirine cevap vermez
  if (message.type === 'SYSTEM' || c.status === 'REJECTED') return;

  const personas = personaMembers(c);
  if (personas.length === 0) return;

  let chosen: { member: Member; def: PersonaDef } | undefined;
  if (c.type === 'GROUP') {
    const text = message.body ?? '';
    chosen = personas.find((p) => mentions(text, p.def)) ?? personas[Math.floor(Math.random() * personas.length)];
  } else {
    chosen = personas[0];
  }
  if (!chosen) return;

  // Grupta gerçek biri bir dakika içinde yazarsa zamanlayıcı sıfırlanır ve karakter susar.
  // Birebirde art arda gelen mesajlar tek cevapta toplanır; süre 1, 2 ya da 3 dakika.
  schedule(c.id, chosen, senderId, delayFor(c.type));
}

/** Sunucu yeniden başlarsa, bir dakikadır cevapsız kalan grup mesajını kaçırma. */
async function catchUpQuietGroups() {
  const convos = await prisma.conversation.findMany({
    where: {
      type: 'GROUP',
      status: 'ACCEPTED',
      lastMessageAt: {
        gte: new Date(Date.now() - 15 * 60 * 1000),
        lte: new Date(Date.now() - GROUP_DELAY_MAX),
      },
      lastSenderId: { not: null },
    },
    select: { id: true, lastSenderId: true },
    take: 12,
  });
  if (convos.length === 0) return;
  const humans = await prisma.user.findMany({
    where: { id: { in: convos.map((c) => c.lastSenderId!) }, isPersona: false },
    select: { id: true },
  });
  const humanIds = new Set(humans.map((h) => h.id));
  for (const convo of convos) {
    if (!convo.lastSenderId || !humanIds.has(convo.lastSenderId)) continue;
    if ([...pending.keys()].some((key) => key.startsWith(`${convo.id}:`))) continue;
    try {
      const loaded = await conversationService.loadForMember(convo.id, convo.lastSenderId);
      const personas = personaMembers(loaded);
      const chosen = personas[Math.floor(Math.random() * personas.length)];
      if (!chosen) continue;
      schedule(convo.id, chosen, convo.lastSenderId, rand(2_000, 8_000));
    } catch (err) {
      logger.warn({ err, conversationId: convo.id }, 'Sessiz grup okunamadı');
    }
  }
}

async function reply(conversationId: string, persona: { member: Member; def: PersonaDef }, userId: string) {
  if (replying.has(conversationId)) return;
  replying.add(conversationId);
  try {
    await deliver(conversationId, persona, userId);
  } finally {
    replying.delete(conversationId);
  }
}

async function deliver(conversationId: string, persona: { member: Member; def: PersonaDef }, userId: string) {
  const personaId = persona.member.userId;
  let c = await conversationService.loadForMember(conversationId, personaId);

  // Bana gelen mesaj isteği (ör. vibe cevabı): karakter isteği kabul eder.
  if (c.status === 'PENDING' && c.initiatorId !== personaId) {
    await conversationService.approve(personaId, c.id);
    c = await conversationService.loadForMember(conversationId, personaId);
  }
  if (c.status !== 'ACCEPTED') return;

  const latest = await prisma.message.findFirst({
    where: { conversationId: c.id },
    orderBy: { seq: 'desc' },
    select: { senderId: true, sender: { select: { isPersona: true } } },
  });
  // Bu arada bir karakter yazdıysa ya da başka bir gerçek kullanıcı cevap verdiyse sus.
  if (!latest || latest.sender.isPersona || latest.senderId !== userId) return;
  if (!personaLimits.takeUserReply(userId)) return;

  const history = await prisma.message.findMany({
    where: { conversationId: c.id },
    orderBy: { seq: 'desc' },
    take: HISTORY,
  });
  history.reverse();

  const kind = c.type as ChatKind;
  const nameOf = (id: string) => {
    const m = c.members.find((x) => x.userId === id);
    if (!m) return 'Biri';
    if (kind === 'ANONYMOUS' && !c.revealedAt) return 'Karşı taraf';
    return m.user.displayName ?? m.user.username ?? 'Biri';
  };
  const humanTexts = history
    .filter((m) => m.senderId === userId && m.type === 'TEXT' && m.body && !m.body.startsWith('sticker:'))
    .slice(-4)
    .map((m) => m.body ?? '');
  const sample = humanTexts.join('\n');
  const language = replyLanguage(sample);
  const turns: ChatTurn[] = [
    { role: 'system', content: chatSystemPrompt(persona.def, { kind, groupTitle: c.title, quote: c.contextQuote, language }) },
    ...history.map((m): ChatTurn => {
      const body = m.type === 'IMAGE'
        ? '[fotoğraf gönderdi]'
        : m.type === 'VOICE'
          ? '[sesli mesaj gönderdi]'
          : m.body?.startsWith('sticker:')
            ? '[çıkartma gönderdi]'
            : (m.body ?? '');
      if (m.senderId === personaId) return { role: 'assistant', content: body };
      return { role: 'user', content: kind === 'GROUP' ? `${nameOf(m.senderId)}: ${body}` : body };
    }),
  ];

  const others = c.members.filter((m) => m.userId !== personaId && !m.user.isPersona).map((m) => m.userId);
  const typing = () => others.forEach((id) => emitToUser(id, 'typing', { conversationId: c.id }));
  typing();
  // İstemci "yazıyor"u 3 sn sonra gizler; cevap üretilirken yenilenir.
  const ticker = setInterval(typing, 2_500);
  try {
    const raw = openAiEnabled() ? await complete(turns, { maxTokens: 160 }) : null;
    const drafted = clean(raw, persona.def);
    const text = drafted && (language !== 'tr' || looksTurkish(drafted)) ? drafted : fallbackReply(sample || 'merhaba');
    if (!text) return;
    // Yazma süresi: uzun mesaj biraz daha uzun sürer.
    await sleep(Math.min(6_000, 600 + text.length * 35));
    await conversationService.send(personaId, c.id, { clientMsgId: randomUUID(), type: 'TEXT', body: text });
  } finally {
    clearInterval(ticker);
  }
}

/** Model çıktısını sohbet mesajına çevirir (tırnak, "Ad:" öneki, aşırı uzunluk). */
function clean(raw: string | null, def: PersonaDef) {
  if (!raw) return null;
  let t = raw.trim().replace(/^["“”']+|["“”']+$/g, '');
  const prefix = new RegExp(`^(${def.displayName}|${def.displayName.split(' ')[0]})\\s*:\\s*`, 'i');
  t = t.replace(prefix, '').trim();
  if (t.length > 500) t = `${t.slice(0, 497).trimEnd()}…`;
  return t || null;
}

/** Anonim sohbette kullanıcı profilleri açmayı onaylarsa karakter de onaylar. */
async function onRevealConsent({ conversationId, userId }: { conversationId: string; userId: string }) {
  const c = await conversationService.loadForMember(conversationId, userId);
  const persona = personaMembers(c).find((p) => !p.member.revealConsent);
  if (!persona) return;
  await sleep(rand(2_000, 5_000));
  await conversationService.reveal(persona.member.userId, conversationId);
}

export function startPersonaChat() {
  chatEvents.on('message:sent', onMessage);
  chatEvents.on('reveal:consent', (e) => {
    void onRevealConsent(e).catch((err) => logger.warn({ err }, 'AI karakter reveal onayı başarısız'));
  });
  const catchUp = () => void catchUpQuietGroups().catch((err) => logger.warn({ err }, 'Sessiz grup taraması başarısız'));
  setTimeout(catchUp, 20_000);
  setInterval(catchUp, 30_000).unref();
}
