-- Questions to ask:
-- Does a director's movie gross more later on in their career?
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
DELETE FROM personalProjects..movies
WHERE releaseDate = 'January 1, 0000'

-- Seeing the earliest and the latest movie
SELECT director, MIN(CAST(releaseDate AS date)) AS earliestMovie, MAX(CAST(releaseDate AS date)) AS latestMovie
FROM personalProjects..movies
GROUP BY director
HAVING COUNT(director) > 1

-- Creating a table to hold this data
-- Will need to create several tables to be able query the data and display it as desired
DROP TABLE IF EXISTS directorFolio
CREATE TABLE directorFolio
(
	director varchar(256),
	earlyDate date,
	lastDate date
)

INSERT INTO directorFolio
SELECT director, MIN(CAST(releaseDate AS date)) AS earlyDate, MAX(CAST(releaseDate AS date)) AS lastDate
FROM personalProjects..movies
GROUP BY director
HAVING COUNT(director) > 1

-- Seeing the earliest movie a director put out
SELECT a.director, a.earlyDate, b.name, b.gross
FROM directorFolio AS a
INNER JOIN personalProjects..movies AS b
	ON a.director = b.director
WHERE a.earlyDate = b.releaseDate
ORDER BY director 

-- Creating a table for this info
DROP TABLE IF EXISTS earlyMovie
CREATE TABLE earlyMovie
(
	director varchar(256),
	releaseDate date,
	name varchar(256),
	gross int
)

INSERT INTO earlyMovie
SELECT b.director, a.releaseDate, a.name, a.gross
FROM personalProjects..movies a
	FULL JOIN personalProjects..directorFolio b
	ON a.director = b.director
	WHERE b.earlyDate = releaseDate

-- Seeing the most recent movie a director put out
SELECT a.director, a.lastDate, b.name, b.gross
FROM directorFolio AS a
INNER JOIN personalProjects..movies AS b
	ON a.director = b.director
WHERE a.lastDate = b.releaseDate
ORDER BY director

-- Creating a table for this info
DROP TABLE IF EXISTS lastMovie
CREATE TABLE lastMovie
(
	director varchar(256),
	releaseDate date,
	name varchar(256),
	gross int
)

INSERT INTO lastMovie
SELECT b.director, a.releaseDate, a.name, a.gross
FROM personalProjects..movies a
	FULL JOIN personalProjects..directorFolio b
	ON a.director = b.director
	WHERE b.lastDate = releaseDate

-- Now to answer the question:
-- Does a director's movie gross more later on in their career?
SELECT a.director, (b.gross - a.gross) AS grossDifference
FROM personalProjects..earlyMovie a
	FULL JOIN personalProjects..lastMovie b
	ON a.director = b.director
ORDER BY grossDifference DESC

-- Now to create a view for later visualization
CREATE VIEW directorGrowth AS
SELECT a.director, (b.gross - a.gross) AS grossDifference
FROM personalProjects..earlyMovie a
	FULL JOIN personalProjects..lastMovie b
	ON a.director = b.director