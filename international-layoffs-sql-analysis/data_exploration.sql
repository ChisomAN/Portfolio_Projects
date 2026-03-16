-- EXPLORATORY DATA ANALYSIS

SELECT *
FROM layoffs1_staging3;

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs1_staging3;

-- Companies that laid off all employees
SELECT *
FROM layoffs1_staging3
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

SELECT *
FROM layoffs1_staging3
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

SELECT *
FROM layoffs1_staging3
ORDER BY total_laid_off DESC;

-- Which companies laid-off the most
SELECT company, SUM(total_laid_off)
FROM layoffs1_staging3
GROUP BY company
ORDER BY 2 DESC;

SELECT MIN(`date`), MAX(`date`)
FROM layoffs1_staging3;

-- Which industry laid-off the most
SELECT industry, SUM(total_laid_off)
FROM layoffs1_staging3
GROUP BY industry
ORDER BY 2 DESC;

-- Which country laid-off the most
SELECT country, SUM(total_laid_off)
FROM layoffs1_staging3
GROUP BY country
ORDER BY 2 DESC;

-- Amount of layoffs/yr
SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs1_staging3
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;

-- companies at which stages laid-off the most
SELECT stage, SUM(total_laid_off)
FROM layoffs1_staging3
GROUP BY stage
ORDER BY 2 DESC;

-- company total employees pre-layoffs
WITH total_pop AS
(
	SELECT company, country, ROUND(total_laid_off/percentage_laid_off) company_population
	FROM layoffs1_staging3
	WHERE total_laid_off IS NOT NULL
	OR percentage_laid_off IS NOT NULL
	GROUP BY company, country, company_population
	HAVING company_population IS NOT NULL
	ORDER BY 3 DESC
)
SELECT 
	company, 
	SUM(company_population) pre_layoff_total
FROM total_pop
GROUP BY company;



-- company total employees post-layoffs
WITH total_pop AS
(
	SELECT company, SUM(ROUND(total_laid_off/percentage_laid_off)) company_population
	FROM layoffs1_staging3
	WHERE (total_laid_off IS NOT NULL
	AND percentage_laid_off IS NOT NULL)
	GROUP BY company
	HAVING company_population IS NOT NULL
)
SELECT tp.company, 
(tp.company_population - total_off.laid_off) post_layoff_pop
FROM total_pop tp
JOIN (SELECT company, SUM(total_laid_off) laid_off
		FROM layoffs1_staging3
		WHERE (total_laid_off IS NOT NULL
			AND percentage_laid_off IS NOT NULL)
		GROUP BY company
		HAVING laid_off IS NOT NULL
) AS total_off
ON tp.company = total_off.company
ORDER BY post_layoff_pop DESC;


-- ranking year-by-year company layoffs
WITH company_year AS 
(
SELECT company, YEAR(`date`) years, SUM(total_laid_off) total_off
FROM layoffs1_staging3
GROUP BY company, years
), 
company_ranking AS
(
SELECT *,
DENSE_RANK() OVER(PARTITION BY years ORDER BY total_off DESC) ranking
FROM company_year
WHERE years IS NOT NULL
)
SELECT *
FROM company_ranking
WHERE ranking <=5 ;






