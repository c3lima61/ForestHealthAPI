#!/bin/bash

# POST request (add a new task)
curl -X POST http://localhost:50100/ -H "Content-Type: application/json" -d '{"content": "Test task"}'
curl -X POST http://localhost:50100/ -H "Content-Type: application/json" -d '{"content": "CSV task"}'

# GET request (retrieve tasks)
curl -X GET http://localhost:50100/

# DELETE request (remove a task with ID 1)
curl -X DELETE http://localhost:50100/delete/1

# EXPORT THE CSV (not formatted)
curl -X GET http://localhost:50100/export -o exported_tasks.csv

# print exported CSV tasks locally 
cat exported_tasks.csv 

# DELETE CSV task
curl -X DELETE http://localhost:50100/delete/2

# Delete exported CSV tasks locally
sudo rm exported_tasks.csv
