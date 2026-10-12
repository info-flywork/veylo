import { EventEmitter } from 'node:events';
import type { Message } from '@prisma/client';
import type { ConversationFull } from '../serializers/conversation.serializer';

/**
 * Sohbet olayları: başka modüller (ör. AI karakterler) sohbet servisine bağımlı olmadan dinler.
 * Dinleyiciler hata fırlatmamalı; mesaj gönderimini asla bekletmez.
 */
interface ChatEvents {
  'message:sent': [{ conversation: ConversationFull; message: Message; senderId: string }];
  'reveal:consent': [{ conversationId: string; userId: string }];
}

export const chatEvents = new EventEmitter<ChatEvents>();
