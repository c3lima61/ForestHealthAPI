import os

class Config:
    # 'user':'password'
    SQLALCHEMY_DATABASE_URI = 'postgresql://postgres:basicpassword@localhost/database_prototype'
    SQLALCHEMY_TRACK_MODIFICATIONS = False  # Not using because I am lazy and want to make life harder
    # Placeholder for future use
    SECRET_KEY = os.environ.get('SECRET_KEY') or 'your_secret_key'
