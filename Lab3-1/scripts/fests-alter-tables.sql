-- execute this AFTER loading the data
-- otherwise the laptop will freeze (at least this one)


-- PKs
ALTER TABLE customer ADD PRIMARY KEY(customer_id);
ALTER TABLE fest ADD PRIMARY KEY(fest_id);
ALTER TABLE genre ADD PRIMARY KEY(genre_id);
-- ALTER TABLE genre_fest ADD PRIMARY KEY(genre_fest_id);
-- ALTER TABLE ticket ADD PRIMARY KEY(ticket_id);
-- ALTER TABLE rewiew ADD PRIMARY KEY(rewiew_id);


-- rewiew
ALTER TABLE rewiew ADD FOREIGN KEY(customer_id) REFERENCES customer;
ALTER TABLE rewiew ADD FOREIGN KEY(fest_id) REFERENCES fest;
ALTER TABLE rewiew ALTER COLUMN customer_id SET NOT NULL;
ALTER TABLE rewiew ALTER COLUMN fest_id SET NOT NULL;
ALTER TABLE rewiew ALTER COLUMN rating SET NOT NULL;
ALTER TABLE rewiew ADD CHECK (rating >= 1 and rating <= 10);


-- ticket
ALTER TABLE ticket ADD FOREIGN KEY(customer_id) REFERENCES customer;
ALTER TABLE ticket ADD FOREIGN KEY(fest_id) REFERENCES fest;
ALTER TABLE ticket ALTER COLUMN customer_id SET NOT NULL;
ALTER TABLE ticket ALTER COLUMN fest_id SET NOT NULL;
ALTER TABLE ticket ALTER COLUMN price_id SET NOT NULL;
ALTER TABLE ticket ADD CHECK (price_id >= 1 and price_id <= 10);


-- genre_fest
ALTER TABLE genre_fest ADD FOREIGN KEY(fest_id) REFERENCES fest;
ALTER TABLE genre_fest ADD FOREIGN KEY(genre_id) REFERENCES genre;
ALTER TABLE genre_fest ALTER COLUMN genre_id SET NOT NULL;
ALTER TABLE genre_fest ALTER COLUMN fest_id SET NOT NULL;


-- genre
ALTER TABLE genre ALTER COLUMN genre_name SET NOT NULL;
ALTER TABLE genre ADD CHECK (genre_name <> '');
ALTER TABLE genre ALTER COLUMN ratings SET NOT NULL;
ALTER TABLE genre ALTER COLUMN ratings SET DEFAULT '{0, 0, 0, 0, 0, 0, 0, 0, 0, 0}';
ALTER TABLE genre ALTER COLUMN total_revenue SET NOT NULL;
ALTER TABLE genre ADD CHECK (total_revenue >= 0);
ALTER TABLE genre ALTER COLUMN total_revenue SET DEFAULT 0;
ALTER TABLE genre ALTER COLUMN total_tickets SET NOT NULL;
ALTER TABLE genre ADD CHECK (total_tickets >= 0);
ALTER TABLE genre ALTER COLUMN total_tickets SET DEFAULT 0;


-- fest
ALTER TABLE fest ALTER COLUMN ratings SET NOT NULL;
ALTER TABLE fest ALTER COLUMN ratings SET DEFAULT '{0, 0, 0, 0, 0, 0, 0, 0, 0, 0}';
ALTER TABLE fest ALTER COLUMN prices SET NOT NULL;
ALTER TABLE fest ALTER COLUMN prices SET DEFAULT '{0, 0, 0, 0, 0, 0, 0, 0, 0, 0}';
ALTER TABLE fest ALTER COLUMN n_tickets SET NOT NULL;
ALTER TABLE fest ALTER COLUMN n_tickets SET DEFAULT '{0, 0, 0, 0, 0, 0, 0, 0, 0, 0}';





-- ALTER TABLE genre ADD CHECK (ALL(ratings) >= 0);