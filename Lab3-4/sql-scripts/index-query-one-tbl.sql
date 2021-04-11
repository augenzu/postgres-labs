-- multicolumn index review_fest_id_rating_idx gives the best timing
-- but with the review_fest_id_idx it's almost the same


-- query to optimize
explain (analyze true, buffers true)
select 
    customer_id, rating, fest_id
from review
where 
    rating between 2 and 8
    and fest_id between 350000 and 350030;


set enable_indexscan = off;
set enable_bitmapscan = off;

-- without indexes
--                                                      QUERY PLAN                                                      
-- ---------------------------------------------------------------------------------------------------------------------
--  Gather  (cost=1000.00..33326.43 rows=21 width=12) (actual time=5.730..195.110 rows=24 loops=1)
--    Workers Planned: 2
--    Workers Launched: 2
--    Buffers: shared hit=16240 read=7751
--    ->  Parallel Seq Scan on review  (cost=0.00..32324.33 rows=9 width=12) (actual time=1.825..43.986 rows=8 loops=3)
--          Filter: ((rating >= 2) AND (rating <= 8) AND (fest_id >= 350000) AND (fest_id <= 350030))
--          Rows Removed by Filter: 333325
--          Buffers: shared hit=16240 read=7751
--  Planning Time: 45.108 ms
--  Execution Time: 195.145 ms


set enable_indexscan = on;
set enable_bitmapscan = on;


create index review_rating_idx on review(rating);

-- about twice faster
--                                                      QUERY PLAN                                                      
-- ---------------------------------------------------------------------------------------------------------------------
--  Gather  (cost=1000.00..33326.43 rows=21 width=12) (actual time=6.695..82.174 rows=24 loops=1)
--    Workers Planned: 2
--    Workers Launched: 2
--    Buffers: shared hit=16142 read=7849
--    ->  Parallel Seq Scan on review  (cost=0.00..32324.33 rows=9 width=12) (actual time=4.027..48.886 rows=8 loops=3)
--          Filter: ((rating >= 2) AND (rating <= 8) AND (fest_id >= 350000) AND (fest_id <= 350030))
--          Rows Removed by Filter: 333325
--          Buffers: shared hit=16142 read=7849
--  Planning Time: 0.342 ms
--  Execution Time: 82.210 ms


create index review_fest_id_idx on review(fest_id);

-- very faster
--                                                          QUERY PLAN                                                          
-- -----------------------------------------------------------------------------------------------------------------------------
--  Bitmap Heap Scan on review  (cost=4.73..122.15 rows=21 width=12) (actual time=0.090..0.220 rows=24 loops=1)
--    Recheck Cond: ((fest_id >= 350000) AND (fest_id <= 350030))
--    Filter: ((rating >= 2) AND (rating <= 8))
--    Rows Removed by Filter: 9
--    Heap Blocks: exact=33
--    Buffers: shared hit=28 read=8
--    ->  Bitmap Index Scan on review_fest_id_idx  (cost=0.00..4.72 rows=30 width=0) (actual time=0.051..0.051 rows=33 loops=1)
--          Index Cond: ((fest_id >= 350000) AND (fest_id <= 350030))
--          Buffers: shared read=3
--  Planning Time: 1.656 ms
--  Execution Time: 0.266 ms


create index review_fest_id_rating_idx on review(fest_id, rating);

-- a bit faster than with review_fest_id_idx
--                                                              QUERY PLAN                                                             
-- ------------------------------------------------------------------------------------------------------------------------------------
--  Bitmap Heap Scan on review  (cost=4.88..87.44 rows=21 width=12) (actual time=0.083..0.173 rows=24 loops=1)
--    Recheck Cond: ((fest_id >= 350000) AND (fest_id <= 350030) AND (rating >= 2) AND (rating <= 8))
--    Heap Blocks: exact=24
--    Buffers: shared hit=24 read=3
--    ->  Bitmap Index Scan on review_fest_id_rating_idx  (cost=0.00..4.88 rows=21 width=0) (actual time=0.061..0.061 rows=24 loops=1)
--          Index Cond: ((fest_id >= 350000) AND (fest_id <= 350030) AND (rating >= 2) AND (rating <= 8))
--          Buffers: shared read=3
--  Planning Time: 1.706 ms
--  Execution Time: 0.219 ms













-- Prepering
-- select 
--     count(fest_id), fest_id, rating
-- from review
-- group by fest_id, rating
-- order by 1 desc, 2;