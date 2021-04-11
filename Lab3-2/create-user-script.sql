create user test with password 'test-password';

grant select, insert, update on customer to test;

grant select (rating, content), update (rating, content) on review to test;

grant select on fest to test; 
grant select on genre to test; 


-- after creating views --

grant select on fest_info to test;

grant select on fest_rating to test;

grant select on prices_of_fest to test;

grant select on mean_rating_of_genre to test;

grant select on mtrlzd_fest_42_ticket, fest_42_ticket to test;

-- after creating role upd_prices --

grant upd_prices to test;
