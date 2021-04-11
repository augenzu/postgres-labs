-- Для каждого билета каждого рейса выводим:
-- номер рейс,
-- цена билета, ее номер в списке по возрастанию,
-- минимальная и максимальная цены билетов рейса,
-- количество билетов, проданных на данный рейс;
-- номера рейсов упорядочены в обратном алфавитном порядке
-- цены билетов упорядочены по возрастанию для каждого рейса

select	
	flight_no,
	amount,
	dense_rank() over w,
	first_value(amount) over w min_amount,
	last_value(amount) over w max_amount,
	count(*) over w count_of_tickets
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
