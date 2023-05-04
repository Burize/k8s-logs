import Koa from 'koa'
import logger from 'koa-logger'
import {router} from './controllers';
import authMiddleware from "./middleware/auth_middleware";
import userMiddleware from "./middleware/user_middleware";


const app = new Koa()


app.use(logger())
app.use(authMiddleware)
app.use(userMiddleware)

app.use(router.routes())

export default app
