from asyncio.windows_events import NULL
from flask import Flask, redirect, request, url_for, render_template, session
from flask_mysqldb import MySQL
from datetime import datetime
from sqlalchemy import true

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
    if "userid" in session:
        user    = 1
        return render_template("home.html",user=user)
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
    else:
        if "userid" in session:
            return redirect(url_for('accounts'))
        return render_template("Login.html")

@app.route("/register", methods=["GET","POST"])
def register():
    msg=''
    if request.method == 'POST':
        now     = datetime.now()
        fdata   = request.form
        fname   = fdata['firstname']
        mname   = fdata['middlename']
        lname   = fdata['lastname']
        email   = fdata['email']
        phone   = fdata['phone']
        adrs    = fdata['address1']
        city    = fdata['city']
        state   = fdata['state']
        zipc    = fdata['zip']
        uname   = fdata['username']
        pswd    = fdata['password']
        date    = now.strftime('%Y-%m-%d')

        cur     = mysql.connection.cursor()
        resultU = cur.execute("SELECT username, password FROM users WHERE username = %s",[uname])
        resultP = cur.execute("SELECT username, password FROM users WHERE password = %s",[pswd])
        if resultU>0:
            msg='Username already exists'
        elif resultP>0:
            msg='Password already exists'
        else:
            cur.execute("INSERT INTO customers(Name_First, Name_Middle, Name_Last, Email, Telephone, Address, City, State, Zip_Code, Date_Joined) VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)",(fname,mname,lname,email,phone,adrs,city,state,zipc,date))
            mysql.connection.commit()
            cur.execute("INSERT INTO users(username, password) VALUES(%s, %s)",(uname,pswd))
            mysql.connection.commit()
        cur.close()
        return render_template("Register.html", msg=msg)

    return render_template("Register.html", msg=msg)

@app.route("/accounts",methods=["GET","POST"])
def accounts():
    if request.method == 'POST':
        if "userid" in session:
            user    = 1
            userid  = str(session["userid"])
            cur     = mysql.connection.cursor()
            
            query   = "SELECT account_id, amount FROM accounts WHERE Customer_ID = %s AND Type = 'Checking'"
            cur.execute(query,(userid,))
            debit = cur.fetchall()

            query   = "SELECT * FROM accounts WHERE Customer_ID = %s AND Type = 'Credit'"
            cur.execute(query,(userid,))
            credit = cur.fetchall()

            query   = "SELECT * FROM accounts WHERE Customer_ID = %s AND Type = 'Savings'"
            cur.execute(query,(userid))
            savings = cur.fetchall()

            cur.execute("SELECT * FROM transactions WHERE Account_A = %s OR Account_B = %s",(userid,userid,))
            hist    = cur.fetchall()

            cur.execute("SELECT account_id, amount FROM accounts WHERE (Type = 'Savings' OR Type = 'Checking') AND Customer_ID = %s",(userid,))
            source = cur.fetchall()

            fdata   = request.form
            AccA    = fdata['AccA']
            AccB    = fdata['AccB']
            Amount  = fdata['transferamount']
            now     = datetime.now()
            date    = now.strftime('%Y-%m-%d')

            x = AccA[18]
            y = AccA[19]
            A = str(x)
            if y != ' ':
                A = str(x) + str(y)
            x = AccB[18]
            y = AccB[19]
            B = str(x)
            if y != ' ':
                B =str(x) + str(y)

            cur.execute("INSERT INTO transactions(Account_A, Account_B, Amount, Transac_Date) VALUES(%s, %s, %s, %s)",(A, B, Amount,date))
            mysql.connection.commit()

            cur.close()

            return render_template("Accounts.html",debit=debit,credit=credit,savings=savings,hist=hist, source=source, user=user)
        else:
            return redirect(url_for("login"))
    else:
        if "userid" in session:
            user    = 1
            userid  = str(session["userid"])
            cur     = mysql.connection.cursor()
            
            query   = "SELECT account_id, amount FROM accounts WHERE Customer_ID = %s AND Type = 'Checking'"
            cur.execute(query,(userid,))
            debit = cur.fetchall()

            query   = "SELECT * FROM accounts WHERE Customer_ID = %s AND Type = 'Credit'"
            cur.execute(query,(userid,))
            credit = cur.fetchall()

            query   = "SELECT * FROM accounts WHERE Customer_ID = %s AND Type = 'Savings'"
            cur.execute(query,(userid))
            savings = cur.fetchall()

            cur.execute("SELECT * FROM transactions WHERE Account_A = %s OR Account_B = %s",(userid,userid,))
            hist    = cur.fetchall()

            cur.execute("SELECT account_id, amount FROM accounts WHERE (Type = 'Savings' OR Type = 'Checking') AND Customer_ID = %s",(userid,))
            source = cur.fetchall()

            cur.close()

            return render_template("Accounts.html",debit=debit,credit=credit,savings=savings,hist=hist, source=source, user=user)
        else:
            return redirect(url_for("login"))

@app.route("/cards",methods=["GET","POST"])
def cards():
    if request.method == 'POST':
        if "userid" in session:
            userid  = str(session["userid"])
            user = 1
            cur     = mysql.connection.cursor()

            cur.execute("SELECT Credit_Score FROM customers WHERE Customer_ID = %s",[userid]) 
            cr_score = cur.fetchall()

            for row in cr_score:
                if row != NULL:
                    credit = row[0]
            cardapr = 15
            if  credit>=900:
                apr = 0.5 * cardapr
            elif credit<900:
                apr = 0.6 * cardapr
            elif credit < 800:
                apr = 0.7 * cardapr
            elif credit < 700:
                apr = 0.8 * cardapr
            else:
                apr = 0.9 * cardapr
            now     = datetime.now()
            date    = now.strftime('%Y-%m-%d')
            cur.execute("INSERT INTO accounts(Type, Customer_ID, Amount, Date_Created, APR) VALUES(%s, %s, %s, %s, %s)",('Credit',userid, '0',date, str(apr)))
            mysql.connection.commit()
            cur.close()
            return redirect(url_for("accounts", user=user))
        else:
            return render_template("login.html")
    else:
        if "userid" in session:
            user = 1
            return render_template("Cards.html", user=user)
        else:
            return render_template("Cards.html")
@app.route("/logout")
def logout():
    session.pop("userid", None)
    return redirect(url_for("login"))


if __name__ == "__main__":
    app.run(debug=True)