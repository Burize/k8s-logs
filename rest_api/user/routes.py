from fastapi import APIRouter
from user.controllers import auth_router
from user.controllers import user_router

api_router = APIRouter(prefix='')
api_router.include_router(auth_router, prefix='/authenticate')
api_router.include_router(user_router, prefix='/user')
