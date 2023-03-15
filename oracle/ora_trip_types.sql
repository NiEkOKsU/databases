create or replace type trip_participant as OBJECT
(
    FIRSTNAME varchar(50),
    LASTNAME varchar(50),
    STATUS char(1),
    RESERVATION_ID int
);
create or replace type trip_participant_table is table of trip_participant;

create or replace type person_reservation as OBJECT
(
    country varchar(50),
    trip_name varchar(50),
    trip_date date,
    RESERVATION_ID int,
    STATUS char(1)
);
create or replace type person_reservation_table is table of person_reservation;

create or replace type available_trips as OBJECT
(
    country varchar(50),
    trip_name varchar(50),
    trip_date date,
    max_no_places int
);
create or replace type available_trips_table is table of available_trips;
