-- task2 

select
	passenger_name, actual_departure
from
	tickets
		join ticket_flights using(ticket_no)
			join flights flt using(flight_id)
				join airports air on air.airport_code = flt.arrival_airport
where
	city = 'Москва' and
		passenger_name ~~ '%PETROV' and
			actual_departure::date = date '2017-08-14'
order by 1;
	