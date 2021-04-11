-- begin isolation level repeatable read;

-- T1, T2, T2; T1 --> no unrepeatable read
-- T1, T3, T3; T1, T1; --> should be phantom read but no (pg) 

-- begin isolation level serializable;

-- T1, T3, T3; T1, T1; --> no phantom read

-- T1
select year_of_foundation, band_name
from band
where year_of_foundation between 1980 and 1990
order by 1, 2;

-- T2
update band
set band_name = 'Red Hot Chili Peppers'
where band_name = 'RHCP'
returning *;

-- T3
insert into band(year_of_foundation, band_name)
values (1987, 'Nirvana')
returning *;

-- T4
delete from band
where band_name = 'KMFDM'
returning *;