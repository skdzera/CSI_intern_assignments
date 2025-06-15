-- 1. Weather Observation Station 8 : Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths
-- https://www.hackerrank.com/challenges/weather-observation-station-8/problem?isFullScreen=true

SELECT CITY FROM STATION 
WHERE LEFT(CITY,1) IN ("a","e","i","o","u") and RIGHT(CITY,1) IN ("a","e","i","o","u");
	

-- 2. Population Density Difernece : Query the difference between the maximum and minimum populations in CITY.
-- https://www.hackerrank.com/challenges/population-density-difference/problem

select (MAX(POPULATION)-MIN(POPULATION)) AS DIFF FROM CITY;


-- 3. Weather Observation Station 19 : Query the Euclidean Distance between points and and format your answer to display decimal digits.
-- https://www.hackerrank.com/challenges/weather-observation-station-19/problem

SELECT ROUND(SQRT(
        POWER(MAX(LAT_N) - MIN(LAT_N), 2) +
        POWER(MAX(LONG_W) - MIN(LONG_W), 2)), 4) 
    AS euclid_dist FROM STATION;


-- 4. Weather Observation Station 20 :Query the median of the Northern Latitudes (LAT_N) from STATION and round your answer to decimal places.
-- https://www.hackerrank.com/challenges/weather-observation-station-20/problem


SELECT ROUND(AVG(LAT_N), 4)
FROM (
    SELECT LAT_N, ROW_NUMBER() OVER(ORDER BY LAT_N) AS rn, COUNT(LAT_N) OVER() AS c
    FROM STATION
) sq
WHERE
    CASE
        WHEN c % 2 = 0 THEN rn = c / 2 OR rn = c / 2 + 1
        ELSE rn = CEIL(c / 2)
    END;



-- 5. African Cities : Query the names of all cities where the CONTINENT is 'Africa'.
-- https://www.hackerrank.com/challenges/african-cities/problem?isFullScreen=true

SELECT C.NAME FROM CITY C 
JOIN COUNTRY CN ON
C.CountryCode = CN.Code 
WHERE CN.CONTINENT = "AFRICA" ;



-- Same Question Repeated in Assignment
-- 6. African Cities : Query the names of all cities where the CONTINENT is 'Africa'.
-- https://www.hackerrank.com/challenges/african-cities/problem?isFullScreen=true

SELECT C.NAME FROM CITY C 
JOIN COUNTRY CN ON
C.CountryCode = CN.Code 
WHERE CN.CONTINENT = "AFRICA" ;

-- 7. Report : Write a SQL Query to create a report
--  https://www.hackerrank.com/challenges/the-report/problem

 SELECT 
  CASE WHEN G.Grade >= 8 THEN S.Name ELSE NULL END AS Name,
  G.Grade,
  S.Marks
FROM Students S
JOIN Grades G ON S.Marks BETWEEN G.Min_Mark AND G.Max_Mark
ORDER BY 
  G.Grade DESC,
  CASE 
    WHEN G.Grade >= 8 THEN S.Name 
    ELSE S.Marks 
  END ASC;
  
-- 8. Top Compettitors : Write SQL Query to find out top competitors

-- https://www.hackerrank.com/challenges/full-score/problem

SELECT t3.hacker_id, t3.name 
FROM (
    SELECT t2.hacker_id, t2.name, COUNT(t2.hacker_id) AS Ind 
    FROM (
        SELECT t1.hacker_id, h.name, t1.Score, t1.Max_Score 
        FROM (
            SELECT t.hacker_id, t.score AS Score, d.score AS Max_Score 
            FROM (
                SELECT S.hacker_id, S.challenge_id, S.score, C.difficulty_level 
                FROM Submissions S 
                LEFT JOIN Challenges C ON S.challenge_id = C.challenge_id
            ) t 
            LEFT JOIN Difficulty d ON t.difficulty_level = d.difficulty_level
        ) t1 
        LEFT JOIN Hackers h ON t1.hacker_id = h.hacker_id
    ) t2 
    WHERE t2.Score = t2.Max_Score 
    GROUP BY t2.hacker_id, t2.name
) t3 
WHERE t3.Ind > 1 
ORDER BY t3.Ind DESC, t3.hacker_id ASC;




--9. Ollivander's Inventory : Question based on Joins
-- https://www.hackerrank.com/challenges/harry-potter-and-wands/problem


SELECT w.id, wp.age, w.coins_needed, w.power
FROM wands w
JOIN wands_property wp ON w.code = wp.code
WHERE wp.is_evil = 0
AND w.coins_needed = (
    SELECT MIN(w2.coins_needed)
    FROM wands w2
    JOIN wands_property wp2 ON w2.code = wp2.code
    WHERE wp2.is_evil = 0
    AND w2.power = w.power
    AND wp2.age = wp.age
)
ORDER BY w.power DESC, wp.age DESC;

3


-- 10. Contest Leaderboard : Question based on joins
-- https://www.hackerrank.com/challenges/contest-leaderboard/problem?isFullScreen=true


SELECT 
    a.hacker_id, 
    b.name, 
    SUM(a.total_score) AS tot
FROM (
    SELECT 
        hacker_id,
        MAX(score) AS total_score
    FROM submissions
    GROUP BY hacker_id, challenge_id
) AS a
JOIN hackers AS b ON a.hacker_id = b.hacker_id
GROUP BY a.hacker_id, b.name
HAVING tot != 0
ORDER BY tot DESC, a.hacker_id;




			









