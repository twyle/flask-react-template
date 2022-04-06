import os

from flask import Flask
from flask_cors import CORS

from api.config import DevelopmentConfig, ProductionConfig

app = Flask(__name__, static_folder='static', static_url_path='/')
CORS(app)

if os.environ['FLASK_ENV'] == 'production':
    app.config.from_object(ProductionConfig)
elif os.environ['FLASK_ENV'] == 'development':
    app.config.from_object(DevelopmentConfig)

from api import config, models, routes
