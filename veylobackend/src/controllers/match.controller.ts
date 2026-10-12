import type { Request, Response } from 'express';
import { matchService } from '../services/match.service';

export async function search(req: Request, res: Response) {
  res.json(await matchService.search(req.user!.id, req.valid.body));
}

export function stats(_req: Request, res: Response) {
  res.json(matchService.stats());
}
