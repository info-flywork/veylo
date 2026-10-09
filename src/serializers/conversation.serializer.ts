import type { Message, Prisma } from '@prisma/client';
import { CONNECTION } from '../config/constants';
import { maskName } from '../utils/mask';
import { serializeUserSummary } from './user.serializer';

export type ConversationFull = Prisma.ConversationGetPayload<{
  include: { members: { include: { user: true } } };
}>;

export interface ViewerContext {
  /** Karşı taraf viewer'ı kısıtladıysa çevrimiçi/okundu bilgisi gizlenir. */
  restrictedByPeer: boolean;
  isOnline: (userId: string) => boolean;
}

/** Anonim sohbet açılmadıysa karşı tarafın kimliği hiçbir alanda dönmez. */
export function isIdentityHidden(c: { type: string; revealedAt: Date | null }) {
  return c.type === 'ANONYMOUS' && !c.revealedAt;
}

export function peerOf(c: ConversationFull, viewerId: string) {
  return c.members.find((m) => m.userId !== viewerId) ?? null;
}

function anonymousPeer(c: ConversationFull, peerMember: NonNullable<ReturnType<typeof peerOf>>) {
  const progress = c.connectionProgress;
  const name = peerMember.user.displayName ?? peerMember.user.username;
  return {
    id: null,
    username: null,
    // %25'te ilk harf açılır (Flutter'daki milestone'lar).
    displayName: progress >= CONNECTION.milestones.initial ? maskName(name) : '******',
    // %70'te sunucuda üretilmiş bulanık önizleme (ayrı rastgele yol, orijinal fotoğrafa ulaşılamaz).
    avatarUrl: progress >= CONNECTION.milestones.blurredPhoto ? peerMember.user.avatarBlurUrl : null,
    avatarBlurred: true,
    borderId: null,
  };
}

export function serializeConversation(c: ConversationFull, viewerId: string, ctx: ViewerContext) {
  const me = c.members.find((m) => m.userId === viewerId)!;
  const peerMember = c.type === 'GROUP' ? null : peerOf(c, viewerId);
  const hidden = isIdentityHidden(c);

  let peer = null;
  if (peerMember) {
    peer = hidden ? anonymousPeer(c, peerMember) : serializeUserSummary(peerMember.user);
  }

  const peerOnline =
    peerMember && !ctx.restrictedByPeer && peerMember.user.status === 'ACTIVE'
      ? ctx.isOnline(peerMember.userId)
      : false;

  const lastVisible = c.lastSeq > me.clearedSeq;

  return {
    id: c.id,
    type: c.type,
    status: c.status,
    /** Bana gelen, henüz onaylamadığım istek. */
    isRequest: c.status === 'PENDING' && c.initiatorId !== viewerId,
    isInitiator: c.initiatorId === viewerId,
    title: c.type === 'GROUP' ? c.title : peer?.displayName ?? null,
    peer,
    isOnline: peerOnline,
    memberCount: c.members.length,
    connection:
      c.type === 'ANONYMOUS'
        ? {
            progress: c.connectionProgress,
            revealed: Boolean(c.revealedAt),
            myConsent: me.revealConsent,
            peerConsent: peerMember?.revealConsent ?? false,
            milestones: CONNECTION.milestones,
          }
        : null,
    contextQuote: c.contextQuote,
    lastMessage: lastVisible
      ? {
          preview: c.lastMessagePreview,
          at: c.lastMessageAt,
          isMine: c.lastSenderId === viewerId,
        }
      : null,
    unreadCount: Math.max(0, c.lastSeq - Math.max(me.lastReadSeq, me.clearedSeq)),
    /** Karşı tarafın okuduğu son seq ("görüldü"). Kısıtlandıysam gizli. */
    peerLastReadSeq: peerMember && !ctx.restrictedByPeer ? peerMember.lastReadSeq : null,
    pinned: me.pinned,
    muted: me.muted,
    createdAt: c.createdAt,
  };
}

export function serializeMessage(m: Message, c: { type: string; revealedAt: Date | null }, viewerId: string) {
  const isMine = m.senderId === viewerId;
  return {
    id: m.id,
    conversationId: m.conversationId,
    seq: m.seq,
    clientMsgId: isMine ? m.clientMsgId : undefined,
    type: m.type,
    body: m.body,
    mediaUrl: m.mediaUrl,
    isMine,
    senderId: isIdentityHidden(c) && !isMine ? null : m.senderId,
    createdAt: m.createdAt,
  };
}
