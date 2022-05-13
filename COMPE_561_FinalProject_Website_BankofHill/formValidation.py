from flask import Flask,render_template
from flask_wtf import FlaskForm
import wtforms import StringField, SubmitField
import wtforms.validators import DataRecquired


#secret key that syncs to make sure a hacker doesnt hack it.
app.config['SECRET_KEY'] = "TheSecret"

#Create a form class
class CertificateForm(FlaskForm):
    term = StringField(validators=[DataRequired()])
    amount = StringField(validators=[DataRequired()])
    submit = SubmitField(validators=[DataRequired()])

@app.route('/name',methods=['GET', 'POST'])
def name():
    name = none
    form = NamerForm()
    return render_template("Name.html")