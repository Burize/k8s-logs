from uuid import uuid4

from passlib.context import CryptContext
from sqlalchemy.dialects import postgresql

from core.database.base import Base
import sqlalchemy as sa

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")


class User(Base):
    __tablename__ = 'auth_user'
    id = sa.Column(postgresql.UUID(as_uuid=True), primary_key=True)
    username = sa.Column(sa.String, nullable=False, unique=True)
    password = sa.Column(sa.String, nullable=False)
    email = sa.Column(sa.String, nullable=False)

    def __init__(self, username: str, password: str, email: str):
        self.id = uuid4()
        self.username = username
        self.password = pwd_context.encrypt(password)
        self.email = email
