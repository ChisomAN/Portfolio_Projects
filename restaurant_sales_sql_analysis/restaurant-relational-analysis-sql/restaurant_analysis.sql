-- 14. combine menu and order tables
SELECT * 
FROM order_details od
	LEFT JOIN menu_items mt
    ON mt.menu_item_id = od.item_id;

-- 15. least and most ordered items?
WITH restaurant_log AS (

SELECT * 
FROM order_details od
	LEFT JOIN menu_items mt
    ON mt.menu_item_id = od.item_id

)
SELECT item_name, COUNT(order_details_id) AS num_purchases
FROM restaurant_log
GROUP BY item_name
ORDER BY num_purchases DESC;

-- 16. what categories were those items in?
WITH restaurant_log AS (

SELECT * 
FROM order_details od
	LEFT JOIN menu_items mt
    ON mt.menu_item_id = od.item_id

)
SELECT item_name, category, COUNT(order_details_id) AS num_purchases
FROM restaurant_log
GROUP BY item_name, category
ORDER BY num_purchases;

-- 17. top 5 orders that spent the most money
SELECT order_id, SUM(price) AS total_spend 
FROM order_details od
	LEFT JOIN menu_items mt
    ON mt.menu_item_id = od.item_id
GROUP BY order_id
ORDER BY total_spend DESC
LIMIT 5;

-- 18. details of the highest spend order. insights from the results
SELECT category, COUNT(item_id) AS num_items
FROM order_details od
	LEFT JOIN menu_items mt
    ON mt.menu_item_id = od.item_id
WHERE order_id = 440
GROUP BY category;

-- 19. details from the top 5 highest spend orders. insights from the results
SELECT order_id, category, COUNT(item_id) AS num_items
FROM order_details od
	LEFT JOIN menu_items mt
    ON mt.menu_item_id = od.item_id
WHERE order_id IN (440, 2075, 1957, 330, 2675)
GROUP BY order_id, category;

