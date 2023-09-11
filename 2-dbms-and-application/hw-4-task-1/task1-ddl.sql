DROP TABLE IF EXISTS Conference CASCADE;
DROP TABLE IF EXISTS ConferenceEvent CASCADE;
DROP TABLE IF EXISTS Paper CASCADE;

DROP VIEW IF EXISTS HighPaperAcceptance;

-- Серия ежегодных конференций
CREATE TABLE Conference
(
    id   INT PRIMARY KEY,
    name TEXT
);

-- "Событие" -- конференция в конкретном году
CREATE TABLE ConferenceEvent
(
    id               INT PRIMARY KEY,
    conference_id    INT REFERENCES Conference,
    year             INT,
    total_papers     INT,
    accepted_papers  INT,
    acceptance_ratio NUMERIC(3, 2),
    UNIQUE (conference_id, year)
);

ALTER TABLE ConferenceEvent
    DROP COLUMN total_papers;
ALTER TABLE ConferenceEvent
    DROP COLUMN accepted_papers;
ALTER TABLE ConferenceEvent
    DROP COLUMN acceptance_ratio;

CREATE TABLE Paper
(
    id       INT PRIMARY KEY,
    event_id INT REFERENCES ConferenceEvent,
    title    TEXT,
    accepted BOOLEAN
);

INSERT INTO conference VALUES (100, 'KONFA');
INSERT INTO conference VALUES (200, 'SPEAKTALK');

INSERT INTO conferenceevent VALUES (30, 100, 2015);
INSERT INTO conferenceevent VALUES (40, 100, 2017);
INSERT INTO conferenceevent VALUES (50, 200, 2019);

INSERT INTO paper VALUES (1, 30, 'notbaasgfd', True);
INSERT INTO paper VALUES (2, 30, 'notbad', True);
INSERT INTO paper VALUES (3, 40, 'noasfasdf', False);
INSERT INTO paper VALUES (4, 40, 'noaasfsadfassasdf', True);
INSERT INTO paper VALUES (5, 40, 'nassf', False);
INSERT INTO paper VALUES (6, 50, 'nasdsf', False);
INSERT INTO paper VALUES (7, 50, 'nassf', True);
