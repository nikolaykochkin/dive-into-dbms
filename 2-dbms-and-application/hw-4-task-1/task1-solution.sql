-- CREATE VIEW HighPaperAcceptance AS
-- SELECT C.name, CE.year, CE.total_papers, CE.acceptance_ratio
-- FROM ConferenceEvent CE
--          JOIN Conference C ON C.id = CE.conference_id
-- WHERE CE.total_papers > 5
--   AND CE.acceptance_ratio > 0.75;

SELECT C.name,
       CE.year,
       COUNT(P.id)                                                  total_papers,
       (SUM(P.accepted::INT)::NUMERIC / COUNT(P.id))::NUMERIC(3, 2) acceptance_ratio
FROM ConferenceEvent CE
         JOIN Conference C ON C.id = CE.conference_id
         JOIN Paper P ON P.event_id = CE.id
GROUP BY C.name, CE.year
HAVING COUNT(P.id) > 5
   AND SUM(P.accepted::INT)::NUMERIC / COUNT(P.id) > 0.75;
