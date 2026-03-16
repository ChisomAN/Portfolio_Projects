CREATE TABLE `new_movies_staging` (
  `MOVIES` text,
  `YEAR` text,
  `GENRE` text,
  `RATING` text,
  `ONE-LINE` text,
  `STARS` text,
  `VOTES` text,
  `RunTime` text,
  `Gross` text,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM new_movies_staging;

INSERT INTO new_movies_staging
SELECT *,
ROW_NUMBER() OVER
(PARTITION BY MOVIES, `YEAR`, GENRE, RATING, `ONE-LINE`, STARS, VOTES, RunTime, Gross) row_num
FROM movies_staging;

SELECT *
FROM new_movies_staging;

-- REMOVE DUPLICATES

DELETE
FROM new_movies_staging
WHERE row_num > 1;

-- Normalize column title

ALTER TABLE new_movies_staging
CHANGE COLUMN `MOVIES` title TEXT,
CHANGE COLUMN `YEAR` year_raw TEXT,
CHANGE COLUMN `GENRE` genre TEXT,
CHANGE COLUMN `RATING` rating TEXT,
CHANGE COLUMN `ONE-LINE` one_line TEXT,
CHANGE COLUMN `STARS` movie_cast TEXT,
CHANGE COLUMN `VOTES` votes TEXT,
CHANGE COLUMN `RunTime` run_time TEXT,
CHANGE COLUMN `GROSS` gross TEXT;

SELECT *
FROM new_movies_staging;

-- Null and Blank Data

UPDATE new_movies_staging
SET
	title = NULLIF(NULLIF(TRIM(title), ''), 'None'),
	year_raw = NULLIF(NULLIF(TRIM(year_raw), ''), 'None'),
	genre = NULLIF(NULLIF(TRIM(genre), ''), 'None'),
    rating = NULLIF(NULLIF(TRIM(rating), ''), 'None'),
	one_line = NULLIF(NULLIF(TRIM(one_line), ''), 'None'),
	movie_cast = NULLIF(NULLIF(TRIM(movie_cast), ''), 'None'),
	votes = NULLIF(NULLIF(TRIM(votes), ''), 'None'),
    run_time = NULLIF(NULLIF(TRIM(run_time), ''), 'None'),
	gross = NULLIF(NULLIF(TRIM(gross), ''), 'None');

-- Take care of line breaks and non-blank spaces in movie_cast

UPDATE new_movies_staging
SET movie_cast = TRIM(REPLACE(REPLACE(REPLACE(movie_cast, '\r', ' '), '\n', ' '), '\t', ' '));

SELECT *
FROM new_movies_staging;


-- Standardize data

ALTER TABLE new_movies_staging
ADD COLUMN votes_int INT NULL;

UPDATE new_movies_staging
SET votes_int = CAST(REPLACE(votes, ',', '') AS UNSIGNED)
WHERE votes IS NOT NULL;

-- split movie cast into respective cells (stars and directors)

ALTER TABLE new_movies_staging
ADD COLUMN stars TEXT,
ADD COLUMN directors TEXT;

SELECT *
FROM new_movies_staging;

UPDATE new_movies_staging
SET directors = (CASE
					WHEN movie_cast LIKE '%Director%' THEN SUBSTRING_INDEX(movie_cast, '|', 1)
					ELSE NULL
				END),
	stars = (CASE
				WHEN movie_cast LIKE '%Director%' AND movie_cast LIKE '%Star%' THEN TRIM(SUBSTRING_INDEX(movie_cast, '|', -1))
				WHEN movie_cast NOT LIKE '%Director%' THEN movie_cast
				ELSE NULL
			END);
		
UPDATE new_movies_staging
SET 
	movie_cast = TRIM(movie_cast),
    stars = TRIM(stars),
    directors = TRIM(directors);

SELECT *
FROM new_movies_staging;

-- clean year data

SELECT year_raw,
	REGEXP_SUBSTR(year_raw, '[0-9]+') AS start_year,
    REGEXP_SUBSTR(year_raw, '[0-9]+', 1, 2) AS end_year,
    REGEXP_SUBSTR(REGEXP_REPLACE(year_raw, '^\\([IVXLCDM]+\\)\\s*',''),
    '(TV Movie|TV Special|TV Series|TV Mini Series|Mini-Series|Video|Short|TV Short|Movie)',1,1) AS content_type
FROM new_movies_staging;


ALTER TABLE new_movies_staging
ADD COLUMN start_year INT NULL,
ADD COLUMN end_year INT NULL,
ADD COLUMN content_type TEXT;

UPDATE  new_movies_staging
SET
	start_year = REGEXP_SUBSTR(year_raw, '[0-9]+'),
    end_year = REGEXP_SUBSTR(year_raw, '[0-9]+', 1, 2),
    content_type = REGEXP_SUBSTR(REGEXP_REPLACE(year_raw, '^\\([IVXLCDM]+\\)\\s*',''),
					'(TV Movie|TV Special|TV Series|TV Mini Series|Mini-Series|Video|Short|TV Short|Movie)',1,1);

SELECT *
FROM new_movies_staging;

ALTER TABLE new_movies_staging
DROP COLUMN row_num;

ALTER TABLE new_movies_staging
DROP COLUMN year_raw,
DROP COLUMN movie_cast,
DROP COLUMN votes;

SELECT *
FROM new_movies_staging
WHERE rating IS NOT NULL
ORDER BY rating;

-- correct data types

ALTER TABLE new_movies_staging
MODIFY rating float,
MODIFY run_time INT NULL;


SELECT title, start_year, end_year, run_time, votes_int, stars, COUNT(*)
FROM new_movies_staging
GROUP BY title, start_year, end_year, run_time, votes_int, stars
HAVING COUNT(*) > 1;

SELECT *
FROM new_movies_staging;





