from dataclasses import dataclass

from fastapi import APIRouter
from fastapi import Depends
from starlette.responses import Response
from starlette.status import HTTP_200_OK

from user.repositories.user_repository import UserRepository

router = APIRouter()


@dataclass
class CreateuserDTO:
    username: str
    password: str


@router.post('')
def create_user(dto: CreateuserDTO, user_repository: UserRepository = Depends()):
    user_repository.create_user(username=dto.username, password=dto.password)
    return Response(status_code=HTTP_200_OK)
