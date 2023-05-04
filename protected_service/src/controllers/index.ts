import Router from '@koa/router';
import { registerRoutes as registerUsersRoutes } from './user_controller';

const router = new Router();

registerAllRoutes(router);

function registerAllRoutes(router: Router) {
  registerUsersRoutes(router);
}

export { router };