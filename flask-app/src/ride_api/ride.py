from flask import Blueprint, request
from database import run_post_with_body, run_dynamic_select_query, run_select_query
import json

ride_blueprint = Blueprint('ride_blueprint', __name__)

@ride_blueprint.route('/checkpoints')
def get_all_checkpoints():
    query = """SELECT city as label, loc_id as value FROM CheckpointLocation"""
    return run_select_query(query)

@ride_blueprint.route('/rides')
def get_all_rides():
    query = """SELECT * FROM Ride"""
    return run_select_query(query)
@ride_blueprint.route('/riders')
def get_all_riders():
    query = """SELECT firstName as label, rider_id as value FROM Rider"""
    return run_select_query(query)

@ride_blueprint.route('/confirmed_rides')
def get_all_confirmed_rides():
    query = """SELECT * FROM RideRider"""
    return run_select_query(query)

@ride_blueprint.route('/<origin_id>/<destination_id>/<date>/<passengers>')
def get_filtered_rides(origin_id, destination_id, date, passengers):
   query = """SELECT departureTime As Departure, firstName AS DriverFirstName, lastName AS DriverLastName, rating AS DriverRating, 
   make AS CarMake, model AS CarModel, price AS Price, rides_completed AS RidesCompleted, ride_id FROM Ride JOIN Car C on C.car_id = Ride.car_id JOIN Driver D on 
   D.driver_id = Ride.driver_id WHERE origin_id = %s AND destination_id = %s AND CAST(departureTime AS DATE) = %s AND seats_available >= %s"""
   params_tuple = (origin_id, destination_id, date, passengers)
   return run_dynamic_select_query(query, params_tuple)

@ride_blueprint.route('/create_ride', methods = ['POST'])
def create_ride_offer():
   body = request.form # a multidict containing POST data
   driver_id = body.get('driver_id')
   car_id = body.get('car_id')
   origin_id = body.get('origin_id')
   destination_id = body.get('destination_id')
   departureTime = body.get('departureTime')
   price = body.get('price')
   seats_available = body.get('seats_available')
   query = """INSERT INTO Ride (driver_id, car_id, origin_id, destination_id, departureTime, price, seats_available) VALUES (%s, %s, %s, %s, %s, %s, %s)"""
   values = (int(driver_id), int(car_id), int(origin_id), int(destination_id), departureTime, float(price), int(seats_available))
   return run_post_with_body(query, values)

@ride_blueprint.route('/confirm_ride', methods = ['POST'])
def confirm_ride():
   body = request.form # a multidict containing POST data
   ride_id = body.get('ride_id')
   rider_id = body.get('rider_id')
   query = """INSERT INTO RideRider (ride_id, rider_id) VALUES (%s, %s)"""
   values = (int(ride_id), int(rider_id))
   return run_post_with_body(query, values)