-- Секционированная таблица
create table if not exists ticket (
    ticket_id serial,
    customer_id int,
    fest_id int,
    price_id int,  -- in [1, 10]
    purchase_date date
) partition by range(purchase_date);


-- 60 секций (5 лет * 12 месяцев)

create table if not exists ticket_y2015m01 partition of ticket
    for values from ('2015-01-01') to ('2015-02-01');
create table if not exists ticket_y2015m02 partition of ticket
    for values from ('2015-02-01') to ('2015-03-01');
create table if not exists ticket_y2015m03 partition of ticket
    for values from ('2015-03-01') to ('2015-04-01');
create table if not exists ticket_y2015m04 partition of ticket
    for values from ('2015-04-01') to ('2015-05-01');
create table if not exists ticket_y2015m05 partition of ticket
    for values from ('2015-05-01') to ('2015-06-01');
create table if not exists ticket_y2015m06 partition of ticket
    for values from ('2015-06-01') to ('2015-07-01');
create table if not exists ticket_y2015m07 partition of ticket
    for values from ('2015-07-01') to ('2015-08-01');
create table if not exists ticket_y2015m08 partition of ticket
    for values from ('2015-08-01') to ('2015-09-01');
create table if not exists ticket_y2015m09 partition of ticket
    for values from ('2015-09-01') to ('2015-10-01');
create table if not exists ticket_y2015m10 partition of ticket
    for values from ('2015-10-01') to ('2015-11-01');
create table if not exists ticket_y2015m11 partition of ticket
    for values from ('2015-11-01') to ('2015-12-01');
create table if not exists ticket_y2015m12 partition of ticket
    for values from ('2015-12-01') to ('2016-01-01');

create table if not exists ticket_y2016m01 partition of ticket
    for values from ('2016-01-01') to ('2016-02-01');
create table if not exists ticket_y2016m02 partition of ticket
    for values from ('2016-02-01') to ('2016-03-01');
create table if not exists ticket_y2016m03 partition of ticket
    for values from ('2016-03-01') to ('2016-04-01');
create table if not exists ticket_y2016m04 partition of ticket
    for values from ('2016-04-01') to ('2016-05-01');
create table if not exists ticket_y2016m05 partition of ticket
    for values from ('2016-05-01') to ('2016-06-01');
create table if not exists ticket_y2016m06 partition of ticket
    for values from ('2016-06-01') to ('2016-07-01');
create table if not exists ticket_y2016m07 partition of ticket
    for values from ('2016-07-01') to ('2016-08-01');
create table if not exists ticket_y2016m08 partition of ticket
    for values from ('2016-08-01') to ('2016-09-01');
create table if not exists ticket_y2016m09 partition of ticket
    for values from ('2016-09-01') to ('2016-10-01');
create table if not exists ticket_y2016m10 partition of ticket
    for values from ('2016-10-01') to ('2016-11-01');
create table if not exists ticket_y2016m11 partition of ticket
    for values from ('2016-11-01') to ('2016-12-01');
create table if not exists ticket_y2016m12 partition of ticket
    for values from ('2016-12-01') to ('2017-01-01');

create table if not exists ticket_y2017m01 partition of ticket
    for values from ('2017-01-01') to ('2017-02-01');
create table if not exists ticket_y2017m02 partition of ticket
    for values from ('2017-02-01') to ('2017-03-01');
create table if not exists ticket_y2017m03 partition of ticket
    for values from ('2017-03-01') to ('2017-04-01');
create table if not exists ticket_y2017m04 partition of ticket
    for values from ('2017-04-01') to ('2017-05-01');
create table if not exists ticket_y2017m05 partition of ticket
    for values from ('2017-05-01') to ('2017-06-01');
create table if not exists ticket_y2017m06 partition of ticket
    for values from ('2017-06-01') to ('2017-07-01');
create table if not exists ticket_y2017m07 partition of ticket
    for values from ('2017-07-01') to ('2017-08-01');
create table if not exists ticket_y2017m08 partition of ticket
    for values from ('2017-08-01') to ('2017-09-01');
create table if not exists ticket_y2017m09 partition of ticket
    for values from ('2017-09-01') to ('2017-10-01');
create table if not exists ticket_y2017m10 partition of ticket
    for values from ('2017-10-01') to ('2017-11-01');
create table if not exists ticket_y2017m11 partition of ticket
    for values from ('2017-11-01') to ('2017-12-01');
create table if not exists ticket_y2017m12 partition of ticket
    for values from ('2017-12-01') to ('2018-01-01');

create table if not exists ticket_y2018m01 partition of ticket
    for values from ('2018-01-01') to ('2018-02-01');
create table if not exists ticket_y2018m02 partition of ticket
    for values from ('2018-02-01') to ('2018-03-01');
create table if not exists ticket_y2018m03 partition of ticket
    for values from ('2018-03-01') to ('2018-04-01');
create table if not exists ticket_y2018m04 partition of ticket
    for values from ('2018-04-01') to ('2018-05-01');
create table if not exists ticket_y2018m05 partition of ticket
    for values from ('2018-05-01') to ('2018-06-01');
create table if not exists ticket_y2018m06 partition of ticket
    for values from ('2018-06-01') to ('2018-07-01');
create table if not exists ticket_y2018m07 partition of ticket
    for values from ('2018-07-01') to ('2018-08-01');
create table if not exists ticket_y2018m08 partition of ticket
    for values from ('2018-08-01') to ('2018-09-01');
create table if not exists ticket_y2018m09 partition of ticket
    for values from ('2018-09-01') to ('2018-10-01');
create table if not exists ticket_y2018m10 partition of ticket
    for values from ('2018-10-01') to ('2018-11-01');
create table if not exists ticket_y2018m11 partition of ticket
    for values from ('2018-11-01') to ('2018-12-01');
create table if not exists ticket_y2018m12 partition of ticket
    for values from ('2018-12-01') to ('2019-01-01');

create table if not exists ticket_y2019m01 partition of ticket
    for values from ('2019-01-01') to ('2019-02-01');
create table if not exists ticket_y2019m02 partition of ticket
    for values from ('2019-02-01') to ('2019-03-01');
create table if not exists ticket_y2019m03 partition of ticket
    for values from ('2019-03-01') to ('2019-04-01');
create table if not exists ticket_y2019m04 partition of ticket
    for values from ('2019-04-01') to ('2019-05-01');
create table if not exists ticket_y2019m05 partition of ticket
    for values from ('2019-05-01') to ('2019-06-01');
create table if not exists ticket_y2019m06 partition of ticket
    for values from ('2019-06-01') to ('2019-07-01');
create table if not exists ticket_y2019m07 partition of ticket
    for values from ('2019-07-01') to ('2019-08-01');
create table if not exists ticket_y2019m08 partition of ticket
    for values from ('2019-08-01') to ('2019-09-01');
create table if not exists ticket_y2019m09 partition of ticket
    for values from ('2019-09-01') to ('2019-10-01');
create table if not exists ticket_y2019m10 partition of ticket
    for values from ('2019-10-01') to ('2019-11-01');
create table if not exists ticket_y2019m11 partition of ticket
    for values from ('2019-11-01') to ('2019-12-01');
create table if not exists ticket_y2019m12 partition of ticket
    for values from ('2019-12-01') to ('2020-01-01');

create table if not exists ticket_y2020m01 partition of ticket
    for values from ('2020-01-01') to ('2020-02-01');
create table if not exists ticket_y2020m02 partition of ticket
    for values from ('2020-02-01') to ('2020-03-01');
create table if not exists ticket_y2020m03 partition of ticket
    for values from ('2020-03-01') to ('2020-04-01');
create table if not exists ticket_y2020m04 partition of ticket
    for values from ('2020-04-01') to ('2020-05-01');
create table if not exists ticket_y2020m05 partition of ticket
    for values from ('2020-05-01') to ('2020-06-01');
create table if not exists ticket_y2020m06 partition of ticket
    for values from ('2020-06-01') to ('2020-07-01');
create table if not exists ticket_y2020m07 partition of ticket
    for values from ('2020-07-01') to ('2020-08-01');
create table if not exists ticket_y2020m08 partition of ticket
    for values from ('2020-08-01') to ('2020-09-01');
create table if not exists ticket_y2020m09 partition of ticket
    for values from ('2020-09-01') to ('2020-10-01');
create table if not exists ticket_y2020m10 partition of ticket
    for values from ('2020-10-01') to ('2020-11-01');
create table if not exists ticket_y2020m11 partition of ticket
    for values from ('2020-11-01') to ('2020-12-01');
create table if not exists ticket_y2020m12 partition of ticket
    for values from ('2020-12-01') to ('2021-01-01');



copy ticket(customer_id, fest_id, price_id, purchase_date) 
from '/home/alex000/Documents/Progs/2020-21/BDLabs/Lab3-4/data/ticket1.csv';
-- and then the same for ticket2.csv, ticket3.csv, ..., ticket10.csv
analyze verbose ticket;


-- faster select (cause of partition pruning)

-- only one section
explain analyze 
select * from ticket where purchase_date between '2016-03-03'::date and '2016-03-27'::date;

-- two sections
explain analyze 
select * from ticket where purchase_date between '2016-03-03'::date and '2016-04-07'::date;

-- 6 sections
explain analyze 
select * from ticket 
where 
    purchase_date between '2016-03-03'::date and '2016-04-07'::date
    or purchase_date between '2018-05-02'::date and '2018-08-02'::date;


-- faster delete (every month/year/...)

begin;
alter table ticket detach partition ticket_y2015m01;
-- or
drop table ticket_y2015m02;
-- and then
explain select * from ticket;  -- rows will decrease
rollback;


-- faster insert (exactly one section)

begin;

create table ticket_y2021m01
  (like ticket including defaults including constraints);

alter table ticket_y2021m01 add constraint y2021m01
   check ( purchase_date >= '2021-01-01'::date and purchase_date < '2021-02-01'::date );

copy ticket_y2021m01(customer_id, fest_id, price_id, purchase_date) 
from '/home/alex000/Documents/Progs/2020-21/BDLabs/Lab3-4/data/ticket2101.csv';

-- analyze verbose ticket_y2021m01;

alter table ticket attach partition ticket_y2021m01
    for values from ('2021-01-01') to ('2021-02-01');

alter table ticket_y2021m01 drop constraint y2021m01;

-- analyze verbose ticket;

explain select * from ticket;

rollback;