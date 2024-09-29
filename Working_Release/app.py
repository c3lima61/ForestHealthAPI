from flask import Flask, request, jsonify, Response
from models import db, Location, LandscapePositionEnum  # Import models file and database object
from config import Config   # Import the config / settings
from io import StringIO # using to handle in-memory files (CSV creation)
import csv  # csv module
from sqlalchemy.exc import IntegrityError # handle database integrity errors

# Start-up the app
app = Flask(__name__)
app.config.from_object(Config)  # Load configuration from config.py
db.init_app(app)    # Initialise the database instance with Flask app

# Initialize the tables in the database / create if they don't exist already
with app.app_context():
    db.create_all()


# Route to add a new location
@app.route("/locations", methods=["POST"])
def create_location():
    data = request.get_json()   # Get the JSON data (incoming)

    try:
        # Validate the landscape_position manually to make sure it's a valid enum
        landscape_position = data.get("landscape_position")
        if landscape_position not in [e.value for e in LandscapePositionEnum]:
            raise ValueError(f"Invalid landscape position: {landscape_position}")

        # Create new Location object with the JSON data
        new_location = Location(
            coordinates=data.get("coordinates"),
            photo=data.get("photo"),
            landscape_position=landscape_position,
            altitude=data.get("altitude"),
            compass_direction=data.get("compass_direction")
        )

        # Add the new location to the current session then commit it to the database
        db.session.add(new_location)
        db.session.commit()
        # return a success message with the ID of the location that was just created
        return jsonify({"message": "Location created successfully", "location_id": new_location.id}), 201
    except ValueError as ve:    # Will return if an invalid landscape position was entered
        return jsonify({"error": f"Invalid landscape position: {ve}"}), 400
    except IntegrityError as ie:    # Will return in the case of DB integrity errors
        return jsonify({"error": f"Database integrity error: {ie}"}), 400
    except Exception as e:  # Return for exceptions
        return jsonify({"error": f"Error occurred: {e}"}), 500

# Route gets details of a location by its ID
@app.route("/locations/<int:id>", methods=["GET"])
def get_location(id):
    try:
        # Query the database to retrieve the location by ID
        location = Location.query.get_or_404(id)    # Return 404 error if not found

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

    except Exception as e:  # Returns for any exceptions that occur
        return jsonify({"error": f"Error occurred: {e}"}), 500

# Route updates a location's details by its ID
@app.route("/locations/<int:id>", methods=["PATCH"])
def patch_location(id):
    data = request.get_json()   # Get the JSON data (incoming)

    # Check if no data was provided in the request, return error if none provided
    if not data:
        return jsonify({"error": "No fields provided for update"}), 400

    try:
        # Find the location to update by its ID or return 404 error
        location = Location.query.get_or_404(id)

        # Update only the fields that are provided in the request data (can be all)
        if "coordinates" in data:
            location.coordinates = data["coordinates"]
        if "photo" in data:
            location.photo = data["photo"]
        if "landscape_position" in data:
            landscape_position = data["landscape_position"]
            if landscape_position not in [e.value for e in LandscapePositionEnum]:
                raise ValueError(f"Invalid landscape position: {landscape_position}")   # Error if not valid enum
            location.landscape_position = landscape_position
        if "altitude" in data:
            location.altitude = data["altitude"]
        if "compass_direction" in data:
            location.compass_direction = data["compass_direction"]

        # Updates are committed to the DB
        db.session.commit()

        # Success message with the location ID
        return jsonify({
            "message": "Location updated successfully",
            "location_id": location.id
        }), 200

    except ValueError as ve:    # Error if invalid data
        return jsonify({"error": f"Invalid data: {ve}"}), 400
    except Exception as e:      # Error for any other exceptions
        return jsonify({"error": f"Error occurred: {e}"}), 500

# Route deletes a location based on its ID
@app.route("/locations/<int:id>", methods=["DELETE"])
def delete_location(id):
    try:
        # Find the location by ID, or return a 404 error if it cannot be found
        location = Location.query.get_or_404(id)

        # Delete the location from the database and commit
        db.session.delete(location)
        db.session.commit()

        return jsonify({"message": "Location deleted successfully"}), 200 # Success message

    except Exception as e:  # Exception message for any that occur
        return jsonify({"error": f"Error occurred: {e}"}), 500

# Route will export all locations to a CSV file
@app.route("/locations/export", methods=["GET"])
def export_locations_csv():
    try:
        # Gets all locations from the database
        locations = Location.query.all()

        # Create an in-memory CSV file
        output = StringIO()
        writer = csv.writer(output)

        # Writes the header (row)
        writer.writerow(['ID', 'Coordinates', 'Photo', 'Landscape Position', 'Altitude', 'Compass Direction', 'Timestamp'])

        # Writes the location's data as a row in the CSV file (corresponding to the table)
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

        # Move back to the start of the file
        output.seek(0)

        # Return the CSV file as an HTTP response
        return Response(output, mimetype="text/csv", headers={"Content-Disposition": "attachment;filename=locations.csv"})

    except Exception as e:  # Exception that occur
        return jsonify({"error": f"Error occurred while exporting CSV: {e}"}), 500

# Setting local host to 50100, ensure debug mode is turned False if testing is finished
if __name__ == '__main__':
    app.run(port=50100, debug=True)
