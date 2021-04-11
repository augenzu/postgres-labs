-- \connect rock_bands;

DROP TABLE test CASCADE;
DROP TABLE child CASCADE;

CREATE TABLE test (
    a int PRIMARY KEY,
    b int
);

INSERT INTO test (a, b)
VALUES 
    (1, 1),
    (2, 2);
    -- (1, null);

CREATE TABLE child (
    c_a int DEFAULT 3
        REFERENCES test ON DELETE SET DEFAULT,
    c_b int
);

INSERT INTO child (c_a, c_b)
VALUES  
    (1, 111),
    (null, 100500);

DELETE FROM test
WHERE a = 1;