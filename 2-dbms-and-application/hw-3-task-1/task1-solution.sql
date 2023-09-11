SELECT c.name, s.name, f.start_date
FROM flight f
         LEFT JOIN spacecraft s
                   ON f.spacecraft_id = s.id
         LEFT JOIN commander c
                   ON f.commander_id = c.id
WHERE commander_id = 6;
