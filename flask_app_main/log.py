#this blueprint is for the views: Log Workout, Log Routine, Progress

from flask import (
    Blueprint, flash, g, redirect, render_template, request, url_for
)

from .db import get_db

bp = Blueprint('log', __name__)

#define code here


#add:
#from . import log
#    app.register_blueprint(log.bp)
#to __init__.py at the end, but before "return app"