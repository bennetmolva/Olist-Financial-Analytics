-- Top 10 product categories by sales
SELECT
    COALESCE(t.product_category_name_english, 'Unknown') AS category,
    COUNT(*) AS items_sold,
    ROUND(SUM(oi.price), 2) AS total_sales
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN products p ON oi.product_id = p.product_id
LEFT JOIN category_translation t
    ON p.product_category_name = t.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY 1
ORDER BY total_sales DESC
LIMIT 10;

-- Category contribution to total delivered sales
SELECT
    COALESCE(t.product_category_name_english, 'Unknown') AS category,
    ROUND(SUM(oi.price), 2) AS sales,
    ROUND(
        100.0 * SUM(oi.price) /
        (SELECT SUM(oi2.price)
         FROM order_items oi2
         JOIN orders o2 ON oi2.order_id = o2.order_id
         WHERE o2.order_status = 'delivered'),
        2
    ) AS revenue_share_pct
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN products p ON oi.product_id = p.product_id
LEFT JOIN category_translation t
    ON p.product_category_name = t.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY 1
ORDER BY sales DESC;

