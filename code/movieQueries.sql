-- Questions to ask:
-- Does a director's movie gross more later on in their career?
-- Do older movies receive higher or lower ratings than newer movies?
-- Do movies in a certain quarter perform better than others?
-- What country averages the highest revenue?

USE myMovieProject

----- First question -----
-- Does a director's movie gross more later on in their career?
-- Picking directors that have at least 2 movies in the database
SELECT director, COUNT(director) AS numberofmovies
FROM myMovieProject..movies
GROUP BY director
HAVING COUNT(director) > 1
ORDER BY numberofmovies desc

-- Deleting rows that interfere with some queries later. They were null values from the original dataset
DELETE FROM myMovieProject..movies
WHERE releaseDate = 'January 1, 0000'

-- Seeing the difference in gross between the earliest and the latest movie
-- At the same time, creating a view for this for later visualization purposes
CREATE VIEW directorProgress AS
WITH folioCTE (director, earlyDate, lastDate)
AS
(
	SELECT director, MIN(CAST(releaseDate AS date)) AS earlyDate, MAX(CAST(releaseDate AS date)) AS lastDate
	FROM myMovieProject..movies
	GROUP BY director
	HAVING COUNT(director) > 1
),

firstCTE (director, releaseDate, name, gross)
AS
(
	SELECT a.director, a.earlyDate, b.name, b.gross
	FROM folioCTE AS a
	INNER JOIN myMovieProject..movies b
		ON a.director = b.director
	WHERE a.earlyDate = b.releaseDate
),

lastCTE (director,releaseDate,name,gross)
AS
(
	SELECT a.director, a.lastDate, b.name, b.gross
	FROM folioCTE AS a
	INNER JOIN myMovieProject..movies AS b
		ON a.director = b.director
	WHERE a.lastDate = b.releaseDate	
)

SELECT a.director, (b.gross - a.gross) AS grossDifference
FROM firstCTE a
	FULL JOIN lastCTE b
	ON a.director = b.director
