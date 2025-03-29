-- Q1) Retrieve the total no.of order places
use pizza_hut;
select count(order_id) as total_orders from orders;

--  Q)2nd Calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM(order_details.quantity * p.price), 2) AS total_sales
FROM
    order_details
        JOIN
    pizza_prices AS p ON p.pizza_id = order_details.pizza_id;
    
-- Q)3 Identify the highest-priced pizza.

SELECT p.price, pt.name AS pizza_name
FROM pizza_prices p
JOIN pizzas_types pt ON p.pizza_type_id = pt.pizza_type_id
ORDER BY p.price DESC
LIMIT 1;


-- Q4) Identify the most common pizza size ordered.
SELECT p.size, COUNT(*) AS order_count
FROM order_details od
JOIN pizza_prices p ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY order_count DESC
LIMIT 1;

-- Q)5  List the top 5 most ordered pizza types along with their quantities.

SELECT pt.name AS pizza_type, SUM(od.quantity) AS total_ordered
FROM order_details od
JOIN pizza_prices p ON od.pizza_id = p.pizza_id
JOIN pizzas_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_ordered DESC
LIMIT 5;





