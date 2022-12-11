CREATE DATABASE alphapool_db;

-- CREATE USER 'webapp'@'%'
--    IDENTIFIED BY 'q3e&nkA8UM]FDI)h;$;d';

-- Via the Docker Compose file, a special user called webapp will 
-- be created in MySQL. We are going to grant that user 
-- all privilages to the new database we just created. 
-- TODO: If you changed the name of the database above, you need 
-- to change it here too.
GRANT ALL PRIVILEGES ON alphapool_db.* TO 'webapp'@'%';
FLUSH PRIVILEGES;

USE alphapool_db;

CREATE TABLE Driver (
    driver_id int NOT NULL auto_increment,
    rides_completed int NOT NULL,
    rating decimal(3,2) NOT NULL,
    cash_earned decimal(19,4) NOT NULL,
    firstName varchar(255) NOT NULL,
    lastName varchar(255) NOT NULL,
    city varchar(255) NOT NULL,
    state varchar(255) NOT NULL,
    PRIMARY KEY(driver_id));

CREATE TABLE Agency (
    agency_id int NOT NULL auto_increment,
    companyName varchar(255) NOT NULL,
    rating decimal(3,2) NOT NULL,
    img varchar(500) NOT NULL,
    PRIMARY KEY(agency_id));

CREATE TABLE CheckpointLocation (
    loc_id int NOT NULL auto_increment,
    street varchar(255) NOT NULL,
    city varchar(255) NOT NULL,
    state varchar(25) NOT NULL,
    zip varchar(10) NOT NULL,
    PRIMARY KEY(loc_id));

CREATE TABLE Car (
    car_id int NOT NULL auto_increment,
    driver_id int,
    agency_id int,
    make varchar(255) NOT NULL,
    model varchar(255) NOT NULL,
    year int NOT NULL,
    miles int NOT NULL,
    seats int NOT NULL,
    img varchar(500) NOT NULL,
    PRIMARY KEY(car_id),
    CONSTRAINT fk_driverOwner FOREIGN KEY (driver_id)
        REFERENCES Driver(driver_id)
        ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT fk_agencyOwner FOREIGN KEY (agency_id)
        REFERENCES Agency(agency_id)
        ON UPDATE cascade ON DELETE restrict);

CREATE TABLE AgencyOffer (
    driver_id int NOT NULL,
    agency_id int NOT NULL,
    car_id int NOT NULL,
    offer decimal(19,4) NOT NULL,
    PRIMARY KEY(driver_id, agency_id),
    CONSTRAINT fk_driverTo FOREIGN KEY (driver_id)
        REFERENCES Driver(driver_id)
        ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT fk_agencyFrom FOREIGN KEY (agency_id)
        REFERENCES Agency(agency_id)
        ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT fk_vehicle FOREIGN KEY (car_id)
        REFERENCES Car(car_id)
        ON UPDATE cascade ON DELETE restrict);

CREATE TABLE Ride (
    ride_id int NOT NULL auto_increment,
    driver_id int NOT NULL,
    car_id int NOT NULL,
    origin_id int NOT NULL,
    destination_id int NOT NULL,
    departureTime datetime NOT NULL,
    price decimal(19,4) NOT NULL,
    seats_available int NOT NULL,
    PRIMARY KEY(ride_id),
    CONSTRAINT fk_driver FOREIGN KEY (driver_id)
        REFERENCES Driver(driver_id)
        ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT fk_car FOREIGN KEY (car_id)
        REFERENCES Car(car_id)
        ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT fk_origin FOREIGN KEY (origin_id)
        REFERENCES CheckpointLocation(loc_id)
        ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT fk_destination FOREIGN KEY (destination_id)
        REFERENCES CheckpointLocation(loc_id)
        ON UPDATE cascade ON DELETE restrict);

CREATE TABLE Rider (
    rider_id int NOT NULL auto_increment,
    firstName varchar(255) NOT NULL,
    lastName varchar(255) NOT NULL,
    rating decimal(3,2) NOT NULL,
    city varchar(255) NOT NULL,
    state varchar(255) NOT NULL,
    PRIMARY KEY(rider_id));

CREATE TABLE RideRider (
    ride_id int NOT NULL,
    rider_id int NOT NULL,
    rating decimal(3,2),
    PRIMARY KEY(ride_id, rider_id),
    CONSTRAINT fk_ride FOREIGN KEY (ride_id)
        REFERENCES Ride(ride_id)
        ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT fk_rider FOREIGN KEY (rider_id)
        REFERENCES Rider(rider_id)
        ON UPDATE cascade ON DELETE restrict);


-- ADDING DATA

insert into Driver (driver_id, rides_completed, rating, cash_earned, firstName, lastName, city, state) values (1, 86, 4.12, 67, 'Janella', 'Longley', 'El Paso', 'Texas');
insert into Driver (driver_id, rides_completed, rating, cash_earned, firstName, lastName, city, state) values (2, 61, 1.83, 64, 'Norton', 'Pointin', 'Wichita Falls', 'Texas');
insert into Driver (driver_id, rides_completed, rating, cash_earned, firstName, lastName, city, state) values (3, 26, 3.41, 96, 'Christiano', 'Hulson', 'Kansas City', 'Kansas');
insert into Driver (driver_id, rides_completed, rating, cash_earned, firstName, lastName, city, state) values (4, 43, 0.92, 24, 'Winni', 'Dallander', 'New Haven', 'Connecticut');
insert into Driver (driver_id, rides_completed, rating, cash_earned, firstName, lastName, city, state) values (5, 41, 0.26, 90, 'Osbourn', 'Pires', 'Waterbury', 'Connecticut');
insert into Driver (driver_id, rides_completed, rating, cash_earned, firstName, lastName, city, state) values (6, 26, 1.46, 85, 'Novelia', 'Dryburgh', 'Glendale', 'Arizona');
insert into Driver (driver_id, rides_completed, rating, cash_earned, firstName, lastName, city, state) values (7, 68, 0.77, 15, 'Parsifal', 'Cheale', 'Sarasota', 'Florida');
insert into Driver (driver_id, rides_completed, rating, cash_earned, firstName, lastName, city, state) values (8, 87, 3.3, 60, 'Merrick', 'Honeyghan', 'Des Moines', 'Iowa');
insert into Driver (driver_id, rides_completed, rating, cash_earned, firstName, lastName, city, state) values (9, 60, 1.22, 50, 'Neala', 'Vercruysse', 'Birmingham', 'Alabama');
insert into Driver (driver_id, rides_completed, rating, cash_earned, firstName, lastName, city, state) values (10, 46, 0.75, 98, 'Nilson', 'Noice', 'Homestead', 'Florida');

insert into Agency (agency_id, companyName, rating, img) values (1, 'Hertz', 4.34, 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Hertz_Car_Rental_logo.svg/1200px-Hertz_Car_Rental_logo.svg.png');
insert into Agency (agency_id, companyName, rating, img) values (2, 'Sixt', 4.41, 'https://1000logos.net/wp-content/uploads/2021/03/Sixt-logo.jpg');
insert into Agency (agency_id, companyName, rating, img) values (3, 'Avis', 4.19, 'https://1000logos.net/wp-content/uploads/2020/10/Avis-Logo.png');

insert into CheckpointLocation (loc_id, street, city, state, zip) values (1, '70812 Mitchell Alley', 'Charlotte', 'North Carolina', '28242');
insert into CheckpointLocation (loc_id, street, city, state, zip) values (2, '85978 Pawling Parkway', 'Honolulu', 'Hawaii', '96840');
insert into CheckpointLocation (loc_id, street, city, state, zip) values (3, '83110 Morrow Plaza', 'Minneapolis', 'Minnesota', '55480');
insert into CheckpointLocation (loc_id, street, city, state, zip) values (4, '403 Hauk Point', 'Buffalo', 'New York', '14225');
insert into CheckpointLocation (loc_id, street, city, state, zip) values (5, '72 Coolidge Terrace', 'Raleigh', 'North Carolina', '27615');
insert into CheckpointLocation (loc_id, street, city, state, zip) values (6, '00467 Ronald Regan Place', 'Pasadena', 'Texas', '77505');
insert into CheckpointLocation (loc_id, street, city, state, zip) values (7, '6793 Blackbird Trail', 'Montpelier', 'Vermont', '05609');
insert into CheckpointLocation (loc_id, street, city, state, zip) values (8, '90 Independence Park', 'Oakland', 'California', '94660');
insert into CheckpointLocation (loc_id, street, city, state, zip) values (9, '466 Fisk Place', 'Fresno', 'California', '93794');
insert into CheckpointLocation (loc_id, street, city, state, zip) values (10, '213 Summer Ridge Drive', 'Dayton', 'Ohio', '45454');

insert into Car (car_id, driver_id, agency_id, make, model, year, miles, seats, img) values (1, 5, NULL, 'Chevrolet', 'Silverado 2500', 2006, 17361, 5, 'https://www.chevrolet.com/content/dam/chevrolet/na/us/english/index/vehicles/2022/trucks/silverado-hd/colorizer/01-images/2022-silverado2500-1lz-GA0-colorizer.jpg?imwidth=960');
insert into Car (car_id, driver_id, agency_id, make, model, year, miles, seats, img) values (2, NULL, 2, 'Ford', 'LTD', 1985, 49863, 3, 'https://www.corral.net/cdn-cgi/image/format=auto,onerror=redirect,width=1920,height=1920,fit=scale-down/https://www.corral.net/attachments/img-2690-jpg.1062958/');
insert into Car (car_id, driver_id, agency_id, make, model, year, miles, seats, img) values (3, 2, NULL, 'Mercedes-Benz', 'GL-Class', 2012, 94670, 4, 'https://cars.usnews.com/static/images/Auto/izmo/337161/2012_mercedes_benz_gl_class_angularfront.jpg');
insert into Car (car_id, driver_id, agency_id, make, model, year, miles, seats, img) values (4, NULL, 1, 'Lamborghini', 'Murcielago', 2009, 73345, 3, 'https://i.ytimg.com/vi/vmWkVSM6xJA/maxresdefault.jpg');
insert into Car (car_id, driver_id, agency_id, make, model, year, miles, seats, img) values (5, NULL, 3, 'GMC', 'Savana 2500', 2001, 641833, 5, 'https://file.kelleybluebookimages.com/kbb/base/evox/CP/12611/2019-GMC-Savana%202500%20Cargo-front_12611_032_2400x1800_GAZ.png');
insert into Car (car_id, driver_id, agency_id, make, model, year, miles, seats, img) values (6, NULL, 3, 'Volkswagen', 'Jetta', 2013, 29857, 3, 'https://crdms.images.consumerreports.org/c_lfill,w_470,q_auto,f_auto/prod/cars/cr/car-versions/12628-2019-volkswagen-jetta-se');
insert into Car (car_id, driver_id, agency_id, make, model, year, miles, seats, img) values (7, 1, NULL, 'Audi', 'RS7', 2020, 68012, 4, 'https://inv.assets.sincrod.com/ChromeColorMatch/us/TRANSPARENT_cc_2022AUC310007_01_1280_R5R5.png');
insert into Car (car_id, driver_id, agency_id, make, model, year, miles, seats, img) values (8, 1, NULL, 'BMW', 'X3', 2017, 79886, 4, 'https://www.bmwusa.com/content/dam/bmwusa/common/vehicles/2022/my23/x3/core-models/mobile/BMW-MY23-X3-DetailPage-Core-MakeitYours-Mobile.jpg');
insert into Car (car_id, driver_id, agency_id, make, model, year, miles, seats, img) values (10, NULL, 1, 'Bugatti', 'Chiron', 2021, 84358, 5, 'https://www.bugatti.com/fileadmin/_processed_/sei/p54/se-image-4799f9106491ebb58ca3351f6df5c44a.jpg');

insert into AgencyOffer (driver_id, agency_id, car_id, offer) values (1, 1, 10, 2000.00);
insert into AgencyOffer (driver_id, agency_id, car_id, offer) values (3, 2, 2, 20.00);
insert into AgencyOffer (driver_id, agency_id, car_id, offer) values (5, 3, 5, 75.00);

insert into Ride (ride_id, driver_id, car_id, origin_id, destination_id, departureTime, price, seats_available) values (1, 9, 10, 2, 10, '2022-11-13 18:26:31', 46.17, 6);
insert into Ride (ride_id, driver_id, car_id, origin_id, destination_id, departureTime, price, seats_available) values (2, 4, 2, 4, 1, '2022-11-11 11:11:50', 27.63, 6);
insert into Ride (ride_id, driver_id, car_id, origin_id, destination_id, departureTime, price, seats_available) values (3, 6, 8, 4, 3, '2022-07-06 08:50:21', 188.68, 2);
insert into Ride (ride_id, driver_id, car_id, origin_id, destination_id, departureTime, price, seats_available) values (5, 4, 1, 10, 2, '2022-03-24 17:36:22', 42.03, 6);
insert into Ride (ride_id, driver_id, car_id, origin_id, destination_id, departureTime, price, seats_available) values (6, 4, 6, 4, 7, '2022-10-13 13:39:29', 50.73, 6);
insert into Ride (ride_id, driver_id, car_id, origin_id, destination_id, departureTime, price, seats_available) values (7, 9, 5, 8, 9, '2022-06-01 00:12:36', 141.28, 3);

insert into Rider (rider_id, firstName, lastName, rating, city, state) values (1, 'Zechariah', 'Montfort', 1.82, 'Glendale', 'California');
insert into Rider (rider_id, firstName, lastName, rating, city, state) values (2, 'Johnath', 'Tabor', 2.23, 'North Little Rock', 'Arkansas');
insert into Rider (rider_id, firstName, lastName, rating, city, state) values (3, 'Charity', 'Shrieves', 1.48, 'El Paso', 'Texas');
insert into Rider (rider_id, firstName, lastName, rating, city, state) values (4, 'Arley', 'Bothe', 1.11, 'Rochester', 'New York');
insert into Rider (rider_id, firstName, lastName, rating, city, state) values (5, 'Inglis', 'Gerraty', 1.05, 'Seminole', 'Florida');
insert into Rider (rider_id, firstName, lastName, rating, city, state) values (6, 'Rosaleen', 'Aronovitz', 1.27, 'Buffalo', 'New York');
insert into Rider (rider_id, firstName, lastName, rating, city, state) values (7, 'Regan', 'Kestell', 1.3, 'Newton', 'Massachusetts');
insert into Rider (rider_id, firstName, lastName, rating, city, state) values (8, 'Gaile', 'Broseman', 3.19, 'Salt Lake City', 'Utah');
insert into Rider (rider_id, firstName, lastName, rating, city, state) values (9, 'Lorenza', 'Elliman', 3.64, 'Kansas City', 'Missouri');
insert into Rider (rider_id, firstName, lastName, rating, city, state) values (10, 'Leonelle', 'Nockolds', 4.53, 'Miami', 'Florida');

insert into RideRider (ride_id, rider_id, rating) values (2, 3, 1.73);
insert into RideRider (ride_id, rider_id, rating) values (1, 2, 3.44);
insert into RideRider (ride_id, rider_id, rating) values (6, 4, 2.67);
insert into RideRider (ride_id, rider_id, rating) values (5, 7, NULL);
insert into RideRider (ride_id, rider_id, rating) values (2, 9, 4.28);
insert into RideRider (ride_id, rider_id, rating) values (5, 8, 4.36);
insert into RideRider (ride_id, rider_id, rating) values (5, 1, 2.88);
insert into RideRider (ride_id, rider_id, rating) values (3, 9, 4.61);
insert into RideRider (ride_id, rider_id, rating) values (5, 4, 1.29);
insert into RideRider (ride_id, rider_id, rating) values (7, 2, NULL);
insert into RideRider (ride_id, rider_id, rating) values (2, 5, 3.9);
insert into RideRider (ride_id, rider_id, rating) values (5, 6, 4.89);