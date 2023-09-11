-- Название конференции, без года (например 'SIGMOD') и описание
DROP TABLE IF EXISTS Conference;

CREATE TABLE IF NOT EXISTS Conference
(
    name        TEXT PRIMARY KEY,
    description TEXT
);

-- Площадка для проведения конференции, представляющая из себя большое здание.
-- Разные площадки расположены в разных зданиях.
-- У площадки есть имя (например, 'Кремлевский Дворец Съездов'),
-- город, в котором она расположена, страна, и географические координаты с точностью до 5 знаков
-- после запятой, что соответствует единицам метров на местности в средних широтах
DROP TABLE IF EXISTS Venue;

CREATE TABLE IF NOT EXISTS Venue
(
    id      INTEGER PRIMARY KEY,
    name    TEXT,
    city    TEXT,
    country TEXT,
    lat     NUMERIC(7, 5),
    lon     NUMERIC(8, 5),
    CONSTRAINT Venue_unique_lat_lon UNIQUE (lat, lon)
);

-- Статья, принятая на конференцию и опубликованная в трудах конференции
-- Строка в таблице утверждает, что статья с названием title была опубликована в трудах
-- конференции conference, проходившей на площадке venue_id в year году,
-- трудам был присвоен isbn код, и статью следует искать на странице page
DROP TABLE IF EXISTS PaperSubmission;

CREATE TABLE IF NOT EXISTS PaperSubmission
(
    id         INTEGER PRIMARY KEY,
    conference TEXT REFERENCES Conference (name),
    year       INTEGER,
    title      TEXT,
    isbn       TEXT,
    page       INTEGER,
    venue_id   INTEGER REFERENCES Venue (id),
    CONSTRAINT PaperSubmission_unique_conference_year_title UNIQUE (conference, year, title),
    CONSTRAINT PaperSubmission_unique_isbn_page UNIQUE (isbn, page)
);