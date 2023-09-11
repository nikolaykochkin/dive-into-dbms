SELECT COUNT(planet_id) + MAX(flts)
FROM (SELECT f.planet_id, COUNT(1) flts
      FROM flight f
               JOIN planet p ON p.id = f.planet_id
      WHERE p.galaxy = 2
      GROUP BY f.planet_id) t;

SELECT *
FROM flight f
         JOIN planet p ON p.id = f.planet_id
WHERE p.galaxy = 2;