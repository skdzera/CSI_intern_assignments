-- 1. https://www.hackerrank.com/challenges/select-all-sql/problem
-- Query all columns (attributes) for every row in the CITY table.

SELECT* FROM CITY;

-- 2. https://www.hackerrank.com/challenges/select-by-id/problem?isFullScreen=true
-- Query all columns for a city in CITY with the ID 1661.

SELECT* FROM CITY
WHERE ID = 1661;

-- 3. https://www.hackerrank.com/challenges/name-of-employees/problem
-- Write a query that prints a list of employee names (i.e.: the name attribute) from the Employee table in alphabetical order.

SELECT name FROM Employee
order by name ASC;

-- 4. https://www.hackerrank.com/challenges/japanese-cities-attributes/problem
-- Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN.

SELECT* FROM CITY
WHERE COUNTRYCODE = 'JPN';


-- 5. https://www.hackerrank.com/challenges/weather-observation-station-1/problem?isFullScreen=true
-- Query a list of CITY and STATE from the STATION table.

SELECT CITY , STATE FROM STATION;

-- 6. https://www.hackerrank.com/challenges/weather-observation-station-3/problem?isFullScreen=true
-- Query a list of CITY names from STATION for cities that have an even ID number. Print the results in any order, but exclude duplicates from the answer.

SELECT DISTINCT CITY 
FROM STATION 
WHERE ID % 2 = 0;

-- 7.  https://www.hackerrank.com/challenges/weather-observation-station-4/problem
-- Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.

SELECT (COUNT(*) - COUNT(DISTINCT CITY)) AS DIFF FROM STATION;

-- 8. https://www.hackerrank.com/challenges/weather-observation-station-5/problem
-- Query the two cities in STATION with the shortest and longest CITY names, 
-- as well as their respective lengths (i.e.: number of characters in the name). If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.


( SELECT CITY, LENGTH(CITY)AS NAME_LENGTH
 FROM STATION
 ORDER BY LENGTH(CITY) ASC,
 CITY ASC LIMIT 1 )
 UNION 
(SELECT CITY, LENGTH(CITY) AS NAME_LENGTH 
 FROM STATION 
 ORDER BY LENGTH(CITY) DESC,
 CITY ASC LIMIT 1 );


-- 9.  https://www.hackerrank.com/challenges/average-population/problem?isFullScreen=true
-- Query the average population for all cities in CITY, rounded down to the nearest integer.

SELECT ROUND(AVG(POPULATION)) FROM CITY;

-- 10. https://www.hackerrank.com/challenges/average-population-of-each-continent/problem
-- Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent) and their respective average city populations (CITY.Population) rounded down to the nearest integer.

SELECT CN.Continent, FLOOR(AVG(C.Population)) AS AvgCityPopulation
FROM COUNTRY AS CN
JOIN CITY AS C ON C.CountryCode = CN.Code
GROUP BY CN.Continent;
















































































