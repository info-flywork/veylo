import { z } from 'zod';

export const borderParams = z.object({ borderId: z.string().min(1).max(32) });
