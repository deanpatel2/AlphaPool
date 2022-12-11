from flask import Blueprint, jsonify, request
from database import run_select_query, run_dynamic_select_query

driver_blueprint = Blueprint('driver_blueprint', __name__)

@driver_blueprint.route('/drivers')
def get_all_drivers():
    query = """SELECT firstName as label, driver_id as value FROM Driver"""
    return run_select_query(query)

@driver_blueprint.route('/<id>')
def get_driver_by_id(id):
   query = """SELECT * FROM Driver WHERE driver_id = %s"""
   id_tuple = (id)
   return run_dynamic_select_query(query, id_tuple)

@driver_blueprint.route('/drivers_without_cars')
def get_drivers_without_cars():
   query = """SELECT * FROM Driver WHERE driver_id NOT IN (SELECT C.driver_id FROM Driver JOIN Car C on Driver.driver_id = C.driver_id)"""
   response = run_select_query(query)
   formatted_response = []
   for item in response.json:
      formatted_response.append({"id": item['driver_id'], "name": item['firstName'] + " " + item['lastName'], 'img': 'https://icons.veryicon.com/png/o/miscellaneous/two-color-icon-library/user-286.png'})
   return formatted_response

