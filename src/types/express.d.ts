import type { User } from '@prisma/client';

export interface FirebaseIdentity {
  uid: string;
  email?: string;
  provider: 'GOOGLE' | 'APPLE' | 'PASSWORD' | 'DEV';
}

declare global {
  namespace Express {
    interface Request {
      identity?: FirebaseIdentity;
      user?: User;
      /** validate() middleware'inin ayrıştırdığı değerler. */
      valid: { body?: any; query?: any; params?: any };
    }
  }
}

export {};
