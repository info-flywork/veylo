import { z } from 'zod';
import { usernameSchema } from './user.validator';

export const usernameLoginBody = z.object({
  username: usernameSchema,
  password: z.string().min(1).max(128),
});
