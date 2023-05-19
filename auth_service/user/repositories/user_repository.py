from typing import Optional

from fastapi_sqlalchemy import db

from core.exceptions import NotFoundException
from user.models import User


class UserRepository:
    def get_user_by_username(self, username: str) -> Optional[User]:
        user = db.session.query(User).filter(User.username.ilike(username)).one_or_none()
        if not user:
            raise NotFoundException('Could not find a user')
        return user

    def create_user(self, username: str, password: str, email: str):
        user = User(username=username, password=password, email=email)
        db.session.add(user)
        db.session.commit()
