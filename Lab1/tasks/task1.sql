-- task 1

select
	distinct a2.arrival_airport
from
	flights a1
		join flights a2 on a1.arrival_airport = a2.departure_airport
where a1.departure_airport = 'VVO'
union
select
	distinct a3.arrival_airport
from
	flights a1
		join flights a2 on a1.arrival_airport = a2.departure_airport
			join flights a3 on a2.arrival_airport = a3.departure_airport
where a1.departure_airport = 'VVO'
order by 1;
