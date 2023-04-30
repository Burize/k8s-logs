from fastapi_sqlalchemy import db


from user.models import User


class UserRepository:
    def get_user_by_username(self, username: str):
        return db.session.query(User).filter(User.username.ilike(username)).one()

    def create_user(self, username: str, password: str):
        user = User(username=username, password=password)
        db.session.add(user)
        db.session.commit()
