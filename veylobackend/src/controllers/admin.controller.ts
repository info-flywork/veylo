import type { Request, Response } from 'express';
import { adminService } from '../services/admin.service';

const actor = (req: Request) => req.adminActor!;

export async function stats(_req: Request, res: Response) {
  res.json(await adminService.stats());
}

export async function listReports(req: Request, res: Response) {
  res.json(await adminService.listReports(req.valid.query));
}

export async function getReport(req: Request, res: Response) {
  res.json(await adminService.getReport(req.valid.params.reportId));
}

export async function setReportStatus(req: Request, res: Response) {
  res.json(await adminService.setReportStatus(actor(req), req.valid.params.reportId, req.valid.body.status));
}

export async function resolveReport(req: Request, res: Response) {
  res.json(await adminService.resolveReport(actor(req), req.valid.params.reportId, req.valid.body));
}

export async function listUsers(req: Request, res: Response) {
  res.json(await adminService.listUsers(req.valid.query));
}

export async function getUser(req: Request, res: Response) {
  res.json(await adminService.getUser(req.valid.params.userId));
}

export async function suspend(req: Request, res: Response) {
  const { days, reason } = req.valid.body;
  res.json(await adminService.suspend(actor(req), req.valid.params.userId, days, reason));
}

export async function unsuspend(req: Request, res: Response) {
  res.json(await adminService.unsuspend(actor(req), req.valid.params.userId, req.valid.body.note));
}

export async function listDeletionRequests(req: Request, res: Response) {
  res.json(await adminService.listDeletionRequests(req.valid.query));
}

export async function purgeNow(req: Request, res: Response) {
  res.json(await adminService.purgeNow(actor(req), req.valid.params.requestId, req.valid.body.note));
}

export async function listActions(req: Request, res: Response) {
  res.json(await adminService.listActions(req.valid.query));
}
