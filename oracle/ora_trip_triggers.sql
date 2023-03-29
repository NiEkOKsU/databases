create or replace trigger tr_update_log
    after insert or update
    on RESERVATION
    for each row
begin
    insert into log(RESERVATION_ID, LOG_DATE, STATUS)
    values (:new.reservation_id, current_date, :new.status);
end;

create or replace trigger tr_dell_log
    before delete
    on RESERVATION
    for each row
begin
    raise_application_error(-20001, 'reservation cant be deleted');
end;

create or replace trigger tr_controll_places_add
    before insert
    on RESERVATION
    for each row
declare
    is_avilable int;
begin
    select 1 into is_avilable from AVAILABLETRIPS A where A.TRIP_ID = :new.TRIP_ID;
    if(is_avilable != 1) then
        raise_application_error(-20001, 'trip is not available');
    end if;
end;

create or replace trigger tr_controll_places_update
    before update
    on RESERVATION
    for each row
declare
    is_avilable int;
begin
    if (:old.status = 'C' and :new.status in ('P', 'N')) then
        select 1 into is_avilable from AVAILABLETRIPS A where A.TRIP_ID = :new.TRIP_ID;
        if(is_avilable != 1) then
            raise_application_error(-20001, 'trip is not available');
        end if;
    end if;
end;

create or replace trigger tr_add_trip
    after insert
    on RESERVATION
    for each row
declare
    no_places int;
begin
    select NO_AVAILABLE_PLACES into no_places from TRIP t where t.TRIP_ID = :new.TRIP_ID;
    update TRIP
    set no_available_places = no_places - 1
    where TRIP_ID = :new.trip_id;
end;

create or replace trigger tr_update_trip
    after update
    on RESERVATION
    for each row
declare
    no_places int;
begin
    select NO_AVAILABLE_PLACES into no_places from TRIP t where t.TRIP_ID = :new.TRIP_ID;
    if (:old.status = 'C' and :new.status in ('P', 'N')) then
        update TRIP
        set no_available_places = no_places - 1
        where TRIP_ID = :new.trip_id;
    end if;
    if(:new.status = 'C' and :old.status in ('P', 'N')) then
        update TRIP
        set no_available_places = no_places + 1
        where TRIP_ID = :new.trip_id;
    end if;
end;

create or replace trigger tr_trip_av_places
    after insert
    on Trip
    for each row
begin
    count_no_av_places(:new.TRIP_ID);
end;

create or replace trigger tr_trip_av_places_update
    before update of MAX_NO_PLACES
    on Trip
    for each row
begin
    if(:new.MAX_NO_PLACES < :old.MAX_NO_PLACES and :old.MAX_NO_PLACES - :new.MAX_NO_PLACES > :old.NO_AVAILABLE_PLACES) then
        raise_application_error(-20001, 'You cant reduce places as much as you try');
    end if;
end;

