import { env } from '../config/env';
import { logger } from '../lib/logger';
import { personaLimits } from './limits';

export interface ChatTurn {
  role: 'system' | 'user' | 'assistant';
  content: string;
}

export const openAiEnabled = () => Boolean(env.OPENAI_API_KEY);

/** OpenAI Chat Completions. Anahtar yoksa, tavan dolduysa ya da hata olursa null döner. */
export async function complete(
  messages: ChatTurn[],
  opts: { maxTokens: number; temperature?: number },
): Promise<string | null> {
  if (!env.OPENAI_API_KEY || !personaLimits.takeCall()) return null;
  try {
    const res = await fetch(`${env.OPENAI_BASE_URL}/chat/completions`, {
      method: 'POST',
      headers: { authorization: `Bearer ${env.OPENAI_API_KEY}`, 'content-type': 'application/json' },
      body: JSON.stringify({
        model: env.OPENAI_MODEL,
        messages,
        max_tokens: opts.maxTokens,
        temperature: opts.temperature ?? 0.9,
        presence_penalty: 0.4,
      }),
      signal: AbortSignal.timeout(20_000),
    });
    if (!res.ok) {
      logger.warn({ status: res.status, body: (await res.text()).slice(0, 300) }, 'OpenAI hatası');
      return null;
    }
    const data = (await res.json()) as { choices?: { message?: { content?: string } }[] };
    return data.choices?.[0]?.message?.content?.trim() || null;
  } catch (err) {
    logger.warn({ err }, 'OpenAI isteği başarısız');
    return null;
  }
}
