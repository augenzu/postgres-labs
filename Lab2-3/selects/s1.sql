-- На каких фестивалях, проводившихся в период с 2013 по 2017,
-- на которых были представлены жанры NDH и industrial metal
select distinct fest_id, fest_name, fest_date
from 
	fest
	natural join performance 
	natural join band
	natural join band_genre
	natural join genre
where 
	extract(year from fest_date) >= 2013
	and extract(year from fest_date) <= 2017
	and genre_name in ('NDH', 'industrial metal')
order by 2;


-- Проверка 
select 
	distinct fest_id, fest_name, fest_date , genre_name
from 
	fest
	natural join performance 
	natural join band
	natural join band_genre
	natural join genre
order by 1, 2, 3, 4;
	
	
	
	