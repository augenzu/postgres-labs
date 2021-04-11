-- Рекурсивные функции

-- Выберем самолет, совершивший максимальное количество рейсов
-- (чтобы маршрут получился длиннее)
-- (а вообще, можно любой другой самолет взять, кромет того, у которого 0 рейсов)
select
	aircraft_code,
	count(flight_id) count_of_flights
from Flights 
group by aircraft_code
order by 2 desc
limit 1;
-- - это CN1


-- Построим таблицу, содержащую информацию обо всех 
-- состоявшихся ('actual_departure is not null') полетах CN1
create or replace view cn1_flights as
	select
		aircraft_code,
		flight_no,
		departure_airport,
		arrival_airport,
		actual_departure,
		actual_arrival
	from Flights
	where 
		aircraft_code ~~ 'CN1' and
		actual_departure is not null;
		
select *
from cn1_flights
order by actual_departure;


-- Построим возможный маршрут CN1,
-- начиная с минимальной даты отправления
with recursive route as (
	select 
		aircraft_code,
		flight_no,
		departure_airport,
		arrival_airport,
		actual_departure,
		actual_arrival
	from cn1_flights
	where 
		actual_departure in (
			select min(actual_departure)
			from cn1_flights
		)
	union all
		select 
			cn1.aircraft_code,
			cn1.flight_no,
			cn1.departure_airport,
			cn1.arrival_airport,
			cn1.actual_departure,
			cn1.actual_arrival
		from
			cn1_flights cn1
			join route rt
				on 
					cn1.actual_departure::date = rt.actual_arrival::date and
					cn1.actual_departure >= rt.actual_arrival and
					cn1.departure_airport ~~ rt.arrival_airport
)
select * from route
limit 10;

-- Проблема в том, что получается ни разу не маршрут,
-- (( а что тогда? *дерево* маршрутов? - походу, что-то типа этого ))
-- так как рекурсия в запросе тоже не рекурсия,
-- а итерационный процесс.
-- Это лучше заметно, если вывести не 10 строк, а, например, 100 - 
-- там будет ~5 одинаковых строк подряд
-- (типа CNN -> MJZ, CNN -> MJZ, ... CNN -> MJZ,
-- а не чередующиеся CNN -> MJZ, MJZ -> CNN, ...)