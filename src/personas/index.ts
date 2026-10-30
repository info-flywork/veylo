import { logger } from '../lib/logger';
import { openAiEnabled } from './openai';
import { startPersonaChat } from './persona-chat';
import { startPersonaGreets } from './persona-greet';
import { startPersonaVibes } from './persona-vibes';

/** AI karakterleri başlatır. Anahtar yoksa kısa hazır cümlelerle devam eder. */
export function startPersonas() {
  startPersonaChat();
  startPersonaVibes();
  startPersonaGreets();
  logger.info(openAiEnabled() ? 'AI karakterler aktif' : 'AI karakterler hazır cümlelerle aktif');
}
