import { z } from 'zod';
import { NOTE } from '../config/constants';

export const setNoteBody = z.object({ text: z.string().trim().min(1).max(NOTE.maxLength) });
