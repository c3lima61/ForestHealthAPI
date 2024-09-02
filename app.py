from flask import Flask, jsonify, request, abort
from flask_sqlalchemy import SQLAlchemy
from flask_httpauth import HTTPTokenAuth
from flask_caching import Cache
from models import db, ForestData
from config import Config
import datetime
from argon2 import PasswordHasher
from sqlalchemy.exc import IntegrityError

# Initialize Flask app
app = Flask(__name__)
app.config.from_object(Config)

# Initialize extensions
db.init_app(app)
auth = HTTPTokenAuth(scheme='Bearer')
cache = Cache(app)
ph = PasswordHasher()

# Dummy user token for demonstration
TOKENS = {
    "your_token_here": "authorized_user"
}


# Authentication handler
@auth.verify_token
def verify_token(token):
    if token in TOKENS:
        return TOKENS[token]
    return None


# Example endpoint 1: Data synchronization (POST)
@app.route('/sync', methods=['POST'])
@auth.login_required
def sync_data():
    data = request.get_json()

    if not data:
        return jsonify({"error": "Invalid data"}), 400

    try:
        for entry in data:
            new_data = ForestData(
                species=entry['species'],
                health_status=entry['health_status'],
                location=entry['location'],
                timestamp=datetime.datetime.strptime(entry['timestamp'], '%Y-%m-%dT%H:%M:%S')
            )
            db.session.add(new_data)

        db.session.commit()
        return jsonify({"message": "Data synchronized successfully"}), 200

    except IntegrityError:
        db.session.rollback()
        return jsonify({"error": "Database integrity error occurred"}), 500

    except Exception as e:
        return jsonify({"error": str(e)}), 500


# Example endpoint 2: Retrieve forest data (GET)
@app.route('/forest_data', methods=['GET'])
@auth.login_required
@cache.cached(timeout=50)
def get_forest_data():
    try:
        forest_data = ForestData.query.all()
        data = [{
            "id": entry.id,
            "species": entry.species,
            "health_status": entry.health_status,
            "location": entry.location,
            "timestamp": entry.timestamp.isoformat()
        } for entry in forest_data]

        return jsonify(data), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500


if __name__ == '__main__':
    app.run(debug=True)
