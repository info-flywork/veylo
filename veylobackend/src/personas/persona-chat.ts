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

/** Grupta biri karakterin adını anmadıysa yine de cevap verme olasılığı. */
const GROUP_REPLY_CHANCE = 0.55;

const FALLBACK_REPLIES = [
  'aynı şeyi düşünüyordum',
  'anlat bakalım',
  'bence de',
  'devam et, dinliyorum',
  'haha evet',
  'bunu daha önce de düşündüm',
  'same honestly',
  'wait, say more',
  'i feel that',
];
/** Aynı grupta iki AI cevabı arasında en az bekleme. */
const GROUP_COOLDOWN_MS = 25_000;
const HISTORY = 14;

type Member = ConversationFull['members'][number];

/** Sohbet başına bekleyen cevap: yeni mesaj gelirse zamanlayıcı baştan başlar (birleşik cevap). */
const pending = new Map<string, NodeJS.Timeout>();
const lastGroupReply = new Map<string, number>();

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

function onMessage({ conversation: c, message, senderId }: { conversation: ConversationFull; message: Message; senderId: string }) {
  if (!openAiEnabled()) return;
  const sender = c.members.find((m) => m.userId === senderId);
  if (!sender || sender.user.isPersona) return; // karakterler birbirine cevap vermez
  if (message.type === 'SYSTEM' || c.status === 'REJECTED') return;

  const personas = personaMembers(c);
  if (personas.length === 0) return;

  let chosen: { member: Member; def: PersonaDef } | undefined;
  if (c.type === 'GROUP') {
    const text = message.body ?? '';
    chosen = personas.find((p) => mentions(text, p.def));
    if (!chosen) {
      if (Date.now() - (lastGroupReply.get(c.id) ?? 0) < GROUP_COOLDOWN_MS) return;
      if (Math.random() > GROUP_REPLY_CHANCE) return;
      chosen = personas[Math.floor(Math.random() * personas.length)];
    }
  } else {
    chosen = personas[0];
  }
  if (!chosen) return;

  // Aynı sohbette art arda gelen mesajlar tek cevapta toplanır.
  const key = `${c.id}:${chosen.member.userId}`;
  clearTimeout(pending.get(key));
  const target = chosen;
  pending.set(
    key,
    setTimeout(() => {
      pending.delete(key);
      void reply(c.id, target, senderId).catch((err) => logger.warn({ err }, 'AI karakter cevabı başarısız'));
    }, rand(1_500, 4_000)),
  );
}

async function reply(conversationId: string, persona: { member: Member; def: PersonaDef }, userId: string) {
  if (!personaLimits.takeUserReply(userId)) return;
  const personaId = persona.member.userId;
  let c = await conversationService.loadForMember(conversationId, personaId);

  // Bana gelen mesaj isteği (ör. vibe cevabı): karakter isteği kabul eder.
  if (c.status === 'PENDING' && c.initiatorId !== personaId) {
    await conversationService.approve(personaId, c.id);
    c = await conversationService.loadForMember(conversationId, personaId);
  }
  if (c.status !== 'ACCEPTED') return;

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
  const turns: ChatTurn[] = [
    { role: 'system', content: chatSystemPrompt(persona.def, { kind, groupTitle: c.title, quote: c.contextQuote }) },
    ...history.map((m): ChatTurn => {
      const body = m.type === 'IMAGE' ? '[fotoğraf gönderdi]' : m.type === 'VOICE' ? '[sesli mesaj gönderdi]' : (m.body ?? '');
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
    const raw = await complete(turns, { maxTokens: 160 });
    const text = clean(raw, persona.def) ?? FALLBACK_REPLIES[Math.floor(Math.random() * FALLBACK_REPLIES.length)]!;
    if (!text) return;
    // Yazma süresi: uzun mesaj biraz daha uzun sürer.
    await sleep(Math.min(6_000, 600 + text.length * 35));
    await conversationService.send(personaId, c.id, { clientMsgId: randomUUID(), type: 'TEXT', body: text });
    if (kind === 'GROUP') lastGroupReply.set(c.id, Date.now());
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
}
