-- query to optimize
explain (analyze true, buffers true)
select *
from fest
where prices @> array[30, 100, 170];


-- without indexes

set enable_indexscan = off;
set enable_bitmapscan = off;

--                                                   QUERY PLAN                                                  
-- --------------------------------------------------------------------------------------------------------------
--  Seq Scan on fest  (cost=0.00..39528.00 rows=64688 width=187) (actual time=0.064..253.425 rows=52859 loops=1)
--    Filter: (prices @> '{30,100,170}'::integer[])
--    Rows Removed by Filter: 947141
--    Buffers: shared hit=320 read=26708
--  Planning Time: 0.155 ms
--  Execution Time: 255.214 ms


set enable_indexscan = on;
set enable_bitmapscan = on;

create index fest_prices_gin_idx on fest using gin (prices);

-- faster by about 2 times
--                                                                QUERY PLAN                                                               
-- ----------------------------------------------------------------------------------------------------------------------------------------
--  Bitmap Heap Scan on fest  (cost=857.33..28693.93 rows=64688 width=187) (actual time=49.697..132.365 rows=52859 loops=1)
--    Recheck Cond: (prices @> '{30,100,170}'::integer[])
--    Heap Blocks: exact=23410
--    Buffers: shared hit=242 read=23410
--    ->  Bitmap Index Scan on fest_prices_gin_idx  (cost=0.00..841.16 rows=64688 width=0) (actual time=45.942..45.942 rows=52859 loops=1)
--          Index Cond: (prices @> '{30,100,170}'::integer[])
--          Buffers: shared hit=242
--  Planning Time: 0.219 ms
--  Execution Time: 134.254 ms