from asyncio.windows_events import NULL
from flask import Flask, redirect, request, url_for, render_template, session
from flask_mysqldb import MySQL
from sqlalchemy import null

app = Flask(__name__)
app.secret_key = "secret"

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'bankofhill'

mysql = MySQL(app)

userid = '1'

@app.route("/")
def home():
    return render_template("home.html")

@app.route("/login", methods=["GET","POST"])
def login():
    if request.method == 'POST':
        fdata   = request.form
        uname   = fdata['uname']
        pswd    = fdata['pswd']

        cur     = mysql.connection.cursor()
        values  = [uname, pswd]
        query   = "SELECT * FROM users WHERE username = %s AND password = %s"
        result  = cur.execute(query,(values)) 
        if result > 0:
            signedIn = cur.fetchall()
            for row in signedIn:
                if row != NULL:
                    session["userid"] = row[0]
            cur.close() 
            return redirect(url_for("accounts"))       
        cur.close()
    return render_template("Login.html")

@app.route("/register", methods=["GET","POST"])
def register():
    msg=''

    return render_template("Register.html", msg=msg)

@app.route("/accounts")
def accounts():
    if "userid" in session:
        userid = str(session["userid"])
        cur     = mysql.connection.cursor()
        
        query   = "SELECT amount FROM accounts WHERE Customer_ID = %s AND Type = 'Debit'"
        cur.execute(query,(userid,))
        data = cur.fetchall()

        query   = "SELECT * FROM accounts WHERE Customer_ID = %s AND Type = 'Credit'"
        cur.execute(query,(userid,))
        credit = cur.fetchall()

        query   = "SELECT * FROM accounts WHERE Customer_ID = %s AND Type = 'Savings'"
        cur.execute(query,(userid))
        savings = cur.fetchall()

        cur.execute("SELECT * FROM transactions WHERE Account_A = %s OR Account_B = %s",(userid,userid,))
        hist    = cur.fetchall()

        cur.close()

        return render_template("Accounts.html",debit=data,credit=credit,savings=savings,hist=hist)
    else:
        return redirect(url_for("login"))

@app.route("/cards")
def cards():
    return render_template("Cards.html")


if __name__ == "__main__":
    app.run(debug=True)