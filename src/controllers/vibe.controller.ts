import type { Request, Response } from 'express';
import { vibeService } from '../services/vibe.service';

const vid = (req: Request) => req.valid.params.vibeId as string;

export async function feed(req: Request, res: Response) {
  const { cursor, q, limit } = req.valid.query;
  res.json(await vibeService.feed(req.user!.id, { cursor, search: q, limit }));
}

export async function create(req: Request, res: Response) {
  res.status(201).json(await vibeService.create(req.user!.id, req.valid.body));
}

export async function remove(req: Request, res: Response) {
  await vibeService.remove(req.user!.id, vid(req));
  res.status(204).end();
}

export async function like(req: Request, res: Response) {
  res.json(await vibeService.setLiked(req.user!.id, vid(req), true));
}

export async function unlike(req: Request, res: Response) {
  res.json(await vibeService.setLiked(req.user!.id, vid(req), false));
}

export async function reply(req: Request, res: Response) {
  res.status(201).json(await vibeService.reply(req.user!.id, vid(req), req.valid.body));
}

export async function report(req: Request, res: Response) {
  await vibeService.report(req.user!.id, vid(req), req.valid.body);
  res.status(202).json({ status: 'RECEIVED' });
}
