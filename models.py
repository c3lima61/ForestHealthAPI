from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class ForestData(db.Model):
    __tablename__ = 'forest_data'

    id = db.Column(db.Integer, primary_key=True)
    species = db.Column(db.String(80), nullable=False)
    health_status = db.Column(db.String(120), nullable=False)
    location = db.Column(db.String(120), nullable=False)
    timestamp = db.Column(db.DateTime, nullable=False)

    def __init__(self, species, health_status, location, timestamp):
        self.species = species
        self.health_status = health_status
        self.location = location
        self.timestamp = timestamp
