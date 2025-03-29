-- Advanced Level Questions

-- Q) 1. Calculate the percentage contribution of each pizza type to total revenue

SELECT 
    pt.name AS pizza_type, 
    SUM(p.price * od.quantity) AS revenue,
    (SUM(p.price * od.quantity) / (
        SELECT SUM(p2.price * od2.quantity)
        FROM order_details od2
        JOIN pizza_prices p2 ON od2.pizza_id = p2.pizza_id
    ) * 100) AS percentage_contribution
FROM order_details od
JOIN pizza_prices p ON od.pizza_id = p.pizza_id
JOIN pizzas_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name;


-- Q) 2 Analyze the cumulative revenue generated over time

SELECT 
    DATE(o.order_date) AS order_day,
    SUM(p.price * od.quantity) AS daily_revenue,
    SUM(SUM(p.price * od.quantity)) OVER (ORDER BY DATE(o.order_date)) AS cumulative_revenue
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN pizza_prices p ON od.pizza_id = p.pizza_id
GROUP BY DATE(o.order_date)
ORDER BY order_day;

-- Q) 3. Determine the top 3 most ordered pizza types based on revenue for each

SELECT 
    category,
    pizza_type,
    revenue
FROM (
    SELECT 
        pt.category,
        pt.name AS pizza_type,
        SUM(p.price * od.quantity) AS revenue,
        RANK() OVER (PARTITION BY pt.category ORDER BY SUM(p.price * od.quantity) DESC) AS revenue_rank
    FROM order_details od
    JOIN pizza_prices p ON od.pizza_id = p.pizza_id
    JOIN pizzas_types pt ON p.pizza_type_id = pt.pizza_type_id
    GROUP BY pt.category, pt.name
) sub
WHERE revenue_rank <= 3;


