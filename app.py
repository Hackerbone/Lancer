from flask import Flask, session
from functools import wraps
import pymongo

app = Flask(__name__)
app.secret_key = b'\x18z\xac^\xaf\xde*kX2\xb3V\x1e\xddV\xf4'

client = pymongo.MongoClient('127.0.0.1', 27017)

db = client.user_login_system

# Decorators


def login_required(f):
    @wraps(f)
    def wrap(*arg, **kwargs):
        if 'logged_in' in session:
            return f(*arg, **kwargs)
        else:
            return 'You need to login first.'

    return wrap


# Routes
from user import routes  # nopep8


@app.route('/')
def home():
    return "LOdfL"


@app.route('/dashboard')
@login_required
def dashboard():
    return "DASH"


# if __name__ == '__main__':
#     app.run(host="0.0.0.0")
