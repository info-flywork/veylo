import type { Request, Response } from 'express';
import { groupService } from '../services/group.service';

const gid = (req: Request) => req.valid.params.conversationId as string;

export async function discover(req: Request, res: Response) {
  res.json({ items: await groupService.discover(req.user!.id, req.valid.query.q) });
}

export async function create(req: Request, res: Response) {
  res.status(201).json(await groupService.create(req.user!.id, req.valid.body));
}

export async function info(req: Request, res: Response) {
  res.json(await groupService.info(req.user!.id, gid(req)));
}

export async function update(req: Request, res: Response) {
  res.json(await groupService.update(req.user!.id, gid(req), req.valid.body));
}

export async function join(req: Request, res: Response) {
  res.json(await groupService.join(req.user!.id, gid(req), req.valid.body.anonymous));
}

export async function requestJoin(req: Request, res: Response) {
  res.status(201).json(await groupService.requestJoin(req.user!.id, gid(req), req.valid.body));
}

export async function listRequests(req: Request, res: Response) {
  res.json({ items: await groupService.listRequests(req.user!.id, gid(req)) });
}

export async function decideRequest(req: Request, res: Response) {
  const items = await groupService.decideRequest(
    req.user!.id,
    gid(req),
    req.valid.params.requestId as string,
    req.valid.body.approve,
  );
  res.json({ items });
}

export async function addMembers(req: Request, res: Response) {
  res.json(await groupService.addMembers(req.user!.id, gid(req), req.valid.body.userIds));
}

export async function removeMember(req: Request, res: Response) {
  res.json(await groupService.removeMember(req.user!.id, gid(req), req.valid.params.memberId as string));
}

export async function setRole(req: Request, res: Response) {
  res.json(await groupService.setRole(req.user!.id, gid(req), req.valid.params.memberId as string, req.valid.body.role));
}

export async function leave(req: Request, res: Response) {
  res.json(await groupService.leave(req.user!.id, gid(req)));
}
