import os
from flask import Flask

def create_app(test_config = None):
    #this creates and sets basic configs for the app
    app = Flask(__name__, instance_relative_config = True)
    app.config.from_mapping(
        SECRET_KEY = 'dev',
        DATABASE = os.path.join(app.instance_path, 'cosc-231-flask-app.sqlite')
    )

    if test_config is None:
        #loads the instances config when not testing
        app.config.from_pyfile('config.py', silent=True)
    else:
        #loads the test config
        app.config.from_mapping(test_config)

    #ensures instance exists
    os.makedirs(app.instance_path, exist_ok = True)

    #add /hello to url to go to test
    @app.route('/hello')
    def hello():
        return 'Hello, World!'

    #imports database using db.py file
    from . import db
    db.init_app(app)

    #imports blueprint from auth.py
    from . import auth
    app.register_blueprint(auth.bp)

    return app