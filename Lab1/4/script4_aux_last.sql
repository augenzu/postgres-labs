-- Рекурсивный запрос
-- хз как, мб что-то типа истории путешествий какого-либо
-- конкретного чела, типа:
-- Москва -> Владивосток -> Калининград -> ... -> Москва/неМосква
-- плюс, каждый город уникален (вернее, уникально сочетание аэропорт + дата)

--drop view many_flights;

create or replace view many_flights as
	select 
		passenger_name, 
		count(ticket_no) flights_cnt
	from Tickets
	group by passenger_name
	order by 2 desc, 2
	limit 1 /*offset 2*/;
	
select * from many_flights;

create or replace view flights_of_alex_ivanov as
	select
		passenger_name,
		departure_airport,
		arrival_airport,
		actual_departure,
		actual_arrival
	from
		Tickets
		join Ticket_flights using(ticket_no)
		join Flights using(flight_id)
	where
		passenger_name = (
			select passenger_name from many_flights
		) and
		actual_departure is not null;
		
select  
	passenger_name,
	departure_airport,
	arrival_airport,
	actual_departure,
	actual_arrival
from flights_of_alex_ivanov
order by actual_departure;

select min(actual_departure)
from flights_of_alex_ivanov

--- TRY --------------------------------------------------------

with recursive travel_of_alex_ivanov as (
	select 
		passenger_name,
		departure_airport,
		arrival_airport,
		actual_departure,
		actual_arrival
	from flights_of_alex_ivanov
	where
		actual_departure = (
			select min(actual_departure)
			from flights_of_alex_ivanov
		)
	union all
		select
			tr.passenger_name,
			tr.departure_airport,
			tr.arrival_airport,
			tr.actual_departure,
			tr.actual_arrival
		from
			flights_of_alex_ivanov fl
			join travel_of_alex_ivanov tr
				on fl.departure_airport == tr.arrival_airport and
					fl.actual_departure >= tr.actual_arrival
)
select * from travel_of_alex_ivanov;
	