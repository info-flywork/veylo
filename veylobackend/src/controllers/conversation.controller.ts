import type { Request, Response } from 'express';
import { conversationService } from '../services/conversation.service';

const cid = (req: Request) => req.valid.params.conversationId as string;

export async function list(req: Request, res: Response) {
  res.json({ items: await conversationService.list(req.user!.id, req.valid.query.box) });
}

export async function get(req: Request, res: Response) {
  res.json(await conversationService.get(req.user!.id, cid(req)));
}

export async function createDirect(req: Request, res: Response) {
  res.status(201).json(await conversationService.createDirect(req.user!.id, req.valid.body.userId));
}

export async function createAnonymous(req: Request, res: Response) {
  const { userId, contextQuote } = req.valid.body;
  res.status(201).json(await conversationService.createAnonymous(req.user!.id, userId, contextQuote));
}

export async function messages(req: Request, res: Response) {
  res.json(await conversationService.messages(req.user!.id, cid(req), req.valid.query));
}

export async function sendMessage(req: Request, res: Response) {
  const result = await conversationService.send(req.user!.id, cid(req), req.valid.body);
  res.status(result.duplicate ? 200 : 201).json(result.message);
}

export async function markRead(req: Request, res: Response) {
  res.json(await conversationService.markRead(req.user!.id, cid(req), req.valid.body.seq));
}

export async function approve(req: Request, res: Response) {
  res.json(await conversationService.approve(req.user!.id, cid(req)));
}

export async function reject(req: Request, res: Response) {
  await conversationService.reject(req.user!.id, cid(req));
  res.status(204).end();
}

export async function reveal(req: Request, res: Response) {
  res.json(await conversationService.reveal(req.user!.id, cid(req)));
}

export async function updateSettings(req: Request, res: Response) {
  res.json(await conversationService.updateSettings(req.user!.id, cid(req), req.valid.body));
}

export async function deleteForMe(req: Request, res: Response) {
  await conversationService.deleteForMe(req.user!.id, cid(req));
  res.status(204).end();
}

export async function deleteAllForMe(req: Request, res: Response) {
  res.json(await conversationService.deleteAllForMe(req.user!.id));
}

export async function blockPeer(req: Request, res: Response) {
  await conversationService.blockPeer(req.user!.id, cid(req));
  res.status(204).end();
}

export async function reportPeer(req: Request, res: Response) {
  res.status(201).json(await conversationService.reportPeer(req.user!.id, cid(req), req.valid.body));
}
