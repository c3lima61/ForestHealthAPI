from flask import Flask, request, jsonify, Response
from datetime import datetime
import csv
from io import StringIO
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)   # Create the Flask API application instance

app.config["SQLALCHEMY_DATABASE_URI"] = 'sqlite:///test.db' # Telling the app where the database is located
db = SQLAlchemy(app)  # Initialize the SQLAlchemy extension for database interaction
app.app_context().push() # Gives context for database access

""" The Todo model for storing tasks in the database """
class Todo(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    content = db.Column(db.String(200), nullable=False)
    completed = db.Column(db.Integer, default=0)
    date_created = db.Column(db.DateTime, default=datetime.utcnow)

    def __repr__(self):
        return '<Task %r>' % self.id

# Route from server
@app.route("/", methods=['POST', 'GET'])
def index():
    if request.method == 'POST':
        task_content = request.json['content']  # Get data from the mock mobile app in JSON format
        new_task = Todo(content=task_content)

        try:
            db.session.add(new_task)
            db.session.commit()
            return jsonify({'message': 'Successfully added task.'}), 201
        except Exception as e:
            return jsonify({'error': f'There was an issue adding the task: {e}'}), 500
    else:
        tasks = Todo.query.order_by(Todo.date_created).all()
        tasks_list = [{"id": task.id, "content": task.content, "completed": task.completed, "date_created": task.date_created} for task in tasks]
        return jsonify(tasks_list), 200

@app.route('/delete/<int:id>', methods=['DELETE'])
def delete(id):
    task_to_delete = Todo.query.get_or_404(id)

    try:
        db.session.delete(task_to_delete)
        db.session.commit()
        return jsonify({'message': 'Successfully deleted task.'}), 200
    except Exception as e:
        return jsonify({'error': f'Problem occurred when deleting task: {e}'}), 500

@app.route('/update/<int:id>', methods=['PUT'])
def update(id):
    task = Todo.query.get_or_404(id)
    task.content = request.json['content']  # Get updated content in JSON format

    try:
        db.session.commit()
        return jsonify({'message': 'Successfully updated task.'}), 200
    except:
        return jsonify({'error': 'There was an issue updating your observation'}), 500

@app.route('/export', methods=['GET'])
def export():
    try:
        # Fetching tasks from the database
        tasks = Todo.query.order_by(Todo.date_created).all()

        if not tasks:
            return jsonify({'error': 'No tasks available to export'}), 404

        # In-memory CSV creation
        output = StringIO()
        writer = csv.writer(output)
        writer.writerow(['ID', 'Content', 'Completed', 'Date Created'])

        # Writing task data into CSV structure
        for task in tasks:
            writer.writerow([task.id, task.content, task.completed, task.date_created])

        output.seek(0)

        # Returning CSV response
        return Response(output, mimetype="text/csv", headers={"Content-Disposition": "attachment;filename=tasks.csv"})

    except Exception as e:
        return jsonify({'error': f'An error occurred while exporting the CSV: {e}'}), 500

# Setting local host to 50100, use localhost:50100
if __name__ == '__main__':
    app.run(port=50100, debug=True)
