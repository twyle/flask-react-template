import os

from api import app


@app.route('/api')
@app.route('/')
def api_home():
    return f"Hello from flask api! The environment is {os.environ['FLASK_ENV']}"
