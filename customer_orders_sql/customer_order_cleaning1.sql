USE sql_practice;

SELECT *
FROM customer_orders;

UPDATE customer_orders
SET
	customer_name = NULLIF(NULLIF(TRIM(customer_name), 'None'), ''),
    email = NULLIF(NULLIF(TRIM(email), 'None'), ''),
    product_name = NULLIF(NULLIF(TRIM(product_name), 'None'), ''),
    price = NULLIF(NULLIF(TRIM(price), 'None'), ''),
    notes = NULLIF(NULLIF(TRIM(notes), 'None'), '');

-- 1. standardize the order status column

SELECT order_status,
	CASE
		WHEN LOWER(order_status) LIKE '%deliver%' THEN 'Delivered'
        WHEN LOWER(order_status) LIKE '%ship%' THEN 'Shipped'
        WHEN LOWER(order_status) LIKE '%return%' THEN 'Returned'
        WHEN LOWER(order_status) LIKE '%pend%' THEN 'Pending'
        WHEN LOWER(order_status) LIKE '%refund%' THEN 'Refunded'
        ELSE NULL
	END AS cleaned_order_status
FROM customer_orders;

-- 2. standardize product name

SELECT product_name,
	CASE
		WHEN LOWER(product_name) LIKE '%apple watch%' THEN 'Apple Watch'
        WHEN LOWER(product_name) LIKE '%samsung galaxy s22%' THEN 'Samsung Galaxy S22'
        WHEN LOWER(product_name) LIKE '%google pixel%' THEN 'Google Pixel'
        WHEN LOWER(product_name) LIKE '%iphone 14%' THEN 'iPhone 14'
        WHEN LOWER(product_name) LIKE '%macbook pro%' THEN 'MacBook Pro'
        ELSE NULL
	END AS cleaned_product_name
FROM customer_orders;

-- 3. Clean quantity field

SELECT *,
	CASE
		WHEN LOWER(quantity) = 'two' THEN 2
        ELSE CAST(quantity AS UNSIGNED)
	END AS cleaned_quantity
FROM customer_orders;

-- 4. Clean customer_name field

SELECT customer_name,
	CONCAT(
    (UPPER(LEFT(SUBSTRING_INDEX(customer_name,' ', 1),1))),
	LOWER(SUBSTRING(SUBSTRING_INDEX(customer_name,' ', 1), 2)),
    ' ',
    (UPPER(LEFT(SUBSTRING_INDEX(customer_name,' ', -1),1))),
	LOWER(SUBSTRING(SUBSTRING_INDEX(customer_name,' ', -1), 2))
    ) AS cleaned_customer_name
FROM customer_orders
WHERE customer_name IS NOT NULL;

-- 5. remove duplicate orders

SELECT *
FROM(
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY LOWER(customer_name), LOWER(email), LOWER(product_name)
ORDER BY order_id
) AS row_num
FROM customer_orders) AS rn
WHERE row_num = 1;

-- 6. standardize date

SELECT order_date,
	CASE
    WHEN order_date REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
      THEN STR_TO_DATE(order_date, '%Y-%m-%d')
    WHEN order_date REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$'
      THEN STR_TO_DATE(order_date, '%m/%d/%Y')
    WHEN order_date REGEXP '^[0-9]{4}/[0-9]{2}/[0-9]{2}$'
      THEN STR_TO_DATE(order_date, '%Y/%m/%d')
    ELSE NULL
  END AS cleaned_order_date
FROM customer_orders;

-- 7. clean email

SELECT email,
	REGEXP_REPLACE(email, '@+', '@') AS cleaned_email
FROM customer_orders;


-- 8. standardize country

SELECT country,
	CASE
		WHEN LOWER(country) LIKE 'us%' OR LOWER(country) LIKE 'united states%' THEN 'United States'
        WHEN LOWER(country) LIKE 'uk%' OR LOWER(country) LIKE 'united kingdom%' THEN 'United Kingdom'
        WHEN LOWER(country) LIKE '%india%' THEN 'India'
        WHEN LOWER(country) LIKE '%spain%' THEN 'Spain'
        WHEN LOWER(country) LIKE '%canada%' THEN 'Canada'
        ELSE NULL
	END AS cleaned_country
FROM customer_orders;

-- 9. standardize price

SELECT price,
			REPLACE(
				REPLACE(price, '$', ''),
			',', '') AS cleaned_price
FROM customer_orders;
		


-- finalize cleaning

WITH cleaned_data AS (
SELECT order_id,
	
	-- cleaned customer_name
    CONCAT(
    (UPPER(LEFT(SUBSTRING_INDEX(customer_name,' ', 1),1))),
	LOWER(SUBSTRING(SUBSTRING_INDEX(customer_name,' ', 1), 2)),
    ' ',
    (UPPER(LEFT(SUBSTRING_INDEX(customer_name,' ', -1),1))),
	LOWER(SUBSTRING(SUBSTRING_INDEX(customer_name,' ', -1), 2))
    ) AS cleaned_customer_name,
    
    -- cleaned email
    REGEXP_REPLACE(email, '@+', '@') AS cleaned_email,
    
    -- standardize order_date
    CASE
		WHEN order_date REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
		THEN STR_TO_DATE(order_date, '%Y-%m-%d')
		WHEN order_date REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$'
		THEN STR_TO_DATE(order_date, '%m/%d/%Y')
		WHEN order_date REGEXP '^[0-9]{4}/[0-9]{2}/[0-9]{2}$'
		THEN STR_TO_DATE(order_date, '%Y/%m/%d')
		ELSE NULL
	END AS cleaned_order_date,
    
    -- standardized product_name
    CASE
		WHEN LOWER(product_name) LIKE '%apple watch%' THEN 'Apple Watch'
        WHEN LOWER(product_name) LIKE '%samsung galaxy s22%' THEN 'Samsung Galaxy S22'
        WHEN LOWER(product_name) LIKE '%google pixel%' THEN 'Google Pixel'
        WHEN LOWER(product_name) LIKE '%iphone 14%' THEN 'iPhone 14'
        WHEN LOWER(product_name) LIKE '%macbook pro%' THEN 'MacBook Pro'
        ELSE NULL
	END AS cleaned_product_name,
    
    -- standardized quantity
    CASE
		WHEN LOWER(quantity) = 'two' THEN 2
        ELSE CAST(quantity AS UNSIGNED)
	END AS cleaned_quantity,
    
    -- standardized price
    REPLACE(
				REPLACE(price, '$', ''),
			',', '') AS cleaned_price,
    
    -- standardized country
    CASE
		WHEN LOWER(country) LIKE 'us%' OR LOWER(country) LIKE 'united states%' THEN 'United States'
        WHEN LOWER(country) LIKE 'uk%' OR LOWER(country) LIKE 'united kingdom%' THEN 'United Kingdom'
        WHEN LOWER(country) LIKE '%india%' THEN 'India'
        WHEN LOWER(country) LIKE '%spain%' THEN 'Spain'
        WHEN LOWER(country) LIKE '%canada%' THEN 'Canada'
        ELSE NULL
	END AS cleaned_country,
    
    -- standardized order status
    CASE
		WHEN LOWER(order_status) LIKE '%deliver%' THEN 'Delivered'
        WHEN LOWER(order_status) LIKE '%ship%' THEN 'Shipped'
        WHEN LOWER(order_status) LIKE '%return%' THEN 'Returned'
        WHEN LOWER(order_status) LIKE '%pend%' THEN 'Pending'
        WHEN LOWER(order_status) LIKE '%refund%' THEN 'Refunded'
        ELSE NULL
	END AS cleaned_order_status
FROM customer_orders
WHERE customer_name IS NOT NULL
),

deduplicated_data AS (
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY LOWER(cleaned_email), LOWER(cleaned_product_name)
ORDER BY order_id
) AS row_num
FROM cleaned_data)

SELECT *
FROM deduplicated_data
WHERE row_num = 1;


SELECT *
FROM customer_orders;
    
    
    
    
    
