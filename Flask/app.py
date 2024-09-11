from flask import Flask, request, jsonify, Response
from datetime import datetime
import csv
from io import StringIO
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)   # Create the Flask API application instance

app.config["SQLALCHEMY_DATABASE_URI"] = 'sqlite:///test.db' # Telling the app where the database is located
db = SQLAlchemy(app)  # Initialize the SQLAlchemy extension for database interaction
app.app_context().push() # Gives context for database access

# The model for storing tasks in the database
class Todo(db.Model):
    id = db.Column(db.Integer, primary_key=True)    # Gives each task a unique id number and sets id column as the primary key
    content = db.Column(db.String(200), nullable=False) # The content can have a max length of 200 characters and cannot be left empty
    completed = db.Column(db.Integer, default=0)    # Status of task = 0 for incomplete, 1 for complete
    date_created = db.Column(db.DateTime, default=datetime.now) # Provides timestamp when the task was created

    def __repr__(self):
        return '<Task %r>' % self.id    # Mainly for debugging purposes using the string representation

# This function defines the main route for task creation and task retrieval
@app.route("/", methods=['POST', 'GET'])
def task_manager():
    if request.method == 'POST':
        task_content = request.json['content']  # Get data (task content) from the frontend (must be JSON input)
        new_task = Todo(content=task_content)   # Create the new task (object)

        try:
            db.session.add(new_task)    # New task is added to the database session
            db.session.commit() # Commit the session to ensure changes are saved
            return jsonify({'message': 'Successfully added task.'}), 201    # Success message and status
        except Exception as e:
            return jsonify({'error': f'There was an issue adding the task: {e}'}), 500  # Error message and status
    else:
        tasks = Todo.query.order_by(Todo.date_created).all()    # Retrieves all tasks by creation date, will be ordered by creation date.
        tasks_list = [{"id": task.id, "content": task.content, "completed": task.completed, "date_created": task.date_created} for task in tasks]
        return jsonify(tasks_list), 200 # Return the list of dictionaries of which each dictionary represents a task from the database

# This function defines the route for task deletion by task id
@app.route('/delete/<int:id>', methods=['DELETE'])
def delete(id):
    task_to_delete = Todo.query.filter_by(id=id).first()    # Look for task by id and if not found return none

    if not task_to_delete:
        return jsonify({'error': 'Task not found.'}), 404   # Return error

    try:
        db.session.delete(task_to_delete)   # Delete task from database session
        db.session.commit() # Commit the session to ensure changes are saved
        return jsonify({'message': 'Successfully deleted task.'}), 200  # Success message
    except Exception as e:
        return jsonify({'error': f'Problem occurred when deleting task: {e}'}), 500 # Error message

# This function defines the route for task updates by task id
@app.route('/update/<int:id>', methods=['PUT'])
def update(id):
    task_to_update = Todo.query.filter_by(id=id).first()  # Look for task by id and if not found return none

    if not task_to_update:
        return jsonify({'error': 'Task not found.'}), 404   # Return error

    task_to_update.content = request.json['content']  # Update the task content with the new data

    try:
        db.session.commit() # Commit the session to ensure changes are saved
        return jsonify({'message': 'Successfully updated task.'}), 200  # Success message
    except:
        return jsonify({'error': 'There was an issue updating your observation'}), 500  # Error message

# This function defines the route for exporting tasks as a CSV file
@app.route('/export', methods=['GET'])
def export():
    try:
        # Fetching tasks from the database (ordered by creation date)
        tasks_to_export = Todo.query.order_by(Todo.date_created).all()

        if not tasks_to_export:
            return jsonify({'error': 'No tasks available to export'}), 404  # Return error

        # In-memory CSV file creation ---FOR TESTING ONLY---TEMP DATA---NO ACTUAL FILE---
        output = StringIO()
        writer = csv.writer(output) # CSV writer object
        writer.writerow(['ID', 'Content', 'Completed', 'Date Created']) # Write CSV header

        # Write each task's data as a row in the CSV file
        for task in tasks_to_export:
            writer.writerow([task.id, task.content, task.completed, task.date_created])

        output.seek(0) # Move back to the beginning of the file to return it as a response

        # Return the CSV as a downloadable file with the correct headers
        return Response(output, mimetype="text/csv", headers={"Content-Disposition": "attachment;filename=tasks.csv"})

    except Exception as e:
        return jsonify({'error': f'An error occurred while exporting the CSV: {e}'}), 500   # Error message

# Setting local host to 50100, ensure debug mode is turned False when testing is finished
if __name__ == '__main__':
    app.run(port=50100, debug=True)
