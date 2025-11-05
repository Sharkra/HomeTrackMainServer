from flask import Blueprint, render_template, jsonify
from flask import current_app as app
from flask_socketio import SocketIO

from application.home_model import *

bp = Blueprint("pages", __name__)

@bp.route("/")
def home():
    socketio=SocketIO(app)
    socketio.start_background_task(stream_data(app))
    app.logger.info("Starting on Home")  
    return render_template("pages/home.html")

@bp.route("/settings")
def settings():
    return render_template("pages/settings.html")

@bp.route('/api/home-settings')
def getSettings():
    return jsonify(getHomeSettings())

socketio = SocketIO()
@socketio.on('initialize')
def stream_data(app):
    socketio = SocketIO(app)
    while True:
        with app.app_context():
            data = jsonify(getTime())
            app.logger.info("Streaming data ")
            app.logger.info(data.data)
            socketio.emit('chart_update', data)
            socketio.sleep(5)
