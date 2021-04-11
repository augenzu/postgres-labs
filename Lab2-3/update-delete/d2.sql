-- Удалим места, в которых не проводилось ни одного фестиваля
delete from place 
where not exists (
	select 1
	from fest
	where place_id = place.place_id 
)
returning *;

