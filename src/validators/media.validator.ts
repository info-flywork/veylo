import { z } from 'zod';

export const chatMediaQuery = z.object({ kind: z.enum(['image', 'voice']) });
