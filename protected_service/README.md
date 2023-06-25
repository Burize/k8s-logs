# Protected microservice
This is microservice written in TypeScript using [KoaJS](https://koajs.com/) as a framework. 
This service provides only one endpoint: GET `/api/user`.
It returns email of user from given JWT token.

This service represents some REST API, that should be protected and available only to authenticated users.

There are two env variables `SERVICE_EXHANGE_HEADER_NAME` and  `SERVICE_EXHANGE_KEY`. 
You should put a value from `SERVICE_EXHANGE_KEY` to a http header with name `SERVICE_EXHANGE_HEADER_NAME` on each request that you make to pass authentication.

Also, a http request should have a header with name equal to the `USER_HEADER_NAME` env variable. This header should contain JWT token in format `Bearer {jwt_token}`.
It's expected that the token has id and email fields. See [UserMiddleware](src/middleware/user_middleware.ts) for more details.

### Run service
Run `docker compose up` to build and run a server container.

The service is available on `127.0.0.1:3000`.