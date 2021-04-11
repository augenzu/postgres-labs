-- Агрегатные функции

select
	aircraft_code
from aircrafts;

-- Для каждой модели самолета выводим:
-- количество различных рейсов, в которых она была (distinct),
-- и полное количество рейсов для нее (!distinct)
create or replace view counts_of_flights as
	select
		aircraft_code, 
		count(distinct flight_no) count_of_dist_flights,
		count(flight_no) total_count_of_flights
	from 
		aircrafts left join
			flights using(aircraft_code)
	group by aircraft_code;
	
select * from counts_of_flights
order by aircraft_code;


-- Минимальное, максимальное и среднее
-- количество различных рейсов для всех самолетов
select
	min(count_of_dist_flights) min_cnt,
	max(count_of_dist_flights) max_cnt,
	round(avg(count_of_dist_flights)) avg_cnt
from counts_of_flights;


-- Минимальное НЕНУЛЕВОЕ, максимальное и среднее
-- количество различных рейсов для всех самолетов
with min_not_zero as (
	select
		case
			when count_of_dist_flights != 0
				then count_of_dist_flights
			else (
				select max(count_of_dist_flights)
				from counts_of_flights
			)
		end
	from counts_of_flights
)

select
	min(
		select * from min_not_zero
	) min_cnt,
	max(count_of_dist_flights) max_cnt,
	round(avg(count_of_dist_flights)) avg_cnt
from counts_of_flights;




