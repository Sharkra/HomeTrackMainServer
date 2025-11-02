from flask import Blueprint, render_template

bp = Blueprint("pages", __name__)

@bp.route("/")
def home():
    data=[
        ("1", 21),
        ("2", 10),
        ("3", 50),
        ("4", 35),
        ("5", 29),
        ("6", 1),
        ("7", 74),
        ("8", 42)
    ]

    labels = [row[0] for row in data]
    values = [row[1] for row in data]

    
    return render_template("pages/home.html", labels=labels, values=values)

@bp.route("/settings")
def settings():
    return render_template("pages/settings.html")
