from flask import Flask, request, jsonify, Response
from models import db, Location, LandscapePositionEnum  # Import models file
from config import Config   # Import the config
from io import StringIO
import csv
from sqlalchemy.exc import IntegrityError

# Start-up the app
app = Flask(__name__)
app.config.from_object(Config)  # Load configuration from config file
db.init_app(app)

# Initialize the tables in the database
with app.app_context():
    db.create_all()


# Route to add a new location
@app.route("/locations", methods=["POST"])
def create_location():
    data = request.get_json()

    try:
        # Validate the landscape_position manually
        landscape_position = data.get("landscape_position")
        if landscape_position not in [e.value for e in LandscapePositionEnum]:
            raise ValueError(f"Invalid landscape position: {landscape_position}")

        # Create new Location object
        new_location = Location(
            coordinates=data.get("coordinates"),
            photo=data.get("photo"),
            landscape_position=landscape_position,
            altitude=data.get("altitude"),
            compass_direction=data.get("compass_direction")
        )

        db.session.add(new_location)
        db.session.commit()
        return jsonify({"message": "Location created successfully", "location_id": new_location.id}), 201
    except ValueError as ve:
        return jsonify({"error": f"Invalid landscape position: {ve}"}), 400
    except IntegrityError as ie:
        return jsonify({"error": f"Database integrity error: {ie}"}), 400
    except Exception as e:
        return jsonify({"error": f"Error occurred: {e}"}), 500

@app.route("/locations/<int:id>", methods=["GET"])
def get_location(id):
    try:
        # Query the database to retrieve the location by ID
        location = Location.query.get_or_404(id)

        # Return the location details as a JSON response
        return jsonify({
            "id": location.id,
            "coordinates": location.coordinates,
            "photo": location.photo,
            "landscape_position": location.landscape_position,
            "altitude": location.altitude,
            "compass_direction": location.compass_direction,
            "timestamp": location.timestamp
        }), 200

    except Exception as e:
        return jsonify({"error": f"Error occurred: {e}"}), 500


@app.route("/locations/<int:id>", methods=["PATCH"])
def patch_location(id):
    data = request.get_json()

    # Check if no data was provided in the request
    if not data:
        return jsonify({"error": "No fields provided for update"}), 400

    try:
        # Fetch the location to update by its ID
        location = Location.query.get_or_404(id)

        # Update only the fields that are provided in the request data
        if "coordinates" in data:
            location.coordinates = data["coordinates"]
        if "photo" in data:
            location.photo = data["photo"]
        if "landscape_position" in data:
            landscape_position = data["landscape_position"]
            if landscape_position not in [e.value for e in LandscapePositionEnum]:
                raise ValueError(f"Invalid landscape position: {landscape_position}")
            location.landscape_position = landscape_position
        if "altitude" in data:
            location.altitude = data["altitude"]
        if "compass_direction" in data:
            location.compass_direction = data["compass_direction"]

        # Commit the updates to the database
        db.session.commit()

        return jsonify({
            "message": "Location updated successfully",
            "location_id": location.id
        }), 200

    except ValueError as ve:
        return jsonify({"error": f"Invalid data: {ve}"}), 400
    except Exception as e:
        return jsonify({"error": f"Error occurred: {e}"}), 500

@app.route("/locations/<int:id>", methods=["DELETE"])
def delete_location(id):
    try:
        # Fetch the location by ID, or return a 404 error if not found
        location = Location.query.get_or_404(id)

        # Delete the location from the database
        db.session.delete(location)
        db.session.commit()

        return jsonify({"message": "Location deleted successfully"}), 200

    except Exception as e:
        return jsonify({"error": f"Error occurred: {e}"}), 500

@app.route("/locations/export", methods=["GET"])
def export_locations_csv():
    try:
        # Fetch all locations from the database
        locations = Location.query.all()

        # Create an in-memory CSV file
        output = StringIO()
        writer = csv.writer(output)

        # Write the header row
        writer.writerow(['ID', 'Coordinates', 'Photo', 'Landscape Position', 'Altitude', 'Compass Direction', 'Timestamp'])

        # Write the data rows
        for location in locations:
            writer.writerow([
                location.id,
                location.coordinates,
                location.photo,
                location.landscape_position,
                location.altitude,
                location.compass_direction,
                location.timestamp
            ])

        # Move the cursor back to the start of the file
        output.seek(0)

        # Return the CSV file as a response
        return Response(output, mimetype="text/csv", headers={"Content-Disposition": "attachment;filename=locations.csv"})

    except Exception as e:
        return jsonify({"error": f"Error occurred while exporting CSV: {e}"}), 500

# Setting local host to 50100, ensure debug mode is turned False when testing is finished
if __name__ == '__main__':
    app.run(port=50100, debug=True)
