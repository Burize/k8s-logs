import os

API_PREFIX = '/api'
DATABASE_URL = os.getenv('DATABASE_URL')
SERVICE_EXCHANGE_HEADER_NAME = os.getenv('SERVICE_EXCHANGE_HEADER_NAME', '')
SERVICE_EXCHANGE_KEY = os.getenv('SERVICE_EXCHANGE_KEY', '')
