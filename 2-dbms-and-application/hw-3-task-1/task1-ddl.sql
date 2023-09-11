DROP TABLE IF EXISTS Spacecraft CASCADE;
DROP TABLE IF EXISTS Planet CASCADE;
DROP TABLE IF EXISTS Commander CASCADE;
DROP TABLE IF EXISTS Flight CASCADE;

CREATE TABLE IF NOT EXISTS Spacecraft
(
    id           SERIAL PRIMARY KEY,
    name         TEXT UNIQUE,
    service_life INT DEFAULT 1000,
    birth_year   INT CHECK (birth_year > 0)
);

CREATE TABLE IF NOT EXISTS Planet
(
    id       SERIAL PRIMARY KEY,
    name     TEXT UNIQUE,
    distance NUMERIC(5, 2)
);

CREATE TABLE IF NOT EXISTS Commander
(
    id   SERIAL PRIMARY KEY,
    name TEXT
);

CREATE TABLE IF NOT EXISTS Flight
(
    id            INT PRIMARY KEY,
    spacecraft_id INT REFERENCES Spacecraft,
    planet_id     INT REFERENCES Planet,
    commander_id  INT REFERENCES Commander,
    start_date    DATE,
    UNIQUE (spacecraft_id, start_date),
    UNIQUE (commander_id, start_date)
);
