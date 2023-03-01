-- countries

insert into countries(country)
values ('Polska');

insert into countries(country)
values ('Francja');

-- trip

insert into trip(trip_name, country, trip_date, max_no_places)
values ('Wycieczka do Paryza', 'Francja', to_date('2022-09-12','YYYY-MM-DD'), 3);

insert into trip(trip_name, country, trip_date,  max_no_places)
values ('Piękny Kraków', 'Polska', to_date('2023-07-03','YYYY-MM-DD'), 10);

insert into trip(trip_name, country, trip_date,  max_no_places)
values ('Znów do Francji', 'Francja', to_date('2023-05-01','YYYY-MM-DD'), 15);

insert into trip(trip_name, country, trip_date,  max_no_places)
values ('Hel', 'Polska', to_date('2023-01-01','YYYY-MM-DD'), 8);

-- person

insert into person(firstname, lastname)
values ('Jan', 'Nowak');

insert into person(firstname, lastname)
values ('Jan', 'Kowalski');

insert into person(firstname, lastname)
values ('Jan', 'Nowakowski');

insert into person(firstname, lastname)
values ('Adam', 'Kowalski');

insert into person(firstname, lastname)
values  ('Novak', 'Nowak');

insert into person(firstname, lastname)
values ('Piotr', 'Piotrowski');

insert into person(firstname, lastname)
values ('Robert', 'Lewandowski');

insert into person(firstname, lastname)
values ('Adam', 'Malysz');

insert into person(firstname, lastname)
values  ('Wojciech', 'Kowalczyk');

insert into person(firstname, lastname)
values ('Stanisław', 'Wokulski');

-- reservation
-- trip 1
insert into reservation(trip_id, person_id, status)
values (1, 1, 'P');

insert into reservation(trip_id, person_id, status)
values (1, 2, 'N');

-- trip 2
insert into reservation(trip_id, person_id, status)
values (2, 1, 'P');

insert into reservation(trip_id, person_id, status)
values (2, 4, 'C');

-- trip 3
insert into reservation(trip_id, person_id, status)
values (2, 4, 'P');

insert into reservation(trip_id, person_id, status)
values (3, 7, 'N');

insert into reservation(trip_id, person_id, status)
values (3, 8, 'N');

-- trip 4
insert into reservation(trip_id, person_id, status)
values (4, 2, 'P');

insert into reservation(trip_id, person_id, status)
values (4, 8, 'C');

insert into reservation(trip_id, person_id, status)
values (4, 9, 'P');

