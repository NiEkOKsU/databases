create or replace procedure AddReservation(p_trip_id int, p_pers_id int)
as
    is_person char(1);
    are_trip_ok char(1);
    max_id int;
begin
    select 1 into is_person from PERSON where PERSON_ID = p_pers_id;
    select 1 into are_trip_ok from AVAILABLETRIPS
                  where TRIP_ID = p_trip_id and TRIP_DATE > current_date;
    insert into RESERVATION(trip_id, person_id, status)
    values (p_trip_id, p_pers_id, 'N');
    select max(RESERVATION_ID) into max_id from RESERVATION where PERSON_ID = p_pers_id and trip_id = p_trip_id;
    insert into log(reservation_id, log_date, status)
    values (max_id, current_date, 'N');
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
    if p_status in ('N', 'P') and av_places = 0 then
        raise_application_error(-20002, 'not enought places');
    end if;
    update reservation
    set status = p_status
    where reservation_id = p_reservation_id;
    insert into log(reservation_id, log_date, status)
        values (p_reservation_id, current_date, p_status);
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
    AddReservation( 2, 7);
    commit;
end;

begin
    modify_reservation_status( 82, 'P');
    commit;
end;

begin
    modify_no_places( 1, 4);
    commit;
end;

create or replace procedure AddReservation2(p_trip_id int, p_pers_id int)
as
    is_person char(1);
    are_trip_ok char(1);
begin
    select 1 into is_person from PERSON where PERSON_ID = p_pers_id;
    select 1 into are_trip_ok from AVAILABLETRIPS
                  where TRIP_ID = p_trip_id and TRIP_DATE > current_date;
    insert into RESERVATION(trip_id, person_id, status)
    values (p_trip_id, p_pers_id, 'N');
exception
    when NO_DATA_FOUND then
        raise_application_error(-20001, 'incorrect data');
end;

begin
    AddReservation2( 3, 2);
    commit;
end;

create or replace procedure modify_reservation_status2(p_reservation_id int, p_status char)
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
    if p_status in ('N', 'P') and av_places = 0 then
        raise_application_error(-20002, 'not enought places');
    end if;
    update reservation
    set status = p_status
    where reservation_id = p_reservation_id;
exception
    when NO_DATA_FOUND then
        raise_application_error(-20001, 'reservation not found');
end;

begin
    modify_reservation_status2( 101, 'P');
    commit;
end;

create or replace procedure AddReservation3(p_trip_id int, p_pers_id int)
as
    is_person char(1);
begin
    select 1 into is_person from PERSON where PERSON_ID = p_pers_id;
    insert into RESERVATION(trip_id, person_id, status)
    values (p_trip_id, p_pers_id, 'N');
exception
    when NO_DATA_FOUND then
        raise_application_error(-20001, 'incorrect data');
end;

begin
    AddReservation3( 1, 8);
    commit;
end;

create or replace procedure modify_reservation_status3(p_reservation_id int, p_status char)
as
    tmp char(1);
begin
    select 1 into tmp from reservation where reservation_id = p_reservation_id;
    if p_status not in ('N', 'P', 'C') then
        raise_application_error(-20002, 'wrong status');
    end if;
    update reservation
    set status = p_status
    where reservation_id = p_reservation_id;
exception
    when NO_DATA_FOUND then
        raise_application_error(-20001, 'reservation not found');
end;

begin
    modify_reservation_status3( 123, 'P');
    commit;
end;

create or replace procedure count_no_av_places(trip_id int)
as
    tmp int;
    no_places int;
begin
    select 1 into tmp from TRIP T where T.TRIP_ID = count_no_av_places.trip_id;
    if(tmp != 1) then
        raise_application_error(-20002, 'wrong trip id');
    end if;
    select MAX_NO_PLACES - (select count(*) from RESERVATION R where
        R.TRIP_ID = T.TRIP_ID and R.STATUS != 'C')
        into no_places from TRIP T where T.TRIP_ID = count_no_av_places.trip_id;
    update TRIP
    set no_available_places = no_places
    where TRIP_ID = count_no_av_places.trip_id;
exception
    when NO_DATA_FOUND then
        raise_application_error(-20001, 'reservation not found');
end;

begin
    count_no_av_places( 4);
    commit;
end;

create or replace procedure AddReservation4(p_trip_id int, p_pers_id int)
as
    is_person char(1);
begin
    select 1 into is_person from PERSON where PERSON_ID = p_pers_id;
    insert into RESERVATION(trip_id, person_id, status)
    values (p_trip_id, p_pers_id, 'N');
    count_no_av_places(p_trip_id);
exception
    when NO_DATA_FOUND then
        raise_application_error(-20001, 'incorrect data');
end;

begin
    AddReservation4( 3, 2);
    commit;
end;

create or replace procedure modify_reservation_status4(p_reservation_id int, p_status char)
as
    tmp char(1);
    p_trip_id int;
begin
    select 1 into tmp from reservation where reservation_id = p_reservation_id;
    if p_status not in ('N', 'P', 'C') then
        raise_application_error(-20002, 'wrong status');
    end if;
    update reservation
    set status = p_status
    where reservation_id = p_reservation_id;
    select TRIP_ID into p_trip_id from RESERVATION where reservation_id = p_reservation_id;
    count_no_av_places(p_trip_id);
exception
    when NO_DATA_FOUND then
        raise_application_error(-20001, 'reservation not found');
end;

begin
    modify_reservation_status4( 142, 'C');
    commit;
end;

create or replace procedure modify_no_places4(p_trip_id int, no_places int)
as
    tmp char(1);
    min_places int;
begin
    select 1 into tmp from TRIP where TRIP_ID = p_trip_id;
    select no_places - NO_AVAILABLE_PLACES into min_places from TRIP where TRIP_ID = p_trip_id;
    if min_places > no_places then
        raise_application_error(-20002, 'not enought places');
    end if;
    update TRIP
    set MAX_NO_PLACES = no_places
    where TRIP_ID = p_trip_id;
    count_no_av_places(p_trip_id);
end;

begin
    modify_no_places4( 3, 5);
    commit;
end;

create or replace procedure AddReservation5(p_trip_id int, p_pers_id int)
as
    is_person char(1);
begin
    select 1 into is_person from PERSON where PERSON_ID = p_pers_id;
    insert into RESERVATION(trip_id, person_id, status)
    values (p_trip_id, p_pers_id, 'N');
exception
    when NO_DATA_FOUND then
        raise_application_error(-20001, 'incorrect data');
end;

begin
    AddReservation5( 2, 9);
    commit;
end;

create or replace procedure modify_reservation_status5(p_reservation_id int, p_status char)
as
    tmp char(1);
    p_trip_id int;
begin
    select 1 into tmp from reservation where reservation_id = p_reservation_id;
    if p_status not in ('N', 'P', 'C') then
        raise_application_error(-20002, 'wrong status');
    end if;
    update reservation
    set status = p_status
    where reservation_id = p_reservation_id;
    select TRIP_ID into p_trip_id from RESERVATION where reservation_id = p_reservation_id;
exception
    when NO_DATA_FOUND then
        raise_application_error(-20001, 'reservation not found');
end;

begin
    modify_reservation_status5( 172, 'C');
    commit;
end;

create or replace procedure modify_no_places5(p_trip_id int, no_places int)
as
    tmp char(1);
begin
    select 1 into tmp from TRIP where TRIP_ID = p_trip_id;
    update TRIP
    set MAX_NO_PLACES = no_places
    where TRIP_ID = p_trip_id;
    count_no_av_places(p_trip_id);
end;

begin
    modify_no_places5( 3, 3);
    commit;
end;





