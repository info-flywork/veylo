import { Router } from 'express';
import * as users from '../controllers/user.controller';
import { requireOnboarded, requireUser } from '../middlewares/auth.middleware';
import { validate } from '../middlewares/validate.middleware';
import {
  deletionRequestBody,
  deviceBody,
  listQuery,
  onboardingBody,
  updateProfileBody,
  userIdParams,
  usernameAvailableQuery,
} from '../validators/user.validator';

export const userRoutes = Router();

userRoutes.use(requireUser);

// Kendi hesabım
userRoutes.get('/me', users.getMe);
userRoutes.patch('/me', requireOnboarded, validate({ body: updateProfileBody }), users.updateMe);
userRoutes.post('/me/onboarding', validate({ body: onboardingBody }), users.completeOnboarding);
userRoutes.post('/me/devices', validate({ body: deviceBody }), users.registerDevice);
userRoutes.delete('/me/devices', validate({ body: deviceBody.pick({ token: true }) }), users.removeDevice);
userRoutes.post('/me/deletion-request', validate({ body: deletionRequestBody }), users.requestDeletion);

// Kullanıcı adı kontrolü (profil oluşturma sırasında, onboarding bitmeden de çalışır)
userRoutes.get('/username-available', validate({ query: usernameAvailableQuery }), users.usernameAvailable);

// Beni takip edeni takipçilerimden çıkar
userRoutes.delete('/me/followers/:userId', requireOnboarded, validate({ params: userIdParams }), users.removeFollower);

// Diğer kullanıcılar
userRoutes.get('/:userId', requireOnboarded, validate({ params: userIdParams }), users.getProfile);
userRoutes.post('/:userId/follow', requireOnboarded, validate({ params: userIdParams }), users.follow);
userRoutes.delete('/:userId/follow', requireOnboarded, validate({ params: userIdParams }), users.unfollow);
userRoutes.get(
  '/:userId/followers',
  requireOnboarded,
  validate({ params: userIdParams, query: listQuery }),
  users.followers,
);
userRoutes.get(
  '/:userId/following',
  requireOnboarded,
  validate({ params: userIdParams, query: listQuery }),
  users.following,
);
