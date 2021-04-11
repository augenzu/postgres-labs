-- В каких жанрах играет группа Marilyn Manson
select 
	genre_name
from
	genre
	natural join band_genre
	natural join band
where band_name = 'Marilyn Manson'
order by 1;