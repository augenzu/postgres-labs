drop view tmp;

create or replace view tmp as
select 
	fest_name,
	fest_date,
	count(*)
from fest
group by fest_name, fest_date;

select * from tmp;

select 
	fest_name, fest_date, 
	sum("count") over (
		partition by extract(year from fest_date) order by fest_date
		range between unbounded preceding and current row
	)
from tmp;