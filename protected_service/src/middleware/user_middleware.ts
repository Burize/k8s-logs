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
    const userToken = ctx.headers[userHeaderName.toLowerCase()] || ''
    ctx.user = paraseToken(userToken as string)

    await next()
}

export default userMiddleware;
