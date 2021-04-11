-- we get the best timing with using both
-- fest_fest_id_idx   and    genre_fest_g_id_f_id_idx   
-- indexes 


-- query to optimize
explain (analyze true, buffers true)
select 
    genre_name,
    total_revenue,
    total_tickets,
    genre_id,
    fest_id
from 
    genre
    left join genre_fest using(genre_id)
    left join fest using(fest_id)
where 
    total_revenue > 75000000
    and fest_id between 4000 and 4050
order by fest_id;


set enable_indexscan = off;
set enable_bitmapscan = off;

-- without indexes
--                                                                    QUERY PLAN                                                                   
-- ------------------------------------------------------------------------------------------------------------------------------------------------
--  Gather Merge  (cost=87285.76..87292.06 rows=54 width=28) (actual time=6128.711..6156.170 rows=74 loops=1)
--    Workers Planned: 2
--    Workers Launched: 2
--    Buffers: shared hit=219 read=48572, temp read=2803 written=2948
--    ->  Sort  (cost=86285.74..86285.80 rows=27 width=28) (actual time=4149.203..4149.216 rows=25 loops=3)
--          Sort Key: genre_fest.fest_id
--          Sort Method: quicksort  Memory: 28kB
--          Worker 0:  Sort Method: quicksort  Memory: 26kB
--          Worker 1:  Sort Method: quicksort  Memory: 26kB
--          Buffers: shared hit=219 read=48572, temp read=2803 written=2948
--          ->  Parallel Hash Left Join  (cost=38032.62..86285.09 rows=27 width=28) (actual time=4040.417..4149.037 rows=25 loops=3)
--                Hash Cond: (genre_fest.fest_id = fest.fest_id)
--                Buffers: shared hit=165 read=48572, temp read=2803 written=2948
--                ->  Hash Join  (cost=1.61..46623.88 rows=27 width=28) (actual time=126.015..1766.122 rows=25 loops=3)
--                      Hash Cond: (genre_fest.genre_id = genre.genre_id)
--                      Buffers: shared hit=79 read=21546
--                      ->  Parallel Seq Scan on genre_fest  (cost=0.00..46622.00 rows=93 width=8) (actual time=84.036..1765.722 rows=69 loops=3)
--                            Filter: ((fest_id >= 4000) AND (fest_id <= 4050))
--                            Rows Removed by Filter: 1333264
--                            Buffers: shared hit=76 read=21546
--                      ->  Hash  (cost=1.48..1.48 rows=11 width=24) (actual time=0.066..0.067 rows=11 loops=3)
--                            Buckets: 1024  Batches: 1  Memory Usage: 9kB
--                            Buffers: shared hit=3
--                            ->  Seq Scan on genre  (cost=0.00..1.48 rows=11 width=24) (actual time=0.043..0.054 rows=11 loops=3)
--                                  Filter: (total_revenue > 75000000)
--                                  Rows Removed by Filter: 27
--                                  Buffers: shared hit=3
--                ->  Parallel Hash  (cost=31194.67..31194.67 rows=416667 width=4) (actual time=2244.743..2244.744 rows=333333 loops=3)
--                      Buckets: 131072  Batches: 16  Memory Usage: 3552kB
--                      Buffers: shared hit=2 read=27026, temp written=2816
--                      ->  Parallel Seq Scan on fest  (cost=0.00..31194.67 rows=416667 width=4) (actual time=0.411..2061.516 rows=333333 loops=3)
--                            Buffers: shared hit=2 read=27026
--  Planning Time: 0.633 ms
--  Execution Time: 6156.254 ms


set enable_indexscan = on;
set enable_bitmapscan = on;

create index fest_fest_id_idx on fest(fest_id);

-- very faster; Index Only Scan
--                                                                   QUERY PLAN                                                                   
-- -----------------------------------------------------------------------------------------------------------------------------------------------
--  Gather Merge  (cost=47741.37..47747.67 rows=54 width=28) (actual time=132.641..134.910 rows=74 loops=1)
--    Workers Planned: 2
--    Workers Launched: 2
--    Buffers: shared hit=498 read=21452
--    ->  Sort  (cost=46741.35..46741.42 rows=27 width=28) (actual time=113.127..113.131 rows=25 loops=3)
--          Sort Key: genre_fest.fest_id
--          Sort Method: quicksort  Memory: 28kB
--          Worker 0:  Sort Method: quicksort  Memory: 26kB
--          Worker 1:  Sort Method: quicksort  Memory: 26kB
--          Buffers: shared hit=498 read=21452
--          ->  Nested Loop Left Join  (cost=2.04..46740.71 rows=27 width=28) (actual time=7.910..113.096 rows=25 loops=3)
--                Buffers: shared hit=484 read=21452
--                ->  Hash Join  (cost=1.61..46623.88 rows=27 width=28) (actual time=7.882..112.969 rows=25 loops=3)
--                      Hash Cond: (genre_fest.genre_id = genre.genre_id)
--                      Buffers: shared hit=259 read=21450
--                      ->  Parallel Seq Scan on genre_fest  (cost=0.00..46622.00 rows=93 width=8) (actual time=1.646..112.831 rows=69 loops=3)
--                            Filter: ((fest_id >= 4000) AND (fest_id <= 4050))
--                            Rows Removed by Filter: 1333264
--                            Buffers: shared hit=172 read=21450
--                      ->  Hash  (cost=1.48..1.48 rows=11 width=24) (actual time=0.031..0.031 rows=11 loops=3)
--                            Buckets: 1024  Batches: 1  Memory Usage: 9kB
--                            Buffers: shared hit=3
--                            ->  Seq Scan on genre  (cost=0.00..1.48 rows=11 width=24) (actual time=0.015..0.021 rows=11 loops=3)
--                                  Filter: (total_revenue > 75000000)
--                                  Rows Removed by Filter: 27
--                                  Buffers: shared hit=3
--                ->  Index Only Scan using fest_fest_id_idx on fest  (cost=0.42..4.32 rows=1 width=4) (actual time=0.003..0.004 rows=1 loops=74)
--                      Index Cond: (fest_id = genre_fest.fest_id)
--                      Heap Fetches: 0
--                      Buffers: shared hit=225 read=2
--  Planning Time: 0.946 ms
--  Execution Time: 134.982 ms


create index genre_fest_g_id_f_id_idx on genre_fest(genre_id, fest_id);

-- faster again; double Index Only Scan
--                                                                           QUERY PLAN                                                                    
      
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- ------
--  Sort  (cost=599.46..599.63 rows=65 width=28) (actual time=1.333..1.352 rows=74 loops=1)
--    Sort Key: genre_fest.fest_id
--    Sort Method: quicksort  Memory: 30kB
--    Buffers: shared hit=308 read=23
--    ->  Nested Loop Left Join  (cost=0.85..597.51 rows=65 width=28) (actual time=0.120..1.243 rows=74 loops=1)
--          Buffers: shared hit=308 read=23
--          ->  Nested Loop  (cost=0.43..316.26 rows=65 width=28) (actual time=0.102..0.757 rows=74 loops=1)
--                Buffers: shared hit=85 read=23
--                ->  Seq Scan on genre  (cost=0.00..1.48 rows=11 width=24) (actual time=0.018..0.035 rows=11 loops=1)
--                      Filter: (total_revenue > 75000000)
--                      Rows Removed by Filter: 27
--                      Buffers: shared hit=1
--                ->  Index Only Scan using genre_fest_g_id_f_id_idx on genre_fest  (cost=0.43..28.56 rows=6 width=8) (actual time=0.030..0.045 rows=7 loops=11)
--                      Index Cond: ((genre_id = genre.genre_id) AND (fest_id >= 4000) AND (fest_id <= 4050))
--                      Heap Fetches: 74
--                      Buffers: shared hit=84 read=23
--          ->  Index Only Scan using fest_fest_id_idx on fest  (cost=0.42..4.32 rows=1 width=4) (actual time=0.005..0.005 rows=1 loops=74)
--                Index Cond: (fest_id = genre_fest.fest_id)
--                Heap Fetches: 0
--                Buffers: shared hit=223
--  Planning Time: 0.959 ms
--  Execution Time: 1.447 ms


-- !!!
-- indexes   fest_fest_id_idx   and    genre_fest_g_id_f_id_idx   
-- each speed up the query 
-- by about 300x, so we need BOTH of them
-- !!!



-- these indexes don't improve the timing
-- this one works almost the same as genre_fest_g_id_f_id_idx
create index genre_fest_f_id_g_id_idx on genre_fest(fest_id, genre_id);
-- this one works even worse
create index genre_fest_fest_id_idx on genre_fest(fest_id);
