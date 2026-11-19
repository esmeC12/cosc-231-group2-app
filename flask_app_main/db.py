import sqlite3
from datetime import datetime

import click
from flask import current_app, g
#current_app: directs to the Flask app when handling request to connect to database
#g: stores data that's accessed multiple times during a request

def get_db():
    if 'db' not in g:
        #sqlite3.connect(): establishes connection btwn sqlite file
        #and DATABASE config key
        g.db = sqlite3.connect(
            current_app.config['DATABASE'],
            detect_types=sqlite3.PARSE_DECLTYPES
        )
        g.db.row_factory = sqlite3.Row

        #sqlite ignores foreign keys unless this is turned on
        g.db.execute('PRAGMA foreign_keys = ON')

    return g.db

#checks if connection was created; if so, it closes
def close_db(e=None):
    db = g.pop('db', None)

    if db is not None:
        db.close()

#functions will run SQL commands from create_tables.sql
def init_db():
    db = get_db()
    #opens file, returns a connection to database
    with current_app.open_resource('create_tables.sql') as f:
        db.executescript(f.read().decode('utf8'))

#click command defines a line command, in this case showing successful outcome
@click.command('init-db')
def init_db_command():
    """Clear the existing data and create new tables."""
    init_db()
    click.echo('Initialized the database')

#this tells Python how to register timestamps in the database
sqlite3.register_converter(
    "timestamp", lambda v: datetime.fromisoformat(v.decode())
)

def init_app(app):
    #Flask calls this after returning the response
    app.teardown_appcontext(close_db)
    #this adds a new line command that can be called after the flask command
    app.cli.add_command(init_db_command)