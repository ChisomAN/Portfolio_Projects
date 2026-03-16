# Global Layoffs Data Analysis (COVID-19 Period)

## Project Overview
This project analyzes global company layoffs during the COVID-19 era using SQL. The objective is to clean messy employment data, standardize inconsistent records, and perform exploratory data analysis to identify patterns in layoffs across industries, countries, and company funding stages.

The analysis focuses on answering several key questions:

- Which companies laid off the most employees?
- Which industries were most affected?
- Which countries experienced the largest layoffs?
- How did layoffs change year by year during the pandemic?

This project demonstrates practical SQL techniques used in real-world data analytics workflows including data cleaning, transformation, and exploratory analysis.

---

## Tools & Technologies
- SQL (MySQL)
- Window Functions
- Common Table Expressions (CTEs)
- Data Cleaning Techniques
- Exploratory Data Analysis (EDA)

---

## Dataset
The dataset contains information about layoffs from companies around the world.

Columns included in the dataset:

| Column | Description |
|------|------|
| company | Company name |
| location | City of company headquarters |
| industry | Industry sector |
| total_laid_off | Number of employees laid off |
| percentage_laid_off | Percentage of workforce laid off |
| date | Date of layoff |
| stage | Company funding stage |
| country | Country where layoffs occurred |
| funds_raised_millions | Capital raised by the company |

---

## Key SQL Techniques Demonstrated
- Window Functions (ROW_NUMBER, DENSE_RANK)
- Common Table Expressions (CTEs)
- Data Standardization
- Data Type Conversion
- Self Joins for Missing Data
- Aggregation functions (SUM, MAX, GROUP BY)
- Time based analysis using YEAR()

---

## Key Insights
Some insights that can be extracted from the dataset include:
- Technology companies accounted for a large share of layoffs during the pandemic.
- Some startups laid off 100 percent of their workforce after funding shortages.
- Layoffs varied significantly across countries depending on economic conditions and industry concentration.
- Certain funding stages experienced higher workforce reductions.

---

## Author

Chisom Atulomah
MS Data Science | Data Analytics | SQL | Machine Learning
