DROP TABLE IF EXISTS Flight;
DROP TABLE IF EXISTS Planet;
DROP TABLE IF EXISTS PoliticalSystem;

-- Справочник политических строев
CREATE TABLE PoliticalSystem
(
    id    SERIAL PRIMARY KEY,
    value TEXT UNIQUE
);

-- Планета, её название, расстояние до Земли, политический строй
CREATE TABLE Planet
(
    id         SERIAL PRIMARY KEY,
    name       TEXT UNIQUE,
    distance   NUMERIC(5, 2),
    psystem_id INT REFERENCES PoliticalSystem
);

-- Полет на планету в означенную дату
CREATE TABLE Flight
(
    id        INT PRIMARY KEY,
    planet_id INT REFERENCES Planet,
    date      DATE
);

-- Table PoliticalSystem
INSERT INTO PoliticalSystem (id, VALUE)
VALUES (1, 'Anarchy');
INSERT INTO PoliticalSystem (id, VALUE)
VALUES (2, 'Monarchy');
INSERT INTO PoliticalSystem (id, VALUE)
VALUES (3, 'Parliamentary republic');
INSERT INTO PoliticalSystem (id, VALUE)
VALUES (4, 'Democracy');

-- Table Planet
INSERT INTO planet (id, NAME, distance, psystem_id)
VALUES (1, 'Bioflex', 89.08, 1);
INSERT INTO planet (id, NAME, distance, psystem_id)
VALUES (2, 'Goldenflex', 131.70, 2);
INSERT INTO planet (id, NAME, distance, psystem_id)
VALUES (3, 'Opeholding', 90.44, 2);
INSERT INTO planet (id, NAME, distance, psystem_id)
VALUES (4, 'Tanzone', 52.83, 3);
INSERT INTO planet (id, NAME, distance, psystem_id)
VALUES (5, 'Flexplus', 105.87, 3);
INSERT INTO planet (id, NAME, distance, psystem_id)
VALUES (6, 'Volholdings', 5.99, 3);
INSERT INTO planet (id, NAME, distance, psystem_id)
VALUES (7, 'Hotla', 195.26, 4);
INSERT INTO planet (id, NAME, distance, psystem_id)
VALUES (8, 'Trioline', 15.58, 4);
INSERT INTO planet (id, NAME, distance, psystem_id)
VALUES (9, 'Stimex', 164.43, 4);
INSERT INTO planet (id, NAME, distance, psystem_id)
VALUES (10, 'Hotanbam', 126.37, 3);
INSERT INTO planet (id, NAME, distance, psystem_id)
VALUES (11, 'Rancare', 57.87, 1);
INSERT INTO planet (id, NAME, distance, psystem_id)
VALUES (12, 'Doubleice', 131.20, 3);
INSERT INTO planet (id, NAME, distance, psystem_id)
VALUES (13, 'Geocom', 114.40, 4);
INSERT INTO planet (id, NAME, distance, psystem_id)
VALUES (14, 'Techiplus', 164.72, 2);
INSERT INTO planet (id, NAME, distance, psystem_id)
VALUES (15, 'Carehigh', 172.01, 2);
INSERT INTO planet (id, NAME, distance, psystem_id)
VALUES (16, 'Medredfan', 130.84, 3);
INSERT INTO planet (id, NAME, distance, psystem_id)
VALUES (17, 'Dandindox', 13.37, 4);
INSERT INTO planet (id, NAME, distance, psystem_id)
VALUES (18, 'Kanron', 3.10, 3);
INSERT INTO planet (id, NAME, distance, psystem_id)
VALUES (19, 'Tanway', 75.28, 1);
INSERT INTO planet (id, NAME, distance, psystem_id)
VALUES (20, 'Vilakix', 40.57, 4);

-- Table Flight
INSERT INTO flight (id, planet_id, DATE)
VALUES (1, 2, '2047-10-28');
INSERT INTO flight (id, planet_id, DATE)
VALUES (2, 5, '2047-12-16');
INSERT INTO flight (id, planet_id, DATE)
VALUES (3, 13, '2048-02-20');
INSERT INTO flight (id, planet_id, DATE)
VALUES (4, 6, '2048-03-02');
INSERT INTO flight (id, planet_id, DATE)
VALUES (5, 12, '2048-03-20');
INSERT INTO flight (id, planet_id, DATE)
VALUES (6, 9, '2048-03-26');
INSERT INTO flight (id, planet_id, DATE)
VALUES (7, 14, '2048-05-01');
INSERT INTO flight (id, planet_id, DATE)
VALUES (8, 3, '2048-05-22');
INSERT INTO flight (id, planet_id, DATE)
VALUES (9, 6, '2048-05-28');
INSERT INTO flight (id, planet_id, DATE)
VALUES (10, 6, '2048-06-04');
INSERT INTO flight (id, planet_id, DATE)
VALUES (11, 4, '2048-06-17');
INSERT INTO flight (id, planet_id, DATE)
VALUES (12, 2, '2048-08-10');
INSERT INTO flight (id, planet_id, DATE)
VALUES (13, 4, '2048-08-18');
INSERT INTO flight (id, planet_id, DATE)
VALUES (14, 6, '2048-09-03');
INSERT INTO flight (id, planet_id, DATE)
VALUES (15, 5, '2048-10-08');
INSERT INTO flight (id, planet_id, DATE)
VALUES (16, 8, '2048-10-20');
INSERT INTO flight (id, planet_id, DATE)
VALUES (17, 9, '2048-11-23');
INSERT INTO flight (id, planet_id, DATE)
VALUES (18, 7, '2048-12-17');
INSERT INTO flight (id, planet_id, DATE)
VALUES (19, 13, '2048-12-23');
INSERT INTO flight (id, planet_id, DATE)
VALUES (20, 19, '2048-12-28');
INSERT INTO flight (id, planet_id, DATE)
VALUES (21, 3, '2049-02-28');
INSERT INTO flight (id, planet_id, DATE)
VALUES (22, 11, '2049-03-28');
INSERT INTO flight (id, planet_id, DATE)
VALUES (23, 5, '2049-03-29');
INSERT INTO flight (id, planet_id, DATE)
VALUES (24, 1, '2049-04-15');
INSERT INTO flight (id, planet_id, DATE)
VALUES (25, 10, '2049-04-16');
INSERT INTO flight (id, planet_id, DATE)
VALUES (26, 10, '2049-04-16');
INSERT INTO flight (id, planet_id, DATE)
VALUES (27, 15, '2049-04-17');
INSERT INTO flight (id, planet_id, DATE)
VALUES (28, 2, '2049-04-17');
INSERT INTO flight (id, planet_id, DATE)
VALUES (29, 5, '2049-04-18');
INSERT INTO flight (id, planet_id, DATE)
VALUES (30, 10, '2049-04-19');