-- Monthly sales growth using CTE and window function
WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
        SUM(oi.price) AS sales
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY 1
),
growth AS (
    SELECT
        month,
        sales,
        LAG(sales) OVER (ORDER BY month) AS previous_month_sales
    FROM monthly_sales
)
SELECT
    month,
    ROUND(sales, 2) AS sales,
    ROUND(previous_month_sales, 2) AS previous_month_sales,
    ROUND(
        100.0 * (sales - previous_month_sales)
        / NULLIF(previous_month_sales, 0), 2
    ) AS monthly_growth_pct
FROM growth
ORDER BY month;

