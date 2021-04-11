-- Минимум двух элементов
create or replace function _min(anyelement, anyelement) returns anyelement as $$
begin
    if $1 < $2
        then return $1;
    else 
        return $2;
    end if;
end;
$$ language plpgsql;


-- Взвешенная сумма элементов массива
-- (в бд fests нужна для вычисления среднего рейтинга и суммарной выручки)
create or replace function weighted_sum(vals int[], weights int[], cnt int = null) returns bigint as $$
declare
    w_sum bigint = 0;
    _cnt int;
begin
    if cnt is not null
        then _cnt = cnt;
    else 
        _cnt = _min(array_length(vals, 1), array_length(weights, 1));
    end if;
    for i in 1.._cnt loop
        w_sum = w_sum + vals[i] * weights[i];
    end loop;
    return w_sum;
end;
$$ language plpgsql;


--------------------- tests ---------------------------

select 
weighted_sum('{1, 2, 3}', '{4, 5, 6}', 3);
select 
weighted_sum('{1, 2, 3}', '{4, 5, 6}');
select 
weighted_sum('{1, 2, 3}', '{5}');


-------------- How and where to use -------------------

-- view from Lab3-2/create-views-script.sql

-- Количество проданных билетов + 
-- суммарная выручка за фестиваль
create or replace view fest_info as
select 
    fest_id,
    weighted_sum(n_tickets, '{ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 }') total_n_tickets,
    weighted_sum(n_tickets, prices) total_revenue
from fest;

-- and then we can use:
--      begin;
--      select refcursor_to_table('ref', 'fest_info');
--      fetch next from ref;
--      ...
--      commit;