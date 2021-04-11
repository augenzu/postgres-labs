-- Возвращает курсор на таблицу fest_rating_cnts
create or replace function refcursor_to_frc(refcursor) returns refcursor as $$
begin
    open $1 for select * from fest_rating_cnts;
    return $1;
end;
$$ language plpgsql;

begin;
select refcursor_to_frc('ref');
fetch next from ref;
-- and the same again...
commit;