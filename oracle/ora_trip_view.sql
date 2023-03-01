CREATE OR REPLACE VIEW Reservations AS
    SELECT country, trip_name, trip_date, FIRSTNAME, LASTNAME, RESERVATION_ID, STATUS
    FROM RESERVATION R
    inner join TRIP T on T.TRIP_ID = R.TRIP_ID
    inner join PERSON P on P.PERSON_ID = R.PERSON_ID
;

CREATE OR REPLACE VIEW Trips AS
    SELECT T.country, T.trip_name, T.trip_date,
           (select count(*) from RESERVATION where
            RESERVATION.TRIP_ID = T.TRIP_ID and RESERVATION.STATUS != 'C') no_places,
           MAX_NO_PLACES - (select count(*) from RESERVATION where
            RESERVATION.TRIP_ID = T.TRIP_ID and RESERVATION.STATUS != 'C') avilable_no_places
    from TRIP T