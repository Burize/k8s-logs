from dataclasses import dataclass
from uuid import UUID

from fastapi import APIRouter
from fastapi import Depends

from user.services import AuthService
from user.services.auth_service import AuthenticateException
from core.exceptions import exception_to_response

router = APIRouter()


@dataclass
class UserAuthenticateDTO:
    username: str
    password: str


@dataclass
class UserDTO:
    id: UUID


@router.post('')
@exception_to_response(AuthenticateException, http_code=401)
def authenticate(dto: UserAuthenticateDTO, auth_service: AuthService = Depends()) -> UserDTO:
    user = auth_service.authenticate(username=dto.username, password=dto.password)

    return UserDTO(id=user.id)

