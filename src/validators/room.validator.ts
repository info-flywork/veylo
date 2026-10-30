import { z } from 'zod';
import { ROOM } from '../services/room.service';

export const roomIdParams = z.object({ roomId: z.uuid() });
export const roomRequestParams = roomIdParams.extend({ requestId: z.uuid() });

export const createRoomBody = z.object({
  title: z.string().trim().min(1).max(ROOM.titleMaxLength),
  /** "Hide Your Account": oda sahibi maskeli görünür. */
  anonymous: z.boolean().default(false),
  isPrivate: z.boolean().default(false),
});

export const roomJoinRequestBody = z.object({
  message: z.string().trim().max(200).optional(),
  anonymous: z.boolean().default(false),
});

export const decideRoomRequestBody = z.object({ approve: z.boolean() });

// Socket olayları
export const roomJoinEvent = roomIdParams.extend({ anonymous: z.boolean().default(false) });
export const roomMicEvent = roomIdParams.extend({ on: z.boolean() });
export const roomMessageEvent = roomIdParams.extend({ body: z.string().trim().min(1).max(ROOM.messageMaxLength) });
export const roomKickEvent = roomIdParams.extend({ uid: z.number().int().positive() });
export const roomMicLockEvent = roomKickEvent.extend({ locked: z.boolean() });
