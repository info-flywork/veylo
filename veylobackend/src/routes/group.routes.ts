import { Router } from 'express';
import * as group from '../controllers/group.controller';
import { requireOnboarded, requireUser } from '../middlewares/auth.middleware';
import { validate } from '../middlewares/validate.middleware';
import {
  addMembersBody,
  createGroupBody,
  decideRequestBody,
  discoverGroupsQuery,
  groupIdParams,
  groupMemberParams,
  groupRequestParams,
  joinGroupBody,
  joinRequestBody,
  setRoleBody,
  updateGroupBody,
} from '../validators/group.validator';

export const groupRoutes = Router();

groupRoutes.use(requireUser, requireOnboarded);

const byId = validate({ params: groupIdParams });

groupRoutes.get('/', validate({ query: discoverGroupsQuery }), group.discover);
groupRoutes.post('/', validate({ body: createGroupBody }), group.create);
groupRoutes.get('/:conversationId', byId, group.info);
groupRoutes.patch('/:conversationId', validate({ params: groupIdParams, body: updateGroupBody }), group.update);

// Katılma: açık grupta direkt, gizli grupta istek + yönetici onayı
groupRoutes.post('/:conversationId/join', validate({ params: groupIdParams, body: joinGroupBody }), group.join);
groupRoutes.post('/:conversationId/requests', validate({ params: groupIdParams, body: joinRequestBody }), group.requestJoin);
groupRoutes.get('/:conversationId/requests', byId, group.listRequests);
groupRoutes.post(
  '/:conversationId/requests/:requestId',
  validate({ params: groupRequestParams, body: decideRequestBody }),
  group.decideRequest,
);

// Üyeler (yönetici işlemleri) ve ayrılma
groupRoutes.post('/:conversationId/members', validate({ params: groupIdParams, body: addMembersBody }), group.addMembers);
groupRoutes.delete('/:conversationId/members/me', byId, group.leave);
groupRoutes.delete('/:conversationId/members/:memberId', validate({ params: groupMemberParams }), group.removeMember);
groupRoutes.patch(
  '/:conversationId/members/:memberId',
  validate({ params: groupMemberParams, body: setRoleBody }),
  group.setRole,
);
