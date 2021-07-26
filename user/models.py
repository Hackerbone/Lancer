from flask import Flask, jsonify, request, session
from flask.globals import session
from passlib.hash import pbkdf2_sha256
from app import db
import uuid


class User:
    def start_session(seld, user):
        del user['password']
        session['logged_in'] = True
        session['user'] = user
        return jsonify({"success": "Session started successfully", "data": user}), 200

    def signup(self):

        print(request.form['client'])
        print(True if request.form['client'] == 'true' else False)
        # User object
        user = {
            "_id": uuid.uuid4().hex,
            "name": request.form['name'],
            "email": request.form['email'],
            "phone": request.form['phone'],
            "password": request.form['password'],
            # "client": True if request.form['client'] else False,
        }
        # encrypt pass
        user['password'] = pbkdf2_sha256.hash(user['password'])

        # check for existing email
        if db.users.find_one({"email": user['email']}):
            return jsonify({"error": "Email already exists"}), 400

        if db.users.insert_one(user):
            return self.start_session(user)

        return jsonify({"error": "Signup Failed"}), 400

    def signout(self):
        session.clear()
        return jsonify({"success": "Session ended successfully"}), 200

    def login(self):
        user = db.users.find_one({"email": request.form['email']})

        if user and pbkdf2_sha256.verify(request.form['password'], user['password']):
            return self.start_session(user)
        else:
            return jsonify({"error": "Invalid Login Credentials"}), 401
