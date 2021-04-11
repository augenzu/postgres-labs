-- Возвращает курсор на заданную таблицу
create or replace function refcursor_to_table(refcursor, tbl_name text) returns refcursor as $$
begin
    open $1 for execute format('select * from %I', tbl_name);
    return $1;
exception
    when undefined_table then 
        raise notice 'Relation % does nor exist. You will not be able to use the returned cursor further.', tbl_name;
        return $1;
end;
$$ language plpgsql;


------------------- test queries ----------------------------

-- right query
-- fetch выполняется быстро, а select * from ticket - несколько минут
begin;
select refcursor_to_table('ref', 'ticket');
fetch next from ref;
-- and the same again...
commit;

-- right query
-- run after 'select collect_ratings_into_array();'
begin;
select refcursor_to_table('ref', 'fest_rating_cnts');
fetch next from ref;
-- and the same again...
commit;

-- wrong query
begin;
select refcursor_to_table('ref', 'jhfjfjgjhfciyfuyfu');
fetch next from ref;  -- => ERROR:  cursor "ref" does not exist
rollback;