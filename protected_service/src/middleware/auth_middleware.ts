import {Context} from "koa";


async function authMiddleware(ctx: Context, next: Awaited<Function>) {
    const serviceExchangeKey = process.env.SERVICE_EXCHANGE_KEY || ''
    const authorizationHeaderName = process.env.SERVICE_EXCHANGE_HEADER_NAME || ''
    const authorizationHeader = ctx.request.headers[authorizationHeaderName.toLowerCase()]

    if (!authorizationHeader || authorizationHeader !== `Bearer ${serviceExchangeKey}`) {
        ctx.throw(401);
    }

    await next()
}

export default authMiddleware;
