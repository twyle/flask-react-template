import os


class BaseConfig():
    SECRET_KEY = os.environ['SECRET_KEY']
    DEBUG = False
    TESTING = False
    BASE_DIR = os.path.abspath(os.path.dirname(__file__))


class DevelopmentConfig(BaseConfig):
    DEBUG = True
    TESTING = True


class ProductionConfig(BaseConfig):
    DEBUG = False
    TESTING = False
