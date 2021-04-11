-- Вспомогательное представление
-- Какие организаторы с какими группами сколько раз работали
create or replace view org_band as
	select 
		organizer_name, band_name, count(distinct fest_date) times
	from 
		organizer
		natural join fest_organizer
		natural join fest
		natural join performance
		natural join band
	group by organizer_name, band_name;

--select * from org_band
--order by 1, 2, 3;


-- Статистика
select 	
	organizer_name, band_name, sum(times)
from org_band 
group by rollup(organizer_name, band_name);


-- Сколько раз работал организатор Roberto Medina с каждой группой
select 
	band_name, times
from 
	org_band 
where organizer_name ~~ 'Roberto Medina' 
order by 2 desc, 1;


-- С какими группами организатор Roberto Medina работал чаще всего
select 
	band_name, times
from 
	org_band
where 
	organizer_name ~~ 'Roberto Medina'
	and times = (
		select 
			max(times)
		from 
			org_band 
		where organizer_name ~~ 'Roberto Medina'
	);


-- С какими группами и когда работал организатор Roberto Medina
select 
	distinct band_name, extract(year from fest_date)
from 
	organizer
	natural join fest_organizer
	natural join fest
	natural join performance
	natural join band
where organizer_name ~~ 'Roberto Medina'
order by 1, 2;