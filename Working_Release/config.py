import os

class Config:
    # 'user':'password'
    SQLALCHEMY_DATABASE_URI = 'postgresql://postgres:basicpassword@localhost/database_prototype'
    SQLALCHEMY_TRACK_MODIFICATIONS = False  # False as is not currently needed
    # Placeholder for future use
    SECRET_KEY = os.environ.get('SECRET_KEY') or 'your_secret_key'
