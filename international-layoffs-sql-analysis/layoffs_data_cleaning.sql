-- verify row count and correct data types (had to transform from csv to json due to parsing issue) ✅
-- create staging table (never edit or clean on raw data) ✅

-- Remove Duplicates ✅
-- Standardize data ✅
-- Null and blank spaces ✅
	-- '' or 'null' or 'none' spaces turn to null
-- unnecessary columns ✅

SELECT *
FROM layoffs1;

CREATE TABLE layoffs1_staging
LIKE layoffs1;

SELECT *
FROM layoffs1_staging;

INSERT layoffs1_staging
SELECT *
FROM layoffs1;

SELECT *,
ROW_NUMBER() OVER 
(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions)  row_num
FROM layoffs1_staging;

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER 
(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions)  row_num
FROM layoffs1_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

SELECT *
FROM layoffs1_staging
WHERE company = 'Casper';


-- JUMP TO 189 FOR FULL QUERIES
				/*-- create another staging database with extra column (row_num) to delete duplicates

				CREATE TABLE `layoffs1_staging2` (
				  `company` text,
				  `location` text,
				  `industry` text,
				  `total_laid_off` text,
				  `percentage_laid_off` text,
				  `date` text,
				  `stage` text,
				  `country` text,
				  `funds_raised_millions` text,
				  `row_num` INT
				) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

				SELECT *
				FROM layoffs1_staging2
				WHERE row_num >1;

				INSERT INTO Layoffs1_staging2
				SELECT *,
				ROW_NUMBER() OVER 
				(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions)  row_num
				FROM layoffs1_staging;

				DELETE
				FROM layoffs1_staging2
				WHERE row_num >1;

				SELECT *
				FROM layoffs1_staging2;

				-- Standardizing the data

				SELECT company, (TRIM(company))
				FROM layoffs1_staging2;

				UPDATE layoffs1_staging2
				SET company = (TRIM(company));

				SELECT *
				FROM layoffs1_staging2;

				SELECT DISTINCT industry
				FROM layoffs1_staging2
				ORDER BY 1;

				-- update 'none spaces to be able to properly standardize
				UPDATE layoffs1_staging2
				SET
				  company = NULLIF(company, 'None'),
				  location = NULLIF(location, 'None'),
				  industry = NULLIF(industry, 'None'),
				  industry = NULLIF(industry, ''),
				  total_laid_off = NULLIF(total_laid_off, 'None'),
				  percentage_laid_off = NULLIF(percentage_laid_off, 'None'),
				  `date` = NULLIF(date, 'None'),
				  stage = NULLIF(stage, 'None'),
				  country = NULLIF(country, 'None'),
				  funds_raised_millions = NULLIF(funds_raised_millions, 'None');

				SELECT *
				FROM layoffs1_staging2;

				ALTER TABLE layoffs1_staging2
				MODIFY total_laid_off INT;

				ALTER TABLE layoffs1_staging2
				MODIFY percentage_laid_off float;

				ALTER TABLE layoffs1_staging2
				MODIFY funds_raised_millions INT;

				SELECT DISTINCT industry
				FROM layoffs1_staging2
				ORDER BY 1;

				SELECT *
				FROM layoffs1_staging2
				WHERE industry LIKE 'Crypto%';

				UPDATE layoffs1_staging2
				SET industry = 'Crypto'
				WHERE industry LIKE 'Crypto%';

				SELECT DISTINCT country
				FROM layoffs1_staging2
				ORDER BY 1;

				SELECT *
				FROM layoffs1_staging2
				WHERE country LIKE 'United States%';

				SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
				FROM layoffs1_staging2
				ORDER BY 1;

				UPDATE layoffs1_staging2
				SET country = TRIM(TRAILING '.' FROM country)
				WHERE country LIKE 'United States%';

				SELECT *
				FROM layoffs1_staging2;

				-- change data column to date data type
				SELECT `date`,
				STR_TO_DATE (`date`, '%m/%d/%Y')
				FROM layoffs1_staging2;

				UPDATE layoffs1_staging2
				SET `date` = STR_TO_DATE (`date`, '%m/%d/%Y');

				ALTER TABLE layoffs1_staging2
				MODIFY `date` date;

				SELECT *
				FROM layoffs1_staging2
				WHERE total_laid_off IS NULL
				and percentage_laid_off IS NULL;

				SELECT *
				FROM layoffs1_staging2
				WHERE industry IS NULL;

				SELECT *
				FROM layoffs1_staging2
				WHERE company = 'Airbnb';

				SELECT *
				FROM layoffs1_staging2 ls1
				JOIN layoffs1_staging2 ls2
					ON ls1.company = ls2.company
					AND ls1.location = ls2.location
				WHERE ls1.industry IS NULL
				AND ls2.industry IS NOT NULL;

				UPDATE layoffs1_staging2 ls1
				JOIN layoffs1_staging2 ls2
					ON ls1.company = ls2.company
				SET ls1.industry = ls2.industry
				WHERE ls1.industry IS NULL
				AND ls2.industry IS NOT NULL;*/


-- Noticed Error in staging (Altered percentage_laid_off incorrectly) (float != INT when altering/standardizing)
CREATE TABLE `layoffs1_staging3` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` text,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` text,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO Layoffs1_staging3
SELECT *,
ROW_NUMBER() OVER 
(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions)  row_num
FROM layoffs1_staging;

SELECT *
FROM layoffs1_staging3;

DELETE
FROM layoffs1_staging3
WHERE row_num >1;

UPDATE layoffs1_staging3
SET company = (TRIM(company));

UPDATE layoffs1_staging3
SET
  company = NULLIF(company, 'None'),
  location = NULLIF(location, 'None'),
  industry = NULLIF(industry, 'None'),
  industry = NULLIF(industry, ''),
  total_laid_off = NULLIF(total_laid_off, 'None'),
  percentage_laid_off = NULLIF(percentage_laid_off, 'None'),
  `date` = NULLIF(date, 'None'),
  stage = NULLIF(stage, 'None'),
  country = NULLIF(country, 'None'),
  funds_raised_millions = NULLIF(funds_raised_millions, 'None');

ALTER TABLE layoffs1_staging3
MODIFY total_laid_off INT;

ALTER TABLE layoffs1_staging3
MODIFY percentage_laid_off float;

ALTER TABLE layoffs1_staging3
MODIFY funds_raised_millions INT;

UPDATE layoffs1_staging3
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

UPDATE layoffs1_staging3
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

-- change data column to date data type
UPDATE layoffs1_staging3
SET `date` = STR_TO_DATE (`date`, '%m/%d/%Y');

ALTER TABLE layoffs1_staging3
MODIFY `date` date;

SELECT *
FROM layoffs1_staging3;

UPDATE layoffs1_staging3 ls3
JOIN layoffs1_staging3 ls4
	ON ls3.company = ls4.company
SET ls3.industry = ls4.industry
WHERE ls3.industry IS NULL
AND ls4.industry IS NOT NULL;

-- companies that had no layoffs (not necessary for data analysis)
SELECT *
FROM layoffs1_staging3
WHERE total_laid_off IS NULL
and percentage_laid_off IS NULL;

DELETE
FROM layoffs1_staging3
WHERE total_laid_off IS NULL
and percentage_laid_off IS NULL;

SELECT *
FROM layoffs1_staging3;

ALTER TABLE layoffs1_staging3
DROP COLUMN row_num;















