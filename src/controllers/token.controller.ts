import type { Request, Response } from 'express';
import { storeService } from '../services/store.service';
import { tokenService } from '../services/token.service';

export async function balance(req: Request, res: Response) {
  res.json({ balance: await tokenService.getBalance(req.user!.id) });
}

export async function history(req: Request, res: Response) {
  const { cursor, limit } = req.valid.query;
  res.json(await tokenService.history(req.user!.id, cursor, limit));
}

/** Uygulama fiyatları RevenueCat'ten alır; burası ürün → token eşlemesini gösterir. */
export async function products(_req: Request, res: Response) {
  res.json({ items: storeService.listTokenProducts() });
}

export async function listBorders(req: Request, res: Response) {
  res.json({ items: await storeService.listBorders(req.user!.id) });
}

export async function purchaseBorder(req: Request, res: Response) {
  res.json(await storeService.purchaseBorder(req.user!.id, req.valid.params.borderId));
}
