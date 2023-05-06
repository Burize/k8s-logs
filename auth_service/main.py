from fastapi import APIRouter
from fastapi import FastAPI
from fastapi_sqlalchemy import DBSessionMiddleware
from starlette.middleware.base import BaseHTTPMiddleware

from core.middlewares import auth_middleware

from user.routes import api_router as user_router
import core.settings as settings

app = FastAPI(
    title='AuthService', docs_url=f"{settings.API_PREFIX}/docs"
)

app.add_middleware(DBSessionMiddleware, db_url=settings.DATABASE_URL)
app.add_middleware(BaseHTTPMiddleware, dispatch=auth_middleware)
root_router = APIRouter()
root_router.include_router(user_router)


app.include_router(root_router, prefix=settings.API_PREFIX)
