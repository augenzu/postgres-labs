CREATE TABLE IF NOT EXISTS customer (
    customer_id serial,
    customer_info jsonb  -- {name, contacts: {email, number}, age, nationality}
                         -- we need name & contacts to inform customers about fests they might like;
                         -- age and/or nationality can be used to make further statistics (if we want) 
);

CREATE TABLE IF NOT EXISTS fest (
    fest_id serial,
    ratings int[10], -- DEFAULT '{0, 0, 0, 0, 0, 0, 0, 0, 0, 0}',  -- ratings[i] is number ratings 'i'
    prices int[10], -- DEFAULT '{0, 0, 0, 0, 0, 0, 0, 0, 0, 0}',  -- prices is const for every fest; => trigger on upd?
                                                     -- if number of prices = n < 8 then prices[n] = .. = prices[n]
                                                     -- and in that case we can use only one function 
                                                     -- (e. g calculate total price) for all the fests
    n_tickets int[10] -- DEFAULT '{0, 0, 0, 0, 0, 0, 0, 0}',  -- n_tickets[i] tickets for price prices[i]
    -- genres int[]
);

-- main statistics is here
CREATE TABLE IF NOT EXISTS genre (
    genre_id serial,
    genre_name varchar(30),
    -- fest_ids int[],  -- trigger on upd => change ratings & totals
    ratings int[10] DEFAULT '{0, 0, 0, 0, 0, 0, 0, 0, 0, 0}',
    total_revenue int,
    total_tickets int
    -- ratings & totals are recalculated once a hour/day/month/...
);

CREATE TABLE IF NOT EXISTS genre_fest (
    genre_fest_id serial,
    genre_id int,
    fest_id int
);

CREATE TABLE IF NOT EXISTS ticket (
    ticket_id serial,
    customer_id int,
    fest_id int,
    price_id int  -- in [1, 10]
    -- trigger on insert => upd fest.n_tickets
);

CREATE TABLE IF NOT EXISTS rewiew (
    rewiew_id serial,
    customer_id int,
    fest_id int,
    rating int,
    content text
    -- trigger on insert => upd fest.ratings
);
