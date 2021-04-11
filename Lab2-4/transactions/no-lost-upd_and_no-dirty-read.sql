-- begin isolation level read uncommitted;

-- T1-1, T2, T1-1, T1-2(=> wait), T2; T1-2(update 0), T1;
--            |                          |
--            |                          |
--  should be dirty read but no (pg)     |
--                                  no lost update

-- T1-1
select year_of_foundation, band_name
from band
where year_of_foundation between 1980 and 1990
order by 1, 2;

-- T2
update band
set band_name = 'RHCP'
where band_name = 'Red Hot Chili Peppers'
returning *;

-- T1-2
update band
set band_name = 'RedHotChiliPeppers'
where band_name = 'Red Hot Chili Peppers'
returning *;
