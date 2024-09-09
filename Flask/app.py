from flask import Flask, render_template, url_for, request, redirect, Response
from datetime import datetime
import csv
from io import StringIO

#imports sql database
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)

#telling app where database is located
app.config["SQLALCHEMY_DATABASE_URI"] = 'sqlite:///test.db'
db = SQLAlchemy(app)# initialize database with setting from app
app.app_context().push()


class Todo(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    content = db.Column(db.String(200), nullable=False)
    completed = db.Column(db.Integer, default=0)
    date_created = db.Column(db.DateTime, default=datetime.utcnow)

    def __repr__(self):
        return '<Task %r>' % self.id

#route from server
@app.route("/", methods=['POST', 'GET'])

#function end point
def index():
    if request.method == 'POST':
        task_content = request.form['content']
        new_task = Todo(content=task_content)

        try:
            db.session.add(new_task)
            db.session.commit()
            return redirect('/')
        except Exception as e:
            return f"There was an issue adding your task: {e}"
    else:
        tasks = Todo.query.order_by(Todo.date_created).all()
        return render_template('index.html', tasks=tasks)

@app.route('/delete/<int:id>')
def delete(id):
    task_to_delete = Todo.query.get_or_404(id)

    try:
        db.session.delete(task_to_delete)
        db.session.commit()
        return redirect('/')
    except Exception as e:
        return f"There was a problem deleting that task: {e}"

@app.route('/update/<int:id>', methods=['GET', 'POST'])
# updates current location through html, may need to update later 
# once a list of observations for location has been made.
def update(id):
    task = Todo.query.get_or_404(id)

    if request.method == 'POST':
        task.content = request.form['content']
        # commits data to database, then redirects back to home page
        try:
            db.session.commit()
            return redirect('/')
        except:
            return 'There was an issue updating your observation'
    else:
        return render_template('update.html', task=task)
    

# Export route, export.html is no longer being rendered
# So can probably be removed.
@app.route('/export')
def export():
    try:
        # Fetching tasks from the 'mock DB' in order of date.
        tasks = Todo.query.order_by(Todo.date_created).all()

        if not tasks:
            return "No tasks available to export." # Will in case of no tasks.

        # Below will create a CSV in-memory buffer which we need currently, as we
        # don't want to create a physical file but still researching if this needs
        # to be updated when we fetch from the real db.
        output = StringIO()
        writer = csv.writer(output) # Writing rows into the output buffer.

        # Writes our header row as well as follows this structure.
        writer.writerow(['ID', 'Content', 'Completed', 'Date Created'])

        # I needed help writing this, but I believe this is the correct logic.
        # Will iterate over each task retrieved, following the header row structure.
        for task in tasks:
            writer.writerow([task.id, task.content, task.completed, task.date_created])

        output.seek(0)  # this will reset the position of the buffer to the beginning.

        # This will need to be edited when we connect to the actual db.
        return Response(output, mimetype="text/csv", headers={"Content-Disposition": "attachment;filename=tasks.csv"})

    except Exception as e:
        # we can probably get rid of this at some point just using it for testing purposes.
        print(f"Error exporting CSV: {e}")

        # Return a user-friendly error message
        return f"An error occurred while exporting the CSV: {e}", 500


# setting local host to 50100, use localhost:50100
if __name__ == '__main__':
    app.run(port=50100, debug=True)