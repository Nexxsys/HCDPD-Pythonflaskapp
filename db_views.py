import sqlite3 as sql

#def insertUser(username,password):
#    con = sql.connect("database.db")
#    cur = con.cursor()
#    cur.execute("INSERT INTO users (username,password) VALUES (?,?)", (username,password))
#    con.commit()
#    con.close()

#def retrieveUsers():
#    con = sql.connect("database.db")
#    cur = con.cursor()
#    cur.execute("SELECT username, password FROM users")
#    users

def retrieveDrugs():
    con = sql.connect("./database/dpd.db")
    cur = con.cursor()
    cur.execute("SELECT DRUG_IDENTIFICATION_NUMBER, INGREDIENT FROM drug INNER JOIN ingred ON drug.DRUG_CODE = ingred.DRUG_CODE WHERE drug.CLASS='Human' LIMIT 20;")
    #drugs
