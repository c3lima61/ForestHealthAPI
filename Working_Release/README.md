
# Location Management API

This project is a Flask-based API that allows for managing location data. It includes functionality to create, retrieve, update, delete, and export locations in CSV format. The project uses PostgreSQL as its database and SQLAlchemy as the ORM.

## Table of Contents
- [Getting Started](#getting-started)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Setting up PostgreSQL](#setting-up-postgresql)
- [Running the App](#running-the-app)
- [API Endpoints](#api-endpoints)
- [Database](#database)
- [Environment Variables](#environment-variables)
- [License](#license)

## Getting Started

This API allows you to manage locations with fields such as coordinates, photos, landscape positions, altitudes, and compass directions. It includes routes to create, update, and delete locations, and export data in CSV format.

## Prerequisites

Before you begin, ensure you have the following installed on your local machine:
- Python 3.8+
- PostgreSQL
- Flask
- SQLAlchemy

## Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/your-username/location-management-api.git
    cd location-management-api
    ```

2. Install the required dependencies:
    ```bash
    pip install -r requirements.txt
    ```

## Setting up PostgreSQL

1. **Install PostgreSQL**:

    Follow the instructions for your operating system:

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
    - On **Windows**, PostgreSQL will automatically start after installation.

3. **Create a PostgreSQL Database**:
   After starting PostgreSQL, create a new user and database:
   - Access the PostgreSQL interactive terminal:
     ```bash
     sudo -u postgres psql
     ```
   - Create a new database user (replace `yourusername` and `yourpassword`):
     ```sql
     CREATE USER yourusername WITH PASSWORD 'yourpassword';
     ```
   - Create a new database (replace `database_prototype` with your desired database name):
     ```sql
     CREATE DATABASE database_prototype;
     ```
   - Grant the user access to the database:
     ```sql
     GRANT ALL PRIVILEGES ON DATABASE database_prototype TO yourusername;
     ```
   - Exit PostgreSQL:
     ```bash
     \q
     ```

4. **Update the Connection String**:
   In `config.py`, update the `SQLALCHEMY_DATABASE_URI` with the correct username, password, and database name:
   ```python
   SQLALCHEMY_DATABASE_URI = 'postgresql://yourusername:yourpassword@localhost/database_prototype'
   ```

5. **Run the SQL file to set up the database schema**:
   You can run the `prototype_database.sql` file to initialize your tables (replace the file path as needed):
   ```bash
   psql -U yourusername -d database_prototype -f /path/to/prototype_database.sql
   ```

## Running the App

Once you've installed the dependencies and set up your PostgreSQL database, you can run the application.

1. Start the Flask app:
    ```bash
    python app.py
    ```

2. The app will be available at `http://127.0.0.1:50100/`.

### API Endpoints

#### 1. Create a New Location
- **URL**: `/locations`
- **Method**: `POST`
- **Description**: Adds a new location to the database.
- **Request Body**:
    ```json
    {
        "coordinates": "string",
        "photo": "string",
        "landscape_position": "Flat/Undulating | Ridge or Hill | Slope | Valley/Gully",
        "altitude": "integer",
        "compass_direction": "float"
    }
    ```
- **Response**:
    - Success: `201 Created`
    - Error: `400 Bad Request`

#### 2. Retrieve Location by ID
- **URL**: `/locations/<int:id>`
- **Method**: `GET`
- **Description**: Retrieves the details of a location by its ID.
- **Response**:
    - Success: `200 OK`
    - Error: `404 Not Found`

#### 3. Update a Location by ID
- **URL**: `/locations/<int:id>`
- **Method**: `PATCH`
- **Description**: Updates the specified fields of a location.
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
- **Response**:
    - Success: `200 OK`
    - Error: `400 Bad Request`

#### 4. Delete Location by ID
- **URL**: `/locations/<int:id>`
- **Method**: `DELETE`
- **Description**: Deletes a location by its ID.
- **Response**:
    - Success: `200 OK`
    - Error: `404 Not Found`

#### 5. Export Locations to CSV
- **URL**: `/locations/export`
- **Method**: `GET`
- **Description**: Exports all locations from the database to a CSV file.
- **Response**: The response will be a downloadable CSV file.

### Database

The database schema is defined in `models.py` using SQLAlchemy. The main table used is `location`, which stores the following fields:
- `id`: Primary key
- `timestamp`: Auto-generated timestamp
- `coordinates`: A string representing the coordinates of the location
- `photo`: A string representing a URL or path to the location's photo
- `landscape_position`: Enum representing the landscape position (Flat/Undulating, Ridge or Hill, Slope, Valley/Gully)
- `altitude`: Optional integer value
- `compass_direction`: Optional float, validated between 0 and 360 degrees

To initialize the database, Flask automatically creates the table structures when the app is run.

### Environment Variables

To store sensitive information like the `SECRET_KEY`, you can use a `.env` file or export the variables in your environment.

- `SECRET_KEY`: Used for securing the Flask session
- `SQLALCHEMY_DATABASE_URI`: The database connection string (defined in `config.py`)

### License

This project is licensed under the MIT License.

---

This update adds PostgreSQL installation instructions and more detailed steps for setting up the database. Let me know if you'd like any further adjustments!