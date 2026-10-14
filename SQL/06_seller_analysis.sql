-- Top 10 sellers by sales
SELECT
    oi.seller_id,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    COUNT(*) AS items_sold,
    ROUND(SUM(oi.price), 2) AS total_sales,
    ROUND(
        SUM(oi.price) / COUNT(DISTINCT oi.order_id), 2
    ) AS avg_sales_per_order
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY oi.seller_id
ORDER BY total_sales DESC
LIMIT 10;

-- Seller sales concentration
WITH seller_sales AS (
    SELECT
        oi.seller_id,
        SUM(oi.price) AS total_sales
    FROM order_items oi
    JOIN orders o ON oi.order_id = o.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY oi.seller_id
),
ranked AS (
    SELECT
        seller_id,
        total_sales,
        ROW_NUMBER() OVER (
            ORDER BY total_sales DESC
        ) AS seller_rank
    FROM seller_sales
)
SELECT
    ROUND(SUM(total_sales), 2) AS overall_sales,
    ROUND(SUM(total_sales) FILTER (
        WHERE seller_rank <= 10
    ), 2) AS top_10_sales,
    ROUND(
        100.0 * SUM(total_sales) FILTER (
            WHERE seller_rank <= 10
        ) / SUM(total_sales), 2
    ) AS top_10_share_pct
FROM ranked;
