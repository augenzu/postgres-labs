-- TABLES


-- checking: "grant select, insert, update on customer to test;""
-- ok
select * from customer limit 3;
-- ok
insert into customer(customer_id, customer_info)
values(1234321, '{ "name": "Arthur Dent", "age": 42 }');
-- ok
update customer
set customer_info = '{ "name": "Arthur Dent", "age": 42 }'
where customer_id = 1000000;
-- permission denied!
delete from customer
where customer_id = 1000000;


-- checking: "grant select (rating, content), update (rating, content) on review to test;"
-- ok
select rating, content
from review
order by rating desc
limit 3;
-- ok
update review 
set rating = rating + 1
where rating < 10;
-- permission denied!
update review 
set rating = rating + 1
where fest_id = 511;


-- checking: "grant select on fest to test;"
-- ok
select * from fest
limit 1;
-- permission denied!
insert into fest(ratings)
values('{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}');


-- checking: "grant select on genre to test;"
-- ok
select genre_name, total_revenue
from genre
order by 2 desc
limit 3;
-- permission denied!
update genre
set total_revenue = total_revenue - 1000000
where genre_name = 'indie rock';


-- VIEWS


-- checking: "grant select on fest_info to test;"
-- ok
select * from fest_info
order by total_revenue, total_n_tickets
limit 5;
-- permission denied!
update fest_info
set fest_id = fest_id + 100
where fest_id = 1000000;


-- checking: "grant select on fest_rating to test;"
--ok
select * from fest_rating
order by fest_id, rating
limit 10;
-- contaning group by
update fest_rating
set rating = rating + 1
where fest_id = 1;

-- checking: "grant select on mean_rating_of_genre to test;"
-- ok
select * from mean_rating_of_genre 
order by 2 desc;


-- checking: "grant select on prices_of_fest to test;",
-- "grant upd_prices to test;"
-- ok
select * from prices_of_fest
order by fest_id
limit 3;
-- ok
update prices_of_fest
set prices[10] = prices[10] + 20
where fest_id = 2;
-- permission denied!
insert into prices_of_fest(fest_id, prices)
values(1234321, '{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}');


-- checking: "grant select on mtrlzd_fest_42_ticket, fest_42_ticket to test;"
-- ok
select * from mtrlzd_fest_42_ticket;  -- fast
-- ok
select * from fest_42_ticket;  -- very slow
-- faster:
select * from fest_42_ticket 
limit 1;
