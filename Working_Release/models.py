from flask_sqlalchemy import SQLAlchemy # ORM.
from sqlalchemy import CheckConstraint  # Used to ensure compass_direction stays within range.
from datetime import datetime   # Generate timestamps.
import enum # Enum module allows for the definition of enumerations in Python.
            # Needed to create distinct sets of values for columns.

db = SQLAlchemy()

#LandscapePositionEnum is an enum that allows only these options for the landscape_position field
class LandscapePositionEnum(enum.Enum):
    Flat_Undulating = 'Flat/Undulating'
    Ridge_or_Hill = 'Ridge or Hill'
    Slope = 'Slope'
    Valley_Gully = 'Valley/Gully'

# Location model reflecting the table structure
class Location(db.Model):
    __tablename__ = 'location'  # The explicit name of the table

    id = db.Column(db.Integer, primary_key=True)    # auto-incremented integer
    timestamp = db.Column(db.DateTime, nullable=False, default=datetime.now)    # Default to current time
    coordinates = db.Column(db.String(100), nullable=False) # Stores location coord as string
    photo = db.Column(db.String(100), nullable=False)   # Stores photo URL/path
    landscape_position = db.Column(db.String(100), nullable=False)  # enum values as strings
    altitude = db.Column(db.Integer, nullable=True) # Stores altitude
    compass_direction = db.Column(db.Float, nullable=True)  # Compass direction, float type

    # Constraint to ensure compass values are not negative nor greater than 360 deg
    __table_args__ = (
        CheckConstraint('compass_direction >= 0 AND compass_direction <= 360', name='compassdirection_check'),
    )
