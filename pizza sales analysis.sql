-- BASIC QUERIES
-- 1. Retrieve the total number of orders placed.
SELECT 
    COUNT(order_id) AS Total_number_of_orders
FROM
    orders;

-- 2. Calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM(o.quantity * p.price), 2) Total_revenue
FROM
    order_details o
        JOIN
    pizzas p ON o.pizza_id = p.pizza_id;

-- 3. Identify the highest-priced pizza.

SELECT 
    pt.name, p.price
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
ORDER BY (p.price) DESC
LIMIT 1;

-- 4. Identify the most common pizza size ordered.

SELECT 
    p.size, COUNT(o.order_details_id) order_count
FROM
    order_details o
        JOIN
    pizzas p ON o.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY COUNT(o.order_details_id) DESC;


-- 5. List the top 5 most ordered pizza types 
-- along with their quantities.

SELECT 
    pt.name, SUM(o.quantity) quantity
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details o ON o.pizza_id = p.pizza_id
GROUP BY pt.name
ORDER BY SUM(o.quantity) DESC
LIMIT 5;


-- INTERMEDIATE QUERIES

-- 1. Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT 
    pt.category, SUM(o.quantity) total_quantity
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details o ON o.pizza_id = p.pizza_id
GROUP BY pt.category
ORDER BY total_quantity DESC;


-- 2. Determine the distribution of orders by hour of the day.

SELECT 
    EXTRACT(HOUR FROM order_time) Hour,
    COUNT(order_id) order_count
FROM
    orders
GROUP BY EXTRACT(HOUR FROM order_time);


-- 3. Join relevant tables to find the category-wise distribution of pizzas.

SELECT 
    category, COUNT(name) pizza_count
FROM
    pizza_types
GROUP BY category;



-- 4. Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT 
    ROUND(AVG(quantity), 0)
FROM
    (SELECT 
        o.order_date, SUM(od.quantity) quantity
    FROM
        orders o
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY o.order_date) order_quantity;



-- 5. Determine the top 3 most ordered pizza types based on revenue.

SELECT 
    pt.name, SUM(o.quantity * p.price) Total_revenue
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details o ON p.pizza_id = o.pizza_id
GROUP BY pt.name
ORDER BY Total_revenue DESC
LIMIT 3;


-- ADVANCE QUERIES


-- 1. Calculate the percentage contribution of each pizza type to total revenue.

SELECT pt.category,
    ROUND(SUM(od.quantity * p.price) / 
    (SELECT ROUND(SUM(od.quantity * p.price), 2) total_sales
                FROM order_details od
				JOIN pizzas p 
                ON od.pizza_id = p.pizza_id) * 100, 2) revenue
FROM pizza_types pt
JOIN pizzas p 
ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details od ON od.pizza_id = p.pizza_id
GROUP BY pt.category
ORDER BY revenue DESC;


-- 2. Analyze the cumulative revenue generated over time.

SELECT order_date, 
SUM(revenue) OVER(ORDER BY order_date) cum_revenue
FROM
	(SELECT o.order_date,
	SUM(od.quantity * p.price) revenue
	FROM order_details od
	JOIN pizzas p
	ON od.pizza_id=p.pizza_id
	JOIN orders o
	ON o.order_id=od.order_id
	GROUP BY o.order_date) Sales;
    

-- 3. Determine the top 3 most ordered pizza types based on revenue for each pizza category.


SELECT name, revenue FROM
	(SELECT category, name, revenue,
	RANK() OVER(PARTITION BY category ORDER BY REVENUE DESC) rn
	FROM
		(SELECT pt.category,pt.name,
		SUM(od.quantity * p.price) revenue
		FROM pizza_types pt
		JOIN pizzas p
		ON pt.pizza_type_id=p.pizza_type_id
		JOIN order_details od
		ON od.pizza_id=p.pizza_id
		GROUP BY pt.category,pt.name) A) B
WHERE rn<=3;