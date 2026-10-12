import { logger } from '../lib/logger';
import { openAiEnabled } from './openai';
import { startPersonaChat } from './persona-chat';
import { startPersonaVibes } from './persona-vibes';

/** AI karakterleri başlatır. OPENAI_API_KEY yoksa dinler ama hiçbir şey üretmez. */
export function startPersonas() {
  startPersonaChat();
  startPersonaVibes();
  logger.info(openAiEnabled() ? 'AI karakterler aktif' : 'AI karakterler kapalı (OPENAI_API_KEY yok)');
}
