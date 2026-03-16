USE restaurant_db;

-- 8. View order_details table
SELECT *
FROM order_details;

-- 9. What is the date range of the table?
SELECT MIN(order_date), MAX(order_date)
FROM order_details;

-- 10. # of order w/in this date range?
SELECT COUNT(DISTINCT order_id)
FROM order_details;

-- 11. # of items ordered w/in this date range?
SELECT COUNT(*)
FROM order_details;

-- 12. orders with the most # of items
SELECT order_id, COUNT(item_id) AS num_items
FROM order_details
GROUP BY order_id
ORDER BY COUNT(item_id) DESC;

-- 13. # of orders w more than 12 items
SELECT COUNT(*) FROM

(SELECT order_id, COUNT(item_id) AS num_items
FROM order_details
GROUP BY order_id
HAVING COUNT(item_id) > 12) AS num_orders; 
