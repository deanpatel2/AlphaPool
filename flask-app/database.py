from flaskext.mysql import MySQL
from flask import jsonify
db_connection = MySQL()

def run_dynamic_select_query(query, tuple):
    cur = db_connection.get_db().cursor()
    cur.execute(query, tuple)
    row_headers = [x[0] for x in cur.description]
    json_data = []
    theData = cur.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    return jsonify(json_data)

def run_select_query(query):
    cur = db_connection.get_db().cursor()
    cur.execute(query)
    row_headers = [x[0] for x in cur.description]
    json_data = []
    theData = cur.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    return jsonify(json_data)

def run_post_with_body(query, values):
    cur = db_connection.get_db().cursor()
    cur.execute(query, values)
    db_connection.get_db().commit()
    return {"Rows Inserted": cur.rowcount}