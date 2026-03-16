# Movies Data Cleaning & Transformation (SQL)

## Project Overview
This project focuses on cleaning, transforming, and standardizing a messy movie dataset using SQL. The dataset contains inconsistencies such as duplicate records, unstructured text fields, missing values, and mixed data formats.

The objective is to convert raw movie data into a structured, analysis-ready dataset using advanced SQL techniques.

---

## Objectives

- Remove duplicate records
- Standardize column names and formats
- Handle null and missing values
- Clean and normalize text-based columns
- Extract structured features from unstructured data
- Convert data types for analytical use

---

## Tools & Technologies

- SQL (MySQL)
- Window Functions (ROW_NUMBER)
- String Functions (TRIM, REPLACE, SUBSTRING_INDEX)
- Regular Expressions (REGEXP_SUBSTR)
- Data Type Casting
- Data Transformation Techniques

---

## Dataset Description

The dataset contains movie-related information including:

- Title
- Year (raw format)
- Genre
- Rating
- Description
- Cast (directors and stars combined)
- Votes
- Runtime
- Gross revenue

The dataset required extensive cleaning before it could be used for analysis.

---

## Data Cleaning Process

### 1. Remove Duplicates
Duplicates were identified using a window function and removed to ensure data integrity.

### 2. Standardize Column Names
Columns were renamed for consistency and readability.

### 3. Handle Null and Blank Values
Blank strings and placeholder values such as "None" were converted to NULL to ensure proper handling during analysis.

### 4. Clean Text Fields
The movie_cast column contained inconsistent formatting, including line breaks and spacing issues. 
Text was cleaned and standardized for parsing.

### 5. Feature Engineering
- Converted votes to numeric
- Split directors and stars
- Extracted year and content type

### 6. Data Type Conversion
Final columns were converted into appropriate data types

### 7. Remove Unnecessary Columns
Temporary and redundant columns were dropped:
- row_num
- year_raw
- movie_cast
- votes

---

## Key SQL Techniques Demonstrated

- Window Functions (ROW_NUMBER)
- String Manipulation (TRIM, REPLACE)
- Regular Expressions (REGEXP_SUBSTR)
- Feature Engineering in SQL
- Data Type Conversion
- Data Normalization
- Conditional Logic (CASE statements)

---

## Key Outcomes

- Transformed raw movie data into a clean, structured dataset
- Extracted meaningful features from unstructured text
- Improved data quality for downstream analysis
- Enabled accurate filtering, grouping, and aggregation

---

## Author

Chisom Atulomah
MS Data Science | SQL | Data Analytics | Machine Learning
