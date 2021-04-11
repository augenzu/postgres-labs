-- Оконные функции (over partition)

-- Ддя каждого билета каждого рейса:
-- стоимость билета + 
-- средняя стоимость билета по рейсу +
-- минимальная и максимальная стоимость;
-- цены билетов упорядочены по возрастанию +
-- для каждой цены указан ее номер (в списке по возрастанию)

select	
	flight_no,
	amount,
	dense_rank() over w,
	count(*) over w,
	--avg(amount) over w avg_amount,  
		-- can`t round avg - error: not a window function
	min(amount) over w min_amount,
	max(amount) over w max_amount
from 
	flights
		join ticket_flights using(flight_id)
window w as (
		partition by flight_no
		order by amount range between
			unbounded preceding and unbounded following
)
order by 1 desc, 2
limit 1000;












