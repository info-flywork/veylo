import type { Request, Response } from 'express';
import { postService } from '../services/post.service';

const pid = (req: Request) => req.valid.params.postId as string;
const me = (req: Request) => req.user!.id;

export async function feed(req: Request, res: Response) {
  res.json(await postService.feed(me(req), req.valid.query));
}

export async function create(req: Request, res: Response) {
  res.status(201).json(await postService.create(me(req), req.valid.body));
}

export async function get(req: Request, res: Response) {
  res.json(await postService.get(me(req), pid(req)));
}

export async function update(req: Request, res: Response) {
  res.json(await postService.update(me(req), pid(req), req.valid.body));
}

export async function remove(req: Request, res: Response) {
  await postService.remove(me(req), pid(req));
  res.status(204).end();
}

export const like = async (req: Request, res: Response) => res.json(await postService.setLiked(me(req), pid(req), true));
export const unlike = async (req: Request, res: Response) => res.json(await postService.setLiked(me(req), pid(req), false));
export const save = async (req: Request, res: Response) => res.json(await postService.setSaved(me(req), pid(req), true));
export const unsave = async (req: Request, res: Response) => res.json(await postService.setSaved(me(req), pid(req), false));

export async function view(req: Request, res: Response) {
  await postService.view(me(req), pid(req));
  res.status(204).end();
}

export async function stats(req: Request, res: Response) {
  res.json(await postService.stats(me(req), pid(req)));
}

export async function boost(req: Request, res: Response) {
  res.json(await postService.boost(me(req), pid(req)));
}

export async function comments(req: Request, res: Response) {
  res.json(await postService.comments(me(req), pid(req), req.valid.query.cursor));
}

export async function addComment(req: Request, res: Response) {
  res.status(201).json(await postService.addComment(me(req), pid(req), req.valid.body.body));
}

export async function deleteComment(req: Request, res: Response) {
  await postService.deleteComment(me(req), req.valid.params.commentId as string);
  res.status(204).end();
}

export async function report(req: Request, res: Response) {
  await postService.report(me(req), pid(req), req.valid.body);
  res.status(202).json({ status: 'RECEIVED' });
}

export async function byUser(req: Request, res: Response) {
  res.json(await postService.byUser(me(req), req.valid.params.userId as string, req.valid.query.cursor));
}

export async function drafts(req: Request, res: Response) {
  res.json(await postService.drafts(me(req)));
}

export async function saved(req: Request, res: Response) {
  res.json(await postService.saved(me(req), req.valid.query.cursor));
}
