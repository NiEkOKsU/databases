create or replace procedure AddReservation(p_trip_id int, p_pers_id int)
as
    is_person char(1);
    are_trip_ok char(1);
begin
    select 1 into are_trip_ok from AVAILABLETRIPS
                  where TRIP_ID = p_trip_id and TRIP_DATE > current_date;
    select 1 into is_person from PERSON where PERSON_ID = p_pers_id;
    insert into RESERVATION(trip_id, person_id, status)
    values (p_trip_id, p_pers_id, 'N');
exception
    when NO_DATA_FOUND then
        raise_application_error(-20001, 'incorrect data');
end;

create or replace procedure modify_reservation_status(p_reservation_id int, p_status char)
as
    tmp char(1);
    av_places int;
begin
    select 1 into tmp from reservation where reservation_id = p_reservation_id;
    if p_status not in ('N', 'P', 'C') then
        raise_application_error(-20002, 'wrong status');
    end if;
    select NO_AVILABLE_PLACES into av_places from TRIPS T join RESERVATION R on R.TRIP_ID = T.TRIP_ID
        where RESERVATION_ID = p_reservation_id;
    if p_status = 'C' and av_places = 0 then
        raise_application_error(-20002, 'not enought places');
    end if;
    update reservation
    set status = p_status
    where reservation_id = p_reservation_id;
exception
    when NO_DATA_FOUND then
        raise_application_error(-20001, 'reservation not found');
end;

create or replace procedure modify_no_places(p_trip_id int, no_places int)
as
    tmp char(1);
    min_places int;
begin
    select 1 into tmp from TRIP where TRIP_ID = p_trip_id;
    select T.no_places - NO_AVILABLE_PLACES into min_places from TRIPS T where TRIP_ID = p_trip_id;
    if min_places > no_places then
        raise_application_error(-20002, 'not enought places');
    end if;
    update TRIP
    set MAX_NO_PLACES = no_places
    where TRIP_ID = p_trip_id;
end;

begin
    AddReservation( 2, 2);
    commit;
end;

begin
    modify_reservation_status( 1, 'N');
    commit;
end;

begin
    modify_no_places( 1, 3);
    commit;
end;