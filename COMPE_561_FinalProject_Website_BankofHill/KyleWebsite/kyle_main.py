from crypt import methods
from flask import Flask, redirect, url_for, render_template, request

app = Flask(__name__)

@app.route("/", methods=["POST", "GET"])
def accounts():
    return render_template("accounts.html")

if __name__ == "__main__":
    app.run(debug=True)