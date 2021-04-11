DROP DATABASE rock_bands;

CREATE DATABASE rock_bands;

\connect rock_bands

SET client_encoding = 'UTF8';

CREATE TABLE IF NOT EXISTS place (
    place_id serial PRIMARY KEY,
    place_name varchar(50) UNIQUE NOT NULL,
    CHECK(place_name <> '')
);

CREATE TABLE IF NOT EXISTS fest (
    fest_id serial PRIMARY KEY,
    fest_name varchar(50) NOT NULL,
    fest_date date,
    place_id int,
    FOREIGN KEY(place_id) REFERENCES place 
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    CHECK(fest_name <> '')
);

CREATE TABLE IF NOT EXISTS organizer (
    organizer_id serial PRIMARY KEY,
    organizer_name varchar(50) NOT NULL,
    CHECK(organizer_name <> '')
);

CREATE TABLE IF NOT EXISTS fest_organizer (
    fest_id int,
    organizer_id int,
    PRIMARY KEY(fest_id, organizer_id),
    FOREIGN KEY(fest_id) REFERENCES fest 
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(organizer_id) REFERENCES organizer 
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS band (
    band_id serial PRIMARY KEY,
    band_name varchar(30) UNIQUE NOT NULL,
    year_of_foundation int NOT NULL,
    CHECK(band_name <> '')
);

CREATE TABLE IF NOT EXISTS musician (
    musician_name varchar(50) NOT NULL,
    band_id integer,
    PRIMARY KEY(musician_name, band_id),
    FOREIGN KEY(band_id) REFERENCES band 
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    CHECK(musician_name <> '')
);

CREATE TABLE IF NOT EXISTS genre (
    genre_id serial PRIMARY KEY,
    genre_name varchar(30) UNIQUE NOT NULL,
    CHECK(genre_name <> '')
);

CREATE TABLE IF NOT EXISTS band_genre (
    band_id int,
    genre_id int,
    PRIMARY KEY(band_id, genre_id),
    FOREIGN KEY(band_id) REFERENCES band 
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(genre_id) REFERENCES genre 
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS performance (
    band_id int,
    fest_id int,
    perf_num int,
    duration interval hour to minute 
        NOT NULL DEFAULT interval '10'minute,
    PRIMARY KEY(fest_id, perf_num),
    FOREIGN KEY(band_id) REFERENCES band 
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(fest_id) REFERENCES fest 
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO band (band_name, year_of_foundation)
VALUES
    ('Rammstein', 1994),
    ('Scorpions', 1965),
    ('Queen', 1970),
    ('Oomph!', 1989),
    ('Bon Jovi', 1983),
    ('Ost+Front', 2008),
    ('Avenged Sevenfold', 1999),
    ('Red Hot Chili Peppers', 1983),
    ('UFO', 1968),
    ('Metallica', 1981),
    ('KMFDM', 1984),
    ('System of a Down', 1994),
    ('Kiss', 1973),
    ('Iron Maiden', 1975),
    ('Muse', 1994),
    ('Marilyn Manson', 1989),
    ('Depeche Mode', 1980),
    ('Apocalyptica', 1993),
    ('Arctic Monkeys', 2002),
    ('Joy Division', 1976),
    ('Black Sabbath', 1968);

INSERT INTO genre (genre_name)
VALUES
    ('hard rock'),
    ('indastrial metal'),
    ('heavy metal'),
    ('gothic metal'),
    ('gothic rock'),
    ('glam metal'),
    ('glam rock'),
    ('industrial rock'),
    ('arena rock'),
    ('pop rock'),
    ('NDH'),
    ('EBM'),
    ('alternative metal'),
    ('progressive metal'),
    ('metalcore'),
    ('rap rock'),
    ('rock'),
    ('trash metal'),
    ('indastrial techno'),
    ('shock rock'),
    ('nu metal'),
    ('art rock'),
    ('space rock'),
    ('synth rock'),
    ('dance rock'),
    ('electronic rock'),
    ('electro-industrial'),
    ('symphonic metal'),
    ('indie rock'),
    ('garage rock'),
    ('post-punk'),
    ('blues rock'),
    ('rock and roll'),
    ('funk rock'),
    ('funk metal'),
    ('experimental'),
    ('alternative rock'),
    ('neoclassic metal');

INSERT INTO musician (musician_name, band_id)
VALUES
    ('Till Lindemann', 1),
    ('Richard Kruspe', 1),
    ('Paul Landers', 1),
    ('Oliver Riedel', 1),
    ('Christoph Schneider', 1),
    ('Christian Lorenz', 1),
    ('Rudolf Schenker', 2),
    ('Klaus Meine', 2),
    ('Matthias Jabs', 2),
    ('Paweł Mąciwoda', 2),
    ('Mikkey Dee', 2),
    ('Brian May', 3),
    ('Roger Taylor', 3),
    ('Freddie Mercury', 3),
    ('John Deacon', 3),
    ('Dero Goi', 4),
    ('Crap', 4),
    ('Robert Flux', 4),
    ('Jon Bon Jovi', 5),
    ('David Bryan', 5),
    ('Tico Torres', 5),
    ('Phil X', 5),
    ('Hugh McDonald', 5),
    ('Anthony Kiedis', 8),
    ('Flea', 8),
    ('Chad Smith', 8),
    ('John Frusciante', 8),
    ('James Hetfield', 10),
    ('Lars Ulrich', 10),
    ('Kirk Hammett', 10),
    ('Robert Trujillo', 10);

INSERT INTO place (place_name)
VALUES
    ('Rio de Janeiro, Brazil'),
    ('Lisbon, Portugal'),
    ('Madrid, Spain'),
    ('Las Vegas, United States'),
    ('Santiago de Chile, Chile'),
    ('San Diego, United States'),
    ('London, England'),
    ('Philadelphia, United States'),
    ('Wacken, Germany'),
    ('Nürburg, Germany'),
    ('Nuremberg, Germany'),
    ('New York, United States'),
    ('Sydney, Australia'),
    ('Melbourne, Australia'),
    ('Adelaide, Australia'),
    ('Perth, Australia'),
    ('Gold Coast, Australia'),
    ('Auckland, New Zealand');

INSERT INTO organizer (organizer_name)
VALUES
    ('Roberto Medina'),
    ('Tony Howk'),
    ('Trevor Hoffman'),
    ('Bob Geldof'),
    ('Midge Ure'),
    ('Wacken Foundation'),
    ('Michael Lang'),
    ('John P. Roberts'),
    ('Joel Rosenman'),
    ('Ken West'),
    ('Vivian Lees');

INSERT INTO fest (fest_name, fest_date, place_id)
VALUES
    ('Rock in Rio', '1985-01-11', 1),
    ('Rock in Rio 2', '1991-01-18', 1),
    ('Rock in Rio 3', '2001-01-12', 1),
    ('Rock in Rio 4', '2011-09-23', 1),
    ('Rock in Rio 5', '2013-09-13', 1),
    ('Rock in Rio 6', '2015-09-18', 1),
    ('Rock in Rio 7', '2017-09-15', 1),
    ('Rock in Rio 8', '2019-09-27', 1),
    ('Rock in Rio Lisboa', '2004-05-28', 2),
    ('Rock in Rio Lisboa 2', '2006-05-26', 2),
    ('Rock in Rio Lisboa 3', '2008-05-30', 2),
    ('Rock in Rio Lisboa 4', '2010-05-21', 2),
    ('Rock in Rio Lisboa 5', '2012-05-25', 2),
    ('Rock in Rio Lisboa 6', '2014-05-25', 2),
    ('Rock in Rio Lisboa 7', '2016-05-19', 2),
    ('Rock in Rio Lisboa 8', '2018-06-23', 2),
    ('Rock in Rio Madrid', '2008-06-27', 3),
    ('Rock in Rio Madrid 2', '2010-06-04', 3),
    ('Rock in Rio Madrid 3', '2012-06-30', 3),
    ('Live Aid', '1985-07-31', 7),
    ('Wacken Open Air', '2012-08-04', 9),
    ('Wacken Open Air', '2013-08-01', 9),
    ('Wacken Open Air', '2014-07-31', 9),
    ('Wacken Open Air', '2015-07-30', 9),
    ('Wacken Open Air', '2016-08-04', 9);

INSERT INTO fest_organizer (fest_id, organizer_id)
VALUES
    (1, 1),
    (2, 1),
    (3, 1),
    (4, 1),
    (5, 1),
    (6, 1),
    (7, 1),
    (8, 1),
    (9, 1),
    (10, 1),
    (11, 1),
    (12, 1),
    (13, 1),
    (14, 1),
    (15, 1),
    (16, 1),
    (17, 1),
    (18, 1),
    (19, 1),
    (20, 4),
    (20, 5),
    (21, 6),
    (22, 6),
    (23, 6),
    (24, 6),
    (25, 6);

INSERT INTO performance (band_id, fest_id, perf_num)
VALUES
    (1, 4, 1),
    (5, 4, 2),
    (8, 5, 1),
    (10, 5, 2),
    (8, 5, 3),
    (1, 5, 4),
    (11, 20, 1),
    (4,20, 2),
    (2, 20, 3),
    (1, 21, 1),
    (15, 24, 1),
    (12, 24, 2),
    (15, 17, 1),
    (17, 17, 2),
    (19, 17, 3),
    (8, 17, 4),
    (17, 17, 5),
    (12, 23, 1),
    (14, 23, 2),
    (16, 25, 1),
    (1, 25, 2),
    (1, 25, 3),
    (19, 25, 4),
    (11, 25, 5),
    (12, 25, 6);

INSERT INTO band_genre (band_id, genre_id)
VALUES  
    (1, 1),
    (1, 2),
    (1, 4),
    (1, 11),
    (2, 1),
    (2, 3),
    (2, 6),
    (3, 1),
    (3, 7),
    (3, 10),
    (4, 8),
    (4, 2),
    (4, 11),
    (4, 12),
    (5, 1),
    (5, 6),
    (5, 10),
    (5, 9),
    (6, 2),
    (6, 11),
    (8, 34),
    (8, 35),
    (8, 37),
    (8, 16),
    (10, 3),
    (10, 18),
    (16, 2),
    (16, 8),
    (16, 13),
    (16, 1),
    (16, 20),
    (17, 24),
    (17, 25),
    (17, 26),
    (17, 37),
    (18, 28),
    (18, 3),
    (18, 13),
    (18, 38),
    (20, 5),
    (20, 31);
