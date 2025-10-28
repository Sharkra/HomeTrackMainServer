from flask import Flask

from application import pages

def create_app():
    """Create Flask app."""
    app = Flask(__name__)

    app.register_blueprint(pages.bp)

    return app
