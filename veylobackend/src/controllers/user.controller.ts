import type { Request, Response } from 'express';
import { userService } from '../services/user.service';

export async function getMe(req: Request, res: Response) {
  res.json(await userService.getMe(req.user!));
}

export async function updateMe(req: Request, res: Response) {
  res.json(await userService.updateProfile(req.user!, req.valid.body));
}

export async function completeOnboarding(req: Request, res: Response) {
  res.json(await userService.completeOnboarding(req.user!, req.valid.body));
}

export async function usernameAvailable(req: Request, res: Response) {
  res.json(await userService.usernameAvailability(req.valid.query.username));
}

export async function getProfile(req: Request, res: Response) {
  res.json(await userService.getPublicProfile(req.user!.id, req.valid.params.userId));
}

export async function follow(req: Request, res: Response) {
  await userService.follow(req.user!.id, req.valid.params.userId);
  res.status(204).end();
}

export async function removeFollower(req: Request, res: Response) {
  await userService.removeFollower(req.user!.id, req.valid.params.userId);
  res.status(204).end();
}

export async function unfollow(req: Request, res: Response) {
  await userService.unfollow(req.user!.id, req.valid.params.userId);
  res.status(204).end();
}

export async function followers(req: Request, res: Response) {
  const { cursor, limit } = req.valid.query;
  res.json(await userService.listFollows(req.user!.id, req.valid.params.userId, 'followers', cursor, limit));
}

export async function following(req: Request, res: Response) {
  const { cursor, limit } = req.valid.query;
  res.json(await userService.listFollows(req.user!.id, req.valid.params.userId, 'following', cursor, limit));
}

export async function registerDevice(req: Request, res: Response) {
  const { token, platform, locale } = req.valid.body;
  await userService.registerDevice(req.user!.id, token, platform, locale);
  res.status(204).end();
}

export async function removeDevice(req: Request, res: Response) {
  await userService.removeDevice(req.user!.id, req.valid.body.token);
  res.status(204).end();
}

export async function requestDeletion(req: Request, res: Response) {
  await userService.requestDeletion(req.user!, req.valid.body.reason);
  res.status(202).json({ status: 'PENDING' });
}
