import { Router } from 'express';
import * as rooms from '../controllers/room.controller';
import { requireOnboarded, requireUser } from '../middlewares/auth.middleware';
import { validate } from '../middlewares/validate.middleware';
import {
  createRoomBody,
  decideRoomRequestBody,
  roomIdParams,
  roomJoinRequestBody,
  roomRequestParams,
} from '../validators/room.validator';

/** Canlı odalar. Katılım, mikrofon ve sohbet socket üzerinden (room:join vb.). */
export const roomRoutes = Router();

roomRoutes.use(requireUser, requireOnboarded);

roomRoutes.get('/', rooms.list);
roomRoutes.post('/', validate({ body: createRoomBody }), rooms.create);
roomRoutes.post('/:roomId/requests', validate({ params: roomIdParams, body: roomJoinRequestBody }), rooms.requestJoin);
roomRoutes.get('/:roomId/requests', validate({ params: roomIdParams }), rooms.listRequests);
roomRoutes.post(
  '/:roomId/requests/:requestId',
  validate({ params: roomRequestParams, body: decideRoomRequestBody }),
  rooms.decideRequest,
);
