SET search_path TO commerce, public;

-- INNER JOIN
SELECT o.order_number, c.email, o.total_amount
FROM orders o JOIN customers c USING (customer_id);

-- LEFT JOIN includes customers with no orders.
SELECT c.customer_id, c.email, COUNT(o.order_id) AS order_count
FROM customers c LEFT JOIN orders o USING (customer_id)
GROUP BY c.customer_id, c.email
ORDER BY order_count DESC;

-- HAVING filters groups after aggregation.
SELECT product_id, COUNT(*) AS review_count, AVG(rating)::NUMERIC(3,2) AS avg_rating
FROM reviews WHERE status = 'published'
GROUP BY product_id HAVING COUNT(*) >= 1;

-- Avoid accidental row multiplication: aggregate order items before joining
-- to another one-to-many relation such as payments or shipments.
