-- Попытаемся удалить группу Metallica
-- Получим ошибку, т. к. в таблице musucian сработает ограничение
-- FOREIGN KEY(band_id) REFERENCES band ON DELETE RESTRICT
delete from band 
where band_name = 'Metallica'
returning *;


-- Проверка: сколько человек из каких групп занесено в бд,
-- и какие группы еще можно удалять 
-- без предварительного удаления всех участников
select 
	band_name, count(musician_id)
from 
	band
	left join musician using(band_id)
group by band_name
order by 2 desc;