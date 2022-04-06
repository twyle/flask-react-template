import os
from datetime import datetime

from api import app


@app.route('/api')
@app.route('/')
def api_home():
    return f"Hello from flask api! The environment is {os.environ['FLASK_ENV']}"


@app.route('/api/time', methods=['GET'])
def get_time():
    return {'time': datetime.utcnow().strftime("%m/%d/%Y, %H:%M:%S")}
