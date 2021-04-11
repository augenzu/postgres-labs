-- Вспомогательная таблица
-- города, в которых 2+ аэропорта
create or replace view cities as
	select city
	from Airports
	group by city
	having count(airport_name) > 1;

-- Для пассажиров, которые летят между городами из cities, выбираем
-- имя, аэропорты отправления и прибытия,
-- запланированное время отправления и задержку рейса;
-- выбираем только те записи, где задержка лежит на отрезке [2min, 4 min]
select
	passenger_name,
	departure_airport,
	arrival_airport,
	scheduled_departure,
	(actual_departure - scheduled_departure) flight_delay
from 
	Tickets
	join Ticket_flights using(ticket_no)
	join Flights using(flight_id)
	join Airports A_dep on departure_airport = A_dep.airport_code
	join Airports A_arr on arrival_airport = A_arr.airport_code
where 
	A_dep.city in (select city from cities) and
	A_arr.city in (select city from cities) and 
	actual_departure is not null and
	actual_arrival is not null and
	(actual_departure - scheduled_departure)
		between interval '2'minute and interval '4'minute
order by passenger_name;
