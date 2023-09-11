SELECT
    company,
    sum(series)
FROM
    (SELECT
         company,
         (lag(D > Ix, 1, FALSE) OVER (PARTITION BY company ORDER BY week)
             AND lag(D > Ix, 2, FALSE) OVER (PARTITION BY company ORDER BY week)
             AND D > Ix)::INT series
     FROM
         (SELECT
              sq1.company,
              sq1.week,
              sq1.share_price - sq2.share_price D,
              AVG(sq1.share_price - sq2.share_price) OVER (PARTITION BY sq1.week) ix
          FROM
              stockquotes sq1
                  JOIN stockquotes sq2
                       ON sq1.company = sq2.company
                           AND sq1.week - 1 = sq2.week) AS T1) AS T2
GROUP BY company;