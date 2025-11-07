from flask import Blueprint, render_template, jsonify
from application.models.settings_model import getChartSettings
from application.models.measurements_model import MeasurementData, SensorType

bp = Blueprint("pages", __name__)

@bp.route("/")
def home():
    return render_template("pages/home.html")

@bp.route("/settings")
def settings():
    return render_template("pages/settings.html")

@bp.route('/api/chart-configs')
def chart_configs():
    return jsonify(getChartSettings())

@bp.route('/api/all-current-data')
def all_current_data():
    return jsonify(MeasurementData(SensorType.Current).getData())
