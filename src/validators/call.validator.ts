import { z } from 'zod';
import { CALL_TARGETS } from '../services/call.service';

export const joinQueueBody = z.object({ target: z.enum(CALL_TARGETS).default('any') });
export const callIdBody = z.object({ callId: z.uuid() });
export const videoRespondBody = callIdBody.extend({ accept: z.boolean() });
