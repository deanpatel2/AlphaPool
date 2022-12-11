###
# Main application interface
###
from flask import Flask, jsonify
from database import db_connection

app = Flask(__name__)
    
# secret key that will be used for securely signing the session 
# cookie and can be used for any other security related needs by 
# extensions or your application
app.config['SECRET_KEY'] = 'someCrazyS3cR3T!Key.!'

# these are for the DB object to be able to connect to MySQL. 
app.config['MYSQL_DATABASE_USER'] = 'webapp'
app.config['MYSQL_DATABASE_PASSWORD'] = open('/secrets/db_password.txt').readline()
app.config['MYSQL_DATABASE_HOST'] = 'db'
app.config['MYSQL_DATABASE_PORT'] = 3306
app.config['MYSQL_DATABASE_DB'] = 'alphapool_db'  # Change this to your DB name

# Initialize the database object with the settings above. 
db_connection.init_app(app)

from src.car_api.car import car_blueprint
from src.agency_api.agency import agency_blueprint
from src.driver_api.driver import driver_blueprint
from src.ride_api.ride import ride_blueprint

app.register_blueprint(car_blueprint, url_prefix='/car')
app.register_blueprint(agency_blueprint, url_prefix='/agency')
app.register_blueprint(driver_blueprint, url_prefix='/driver')
app.register_blueprint(ride_blueprint, url_prefix='/ride')

@app.route('/')
def home():
    return ('<h1>Hello From the Alphapool API!</h1>')

# This is a sample route for the /test URI.  
# as above, it just returns a simple string. 
@app.route('/test')
def tester():
    return "<h1>This is a test!</h1>"

if __name__ == '__main__':
    # we want to run in debug mode (for hot reloading) 
    # this app will be bound to port 4000. 
    # Take a look at the docker-compose.yml to see 
    # what port this might be mapped to... 
    app.run(debug = True, host = '0.0.0.0', port = 4000)