create or replace function TripParticipants(trip_id int)
    return trip_participant_table
as
    result trip_participant_table;
    valid int;
begin
    select count(*) into valid
        from trip t
        where t.trip_id = TripParticipants.trip_id;
    if valid = 0 then
        raise_application_error(-20001, 'trip not found');
    end if;
    select trip_participant(rs.FIRSTNAME, rs.LASTNAME, rs.STATUS, rs.RESERVATION_ID) bulk collect
    into result
    from RESERVATIONS rs
    join RESERVATION r on r.RESERVATION_ID = rs.RESERVATION_ID
    where r.trip_id = TripParticipants.trip_id;
    return result;
end;

create or replace function PersonReservations(person_id int)
    return person_reservation_table
as
    result person_reservation_table;
    valid int;
begin
    select count(*) into valid
        from PERSON p
        where p.PERSON_ID = PersonReservations.person_id;
    if valid = 0 then
        raise_application_error(-20001, 'person not found');
    end if;
    select person_reservation(rs.COUNTRY, rs.TRIP_NAME,
        rs.TRIP_DATE, rs.RESERVATION_ID, rs.STATUS) bulk collect
    into result
    from RESERVATIONS rs
    join RESERVATION r on r.RESERVATION_ID = rs.RESERVATION_ID
    join PERSON p on p.PERSON_ID = r.PERSON_ID
    where p.PERSON_ID = PersonReservations.person_id;
    return result;
end;

create or replace function FAvailableTrips(country varchar, date_from date, date_to date)
    return available_trips_table
as
    result available_trips_table;
    valid int;
begin
    if FAvailableTrips.date_to < FAvailableTrips.date_from then
        raise_application_error(-20001, 'date_to is earlier from date_from');
    end if;
    select count(*) into valid
        from COUNTRIES c
        where c.COUNTRY = FAvailableTrips.country;
    if valid = 0 then
        raise_application_error(-20001, 'country not found');
    end if;
    select available_trips(t.country, trip_name, trip_date, max_no_places) bulk collect
    into result
    from TRIP t
    where t.country = FAvailableTrips.country
      and trip_date between FAvailableTrips.date_from and FAvailableTrips.date_to;
    return result;
end;
