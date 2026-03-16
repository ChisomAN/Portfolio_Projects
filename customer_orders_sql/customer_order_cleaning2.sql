CREATE TABLE `customer_orders_staging2` (
  `order_id` INT,
  `customer_name` text,
  `email` text,
  `order_date` text,
  `product_name` text,
  `quantity` text,
  `price` text,
  `country` text,
  `order_status` text,
  `notes` text,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO customer_orders_staging2
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY LOWER(customer_name), LOWER(email), LOWER(order_status)
) row_num
FROM customer_orders;


SELECT *
FROM customer_orders_staging2;

DELETE 
FROM customer_orders_staging2
WHERE row_num > 1;

UPDATE customer_orders_staging2
SET 
	customer_name = CONCAT(
					(UPPER(LEFT(SUBSTRING_INDEX(customer_name,' ', 1),1))),
					LOWER(SUBSTRING(SUBSTRING_INDEX(customer_name,' ', 1), 2)),
					' ',
					(UPPER(LEFT(SUBSTRING_INDEX(customer_name,' ', -1),1))),
					LOWER(SUBSTRING(SUBSTRING_INDEX(customer_name,' ', -1), 2))
					),
	email = 		REGEXP_REPLACE(email, '@+', '@'),
	order_date = 	CASE
						WHEN order_date REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
						THEN STR_TO_DATE(order_date, '%Y-%m-%d')
						WHEN order_date REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$'
						THEN STR_TO_DATE(order_date, '%m/%d/%Y')
						WHEN order_date REGEXP '^[0-9]{4}/[0-9]{2}/[0-9]{2}$'
						THEN STR_TO_DATE(order_date, '%Y/%m/%d')
						ELSE order_date
					END,
	product_name = 	CASE
						WHEN LOWER(product_name) LIKE '%apple watch%' THEN 'Apple Watch'
						WHEN LOWER(product_name) LIKE '%samsung galaxy s22%' THEN 'Samsung Galaxy S22'
						WHEN LOWER(product_name) LIKE '%google pixel%' THEN 'Google Pixel'
						WHEN LOWER(product_name) LIKE '%iphone 14%' THEN 'iPhone 14'
						WHEN LOWER(product_name) LIKE '%macbook pro%' THEN 'MacBook Pro'
						ELSE product_name
					END,
    quantity = 		CASE
						WHEN LOWER(quantity) = 'two' THEN 2
						ELSE CAST(quantity AS UNSIGNED)
					END,
    price = 		REPLACE(REPLACE(price, '$', ''),',', ''),
    country = 		CASE
						WHEN LOWER(country) LIKE 'us%' OR LOWER(country) LIKE 'united states%' THEN 'United States'
						WHEN LOWER(country) LIKE 'uk%' OR LOWER(country) LIKE 'united kingdom%' THEN 'United Kingdom'
						WHEN LOWER(country) LIKE '%india%' THEN 'India'
						WHEN LOWER(country) LIKE '%spain%' THEN 'Spain'
						WHEN LOWER(country) LIKE '%canada%' THEN 'Canada'
						ELSE NULL
					END,
    order_status = 	CASE
						WHEN LOWER(order_status) LIKE '%deliver%' THEN 'Delivered'
						WHEN LOWER(order_status) LIKE '%ship%' THEN 'Shipped'
						WHEN LOWER(order_status) LIKE '%return%' THEN 'Returned'
						WHEN LOWER(order_status) LIKE '%pend%' THEN 'Pending'
						WHEN LOWER(order_status) LIKE '%refund%' THEN 'Refunded'
						ELSE NULL
					END;


SELECT *
FROM customer_orders_staging2;

ALTER TABLE customer_orders_staging2
MODIFY order_date DATE,
MODIFY quantity INT,
MODIFY price float;


ALTER TABLE customer_orders_staging2
DROP COLUMN notes,
DROP COLUMN row_num;









