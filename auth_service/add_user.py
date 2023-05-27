import argparse
import sys

from core import settings
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from user.models import User


class Parser(argparse.ArgumentParser):
    def error(self, message):
        sys.stderr.write('error: %s\n' % message)
        self.print_help()
        sys.exit(2)



def parse_args(parser_object):
    parser_object.add_argument(
        '-u',
        '--username',
        type=str,
        dest='username',
        help='Username',
        required=True,
    )
    parser_object.add_argument(
        '-p',
        '--password',
        type=str,
        dest='password',
        help='Password',
        required=True,
    )
    parser_object.add_argument(
        '-e',
        '--email',
        type=str,
        dest='email',
        help='Email',
        required=True,
    )
    return parser_object.parse_args()


if __name__ == '__main__':
    parser = Parser(description='Create a new user')
    args = parse_args(parser)

    engine = create_engine(settings.DATABASE_URL)
    Session = sessionmaker(autocommit=False, autoflush=False, bind=engine)
    session = Session()

    user = User(username=args.username, password=args.password, email=args.email)
    session.add(user)
    session.commit()
