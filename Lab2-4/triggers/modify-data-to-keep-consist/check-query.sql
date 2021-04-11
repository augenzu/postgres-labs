begin;
-- 100500 -> null
insert into fest(fest_name, place_id)
values ('Fest-with-wrong-place-id', 100500);
commit;

begin;
-- 100500 -> 1
update fest set place_id = 100500
where place_id = 1;
commit;
