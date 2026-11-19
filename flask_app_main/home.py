#this blueprint is for the views: Home, Support

from flask import (
    Blueprint, flash, g, redirect, render_template, request, url_for
)

from db import get_db

bp = Blueprint('home', __name__)

#define code here


#add:
#from . import home
#    app.register_blueprint(home.bp)
#to __init__.py at the end, but before "return app"