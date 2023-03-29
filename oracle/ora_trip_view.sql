CREATE OR REPLACE VIEW Reservations AS
    SELECT country, trip_name, trip_date, FIRSTNAME, LASTNAME, RESERVATION_ID, STATUS
    FROM RESERVATION R
    inner join TRIP T on T.TRIP_ID = R.TRIP_ID
    inner join PERSON P on P.PERSON_ID = R.PERSON_ID
;

CREATE OR REPLACE VIEW Trips AS
    SELECT T.TRIP_ID, T.country, T.trip_name, T.trip_date, MAX_NO_PLACES no_places,
           MAX_NO_PLACES - (select count(*) from RESERVATION where
           RESERVATION.TRIP_ID = T.TRIP_ID and RESERVATION.STATUS != 'C') no_avilable_places
    from TRIP T
;

CREATE OR REPLACE VIEW AvailableTrips AS
    SELECT TRIP_ID, country, trip_name, trip_date, no_places, no_avilable_places
    FROM Trips
    where no_avilable_places > 0 and current_date < trip_date
;

CREATE OR REPLACE VIEW Trips4 AS
    SELECT T.TRIP_ID, T.country, T.trip_name, T.trip_date, MAX_NO_PLACES no_places, NO_AVAILABLE_PLACES
    from TRIP T
;

CREATE OR REPLACE VIEW AvailableTrips4 AS
    SELECT TRIP_ID, country, trip_name, trip_date, no_places, NO_AVAILABLE_PLACES
    FROM Trips4
    where NO_AVAILABLE_PLACES > 0 and current_date < trip_date
;

