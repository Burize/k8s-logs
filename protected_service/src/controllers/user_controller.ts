import Router from '@koa/router';
import { Context } from 'koa';

const getUserInfo = (ctx: Context) => {
  ctx.body = `Hello, ${ctx.user.email}`
}


function registerRoutes(router: Router) {
  router.get('/user', getUserInfo);
}

export { registerRoutes };