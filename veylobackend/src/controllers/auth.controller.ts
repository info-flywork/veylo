import type { Request, Response } from 'express';
import { authService } from '../services/auth.service';
import { userService } from '../services/user.service';

/**
 * POST /auth/session
 * Uygulama Firebase ile giriş yaptıktan sonra çağırır. Kullanıcı yoksa oluşturulur (+100 token).
 * Dönen `onboardingCompleted` false ise uygulama profil oluşturma adımlarına gider.
 */
export async function createSession(req: Request, res: Response) {
  const { user, isNew } = await authService.upsertSession(req.identity!);
  res.status(isNew ? 201 : 200).json({ isNew, user: await userService.getMe(user) });
}

/**
 * POST /auth/username-login { username, password } → { customToken }
 * Uygulama dönen token ile FirebaseAuth.signInWithCustomToken yapar, sonra /auth/session.
 */
export async function usernameLogin(req: Request, res: Response) {
  const { username, password } = req.valid.body;
  res.json({ customToken: await authService.loginWithUsername(username, password) });
}
