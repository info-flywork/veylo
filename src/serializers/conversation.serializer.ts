import type { Message, Prisma, User } from '@prisma/client';
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
  if (peerMember.profileShared) {
    return { ...serializeUserSummary(peerMember.user), avatarBlurred: false };
  }
  const progress = c.connectionProgress;
  const name = peerMember.user.displayName ?? peerMember.user.username;
  const displayName = peerMember.nameShared
    ? name
    : progress >= CONNECTION.milestones.initial
      ? maskName(name)
      : '******';
  const photoVisible = peerMember.photoShared || progress >= CONNECTION.milestones.blurredPhoto;
  return {
    id: null,
    username: null,
    displayName,
    // Onay ya da %70: sunucuda üretilmiş bulanık önizleme (orijinal fotoğrafa ulaşılamaz).
    avatarUrl: photoVisible ? peerMember.user.avatarBlurUrl : null,
    avatarBlurred: true,
    borderId: null,
    // Kimlik gizli olsa da AI karakter olduğu her zaman belli.
    isAi: peerMember.user.isPersona,
  };
}

type MemberWithUser = ConversationFull['members'][number];

/** Grup üyesi: "Hesabımı gizle" açıksa maskeli ad + bulanık fotoğraf, id/kullanıcı adı yok. */
export function serializeGroupMember(m: Pick<MemberWithUser, 'anonymous' | 'user'>) {
  const name = m.user.displayName ?? m.user.username;
  if (m.anonymous) {
    return {
      id: null,
      username: null,
      displayName: maskName(name),
      avatarUrl: m.user.avatarBlurUrl,
      avatarBlurred: true,
      isAi: m.user.isPersona,
    };
  }
  return {
    id: m.user.id,
    username: m.user.username,
    displayName: name,
    avatarUrl: m.user.avatarUrl,
    avatarBlurred: false,
    isAi: m.user.isPersona,
  };
}

/** Grup kartı/başlığı için en fazla 3 üye fotoğrafı (izleyen hariç). */
export function groupAvatars(c: ConversationFull, viewerId?: string) {
  return c.members
    .filter((m) => m.userId !== viewerId)
    .map((m) => serializeGroupMember(m).avatarUrl)
    .filter((u): u is string => Boolean(u))
    .slice(0, 3);
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
    group:
      c.type === 'GROUP'
        ? { isPrivate: c.isPrivate, myRole: me.role, anonymous: me.anonymous, avatars: groupAvatars(c, viewerId) }
        : null,
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

export function serializeMessage(
  m: Message,
  c: { type: string; revealedAt: Date | null; members?: MemberWithUser[] },
  viewerId: string,
  /** Gruptan ayrılmış göndericiler (messages() doldurur). */
  formerMembers?: Map<string, User>,
) {
  const isMine = m.senderId === viewerId;
  let sender = null;
  if (c.type === 'GROUP' && !isMine) {
    const member = c.members?.find((x) => x.userId === m.senderId);
    const former = formerMembers?.get(m.senderId);
    if (member) sender = serializeGroupMember(member);
    else if (former) sender = serializeGroupMember({ anonymous: true, user: former });
  }
  return {
    id: m.id,
    conversationId: m.conversationId,
    seq: m.seq,
    clientMsgId: isMine ? m.clientMsgId : undefined,
    type: m.type,
    body: m.body,
    mediaUrl: m.mediaUrl,
    isMine,
    senderId: (isIdentityHidden(c) || (sender && sender.id === null)) && !isMine ? null : m.senderId,
    sender,
    createdAt: m.createdAt,
  };
}
