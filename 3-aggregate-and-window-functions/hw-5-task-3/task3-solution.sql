WITH flights AS (SELECT p.name                                           planet,
                        ps.value                                         psystem,
                        SUM(CASE WHEN f.id IS NULL THEN 0 ELSE 1 END) AS flght
                 FROM planet p
                          LEFT JOIN politicalsystem ps ON ps.id = p.psystem_id
                          LEFT JOIN flight f ON p.id = f.planet_id
                 GROUP BY p.name, ps.value)
SELECT planet,
       psystem,
       flght,
       RANK() OVER (PARTITION BY psystem ORDER BY flght DESC) local_rank,
       RANK() OVER (ORDER BY flght DESC )                     global_rank
FROM flights;