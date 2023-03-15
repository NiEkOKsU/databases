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

end;
