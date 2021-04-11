begin;

-- Абсолютно любые команды, НЕ пытающиеся изменить band_id в таблице band
-- (чтобы показать, что они потом тоже откатятся)
delete from band where band_name = 'UFO' returning *;
-- savepoint everythings_fine;

-- команда, пытающаяся изменить band_id в band - 
-- приведет к откату всей транзакции (или до savepoint-а)
update band set band_id = 100500 where band_name = 'Rammstein';

commit;