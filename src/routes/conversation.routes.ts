import { Router } from 'express';
import * as conv from '../controllers/conversation.controller';
import { requireOnboarded, requireUser } from '../middlewares/auth.middleware';
import { validate } from '../middlewares/validate.middleware';
import {
  conversationIdParams,
  createAnonymousBody,
  createDirectBody,
  listConversationsQuery,
  markReadBody,
  messagesQuery,
  reportPeerBody,
  sendMessageBody,
  settingsBody,
} from '../validators/conversation.validator';

export const conversationRoutes = Router();

conversationRoutes.use(requireUser, requireOnboarded);

const byId = validate({ params: conversationIdParams });

conversationRoutes.get('/', validate({ query: listConversationsQuery }), conv.list);
conversationRoutes.delete('/', conv.deleteAllForMe);
conversationRoutes.post('/direct', validate({ body: createDirectBody }), conv.createDirect);
conversationRoutes.post('/anonymous', validate({ body: createAnonymousBody }), conv.createAnonymous);

conversationRoutes.get('/:conversationId', byId, conv.get);
conversationRoutes.delete('/:conversationId', byId, conv.deleteForMe);
conversationRoutes.patch('/:conversationId/settings', validate({ params: conversationIdParams, body: settingsBody }), conv.updateSettings);

conversationRoutes.get('/:conversationId/messages', validate({ params: conversationIdParams, query: messagesQuery }), conv.messages);
conversationRoutes.post('/:conversationId/messages', validate({ params: conversationIdParams, body: sendMessageBody }), conv.sendMessage);
conversationRoutes.post('/:conversationId/read', validate({ params: conversationIdParams, body: markReadBody }), conv.markRead);

// Mesaj isteği
conversationRoutes.post('/:conversationId/approve', byId, conv.approve);
conversationRoutes.post('/:conversationId/reject', byId, conv.reject);

// Anonim → profil açma
conversationRoutes.post('/:conversationId/reveal', byId, conv.reveal);

// Sohbet içinden güvenlik (anonimde karşı tarafın id'si bilinmediği için)
conversationRoutes.post('/:conversationId/block', byId, conv.blockPeer);
conversationRoutes.post('/:conversationId/report', validate({ params: conversationIdParams, body: reportPeerBody }), conv.reportPeer);
