/*
	Creating the City Table.
*/
CREATE TABLE qap_schema.cities
(
    id bigint NOT NULL,
    name text,
    province text,
    population bigint,
    PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS qap_schema.cities
    OWNER to postgres;
	
/*
	Creating the Passengers table.
*/
CREATE TABLE qap_schema.passengers
(
    id bigint NOT NULL,
    "firstName" text,
    "lastName" text,
    "phoneNumber" bigint,
    PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS qap_schema.passengers
    OWNER to postgres;
	
/*
	Creating the  table.
*/
CREATE TABLE qap_schema.airports
(
    id bigint NOT NULL,
    name text,
    code bigint,
    PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS qap_schema.airports
    OWNER to postgres;
	
/*
	Creating the Aircraft table.
*/
CREATE TABLE qap_schema.aircraft
(
    id bigint NOT NULL,
    type text,
    "airlineName" text,
    "numberOfPassengers" bigint,
    PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS qap_schema.aircraft
    OWNER to postgres;
	
/*
	Making relationships
*/
/*
	Which airport is in which city?
*/
ALTER TABLE IF EXISTS qap_schema.airports
    ADD COLUMN what_city bigint;
ALTER TABLE IF EXISTS qap_schema.airports
    ADD CONSTRAINT cities_fk FOREIGN KEY (what_city)
    REFERENCES qap_schema.cities (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
	
/*
	Who lives where?
*/
ALTER TABLE IF EXISTS qap_schema.passengers
    ADD COLUMN home_city bigint;
ALTER TABLE IF EXISTS qap_schema.passengers
    ADD CONSTRAINT cities_fk FOREIGN KEY (home_city)
    REFERENCES qap_schema.cities (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
	
/*
	Creating a flights table to show which plane took off from which city, to land in which city.
*/
CREATE TABLE qap_schema.flights
(
    flight_num bigint NOT NULL,
    aircraft bigint,
    depart bigint,
    arrive bigint,
    PRIMARY KEY (flight_num),
    CONSTRAINT aircraft_fk FOREIGN KEY (aircraft)
        REFERENCES qap_schema.aircraft (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT depart_fk FOREIGN KEY (depart)
        REFERENCES qap_schema.airports (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT arrive_fk FOREIGN KEY (arrive)
        REFERENCES qap_schema.airports (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

ALTER TABLE IF EXISTS qap_schema.flights
    OWNER to postgres;
	
/*
	Creating a table to show which passenger took which flight.
*/
CREATE TABLE qap_schema.who_flew
(
    flight_num bigint,
    passenger bigint,
    CONSTRAINT flight_num_fk FOREIGN KEY (flight_num)
        REFERENCES qap_schema.flights (flight_num) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT passenger_fk FOREIGN KEY (passenger)
        REFERENCES qap_schema.passengers (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

ALTER TABLE IF EXISTS qap_schema.who_flew
    OWNER to postgres;

/*
	Inputting data into the aircraft table.
	id (bigint), type(text), airlineName(text), numberOfPassengers(bigint)
*/
insert into qap_schema.aircraft values (1,'medium','Flight 1',24);
insert into qap_schema.aircraft values (2,'small','Flight 2',10);
insert into qap_schema.aircraft values (3,'medium','Flight 3',27);
insert into qap_schema.aircraft values (4,'large','Flight 4',42);
insert into qap_schema.aircraft values (5,'small','Flight 5',12);
insert into qap_schema.aircraft values (6,'large','Flight 6',51);

/*
	Inputting data into the cities table.
	id(bigint), name(text), province(text), population(bigint)
*/
insert into qap_schema.cities values (1,'St. Johns', 'NL',50000);
insert into qap_schema.cities values (2,'Deer Lake', 'NL',10000);
insert into qap_schema.cities values (3,'Halifax', 'NS',150000);

/*
	Inputting data into the airports table.
	id(bigint), name (text), code(bigint), what_city(bigint)
	what_city is a fk for the cities table (1-3)
*/
insert into qap_schema.airports values (1,'St Johns 1',123,1);
insert into qap_schema.airports values (2,'St Johns 2',321,1);
insert into qap_schema.airports values (3,'Deer Lake 1',234,2);
insert into qap_schema.airports values (4,'Halifax 1',345,3);
insert into qap_schema.airports values (5,'Halifax 2',456,3);
insert into qap_schema.airports values (6,'Halifax 3',567,3);

/*
	Inputting data into the passengers table.
	id(bigint), firstName(text), lastName(text), phoneNumber(bigint), home_city(bigint)
	home_city is a fk for the cities table (1-3).
*/
insert into qap_schema.passengers values (1,'John','Johnson',1234567890,1);
insert into qap_schema.passengers values (2,'Tom','Thompson',1234567891,1);
insert into qap_schema.passengers values (3,'Jane','Juniper',1234567892,1);
insert into qap_schema.passengers values (4,'Nancy','Brown',1234567893,1);
insert into qap_schema.passengers values (5,'Stew','Charissa',1234567894,1);
insert into qap_schema.passengers values (6,'Corinna','Nik',1234567895,1);
insert into qap_schema.passengers values (7,'Micky','Katharine',1234567896,2);
insert into qap_schema.passengers values (8,'Angie','Elisabeth',1234567897,2);
insert into qap_schema.passengers values (9,'Andre','Hedley',1234567898,2);
insert into qap_schema.passengers values (10,'Lizzy','Maude',1234567899,3);
insert into qap_schema.passengers values (11,'Norene','Lolicia',1234567810,3);
insert into qap_schema.passengers values (12,'Jeannette','Dillan',1234567820,3);
insert into qap_schema.passengers values (13,'Nathan','Deryck',1234567830,3);
insert into qap_schema.passengers values (14,'Clement','Kendal',1234567840,3);
insert into qap_schema.passengers values (15,'Jaki','Valerie',1234567850,3);
insert into qap_schema.passengers values (16,'Janis','Raynard',1234567860,3);
insert into qap_schema.passengers values (17,'Elvin','Anona',1234567870,3);
insert into qap_schema.passengers values (18,'Stacee','Kylan',1234567880,3);
insert into qap_schema.passengers values (19,'Sophie','Nancy',1234567790,3);
insert into qap_schema.passengers values (20,'Zella','Sonnie',1234567690,3);

/*
	Inputting data into the flights table.
	flight_num(bigint), aircraft(bigint), depart(bigint), arrive(bigint)
	aircraft is a fk for the aircraft table (1-6)
	depart and arrive are fk for the airports table (1-6)
*/
insert into qap_schema.flights values (1,1,1,2);
insert into qap_schema.flights values (2,1,2,3);
insert into qap_schema.flights values (3,2,3,1);
insert into qap_schema.flights values (4,3,5,6);
insert into qap_schema.flights values (5,2,4,3);
insert into qap_schema.flights values (6,4,1,6);
insert into qap_schema.flights values (7,5,6,3);
insert into qap_schema.flights values (8,4,3,5);
insert into qap_schema.flights values (9,6,4,6);
insert into qap_schema.flights values (10,6,5,2);

/*
	Inputting data into the who_flew table.
	flight_num(bigint), passenger(bigint)
	flight_num is a fk for the flights table (1-10)
	passenger is a fk for the passengers table (1-20)
*/
insert into qap_schema.who_flew values (1,1);
insert into qap_schema.who_flew values (1,2);
insert into qap_schema.who_flew values (1,3);
insert into qap_schema.who_flew values (1,4);
insert into qap_schema.who_flew values (1,5);
insert into qap_schema.who_flew values (1,6);
insert into qap_schema.who_flew values (2,7);
insert into qap_schema.who_flew values (2,8);
insert into qap_schema.who_flew values (2,9);
insert into qap_schema.who_flew values (2,10);
insert into qap_schema.who_flew values (2,11);
insert into qap_schema.who_flew values (2,12);
insert into qap_schema.who_flew values (2,13);
insert into qap_schema.who_flew values (2,14);
insert into qap_schema.who_flew values (2,15);
insert into qap_schema.who_flew values (2,16);
insert into qap_schema.who_flew values (2,17);
insert into qap_schema.who_flew values (2,18);
insert into qap_schema.who_flew values (2,19);
insert into qap_schema.who_flew values (2,20);
insert into qap_schema.who_flew values (3,6);
insert into qap_schema.who_flew values (3,7);
insert into qap_schema.who_flew values (3,8);
insert into qap_schema.who_flew values (3,9);
insert into qap_schema.who_flew values (3,10);
insert into qap_schema.who_flew values (3,11);
insert into qap_schema.who_flew values (3,12);
insert into qap_schema.who_flew values (3,13);
insert into qap_schema.who_flew values (3,14);
insert into qap_schema.who_flew values (3,15);
insert into qap_schema.who_flew values (3,16);
insert into qap_schema.who_flew values (3,17);
insert into qap_schema.who_flew values (4,18);
insert into qap_schema.who_flew values (4,19);
insert into qap_schema.who_flew values (4,20);
insert into qap_schema.who_flew values (4,1);
insert into qap_schema.who_flew values (4,2);
insert into qap_schema.who_flew values (4,3);
insert into qap_schema.who_flew values (4,4);
insert into qap_schema.who_flew values (4,5);
insert into qap_schema.who_flew values (4,6);
insert into qap_schema.who_flew values (4,7);
insert into qap_schema.who_flew values (4,8);
insert into qap_schema.who_flew values (4,9);
insert into qap_schema.who_flew values (4,10);
insert into qap_schema.who_flew values (4,11);
insert into qap_schema.who_flew values (4,12);
insert into qap_schema.who_flew values (4,13);
insert into qap_schema.who_flew values (4,14);
insert into qap_schema.who_flew values (5,15);
insert into qap_schema.who_flew values (5,16);
insert into qap_schema.who_flew values (5,17);
insert into qap_schema.who_flew values (5,18);
insert into qap_schema.who_flew values (5,19);
insert into qap_schema.who_flew values (5,20);
insert into qap_schema.who_flew values (5,1);
insert into qap_schema.who_flew values (5,2);
insert into qap_schema.who_flew values (5,3);
insert into qap_schema.who_flew values (5,4);
insert into qap_schema.who_flew values (5,5);
insert into qap_schema.who_flew values (5,6);
insert into qap_schema.who_flew values (5,7);
insert into qap_schema.who_flew values (5,8);
insert into qap_schema.who_flew values (6,9);
insert into qap_schema.who_flew values (6,10);
insert into qap_schema.who_flew values (6,11);
insert into qap_schema.who_flew values (6,12);
insert into qap_schema.who_flew values (6,14);
insert into qap_schema.who_flew values (6,15);
insert into qap_schema.who_flew values (6,17);
insert into qap_schema.who_flew values (6,18);
insert into qap_schema.who_flew values (6,19);
insert into qap_schema.who_flew values (6,1);
insert into qap_schema.who_flew values (6,2);
insert into qap_schema.who_flew values (6,3);
insert into qap_schema.who_flew values (6,5);
insert into qap_schema.who_flew values (6,6);
insert into qap_schema.who_flew values (6,7);
insert into qap_schema.who_flew values (7,9);
insert into qap_schema.who_flew values (7,10);
insert into qap_schema.who_flew values (7,11);
insert into qap_schema.who_flew values (7,12);
insert into qap_schema.who_flew values (7,13);
insert into qap_schema.who_flew values (7,16);
insert into qap_schema.who_flew values (7,17);
insert into qap_schema.who_flew values (7,18);
insert into qap_schema.who_flew values (7,19);
insert into qap_schema.who_flew values (7,1);
insert into qap_schema.who_flew values (7,2);
insert into qap_schema.who_flew values (7,3);
insert into qap_schema.who_flew values (7,6);
insert into qap_schema.who_flew values (7,7);
insert into qap_schema.who_flew values (7,8);
insert into qap_schema.who_flew values (8,9);
insert into qap_schema.who_flew values (8,10);
insert into qap_schema.who_flew values (8,11);
insert into qap_schema.who_flew values (8,12);
insert into qap_schema.who_flew values (8,13);
insert into qap_schema.who_flew values (8,14);
insert into qap_schema.who_flew values (8,15);
insert into qap_schema.who_flew values (8,16);
insert into qap_schema.who_flew values (8,17);
insert into qap_schema.who_flew values (8,18);
insert into qap_schema.who_flew values (8,19);
insert into qap_schema.who_flew values (8,20);
insert into qap_schema.who_flew values (8,1);
insert into qap_schema.who_flew values (8,2);
insert into qap_schema.who_flew values (9,3);
insert into qap_schema.who_flew values (9,4);
insert into qap_schema.who_flew values (9,5);
insert into qap_schema.who_flew values (9,6);
insert into qap_schema.who_flew values (9,8);
insert into qap_schema.who_flew values (9,9);
insert into qap_schema.who_flew values (9,11);
insert into qap_schema.who_flew values (9,14);
insert into qap_schema.who_flew values (9,15);
insert into qap_schema.who_flew values (9,16);
insert into qap_schema.who_flew values (9,19);
insert into qap_schema.who_flew values (9,20);
insert into qap_schema.who_flew values (10,1);
insert into qap_schema.who_flew values (10,3);
insert into qap_schema.who_flew values (10,7);
insert into qap_schema.who_flew values (10,8);
insert into qap_schema.who_flew values (10,11);
insert into qap_schema.who_flew values (10,13);
insert into qap_schema.who_flew values (10,17);
insert into qap_schema.who_flew values (10,18);
insert into qap_schema.who_flew values (10,19);
insert into qap_schema.who_flew values (10,20);

/*
	What airports are in what cities?
*/
select airports."name" from qap_schema.airports where what_city=1;
select airports."name" from qap_schema.airports where what_city=2;
select airports."name" from qap_schema.airports where what_city=3;

/*
    List all aircraft passengers have travelled on.
    (fill in the !!PassengerID!! with any passenger from 1-20)
*/
select passengers."firstName", passengers."lastName", aircraft."airlineName" 
from qap_schema.aircraft, qap_schema.passengers, qap_schema.flights, qap_schema.who_flew 
where flights.aircraft = aircraft.id 
and flights.flight_num = who_flew.flight_num 
and who_flew.passenger = passengers.id
and passengers.id = !!PassengerID!!

/*
    Which airports can aircraft take off from and land at?
	(fill in both !!AirportID!! with any airport from 1-6, making sure they match)
*/
select aircraft."airlineName", airports."name",flights.arrive,flights.depart
from qap_schema.aircraft, qap_schema.airports, qap_schema.flights
where flights.arrive = airports.id
and flights.aircraft = aircraft.id
and aircraft.id = !!AircraftID!!
or flights.depart = airports.id
and flights.aircraft = aircraft.id
and aircraft.id = !!AircraftID!!

/*
    What airports have passengers used?
    (fill in both !!PassengerID!! with any passenger from 1-20, making sure they match)
*/
select passengers."firstName", passengers."lastName", airports."name"
from qap_schema.passengers, qap_schema.airports, qap_schema.flights, qap_schema.who_flew
where flights.flight_num = who_flew.flight_num 
and who_flew.passenger = passengers.id
and passengers.id = !!PassengerID!!
and airports.id = flights.depart 
or flights.flight_num = who_flew.flight_num 
and who_flew.passenger = passengers.id
and passengers.id = !!PassengerID!!
and airports.id = flights.arrive