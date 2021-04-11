COPY ticket(customer_id, fest_id, price_id) 
FROM '/home/alex000/Documents/Progs/2020-21/BDLabs/Lab3-1/data/ticket1.csv';
-- and then the same for ticket2.csv, ticket3.csv, ..., ticket10.csv
ANALYZE VERBOSE ticket;

COPY customer(customer_info) 
FROM '/home/alex000/Documents/Progs/2020-21/BDLabs/Lab3-1/data/customer.csv';
ANALYZE VERBOSE customer;

COPY fest(ratings, prices, n_tickets) 
FROM '/home/alex000/Documents/Progs/2020-21/BDLabs/Lab3-1/data/fest.csv';
ANALYZE VERBOSE fest;

COPY genre(genre_name, ratings, total_revenue, total_tickets) 
FROM '/home/alex000/Documents/Progs/2020-21/BDLabs/Lab3-1/data/genre.csv';
ANALYZE VERBOSE genre;

COPY genre_fest(genre_id, fest_id) 
FROM '/home/alex000/Documents/Progs/2020-21/BDLabs/Lab3-1/data/genre_fest.csv';
ANALYZE VERBOSE genre_fest;

COPY rewiew(customer_id, fest_id, rating, content) 
FROM '/home/alex000/Documents/Progs/2020-21/BDLabs/Lab3-1/data/rewiew.csv';
ANALYZE VERBOSE rewiew;