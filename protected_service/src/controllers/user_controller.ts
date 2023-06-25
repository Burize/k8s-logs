import Router from '@koa/router';
import { Context } from 'koa';

const getUserInfo = (ctx: Context) => {
  ctx.body = `Hello, ${ctx.user.email}`
}


function registerRoutes(router: Router) {
  router.get('/api/user', getUserInfo);
}

export { registerRoutes };