import { Router } from 'express';
import * as posts from '../controllers/post.controller';
import { requireOnboarded, requireUser } from '../middlewares/auth.middleware';
import { validate } from '../middlewares/validate.middleware';
import {
  commentBody,
  commentIdParams,
  createPostBody,
  cursorQuery,
  feedQuery,
  postIdParams,
  reportPostBody,
  updatePostBody,
  userPostsParams,
} from '../validators/post.validator';

export const postRoutes = Router();

postRoutes.use(requireUser, requireOnboarded);

const byId = validate({ params: postIdParams });

// Akış, profil sekmeleri
postRoutes.get('/feed', validate({ query: feedQuery }), posts.feed);
postRoutes.get('/drafts', posts.drafts);
postRoutes.get('/saved', validate({ query: cursorQuery }), posts.saved);
postRoutes.get('/user/:userId', validate({ params: userPostsParams, query: cursorQuery }), posts.byUser);

// Oluştur / görüntüle / düzenle / sil (görsel önce POST /media/post ile yüklenir)
postRoutes.post('/', validate({ body: createPostBody }), posts.create);
postRoutes.get('/:postId', byId, posts.get);
postRoutes.patch('/:postId', validate({ params: postIdParams, body: updatePostBody }), posts.update);
postRoutes.delete('/:postId', byId, posts.remove);

// Etkileşimler
postRoutes.post('/:postId/like', byId, posts.like);
postRoutes.delete('/:postId/like', byId, posts.unlike);
postRoutes.post('/:postId/save', byId, posts.save);
postRoutes.delete('/:postId/save', byId, posts.unsave);
postRoutes.post('/:postId/view', byId, posts.view);
postRoutes.get('/:postId/stats', byId, posts.stats);
postRoutes.post('/:postId/boost', byId, posts.boost);
postRoutes.post('/:postId/report', validate({ params: postIdParams, body: reportPostBody }), posts.report);

// Yorumlar
postRoutes.get('/:postId/comments', validate({ params: postIdParams, query: cursorQuery }), posts.comments);
postRoutes.post('/:postId/comments', validate({ params: postIdParams, body: commentBody }), posts.addComment);
postRoutes.delete('/comments/:commentId', validate({ params: commentIdParams }), posts.deleteComment);
