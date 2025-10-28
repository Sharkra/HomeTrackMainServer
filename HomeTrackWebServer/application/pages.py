from flask import Blueprint

bp = Blueprint("pages", __name__)

@bp.route("/")
def home():
    return "Hello, Home!"

@bp.route("/settings")
def about():
    return "Settings"
