-- begin; -- any isolation level

-- T!-1, T2-1, T1-2, T2-2
--                    |
--                    |
--          error: deadlock detected

-- T1-1
update band set band_name = 'RHCP'
where band_name = 'Red Hot Chili Peppers';
-- T1-2
update band set band_name = 'SOAD'
where band_name = 'System of a Down';

-- T2-1 = T1-2
-- T2-2 = T1-1