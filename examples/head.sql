-- head.sql: select the first 10 rows from the imported swimming table
/*SELECT s.year, s.distance, s.stroke, s.athlete, s.rank, ss.athlete, ss.rank FROM swimming s
JOIN swimming ss ON s.year = ss.year 
AND s.distance = ss.distance 
AND s.Stroke = ss.Stroke
WHERE s.athlete = 'Laszlo Cseh' AND ss.athlete = 'Michael Phelps';*/

/*SELECT s.year, s.distance, s.stroke, s.athlete, s.rank, ss.athlete, ss.rank FROM swimming s
JOIN swimming ss ON s.year = ss.year 
AND s.distance = ss.distance 
AND s.Stroke = ss.Stroke
WHERE s.athlete = 'Ryan Lochte' AND ss.athlete = 'Michael Phelps';*/

WITH TopAthletes AS (
    SELECT * FROM swimming
    WHERE Rank != 0
)
SELECT *,  MIN(Rank) as BestRank
FROM TopAthletes
GROUP BY Year, Distance, Stroke, Gender
HAVING MIN(Rank) > 1
-- python .\scripts\run_sql_file.py .\examples\head.sql data\example.db

-- only places with 2 or more distinct years are angeles london tokyo