#!/bin/bash

# Task will be completed with 0 even though you return a success message.
# The task is created with the default value, as defined in the Todo class.

# POST request (add a new task)
curl -X POST http://localhost:50100/ -H "Content-Type: application/json" -d '{"content": "Test task"}'
curl -X POST http://localhost:50100/ -H "Content-Type: application/json" -d '{"content": "CSV task"}'

# GET request (retrieve tasks)
curl -X GET http://localhost:50100/

# DELETE request (remove a task with ID 1)
curl -X DELETE http://localhost:50100/delete/1

# PUT request to update a task (task with ID 2)
curl -X PUT http://localhost:50100/update/2 -H "Content-Type: application/json" -d '{"content": "updated CSV task"}'

# Confirm update with a GET request
curl -X GET http://localhost:50100/

# EXPORT THE CSV (not formatted)
curl -X GET http://localhost:50100/export -o exported_tasks.csv

# print exported CSV tasks locally 
cat exported_tasks.csv 

# DELETE CSV task
curl -X DELETE http://localhost:50100/delete/2

# Delete exported CSV tasks locally
sudo rm exported_tasks.csv
