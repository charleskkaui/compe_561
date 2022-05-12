from flask import Flask, redirect, url_for, render_template

app = Flask(__name__)

@app.route("/")
def home():
    return render_template("home.html")

@app.route("/login")
def login():
    return render_template("Login.html")

@app.route("/register")
def register():
    return render_template("Register.html")

@app.route("/accounts")
def accounts():
    return render_template("Accounts.html")

@app.route("/cards")
def cards():
    return render_template("Cards.html")


if __name__ == "__main__":
    app.run(debug=True)