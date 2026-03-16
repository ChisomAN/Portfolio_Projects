# Customer Orders Data Cleaning (SQL)

## Project Overview
This project focuses on cleaning and transforming a messy customer orders dataset using SQL. The dataset contains inconsistent formatting, duplicate records, missing values, and unstructured data.

The objective is to standardize the dataset into a clean, analysis-ready format using SQL-based data cleaning techniques and feature engineering.

---

## Objectives

- Remove duplicate records
- Standardize inconsistent text fields
- Clean and normalize customer names and emails
- Convert mixed-format date fields into a consistent format
- Standardize product names and order statuses
- Convert string-based numeric fields into proper data types
- Prepare dataset for downstream analysis

---

## Tools & Technologies

- SQL (MySQL)
- Window Functions (ROW_NUMBER)
- String Functions (TRIM, CONCAT, REPLACE)
- Regular Expressions (REGEXP, REGEXP_REPLACE)
- Conditional Logic (CASE statements)
- Data Type Conversion

---

## Dataset Description

The dataset contains customer order information including:

- order_id
- customer_name
- email
- order_date
- product_name
- quantity
- price
- country
- order_status
- notes

The dataset required extensive cleaning due to inconsistent formatting and data quality issues.

---

## Data Cleaning Process

### 1. Handle Null and Blank Values
Blank and placeholder values such as "None" were converted to NULL.

### 2. Standardize Order Status
Ensure consistent categorization across records.

### 3. Standardize Product Names
Different variations of product names were mapped to a single standardized value.

### 4. Clean Quantity Field
Handled mixed formats such as text values.

### 5. Clean Customer Names
Names were converted to proper case formatting.

### 6. Remove Duplicate Records
Duplicates were identified and only unique records were retained.

### 7. Standardize Dates
Handled multiple date formats using pattern matching.

### 8. Clean Email Field
Removed invalid email formatting.

### 9. Standardize Country Values
Mapped inconsistent country values to standard names:
- US → United States
- UK → United Kingdom

### 10. Clean Price Field
Converted currency strigs into numeric format.

---

## Final Data Transformation

A full cleaning pipeline was implemented using CTEs to:
- Apply all transformations
- Remove duplicates
- Output a clean dataset

---

## Key SQL Techniques Demonstrated

- Window Functions (ROW_NUMBER)
- String Manipulation (TRIM, CONCAT, REPLACE)
- Regular Expressions (REGEXP, REGEXP_REPLACE)
- Conditional Logic (CASE)
- Data Type Conversion
- Data Standardization
- CTE-based transformation pipelines

---

## Key Outcomes

- Transformed messy transactional data into structured format
- Standardized inconsistent categorical and numeric fields
- Removed duplicates and improved data integrity
- Created a reusable SQL cleaning pipeline

---

## Future Improvements

- Perform exploratory data analysis on cleaned dataset
- Build dashboards using Power BI or Tableau
- Add customer segmentation analysis
- Integrate with a larger analytics pipeline

---

## Dataset

The dataset is hosted externally due to GitHub file size limitations.

[Download Customer Orders Dataset](https://drive.google.com/uc?export=download&id=1v_IzD327P7EQL9lVCKinLtuu1Rfiz-60)

- customer_orders.csv: Raw transactional dataset containing customer details, product information, and order records

---

## Data Accessibility

The dataset exceeds GitHub’s file size limit (100MB), so it is hosted externally.

This reflects real-world workflows where large transactional datasets are stored in cloud systems and accessed for cleaning and analysis.

---

## Author

Chisom Atulomah
MS Data Science | SQL | Data Analytics | Machine Learning
