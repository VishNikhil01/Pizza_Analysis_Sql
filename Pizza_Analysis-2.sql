
-- Intermediate Level Questions

-- Q1) Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT pt.category, SUM(od.quantity) AS total_quantity
FROM order_details od
JOIN pizza_prices p ON od.pizza_id = p.pizza_id
JOIN pizzas_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category;

-- Q)2 Determine the distribution of orders by hour of the day.

SELECT HOUR(order_date) AS order_hour, COUNT(*) AS order_count
FROM orders
GROUP BY order_hour
ORDER BY order_hour;

-- Q)3 Join relevant tables to find the category-wise distribution of pizzas.

SELECT pt.category, SUM(od.quantity) AS total_ordered
FROM order_details od
JOIN pizza_prices p ON od.pizza_id = p.pizza_id
JOIN pizzas_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category;

-- Q)4 Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT AVG(daily_total) AS avg_pizzas_per_day
FROM (
  SELECT DATE(o.order_date) AS order_day, SUM(od.quantity) AS daily_total
  FROM orders o
  JOIN order_details od ON o.order_id = od.order_id
  GROUP BY order_day
) AS daily;

-- Q) 5 Determine the top 3 most ordered pizza types based on revenue.

SELECT pt.name AS pizza_type, SUM(p.price * od.quantity) AS revenue
FROM order_details od
JOIN pizza_prices p ON od.pizza_id = p.pizza_id
JOIN pizzas_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY revenue DESC
LIMIT 3;

-- Q)6 



