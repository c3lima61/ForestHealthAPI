# Forest Health API Prototype

This is a simple Flask-based API prototype for managing locational data related for the forest 
health app. It includes functionality to create, retrieve, update, delete, and export location 
data as a CSV file.

## Requirements

- Python 3.x
- PostgreSQL
- Required Python packages (listed in `requirements.txt`)

## Setup Instructions

### Step 1:
cd to Forest Health API Prototype folder

### Step 2: (Create a Virtual Environment)
python3 -m venv .venv

source .venv/bin/activate           (On Windows, use .venv\Scripts\activate)

### Step 3: (Install Dependencies)
pip install -r requirements.txt

### Step 4: (Set Up PostgreSQL Database)/
psql -U postgres                        (Ensure PostgreSQL is installed and running.)

CREATE DATABASE database_prototype;     (Create a PostgreSQL database)

psql -U postgres -d database_prototype -f /path/to/test.sql  (load the schema and data using test.sql)

### Step 5: (Configure Database Connection)
(Ensure the config.py file contains the correct PostgreSQL credentials)

SQLALCHEMY_DATABASE_URI = 'postgresql://<username>:<password>@localhost/database_prototype'

### Step 6: (Run the app)
python app.py


### Example POST REQUEST

curl -X POST http://127.0.0.1:50100/locations \
-H "Content-Type: application/json" \
-d '{
  "coordinates": "45.123,-75.123",
  "photo": "path/to/photo.jpg",
  "landscape_position": "Valley/Gully",
  "altitude": 300,
  "compass_direction": 180
}'

### EXAMPLE GET REQUEST

curl -X GET http://localhost:50100/locations/1

### EXAMPLE PATCH REQUEST

curl -X PATCH http://localhost:50100/locations/1 \
-H "Content-Type: application/json" \
-d '{
    "coordinates": "40.7306, -73.9352",
    "altitude": 15.7
}'

### EXAMPLE DELETE REQUEST

curl -X DELETE http://localhost:50100/locations/1

### EXAMPLE EXPORT CSV

curl -X GET http://127.0.0.1:50100/locations/export -o locations.csv
