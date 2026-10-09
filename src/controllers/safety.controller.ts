import type { Request, Response } from 'express';
import { safetyService } from '../services/safety.service';

export async function listBlocks(req: Request, res: Response) {
  res.json({ items: await safetyService.listBlocks(req.user!.id) });
}

export async function block(req: Request, res: Response) {
  const { userId, type } = req.valid.body;
  await safetyService.setBlock(req.user!.id, userId, type);
  res.status(204).end();
}

export async function unblock(req: Request, res: Response) {
  await safetyService.removeBlock(req.user!.id, req.valid.params.userId);
  res.status(204).end();
}

export async function report(req: Request, res: Response) {
  const result = await safetyService.report({ reporterId: req.user!.id, ...req.valid.body });
  if (req.valid.body.alsoBlock) await safetyService.setBlock(req.user!.id, req.valid.body.targetUserId, 'BLOCK');
  res.status(201).json(result);
}
