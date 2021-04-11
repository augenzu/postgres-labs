------------ single word queries ----------------

-- without indexes

set enable_indexscan = off;
set enable_bitmapscan = off;


-- with ilike
explain (analyze true, buffers true)
select content
from review
where 
    content ~~* '% communicate %' or content ~~* '% communicate.%'
    or content ~~* '% communicates %' or content ~~* '% communicates.%';

--                                                                                       QUERY PLAN                                                        
                              
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------
--  Gather  (cost=1000.00..38533.73 rows=52094 width=147) (actual time=1.020..2978.539 rows=70407 loops=1)
--    Workers Planned: 2
--    Workers Launched: 2
--    Buffers: shared hit=14146 read=9845
--    ->  Parallel Seq Scan on review  (cost=0.00..32324.33 rows=21706 width=147) (actual time=0.237..2950.822 rows=23469 loops=3)
--          Filter: ((content ~~* '% communicate %'::text) OR (content ~~* '% communicate.%'::text) OR (content ~~* '% communicates %'::text) OR (content ~~* '% communicates.%'::text))
--          Rows Removed by Filter: 309864
--          Buffers: shared hit=14146 read=9845
--  Planning Time: 4.872 ms
--  Execution Time: 2981.269 ms


-- with regexps
explain (analyze true, buffers true)
select content
from review
where content ~* 'communicate';

-- faster!
--                                                           QUERY PLAN                                                           
-- -------------------------------------------------------------------------------------------------------------------------------
--  Gather  (cost=1000.00..35380.63 rows=51813 width=147) (actual time=0.607..791.311 rows=70407 loops=1)
--    Workers Planned: 2
--    Workers Launched: 2
--    Buffers: shared hit=11716 read=12275
--    ->  Parallel Seq Scan on review  (cost=0.00..29199.33 rows=21589 width=147) (actual time=0.121..757.075 rows=23469 loops=3)
--          Filter: (content ~* 'communicate'::text)
--          Rows Removed by Filter: 309864
--          Buffers: shared hit=11716 read=12275
--  Planning Time: 1.183 ms
--  Execution Time: 794.135 ms


set enable_indexscan = on;
set enable_bitmapscan = on;

create index review_content_ts_idx on review using gin (to_tsvector('english', content));

explain (analyze true, buffers true)
select content
from review
where (to_tsvector('english', content)) @@ to_tsquery('communicate');

-- faster by about 26 times than ilike
-- and by about 6 times than regexp
--                                                                QUERY PLAN                                                               
-- ----------------------------------------------------------------------------------------------------------------------------------------
--  Bitmap Heap Scan on review  (cost=75.00..14850.12 rows=5000 width=147) (actual time=13.575..133.501 rows=70407 loops=1)
--    Recheck Cond: (to_tsvector('english'::regconfig, content) @@ to_tsquery('communicate'::text))
--    Heap Blocks: exact=22831
--    Buffers: shared hit=40 read=22807 written=1
--    ->  Bitmap Index Scan on review_content_ts_idx  (cost=0.00..73.75 rows=5000 width=0) (actual time=10.394..10.395 rows=70407 loops=1)
--          Index Cond: (to_tsvector('english'::regconfig, content) @@ to_tsquery('communicate'::text))
--          Buffers: shared hit=16
--  Planning Time: 0.207 ms
--  Execution Time: 136.027 ms


---------------- multiple word queries ------------------------

set enable_indexscan = off;
set enable_bitmapscan = off;

-- with ilike
explain (analyze true, buffers true)
select content
from review
where 
    (content ~~* '% communicate %' or content ~~* '% communicate.%'
    or content ~~* '% communicates %' or content ~~* '% communicates.%')
    or (content ~~* '% world %' or content ~~* '% world.%'
        or content ~~* '% worlds %' or content ~~* '% worlds.%');

--      QUERY PLAN                                                                                                                                                             
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  Gather  (cost=1000.00..47638.40 rows=101474 width=147) (actual time=0.468..5672.522 rows=70407 loops=1)
--    Workers Planned: 2
--    Workers Launched: 2
--    Buffers: shared hit=16160 read=7831
--    ->  Parallel Seq Scan on review  (cost=0.00..36491.00 rows=42281 width=147) (actual time=0.553..5639.340 rows=23469 loops=3)
--          Filter: ((content ~~* '% communicate %'::text) OR (content ~~* '% communicate.%'::text) OR (content ~~* '% communicates %'::text) OR (content ~~* '% communicates.%'::text) OR (content ~~* '% world %'::text) OR (content ~~* '% world.%'::text) OR (content ~~* '% worlds %'::text) OR (content ~~* '% worlds.%'::text))
--          Rows Removed by Filter: 309864
--          Buffers: shared hit=16160 read=7831
--  Planning Time: 6.001 ms
--  Execution Time: 5675.175 ms


-- with regexps
explain (analyze true, buffers true)
select content
from review
where content ~* 'communicate|world';

--                                                            QUERY PLAN                                                           
-- --------------------------------------------------------------------------------------------------------------------------------
--  Gather  (cost=1000.00..35380.63 rows=51813 width=147) (actual time=0.656..1052.162 rows=70407 loops=1)
--    Workers Planned: 2
--    Workers Launched: 2
--    Buffers: shared hit=11853 read=12138
--    ->  Parallel Seq Scan on review  (cost=0.00..29199.33 rows=21589 width=147) (actual time=0.134..1023.521 rows=23469 loops=3)
--          Filter: (content ~* 'communicate|world'::text)
--          Rows Removed by Filter: 309864
--          Buffers: shared hit=11853 read=12138
--  Planning Time: 1.385 ms
--  Execution Time: 1054.923 ms


set enable_indexscan = on;
set enable_bitmapscan = on;


explain (analyze true, buffers true)
select content
from review
where (to_tsvector('english', content)) @@ to_tsquery('communicate | world');


--                                                                   QUERY PLAN                                                                   
-- -----------------------------------------------------------------------------------------------------------------------------------------------
--  Gather  (cost=1149.56..22775.68 rows=9975 width=147) (actual time=19.589..111.033 rows=70407 loops=1)
--    Workers Planned: 2
--    Workers Launched: 2
--    Buffers: shared hit=8 read=22854
--    ->  Parallel Bitmap Heap Scan on review  (cost=149.56..20778.18 rows=4156 width=147) (actual time=6.434..41.918 rows=23469 loops=3)
--          Recheck Cond: (to_tsvector('english'::regconfig, content) @@ to_tsquery('communicate | world'::text))
--          Heap Blocks: exact=19018
--          Buffers: shared hit=8 read=22854
--          ->  Bitmap Index Scan on review_content_ts_idx  (cost=0.00..147.06 rows=9975 width=0) (actual time=14.414..14.414 rows=70407 loops=1)
--                Index Cond: (to_tsvector('english'::regconfig, content) @@ to_tsquery('communicate | world'::text))
--                Buffers: shared hit=5 read=26
--  Planning Time: 0.214 ms
--  Execution Time: 113.664 ms