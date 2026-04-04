-- Phase 3 – SQL Queries

-- 1. Daily Sales
SELECT sale_date, SUM(total_amount) AS daily_revenue
FROM sales
GROUP BY sale_date;


-- 2. City-wise Revenue
SELECT c.city, SUM(s.total_amount) AS city_revenue
FROM customers c
JOIN sales s 
ON c.customer_id = s.customer_id
GROUP BY c.city;


-- 3. Repeat Customers (> 2 orders)
SELECT customer_id, COUNT(*) AS order_count
FROM sales
GROUP BY customer_id
HAVING COUNT(*) > 2;


-- 4. Highest Spending Customer per City
SELECT *
FROM (
    SELECT c.customer_id, c.city,
           SUM(s.total_amount) AS total_spend,
           ROW_NUMBER() OVER (
               PARTITION BY c.city 
               ORDER BY SUM(s.total_amount) DESC
           ) AS rank
    FROM customers c
    JOIN sales s 
    ON c.customer_id = s.customer_id
    GROUP BY c.customer_id, c.city
) t
WHERE rank = 1;


-- 5. Final Reporting Table
SELECT c.customer_id, c.city,
       SUM(s.total_amount) AS total_spend,
       COUNT(s.sale_id) AS order_count
FROM customers c
JOIN sales s 
ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.city;