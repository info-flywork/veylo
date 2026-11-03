import type { Socket } from 'socket.io';
import { z } from 'zod';
import { callService } from '../../services/call.service';
import { callIdBody, directCallBody, inviteIdBody, joinQueueBody, videoRespondBody } from '../../validators/call.validator';
import { on } from './socket-utils';

/** Rastgele arama: sıra, devam oyu, görüntülü geçiş, kapatma. Sonuçlar `call:*` olaylarıyla gelir. */
export function registerCallHandlers(socket: Socket) {
  const userId: string = socket.data.userId;

  /** call:queue { target: any|female|male|nonBinary } → { status: searching|matched } */
  on(socket, 'call:queue', joinQueueBody, ({ target }) => callService.joinQueue(userId, target));

  on(socket, 'call:cancel', z.object({}), () => {
    callService.leaveQueue(userId);
    return { cancelled: true };
  });

  /** Sohbetten birebir arama: call:direct { conversationId, video } → { inviteId, ringSeconds } */
  on(socket, 'call:direct', directCallBody, ({ conversationId, video }) =>
    callService.startDirect(userId, conversationId, video),
  );
  on(socket, 'call:direct_cancel', inviteIdBody, ({ inviteId }) => callService.cancelDirect(userId, inviteId));

  on(socket, 'call:accept', inviteIdBody, ({ inviteId }) => callService.acceptInvite(userId, inviteId));
  on(socket, 'call:decline', inviteIdBody, ({ inviteId }) => callService.declineInvite(userId, inviteId));
  on(socket, 'call:keep', callIdBody, ({ callId }) => callService.keepTalking(userId, callId));
  on(socket, 'call:video_request', callIdBody, ({ callId }) => callService.requestVideo(userId, callId));
  on(socket, 'call:video_respond', videoRespondBody, ({ callId, accept }) =>
    callService.respondVideo(userId, callId, accept),
  );
  on(socket, 'call:end', callIdBody, ({ callId }) => callService.hangUp(userId, callId));
}
