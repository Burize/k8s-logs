import {Context} from "koa";


async function authMiddleware(ctx: Context, next: Awaited<Function>) {
    const gatewayKey = process.env.GATEWAY_KEY || ''
    const gatewayKeyHeaderName = process.env.GATEWAY_KEY_HEADER_NAME || ''
    const gatewayKeyHeader = ctx.request.headers[gatewayKeyHeaderName.toLowerCase()]

    if (!gatewayKeyHeader || gatewayKey !== gatewayKeyHeader) {
        ctx.throw(401);
    }

    await next()
}

export default authMiddleware;
