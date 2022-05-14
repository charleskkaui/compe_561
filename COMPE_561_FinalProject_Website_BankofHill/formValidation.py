from flask import Flask,render_template
from flask_wtf import  
import wtforms import StringField, SubmitField
import wtforms.validators import DataRecquired


#secret key that syncs to make sure a hacker doesnt hack it.
app.config['SECRET_KEY'] = "TheSecret"

#Create a form class
class CertificateForm(FlaskForm):
    certificate_term = StringField(validators=[DataRequired()])
    certificate_amount = StringField(validators=[DataRequired()])
    certificate_submit = SubmitField(validators=[DataRequired()])

@app.route('/name',methods=['GET', 'POST'])
def certificateformroute():
    certificate_term = none
    certificate_amount = none
    certificate_form = CertificateForm()
    #ValidateFOrm
    if form.validate_on_submit():
        certificate_term = certificate_form.certificate_term.data
        certificate_amount = certificate_form.certificate_amount.data
        certificate_form.certificate_term.data = ''
        certificate_form.certificate_amount.data = ''

    return render_template("Name.html",
                           certificate_term = certificate_term,
                           certificate_amount = certificate_amount,
                           certificate_form = certificate_form)