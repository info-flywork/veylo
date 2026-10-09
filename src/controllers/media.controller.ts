import type { Request, Response } from 'express';
import { mediaService } from '../services/media.service';

export async function uploadAvatar(req: Request, res: Response) {
  res.json(await mediaService.uploadAvatar(req.user!, req.file!.buffer));
}

export async function removeAvatar(req: Request, res: Response) {
  res.json(await mediaService.removeAvatar(req.user!));
}

export async function uploadVoiceIntro(req: Request, res: Response) {
  res.json(await mediaService.uploadVoiceIntro(req.user!, req.file!.buffer));
}

export async function removeVoiceIntro(req: Request, res: Response) {
  res.json(await mediaService.removeVoiceIntro(req.user!));
}

export async function uploadChatMedia(req: Request, res: Response) {
  res.status(201).json(await mediaService.uploadChatMedia(req.user!.id, req.valid.query.kind, req.file!.buffer));
}
