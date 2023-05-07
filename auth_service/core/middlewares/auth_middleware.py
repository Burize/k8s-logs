from fastapi import Request
from starlette.responses import Response
from starlette.status import HTTP_401_UNAUTHORIZED

import core.settings as settings


async def auth_middleware(request: Request, call_next):
    authorization_header = request.headers.get(settings.SERVICE_EXCHANGE_HEADER_NAME, None)
    invalid_authorization_header = not authorization_header or authorization_header != f'Bearer {settings.SERVICE_EXCHANGE_KEY}'
    if request.url.path != '/api/authenticate' and invalid_authorization_header:
        return Response(status_code=HTTP_401_UNAUTHORIZED, content='UNAUTHORIZED')

    response = await call_next(request)
    return response
