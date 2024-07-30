USE restaurant_db;

SELECT * FROM menu_items;

-- write a query to find the number of items on the menu

SELECT COUNT(*) FROM menu_items;

-- What are the least and most expensive items on the menu?

SELECT item_name, MAX(price) as price
FROM menu_items
GROUP BY item_name
ORDER BY price DESC
LIMIT 1;

SELECT item_name, MIN(price) as price
FROM menu_items
GROUP BY item_name
ORDER BY price ASC
LIMIT 1;

-- How many Italian dishes are on the menu?

SELECT COUNT(item_name)
FROM menu_items
WHERE category = "Italian";

-- What are the least and most expensive Italian dishes on the menu?

SELECT *
FROM menu_items
WHERE category = "Italian"
ORDER BY price ASC;

SELECT *
FROM menu_items
WHERE category = "Italian"
ORDER BY price DESC;

-- How many dishes are in each category? 

SELECT category,COUNT(menu_item_id) as num_dishes
FROM menu_items
GROUP BY category;

-- What is the average dish price within each category?

SELECT category,AVG(PRICE) as avg_price
FROM menu_items
GROUP BY category;


-- What is the date range of the order_details table?

SELECT * FROM order_details;

SELECT MIN(order_date) as start_date, MAX(order_date) as last_date
FROM order_details;

-- How many orders were made within this date range?

SELECT COUNT(DISTINCT order_id) as total_orders
FROM order_details;

-- How many items were ordered within this date range?

SELECT COUNT(*)
FROM order_details;

-- Which orders had the most number of items?

SELECT DISTINCT order_id,COUNT(item_id) as items_purchased
FROM order_details
GROUP BY order_id
ORDER BY items_purchased DESC;

-- How many orders had more than 12 items?

SELECT COUNT(*) FROM

(SELECT DISTINCT order_id,COUNT(item_id) as items_purchased
FROM order_details
GROUP BY order_id
HAVING items_purchased > 12) AS num_orders;


-- Combine the menu_items and order_details tables into a single table

SELECT * FROM menu_items;
SELECT * FROM order_details;

SELECT * 
FROM  order_details od
LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id;

-- What were the least and most ordered items?

SELECT item_name, COUNT(order_details_id) as num_purchases 
FROM  order_details od
LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
GROUP BY item_name
ORDER BY num_purchases;

-- What categories were they in?

SELECT item_name, category,COUNT(order_details_id) as num_purchases 
FROM  order_details od
LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
GROUP BY item_name,category
ORDER BY num_purchases;

-- What were the top 5 orders that spent the most money?

SELECT order_id,SUM(price) AS total_spend
FROM  order_details od
LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
GROUP BY order_id
ORDER BY total_spend DESC
LIMIT 5;

-- View the details of the highest spend order. Which specific items were purchased?

SELECT category,COUNT(item_id) as num_items
FROM  order_details od
LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
WHERE order_id = 440
GROUP BY category;

-- View the details of the top 5 highest spend orders

SELECT order_id,category,COUNT(item_id) as num_items
FROM  order_details od
LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
WHERE order_id IN( 440,2075,1957,330,2675)
GROUP BY order_id,category;

-- How much was the most expensive order in the dataset?

SELECT order_id, SUM(price) as total_price
FROM order_details od
LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
GROUP BY order_id
ORDER BY total_price DESC
LIMIT 1;










