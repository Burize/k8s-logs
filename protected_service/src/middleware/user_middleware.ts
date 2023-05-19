import {Context} from "koa";


interface IUser {
    id: string
    email: string
}



function paraseToken(jwt_token: string): IUser {
    // We don't need to verify a token, because it's already verified by the Gateway, so just get its payload
    const user = JSON.parse(
        Buffer.from(jwt_token.split(".")[1], "base64").toString()
      );
    return {id: user.id, email: user.email}
}


async function userMiddleware(ctx: Context, next: Awaited<Function>) {
    const userHeaderName = process.env.USER_HEADER_NAME || ''
    const userHeader = (ctx.headers[userHeaderName.toLowerCase()] || '') as string
    const userToken = userHeader.match(/Bearer (.*)/)

    if (!userToken || !userToken[1]) {
        ctx.throw(401, 'Invalid user token');
    }
    ctx.user = paraseToken(userToken[1])

    await next()
}

export default userMiddleware;
