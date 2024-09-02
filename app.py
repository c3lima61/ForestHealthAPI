
from flask import Flask, request, jsonify
from flask_restful import Api, Resource
import psycopg2

app = Flask(__name__)
api = Api(app)

#General placeholder for DB connection
def get_db_connection():
    conn = psycopg2.connect(
        host="localhost",
        database="forest_health",
        user="your_username",
        password="your_password"
    )
    return conn

#Just using an example endpoint here
#Adding survey data
class addSurveyData(Resource):
    def post(self):
        data = request.get_json()
        # connect to the database
        conn = get_db_connection()
        cur = conn.cursor()

        #The actual logic for putting the survey data into the DB
        try:
            cur.execute(
                """
                INSERT INTO surveys (date, time, location, vegetation_type, burn_severity, recovery_stage)
                VALUES (%s, %s, %s, %s, %s, %s)
                """,
                (
                    data['date'],
                    data['time'],
                    data['location'],
                    data['vegetation_type'],
                    data['burn_severity'],
                    data['recovery_stage']
                )
            )
            conn.commit()
            cur.close()
            conn.close()
            return jsonify({"message": "Survey data added successfully"}), 201
        except Exception as e:
            conn.rollback()
            cur.close()
            conn.close()
            return jsonify({"error": str(e)}), 500

api.add_resource(addSurveyData, '/addSurveyData')

if __name__ == '__main__':
    app.run(debug=True)


