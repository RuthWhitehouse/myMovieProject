-- Questions to ask:
-- How does a movie from the early career of a director/star/writer gross compared to the most recent?
-- Do older movies receive higher or lower ratings than newer movies?
-- Do movies in a certain quarter perform better than others?
-- What country averages the highest revenue?

----- First question -----
-- Picking directors that have at least 2 movies in the database
SELECT director, COUNT(director) AS numberofmovies
FROM personalProjects..movies
GROUP BY director
HAVING COUNT(director) > 1
ORDER BY numberofmovies desc

-- Deleting rows that interfere with some queries later. They were null values from the original dataset
DELETE FROM movies
WHERE releaseDate = 'January 1, 0000'

-- Seeing the earliest and the latest movie
SELECT director, MIN(CAST(releaseDate AS date)) AS earliestMovie, MAX(CAST(releaseDate AS date)) AS latestMovie
FROM personalProjects..movies
GROUP BY director
HAVING COUNT(director) > 1

-- Creating a table to hold this data
-- CONSIDER CHANGING THIS TO A VIEW?
-- THIS SECTION NEEDS TO CHANGE AS WELL (NEED TO SWITCH TO RELEASE DATE)
DROP TABLE IF EXISTS directorYears
CREATE TABLE directorYears 
(
	director varchar(256),
	earlyYear int,
	lastYear int
)

INSERT INTO directorYears
SELECT director, MIN(correctYear) AS earliestMovie, MAX(correctYear) AS latestMovie
FROM personalProjects..movies
GROUP BY director
HAVING COUNT(director) > 1 AND MIN(correctYear) > 0

-- Because of the results below, I AM GOING TO WANT TO GO BACK AND BASE IT OFF OF THE FULL RELEASE DATE
SELECT a.director, a.earlyYear, b.name
FROM directorYears AS a
INNER JOIN movies AS b
	ON a.director = b.director
WHERE a.director = 'Stanley Kubrick'






----Checking a director's average gross
--SELECT director, ROUND(avg(gross),2) AS averageGross
--FROM personalProjects..movies
--GROUP BY director
--ORDER BY averageGross desc

----Checking a star's average gross
--SELECT star, ROUND(avg(gross),2) AS averageGross
--FROM personalProjects..movies
--GROUP BY star
--ORDER BY averageGross desc