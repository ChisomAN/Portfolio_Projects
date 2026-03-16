# E-Commerce Funnel Analysis (SQL)

## Project Overview
This project analyzes user behavior across an e-commerce funnel using SQL. The goal is to understand user progression from initial interaction to final purchase, identify drop-off points, and evaluate conversion efficiency.

The analysis includes funnel stage tracking, conversion rate calculation, traffic source performance, user journey timing, and revenue metrics.

---

## Objectives

- Define and analyze key stages in the user conversion funnel
- Calculate conversion rates between funnel stages
- Identify drop-off points in the funnel
- Analyze performance by traffic source
- Measure time taken for users to convert
- Evaluate revenue performance and efficiency

---

## Tools & Technologies

- SQL (MySQL)
- Common Table Expressions (CTEs)
- Aggregations and grouping
- Conditional logic (CASE statements)
- Time-based functions (TIMESTAMPDIFF)
- Data cleaning and type conversion

---

## Dataset Description

The dataset contains user-level event tracking data, including:

- user_id
- event_type (page_view, add_to_cart, checkout_start, payment_info, purchase)
- event_date
- traffic_source
- amount (purchase value)

This dataset simulates user interactions in an e-commerce environment.

---

## Data Preparation

Initial cleaning included converting the `amount` column into a numeric format:

---

## Funnel Stage Analysis

Defined key funnel stages:
- Page View
- Add to Cart
- Checkout Start
- Payment Info
- Purchase

---

## Conversion Rate Analysis

Calculated conversion rates between stages.
Key metrics:
- View → Cart conversion rate
- Cart → Checkout conversion rate
- Checkout → Payment conversion rate
- Payment → Purchase conversion rate
- Overall conversion rate

---

## Funnel by Traffic Source

Analyzed performance by traffic source.
Insights include:
- Which channels drive the most traffic
- Which channels convert best
- Efficiency of marketing sources

---

## Time to Conversion Analysis

Measured how long users take to convert.
Metrics:
- Average time from view → cart
- Cart → purchase
- Total conversion journey time

---

## Revenue Analysis

Evaluated revenue performance across the funnel.
Key metrics:
- Total revenue
- Average order value
- Revenue per buyer
- Revenue per visitor

---

## Key SQL Techniques Demonstrated

- Funnel analysis using conditional aggregation
- CTE-based analytical workflows
- Conversion rate calculations
- Time-based analysis
- Revenue aggregation
- Data cleaning and preparation

---

## Key Insights

- Identified major drop-off points in the checkout process
- Evaluated high-performing traffic sources
- Measured conversion efficiency across funnel stages
- Quantified revenue performance and user value

---

## Author

Chisom Atulomah
MS Data Science | SQL | Data Analytics | Machine Learning
