-- Check for duplicate orders
SELECT
    COUNT(*) AS total_orders,
    COUNT(DISTINCT order_id) AS unique_orders
FROM orders;

-- Check missing order information
SELECT
    COUNT(*) AS total_orders,
    COUNT(*) FILTER (WHERE order_status IS NULL) AS missing_status,
    COUNT(*) FILTER (WHERE order_purchase_timestamp IS NULL) AS missing_dates,
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS missing_customers
FROM orders;

-- Check unmatched order items
SELECT
    COUNT(*) AS total_items,
    COUNT(*) FILTER (WHERE o.order_id IS NULL) AS unmatched_items
FROM order_items oi
LEFT JOIN orders o
    ON oi.order_id = o.order_id;

