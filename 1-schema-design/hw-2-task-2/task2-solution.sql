SELECT conference
FROM paper
GROUP BY conference
HAVING COUNT(DISTINCT location) > 1

UNION

SELECT p.conference
FROM paper AS p
         LEFT JOIN conference AS c
                   ON p.conference = c.value
WHERE c.value IS NULL;