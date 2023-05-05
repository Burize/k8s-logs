"""add_email_column

Revision ID: c3b1b46d653e
Revises: b50788820c55
Create Date: 2023-05-05 14:01:31.489003

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = 'c3b1b46d653e'
down_revision = 'b50788820c55'
branch_labels = None
depends_on = None


def upgrade() -> None:
    op.add_column('auth_user', sa.Column('email', sa.String(), nullable=False))


def downgrade() -> None:
    op.drop_column('auth_user', 'email')
