-- Какие группы играют в самом популярном жанре
select 
	band_name, genre_name
from
	genre
	natural join band_genre
	natural join band
where
	genre_id = (
		select 	
			genre_id
		from
			genre
			left join band_genre using(genre_id)
			left join band using(band_id)
		group by genre_id 
		order by count(band_id) desc
		limit 1
	)
order by 1;




