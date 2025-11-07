from flask import Flask


from application import routes, database
from application.database import db_session

def create_app():
    """Create Flask app."""
    app = Flask(__name__)

    app.register_blueprint(routes.bp)

    database.init_db()
    @app.teardown_appcontext
    def shutdown_session(exception=None):
        db_session.remove()

    return app