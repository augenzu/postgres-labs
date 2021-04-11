-- except all

-- Выбираем самолеты, в которых > 100 мест,
-- кроме тех, которые совершили более 2000 рейсов
select
	aircraft_code
from seats
group by aircraft_code
having count(seat_no) > 100
except all
select
	aircraft_code
from 
	aircrafts left join
		flights using(aircraft_code)
group by aircraft_code
having count(actual_departure) > 2000
order by 1;



-- Check query 
select
	aircraft_code,
	count(distinct seat_no) seat_cnt,
	count(distinct actual_departure) flights_cnt
from 
	(seats
		join aircrafts using(aircraft_code))
			left join flights using(aircraft_code)
group by aircraft_code
order by 1;
