#this blueprint is for the views: Log Workout, Log Routine, Progress

from flask import (
    Blueprint, flash, g, redirect, render_template, request, url_for
)

from .db import get_db
#decimal import for weight value in WorkoutExercise
from decimal import Decimal
#datetime import for the date value in Goal
from datetime import date

bp = Blueprint('log', __name__)

#define code here

#connection to database
conn = sqlite3.connect("create_tables.sql")
cursor = conn.cursor()

#Log Workout User Input
workoutId int(input("Enter the workout ID:"))
exerciseId int(input("Enter the exercise ID:"))
sets int(input("Enter the number of sets you completed:"))
reps int(input("Enter the number of reps you completed:"))
weight Decimal(input("Enter the weight you used for this workout:"))

#Insert into the table using parameterized query
sql = "INSERT INTO WorkoutExercise (workoutId, exerciseId, sets, reps, weight) VALUES (?, ?, ?, ?, ?)"
cursor.execute(sql, (workoutId, exerciseId, sets, reps, weight))

#Commit Changes
conn.commit()

#Verify
cursor.execute("SELECT * FROM WorkoutExercise")
for row in cursor.fetchall():
    print(row)

#Log Routine User Input
routineId int(input("Enter the routine ID:"))
userId int(input("Enter your user ID:"))
name input("Enter your name:")
targetArea input("Enter your target:")
details input("Enter the details of your routine:")

#Insert into the table using parameterized query
sql = "INSERT INTO Routine (routineId, userId, name, targetArea, details) VALUES (?, ?, ?, ?, ?)"
cursor.execute(sql, (routineId, userId, name, targetArea, details))

#Commit Changes
conn.commit()

#Verify
cursor.execute("SELECT * FROM Routine")
for row in cursor.fetchall():
    print(row)

#Progress User Input
#I could use some help on the check to see if the goal is completed.
goalId int(input("Please enter the ID for this goal:"))
userId int(input("Please enter your user ID:"))
description input("Please explain this goal:")
targetDate date(input("Please enter the intended completion date of this goal:"))

#Insert into the table using parameterized query
sql = "INSERT INTO Goal (goalId, userId, description, targetDate) VALUES (?, ?, ?, ?)"
cursor.execute(sql, (goalId, userId, description, targetDate))

#Commit Changes
conn.commit()

#Verify
cursor.execute("SELECT * FROM Goal")
for row in cursor.fetchall():
    print(row)

conn.close()

#add:
#from . import log
#    app.register_blueprint(log.bp)
#to __init__.py at the end, but before "return app"
