-- Phase 4A – SQL Bucketing

-- Total Spend
WITH total_spend AS (
    SELECT customer_id, SUM(total_amount) AS total_spend
    FROM sales
    GROUP BY customer_id
)

-- 1. Segmentation using CASE
SELECT *,
CASE 
    WHEN total_spend > 10000 THEN 'Gold'
    WHEN total_spend BETWEEN 5000 AND 10000 THEN 'Silver'
    ELSE 'Bronze'
END AS segment
FROM total_spend;

-- 2. Count per segment
SELECT segment, COUNT(*) AS customer_count
FROM (
    SELECT *,
    CASE 
        WHEN total_spend > 10000 THEN 'Gold'
        WHEN total_spend BETWEEN 5000 AND 10000 THEN 'Silver'
        ELSE 'Bronze'
    END AS segment
    FROM total_spend
) t
GROUP BY segment;