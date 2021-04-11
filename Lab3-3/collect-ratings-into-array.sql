-- Таблица для заполнения следующей функцией
create table if not exists fest_rating_cnts (
    fest_id int,
    rating_cnts int[10] default '{0, 0, 0, 0, 0, 0, 0, 0, 0, 0}'
);


-- Собирает количества рейтингов из таблицы-связи fest_rating в массивы 
-- и записывает их в таблицу fest_rating_cnts
create or replace function collect_ratings_into_array() returns void as $$
declare
    rec record;
    r_cnt bigint = 0;
    rating_cnts bigint[10] = '{0, 0, 0, 0, 0, 0, 0, 0, 0, 0}';
begin
    for rec in
        select fest_id from fest
        limit 5  -- in fact we should remove this but the function already works really slow
    loop
        for r in 1..10 loop
            select rating_cnt into r_cnt
            from fest_rating
            where fest_id = rec.fest_id and rating = r;
            rating_cnts[r] = coalesce(r_cnt, 0);
        end loop;
        insert into fest_rating_cnts values(rec.fest_id, rating_cnts);
    end loop;
end;
$$ language plpgsql;


-- truncate table fest_rating_cnts;
select collect_ratings_into_array();
     