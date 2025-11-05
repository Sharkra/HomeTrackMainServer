from flask import Flask
from flask_debugtoolbar import DebugToolbarExtension

from gevent import monkey
monkey.patch_all()

from flask_socketio import SocketIO

from application import routes

from logging.config import dictConfig

dictConfig({
    'version': 1,
    'formatters': {'default': {
        'format': '[%(asctime)s] %(levelname)s in %(module)s: %(message)s',
    }},
    'handlers': {'wsgi': {
        'class': 'logging.StreamHandler',
        'stream': 'ext://flask.logging.wsgi_errors_stream',
        'formatter': 'default'
    }},
    'root': {
        'level': 'INFO',
        'handlers': ['wsgi']
    }
})

socketio = SocketIO()
@socketio.on("home")
def create_app():
    """Create Flask app."""
    app = Flask(__name__)

    app.logger.info("Starting the app")

    app.register_blueprint(routes.bp)

    app.config['SECRET_KEY'] ="irunooo"

    toolbar = DebugToolbarExtension(app)

    app.logger.info("Starting the websocket")
    socketio.init_app(app)
    return app

if __name__ == '__main__':
    
    app = create_app()
    app.logger.info("Starting the app with websocket")
    socketio.run(app)
