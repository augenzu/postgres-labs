-- Попытаемся заменить организатора фестов Rock in Rio на несуществующего (org_id = 100500)
-- => получим ошибку из-за ограничения FK в таблице fest_org 
update fest_organizer 
set organizer_id = 100500
where fest_id in (
	select fest_id 
	from fest 
	where fest_name ~~ 'Rock in Rio%' 
)
returning *;


-- То же самое, с использованием FROM
update fest_organizer fo
set organizer_id = 100500
from fest f
where
	fo.fest_id = f.fest_id 
	and fest_name ~~ 'Rock in Rio%'
returning fest_name, fo.fest_id, fo.organizer_id;


-- Сделаем организатором всех фестов Rock in Rio Тревора Хоффмана
-- (делаем то же самое, что и в двух предыдущих запросах,
-- только теперь используем существующего организатора)
update fest_organizer 
set organizer_id = (
	select organizer_id
	from organizer 
	where organizer_name = 'Trevor Hoffman'
)
where fest_id in (
	select fest_id 
	from fest 
	where fest_name ~~ 'Rock in Rio%' 
)
returning *;


-- И то же самое с использованием FROM,
-- чтобы выдавалось больше информации
update fest_organizer fo
set organizer_id = (
	select organizer_id
	from organizer 
	where organizer_name = 'Trevor Hoffman'
)
from fest f
where
	fo.fest_id = f.fest_id 
	and fest_name ~~ 'Rock in Rio%'
returning fest_name, fo.fest_id, fo.organizer_id;


-- Проверка (до и после изменений): какие организаторы какие фесты проводят
select 
	organizer_name, organizer_id,
	fest_id, fest_name
from 
	organizer
	natural join fest_organizer
	natural join fest
order by 1, 4, 3;