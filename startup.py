from flask import Flask
from flask import render_template
from flask import request
import sqlite3 as sql

app = Flask(__name__)

#@app.route('/')
#def index():
#    return render_template('index.html')

@app.route('/', methods=['GET'])
def home():
    if request.method=='GET':
        con = sql.connect("./database/dpd.db")
        cur = con.cursor()
        drugs = cur.execute("SELECT DRUG_IDENTIFICATION_NUMBER, INGREDIENT FROM drug INNER JOIN ingred ON drug.DRUG_CODE = ingred.DRUG_CODE WHERE drug.CLASS='Human' LIMIT 20;")
        return render_template('index.html', drugs=drugs)
    else:
        return render_template('index.html')

if __name__ == '__main__':
    app.run(debug=True)
