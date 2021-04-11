-- query to optimize
explain (analyze true, buffers true)
select * from customer
where (customer_info->'age')::int between 25 and 35;


set enable_indexscan = off;
set enable_bitmapscan = off;

-- without indexes
--                                                            QUERY PLAN                                                           
-- --------------------------------------------------------------------------------------------------------------------------------
--  Gather  (cost=1000.00..36916.67 rows=5000 width=170) (actual time=0.492..273.218 rows=216311 loops=1)
--    Workers Planned: 2
--    Workers Launched: 2
--    Buffers: shared hit=353 read=24647
--    ->  Parallel Seq Scan on customer  (cost=0.00..35416.67 rows=2083 width=170) (actual time=0.031..218.152 rows=72104 loops=3)
--          Filter: ((((customer_info -> 'age'::text))::integer >= 25) AND (((customer_info -> 'age'::text))::integer <= 35))
--          Rows Removed by Filter: 261230
--          Buffers: shared hit=353 read=24647
--  Planning Time: 0.091 ms
--  Execution Time: 281.373 ms


set enable_indexscan = on;
set enable_bitmapscan = on;

create index customer_customer_info_age on customer(((customer_info->'age')::int));

-- faster by about 2 times
--                                                                   QUERY PLAN                                                                   
-- -----------------------------------------------------------------------------------------------------------------------------------------------
--  Bitmap Heap Scan on customer  (cost=107.67..12601.06 rows=5000 width=170) (actual time=25.491..128.973 rows=216311 loops=1)
--    Recheck Cond: ((((customer_info -> 'age'::text))::integer >= 25) AND (((customer_info -> 'age'::text))::integer <= 35))
--    Heap Blocks: exact=25000
--    Buffers: shared hit=1 read=25593
--    ->  Bitmap Index Scan on customer_customer_info_age  (cost=0.00..106.42 rows=5000 width=0) (actual time=21.045..21.045 rows=216311 loops=1)
--          Index Cond: ((((customer_info -> 'age'::text))::integer >= 25) AND (((customer_info -> 'age'::text))::integer <= 35))
--          Buffers: shared read=594
--  Planning Time: 0.401 ms
--  Execution Time: 135.963 ms