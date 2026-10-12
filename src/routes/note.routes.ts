import { Router } from 'express';
import * as notes from '../controllers/note.controller';
import { requireOnboarded, requireUser } from '../middlewares/auth.middleware';
import { validate } from '../middlewares/validate.middleware';
import { setNoteBody } from '../validators/note.validator';

export const noteRoutes = Router();

noteRoutes.use(requireUser, requireOnboarded);

noteRoutes.get('/', notes.list);
noteRoutes.put('/me', validate({ body: setNoteBody }), notes.setMine);
noteRoutes.delete('/me', notes.deleteMine);
