-- For all questions, create a view for later visualization purposes
-- Questions to ask:
-- Does a director's movie gross more later on in their career?
-- How does score change over time?
-- Do movies in a certain quarter perform better than others?
-- What country averages the highest revenue?

----- Setup -----
USE myMovieProject

-- Deleting rows that interfere with some queries later. They were null values from the original dataset
DELETE FROM myMovieProject..movies
WHERE releaseDate = 'January 1, 0000'

----- First question -----
-- Does a director's movie gross more later on in their career?
-- Seeing the difference in gross between the earliest and the latest movie
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

----- Second Question -----
-- How does score change over time?
CREATE VIEW scoreByYear AS
SELECT correctYear AS year, AVG(score) AS averageRating
FROM myMovieProject..movies
WHERE correctYear <> 0
GROUP BY correctYear

----- Third Question -----
-- Do movies in a certain quarter perform better than others?
