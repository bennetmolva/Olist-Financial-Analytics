-- Pareto analysis: Sales concentration among top 20% of customers
WITH customer_sales AS (
    SELECT
        c.customer_unique_id,
        SUM(oi.price) AS total_spent
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY 1
),
ranked AS (
    SELECT
        total_spent,
        ROW_NUMBER() OVER (ORDER BY total_spent DESC) AS customer_rank,
        COUNT(*) OVER () AS total_customers
    FROM customer_sales
)
SELECT
    COUNT(*) FILTER (
        WHERE customer_rank <= CEIL(total_customers * 0.20)
    ) AS top_20_pct_customers,
    ROUND(
        100.0 * SUM(total_spent) FILTER (
            WHERE customer_rank <= CEIL(total_customers * 0.20)
        ) / SUM(total_spent), 2
    ) AS top_20_pct_sales_share
FROM ranked;-- Customer segmentation by total spending
-- Thresholds are illustrative, not statistically optimized
WITH customer_spending AS (
    SELECT
        c.customer_unique_id,
        SUM(oi.price) AS total_spent
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
)
SELECT
    CASE
        WHEN total_spent >= 500 THEN 'High Value'
        WHEN total_spent >= 150 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment,
    COUNT(*) AS customers,
    ROUND(SUM(total_spent), 2) AS total_sales,
    ROUND(AVG(total_spent), 2) AS avg_customer_spending
FROM customer_spending
GROUP BY 1
ORDER BY avg_customer_spending DESC;WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS order_count
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY 1
)
SELECT
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (
        WHERE order_count > 1
    ) AS repeat_customers,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE order_count > 1)
        / COUNT(*), 2
    ) AS repeat_customer_pct
FROM customer_orders;-- Top 10 repeat customers by total spending
SELECT
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_unique_id
HAVING COUNT(DISTINCT o.order_id) > 1
ORDER BY total_spent DESC
LIMIT 10;

-- Overall repeat purchase rate
WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS order_count
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
)
SELECT
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (
        WHERE order_count > 1
    ) AS repeat_customers,
    RO-- Top 10 repeat customers by total spending
SELECT
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_unique_id
HAVING COUNT(DISTINCT o.order_id) > 1
ORDER BY total_spent DESC
LIMIT 10;

-- Overall repeat purchase rate
WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS order_count
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
)
SELECT
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (
        WHERE order_count > 1
    ) AS repeat_customers,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE order_count > 1)
        / COUNT(*), 2
    ) AS repeat_customer_pct
FROM customer_orders;        100.0 * COUNT(*) FILTER (WHERE order_count > 1)
        / COUNT(*), 2
