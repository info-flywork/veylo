import type { Request, Response } from 'express';
import { noteService } from '../services/note.service';

export async function list(req: Request, res: Response) {
  res.json(await noteService.list(req.user!.id));
}

export async function setMine(req: Request, res: Response) {
  res.json(await noteService.setMine(req.user!.id, req.valid.body.text));
}

export async function deleteMine(req: Request, res: Response) {
  await noteService.deleteMine(req.user!.id);
  res.status(204).end();
}
