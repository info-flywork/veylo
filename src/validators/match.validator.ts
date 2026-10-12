import { z } from 'zod';
import { INTENTS, MOODS } from '../services/match.service';

export const matchSearchBody = z.object({ mood: z.enum(MOODS), intent: z.enum(INTENTS) });
