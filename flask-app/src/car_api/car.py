from flask import Blueprint
from database import run_select_query, run_dynamic_select_query

# Create a new blueprint for car
car_blueprint = Blueprint('car_blueprint', __name__)

# add a route to this blueprint
@car_blueprint.route('/agency/<agency_id>')
def get_cars_by_agency_id(agency_id):
    query = """SELECT * FROM Car WHERE agency_id = %s"""
    agency_id_tuple = (agency_id)
    response = run_dynamic_select_query(query, agency_id_tuple)
    formatted_response = []
    for item in response.json:
       formatted_response.append({"id": item['car_id'], "value": item['car_id'], "name": item['make'] + " " + item['model'] + " " + str(item['year']), "label": item['make'] + " " + item['model'], 'img': item['img']})
    return formatted_response

@car_blueprint.route('/driver/<driver_id>')
def get_cars_by_driver_id(driver_id):
    query = """SELECT * FROM Car WHERE driver_id = %s"""
    driver_id_tuple = (driver_id)
    response = run_dynamic_select_query(query, driver_id_tuple)
    formatted_response = []
    for item in response.json:
       formatted_response.append({"id": item['car_id'], "value": item['car_id'], "name": item['make'] + " " + item['model'] + " " + str(item['year']), "label": item['make'] + " " + item['model'], 'img': item['img']})
    return formatted_response

@car_blueprint.route('/driver/labels/<driver_id>')
def get_car_labels_by_driver_id(driver_id):
    query = """SELECT * FROM Car WHERE driver_id = %s"""
    driver_id_tuple = (driver_id)
    cars = run_dynamic_select_query(query, driver_id_tuple)
    formatted_cars = []
    for car in cars.json:
       formatted_cars.append({"label": car['make'] + " " + car['model'], "value": car['car_id']})
    return formatted_cars