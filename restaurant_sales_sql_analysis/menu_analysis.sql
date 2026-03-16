USE restaurant_db;

-- 1. View menu_items table
SELECT *
FROM menu_items;

-- 2. Find # of items on the menu
SELECT COUNT(*)
FROM menu_items;

-- 3. Identify least and most expensive items on the menu
SELECT *
FROM menu_items
ORDER BY price;

SELECT *
FROM menu_items
ORDER BY price DESC;

-- 4. # of italian dishes on the menu
SELECT COUNT(*)
FROM menu_items
WHERE category = 'Italian';

-- 5. Identify least and most expensive italian dishes on the menu
SELECT *
FROM menu_items
WHERE category = 'Italian'
ORDER BY price;

SELECT *
FROM menu_items
WHERE category = 'Italian'
ORDER BY price DESC;

-- 6. # of dishes per category
SELECT category, COUNT(menu_item_id) AS num_dishes
FROM menu_items
GROUP BY category;

-- 7. Average dish price w/in each category
SELECT category, AVG(price) AS avg_price
FROM menu_items
GROUP BY category;


