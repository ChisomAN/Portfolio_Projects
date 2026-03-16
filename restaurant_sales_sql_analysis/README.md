# Restaurant Sales SQL Analysis

## Project Overview
This project analyzes restaurant menu and order data using SQL to uncover insights into customer behavior, menu performance, and revenue trends.

The goal of this project is to demonstrate end-to-end SQL analytics, including data exploration, aggregation, joins, and business-driven insights.

---

## Objectives

- Analyze menu pricing and category distribution
- Understand order volume and customer purchasing behavior
- Identify top-selling and least-selling menu items
- Determine high-value orders and spending patterns
- Generate insights to support menu optimization and revenue growth

---

## Tools & Technologies

- SQL (MySQL)
- Joins (LEFT JOIN)
- Aggregations (COUNT, SUM, AVG)
- Common Table Expressions (CTEs)
- Grouping and filtering

---

## Dataset Description

The project uses two main tables:

### menu_items
Contains information about restaurant menu items:

- menu_item_id
- item_name
- category
- price

### order_details
Contains transactional order data:

- order_id
- order_date
- item_id
- order_details_id

---

## Data Exploration

### Menu Analysis

- Total number of menu items
- Least and most expensive items
- Category distribution
- Average price per category

### Order Analysis
- Date range of orders
- Total number of orders
- Total items sold
- Orders with highest item counts

### Combined Analysis (Business Insights)
- Most and Least ordered items
- Top spending orders
- Category insights from high-spend orders

---

## Key SQL Techniques Demonstrated
- Data aggregation using COUNT, SUM, AVG
- Joining tables for relational analysis
- Use of CTEs for structured queries
- Grouping and filtering for insights
- Ranking and ordering results

---

## Key Insights
- Certain menu categories generate higher revenue despite fewer items
- High-value orders often include multiple categories
- A small subset of items drives the majority of sales
- Pricing varies significantly across categories, impacting demand

---

## Dataset

The dataset is hosted externally due to GitHub file size limits and multi-file structure.

[Access Restaurant Dataset (Google Drive)](https://drive.google.com/drive/folders/110CPWxf95xFXfe4qeTqDlTVImFt6NQCT)

Contents include:

- menu_items.csv: Menu data including item names, categories, and prices
- order_details.csv: Transactional order data
- create_database.sql: SQL script to initialize the database schema

These files are used together to simulate a relational database environment for analysis.

---

## Data Setup Instructions

1. Download all files from the Google Drive folder
2. Run the `create_database.sql` script to initialize the database
3. Import `menu_items.csv` and `order_details.csv` into the database
4. Run the analysis queries provided in this repository

This setup reflects a real-world workflow where structured data is loaded into a relational database before analysis.

---

## Author
Chisom Atulomah
MS Data Science | SQL | Data Analytics | Machine Learning
