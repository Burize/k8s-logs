"""init

Revision ID: b50788820c55
Revises: 
Create Date: 2023-04-30 17:08:54.522425

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = 'b50788820c55'
down_revision = None
branch_labels = None
depends_on = None


def upgrade() -> None:
    op.create_table('auth_user',
    sa.Column('id', sa.UUID(), nullable=False),
    sa.Column('username', sa.String(), nullable=False),
    sa.Column('password', sa.String(), nullable=False),
    sa.PrimaryKeyConstraint('id', name=op.f('pk_auth_user')),
    sa.UniqueConstraint('username', name=op.f('uq_auth_user_username'))
    )


def downgrade() -> None:
    op.drop_table('auth_user')
