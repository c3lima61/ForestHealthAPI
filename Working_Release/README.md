
# The Forest Health Project API Prototype

This prototype is a Flask-based API that allows for managing location data. It allows the ability to create, retrieve, update, delete, and export locations in CSV format. The prototype uses PostgreSQL as its database and SQLAlchemy as the ORM. Also included is a database prototype SQL dump file to use for testing the API functionality.

## Table of Contents
- [Getting Started](#getting-started)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Setting up PostgreSQL](#setting-up-postgresql)
- [Running the App](#running-the-app)
- [API Endpoints](#api-endpoints)
- [Database](#database)
- [Environment Variables](#environment-variables)

## Getting Started

This API prototype allows you to manage locations with fields such as coordinates, photos, landscape positions, altitudes, and compass directions. There are routes to create, retrieve, update, and delete locations, and export data in CSV format.

## Prerequisites

Before you begin, ensure you have the following installed on your local machine:
- Python 3.x
- PostgreSQL
- Flask
- SQLAlchemy

## Installation

1. Clone the repository // Download the file:
    ```bash
    git clone """"
    cd location/of/downloaded/file
    ```

2. Install the dependencies:
    ```bash
    pip install -r requirements.txt
    ```

## Setting up PostgreSQL

1. **Install PostgreSQL**:

    Use the instructions for your OS:

    - **Ubuntu / Debian**:
      ```bash
      sudo apt update
      sudo apt install postgresql postgresql-contrib
      ```

    - **MacOS** (using Homebrew):
      ```bash
      brew install postgresql
      ```

    - **Windows**:
      Download and install PostgreSQL from the [official website](https://www.postgresql.org/download/).

2. **Start the PostgreSQL Service**:
    - On **Linux** or **MacOS**, you can start PostgreSQL with:
      ```bash
      sudo service postgresql start
      ```
    - On **Windows**, PostgreSQL will automatically start straight after you have finished installing.

3. **Create a PostgreSQL Database**:
   Once you have started PostgreSQL, create a new user and database:
   - Access the PostgreSQL interactive terminal:
     ```bash
     sudo -u postgres psql
     ```
   - Create a new database user (please replace `username` and `password`):
     ```sql
     CREATE USER username WITH PASSWORD 'password';
     ```
   - Create a new database (please replace `database_prototype` with a name of your choice otherwise you can keep it as is):
     ```sql
     CREATE DATABASE database_prototype;
     ```
   - Grant the user access to the database:
     ```sql
     GRANT ALL PRIVILEGES ON DATABASE database_prototype TO username;
     ```
   - Exit PostgreSQL:
     ```bash
     \q
     ```

4. **Update the Connection String**:
   In `config.py`, ensure to update the `SQLALCHEMY_DATABASE_URI` with the correct username, password, and database name:
   ```python
   SQLALCHEMY_DATABASE_URI = 'postgresql://username:password@localhost/database_prototype'
   ```

5. **Run the SQL file to set up the database schema**:
   You can run the `prototype_database.sql` file to initialize your tables (replace the file path as needed):
   ```bash
   psql -U username -d database_prototype -f /path/to/the/prototype_database.sql
   ```

## Run the App

Once you have finished installing the dependencies and set up your PostgreSQL database, you can now run the application.

1. Start the Flask app:
    ```bash
    python app.py
    ```

2. The app will be available at `http://127.0.0.1:50100/`.

### API Endpoints

#### 1. Create a New Location

- **Description**: Adds a new location to the database.
- **Path**: http://127.0.0.1:50100/locations
- **Example Request Body**: 
    ```json
    {
        "coordinates": "string",
        "photo": "string",
        "landscape_position": "Flat/Undulating | Ridge or Hill | Slope | Valley/Gully",
        "altitude": "integer",
        "compass_direction": "float"
    }
    ```

#### 2. Read / Retrieve Location by ID

- **Description**: Retrieves/reads the details of a location by ID.
- **Path**: http://127.0.0.1:50100/locations/'location_id'
- **Request**: Can be done using a GET request.

#### 3. Update a Location by ID

- **Description**: Updates the specified fields of a location.
- **Path**: http://127.0.0.1:50100/locations/'location_id'
- **Request Body** (Fields are optional):
    ```json
    {
        "coordinates": "string",
        "photo": "string",
        "landscape_position": "Flat/Undulating | Ridge or Hill | Slope | Valley/Gully",
        "altitude": "integer",
        "compass_direction": "float"
    }
    ```

#### 4. Delete Location by ID

- **Description**: Deletes a location by its ID.
- **Path**: http://127.0.0.1:50100/locations/'location_id'
- **Request**: Can be done using a DELETE request.

#### 5. Export Locations to CSV

- **Description**: Exports all locations from the database to a CSV file.
- **Path**: http://127.0.0.1:50100/locations/export
- **Request**: Can be done using a GET request but remember to name your CSV file. Example curl command:
    ```bash
   curl -X GET http://127.0.0.1:50100/locations/export -o locations.csv
   ```

### Database

The database schema is defined in `models.py` using SQLAlchemy. The table being used is `location`, which stores the following fields:
- `id`: Primary key
- `timestamp`: Auto-generated timestamp
- `coordinates`: A string representing the coordinates of the location
- `photo`: A string representing a URL or path to the location's photo
- `landscape_position`: Enum representing the landscape position (Flat/Undulating, Ridge or Hill, Slope, Valley/Gully)
- `altitude`: Optional integer value
- `compass_direction`: Optional float, validated between 0 and 360 degrees

Flask will initialize the database when run / create the tables when run.

### Environment Variables

To store sensitive information like the `SECRET_KEY`, you can use a `.env` file or export the variables in your environment.

- `SECRET_KEY`: Used for securing the Flask session
- `SQLALCHEMY_DATABASE_URI`: The database connection string (defined in `config.py`)


