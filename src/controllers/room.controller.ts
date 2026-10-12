import type { Request, Response } from 'express';
import { roomService } from '../services/room.service';

const rid = (req: Request) => req.valid.params.roomId as string;

export async function list(req: Request, res: Response) {
  res.json({ items: await roomService.list(req.user!.id) });
}

export async function create(req: Request, res: Response) {
  res.status(201).json(await roomService.create(req.user!.id, req.valid.body));
}

export async function requestJoin(req: Request, res: Response) {
  res.status(201).json(await roomService.requestJoin(req.user!.id, rid(req), req.valid.body));
}

export async function listRequests(req: Request, res: Response) {
  res.json({ items: await roomService.listRequests(req.user!.id, rid(req)) });
}

export async function decideRequest(req: Request, res: Response) {
  const items = await roomService.decideRequest(
    req.user!.id,
    rid(req),
    req.valid.params.requestId as string,
    req.valid.body.approve,
  );
  res.json({ items });
}
