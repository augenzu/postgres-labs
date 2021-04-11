-- begin isolation level read committed;

-- T1, T2, T1, T2; T1, T1;
--          |       |
--          |       | 
--   no dirty read  |
--           unrepeatable read

-- T1
select year_of_foundation, band_name
from band
where year_of_foundation between 1980 and 1990
order by 1, 2;

--T2
update band
set band_name = 'RHCP'
where band_name = 'Red Hot Chili Peppers'
returning *;

--T3 -> to PHANTOM READ, not UNREPEATABLE READ!
insert into band(year_of_foundation, band_name)
values (1985, 'Guns N'' Roses');

--T4
delete from band
where band_name = 'Guns N'' Roses'
returning *;

--T5 
select count(*)
from band
where year_of_foundation between 1980 and 1990;