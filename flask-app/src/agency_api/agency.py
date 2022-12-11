from flask import Blueprint, request
from database import run_select_query, run_dynamic_select_query, run_post_with_body

agency_blueprint = Blueprint('agency_blueprint', __name__)

@agency_blueprint.route('/agencies')
def get_all_agencies():
    query = """SELECT companyName as label, agency_id as value FROM Agency"""
    return run_select_query(query)

@agency_blueprint.route('/agencies/<id>')
def get_agency_by_id(id):
   query = """SELECT * FROM Agency WHERE agency_id = %s"""
   id_tuple = (id)
   return run_dynamic_select_query(query, id_tuple)

# propose_offer POST route
@agency_blueprint.route('/propose_offer', methods = ['POST'])
def propose_offer():
   body = request.form # a multidict containing POST data
   driver_id = body.get('driver_id')
   agency_id = body.get('agency_id')
   car_id = body.get('car_id')
   offer = body.get('offer')
   query = """INSERT INTO AgencyOffer (driver_id, agency_id, car_id, offer) VALUES (%s, %s, %s, %s)"""
   values = (int(driver_id), int(agency_id), int(car_id), float(offer))
   return run_post_with_body(query, values)