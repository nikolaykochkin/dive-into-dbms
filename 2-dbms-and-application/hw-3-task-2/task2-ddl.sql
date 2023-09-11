DROP TABLE IF EXISTS Planet CASCADE;
DROP TABLE IF EXISTS Commander CASCADE;
DROP TABLE IF EXISTS Flight CASCADE;

CREATE TABLE Planet
(
    id       SERIAL PRIMARY KEY,
    name     TEXT UNIQUE,
    distance NUMERIC(5, 2),
    galaxy   INT CHECK (galaxy > 0)
);

CREATE TABLE Commander
(
    id   SERIAL PRIMARY KEY,
    name TEXT
);

CREATE TABLE Flight
(
    id           INT PRIMARY KEY,
    planet_id    INT REFERENCES Planet,
    commander_id INT REFERENCES Commander,
    start_date   DATE,
    UNIQUE (commander_id, start_date)
);